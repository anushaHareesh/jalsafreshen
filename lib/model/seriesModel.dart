class SeriesModel {
  String? orderMaster;
  String? saleMaster;
  String? collection;

  SeriesModel({this.orderMaster, this.saleMaster, this.collection});

  SeriesModel.fromJson(Map<String, dynamic> json) {
    orderMaster = json['order_master'];
    saleMaster = json['sale_master'];
    collection = json['collection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_master'] = this.orderMaster;
    data['sale_master'] = this.saleMaster;
    data['collection'] = this.collection;
    return data;
  }
}