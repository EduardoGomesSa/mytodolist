import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Column(
            children: [Text('Logo')],
          ),
          Column(
            children: [Text('Form Login')],
          )
        ],
      ),
    );
  }
}
