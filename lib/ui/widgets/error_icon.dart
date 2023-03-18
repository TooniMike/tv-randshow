import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:unicons/unicons.dart';

class ErrorIcon extends StatelessWidget {
  final String keyText;
  const ErrorIcon({super.key, required this.keyText});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: translate(keyText),
      child: Icon(
        UniconsLine.exclamation_octagon,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
