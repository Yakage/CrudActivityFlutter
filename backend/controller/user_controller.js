const mysql = require('mysql');
const pool = mysql.createPool({
  connectionLimit: 10,
  host: 'localhost',
  user: 'root',
  database: 'crud_activity_flutter',
});

exports.getAllStudents = (req, res) => {
  pool.getConnection((error, connection) => {
    if (error) throw error
    console.log(`connected as id ${connection.threadId}`);

    connection.query('SELECT * from users', (error, results) => {
        connection.release();

        if (!error) {
          res.status(200).json(results);
        } else {
          console.log(error);
          res.status(500).json(error);
        }
      });
    
  });
};

exports.getStudentProfile = (req, res) => {
  pool.getConnection((error, connection) => {
    try {
      console.log(`connected as id ${connection.threadId}`);

      connection.query('SELECT * from users WHERE id = ?', [req.perams.id], (error, results) => {
          connection.release();

          if (error) {
            res.status(404).json({ message: 'User not found' });
          };

          if (results.length > 0) {
              res.status(200).json(results[0]);
          };
      });
    } catch (error) {
        console.error(error);
        res.status(500).json(error); 
    }
  });
};

exports.createStudent = (req, res) => {
  pool.getConnection((error, connection) => {
      if (error) {
        console.error('Error getting MySQL connection:', error);
        return res.status(500).json({ message: 'Server error occurred' });
      }

      const params = req.body;

      connection.query('INSERT INTO users SET ?', params, (error, results) => {
          connection.release();

          if (!error) {
              res.status(200).json({ message: `Record of ${[params.last_name, params.first_name]} has been added.`});
          } else {
              console.log(error);
              res.status(500).json({ message: error});
          };
      });
  });
};

exports.updateStudent = (req, res) => {
  pool.getConnection((error, connection) => {
      if (error) {
        console.error('Error getting MySQL connection:', error);
        return res.status(500).json({ message: 'Server error occurred' });
      }
      console.log(`connected as id ${connection.threadId}`);

      const params= req.body;
      const id = req.params.id;

      connection.query('UPDATE users SET ? where id = ?', [params, id], (error, results) => {
          connection.release();

          if (!error) {
              res.status(200).json({ message: `Record of ${[params.lastname, params.firstname]} has been updated.`});
          } else {
              console.log(error);
              res.status(500).json({ message: error});
          };
      });
  });
};

exports.deleteStudent = (req, res) => {
  pool.getConnection((error, connection) => {
      if (error) {
          console.error('Error getting MySQL connection:', error);
          return res.status(500).json({ message: 'Server error occurred' });
      }
      console.log(`Connected as id ${connection.threadId}`);

      connection.query('DELETE FROM users WHERE id = ?', [req.params.id], (error, result) => {
          connection.release(); 

          if (error) {
              console.error('Error executing query:', error);
              return res.status(500).json({ message: 'Server error occurred' });
          }

          if (result.affectedRows > 0) {
              res.status(200).json({ message: `Record with ID # ${req.params.id} has been deleted.` });
          } else {
              res.status(404).json({ message: 'User not found' });
          }
      });
  });
};

