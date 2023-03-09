import 'package:cheque_print/model/post_excel_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/user_data_model.dart';
import '../../model/viewallcategories/ViewAllCategories_model.dart';
import '../../network/repositary.dart';

part 'Dashboard_event.dart';
part 'Dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvents, DashboardStates> {
  final Repository repositaryRepo;

  late post_excel_model excelData;


  DashboardBloc(this.repositaryRepo) : super(DashboardInitialState()) {
    on<DashboardEvents>((event, emit) async {

      if(event is PostExcelDataEvent) {
        // late UserProfileData userProfileData;
        try {
          emit(DashboardLoadingState(true));
          print("event working");

          excelData = await repositaryRepo.logPostAPI('chequeprintlog',[
            {
              "chequeNo":event.chequeNo,
              "chequeDate":event.chequeDate,
              "isAccountPay":event.isAccountPay,
              "chequeAmount":event.chequeAmount,
              "chequePayname":event.chequePayname}
          ]
          );
          // userProfileData = await repositaryRepo.getUserDataForProfile('profile');
          emit(DashboardLoadingState(false));
          emit(PostExcelDataEventState(excelData));

        } catch (error, stacktrace) {
          emit(DashboardLoadingState(false));
          emit(APIFailureState(Exception(error.toString())));
        }
      }

    });
  }
}
