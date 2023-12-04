class RequestlistModel {
  int? status;
  String? message;
  List<Data>? data;

  RequestlistModel({this.status, this.message, this.data});

  RequestlistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? reqId;
  String? userId;
  String? itiId;
  String? subject;
  String? comments;
  String? dates;
  String? title;
  String? subtitle;
  String? description;
  List<String>? galleryImg;

  Data(
      {this.reqId,
        this.userId,
        this.itiId,
        this.subject,
        this.comments,
        this.dates,
        this.title,
        this.subtitle,
        this.description,
        this.galleryImg});

  Data.fromJson(Map<String, dynamic> json) {
    reqId = json['req_id'];
    userId = json['user_id'];
    itiId = json['iti_id'];
    subject = json['subject'];
    comments = json['comments'];
    dates = json['dates'];
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    galleryImg = json['gallery_img'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['req_id'] = reqId;
    data['user_id'] = userId;
    data['iti_id'] = itiId;
    data['subject'] = subject;
    data['comments'] = comments;
    data['dates'] = dates;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['description'] = description;
    data['gallery_img'] = galleryImg;
    return data;
  }
}