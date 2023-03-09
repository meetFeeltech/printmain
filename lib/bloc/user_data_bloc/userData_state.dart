
part of 'userData_bloc.dart';


abstract class UserDataPageState{}

class UserPageInitialState extends UserDataPageState{}

class AllFetchDataForUserDataPageState extends UserDataPageState{
  final List<user_data_model> alluserModel;
  AllFetchDataForUserDataPageState(this.alluserModel);
}

class UserDataPageLoadingState extends  UserDataPageState{
  final bool showProgress;
  UserDataPageLoadingState(this.showProgress);
}

class ApiFailureState extends UserDataPageState{
  final Exception exception;
  ApiFailureState(this.exception);
}
