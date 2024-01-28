import 'package:flutter/material.dart';
import 'package:nova/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'Oops! An error occured :(',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
