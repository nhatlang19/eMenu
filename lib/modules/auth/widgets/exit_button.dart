import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: () {
        SystemNavigator.pop();
        exit(0);
      },
      child: const Text('Exit'),
    );
  }
}
