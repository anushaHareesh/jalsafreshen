class Balance {
  String? code;
  double? ba;

  Balance({this.code, this.ba});

  Balance.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    ba = double.parse(json['ba']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['ba'] = this.ba;
    return data;
  }
}
