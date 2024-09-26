const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const {
  createUser,
  getUser,
  getUserEvents,
  getUserAttendance,
} = require("../Queries/userQueries");
var currentdate = new Date();

// register new user
const registerUser = async (req, res) => {
  console.log("Register User got hit");
  try {
    await createUser(req, (err, user) => {
      if (err) {
        return res.status(err.code).json({ msg: err.error });
      }
      res.status(200).json({ msg: "User Created", user });
    });
    console.log("User Registered");
  } catch (err) {
    res.status(500).send("Server Error");
  }
};
// login user
const login = async (req, res) => {
  console.log("User LogIn got hit");
  const { employee_id, password } = req.body;
  try {
    // See if user exists
    const user = await getUser(employee_id);
    if (user === null) {
      return res.status(404).json({ msg: "No profile found" });
    }
    // Match password
    const isMatch = await bcrypt.compare(password, user.profile.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Invalid Password" });
    }
    // payload
    const payload = {
      user: {
        userId: user.profile.employeeId,
        role: user.role,
      },
    };
    // Sign the token
    const token = jwt.sign(payload, process.env.JWT_SECRET);
    const literal = "Bearer ".concat(token);
    // send the token
    res.json({
      message: "User Log in successfull",
      token: literal,
    });
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
};
// TODO:
// mark attendance
const markAttendance = async (req, res) => {
  console.log("Mark User Attendance got hit!");
  var {
    id, // user id
    lat,
    log,
    locationName,
  } = req.body;
  console.log(req.body);
  try {
    await prisma.users.update({
      where: {
        id: id,
      },
      data: {
        Attendance: {
          // create new location and add it to attendance
          create: {
            time: currentdate,
            location: {
              // FIXME: IT DONT WORK WITH connectOrCreate but works
              // FIXME: with Create.
              connectOrCreate: {
                locationName: locationName,
                xCoordinate: parseFloat(lat),
                yCoordinate: parseFloat(log),
              },
            },
          },
        },
      },
    });
    res.status(200).send("Marked Attendance!");
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error");
  }
};
// TODO: handle the case of the admin if he uses this route
// returns all events of the user,
const userEvents = async (req, res) => {
  console.log("Get All Events got hit!");
  try {
    const { employeeId } = req.body;
    const { error, events } = await getUserEvents(employeeId);
    if (error) {
      return res.status(error.code).json({ msg: error.msg });
    }
    res.status(200).json({ events });
  } catch (err) {
    console.error(err.message);
    res.status(400).send("Bad Request");
  }
};

// returns attendance history  of the user
const getAttendance = async (req, res) => {
  console.log("Get Attendance got hit!");
  try {
    const { employeeId } = req.body;
    const user = await getUserAttendance(employeeId);
    if (user === null) {
      return res.status(404).json({ msg: "No profile found" });
    }
    res.status(200).json({ Attendance: user.Attendance });
  } catch {
    console.error(err.message);
    res.status(400).send("Bad Request");
  }
};

// Ask Location from all under the event

// last location

module.exports = {
  registerUser,
  login,
  // markAttendance,
  userEvents,
  getAttendance,
  
};
