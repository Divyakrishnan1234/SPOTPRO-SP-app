class UserModel {
  String name;
  String url;
  String createdAt;
  String service;
  String desc;
  String phoneNumber;
  String uid;
// List promourl;
  Map review;
  String ln;
  String rate;
  String image;
  String location;
  bool verified;
  bool available;



  UserModel({
    required this.image,
   required this.verified,
    required this.ln,
    required this.name,
    required this.url,
    required this.createdAt,
    required this.service,
    required this.phoneNumber,
    required this.desc,
    required this.uid,
    required this.location,
    required this.rate,
    required this.review,
    required this.available
    // required this.promourl

  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      ln:map['ln']??'',
      verified:map['verified']??'',
      image: map['image']?? '',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      //promourl:map['promourl'],
available: map['available'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      service: map['service'] ?? '',
      desc: map['desc'] ?? '',
      location: map['location'] ?? '',
      rate: map['rate'] ?? '',
      review: map['review'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "ln":ln,
      "verified":verified,
      "name": name,
      "url": url,
      "image":image,
      "available":available,
      // "promourl":promourl,
      "uid": uid,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "service":service,
      "desc":desc,
      "review":review,
      "rate":rate,
      "location":location,
    };
  }
}
