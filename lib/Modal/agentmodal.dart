class MyagentModal {
  int? status;
  String? message;
  Data? data;

  MyagentModal({this.status, this.message, this.data});

  MyagentModal.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? fullname;
  String? emailAddress;
  String? dateOfBirth;
  String? phoneNumber;
  String? gender;
  String? address;
  String? expertise;
  String? aTOLNumber;
  String? aTOLCertificate;

  Data(
      {this.id,
        this.fullname,
        this.emailAddress,
        this.dateOfBirth,
        this.phoneNumber,
        this.gender,
        this.address,
        this.expertise,
        this.aTOLNumber,
        this.aTOLCertificate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['Fullname'];
    emailAddress = json['Email Address'];
    dateOfBirth = json['Date of birth'];
    phoneNumber = json['Phone number'];
    gender = json['Gender'];
    address = json['Address'];
    expertise = json['Expertise'];
    aTOLNumber = json['ATOL Number'];
    aTOLCertificate = json['ATOL Certificate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Fullname'] = fullname;
    data['Email Address'] = emailAddress;
    data['Date of birth'] = dateOfBirth;
    data['Phone number'] = phoneNumber;
    data['Gender'] = gender;
    data['Address'] = address;
    data['Expertise'] = expertise;
    data['ATOL Number'] = aTOLNumber;
    data['ATOL Certificate'] = aTOLCertificate;
    return data;
  }
}