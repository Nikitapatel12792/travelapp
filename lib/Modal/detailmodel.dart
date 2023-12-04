class DetailModel {
  int? status;
  String? message;
  String? location;
  String? latlong;
  List<AboutTheTour>? aboutTheTour;
  List<TourInformation>? tourInformation;
  List<TravelDetail>? travelDetail;
  List<Transport>? transport;
  List<Hotel>? hotel;
  List<String>? gallery;
  List<Itinerary>? itinerary;
  OtherInformation? otherInformation;
  List<LuggageDetail>? luggageDetail;

  DetailModel(
      {this.status,
        this.message,
        this.location,
        this.latlong,
        this.aboutTheTour,
        this.tourInformation,
        this.travelDetail,
        this.transport,
        this.hotel,
        this.gallery,
        this.itinerary,
        this.otherInformation,
        this.luggageDetail});

  DetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    location = json['Location'];
    latlong = json['Latlong'];
    if (json['About the tour'] != null) {
      aboutTheTour = <AboutTheTour>[];
      json['About the tour'].forEach((v) {
        aboutTheTour!.add(AboutTheTour.fromJson(v));
      });
    }
    if (json['Tour information'] != null) {
      tourInformation = <TourInformation>[];
      json['Tour information'].forEach((v) {
        tourInformation!.add(TourInformation.fromJson(v));
      });
    }
    if (json['Travel Detail'] != null) {
      travelDetail = <TravelDetail>[];
      json['Travel Detail'].forEach((v) {
        travelDetail!.add(TravelDetail.fromJson(v));
      });
    }
    if (json['Transport'] != null) {
      transport = <Transport>[];
      json['Transport'].forEach((v) {
        transport!.add(Transport.fromJson(v));
      });
    }
    if (json['Hotel'] != null) {
      hotel = <Hotel>[];
      json['Hotel'].forEach((v) {
        hotel!.add(Hotel.fromJson(v));
      });
    }
    gallery = json['Gallery'].cast<String>();
    if (json['Itinerary'] != null) {
      itinerary = <Itinerary>[];
      json['Itinerary'].forEach((v) {
        itinerary!.add(Itinerary.fromJson(v));
      });
    }
    otherInformation = json['Other information'] != null
        ? OtherInformation.fromJson(json['Other information'])
        : null;
    if (json['Luggage detail'] != null) {
      luggageDetail = <LuggageDetail>[];
      json['Luggage detail'].forEach((v) {
        luggageDetail!.add(LuggageDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['Location'] = location;
    data['Latlong'] = latlong;
    if (aboutTheTour != null) {
      data['About the tour'] =
          aboutTheTour!.map((v) => v.toJson()).toList();
    }
    if (tourInformation != null) {
      data['Tour information'] =
          tourInformation!.map((v) => v.toJson()).toList();
    }
    if (travelDetail != null) {
      data['Travel Detail'] =
          travelDetail!.map((v) => v.toJson()).toList();
    }
    if (transport != null) {
      data['Transport'] = transport!.map((v) => v.toJson()).toList();
    }
    if (hotel != null) {
      data['Hotel'] = hotel!.map((v) => v.toJson()).toList();
    }
    data['Gallery'] = gallery;
    if (itinerary != null) {
      data['Itinerary'] = itinerary!.map((v) => v.toJson()).toList();
    }
    if (otherInformation != null) {
      data['Other information'] = otherInformation!.toJson();
    }
    if (luggageDetail != null) {
      data['Luggage detail'] =
          luggageDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AboutTheTour {
  String? title;
  String? subtitle;
  String? description;
  String? startDate;
  String? endDate;
  String? duration;

  AboutTheTour(
      {this.title,
        this.subtitle,
        this.description,
        this.startDate,
        this.endDate,
        this.duration});

  AboutTheTour.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    duration = json['Duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['description'] = description;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['Duration'] = duration;
    return data;
  }
}

class TourInformation {
  String? duration;
  String? startPoint;
  String? endPoint;
  String? returnStartPoint;
  String? returnEndPoint;

  TourInformation(
      {this.duration,
        this.startPoint,
        this.endPoint,
        this.returnStartPoint,
        this.returnEndPoint});

  TourInformation.fromJson(Map<String, dynamic> json) {
    duration = json['Duration'];
    startPoint = json['Start Point'];
    endPoint = json['End Point'];
    returnStartPoint = json['Return Start Point'];
    returnEndPoint = json['Return End Point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Duration'] = duration;
    data['Start Point'] = startPoint;
    data['End Point'] = endPoint;
    data['Return Start Point'] = returnStartPoint;
    data['Return End Point'] = returnEndPoint;
    return data;
  }
}

class TravelDetail {
  String? travelOption;
  String? departureFromDate;
  String? departureToDate;
  String? departureTime;
  String? pickupTime;
  String? dropTime;
  String? airlines;
  String? flightNo;
  String? returnTravelOption;
  String? returnFromDate;
  String? returnToDate;
  String? returnDepartureTime;
  String? returnPickupTime;
  String? returnDropTime;
  String? returnAirlines;
  String? returnFlightNo;

  TravelDetail(
      {this.travelOption,
        this.departureFromDate,
        this.departureToDate,
        this.departureTime,
        this.pickupTime,
        this.dropTime,
        this.airlines,
        this.flightNo,
        this.returnTravelOption,
        this.returnFromDate,
        this.returnToDate,
        this.returnDepartureTime,
        this.returnPickupTime,
        this.returnDropTime,
        this.returnAirlines,
        this.returnFlightNo});

  TravelDetail.fromJson(Map<String, dynamic> json) {
    travelOption = json['Travel_option'];
    departureFromDate = json['departure_from_date'];
    departureToDate = json['departure_to_date'];
    departureTime = json['Departure_time'];
    pickupTime = json['pickup_time'];
    dropTime = json['drop_time'];
    airlines = json['airlines'];
    flightNo = json['flight_no'];
    returnTravelOption = json['Return travel option'];
    returnFromDate = json['Return_from_date'];
    returnToDate = json['Return_to_date'];
    returnDepartureTime = json['Return departure time'];
    returnPickupTime = json['Return_pickup_time'];
    returnDropTime = json['Return_drop_time'];
    returnAirlines = json['return_airlines'];
    returnFlightNo = json['return_flight_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Travel_option'] = travelOption;
    data['departure_from_date'] = departureFromDate;
    data['departure_to_date'] = departureToDate;
    data['Departure_time'] = departureTime;
    data['pickup_time'] = pickupTime;
    data['drop_time'] = dropTime;
    data['airlines'] = airlines;
    data['flight_no'] = flightNo;
    data['Return travel option'] = returnTravelOption;
    data['Return_from_date'] = returnFromDate;
    data['Return_to_date'] = returnToDate;
    data['Return departure time'] = returnDepartureTime;
    data['Return_pickup_time'] = returnPickupTime;
    data['Return_drop_time'] = returnDropTime;
    data['return_airlines'] = returnAirlines;
    data['return_flight_no'] = returnFlightNo;
    return data;
  }
}

class Transport {
  String? transfer;
  String? returnTransfer;

  Transport({this.transfer, this.returnTransfer});

  Transport.fromJson(Map<String, dynamic> json) {
    transfer = json['transfer'];
    returnTransfer = json['return_transfer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transfer'] = transfer;
    data['return_transfer'] = returnTransfer;
    return data;
  }
}

class Hotel {
  String? hotelName;
  String? hotelType;
  String? hotelImage;
  String? location;
  String? noOfNight;

  Hotel(
      {this.hotelName,
        this.hotelType,
        this.hotelImage,
        this.location,
        this.noOfNight});

  Hotel.fromJson(Map<String, dynamic> json) {
    hotelName = json['hotel_name'];
    hotelType = json['hotel_type'];
    hotelImage = json['hotel_image'];
    location = json['location'];
    noOfNight = json['no_of_night'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hotel_name'] = hotelName;
    data['hotel_type'] = hotelType;
    data['hotel_image'] = hotelImage;
    data['location'] = location;
    data['no_of_night'] = noOfNight;
    return data;
  }
}

class Itinerary {
  String? date;
  String? daysTitle;
  String? dayDescription;

  Itinerary({this.date, this.daysTitle, this.dayDescription});

  Itinerary.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    daysTitle = json['Days_title'];
    dayDescription = json['Day_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    data['Days_title'] = daysTitle;
    data['Day_description'] = dayDescription;
    return data;
  }
}

class OtherInformation {
  List<String>? title;
  List<String>? description;

  OtherInformation({this.title, this.description});

  OtherInformation.fromJson(Map<String, dynamic> json) {
    title = json['title'].cast<String>();
    description = json['description'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class LuggageDetail {
  String? luggage;
  String? returnLuggage;

  LuggageDetail({this.luggage, this.returnLuggage});

  LuggageDetail.fromJson(Map<String, dynamic> json) {
    luggage = json['luggage'];
    returnLuggage = json['return_luggage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['luggage'] = luggage;
    data['return_luggage'] = returnLuggage;
    return data;
  }
}