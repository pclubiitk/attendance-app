const EventQueries = require("../Queries/eventQueries");

const createEvent = async (req, res) => {
  try {
    // FIXME: destructuring as array why? what do you expect in input?
    const { title, description, date, locationName, xCoordinate, yCoordinate } =
      req.body;
    console.log(title);
    const location = {
      locationName,
      xCoordinate,
      yCoordinate,
    };
    const event = await EventQueries.createEvent(
      title,
      description,
      date,
      location
    );
    console.log(event);
    if (event) {
      const { userIds } = req.body;
      const updatedEvent = await EventQueries.assignUsers(event.id, userIds);
      if (updatedEvent) {
        res.status(200).json({ message: "Event Created Successfully" });
      } else {
        throw new Error("Error Assigning Users");
      }
    } else {
      throw new Error("Error Creating Event");
    }
  } catch (error) {
    res.status(500).json({ message: "Error Creating Event", error });
  }
};

// TODO: Break the create and the subevent creation into separate functions, a
// TODO: as if the error occurs in between, the event is created but can never be used
const createSubEvent = async (req, res) => {
  try {
    // FIXME: Why array?
    const { title, description, date, locationName, xCoordinate, yCoordinate } =
      req.body;
    const location = {
      locationName,
      xCoordinate,
      yCoordinate,
    };
    const event = await EventQueries.createEvent(
      title,
      description,
      date,
      location
    );
    if (event) {
      const { userIds } = req.body;
      const updatedEvent = await EventQueries.assignUsers(event.id, userIds);
      if (updatedEvent) {
        const { parentEventId } = req.body;
        const subEvent = await EventQueries.linkSubEvent(
          parentEventId,
          updatedEvent.id
        );
        if (subEvent) {
          res.status(200).json({ message: "Event Created Successfully" });
        } else {
          throw new Error("Error linking parent and SubEvent");
        }
      } else {
        throw new Error("Error Assigning Users");
      }
    } else {
      throw new Error("Error Creating Event");
    }
  } catch (error) {
    res.status(500).json({ message: "Error Creating Event", error });
  }
};

const getAllEvents = async (req, res) => {
  try {
    const events = await EventQueries.getEvents();
    if (events) {
      res.status(200).json({ events });
    } else {
      throw new Error("Error fetching Events");
    }
  } catch (error) {
    res.status(500).json({ error });
  }
};

const deleteEvent = async (req, res) => {
  try {
    const { eventId } = req.body;
    const event = await EventQueries.deleteEvent(eventId);
    if (event) {
      res.status(200).json({ message: "Event Deleted Successfully" });
    } else {
      throw new Error("Error Deleting Event");
    }
  } catch (error) {
    res.status(500).json({ message: "Error Deleting Event", error });
  }
};

module.exports = {
  createEvent,
  createSubEvent,
  getAllEvents,
  deleteEvent,
};
