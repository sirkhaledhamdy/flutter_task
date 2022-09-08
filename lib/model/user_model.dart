import 'package:hive/hive.dart';


class DataModel {
  DataModel({
    required this.users,
    required this.total,
    required this.skip,
    required this.limit,
  });
  late final List<Users> users;
  late final int total;
  late final int skip;
  late final int limit;

  DataModel.fromJson(Map<String, dynamic> json){
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['users'] = users.map((e)=>e.toJson()).toList();
    _data['total'] = total;
    _data['skip'] = skip;
    _data['limit'] = limit;
    return _data;
  }
}


class Users {
  Users({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.eyeColor,
    required this.hair,
    required this.domain,
    required this.ip,
    required this.address,
    required this.macAddress,
    required this.university,
    required this.bank,
    required this.company,
    required this.ein,
    required this.ssn,
    required this.userAgent,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String maidenName;
  late final int age;
  late final String gender;
  late final String email;
  late final String phone;
  late final String username;
  late final String password;
  late final String birthDate;
  late final String image;
  late final String bloodGroup;
  late final int height;
  late final String eyeColor;
  late final Hair hair;
  late final String domain;
  late final String ip;
  late final Address address;
  late final String macAddress;
  late final String university;
  late final Bank bank;
  late final Company company;
  late final String ein;
  late final String ssn;
  late final String userAgent;

  Users.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    maidenName = json['maidenName'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    password = json['password'];
    birthDate = json['birthDate'];
    image = json['image'];
    bloodGroup = json['bloodGroup'];
    height = json['height'];
    eyeColor = json['eyeColor'];
    hair = Hair.fromJson(json['hair']);
    domain = json['domain'];
    ip = json['ip'];
    address = Address.fromJson(json['address']);
    macAddress = json['macAddress'];
    university = json['university'];
    bank = Bank.fromJson(json['bank']);
    company = Company.fromJson(json['company']);
    ein = json['ein'];
    ssn = json['ssn'];
    userAgent = json['userAgent'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['maidenName'] = maidenName;
    _data['age'] = age;
    _data['gender'] = gender;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['username'] = username;
    _data['password'] = password;
    _data['birthDate'] = birthDate;
    _data['image'] = image;
    _data['bloodGroup'] = bloodGroup;
    _data['height'] = height;
    _data['eyeColor'] = eyeColor;
    _data['hair'] = hair.toJson();
    _data['domain'] = domain;
    _data['ip'] = ip;
    _data['address'] = address.toJson();
    _data['macAddress'] = macAddress;
    _data['university'] = university;
    _data['bank'] = bank.toJson();
    _data['company'] = company.toJson();
    _data['ein'] = ein;
    _data['ssn'] = ssn;
    _data['userAgent'] = userAgent;
    return _data;
  }
}

class Hair {
  Hair({
    required this.color,
    required this.type,
  });
  late final String color;
  late final String type;

  Hair.fromJson(Map<String, dynamic> json){
    color = json['color'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['color'] = color;
    _data['type'] = type;
    return _data;
  }
}

class Address {
  Address({
    required this.address,
    required this.city,
    required this.coordinates,
    required this.postalCode,
    required this.state,
  });
  late final String address;
  late final String city;
  late final Coordinates coordinates;
  late final String postalCode;
  late final String state;

  Address.fromJson(Map<String, dynamic> json){
    address = json['address'];
    city = json['city'];
    coordinates = Coordinates.fromJson(json['coordinates']);
    postalCode = json['postalCode'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address'] = address;
    _data['city'] = city;
    _data['coordinates'] = coordinates.toJson();
    _data['postalCode'] = postalCode;
    _data['state'] = state;
    return _data;
  }
}

class Coordinates {
  Coordinates({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Coordinates.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Bank {
  Bank({
    required this.cardExpire,
    required this.cardNumber,
    required this.cardType,
    required this.currency,
    required this.iban,
  });
  late final String cardExpire;
  late final String cardNumber;
  late final String cardType;
  late final String currency;
  late final String iban;

  Bank.fromJson(Map<String, dynamic> json){
    cardExpire = json['cardExpire'];
    cardNumber = json['cardNumber'];
    cardType = json['cardType'];
    currency = json['currency'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cardExpire'] = cardExpire;
    _data['cardNumber'] = cardNumber;
    _data['cardType'] = cardType;
    _data['currency'] = currency;
    _data['iban'] = iban;
    return _data;
  }
}

class Company {
  Company({
    required this.address,
    required this.department,
    required this.name,
    required this.title,
  });
  late final Address address;
  late final String department;
  late final String name;
  late final String title;

  Company.fromJson(Map<String, dynamic> json){
    address = Address.fromJson(json['address']);
    department = json['department'];
    name = json['name'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address'] = address.toJson();
    _data['department'] = department;
    _data['name'] = name;
    _data['title'] = title;
    return _data;
  }
}