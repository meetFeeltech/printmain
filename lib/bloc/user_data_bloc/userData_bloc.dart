
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user_data_model.dart';
import '../../network/repositary.dart';

part 'userData_event.dart';
part 'userData_state.dart';

class UserDataPageBloc extends Bloc<UserDataPageEvent, UserDataPageState> {
  final Repository repositoryRepo;

  UserDataPageBloc(this.repositoryRepo) : super(UserPageInitialState()) {
    on<UserDataPageEvent>((event, emit) async {

      if(event is AllFetchDataForUserPageEvent){
        late List<user_data_model> allUserData;

        try{
          emit(UserDataPageLoadingState(true));
          allUserData =
          await repositoryRepo.getUser();
          emit(UserDataPageLoadingState(false));
          emit(AllFetchDataForUserDataPageState(allUserData));
          print("user all Data are here : $allUserData");
        }
        catch(error,stacktrace){
          print("stacktrave: $stacktrace");
          emit(UserDataPageLoadingState(false));
          emit(ApiFailureState(Exception(error.toString())));
        }

      }



    });
  }
}
