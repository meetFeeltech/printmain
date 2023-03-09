class login_model {
  String? accessToken;
  String? eDate;
  String? cDate;
  String? sDate;
  String? companyName;

  login_model({this.accessToken});

  login_model.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    eDate = json['eDate'];
    cDate = json['cDate'];
    sDate = json['sDate'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['eDate'] = this.eDate;
    data['cDate'] = this.cDate;
    data['sDate'] = this.sDate;
    data['companyName'] = this.companyName;
    return data;
  }
}
