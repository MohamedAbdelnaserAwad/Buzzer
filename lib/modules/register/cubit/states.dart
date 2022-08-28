abstract class BuzzerRegisterStates {}

class BuzzerRegisterInitialState extends BuzzerRegisterStates {}

class BuzzerRegisterLoadingState extends BuzzerRegisterStates {}

class BuzzerRegisterSuccessState extends BuzzerRegisterStates {}

class BuzzerRegisterErrorState extends BuzzerRegisterStates
{
  final String error;

  BuzzerRegisterErrorState(this.error);
}

class BuzzerCreateUserSuccessState extends BuzzerRegisterStates {}

class BuzzerCreateUserErrorState extends BuzzerRegisterStates
{
  final String error;

  BuzzerCreateUserErrorState(this.error);
}

class BuzzerRegisterChangePasswordVisibilityState extends BuzzerRegisterStates {}
