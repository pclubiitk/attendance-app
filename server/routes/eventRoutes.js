const { createEvent } = require("../controllers/eventController");

const express = require("express");
const router = express.Router();

router.post("/createEvent", createUser);
