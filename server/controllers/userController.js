const { User, Attendance } = require("../database/models.js");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');



exports.registerUser = async (req, res) => {
  console.log("Register User got hit");
  const {employee_id,name,age,position, blood_group, username, password, keyImage } = req.body;
  try {
    const user = new User({ employee_id, name , age , position , blood_group , username , password , keyImage });

    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(password, salt);

    await user.save();

    res.json({ msg: 'User added' });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
};


exports.login = async (req, res) => {
  console.log("User LogIn got hit");
  const { username, password } = req.body;

  try {
    const user = await User.findOne({username});

    if (!user) {
      return res.status(400).json({ msg: 'Invalid Credentials' });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: 'Invalid Credentials' });
    }

    const payload = {
      user: {
        id: user._id,
        role: 'user'
      }
    };

    const token = jwt.sign(payload,process.env.JWT_SECRET);
    const literal = "Bearer ".concat(token);

    res.json({
      message: "User Log in successfull",
      token: literal
    })

  } 
  catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
};

exports.markAttendance = async(req,res)=>{
  console.log("Mark User Attendance got hit!");
  console.log(req.user);
  const userID = req.user.id;
  try{
    const userAttendance = await Attendance.create({
      userID: userID
    });
    await User.updateOne({
      _id: userID
    },{
      "$push": {
        attendance: userAttendance._id
      }
    });
    res.json("Attendance marked successfully!");
  }
  catch(err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
}
  
