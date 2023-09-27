class AccountHead {
  String? code;
  String? hname;
  String? gtype;
  String? ad1;
  String? ad2;
  String? ad3;
  String? aid;
  String? ph;
  String? ba;
  String? ri;
  String? rc;
  String? ht;
  String? mo;
  String? gst;
  String? ac;
  String? cag;

  AccountHead(
      {this.code,
      this.hname,
      this.gtype,
      this.ad1,
      this.ad2,
      this.ad3,
      this.aid,
      this.ph,
      this.ba,
      this.ri,
      this.rc,
      this.ht,
      this.mo,
      this.gst,
      this.ac,
      this.cag});

  AccountHead.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    hname = json['hname'];
    gtype = json['gtype'];
    ad1 = json['ad1'];
    ad2 = json['ad2'];
    ad3 = json['ad3'];
    aid = json['aid'];
    ph = json['ph'];
    ba = json['ba'];
    ri = json['ri'];
    rc = json['rc'];
    ht = json['ht'];
    mo = json['mo'];
    gst = json['gst'];
    ac = json['ac'];
    cag = json['cag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['hname'] = this.hname;
    data['gtype'] = this.gtype;
    data['ad1'] = this.ad1;
    data['ad2'] = this.ad2;
    data['ad3'] = this.ad3;
    data['aid'] = this.aid;
    data['ph'] = this.ph;
    data['ba'] = this.ba;
    data['ri'] = this.ri;
    data['rc'] = this.rc;
    data['ht'] = this.ht;
    data['mo'] = this.mo;
    data['gst'] = this.gst;
    data['ac'] = this.ac;
    data['cag'] = this.cag;
    return data;
  }
}
