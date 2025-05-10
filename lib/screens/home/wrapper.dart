import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/screens/authentications/sign_in_screen.dart';
import 'package:flutter_application_2/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return SignInScreen();
      // return Text("perlu login");
    } else {
      return HomeScreen();
    }
  }
}