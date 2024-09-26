const { getUser } = require("./userQueries");

const prisma = require("../db/prisma");

const createEvent = async (title, description, date, location) => {
  try {
    const newEvent = await prisma.event.create({
      data: {
        title,
        description,
        date,
        location: {
          create: {
            locationName: location["locationName"],
            xCoordinate: location["xCoordinate"],
            yCoordinate: location["yCoordinate"],
          },
        },
      },
      include: {
        location: true,
      },
    });
    console.log("Event Created: " + newEvent);
    // FIXME: you made the return newEvent in {newEvent} format, why?
    return newEvent;
  } catch (error) {
    console.log(`Error creating event ${error}`);
    throw new Error("Error creating Event");
  }
};
const assignUsers = async (eventId, userIds) => {
  try {
    // Fetch user IDs from getUser in parallel
    const userIdPromises = userIds.map((userId) => getUser(userId));
    const users = await Promise.all(userIdPromises);
    const userIdsToConnect = users.map((user) => ({ id: user.id }));

    const updatedEvent = await prisma.event.update({
      where: {
        id: eventId,
      },
      data: {
        assignedOfficers: {
          // FIXME: this will not work as the userId is the employe id
          connect: userIdsToConnect,
        },
      },
    });
    console.log(`Users assigned to event ${updatedEvent}`);
    // FIXME: changed {updatedEvent} in updatedEventformat
    return updatedEvent;
  } catch (error) {
    console.log(`Error Updating the Event: ${error}`);
    throw new Error("Error Assigning Users");
  }
};
const linkSubEvent = async (parentEventId, subEventId) => {
  try {
    const subEvent = await prisma.event.update({
      where: { id: subEventId },
      data: {
        parentEvent: {
          connect: { id: parentEventId },
        },
      },
    });
    console.log(`SubEvent Linked Successfully`);
    return { subEvent };
  } catch (error) {
    console.log(`Error Linking SubEvent ${error}`);
    throw new Error("Error Linking Sub Event");
  }
};
const getEvents = async () => {
  try {
    const events = await prisma.event.findMany({
      include: {
        location: true,
        subEvents: true,
        assignedOfficers: true,
      },
    });
    return events;
  } catch (error) {
    throw new Error("Error fetching events");
  }
};
const getEvent = async (eventId) => {
  try {
    const event = await prisma.event.findUnique({
      where: {
        id: eventId,
      },
      include: {
        location: true,
        subEvents: true,
        assignedOfficers: true,
      },
    });
    return { event };
  } catch (error) {
    throw new Error("Error fetching event");
  }
};
const deleteEvent = async (eventId) => {
  try {
    await prisma.event.deleteMany({
      where: {
        parentEventId: eventId,
      },
    });
    await prisma.event.delete({
      where: {
        id: eventId,
      },
    });
    return { success: "Events deleted successfully" };
  } catch (error) {
    throw new Error("Error deleting Event");
  }
};

module.exports = {
  createEvent,
  assignUsers,
  linkSubEvent,
  getEvents,
  getEvent,
  deleteEvent,
};
