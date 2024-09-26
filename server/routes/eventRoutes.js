const {
  authenticateToken,
  authenticateUserRole,
} = require("../middlewares/authenticate");

const {
  createEvent,
  createSubEvent,
  getAllEvents,
  deleteEvent,
} = require("../controllers/eventController");

const express = require("express");
const router = express.Router();

router.post(
  "/createEvent",
  authenticateToken,
  authenticateUserRole,
  createEvent
);
router.post(
  "/createSubEvent",
  authenticateToken,
  authenticateUserRole,
  createSubEvent
);
router.delete(
  "/delete",
  authenticateToken,
  authenticateUserRole,
  deleteEvent
)
router.get("/", authenticateToken, authenticateUserRole, getAllEvents);

module.exports = router;
