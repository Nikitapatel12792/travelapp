class FavouritelistModel {
  String? status;
  String? message;
  List<Data>? data;

  FavouritelistModel({this.status, this.message, this.data});

  FavouritelistModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? title;
  String? subtitle;
  String? imageId;
  String? description;
  String? startDate;
  String? endDate;
  String? days;
  String? daysTitle;
  String? daysDescription;
  String? createdDate;
  String? updatedDate;
  String? iteId;
  String? userId;
  String? clientId;
  String? itineraryId;
  String? travelOption;
  String? flightNo;
  String? overnightAccommodation;
  String? carParking;
  String? transfer;
  String? departureTime;
  String? pickupLocation;
  String? dropLocation;
  String? depFromDate;
  String? depToDate;
  String? pickupTime;
  String? dropTime;
  String? returnCarParking;
  String? returnOvernoghtAcco;
  String? returnTravelOption;
  String? returnTransfer;
  String? returnTime;
  String? returnPickupLocation;
  String? returnDropLocation;
  String? returnFromDate;
  String? returnToDate;
  String? returnPickupTime;
  String? returnDropTime;
  String? returnFlightNo;
  String? hotelName;
  String? hotelType;
  String? hotelImg;
  String? noOfRoom;
  String? roomDetail;
  String? mealArragement;
  String? checkInDate;
  String? checkOutDate;
  String? location;
  String? noOfNightStay;
  String? totalAmt;
  String? deposit;
  String? paymentMode;
  String? passportVisa;
  String? drivingLicence;
  String? vaccinationReq;
  String? currency;
  String? insuranceAllowance;
  String? insuranceDet;
  String? luggageAllowance;
  String? luggageDetail;
  String? notes;
  String? healthReq;
  String? entryReq;
  String? seatRequest;
  String? dietaryRequirement;
  String? upToDate;
  String? cancellationCharge;
  String? norefundableDate;
  String? weather;
  String? isFavourite;
  String? imgId;
  List<String>? images;

  Data(
      {this.id,
        this.title,
        this.subtitle,
        this.imageId,
        this.description,
        this.startDate,
        this.endDate,
        this.days,
        this.daysTitle,
        this.daysDescription,
        this.createdDate,
        this.updatedDate,
        this.iteId,
        this.userId,
        this.clientId,
        this.itineraryId,
        this.travelOption,
        this.flightNo,
        this.overnightAccommodation,
        this.carParking,
        this.transfer,
        this.departureTime,
        this.pickupLocation,
        this.dropLocation,
        this.depFromDate,
        this.depToDate,
        this.pickupTime,
        this.dropTime,
        this.returnCarParking,
        this.returnOvernoghtAcco,
        this.returnTravelOption,
        this.returnTransfer,
        this.returnTime,
        this.returnPickupLocation,
        this.returnDropLocation,
        this.returnFromDate,
        this.returnToDate,
        this.returnPickupTime,
        this.returnDropTime,
        this.returnFlightNo,
        this.hotelName,
        this.hotelType,
        this.hotelImg,
        this.noOfRoom,
        this.roomDetail,
        this.mealArragement,
        this.checkInDate,
        this.checkOutDate,
        this.location,
        this.noOfNightStay,
        this.totalAmt,
        this.deposit,
        this.paymentMode,
        this.passportVisa,
        this.drivingLicence,
        this.vaccinationReq,
        this.currency,
        this.insuranceAllowance,
        this.insuranceDet,
        this.luggageAllowance,
        this.luggageDetail,
        this.notes,
        this.healthReq,
        this.entryReq,
        this.seatRequest,
        this.dietaryRequirement,
        this.upToDate,
        this.cancellationCharge,
        this.norefundableDate,
        this.weather,
        this.isFavourite,
        this.imgId,
        this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    imageId = json['image_id'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    days = json['days'];
    daysTitle = json['days_title'];
    daysDescription = json['days_description'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    iteId = json['ite_id'];
    userId = json['user_id'];
    clientId = json['client_id'];
    itineraryId = json['itinerary_id'];
    travelOption = json['travel_option'];
    flightNo = json['flight_no'];
    overnightAccommodation = json['overnight_accommodation'];
    carParking = json['car_parking'];
    transfer = json['transfer'];
    departureTime = json['departure_time'];
    pickupLocation = json['pickup_location'];
    dropLocation = json['drop_location'];
    depFromDate = json['dep_from_date'];
    depToDate = json['dep_to_date'];
    pickupTime = json['pickup_time'];
    dropTime = json['drop_time'];
    returnCarParking = json['return_car_parking'];
    returnOvernoghtAcco = json['return_overnoght_acco'];
    returnTravelOption = json['return_travel_option'];
    returnTransfer = json['return_transfer'];
    returnTime = json['return_time'];
    returnPickupLocation = json['return_pickup_location'];
    returnDropLocation = json['return_drop_location'];
    returnFromDate = json['return_from_date'];
    returnToDate = json['return_to_date'];
    returnPickupTime = json['return_pickup_time'];
    returnDropTime = json['return_drop_time'];
    returnFlightNo = json['return_flight_no'];
    hotelName = json['hotel_name'];
    hotelType = json['hotel_type'];
    hotelImg = json['hotel_img'];
    noOfRoom = json['no_of_room'];
    roomDetail = json['room_detail'];
    mealArragement = json['meal_arragement'];
    checkInDate = json['check_in_date'];
    checkOutDate = json['check_out_date'];
    location = json['location'];
    noOfNightStay = json['no_of_night_stay'];
    totalAmt = json['total_amt'];
    deposit = json['deposit'];
    paymentMode = json['payment_mode'];
    passportVisa = json['passport_visa'];
    drivingLicence = json['driving_licence'];
    vaccinationReq = json['vaccination_req'];
    currency = json['currency'];
    insuranceAllowance = json['insurance_allowance'];
    insuranceDet = json['insurance_det'];
    luggageAllowance = json['luggage_allowance'];
    luggageDetail = json['luggage_detail'];
    notes = json['notes'];
    healthReq = json['health_req'];
    entryReq = json['entry_req'];
    seatRequest = json['seat_request'];
    dietaryRequirement = json['dietary_requirement'];
    upToDate = json['up_to_date'];
    cancellationCharge = json['cancellation_charge'];
    norefundableDate = json['norefundable_date'];
    weather = json['weather'];
    isFavourite = json['is_favourite'];
    imgId = json['img_id'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['image_id'] = imageId;
    data['description'] = description;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['days'] = days;
    data['days_title'] = daysTitle;
    data['days_description'] = daysDescription;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['ite_id'] = iteId;
    data['user_id'] = userId;
    data['client_id'] = clientId;
    data['itinerary_id'] = itineraryId;
    data['travel_option'] = travelOption;
    data['flight_no'] = flightNo;
    data['overnight_accommodation'] = overnightAccommodation;
    data['car_parking'] = carParking;
    data['transfer'] = transfer;
    data['departure_time'] = departureTime;
    data['pickup_location'] = pickupLocation;
    data['drop_location'] = dropLocation;
    data['dep_from_date'] = depFromDate;
    data['dep_to_date'] = depToDate;
    data['pickup_time'] = pickupTime;
    data['drop_time'] = dropTime;
    data['return_car_parking'] = returnCarParking;
    data['return_overnoght_acco'] = returnOvernoghtAcco;
    data['return_travel_option'] = returnTravelOption;
    data['return_transfer'] = returnTransfer;
    data['return_time'] = returnTime;
    data['return_pickup_location'] = returnPickupLocation;
    data['return_drop_location'] = returnDropLocation;
    data['return_from_date'] = returnFromDate;
    data['return_to_date'] = returnToDate;
    data['return_pickup_time'] = returnPickupTime;
    data['return_drop_time'] = returnDropTime;
    data['return_flight_no'] = returnFlightNo;
    data['hotel_name'] = hotelName;
    data['hotel_type'] = hotelType;
    data['hotel_img'] = hotelImg;
    data['no_of_room'] = noOfRoom;
    data['room_detail'] = roomDetail;
    data['meal_arragement'] = mealArragement;
    data['check_in_date'] = checkInDate;
    data['check_out_date'] = checkOutDate;
    data['location'] = location;
    data['no_of_night_stay'] = noOfNightStay;
    data['total_amt'] = totalAmt;
    data['deposit'] = deposit;
    data['payment_mode'] = paymentMode;
    data['passport_visa'] = passportVisa;
    data['driving_licence'] = drivingLicence;
    data['vaccination_req'] = vaccinationReq;
    data['currency'] = currency;
    data['insurance_allowance'] = insuranceAllowance;
    data['insurance_det'] = insuranceDet;
    data['luggage_allowance'] = luggageAllowance;
    data['luggage_detail'] = luggageDetail;
    data['notes'] = notes;
    data['health_req'] = healthReq;
    data['entry_req'] = entryReq;
    data['seat_request'] = seatRequest;
    data['dietary_requirement'] = dietaryRequirement;
    data['up_to_date'] = upToDate;
    data['cancellation_charge'] = cancellationCharge;
    data['norefundable_date'] = norefundableDate;
    data['weather'] = weather;
    data['is_favourite'] = isFavourite;
    data['img_id'] = imgId;
    data['images'] = images;
    return data;
  }
}