
part of 'login_bloc.dart';

abstract class LoginScreenStates {}

class LoginScreenInitialState extends LoginScreenStates {}

class LoginScreenLoadingState extends LoginScreenStates {
  final bool showProgress;

  LoginScreenLoadingState(this.showProgress);
}

class PostLoginDataEventState extends LoginScreenStates {
  final login_model loginResponseData;
  // final UserProfileData userProfileDataResponse;
  PostLoginDataEventState(this.loginResponseData);
}

class APIFailureState extends LoginScreenStates {
  final Exception exception;

  APIFailureState(this.exception);
}