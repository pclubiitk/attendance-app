import { authenticateToken, authenticateUserRole } from "../middlewares/authenticate";

const { createEvent, createSubEvent, getAllEvents } = require("../controllers/eventController");

const express = require("express");
const router = express.Router();

router.post("/createEvent", authenticateToken, authenticateUserRole, createEvent);
router.post("/createSubEvent", authenticateToken, authenticateUserRole, createSubEvent);
router.get("/", authenticateToken, authenticateUserRole, getAllEvents)