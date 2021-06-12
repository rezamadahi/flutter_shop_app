enum Gender { Male, Female }

class UserModel {
  int id;
  String fullName;
  String username;
  String password;
  String userImage;
  Gender gender;
  String mobile;
  String email;
  String address;

  UserModel({
    this.id,
    this.fullName,
    this.username,
    this.password,
    this.userImage,
    this.gender,
    this.address,
    this.email,
    this.mobile,
  });

  Map<String, dynamic> toJson() =>
      {
        "full_name": fullName,
        "username": username,
        "password": password,
        "userImage": userImage,
        "gender": gender == Gender.Male ? 1 : 2 ,
        "mobile": mobile,
        "email": email,
        "address": address,
      };


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    fullName: json["full_name"],
    username: json["username"],
    password: json["password"],
    userImage: json["userImage"],
    gender: json["gender"] ==  1 ? Gender.Male : Gender.Female,
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
  );

}
