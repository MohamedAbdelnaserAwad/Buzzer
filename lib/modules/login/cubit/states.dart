abstract class BuzzerLoginStates {}

class BuzzerLoginInitialState extends BuzzerLoginStates{}

class BuzzerLoginLoadingState extends BuzzerLoginStates{}

class BuzzerLoginSuccessState extends BuzzerLoginStates{
  final String uId;

  BuzzerLoginSuccessState(this.uId);
}

class BuzzerLoginErrorState extends BuzzerLoginStates{
  final String error;
  BuzzerLoginErrorState(this.error);
}

class BuzzerLoginChangePasswordVisibilityState extends BuzzerLoginStates{}



