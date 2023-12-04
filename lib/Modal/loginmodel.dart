class UserModal {
  int? status;
  String? message;
  List<Data>? data;

  UserModal({this.status, this.message, this.data});

  UserModal.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? uId;
  String? itineraryId;
  String? email;
  String? fullname;
  String? type;
  String? clientId;
  String? clientName;
  String? profileImg;

  Data(
      {this.uId,
        this.itineraryId,
        this.email,
        this.fullname,
        this.type,
        this.clientId,
        this.clientName,
        this.profileImg});

  Data.fromJson(Map<dynamic, dynamic> json) {
    uId = json['u_id'];
    itineraryId = json['itinerary_id'];
    email = json['email'];
    fullname = json['fullname'];
    type = json['type'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    profileImg = json['profile_img'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['u_id'] = uId;
    data['itinerary_id'] = itineraryId;
    data['email'] = email;
    data['fullname'] = fullname;
    data['type'] = type;
    data['client_id'] = clientId;
    data['client_name'] = clientName;
    data['profile_img'] = profileImg;
    return data;
  }
}
