class UserTypeModel {
  String? uid;
  String? unme;
  String? upwd;
  String? status;

  UserTypeModel({this.uid, this.unme, this.upwd, this.status});

  UserTypeModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    unme = json['unme'];
    upwd = json['upwd'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['unme'] = this.unme;
    data['upwd'] = this.upwd;
    data['status'] = this.status;
    return data;
  }
}