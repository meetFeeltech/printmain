class ViewAllCategories_model {
  String? id;
  String? categoryName;
  String? categoryDesc;
  String? prodImg;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? createdBy;
  String? updatedBy;
  Null? deletedBy;
  CreatedByUser? createdByUser;
  CreatedByUser? updatedByUser;

  ViewAllCategories_model(
      {this.id,
        this.categoryName,
        this.categoryDesc,
        this.prodImg,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdByUser,
        this.updatedByUser});

  ViewAllCategories_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    categoryDesc = json['categoryDesc'];
    prodImg = json['prodImg'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    createdByUser = json['CreatedByUser'] != null
        ? new CreatedByUser.fromJson(json['CreatedByUser'])
        : null;
    updatedByUser = json['UpdatedByUser'] != null
        ? new CreatedByUser.fromJson(json['UpdatedByUser'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    data['categoryDesc'] = this.categoryDesc;
    data['prodImg'] = this.prodImg;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['deletedBy'] = this.deletedBy;
    if (this.createdByUser != null) {
      data['CreatedByUser'] = this.createdByUser!.toJson();
    }
    if (this.updatedByUser != null) {
      data['UpdatedByUser'] = this.updatedByUser!.toJson();
    }
    return data;
  }
}

class CreatedByUser {
  String? id;
  String? firstName;
  String? lastName;

  CreatedByUser({this.id, this.firstName, this.lastName});

  CreatedByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}
