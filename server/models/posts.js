const postSchema = new mongoose.Schema({
  userPosted: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
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
      url: { type: String, trim: true },
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
  privacy: {
    type: String,
    default: "public",
  },
  totalReacts: { type: Number, default: 0 },
  totalComments: { type: Number, default: 0 },
  totalShares: { type: Number, default: 0 },
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
      commentsLikes: [
        {
          type: mongoose.Schema.Types.ObjectId,
          ref: "User",
        },
      ],
      replies: [
        {
          user: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
            required: true,
          },
          replyText: {
            type: String,
            required: true,
            trim: true,
          },
          repliedAt: {
            type: Date,
            default: Date.now,
          },
        },
      ],
    },
  ],
});

const Post = mongoose.model("Post", postSchema);
module.exports = Post;
