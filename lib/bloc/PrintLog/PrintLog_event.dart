
part of 'PrintLog_bloc.dart';

abstract class PrintLogEvents {}

class PrintLogInitialEvent extends PrintLogEvents {}

class AllFetchDataForPrintLogPageEvent extends PrintLogEvents{

}

class DeleteLogEvent extends PrintLogEvents{
  final String? id;
  DeleteLogEvent(this.id);

}