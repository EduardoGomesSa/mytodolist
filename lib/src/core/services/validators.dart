import 'package:get/get.dart';

String? emailvalidator(String? email) {
  if (email == null || email.isEmpty) {
    return "Digite seu e-mail!";
  }

  if (!email.isEmail) {
    return "Digite um e-mail válido";
  }

  return null;
}

String? passwordValidator(password) {
  if (password == null || password.isEmpty) {
    return "Digite sua senha!";
  }

  if (password.length < 6) {
    return "Sua senha deve ter no mínimo 6 caracteres";
  }

  return null;
}

String? nameValidator(name) {
  if (name == null || name.isEmpty) {
    return "Digite seu nome!";
  }

  return null;
}