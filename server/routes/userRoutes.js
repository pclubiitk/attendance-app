const {
  registerUser,
  login,
  userEvents,
  getAttendance,
  markAttendance,
} = require("../controllers/userController");

const express = require("express");
const router = express.Router();

router.post("/register", registerUser);
router.post("/login", login);
router.post("/events", userEvents);
router.post("/attendance", getAttendance);
router.post("/markattendance", markAttendance);

module.exports = router;