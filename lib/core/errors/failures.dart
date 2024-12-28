import 'package:vm_tecnologia/core/constants/app_strings.dart';

class Failure {
  final String message;

  Failure(this.message);
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure() : super(AppStrings.entradaInvalida);
}

class NumberGenerationFailure extends Failure {
  NumberGenerationFailure() : super(AppStrings.erroGerarNumeros);
}