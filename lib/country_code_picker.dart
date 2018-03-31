library country_code_picker;

import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/selection_dialog.dart';
import 'package:country_code_picker/celement.dart';

class CountryCodePicker extends StatefulWidget {
  final Function(CElement) onChanged;
  final String initialSelection;

  CountryCodePicker({this.onChanged, this.initialSelection});

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;

    List<CElement> elements = jsonList
        .map((s) => new CElement(
              name: s['name'],
              code: s['code'],
              dial_code: s['dial_code'],
              flag: s['flag'],
            ))
        .toList();
    return new _CountryCodePickerState(elements);
  }
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  CElement selectedItem;
  List<CElement> elements = [];

  _CountryCodePickerState(this.elements);

  @override
  Widget build(BuildContext context) => new GestureDetector(
        child: new Text("${selectedItem.toString()}"),
        onTap: _showSelectionDialog,
      );

  @override
  initState() {
    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
          (e) => e.code.toUpperCase() == widget.initialSelection.toUpperCase(),
          orElse: () => elements[0]);
    }else{
      selectedItem = elements[0];
    }
    super.initState();
  }

  void _showSelectionDialog() {
    showDialog(
      context: context,
      child: new SelectionDialog(elements),
    ).then((e) {
      if (e != null) {
        setState(() {
          selectedItem = e;
        });
        if (widget.onChanged != null) {
          widget.onChanged(e);
        }
      }
    });
  }
}
