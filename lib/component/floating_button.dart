import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  final List<FloatingButtonItem> floatingButtonItems;

  FloatingButton(
      {this.onPressed, this.tooltip, @required this.icon, this.floatingButtonItems});

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

///floating button item
class FloatingButtonItem {
  final Widget icon;
  final String desc;
  final VoidCallback onPressed;

  const FloatingButtonItem(
      {@required this.icon, @required this.desc, @required this.onPressed});
}

class _FloatingButtonState extends State<FloatingButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  bool showItems;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }


 _onMainButtonPressed(){
    if(showItems){
      if (!isOpened) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      isOpened = !isOpened;
    }else{

    }
    widget.onPressed();
 }

  List<Widget> _buildFloatingButtonItem() {
    var ret = <Widget>[];
    showItems=false;
    if (widget.floatingButtonItems != null) {
      showItems=true;
      var index = widget.floatingButtonItems.length+1;
      ret.addAll(widget.floatingButtonItems.map((p) {
        index--;
        return Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * (index),
            0.0,
          ),
          child: Container(
            child: FloatingActionButton(
              onPressed: p.onPressed,
              tooltip: p.desc,
              child: p.icon,
            ),
          ),
        );
      }));
    }
    ret.add(toggle(showItems));
    return ret;
  }

  Widget toggle(bool showItems) {
    if(showItems){
      return Container(
        child: FloatingActionButton(
          backgroundColor: _buttonColor.value,
          onPressed: _onMainButtonPressed,
          tooltip: widget.tooltip,
          child: AnimatedIcon(
            // todo how to animate widget.icon to close icon
            icon: AnimatedIcons.menu_close,
            progress: _animateIcon,
          ),
        ),
      );
    }else{
      return Container(
          child:FloatingActionButton(
            backgroundColor: Colors.blue,
            tooltip: widget.tooltip,
            onPressed: _onMainButtonPressed,
            child: Icon(widget.icon),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _buildFloatingButtonItem());
  }
}
