class StaffArea {
  String? aid;
  String? anme;

  StaffArea({this.aid, this.anme});

  StaffArea.fromJson(Map<String, dynamic> json) {
    aid = json['aid'];
    anme = json['anme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aid'] = this.aid;
    data['anme'] = this.anme;
    return data;
  }
}