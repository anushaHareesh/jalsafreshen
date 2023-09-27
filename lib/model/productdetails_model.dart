class ProductDetails {
  String? code;
  String? pid;

  String? ean;
  String? item;
  String? unit;
  String? categoryId;
  String? companyId;
  String? stock;
  String? hsn;
  String? tax;
  String? prate;
  String? mrp;
  String? cost;
  String? rate1;
  String? rate2;
  String? rate3;
  String? rate4;
  String? priceFlag;

  ProductDetails(
      {this.code,
      this.pid,
      this.ean,
      this.item,
      this.unit,
      this.categoryId,
      this.companyId,
      this.stock,
      this.hsn,
      this.tax,
      this.prate,
      this.mrp,
      this.cost,
      this.rate1,
      this.rate2,
      this.rate3,
      this.rate4,
      this.priceFlag});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    pid = json['pid'];
    ean = json['ean'];
    item = json['item'];
    unit = json['unit'];
    categoryId = json['category_id'];
    companyId = json['company_id'];
    stock = json['stock'];
    hsn = json['hsn'];
    tax = json['tax'];
    prate = json['prate'];
    mrp = json['mrp'];
    cost = json['cost'];
    rate1 = json['rate1'];
    rate2 = json['rate2'];
    rate3 = json['rate3'];
    rate4 = json['rate4'];
    priceFlag = json['price_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['pid'] = this.pid;
    data['ean'] = this.ean;
    data['item'] = this.item;
    data['unit'] = this.unit;
    data['category_id'] = this.categoryId;
    data['company_id'] = this.companyId;
    data['stock'] = this.stock;
    data['hsn'] = this.hsn;
    data['tax'] = this.tax;
    data['prate'] = this.prate;
    data['mrp'] = this.mrp;
    data['cost'] = this.cost;
    data['rate1'] = this.rate1;
    data['rate2'] = this.rate2;
    data['rate3'] = this.rate3;
    data['rate4'] = this.rate4;
    data['price_flag'] = this.priceFlag;
    return data;
  }
}