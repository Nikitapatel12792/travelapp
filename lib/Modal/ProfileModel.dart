class ProfileModel {
  int? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? uId;
  String? username;
  String? password;
  String? stripeCustId;
  String? email;
  String? type;
  String? freeCreated;
  String? createdDate;
  String? id;
  String? userId;
  String? fullname;
  String? gender;
  String? profileImg;
  String? phoneno;
  String? user;
  String? address;
  String? expertise;
  String? dateOfBirth;
  String? emergencyContact;
  String? additionalTraveller;
  String? updatedDate;

  Data(
      {this.uId,
        this.username,
        this.password,
        this.stripeCustId,
        this.email,
        this.type,
        this.freeCreated,
        this.createdDate,
        this.id,
        this.userId,
        this.fullname,
        this.gender,
        this.profileImg,
        this.phoneno,
        this.user,
        this.address,
        this.expertise,
        this.dateOfBirth,
        this.emergencyContact,
        this.additionalTraveller,
        this.updatedDate});

  Data.fromJson(Map<String, dynamic> json) {
    uId = json['u_id'];
    username = json['username'];
    password = json['password'];
    stripeCustId = json['stripe_cust_id'];
    email = json['email'];
    type = json['type'];
    freeCreated = json['free_created'];
    createdDate = json['created_date'];
    id = json['id'];
    userId = json['user_id'];
    fullname = json['fullname'];
    gender = json['gender'];
    profileImg = json['profile_img'];
    phoneno = json['phoneno'];
    user = json['user'];
    address = json['address'];
    expertise = json['expertise'];
    dateOfBirth = json['date_of_birth'];
    emergencyContact = json['emergency_contact'];
    additionalTraveller = json['additional_traveller'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['u_id'] = uId;
    data['username'] = username;
    data['password'] = password;
    data['stripe_cust_id'] = stripeCustId;
    data['email'] = email;
    data['type'] = type;
    data['free_created'] = freeCreated;
    data['created_date'] = createdDate;
    data['id'] = id;
    data['user_id'] = userId;
    data['fullname'] = fullname;
    data['gender'] = gender;
    data['profile_img'] = profileImg;
    data['phoneno'] = phoneno;
    data['user'] = user;
    data['address'] = address;
    data['expertise'] = expertise;
    data['date_of_birth'] = dateOfBirth;
    data['emergency_contact'] = emergencyContact;
    data['additional_traveller'] = additionalTraveller;
    data['updated_date'] = updatedDate;
    return data;
  }
}