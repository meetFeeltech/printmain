class user_data_model {
  String? id;
  String? file;
  String? reportingTo;
  String? firstName;
  String? lastName;
  int? mobile;
  String? address;
  String? email;
  bool? isVerified;
  bool? status;
  String? createdBy;
  String? createdDate;

  user_data_model(
      {this.id,
        this.file,
        this.reportingTo,
        this.firstName,
        this.lastName,
        this.mobile,
        this.address,
        this.email,
        this.isVerified,
        this.status,
        this.createdBy,
        this.createdDate});

  user_data_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    reportingTo = json['reportingTo'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    address = json['address'];
    email = json['email'];
    isVerified = json['isVerified'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.file;
    data['reportingTo'] = this.reportingTo;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['email'] = this.email;
    data['isVerified'] = this.isVerified;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
