const mongoose = require("mongoose");

const AttendanceSchema = new mongoose.Schema({
    userID: { 
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'User', 
        required: true 
    },
    date: { 
        type: Date,
        default: Date.now 
    },
  },{
    timestamps: true
});

const UserSchema = new mongoose.Schema({
    employee_id:{
        type: String,
        required: true,
        unique: true
    } ,
    name: {
        type: String,
        required: true
    },
    age: {
        type: Number,
        required: true
    },
    position: {
        type: String,
        required: true
    },
    blood_group: {
        type: String,
        required: true
    },
    username: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
    keyImage: {
        type: String, 
        required: true,
    },
    attendance: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Attendance',
    }],
},{
    timestamps: true
});

const User = mongoose.model('User',UserSchema);
const Attendance = mongoose.model('Attendance',AttendanceSchema);

module.exports = {
    User,
    Attendance
}
