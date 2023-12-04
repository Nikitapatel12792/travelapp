class NotinumberModal {
  int? status;
  int? totalNewMsg;

  NotinumberModal({this.status, this.totalNewMsg});

  NotinumberModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalNewMsg = json['total_new_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['total_new_msg'] = totalNewMsg;
    return data;
  }
}
