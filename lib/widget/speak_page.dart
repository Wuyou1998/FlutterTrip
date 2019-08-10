import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:xiecheng_demo/page/search_page.dart';
import 'package:xiecheng_demo/plugin/asr_manager.dart';

const double MIC_SIZE = 80;

//语音识别页面
class SpeakPage extends StatefulWidget {
  @override
  _SpeakPageState createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage>
    with SingleTickerProviderStateMixin {
  String _speakTips = '长按说话';
  String _speakResult = '';
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[_topItem(), _bottomItem()],
          ),
        ),
      ),
    );
  }

  _topItem() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Text(
            '你可以这样说',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
        Text('故宫门票\n北京一日游\n迪士尼乐园',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey)),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            _speakResult,
            style: TextStyle(color: Colors.blueAccent),
          ),
        )
      ],
    );
  }

  _bottomItem() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (e) {
              _speakStart();
            },
            onTapUp: (e) {
              _speakStop();
            },
            onTapCancel: () {
              _speakCancel();
            },
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      _speakTips,
                      style: TextStyle(color: Colors.blueAccent, fontSize: 12),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        //宽高写死防止动画执行过程父布局宽高变化
                        height: MIC_SIZE,
                        width: MIC_SIZE,
                        child: Center(
                          child: AnimatedMic(
                            animation: _animation,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: 0,
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.grey,
                ),
              ))
        ],
      ),
    );
  }

  void _speakStart() {
    _controller.forward();
    setState(() {
      _speakTips = '- 识别中 -';
    });
    AsrManager.start().then((text) {
      if (text != null && text.length > 0) {
        setState(() {
          _speakResult = text;
        });
        print('----------语音识别成功，其内容是：$text-----------');
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchPage(
                      keyWord: _speakResult,
                    )));
      }
    }).catchError((e){
      print('----------语音识别出错：$e-----------');
    });
  }

  void _speakStop() {
    setState(() {
      _speakTips = '长按说话';
    });
    _controller.reset();
    _controller.stop();
    AsrManager.stop();
  }

  void _speakCancel() {
    setState(() {
      _speakTips = '长按说话';
    });
    _controller.reset();
    _controller.stop();
    AsrManager.cancel();
  }
}

class AnimatedMic extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 1, end: 0.5);
  static final _sizeTween = Tween<double>(begin: MIC_SIZE, end: MIC_SIZE - 20);

  AnimatedMic({Animation<double> animation}) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(MIC_SIZE / 2)),
        child: Icon(
          Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
