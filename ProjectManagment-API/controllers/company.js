const connection = require("../database/index");
const fs = require('fs');
const path = require('path');

  async function getCompanyDetails(){
    companyQuery = `SELECT * FROM ${process.env.DB_SCHEMA}.settings;`;
    const [rows] = await connection.execute(companyQuery, []);
    return rows;
  }

  async function insertCompanyDetails(details){
    const {company_name, owner,lastName, phone, email} = details;
    const values = [company_name, owner,lastName, phone, email];
    companyInsertQuery = `INSERT INTO ${process.env.DB_SCHEMA}.settings (company_name, owner,lastName, phone, email) VALUES (?, ?, ?, ?, ?);
    `;
    const [rows] = await connection.execute(companyInsertQuery, values);
    return rows;
  }
  
  async function insertTables(){
    // const getTabels = fs.readFileSync(path.join(__dirname, '../sql/PMS-DUMMY.sql')).toString();
    const getTabels = fs.readFileSync(path.join(__dirname, '../sql/projects_managment.sql'),{encoding : "utf-8"})
    const [rows] = await connection.execute(getTabels, []);
    console.log('hello from seed')
    console.log(rows)
    return rows[0];
  }

module.exports = {
  getCompanyDetails,
  insertCompanyDetails,
  insertTables
};
