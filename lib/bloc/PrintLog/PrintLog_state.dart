
part of 'PrintLog_bloc.dart';

abstract class PrintLogStates {}

class PrintLogInitialState extends PrintLogStates {}

class AllFetchDataForPrintLogPageState extends PrintLogStates{
  final List<ExcelDataModel> allCatoModel;
  AllFetchDataForPrintLogPageState(this.allCatoModel);
}

class DeleteLogDataState extends PrintLogStates {
  final List<ExcelDataModel> allCatoModel;
  Delete_model deleteResponse;
  DeleteLogDataState(this.deleteResponse,this.allCatoModel);
}



class PrintLogLoadingState extends PrintLogStates {
  final bool showProgress;

  PrintLogLoadingState(this.showProgress);
}


class APIFailureState extends PrintLogStates {
  final Exception exception;

  APIFailureState(this.exception);
}

