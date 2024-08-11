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
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.status(200).json({token, user});
    console.log({token, user});
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//* get user data
authRouter.get("/", async (req, res) => {
  const user = await User.find();
  res.json({ user });
});
authRouter.get("/user", async (req, res) => {
  const user = await User.find();
  res.json(user);
});

module.exports = authRouter;
