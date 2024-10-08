const express = require("express");
const User = require("../models/user");
const accountRouter = express.Router();
const auth = require("../middlewares/auth");

//* Create account
accountRouter.post("/api/create-account", auth, async (req, res) => {
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
accountRouter.get("/api/suggested-friends", auth, async (req, res) => {
  try {
    const userId = req.user;
    const users = await User.find({ _id: { $ne: userId } }).limit(20);
    res.status(200).json(users);
    console.log(users);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//* Send friends request
accountRouter.post(
  "/api/send-friend-request/:userId",
  auth,
  async (req, res) => {
    try {
      const { userId } = req.params;
      const user = await User.findById(userId);
      if (!user) return res.status(400).json({ msg: "User does not exist!" });
      user.friendsRequests.push(req.user);
      await user.save();
      res.status(200).json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
      console.log(e.message);
    }
  }
);

//* Get friends request
accountRouter.get("/api/get-friend-requests", auth, async (req, res) => {
  try {
    const userId = req.user;
    const user = await User.findById(userId).populate("friendsRequests");
    if (!user) return res.status(400).json({ msg: "User does not exist!" });
    const friendsRequests = user.friendsRequests;
    if (friendsRequests.length === 0)
      return res.status(400).json({ msg: "No friend requests." });
    res.status(200).json(friendsRequests);
    console.log(user.friendsRequests);
  } catch (e) {
    res.status(500).json({ error: e.message });
    console.log(e.message);
  }
});

//* Get friends
accountRouter.get("/api/get-friends/:userId", auth, async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await User.findById(userId).populate("friends");
    if (!user) return res.status(400).json({ msg: "User does not exist!" });
    const friends = user.friends;
    if (friends.length === 0)
      return res.status(400).json({ msg: "No friends." });
    res.status(200).json(friends);
    console.log(user.friends);
  } catch (e) {
    res.status(500).json({ error: e.message });
    console.log(e.message);
  }
});

//* Accept friends request
accountRouter.post(
  "/api/accept-friend-requests/:userId",
  auth,
  async (req, res) => {
    try {
      const userId = req.user;
      const requestUserId = req.params.userId;
      const user = await User.findById(userId);
      const requestUser = await User.findById(requestUserId);
      if (!user) return res.status(400).json({ msg: "User does not exist!" });
      user.friends.push(requestUserId);
      await User.findByIdAndUpdate(userId, {
        $pull: { friendsRequests: requestUserId },
      });
      await user.save();
      requestUser.friends.push(userId);
      await requestUser.save();
      const userWithRequests = await User.findById(userId).populate(
        "friendsRequests"
      );
      const requests = userWithRequests.friendsRequests;

      res
        .status(200)
        .json({ message: "Request accepted!", friendRequests: requests });
      console.log(requests);
    } catch (e) {
      res.status(500).json({ error: e.message });
      console.log(e.message);
    }
  }
);

//* Delete friends request
accountRouter.post(
  "/api/delete-friend-request/:userId",
  auth,
  async (req, res) => {
    try {
      const userId = req.params.userId;
      const myUser = req.user;
      await User.findByIdAndUpdate(myUser, {
        $pull: { friendsRequests: userId },
      });

      const updatedUser = await User.findById(myUser).populate(
        "friendsRequests"
      );
      const requests = updatedUser.friendsRequests;

      res.status(200).json({ requests });
      console.log(requests);
    } catch (e) {
      res.status(500).json({ error: e.message });
      console.log(e.message);
    }
  }
);

//* Check friends requests status
accountRouter.post(
  "/api/check-friend-requests/:userId",
  auth,
  async (req, res) => {
    try {
      const { userId } = req.params;
      const user = await User.findById(userId);
      if (!user) return res.status(400).json({ msg: "User does not exist!" });
      const isRequestSent = user.friendsRequests.includes(req.user);

      res.status(200).json({ isRequestSent });
    } catch (e) {
      res.status(500).json({ error: e.message });
      console.log(e.message);
    }
  }
);

module.exports = accountRouter;
