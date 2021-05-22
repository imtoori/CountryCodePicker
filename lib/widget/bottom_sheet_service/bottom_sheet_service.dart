import 'package:flutter/material.dart';
import 'package:country_code_picker/widget/bottom_sheet_service/bottom_sheet_widget.dart';
import 'bottom_sheet_component.dart';

import 'package:flutter/foundation.dart';

export '../../country_code.dart';

class BottomSheetService {
  static Future<T?> show<T>(
    BuildContext context, {
    @required Widget? builder,
    Color? backgroundColor,
    double? elevation,
    bool persistent = true,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color? barrierColor,
    bool? ignoreSafeArea,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    double maxWidth = double.infinity,
    RouteSettings? settings,
    Duration? enterBottomSheetDuration,
    Duration? exitBottomSheetDuration,
  }) async {
    assert(builder != null);
    assert(persistent != null);
    assert(isScrollControlled != null);
    assert(useRootNavigator != null);
    assert(isDismissible != null);
    assert(enableDrag != null);
    
    return await Navigator.of(
      context,
      rootNavigator: useRootNavigator,
    ).push(
      BottomSheetWidgetRoute<T>(
        builder: (_) => builder!,
        isPersistent: persistent,
        maxWidth: maxWidth,
        isScrollControlled: isScrollControlled,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        backgroundColor: backgroundColor ?? Colors.white,
        elevation: elevation,
        shape: shape ?? BottomSheetComponent.shape(),
        removeTop: ignoreSafeArea ?? true,
        clipBehavior: clipBehavior,
        isDismissible: isDismissible,
        modalBarrierColor: barrierColor ?? Colors.black.withOpacity(0.4),
        settings: settings,
        enableDrag: enableDrag,
      ),
    );
  }

}
