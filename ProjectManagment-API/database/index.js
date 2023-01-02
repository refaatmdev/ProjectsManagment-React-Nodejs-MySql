

    const mysql2Promise = require("mysql2/promise")
    const { DB_SCHEMA, DB_USER, DB_PASSWORD, DB_PORT, DB_HOST } = process.env;
    console.log('db',DB_SCHEMA, DB_USER, DB_PASSWORD, DB_PORT, DB_HOST)
    function createPool() {
        try {
          const mysql = require('mysql2');
      
          const pool = mysql.createPool({
            host: process.env.DB_HOST || 'localhost', //commit for docker
            user: process.env.DB_USER,
            port: DB_PORT,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_SCHEMA,
            connectionLimit: 10,
            waitForConnections: true,
            queueLimit: 0,
            multipleStatements:true
          });
      
          const promisePool = pool.promise();
      
          return promisePool;
        } catch (error) {
          return console.log(`Could not connect - ${error}`);
        }
      }
      
      const pool = createPool();
      
      module.exports = {
        connection: async () => pool.getConnection(),
        execute: (...params) => pool.execute(...params)
      };
      