class UserProfileModel {
  bool? success;
  String? message;
  UserData? data;

  UserProfileModel({this.success, this.message, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? userStatus;
  String? sId;
  String? name;
  String? role;
  String? email;
  String? image;
  String? status;
  bool? verified;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserData(
      {this.userStatus,
      this.sId,
      this.name,
      this.role,
      this.email,
      this.image,
      this.status,
      this.verified,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserData.fromJson(Map<String, dynamic> json) {
    userStatus = json['userStatus'];
    sId = json['_id'];
    name = json['name'];
    role = json['role'];
    email = json['email'];
    image = json['image'];
    status = json['status'];
    verified = json['verified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userStatus'] = userStatus;
    data['_id'] = sId;
    data['name'] = name;
    data['role'] = role;
    data['email'] = email;
    data['image'] = image;
    data['status'] = status;
    data['verified'] = verified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
