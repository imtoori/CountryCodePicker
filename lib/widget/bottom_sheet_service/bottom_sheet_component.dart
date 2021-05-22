
import 'package:flutter/material.dart';

class BottomSheetComponent {
  static ShapeBorder shape() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0),
        topRight: Radius.circular(32.0),
      ),
    );
  }

  static Widget container(BuildContext context, {@required Widget? child}) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        right: 16.0,
      ),
      child: child,
    );
  }

  static Widget content(
    BuildContext context, {
    double minHeight = 0.35,
    double maxHeight = 0.55,
    Widget? header,
    Widget? footer,
    @required Widget? body,
  }) {
    final size = MediaQuery.of(context).size;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 420,
        minHeight: size.height * minHeight,
        maxHeight: size.height * maxHeight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (header != null) ...[
            header,
            SizedBox(height: 24.0),
          ],
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: body,
            ),
          ),
          if (footer != null) ...[
            SizedBox(height: 24.0),
            footer,
          ],
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  static Widget draggableEdge(BuildContext context) {

    return Center(
      child: Container(
        width: 131.0,
        height: 8.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
