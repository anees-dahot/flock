const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

//* SIGN UP
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 9);

    let user = new User({
      email,
      password: hashedPassword,
    });
    user = await user.save();
    res.json(user);
    console.log(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
    console.log(e.message);
  }
});

//* Sign In Route
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      const msg = "Incorrect password.";
      return res.status(400).json({ msg });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.status(200).json({ token, user });
    console.log({ token, user });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//* Create account
authRouter.post("/api/create-account", auth, async (req, res) => {
  try {
    const {
      fullName,
      userName,
      Bio,
      profileImage,
      profileCover,
      phoneNumber,
      dateOfBirth,
    } = req.body;

    const id = req.user;

    const user = await User.findById(id);

    if (!user) {
      return res.status(404).send({ error: "User not found" });
    }
    user.fullName = fullName;
    user.userName = userName;
    user.Bio = Bio;
    user.profileImage = profileImage;
    user.profileCover = profileCover;
    user.phoneNumber = phoneNumber;
    user.dateOfBirth = dateOfBirth;

    user.save();

    res.status(200).json({ user });
    console.log({ user });
  } catch (error) {
    res.status(400).send({ error: error.message });
    console.log(error.message);
  }
});

//* Get suggested friends
authRouter.get("/api/suggested-friends", auth, async (req, res) => {
  const userId = req.user; // Get the authenticated user's ID
  const users = await User.find({ _id: { $ne: userId } }).limit(20); // Exclude the authenticated user
  res.status(200).json(users);
});

module.exports = authRouter;