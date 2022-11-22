const mysql = require('mysql2');

/*const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    database: 'kiara',
    password: '',
});
*/

const pool = mysql.createPool({
    host: '165.232.152.1',
    user: 'kiaradeveloper',
    database: 'kiara',
    password: 'kiara',
});

module.exports = pool.promise();