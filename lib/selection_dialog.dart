import 'package:flutter/material.dart';
import 'package:country_code_picker/celement.dart';

class SelectionDialog extends StatefulWidget {
  final List<CElement> elements;

  SelectionDialog(this.elements);

  @override
  State<StatefulWidget> createState() => new _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  List<CElement> showedElements = [];

  @override
  Widget build(BuildContext context) => new SimpleDialog(
      title: new TextField(
        decoration: new InputDecoration(prefixIcon: new Icon(Icons.search)),
        onChanged: _filterElements,
      ),
      children: showedElements
          .map((e) => new SimpleDialogOption(
              child: new Text(e.toLongString()),
              onPressed: () {
                _selectItem(e);
              }))
          .toList());

  @override
  void initState() {
    showedElements = widget.elements;
    super.initState();
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      showedElements = widget.elements
          .where((e) =>
              e.code.contains(s) ||
              e.dial_code.contains(s) ||
              e.name.toUpperCase().contains(s))
          .toList();
    });
  }

  void _selectItem(CElement e) {
    Navigator.pop(context, e);
  }
}
