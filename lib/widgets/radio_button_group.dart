import 'package:flutter/material.dart';
import 'grouped_buttons_orientation.dart';

class RadioButtonGroup extends StatefulWidget {
  final List<String> labels;

  final String picked;

  final List<String> disabled;

  final void Function(String label, int index) onChange;

  final void Function(String selected) onSelected;

  final TextStyle labelStyle;

  final GroupedButtonsOrientation orientation;

  final Widget Function(Radio radioButton, Text label, int index) itemBuilder;

  final Color activeColor;

  final EdgeInsetsGeometry padding;

  final EdgeInsetsGeometry margin;

  RadioButtonGroup({
    Key key,
    @required this.labels,
    this.picked,
    this.disabled,
    this.onChange,
    this.onSelected,
    this.labelStyle = const TextStyle(),
    this.activeColor, //defaults to toggleableActiveColor,
    this.orientation = GroupedButtonsOrientation.VERTICAL,
    this.itemBuilder,
    this.padding = const EdgeInsets.all(0.0),
    this.margin = const EdgeInsets.all(0.0),
  }) : super (key: key);

  @override
  _RadioButtonGroupState createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<RadioButtonGroup> {
  String _selected;

  @override
  void initState(){
    super.initState();
    _selected = widget.picked ?? "";
  }


  @override
  Widget build(BuildContext context) {

    _selected = widget.picked ?? _selected;


    List<Widget> content = [];
    for(int i = 0; i < widget.labels.length; i++){

      Radio rb = Radio(
                  activeColor: widget.activeColor ?? Theme.of(context).toggleableActiveColor,
                  groupValue: widget.labels.indexOf(_selected),
                  value: i,

                  onChanged: (widget.disabled != null && widget.disabled.contains(widget.labels.elementAt(i))) ? null :
                    (var index) => setState((){
                      _selected = widget.labels.elementAt(i);

                      if(widget.onChange != null) widget.onChange(widget.labels.elementAt(i), i);
                      if(widget.onSelected != null) widget.onSelected(widget.labels.elementAt(i));
                    }),
                );

      Text t = Text(
        widget.labels.elementAt(i),
        style: (widget.disabled != null && widget.disabled.contains(widget.labels.elementAt(i))) ?
                  widget.labelStyle.apply(color: Theme.of(context).disabledColor) :
                  widget.labelStyle
      );

      if(widget.itemBuilder != null)
        content.add(widget.itemBuilder(rb, t, i));
      else{

        if(widget.orientation == GroupedButtonsOrientation.VERTICAL){

          content.add(Row(children: <Widget>[
            SizedBox(width: 12.0),
            rb,
            SizedBox(width: 12.0),
            t,
          ]));

        }else{

          content.add(Column(children: <Widget>[
            rb,
            SizedBox(width: 12.0),
            t,
            SizedBox(width: 12.0),
          ]));

        }
      }

    }

    return
    Container(
      padding: widget.padding,
      margin: widget.margin,
      child:
      widget.orientation == GroupedButtonsOrientation.HORIZONTAL ? Row(children: content) : Row(children: content),
    );
  }
}