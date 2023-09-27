class AdminDash {
  String? caption;
  String? cvalue;
  String? color;
  List<Today>? today;

  AdminDash({this.caption, this.cvalue, this.color, this.today});

  AdminDash.fromJson(Map<String, dynamic> json) {
    caption = json['Caption'];
    cvalue = json['Cvalue'];
    color = json['color'];
    if (json['today'] != null) {
      today = <Today>[];
      json['today'].forEach((v) {
        today!.add(new Today.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Caption'] = this.caption;
    data['Cvalue'] = this.cvalue;
    data['color'] = this.color;
    if (this.today != null) {
      data['today'] = this.today!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Today {
  String? group;
  int? tileCount;
  List<Data>? data;

  Today({this.group, this.tileCount, this.data});

  Today.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    tileCount = json['tile_count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    data['tile_count'] = this.tileCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? caption;
  String? cvalue;
  String? color;

  Data({this.caption, this.cvalue});

  Data.fromJson(Map<String, dynamic> json) {
    caption = json['caption'];
    cvalue = json['Cvalue'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caption'] = this.caption;
    data['Cvalue'] = this.cvalue;
    data['color'] = this.color;
    return data;
  }
}
