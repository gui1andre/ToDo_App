import 'package:flutter/material.dart';

showMessageDialog(BuildContext context, String message,
    {String? title, List<Widget>? actions}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  AlertDialog alert = AlertDialog(
    title: title == null
        ? null
        : Text(
            title,
          ),
    content: Text(
      message,
      style: textTheme.bodyLarge,
      textAlign: TextAlign.justify,
    ),
    actions: actions ??
        [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Ok',
            ),
          )
        ],
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
