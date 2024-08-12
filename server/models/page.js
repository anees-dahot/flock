const mongoose = require("mongoose");

const pageSchema = mongoose.Schema({
  pageName: {
    type: String,
    trim: true,
    default: "",
  },
  pageCreator: {
    type: String,
    trim: true,
    default: "",
  },
  pageCreatedAt: {
    type: Date,
    default: Date.now,
  },
  pageImage: {
    type: String,
    trim: true,
    default: "",
  },
  pageLikes: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      default: [],
    },
  ],
  posts: {
    type: Array,
    postOwner: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      default: [],
    },
    postText: {
      type: String,
      trim: true,
    },
    postReacts: [
      {
        icon: {
          type: String,
          trim: true,
        },
        text: {
          type: String,
          trim: true,
        },
        userId: {
          type: mongoose.Schema.Types.ObjectId,
          ref: "User",
        },
      },
    ],
    postImages: [
      {
        type: String,
        trim: true,
      },
    ],
    postVideos: [
      {
        type: String,
        trim: true,
      },
    ],
    postedAt: {
      type: Date,
      default: Date.now,
    },
  },
  comments: [
    {
      user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
      },
      commentText: {
        type: String,
        required: true,
        trim: true,
      },
      commentedAt: {
        type: Date,
        default: Date.now,
      },
      commentsLikes: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
      },
    },
  ],
  visibility: {
    type: String,
    enum: ["public", "private", "friends"],
    default: "public",
  },
  tags: {
    type: [String],
    default: [],
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  },
  pageType: {
    type: String,
    enum: ["personal", "business", "community"],
    default: "personal",
  },
});

const Page = mongoose.model("Pages", pageSchema);

module.exports = Page;
