import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';

/// selection dialog used for selection of the country code
class SelectionDialog extends StatefulWidget {
  final List<CountryCode> elements;
  final bool? showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final TextStyle? textStyle;
  final BoxDecoration? boxDecoration;
  final WidgetBuilder? emptySearchBuilder;
  final bool? showFlag;
  final double flagWidth;
  final Decoration? flagDecoration;
  final Size? size;
  final bool hideSearch;
  final Icon? closeIcon;

  /// Background color of SelectionDialog
  final Color? backgroundColor;

  /// Boxshaow color of SelectionDialog that matches CountryCodePicker barrier color
  final Color? barrierColor;

  /// elements passed as favorite
  final List<CountryCode> favoriteElements;

  SelectionDialog(
    this.elements,
    this.favoriteElements, {
    Key? key,
    this.showCountryOnly,
    this.emptySearchBuilder,
    InputDecoration searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.textStyle,
    this.boxDecoration,
    this.showFlag,
    this.flagDecoration,
    this.flagWidth = 32,
    this.size,
    this.backgroundColor,
    this.barrierColor,
    this.hideSearch = false,
    this.closeIcon,
  })  : this.searchDecoration = searchDecoration.prefixIcon == null
            ? searchDecoration.copyWith(prefixIcon: Icon(Icons.search))
            : searchDecoration,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  /// this is useful for filtering purpose
  late List<CountryCode> filteredElements;

  int get _itemCount =>
      (widget.favoriteElements.length > 0 ? 1 : 0) + filteredElements.length;

  bool get _displayFavoriteElements => widget.favoriteElements.length > 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: widget.size?.width ?? MediaQuery.of(context).size.width,
      height: widget.size?.height ?? MediaQuery.of(context).size.height * 0.85,
      decoration: widget.boxDecoration ??
          BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                color: widget.barrierColor ?? Colors.grey.withOpacity(1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              )
            ],
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            iconSize: 20,
            icon: widget.closeIcon!,
            onPressed: () => Navigator.pop(context),
          ),
          if (!widget.hideSearch)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                style: widget.searchStyle,
                decoration: widget.searchDecoration,
                onChanged: _filterElements,
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _itemCount,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  if (_displayFavoriteElements ||
                      filteredElements.length == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_displayFavoriteElements) ...[
                          ...widget.favoriteElements.map(
                            (favoriteItem) => SimpleDialogOption(
                              child: _buildOption(favoriteItem),
                              onPressed: () => _selectItem(favoriteItem),
                            ),
                          ),
                          const Divider(),
                        ],
                        if (filteredElements.length == 0)
                          _buildEmptySearchWidget(context)
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }
                final filteredItem = filteredElements[index - 1];
                return SimpleDialogOption(
                  child: _buildOption(filteredItem),
                  onPressed: () => _selectItem(filteredItem),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(CountryCode e) {
    return Container(
      width: 400,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          if (widget.showFlag!)
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(right: 16.0),
                decoration: widget.flagDecoration,
                clipBehavior:
                    widget.flagDecoration == null ? Clip.none : Clip.hardEdge,
                child: Image.asset(
                  e.flagUri!,
                  package: 'country_code_picker',
                  width: widget.flagWidth,
                ),
              ),
            ),
          Expanded(
            flex: 4,
            child: Text(
              widget.showCountryOnly!
                  ? e.toCountryStringOnly()
                  : e.toLongString(),
              overflow: TextOverflow.fade,
              style: widget.textStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchWidget(BuildContext context) {
    if (widget.emptySearchBuilder != null) {
      return widget.emptySearchBuilder!(context);
    }

    return Center(
      child: Text(CountryLocalizations.of(context)?.translate('no_country') ??
          'No country found'),
    );
  }

  @override
  void initState() {
    filteredElements = widget.elements;
    super.initState();
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      filteredElements = widget.elements
          .where((e) =>
              e.code!.contains(s) ||
              e.dialCode!.contains(s) ||
              e.name!.toUpperCase().contains(s))
          .toList();
    });
  }

  void _selectItem(CountryCode e) => Navigator.pop(context, e);
}
