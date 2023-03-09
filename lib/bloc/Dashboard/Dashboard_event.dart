
part of 'Dashboard_bloc.dart';

abstract class DashboardEvents {}

class DashboardInitialEvent extends DashboardEvents {}

class AllFetchDataForDashboardPageEvent extends DashboardEvents{}

class PostExcelDataEvent extends DashboardEvents {
  final String chequeNo;
  final String chequeDate;
  final bool isAccountPay;
  final String chequeAmount;
  final String chequePayname;

  PostExcelDataEvent(this.chequeNo, this.chequeDate, this.isAccountPay, this.chequeAmount, this.chequePayname);


}

