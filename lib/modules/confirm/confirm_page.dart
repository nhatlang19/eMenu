import 'package:emenu/modules/confirm/widgets/confirm_view.dart';
import 'package:flutter/material.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({super.key});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
        body: const ConfirmView(),
    );
  }
}