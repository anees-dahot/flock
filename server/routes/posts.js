const express = require("express");
const postsRouter = express.Router();
const auth = require("../middlewares/auth");
const Post = require("../models/posts");

postsRouter.post("/api/posts/add-post", auth, async (req, res) => {
  try {
    const userPosted = req.user;
    const { postText, postImages, postVideos, privacy } = req.body;
    const newPost = new Post({
      userPosted,
      postText,
      postImages,
      postVideos,
      privacy,
    });
    await newPost.save();
    res
      .status(200)
      .json({ message: "Post published successfully", post: newPost });
    console.log(newPost);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

postsRouter.get("/api/posts/get-posts", auth, async (req, res) => {
  try {
    const posts = await Post.find({}).populate('userPosted');
    res
      .status(200)
      .json({ message: "Post published successfully", posts: posts });
    console.log(posts);
  } catch (e) {
    res.status(500).json({ error: e.message });
    console.log(e.message)
  }
});

module.exports = postsRouter;
