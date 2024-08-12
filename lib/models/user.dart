// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String fullName;
  final String userName;
  final String bio;
  final String profileImage;
  final String profileCover;
  final String email;
  final String password;
  final DateTime dateOfBirth;
  final int phoneNumber;
  final List<String> friends;
  final List<String> friendsRequests;
  final List<String> likedPage;
  final List<String> followedGroups;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.bio,
    required this.profileImage,
    required this.profileCover,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.friends,
    required this.friendsRequests,
    required this.likedPage,
    required this.followedGroups,
  });

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
      'DateOfBirth': dateOfBirth.toIso8601String(),
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
