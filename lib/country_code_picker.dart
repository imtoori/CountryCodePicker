library country_code_picker;

import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';

class _CElement {
    String name;
    String flag;
    String code;
    String dial_code;

    _CElement({this.name, this.flag, this.code, this.dial_code});
}

class CountryCodePicker extends StatefulWidget {

    @override
    State<StatefulWidget> createState() {
        List<Map> jsonList = codes;

        List<_CElement> elements = jsonList.map((s) =>
        new _CElement(name: s['name'],
            code: s['code'],
            dial_code: s['dial_code'],
            flag: s['flag'],
        )).toList();

        return new _CountryCodePickerState(elements);
    }
}

class _CountryCodePickerState extends State<CountryCodePicker> {
    List<_CElement> elements = [];

    String selectedItem;

    _CountryCodePickerState(this.elements);


    @override
    Widget build(BuildContext context) {
        return new DropdownButton(
                items: elements.map((e) =>
                new DropdownMenuItem<String>(
                    key: new Key(e.code),
                    value: e.dial_code,
                    child: new Text("${e.flag} ${e.dial_code}"),
                )).toList(),
                onChanged: (v) {
                    setState(() {
                        selectedItem = v;
                    });
                });
    }

}
