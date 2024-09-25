const mongoose = require("mongoose");

const studentSchema = new mongoose.Schema({
  firstname: {
    type: String,
    required: true,
    maxlength: 255,
  },
  lastname: {
    type: String,
    required: true,
    maxlength: 255,
  },
  course: {
    type: String,
    required: true,
    maxlength: 255,
  },
  year: {
    type: String,
    required: true,
    maxlength: 255,
  },
  enrolled: {
    type: Boolean,
    default: false,
  },
});

const Student = mongoose.model("Student", studentSchema);

module.exports = Student;
