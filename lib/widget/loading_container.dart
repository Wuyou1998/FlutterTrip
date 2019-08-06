import 'package:flutter/material.dart';
//加载进度组件
class LoadingContainer extends StatelessWidget{
  final Widget child;
  final bool isLoading;
  final bool isCover;

  const LoadingContainer(
      {Key key,
      @required this.isLoading,
      this.isCover = false,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isCover
        ? !isLoading ? child : _loadingView
        : Stack(
            children: <Widget>[child, isLoading ? _loadingView : null],
          );
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
