import 'package:flutter/material.dart';
import 'package:nova/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
      context: context,
      title: 'Sign Out',
      content: 'Do you weally wanna sign out?',
      optionsBuilder: () => {
        'Cancel': false,
        'Sign Out': true,
      },
      ).then((value) => value ?? false,
    );
}
