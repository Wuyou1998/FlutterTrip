package com.wy.plugin.asr;

import android.util.Log;

import io.flutter.plugin.common.MethodChannel;

/* 名称: android.com.wy.plugin.asr.ResultStateful
 * 用户: _VIEW
 * 时间: 2019/8/10,13:09
 * 描述: 处理结果回调
 */
public class ResultStateful implements MethodChannel.Result {
    private static final String TAG = "ResultStateful";
    private MethodChannel.Result result;
    private boolean called = false;

    private ResultStateful(MethodChannel.Result result) {
        this.result = result;
    }

    public static ResultStateful of(MethodChannel.Result result) {
        return new ResultStateful(result);
    }

    @Override
    public void success(Object o) {
        if (called) {
            Log.e(TAG, "result已经调用过了");
            return;
        }
        called = true;
        result.success(o);
    }

    @Override
    public void error(String s, String s1, Object o) {
        if (called) {
            Log.e(TAG, "result已经调用过了");
            return;
        }
        called = true;
        result.error(s, s1, o);
    }

    @Override
    public void notImplemented() {
        if (called) {
            Log.e(TAG, "result已经调用过了");
            return;
        }
        called = true;
        result.notImplemented();
    }
}
