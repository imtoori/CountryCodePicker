
import 'package:country_code_picker/widget/bottom_sheet_service/bottom_sheet_component.dart';
import 'package:country_code_picker/widget/bottom_sheet_service/bottom_sheet_service.dart';
import 'package:flutter/material.dart';

class FlagPhoneNumberBottomSheet extends StatefulWidget {
  FlagPhoneNumberBottomSheet({
    Key? key,
    this.elements,
    this.showFlag = true,
    this.hideSearch = false,
    this.flagWidth = 32.0,
    this.heightBottomSheet = 0.8, // <= 1.0
    this.textStyle,
    this.searchStyle,
    this.flagDecoration,
    this.searchDecoration,
    this.emptySearchBuilder,
    this.favoriteElements,
    this.placeholder = 'Tìm tên nước',
  }) : super(key: key);

  final List<CountryCode>? elements;
  final bool hideSearch;
  final bool showFlag;
  final double flagWidth;
  final String? placeholder;
  final double heightBottomSheet;
  final TextStyle? textStyle;
  final TextStyle? searchStyle;
  final Decoration? flagDecoration;
  final WidgetBuilder? emptySearchBuilder;
  final InputDecoration? searchDecoration;
  final List<CountryCode>? favoriteElements;

  @override
  _FlagPhoneNumberBottomSheetState createState() => _FlagPhoneNumberBottomSheetState();
}

class _FlagPhoneNumberBottomSheetState extends State<FlagPhoneNumberBottomSheet> {
  bool showIconClear = false;
  TextEditingController? controllerFilterFormField;
  List<CountryCode>? filteredElements;
  
  @override
  void initState() {
    filteredElements = widget.elements!;
    controllerFilterFormField = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controllerFilterFormField!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final sizeScreen = MediaQuery.of(context).size;

    return BottomSheetComponent.container(
      context,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: sizeScreen.height * widget.heightBottomSheet,
          maxHeight: sizeScreen.height * widget.heightBottomSheet,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BottomSheetComponent.draggableEdge(context),
            const SizedBox(height: 24.0),
            if (!widget.hideSearch)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: controllerFilterFormField,
                  style: widget.searchStyle,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.withOpacity(0.4),
                      size: 18,
                    ),
                    suffixIcon: showIconClear ? IconButton(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(
                        Icons.clear,
                        size: 16.0,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      onPressed: () {
                        setState(() {
                          filteredElements = widget.elements!;
                        });
                        controllerFilterFormField!.text = '';
                      }
                    ) : null,
                    counterText: '',
                    errorText: null,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.14),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.14),
                        width: 0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.14),
                        width: 0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.14),
                        width: 0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.14),
                        width: 0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(0)),
                    ),
                    contentPadding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                      top: 8.0,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    hintText: widget.placeholder!,
                  ),
                  onChanged: _filterElements,
                ),
              ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  widget.favoriteElements!.isEmpty
                      ? const DecoratedBox(decoration: BoxDecoration())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...widget.favoriteElements!.map(
                              (f) => _buildOption(f),
                            ),
                            const Divider(),
                          ],
                        ),
                  if (filteredElements!.isEmpty)
                    _buildEmptySearchWidget(context)
                  else
                    ...filteredElements!.map(
                      (e) => _buildOption(e),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySearchWidget(BuildContext context) {
    if (widget.emptySearchBuilder != null) {
      return widget.emptySearchBuilder!(context);
    }

    return Center(
      child: Text('No country found'),
    );
  }

  Widget _buildOption(CountryCode e) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          return _selectItem(e);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 12.0,
          ),
          child: Row(
            children: <Widget>[
              if (widget.showFlag)
                Container(
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e.toCountryStringOnly(),
                      overflow: TextOverflow.fade,
                      style: widget.textStyle,
                    ),
                    Text(
                      '${e.dialCode}',
                        overflow: TextOverflow.fade,
                        style: widget.textStyle,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectItem(CountryCode e) {
    Navigator.pop(context, e);
  }

  void _filterElements(String s) {
      if (s.isNotEmpty) {
        setState(() {
          showIconClear = true;
        });   
      } else {
        setState(() {
          showIconClear = false;
        });
      }

      s = s.toUpperCase();
      setState(() {
        filteredElements = widget.elements!
            .where((e) =>
                e.code!.contains(s) ||
                e.dialCode!.contains(s) ||
                e.name!.toUpperCase().contains(s))
            .toList();
      });
    }
}
