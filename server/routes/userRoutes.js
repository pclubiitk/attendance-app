const { login, markAttendance, registerUser } =  require("../controllers/userController.js");
const { authenticate } = require("../middlewares/authenticate.js");
const { keyImageValidator } = require("../middlewares/inputValidation.js");

const express = require('express');

const router = express.Router();

router.post("/login",login);
router.post("/registerUser",keyImageValidator ,registerUser);
router.post("/markAttendance",authenticate,markAttendance);

module.exports = router;