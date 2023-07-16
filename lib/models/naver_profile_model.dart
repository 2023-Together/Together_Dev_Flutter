class NaverProfileModel {
  String id;
  String name;
  String email;
  String gender;
  String birthday;
  String birthyear;
  String mobile;

  NaverProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.birthday,
    required this.birthyear,
    required this.mobile,
  });

  NaverProfileModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        gender = json['gender'],
        birthday = json['birthday'],
        birthyear = json['birthyear'],
        mobile = json['mobile'];
}
