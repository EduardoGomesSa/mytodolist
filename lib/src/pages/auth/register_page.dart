import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        Expanded(child: Column(children: [
          Text('Logo')
        ],
      ),
      ),
      Container(child: Text('Formulario'),),
      ],
    ),);
  }
}