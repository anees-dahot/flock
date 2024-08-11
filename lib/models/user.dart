// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String id;
  String fullName;
  String userName;
  String bio;
  String profileImage;
  String email;
  String password;
  int phoneNumbder;
  DateTime dateOfBirth;
  List<String> followers;
  List<String> following;
  UserModel({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.bio,
    required this.profileImage,
    required this.email,
    required this.password,
    required this.phoneNumbder,
    required this.dateOfBirth,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'userName': userName,
      'bio': bio,
      'profileImage': profileImage,
      'email': email,
      'password': password,
      'phoneNumbder': phoneNumbder,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      userName: map['userName'] as String,
      bio: map['bio'] as String,
      profileImage: map['profileImage'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phoneNumbder: map['phoneNumbder'] as int,
      dateOfBirth:
          DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int),
      followers: List<String>.from((map['followers'] as List<String>)),
      following: List<String>.from(map['following'] as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [
        id,
        fullName,
        userName,
        bio,
        profileImage,
        email,
        password,
        phoneNumbder,
        dateOfBirth,
        followers,
        following,
      ];
}
