const Student = require('../models/students'); // Assuming your model is in the 'models' folder

// Get all students
exports.getAllStudents = async (req, res) => {
  try {
    const students = await Student.find();
    res.status(200).json(students);
  } catch (error) {
    console.error('Error fetching students:', error);
    res.status(500).json({ message: 'Server error occurred' });
  }
};

// Get a single student by ID
exports.getStudentProfile = async (req, res) => {
  try {
    const student = await Student.findById(req.params.id);
    if (student) {
      res.status(200).json(student);
    } else {
      res.status(404).json({ message: 'Student not found' });
    }
  } catch (error) {
    console.error('Error fetching student profile:', error);
    res.status(500).json({ message: 'Server error occurred' });
  }
};

// Create a new student
exports.createStudent = async (req, res) => {
  try {
    const student = new Student(req.body);
    await student.save();
    res.status(200).json({ message: `Record of ${student.lastname}, ${student.firstname} has been added.` });
  } catch (error) {
    console.error('Error creating student:', error);
    res.status(500).json({ message: 'Server error occurred' });
  }
};

// Update a student's profile
exports.updateStudent = async (req, res) => {
  try {
    const result = await Student.findByIdAndUpdate(req.params.id, req.body, { new: true });

    if (result) {
      res.status(200).json({ message: `Record of ${result.lastname}, ${result.firstname} has been updated.` });
    } else {
      res.status(404).json({ message: 'Student not found' });
    }
  } catch (error) {
    console.error('Error updating student:', error);
    res.status(500).json({ message: 'Server error occurred' });
  }
};

// Delete a student by ID
exports.deleteStudent = async (req, res) => {
  try {
    const result = await Student.findByIdAndDelete(req.params.id);

    if (result) {
      res.status(200).json({ message: `Record with ID #${req.params.id} has been deleted.` });
    } else {
      res.status(404).json({ message: 'Student not found' });
    }
  } catch (error) {
    console.error('Error deleting student:', error);
    res.status(500).json({ message: 'Server error occurred' });
  }
};
