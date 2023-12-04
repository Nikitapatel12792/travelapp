class InvoiceModel {
  int? status;
  Data? data;

  InvoiceModel({this.status, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
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
  String? fullCostOfBooking;
  String? paymentMode;
  String? remainingBalance;
  String? dueBy;

  Data(
      {this.fullCostOfBooking,
        this.paymentMode,
        this.remainingBalance,
        this.dueBy});

  Data.fromJson(Map<String, dynamic> json) {
    fullCostOfBooking = json['Full Cost Of Booking'];
    paymentMode = json['Payment Mode'];
    remainingBalance = json['Remaining Balance'];
    dueBy = json['Due By'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Full Cost Of Booking'] = fullCostOfBooking;
    data['Payment Mode'] = paymentMode;
    data['Remaining Balance'] = remainingBalance;
    data['Due By'] = dueBy;
    return data;
  }
}