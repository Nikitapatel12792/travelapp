class MessageModal {
  int? status;
  String? message;
  List<Data>? data;

  MessageModal({this.status, this.message, this.data});

  MessageModal.fromJson(Map<String, dynamic> json) {
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
  String? chatId;
  String? fromUserId;
  String? toUserId;
  String? message;
  String? messageType;
  String? status;
  String? date;

  Data(
      {this.chatId,
        this.fromUserId,
        this.toUserId,
        this.message,
        this.messageType,
        this.status,
        this.date});

  Data.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    fromUserId = json['from_user_id'];
    toUserId = json['to_user_id'];
    message = json['message'];
    messageType = json['message_type'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_id'] = chatId;
    data['from_user_id'] = fromUserId;
    data['to_user_id'] = toUserId;
    data['message'] = message;
    data['message_type'] = messageType;
    data['status'] = status;
    data['date'] = date;
    return data;
  }
}