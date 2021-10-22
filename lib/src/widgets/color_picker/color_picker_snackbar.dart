import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:inspect/src/widgets/color_picker/utils.dart';

void showColorPickerResultSnackbar({
  required BuildContext context,
  required Color color,
}) {
  final colorString = '#${colorToHexString(color)}';

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          const SizedBox(width: 8.0),
          Text('Color: $colorString'),
        ],
      ),
      action: SnackBarAction(
        label: 'Copy',
        onPressed: () {
          Clipboard.setData(ClipboardData(text: colorString));
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}