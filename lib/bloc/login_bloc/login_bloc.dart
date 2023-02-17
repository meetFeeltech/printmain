
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/login_model.dart';
import '../../network/repositary.dart';

part 'login_event.dart';
part 'login_state.dart';


class LoginScreenBloc extends Bloc<LoginScreenEvents, LoginScreenStates> {
  late login_model loginData;
  final Repository repositaryRepo;

  LoginScreenBloc(this.repositaryRepo) : super(LoginScreenInitialState()){
    on<LoginScreenEvents>((event, emit) async {
      if(event is PostLoginDataEvent) {
        // late UserProfileData userProfileData;
        try {
          emit(LoginScreenLoadingState(true));
          loginData = await repositaryRepo.loginPostAPI('login', {"email": event.userName, "password": event.passWord});
          // userProfileData = await repositaryRepo.getUserDataForProfile('profile');
          emit(LoginScreenLoadingState(false));
          emit(PostLoginDataEventState(loginData));
        } catch (error, stacktrace) {
          emit(LoginScreenLoadingState(false));
          emit(APIFailureState(Exception(error.toString())));
        }
      }
    });
  }
}
