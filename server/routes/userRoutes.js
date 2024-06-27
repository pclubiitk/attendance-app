import { login, markAttendance, registerUser } from "../controllers/userController";
import { authenticate } from "../middlewares/authenticate";
import { keyImageValidator } from "../middlewares/inputValidation";

const express = require("express");

const router = express.Router();

router.post("/login",login);
router.post("registerUser",keyImageValidator ,registerUser);
router.post("markAttendance",authenticate,markAttendance);

module.exports = router;