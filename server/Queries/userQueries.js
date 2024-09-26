const prisma = require("../db/prisma");
const bcrypt = require("bcrypt");

const createUser = async (req, callback) => {
  try {
    const existingUser = await getUser(req.body.employee_id);
    if (existingUser) {
      return callback({ error: "User already exists", code: 403 });
    }
    const salt = await bcrypt.genSalt(10);
    const password = await bcrypt.hash(req.body.password, salt);
    const user = await prisma.user.create({
      data: {
        role: req.body.role,
        profile: {
          create: {
            employeeId: req.body.employee_id,
            name: req.body.name,
            position: req.body.position,
            password: password,
          },
        },
      },
      include: {
        profile: {
          select: {
            employeeId: true,
            name: true,
            position: true,
          },
        },
      },
    });
    callback(null, user); // Successful creation
  } catch (error) {
    callback({ error: "Bad Request", code: 400 }); // Error handling
  }
};

const getUsers = async () => {
  try {
    const users = await prisma.user.findMany({
      include: {
        profile: true,
      },
    });
    return users;
  } catch (error) {
    console.log(error);
  }
};

const getUser = async (employeeId) => {
  try {
    const user = await prisma.user.findFirst({
      where: {
        profile: {
          employeeId,
        },
      },
      include: {
        profile: true,
        events: true,
      },
    });
    return user;
  } catch (error) {
    console.log(error);
    return null;
  }
};

const getUserAttendance = async (employeeId) => {
  try {
    const user = await prisma.user.findFirst({
      where: {
        profile: {
          employeeId,
        },
      },
      include: {
        Attendance: true,
      },
    });
    return user;
  } catch (error) {
    console.log(error);
    return null;
  }
};
const getUserEvents = async (employeeId) => {
  try {
    const user = await getUser(employeeId);
    if (user === null) {
      return { error: { msg: "No profile found", code: 404 }, events: null };
    }
    // get all events
    const events = await prisma.event.findMany({
      where: {
        id: {
          in: user.events.map((event) => event.id),
        },
      },
      include: {
        location: true,
        subEvents: true,
        assignedOfficers: true,
      },
    });
    return { error: null, events };
  } catch (err) {
    console.error(err.message);
    return { error: { error: "Server Error", code: 500 }, events: null };
  }
};

module.exports = {
  createUser,
  getUsers,
  getUser,
  getUserEvents,
  getUserAttendance,
};
