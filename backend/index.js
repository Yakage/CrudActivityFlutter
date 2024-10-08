require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const userRoutes = require("./routers/user_routes");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use("/api", userRoutes);

const mongoose = require("mongoose");

mongoose
    .connect("mongodb+srv://Benedict:dBbVYoeXczUsGEZ4@ishkolarium.n4c2z.mongodb.net/?retryWrites=true&w=majority&appName=Ishkolarium")
    .then(() => console.log("MongoDB connected"))
    .catch((error) => console.log("MongoDB connection error:", error));

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
