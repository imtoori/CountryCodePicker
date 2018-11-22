import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';

/// selection dialog used for selection of the country code
class SelectionDialog extends StatefulWidget {
  final List<CountryCode> elements;

  /// elements passed as favorite
  final List<CountryCode> favoriteElements;

  SelectionDialog(this.elements, this.favoriteElements);

  @override
  State<StatefulWidget> createState() => new _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  /// this is useful for filtering purpose
  List<CountryCode> showedElements = [];

  @override
  Widget build(BuildContext context) => new SimpleDialog(
      title: new Column(
        children: <Widget>[
          new TextField(
            decoration: new InputDecoration(prefixIcon: new Icon(Icons.search)),
            onChanged: _filterElements,
          ),
        ],
      ),
      children: [
        widget.favoriteElements.isEmpty
            ? new Container()
            : new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[]
                  ..addAll(widget.favoriteElements
                      .map(
                        (f) => new SimpleDialogOption(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Image.asset(
                                        f.flagUri,
                                        package: 'country_code_picker',
                                        width: 32.0,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: new Text(
                                      f.toLongString(),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                _selectItem(f);
                              },
                            ),
                      )
                      .toList())
                  ..add(new Divider())),
      ]..addAll(showedElements
          .map(
            (e) => new SimpleDialogOption(
                  key: Key(e.toLongString()),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Image.asset(
                            e.flagUri,
                            package: 'country_code_picker',
                            width: 32.0,
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          e.toLongString(),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    _selectItem(e);
                  },
                ),
          )
          .toList()));

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
              e.dialCode.contains(s) ||
              e.name.toUpperCase().contains(s))
          .toList();
    });
  }

  void _selectItem(CountryCode e) {
    Navigator.pop(context, e);
  }
}
