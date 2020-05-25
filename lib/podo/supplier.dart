class Supplier {
  String img;
  bool isFav;
  String name;
  String scategory;
  String email;
  String phone;
  String address;
  String srate; //needed for ranking
  String yearsxp; //needed for ranking
  String bio;
  String avail; //needed for ranking
  bool verified; //needed for ranking

  Supplier(
      {this.img,
        this.isFav,
        this.name,
        this.scategory,
        this.email,
        this.phone,
        this.address,
        this.srate, //needed for ranking
        this.yearsxp, //needed for ranking
        this.bio, 
        this.avail, //needed for ranking
        this.verified}); //needed for ranking

  Supplier.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    isFav = json['isFav'];
    name = json['name'];
    scategory = json['scategory'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    srate = json['srate'];
    yearsxp = json['yearsxp'];
    bio = json['bio'];
    avail = json['avail'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['isFav'] = this.isFav;
    data['name'] = this.name;
    data['scategory'] = this.scategory;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['srate'] = this.srate;
    data['yearsxp'] = this.yearsxp;
    data['bio'] = this.bio;
    data['avail'] = this.avail;
    data['verified'] = this.verified;
    return data;
  }
}
