import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserModel extends Equatable {
  final String id;
  final String fullName;
  final String userName;
  final String bio;
  final String profileImage;
  final String email;
  final String password;
  final int phoneNumber;
  final List<String> followers;
  final List<String> following;
  final DateTime dateOfBirth;

  UserModel({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.bio,
    required this.profileImage,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.followers,
    required this.following,
    required this.dateOfBirth,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      fullName: json['fullName'],
      userName: json['userName'],
      bio: json['Bio'],
      profileImage: json['profileImage'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      followers: List<String>.from(json['followers']),
      following: List<String>.from(json['following']),
      dateOfBirth: DateTime.parse(json['DateOfBirth']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'userName': userName,
      'Bio': bio,
      'profileImage': profileImage,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'followers': followers,
      'following': following,
      'DateOfBirth': dateOfBirth.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        userName,
        bio,
        profileImage,
        email,
        password,
        phoneNumber,
        dateOfBirth,
        followers,
        following,
      ];
}
