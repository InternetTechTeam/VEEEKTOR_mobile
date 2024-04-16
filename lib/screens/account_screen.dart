import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/user_bloc/user_bloc.dart';

class AccoutScreen extends StatelessWidget {
  const AccoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Аккаунт"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.user!.email ?? "Втф пусто"),
              TextButton(onPressed: () {
                BlocProvider.of<UserBloc>(context).add(UserEvent.logout());
              }, child: Text("Logout")),
            ],
          );
        },
      ),
    );
  }
}
