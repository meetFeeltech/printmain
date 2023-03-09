
part of 'Dashboard_bloc.dart';

abstract class DashboardStates {}

class DashboardInitialState extends DashboardStates {}

class DashboardLoadingState extends DashboardStates {
  final bool showProgress;

  DashboardLoadingState(this.showProgress);
}

class PostExcelDataEventState extends DashboardStates {
  final post_excel_model loginResponseData;
  // final UserProfileData userProfileDataResponse;

  PostExcelDataEventState(this.loginResponseData);
}

class APIFailureState extends DashboardStates {
  final Exception exception;

  APIFailureState(this.exception);
}

