import 'package:flutter/material.dart';

class TabItem extends StatefulWidget {
  TabItem(
  {@required this.selected,
      @required this.iconData,
      @required this.title,
      @required this.callbackFunction});

  String title;
  IconData iconData;
  bool selected;
  Function callbackFunction;

  @override
  _TabItemState createState() => _TabItemState();
}

const double ICON_OFF = -3.0;
const double ICON_ON = 0.0;
const double TEXT_OFF = 3.0;
const double TEXT_ON = 1.0;
const double ALPHA_OFF = 0.0;
const double ALPHA_ON = 1.0;
const int ANIM_DURATION = 300;

class _TabItemState extends State<TabItem> {
  double iconYAlign = ICON_ON;
  double textYAlign = TEXT_OFF;
  double iconAlpha = ALPHA_ON;

  _setIconTextAlpha() {
    setState(() {
      iconYAlign = (widget.selected) ? ICON_OFF : ICON_ON;
      textYAlign = (widget.selected) ? TEXT_ON : TEXT_OFF;
      iconAlpha = (widget.selected) ? ALPHA_OFF : ALPHA_ON;
    });
  }

  @override
  void initState() {
    super.initState();
    _setIconTextAlpha();
  }

  @override
  void didUpdateWidget(TabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setIconTextAlpha();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: Duration(milliseconds: ANIM_DURATION),
              alignment: Alignment(0.0, textYAlign),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: Duration(milliseconds: ANIM_DURATION),
              alignment: Alignment(0.0, textYAlign),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: ANIM_DURATION),
                opacity: iconAlpha,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: const EdgeInsets.all(0.0),
                  alignment: Alignment(0.0, 0.0),
                  icon: Icon(widget.iconData),
                  onPressed: () {
                    widget.callbackFunction();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
