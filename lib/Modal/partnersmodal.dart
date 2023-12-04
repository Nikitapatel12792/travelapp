class Partnersmodal {
  int? status;
  String? message;
  List<LuggageDetail>? luggageDetail;
  List<InsuranceDet>? insuranceDet;
  List<BeautyDetail>? beautyDetail;
  List<SwimwearDetail>? swimwearDetail;

  Partnersmodal(
      {this.status,
        this.message,
        this.luggageDetail,
        this.insuranceDet,
        this.beautyDetail,
        this.swimwearDetail});

  Partnersmodal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['luggage_detail'] != null) {
      luggageDetail = <LuggageDetail>[];
      json['luggage_detail'].forEach((v) {
        luggageDetail!.add(LuggageDetail.fromJson(v));
      });
    }
    if (json['insurance_det'] != null) {
      insuranceDet = <InsuranceDet>[];
      json['insurance_det'].forEach((v) {
        insuranceDet!.add(InsuranceDet.fromJson(v));
      });
    }
    if (json['beauty_detail'] != null) {
      beautyDetail = <BeautyDetail>[];
      json['beauty_detail'].forEach((v) {
        beautyDetail!.add(BeautyDetail.fromJson(v));
      });
    }
    if (json['swimwear_detail'] != null) {
      swimwearDetail = <SwimwearDetail>[];
      json['swimwear_detail'].forEach((v) {
        swimwearDetail!.add(SwimwearDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (luggageDetail != null) {
      data['luggage_detail'] =
          luggageDetail!.map((v) => v.toJson()).toList();
    }
    if (insuranceDet != null) {
      data['insurance_det'] =
          insuranceDet!.map((v) => v.toJson()).toList();
    }
    if (beautyDetail != null) {
      data['beauty_detail'] =
          beautyDetail!.map((v) => v.toJson()).toList();
    }
    if (swimwearDetail != null) {
      data['swimwear_detail'] =
          swimwearDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LuggageDetail {
  String? partnerName;
  String? partnerImage;
  String? partnerLink;

  LuggageDetail({this.partnerName, this.partnerImage, this.partnerLink});

  LuggageDetail.fromJson(Map<String, dynamic> json) {
    partnerName = json['partner_name'];
    partnerImage = json['partner_image'];
    partnerLink = json['partner_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partner_name'] = partnerName;
    data['partner_image'] = partnerImage;
    data['partner_link'] = partnerLink;
    return data;
  }
}
class InsuranceDet {
  String? partnerName;
  String? partnerImage;
  String? partnerLink;

  InsuranceDet({this.partnerName, this.partnerImage, this.partnerLink});

  InsuranceDet.fromJson(Map<String, dynamic> json) {
    partnerName = json['partner_name'];
    partnerImage = json['partner_image'];
    partnerLink = json['partner_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partner_name'] = partnerName;
    data['partner_image'] = partnerImage;
    data['partner_link'] = partnerLink;
    return data;
  }
}
class BeautyDetail {
  String? partnerName;
  String? partnerImage;
  String? partnerLink;

  BeautyDetail({this.partnerName, this.partnerImage, this.partnerLink});

  BeautyDetail.fromJson(Map<String, dynamic> json) {
    partnerName = json['partner_name'];
    partnerImage = json['partner_image'];
    partnerLink = json['partner_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partner_name'] = partnerName;
    data['partner_image'] = partnerImage;
    data['partner_link'] = partnerLink;
    return data;
  }
}
class SwimwearDetail {
  String? partnerName;
  String? partnerImage;
  String? partnerLink;

  SwimwearDetail({this.partnerName, this.partnerImage, this.partnerLink});

  SwimwearDetail.fromJson(Map<String, dynamic> json) {
    partnerName = json['partner_name'];
    partnerImage = json['partner_image'];
    partnerLink = json['partner_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partner_name'] = partnerName;
    data['partner_image'] = partnerImage;
    data['partner_link'] = partnerLink;
    return data;
  }
}

