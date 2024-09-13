import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:flock/models/user.dart';

class Post extends Equatable {
  final String? id;
  final UserModel? userPosted;
  final String? postText;
  final List<PostReact>? postReacts;
  final List<String>? postImages;
  final List<String>? postVideos;
  final DateTime? postedAt;
  final String? privacy;
  final int? totalReacts;
  final int? totalComments;
  final int? totalShares;
  final List<Comment>? comments;

  const Post({
    this.id,
    this.userPosted,
    this.postText,
    this.postReacts,
    this.postImages,
    this.postVideos,
    this.postedAt,
    this.privacy,
    this.totalReacts,
    this.totalComments,
    this.totalShares,
    this.comments,
  });

  factory Post.fromJson(String source) => Post.fromMap(jsonDecode(source));

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['_id'],
      userPosted: map['userPosted'] != null
          ? UserModel.fromMap(map['userPosted'])
          : null,
      postText: map['postText'],
      postReacts: map['postReacts'] != null
          ? List<PostReact>.from(
              map['postReacts']?.map((x) => PostReact.fromMap(x)))
          : null,
      postImages: map['postImages'] != null
          ? List<String>.from(map['postImages'])
          : null,
      postVideos: map['postVideos'] != null
          ? List<String>.from(map['postVideos'])
          : null,
      postedAt:
          map['postedAt'] != null ? DateTime.parse(map['postedAt']) : null,
      privacy: map['privacy'],
      totalReacts: map['totalReacts'],
      totalComments: map['totalComments'],
      totalShares: map['totalShares'],
      comments: map['comments'] != null
          ? List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userPosted': userPosted,
      'postText': postText,
      'postReacts': postReacts?.map((x) => x.toMap()).toList(),
      'postImages': postImages,
      'postVideos': postVideos,
      'postedAt': postedAt?.toIso8601String(),
      'privacy': privacy,
      'totalReacts': totalReacts,
      'totalComments': totalComments,
      'totalShares': totalShares,
      'comments': comments?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [
        id,
        userPosted,
        postText,
        postReacts,
        postImages,
        postVideos,
        postedAt,
        privacy,
        totalReacts,
        totalComments,
        totalShares,
        comments,
      ];
}

class PostReact extends Equatable {
  final String? icon;
  final String? text;
  final String? userId;

  const PostReact({
    this.icon,
    this.text,
    this.userId,
  });

  factory PostReact.fromMap(Map<String, dynamic> map) {
    return PostReact(
      icon: map['icon'],
      text: map['text'],
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'text': text,
      'userId': userId,
    };
  }

  @override
  List<Object?> get props => [icon, text, userId];
}

class Comment extends Equatable {
  final String? id;
  final String? user;
  final String? commentText;
  final DateTime? commentedAt;
  final List<String>? commentsLikes;
  final List<CommentReply>? replies;

  const Comment({
    this.id,
    this.user,
    this.commentText,
    this.commentedAt,
    this.commentsLikes,
    this.replies,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['_id'],
      user: map['user'],
      commentText: map['commentText'],
      commentedAt: map['commentedAt'] != null
          ? DateTime.parse(map['commentedAt'])
          : null,
      commentsLikes: map['commentsLikes'] != null
          ? List<String>.from(map['commentsLikes'])
          : null,
      replies: map['replies'] != null
          ? List<CommentReply>.from(
              map['replies'].map((x) => CommentReply.fromMap(x)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user': user,
      'commentText': commentText,
      'commentedAt': commentedAt?.toIso8601String(),
      'commentsLikes': commentsLikes,
      'replies': replies?.map((x) => x.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        user,
        commentText,
        commentedAt,
        commentsLikes,
        replies,
      ];
}

class CommentReply extends Equatable {
  final String? id;
  final String? user;
  final String? replyText;
  final DateTime? repliedAt;

  const CommentReply({
    this.id,
    this.user,
    this.replyText,
    this.repliedAt,
  });

  factory CommentReply.fromMap(Map<String, dynamic> map) {
    return CommentReply(
      id: map['_id'],
      user: map['user'],
      replyText: map['replyText'],
      repliedAt:
          map['repliedAt'] != null ? DateTime.parse(map['repliedAt']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user': user,
      'replyText': replyText,
      'repliedAt': repliedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        user,
        replyText,
        repliedAt,
      ];
}
