class TripModel {
  int? status;
  String? message;
  List<Data>? data;

  TripModel({this.status, this.message, this.data});

  TripModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? galleryImage;
  String? itineraryId;
  String? tripplannerId;
  String? location;
  String? latlong;
  String? favourite;

  Data(
      {this.title,
        this.galleryImage,
        this.itineraryId,
        this.tripplannerId,
        this.location,
        this.latlong,
        this.favourite});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    galleryImage = json['gallery_image'];
    itineraryId = json['itinerary_id'];
    tripplannerId = json['tripplanner_id'];
    location = json['location'];
    latlong = json['latlong'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['gallery_image'] = galleryImage;
    data['itinerary_id'] = itineraryId;
    data['tripplanner_id'] = tripplannerId;
    data['location'] = location;
    data['latlong'] = latlong;
    data['favourite'] = favourite;
    return data;
  }
}