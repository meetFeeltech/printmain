import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/Excel_data_model.dart';
import '../../model/viewallcategories/ViewAllCategories_model.dart';
import '../../network/repositary.dart';

part 'PrintLog_event.dart';
part 'PrintLog_state.dart';

class PrintLogBloc extends Bloc<PrintLogEvents, PrintLogStates> {
  final Repository repositaryRepo;

  PrintLogBloc(this.repositaryRepo) : super(PrintLogInitialState()) {
    on<PrintLogEvents>((event, emit) async {

      if(event is AllFetchDataForPrintLogPageEvent){
        late List<ExcelDataModel> allCategoryData;

        try{
          emit(PrintLogLoadingState(true));
          allCategoryData =
          await repositaryRepo.getAllCategoryData();
          emit(PrintLogLoadingState(false));
          emit(AllFetchDataForPrintLogPageState(allCategoryData));

        }
        catch(error,stacktrace){
          print("stacktrave: $stacktrace");
          emit(PrintLogLoadingState(false));
          emit(APIFailureState(Exception(error.toString())));
        }

      }


    });
  }
}
