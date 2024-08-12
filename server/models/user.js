const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  fullName: {
    type: String,
    trim: true,
    default: "",
  },
  userName: {
    type: String,
    trim: true,
    default: "",
  },
  Bio: {
    type: String,
    trim: true,
    default: "",
  },
  profileImage: {
    type: String,
    trim: true,
    default: "",
  },
  profileCover: {
    type: String,
    trim: true,
    default: "",
  },
  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (val) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return val.match(re);
      },
      message: "Enter a valid email address",
    },
  },
  password: {
    type: String,
    required: true,
    validate: {
      validator: (val) => {
        return val.length > 6;
      },
      message: "Enter a long password",
    },
  },
  DateOfBirth: {
    type: Date,
    default: Date.now,
  },
  phoneNumber: {
    type: Number,
    default: 0,
  },
  freinds: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      default: [],
    },
  ],
  freindsRequests: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      default: [],
    },
  ],
  likedPage: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      default: [],
    },
  ],
  followedGroups: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      default: [],
    },
  ],
});

const User = mongoose.model("User", userSchema);

module.exports = User;
