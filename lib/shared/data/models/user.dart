import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String firstName;
  String lastName;
  int age;
  String gender;
  String email;
  String phone;
  String username;
  String password;
  String birthDate;
  String image;
  String bloodGroup;
  String eyeColor;
  String ip;
  Address address;
  String university;
  String role;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.eyeColor,
    required this.ip,
    required this.address,
    required this.university,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    age: json["age"],
    gender: json["gender"],
    email: json["email"],
    phone: json["phone"],
    username: json["username"],
    password: json["password"],
    birthDate: json["birthDate"],
    image: json["image"],
    bloodGroup: json["bloodGroup"],
    eyeColor: json["eyeColor"],
    ip: json["ip"],
    address: Address.fromJson(json["address"]),
    university: json["university"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "age": age,
    "gender": gender,
    "email": email,
    "phone": phone,
    "username": username,
    "password": password,
    "birthDate": birthDate,
    "address": address.toJson(),
    "role": role,
  };
}

class Address {
  String address;
  String city;
  String state;
  String stateCode;
  String postalCode;
  String country;

  Address({
    required this.address,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    city: json["city"],
    state: json["state"],
    stateCode: json["stateCode"],
    postalCode: json["postalCode"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "city": city,
    "state": state,
    "stateCode": stateCode,
    "postalCode": postalCode,
    "country": country,
  };
}
