const {createUser} = require("../Queries/userQueries")
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

exports.registerUser = async (req, res) => {
  console.log("Register User got hit");
  const {
    employeeId,
    name,
    position,
    password,
  } = req.body;
  try {
    const salt = await bcrypt.genSalt(10);
    const hashed_password = await bcrypt.hash(password, salt);
    const user = await createUser(employeeId, name, position, hashed_password)
    res.json({ msg: "User added" });
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
};