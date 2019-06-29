library country_code_picker;

import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:country_code_picker/selection_dialog.dart';
import 'package:flutter/material.dart';

export 'country_code.dart';

class CountryCodePicker extends StatefulWidget {
  final ValueChanged<CountryCode> onChanged;
  final String initialSelection;
  final List<String> favorite;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final bool showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle searchStyle;
  final WidgetBuilder emptySearchBuilder;

  /// shows the name of the country instead of the dialcode
  final bool showOnlyCountryWhenClosed;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widget.
  /// this is especially usefull in combination with [showOnlyCountryWhenClosed],
  /// because longer countrynames are displayed in one line
  final bool alignLeft;

  /// shows the flag
  final bool showFlag;

  CountryCodePicker({
    this.onChanged,
    this.initialSelection,
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.showCountryOnly = false,
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.emptySearchBuilder,
    this.showOnlyCountryWhenClosed = false,
    this.alignLeft = false,
    this.showFlag = true
  });

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;

    List<CountryCode> elements = jsonList
        .map((s) => CountryCode(
              name: s['name'],
              code: s['code'],
              dialCode: s['dial_code'],
              flagUri: 'flags/${s['code'].toLowerCase()}.png',
            ))
        .toList();

    return new _CountryCodePickerState(elements);
  }
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  CountryCode selectedItem;
  List<CountryCode> elements = [];
  List<CountryCode> favoriteElements = [];

  _CountryCodePickerState(this.elements);

  @override
  Widget build(BuildContext context) => FlatButton(
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.showFlag ? Flexible(
              flex: widget.alignLeft ? 0 : 1,
              fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
              child: Padding(
                padding: widget.alignLeft
                    ? const EdgeInsets.only(right: 16.0, left: 8.0)
                    : const EdgeInsets.only(right: 16.0),
                child: Image.asset(
                  selectedItem.flagUri,
                  package: 'country_code_picker',
                  width: 32.0,
                ),
              ),
            ) : Container(),
            Flexible(
              fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
              child: Text(
                widget.showOnlyCountryWhenClosed
                    ? selectedItem.toCountryStringOnly()
                    : selectedItem.toString(),
                style: widget.textStyle ?? Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
        padding: widget.padding,
        onPressed: _showSelectionDialog,
      );

  @override
  initState() {
    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
          (e) =>
              (e.code.toUpperCase() == widget.initialSelection.toUpperCase()) ||
              (e.dialCode == widget.initialSelection.toString()),
          orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    favoriteElements = elements
        .where((e) =>
            widget.favorite.firstWhere(
                (f) => e.code == f.toUpperCase() || e.dialCode == f.toString(),
                orElse: () => null) !=
            null)
        .toList();
    super.initState();
  }

  void _showSelectionDialog() {
    showDialog(
      context: context,
      builder: (_) =>
        SelectionDialog(
          elements,
          favoriteElements,
          showCountryOnly: widget.showCountryOnly,
          emptySearchBuilder: widget.emptySearchBuilder,
          searchDecoration: widget.searchDecoration,
          searchStyle: widget.searchStyle,
          showFlag: widget.showFlag
        ),
    ).then((e) {
      if (e != null) {
        setState(() {
          selectedItem = e;
        });

        _publishSelection(e);
      }
    });
  }

  void _publishSelection(CountryCode e) {
    if (widget.onChanged != null) {
      widget.onChanged(e);
    }
  }
}
