class WalletModal {
  String? waid;
  String? wanme;

  WalletModal({this.waid, this.wanme});

  WalletModal.fromJson(Map<String, dynamic> json) {
    waid = json['waid'];
    wanme = json['wanme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['waid'] = this.waid;
    data['wanme'] = this.wanme;
    return data;
  }
}