class ProductUnitsModel {
  String? uid;
  String? prodid;
  String? boxnme;
  String? boxqty;

  ProductUnitsModel({this.uid, this.prodid, this.boxnme, this.boxqty});

  ProductUnitsModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    prodid = json['prodid'];
    boxnme = json['boxnme'];
    boxqty = json['boxqty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['prodid'] = this.prodid;
    data['boxnme'] = this.boxnme;
    data['boxqty'] = this.boxqty;
    return data;
  }
}