library country_code_picker;

import 'package:collection/collection.dart' show IterableExtension;
import 'package:country_code_picker/widget/bottom_sheet_service/bottom_sheet_service.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:country_code_picker/flag_phone_number_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

export 'country_code.dart';

class FlagPhoneNumber extends StatefulWidget {
  final ValueChanged<CountryCode>? onChanged;
  final ValueChanged<CountryCode?>? onInit;
  final String? initialSelection;
  final List<String> favorite;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final WidgetBuilder? emptySearchBuilder;
  final bool disable;
  final TextOverflow textOverflow;
  final List<String>? countryFilter;
  final bool showOnlyCountryWhenClosed;
  final EdgeInsets margin;
  final bool showFlag;
  final bool hideText;
  final bool showFlagBottomSheet;
  final double flagWidth;
  final Comparator<CountryCode>? comparator;
  final bool hideSearch;
  final Decoration? flagDecoration;
  final String? placeholder;

  FlagPhoneNumber({
    // Custom Button
    this.onChanged,
    this.onInit,
    this.countryFilter,
    this.initialSelection,
    this.comparator,
    this.favorite = const [],
    this.disable = false,
    this.hideText = false,
    this.showFlag = true,
    this.showOnlyCountryWhenClosed = false,  
    this.textOverflow = TextOverflow.ellipsis,
    this.padding = const EdgeInsets.all(8.0),
    this.margin = const EdgeInsets.only(right: 8.0),
    // Custom Flag on Button Sheet
    this.textStyle,
    this.searchStyle,
    this.placeholder,
    this.flagDecoration,
    this.flagWidth = 32.0,
    this.emptySearchBuilder,
    this.hideSearch = false,
    this.showFlagBottomSheet  = true,
    this.searchDecoration = const InputDecoration(),
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;

    List<CountryCode> elements = jsonList
        .map((json) => CountryCode.fromJson(json as Map<String, dynamic>))
        .toList();

    if (comparator != null) {
      elements.sort(comparator);
    }

    if (countryFilter != null && countryFilter!.isNotEmpty) {
      final uppercaseCustomList =
          countryFilter!.map((c) => c.toUpperCase()).toList();
      elements = elements
          .where((c) =>
              uppercaseCustomList.contains(c.code) ||
              uppercaseCustomList.contains(c.name) ||
              uppercaseCustomList.contains(c.dialCode))
          .toList();
    }

    return FlagPhoneNumberState(elements);
  }
}

class FlagPhoneNumberState extends State<FlagPhoneNumber> {
  CountryCode? selectedItem;
  List<CountryCode> elements = [];
  List<CountryCode> favoriteElements = [];
  FlagPhoneNumberState(this.elements);

  @override
  void initState() {
    super.initState();

    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
          (e) =>
              (e.code!.toUpperCase() ==
                  widget.initialSelection!.toUpperCase()) ||
              (e.dialCode == widget.initialSelection) ||
              (e.name!.toUpperCase() == widget.initialSelection!.toUpperCase()),
          orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    favoriteElements = elements
        .where((e) =>
            widget.favorite.firstWhereOrNull((f) =>
                e.code!.toUpperCase() == f.toUpperCase() ||
                e.dialCode == f ||
                e.name!.toUpperCase() == f.toUpperCase()) !=
            null)
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this.elements = elements.map((e) => e.localize(context)).toList();
    _onInit(selectedItem);
  }

  @override
  void didUpdateWidget(FlagPhoneNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
  
    if (oldWidget.initialSelection != widget.initialSelection) {
      if (widget.initialSelection != null) {
        selectedItem = elements.firstWhere(
            (e) =>
                (e.code!.toUpperCase() ==
                    widget.initialSelection!.toUpperCase()) ||
                (e.dialCode == widget.initialSelection) ||
                (e.name!.toUpperCase() ==
                    widget.initialSelection!.toUpperCase()),
            orElse: () => elements[0]);
      } else {
        selectedItem = elements[0];
      }
      _onInit(selectedItem);
    }
  }

  void _onInit(CountryCode? e) {
    if (widget.onInit != null) {
      widget.onInit!(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return Colors.transparent;
          },
        ),
      ),
      child: Padding(
        padding: widget.padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(widget.showFlag)
              Container(
                clipBehavior: widget.flagDecoration == null
                    ? Clip.none
                    : Clip.hardEdge,
                decoration: widget.flagDecoration,
                margin: widget.margin,
                child: Image.asset(
                  selectedItem!.flagUri!,
                  package: 'country_code_picker',
                  width: widget.flagWidth,
                ),
              ),
            if(!widget.hideText) 
              Text(
                widget.showOnlyCountryWhenClosed
                    ? selectedItem!.toCountryStringOnly()
                    : selectedItem.toString(),
                style:
                    widget.textStyle ?? Theme.of(context).textTheme.button,
                overflow: widget.textOverflow,
              ),
          ]
        ),
      ),
      onPressed: widget.disable ? null : () async {
        final countryCode = await BottomSheetService.show(
          context,
          isScrollControlled: true,
          maxWidth: 420,
          builder: FlagPhoneNumberBottomSheet(
            elements: elements,
            flagWidth: widget.flagWidth,
            textStyle: widget.textStyle,
            hideSearch: widget.hideSearch,
            searchStyle: widget.searchStyle,
            placeholder: widget.placeholder,
            favoriteElements: favoriteElements,
            showFlag: widget.showFlagBottomSheet,
            flagDecoration: widget.flagDecoration,
            searchDecoration: widget.searchDecoration,
            emptySearchBuilder: widget.emptySearchBuilder,
          ),
        );

        if(countryCode != null) {
          setState(() {
            selectedItem = countryCode;
          });
          _publishSelection(countryCode);
        }
      },
    );
  }

  void _publishSelection(CountryCode e) {
    if (widget.onChanged != null) {
      widget.onChanged!(e);
    }
  }
}
