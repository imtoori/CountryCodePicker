library country_code_picker;

import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/selection_dialog.dart';
import 'package:country_code_picker/celement.dart';

class CountryCodePicker extends StatefulWidget {
  final Function(String) onChanged;
  final String initialSelection;
  final List<String> favorite;

  CountryCodePicker({this.onChanged, this.initialSelection, this.favorite});

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;

    List<CElement> elements = jsonList
        .map((s) => new CElement(
              name: s['name'],
              code: s['code'],
              dialCode: s['dial_code'],
              flag: s['flag'],
            ))
        .toList();
    return new _CountryCodePickerState(elements);
  }
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  CElement selectedItem;
  List<CElement> elements = [];
  List<CElement> favoriteElements = [];

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
    } else {
      selectedItem = elements[0];
    }

    favoriteElements = elements
        .where((e) =>
            widget.favorite.firstWhere((f) => e.code == f.toUpperCase(),
                orElse: () => null) !=
            null)
        .toList();
    print(favoriteElements);
    super.initState();
  }

  void _showSelectionDialog() {
    showDialog(
      context: context,
      child: new SelectionDialog(elements, favoriteElements),
    ).then((e) {
      if (e != null) {
        setState(() {
          selectedItem = e;
        });
        if (widget.onChanged != null) {
          widget.onChanged(e.dialCode);
        }
      }
    });
  }
}
