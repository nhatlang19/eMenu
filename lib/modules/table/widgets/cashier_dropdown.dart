import 'package:emenu/models/user.dart';
import 'package:emenu/modules/table/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashierDropdown extends StatelessWidget {
  const CashierDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (previous, current) =>
          previous.selectedUser.cashierID != current.selectedUser.cashierID,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                    flex: 1,
                    child: Text(
                      'Cashier: ',
                    )),
                Expanded(
                  flex: 4,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<User>(
                        value: state.selectedUser,
                        onChanged: (User? newValue) {
                          context.read<UserBloc>().add(ChangeSelectUser(
                              user: newValue ?? state.selectedUser));
                        },
                        items: state.users
                            .map<DropdownMenuItem<User>>((User user) {
                          return DropdownMenuItem<User>(
                            value: user,
                            child: Text(user.cashierName ?? ''),
                          );
                        }).toList(),
                      ))),
                ),
              ],
            ));
      },
    );
  }
}
