const express = require("express");
const accountRouter = require("./routes/auth");
const authrouter = require("./routes/account");
const mongoose = require("mongoose");
const app = express();
const PORT = 3000;
app.use(express.json());
app.use(authrouter);
app.use(accountRouter);

mongoose
  .connect(
    "mongodb://anees:anees123@flock-shard-00-00.mzskc.mongodb.net:27017,flock-shard-00-01.mzskc.mongodb.net:27017,flock-shard-00-02.mzskc.mongodb.net:27017/?ssl=true&replicaSet=atlas-ucwjnx-shard-0&authSource=admin&retryWrites=true&w=majority&appName=Flock"
  )
  .then(() => console.log("MongoDB connected successfully!"))
  .catch((err) => console.error(err));

app.get("/send", (req, res) => {
  console.log(req.body);
  res.status(200).json({ no: "anees" });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log("connecting to port " + PORT);
});
