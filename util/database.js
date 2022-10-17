const mysql = require('mysql2');

const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    database: 'kiara',
    password: '',
});

module.exports = pool.promise();