import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BottomBar extends StatefulWidget {
  BottomBar({this.cardCount, this.scrollPercent});
  final int cardCount;
  final double scrollPercent;

  @override
  State<StatefulWidget> createState() => _BottomBarState();

}

class _BottomBarState extends State<BottomBar> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Container(
            margin: const EdgeInsets.only(left: 15.0,right: 15.0),
            width: double.infinity,
            height: 5.0,
            child: ScrollIndicator(
                cardCount: widget.cardCount,
                scrollPercent: widget.scrollPercent
            ),
          )),
        ],
      ),
    );
  }
}

class ScrollIndicator extends StatelessWidget {
  ScrollIndicator({this.cardCount, this.scrollPercent});
  final int cardCount;
  final double scrollPercent;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScrollIndicatorPainter(
          cardCount: cardCount,
          scrollPercent: scrollPercent
      ),
      child: Container(),
    );
  }

}

class ScrollIndicatorPainter extends CustomPainter {
  ScrollIndicatorPainter({
    this.cardCount, this.scrollPercent
  }) : trackPaint = Paint()
    ..color = Color(0xFF444444)
    ..style = PaintingStyle.fill,
        thumbPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

  final int cardCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        topLeft: Radius.circular(3.0),
        topRight: Radius.circular(3.0),
        bottomLeft: Radius.circular(3.0),
        bottomRight: Radius.circular(3.0),
      ),
      trackPaint,
    );

    final thumbWidth = size.width / cardCount;
    final thumbLeft = scrollPercent * size.width;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(thumbLeft, 0.0, thumbWidth, size.height),
        topLeft: Radius.circular(3.0),
        topRight: Radius.circular(3.0),
        bottomLeft: Radius.circular(3.0),
        bottomRight: Radius.circular(3.0),
      ),
      thumbPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
