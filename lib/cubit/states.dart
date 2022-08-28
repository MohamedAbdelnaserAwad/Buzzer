abstract class BuzzerStates {}

class BuzzerInitialState extends BuzzerStates {}

class BuzzerGetUserLoadingState extends BuzzerStates {}

class BuzzerGetUserSuccessState extends BuzzerStates {}

class BuzzerGetUserErrorState extends BuzzerStates
{
  final String error;

  BuzzerGetUserErrorState(this.error);
}

class BuzzerGetAllUsersLoadingState extends BuzzerStates {}

class BuzzerGetAllUsersSuccessState extends BuzzerStates {}

class BuzzerGetAllUsersErrorState extends BuzzerStates
{
  final String error;

  BuzzerGetAllUsersErrorState(this.error);
}