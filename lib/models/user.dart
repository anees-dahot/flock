// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? fullName;
  final String? userName;
  final String? bio;
  final String? profileImage;
  final String? profileCover;
  final String? email;
  final String? password;
  final int? phoneNumber;
  final List<String>? friends;
  final List<String>? friendsRequests;
  final List<String>? likedPage;
  final List<String>? followedGroups;
  final DateTime? dateOfBirth;

  const UserModel({
    this.id,
    this.fullName,
    this.userName,
    this.bio,
    this.profileImage,
    this.profileCover,
    this.email,
    this.password,
    this.phoneNumber,
    this.friends,
    this.friendsRequests,
    this.likedPage,
    this.followedGroups,
    this.dateOfBirth,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'],
      fullName: map['fullName'],
      userName: map['userName'],
      bio: map['Bio'],
      profileImage: map['profileImage'],
      profileCover: map['profileCover'],
      email: map['email'],
      password: map['password'],
      phoneNumber: map['phoneNumber'],
      friends:
          map['friends'] != null ? List<String>.from(map['friends']) : null,
      friendsRequests: map['friendsRequests'] != null
          ? List<String>.from(map['friendsRequests'])
          : null,
      likedPage:
          map['likedPage'] != null ? List<String>.from(map['likedPage']) : null,
      followedGroups: map['followedGroups'] != null
          ? List<String>.from(map['followedGroups'])
          : null,
      dateOfBirth: map['DateOfBirth'] != null
          ? DateTime.parse(map['DateOfBirth'])
          : null,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      fullName: json['fullName'],
      userName: json['userName'],
      bio: json['Bio'],
      profileImage: json['profileImage'],
      profileCover: json['profileCover'],
      email: json['email'],
      password: json['password'],
      dateOfBirth: DateTime.parse(json['DateOfBirth']),
      phoneNumber: json['phoneNumber'],
      friends: List<String>.from(json['friends']),
      friendsRequests: List<String>.from(json['friendsRequests']),
      likedPage: List<String>.from(json['likedPage']),
      followedGroups: List<String>.from(json['followedGroups']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'userName': userName,
      'Bio': bio,
      'profileImage': profileImage,
      'profileCover': profileCover,
      'email': email,
      'password': password,
      'DateOfBirth': dateOfBirth!.toIso8601String(),
      'phoneNumber': phoneNumber,
      'friends': friends,
      'friendsRequests': friendsRequests,
      'likedPage': likedPage,
      'followedGroups': followedGroups,
    };
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        userName,
        bio,
        profileImage,
        profileCover,
        email,
        password,
        dateOfBirth,
        phoneNumber,
        friends,
        friendsRequests,
        likedPage,
        followedGroups,
      ];
}
