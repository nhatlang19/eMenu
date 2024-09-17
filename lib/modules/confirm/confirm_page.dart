import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/modules/confirm/widgets/confirm_view.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/repositories/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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