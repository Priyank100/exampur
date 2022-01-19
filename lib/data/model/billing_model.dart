class BillingModel {
  String? name;
  String? eMail;
  String? mobile;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;

  String? itemName;
  String? itemAmount;

  BillingModel(this.name, this.eMail, this.mobile, this.address, this.city, this.state, this.country,
      this.pincode, this.itemName, this.itemAmount);

  BillingModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    eMail = json['eMail'];
    mobile = json['mobile'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    itemName = json['itemName'];
    itemAmount = json['itemAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['eMail'] = this.eMail;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['itemName'] = this.itemName;
    data['itemAmount'] = this.itemAmount;
    return data;
  }

}