class ViewModel {
  int? status;
  Data? data;

  ViewModel({this.status, this.data});

  ViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? fullName;
  String? emailAddress;
  String? dateOfBirth;
  String? phoneNumber;
  String? gender;
  String? address;

  Data(
      {this.id,
      this.fullName,
      this.emailAddress,
      this.dateOfBirth,
      this.phoneNumber,
      this.gender,
      this.address});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['FullName'];
    emailAddress = json['Email Address'];
    dateOfBirth = json['Date of birth'];
    phoneNumber = json['Phone number'];
    gender = json['Gender'];
    address = json['Address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['FullName'] = fullName;
    data['Email Address'] = emailAddress;
    data['Date of birth'] = dateOfBirth;
    data['Phone number'] = phoneNumber;
    data['Gender'] = gender;
    data['Address'] = address;
    return data;
  }
}
