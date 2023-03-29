class CreateUserModel {
  String? phoneExt;
  String? phone;
  String? password;
 // String? emailId;
  String? firstName;
  String? lastName;
  String? language;
  String? city;
  String? state;
  String? country;
  // String? dob;

  CreateUserModel(
      {this.phoneExt,
        this.phone,
        this.password,
      //  this.emailId,
        this.firstName,
        this.lastName,
        this.language,
        this.city,
        this.state,
        this.country,
      // this.dob
      });

  CreateUserModel.fromJson(Map<String, dynamic> json) {
    phoneExt = json['phone_ext'];
    phone = json['phone'];
    password = json['password'];
   // emailId = json['email_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    language = json['language'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    // dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_ext'] = this.phoneExt;
    data['phone'] = this.phone;
    data['password'] = this.password;
   // data['email_id'] = this.emailId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['language'] = this.language;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    // data['dob'] = this.dob;
    return data;
  }
}