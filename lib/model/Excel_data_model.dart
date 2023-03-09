class ExcelDataModel {
  String? id;
  String? chequeNo;
  String? chequeDate;
  bool? isAccountPay;
  String? chequePayname;
  dynamic chequeAmount;
  CompanyMaster? companyMaster;
  String? createdBy;
  String? createdDate;

  ExcelDataModel(
      {this.id,
        this.chequeNo,
        this.chequeDate,
        this.isAccountPay,
        this.chequePayname,
        this.chequeAmount,
        this.companyMaster,
        this.createdBy,
        this.createdDate});

  ExcelDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chequeNo = json['chequeNo'];
    chequeDate = json['chequeDate'];
    isAccountPay = json['isAccountPay'];
    chequePayname = json['chequePayname'];
    chequeAmount = json['chequeAmount'];
    companyMaster = json['companyMaster'] != null
        ? new CompanyMaster.fromJson(json['companyMaster'])
        : null;
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chequeNo'] = this.chequeNo;
    data['chequeDate'] = this.chequeDate;
    data['isAccountPay'] = this.isAccountPay;
    data['chequePayname'] = this.chequePayname;
    data['chequeAmount'] = this.chequeAmount;
    if (this.companyMaster != null) {
      data['companyMaster'] = this.companyMaster!.toJson();
    }
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    return data;
  }
}

class CompanyMaster {
  String? id;
  String? companyName;
  dynamic phone;
  dynamic address;
  String? startDate;
  String? endDate;
  dynamic remarks;
  String? email;
  String? passwordHash;
  String? passwordSalt;
  bool? isActive;
  bool? isDeleted;
  dynamic createdBy;
  dynamic createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  dynamic deletedBy;
  dynamic deletedDate;
  dynamic printLog;

  CompanyMaster(
      {this.id,
        this.companyName,
        this.phone,
        this.address,
        this.startDate,
        this.endDate,
        this.remarks,
        this.email,
        this.passwordHash,
        this.passwordSalt,
        this.isActive,
        this.isDeleted,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.deletedBy,
        this.deletedDate,
        this.printLog});

  CompanyMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    phone = json['phone'];
    address = json['address'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    remarks = json['remarks'];
    email = json['email'];
    passwordHash = json['passwordHash'];
    passwordSalt = json['passwordSalt'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
    printLog = json['printLog'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['remarks'] = this.remarks;
    data['email'] = this.email;
    data['passwordHash'] = this.passwordHash;
    data['passwordSalt'] = this.passwordSalt;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    data['deletedBy'] = this.deletedBy;
    data['deletedDate'] = this.deletedDate;
    data['printLog'] = this.printLog;
    return data;
  }
}
