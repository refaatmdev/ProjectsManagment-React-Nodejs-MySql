const connection = require("../database/index");
const bcrypt = require("bcryptjs");

async function isUserRegistered(email, password) {
  const params = password ? [email, password] : [email];
  const passwordQuery = password ? ` AND users.password = ? ` : "";
  const query = `SELECT * FROM users where email = ? ${passwordQuery} `;
  const [rows] = await connection.execute(query, params);
  return rows[0];
}

async function isUserExist(id) {
  const [rows] = await connection.execute("SELECT * FROM users where id = ?", [id]);
  return rows[0];
}

async function createUser(userValues) {
  const { email, firstName, lastName, password, role } = userValues;
  const hashPassword = bcrypt.hashSync(password, 8);
  const values = [email, firstName, lastName, hashPassword, role];
  const insertQuery = `INSERT INTO ${process.env.DB_SCHEMA}.users(email,firstName,lastName,password,role) VALUES (?,?,?,?,?)`;
  const [rows] = await connection.execute(insertQuery, values);
  return rows.affectedRows;
}

async function changePassword(id, newPassword) {
  const updateQuery = `UPDATE ${process.env.DB_SCHEMA}.users SET password = ? WHERE (id = ?);`;
  const [rows] = await connection.execute(updateQuery, [newPassword, id]);
  return rows.affectedRows;
}

async function getUsers() {
  const getQuery = `SELECT * FROM ${process.env.DB_SCHEMA}.users`;
  const [rows] = await connection.execute(getQuery);
  return rows;
}

async function getUsersWithAccounts() {
  const getQuery = `SELECT 
    distinct(${process.env.DB_SCHEMA}.users.email) , ${process.env.DB_SCHEMA}.users.firstName, ${process.env.DB_SCHEMA}.users.id as id
    FROM
    ${process.env.DB_SCHEMA}.users
        JOIN
    ${process.env.DB_SCHEMA}.accounts_users ON ${process.env.DB_SCHEMA}.users.id = ${process.env.DB_SCHEMA}.accounts_users.userId`;
  const [rows] = await connection.execute(getQuery);
  return rows;
}

module.exports = {
  isUserRegistered,
  isUserExist,
  createUser,
  changePassword,
  getUsers,
  getUsersWithAccounts,
};
