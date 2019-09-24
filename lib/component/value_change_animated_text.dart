import 'package:flutter/cupertino.dart';

class ValueChangeAnimatedText extends StatefulWidget {
  final int seconds;
  final double initialValue;
  const ValueChangeAnimatedText({this.initialValue = 0, this.seconds = 1});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ValueChangeAnimatedTextState();
  }
}

class _ValueChangeAnimatedTextState extends State<ValueChangeAnimatedText>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;
  Tween<double> _tween;

  double previousValue=0;
  double currentValue=0;

  @override
  void initState() {
    super.initState();
    previousValue=currentValue=widget.initialValue;
    animationController = AnimationController(
        duration: Duration(seconds: widget.seconds), vsync: this);
    _tween = Tween<double>(begin: 0, end: widget.initialValue);
    animation = _tween.animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    animationController.forward();
  }

  void setValue(double value){
    previousValue=currentValue;
    currentValue=value;
    animationController.reset();
    _tween.begin=previousValue;
    _tween.end=currentValue;
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Text(animation.value.toStringAsFixed(2));
        });
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();

  }
}
