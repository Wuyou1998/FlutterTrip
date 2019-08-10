package com.wy.plugin.asr;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.util.Log;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.util.ArrayList;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/* 名称: android.com.wy.plugin.asr.AsrPlugin
 * 用户: _VIEW
 * 时间: 2019/8/9,23:53
 * 描述: dart代码调用Java代码中间件，methodChannel
 */
public class AsrPlugin implements MethodChannel.MethodCallHandler {
    private static final String TAG = "AsrPlugin";
    private final Activity activity;
    private ResultStateful resultStateful;
    private AsrManager asrManager;
    private OnAsrListener onAsrListener = new OnAsrListener() {
        @Override
        public void onAsrReady() {

        }

        @Override
        public void onAsrBegin() {

        }

        @Override
        public void onAsrEnd() {

        }

        @Override
        public void onAsrPartialResult(String[] results, RecogResult recogResult) {

        }

        @Override
        public void onAsrOnlineNluResult(String nluResult) {

        }

        @Override
        public void onAsrFinalResult(String[] results, RecogResult recogResult) {
            if (resultStateful != null) {
                resultStateful.success(results[0]);
            }
        }

        @Override
        public void onAsrFinish(RecogResult recogResult) {

        }

        @Override
        public void onAsrFinishError(int errorCode, int subErrorCode, String descMessage, RecogResult recogResult) {
            if (resultStateful != null) {
                resultStateful.error(descMessage, null, null);
            }
        }

        @Override
        public void onAsrLongFinish() {

        }

        @Override
        public void onAsrVolume(int volumePercent, int volume) {

        }

        @Override
        public void onAsrAudio(byte[] data, int offset, int length) {

        }

        @Override
        public void onAsrExit() {

        }

        @Override
        public void onOfflineLoaded() {

        }

        @Override
        public void onOfflineUnLoaded() {

        }
    };

    private AsrPlugin(PluginRegistry.Registrar registrar) {
        activity = registrar.activity();
        initPermission();
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        MethodChannel channel = new MethodChannel(registrar.messenger(), "asr_plugin");
        AsrPlugin instance = new AsrPlugin(registrar);
        channel.setMethodCallHandler(instance);
    }


    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch (methodCall.method) {
            case "start":
                resultStateful = ResultStateful.of(result);
                start(methodCall, resultStateful);
                break;
            case "stop":
                stop(methodCall, resultStateful);
                break;
            case "cancel":
                cancel(methodCall, resultStateful);
                break;

            default:
                result.notImplemented();
        }
    }

    private void start(MethodCall methodCall, ResultStateful resultStateful) {
        if (activity == null) {
            Log.e(TAG, "Ignored start, current activity is empty");
            resultStateful.error("Ignored start, current activity is empty", null, null);
            return;
        }
        if (getAsrManager() != null) {
            getAsrManager().start(methodCall.arguments instanceof Map ? (Map) methodCall.arguments : null);
        } else {
            Log.e(TAG, "Ignored start,current AsrManager is null");
            resultStateful.error("Ignored start,current AsrManager is null", null, null);
        }
    }

    private void stop(MethodCall methodCall, ResultStateful resultStateful) {
        if (asrManager != null) {
            asrManager.stop();
            Log.e(TAG, "停止识别");
        }
    }

    private void cancel(MethodCall methodCall, ResultStateful resultStateful) {
        if (asrManager != null) {
            asrManager.cancel();
            Log.e(TAG, "取消识别");
        }
    }


    private AsrManager getAsrManager() {
        if (asrManager == null) {
            if (activity != null && !activity.isFinishing()) {
                asrManager = AsrManager.getInstance(activity, onAsrListener);
            }
        }
        return asrManager;
    }

    private void initPermission() {
        String permissions[] = {Manifest.permission.RECORD_AUDIO,
                Manifest.permission.ACCESS_NETWORK_STATE,
                Manifest.permission.INTERNET,
                Manifest.permission.READ_PHONE_STATE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
        };

        ArrayList<String> toApplyList = new ArrayList<String>();

        for (String perm : permissions) {
            if (PackageManager.PERMISSION_GRANTED != ContextCompat.checkSelfPermission(activity, perm)) {
                toApplyList.add(perm);
                //进入到这里代表没有权限.

            }
        }
        String tmpList[] = new String[toApplyList.size()];
        if (!toApplyList.isEmpty()) {
            ActivityCompat.requestPermissions(activity, toApplyList.toArray(tmpList), 123);
        }

    }

}
