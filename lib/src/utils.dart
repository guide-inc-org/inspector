import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class InspectorUtils {
  /// Recursively visits children of a given [renderObject] and calls [callback]
  /// on each child until [callback] returns [true].
  static void _recursivelyVisitChildren(
    RenderObject renderObject,
    bool Function(RenderObject) callback,
  ) {
    renderObject.visitChildren((child) {
      if (callback(child)) return;

      _recursivelyVisitChildren(child, callback);
    });
  }

  static RenderViewport? findAncestorViewport(RenderObject box) {
    if (box is RenderViewport) return box;

    if (box.parent is RenderObject) {
      return findAncestorViewport(box.parent as RenderObject);
    }

    return null;
  }

  static Iterable<RenderBox> onTap(BuildContext context, Offset pointerOffset) {
    final renderObject = context.findRenderObject() as RenderBox;

    final hitTestResult = BoxHitTestResult();
    renderObject.hitTest(
      hitTestResult,
      position: renderObject.globalToLocal(pointerOffset),
    );

    return hitTestResult.path
        .where((v) => v.target is RenderBox)
        .map((v) => v.target)
        .cast<RenderBox>();
  }
}

String colorToHexString(Color color) {
  final r = color.red.toRadixString(16).padLeft(2, '0');
  final g = color.green.toRadixString(16).padLeft(2, '0');
  final b = color.blue.toRadixString(16).padLeft(2, '0');

  return '$r$g$b';
}

Color getTextColorOnBackground(Color background) {
  final luminance = background.computeLuminance();

  if (luminance > 0.5) return Colors.black;
  return Colors.white;
}