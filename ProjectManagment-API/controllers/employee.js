// const connection = require("../database/index");
const connection = require("../database/index");
// const connection = db.connection();
const moment = require("moment");

async function getEmployeeById(employeeId) {
  const getEmployeeQuery = `
  SELECT ${process.env.DB_SCHEMA}.employee.id As id,
  ${process.env.DB_SCHEMA}.employee.firstName,
  ${process.env.DB_SCHEMA}.employee.lastName,
  ${process.env.DB_SCHEMA}.employee.phone,
  ${process.env.DB_SCHEMA}.employee.bankBranch,
  ${process.env.DB_SCHEMA}.employee.createdAt,
  ${process.env.DB_SCHEMA}.employee.updatedAt,
  ${process.env.DB_SCHEMA}.employee.bankAccount
 FROM ${process.env.DB_SCHEMA}.employee 
where ${process.env.DB_SCHEMA}.employee.id = ?
  `;
  const [rows] = await connection.execute(getEmployeeQuery, [employeeId]);
  return rows[0];
}
async function createEmployee(employeeValues) {
  const { firstName, lastName, phone, wagePerDay, bankAccount, bankBranch } =
    employeeValues;
  const values = [firstName, lastName, phone, bankAccount, bankBranch];

  const createProjectQuery = `INSERT INTO ${process.env.DB_SCHEMA}.employee (firstName, lastName, phone, bankAccount,bankBranch) VALUES (?,?,?,?,?);`;
  const [rows] = await connection.execute(createProjectQuery, values);
  return rows.insertId;
}

async function addDailyWage(employeeId, dailyWage, startFrom) {
  const values = [employeeId, dailyWage, startFrom];
  const insertDailyWage = `INSERT INTO ${process.env.DB_SCHEMA}.employeeDailyWage (employeeId, dailyWage,startFromDate) VALUES (?,?,?);`;
  const [rows] = await connection.execute(insertDailyWage, values);
  return rows;
}

async function getEmployees(pageSize, currentPage, searchValue, employeeId) {
  console.log(pageSize, currentPage, searchValue, employeeId);
  const serchV = searchValue
    ? `WHERE ${process.env.DB_SCHEMA}.employee.firstName  LIKE '%${searchValue}%' `
    : "";
  const currentDate = moment().format("YYYY-MM-DD hh:mm:ss");
  console.log(currentDate);
  const limitQuery = currentPage
    ? `LIMIT ${pageSize * (currentPage - 1) + "," + pageSize}`
    : "";
  const employee = employeeId
    ? `WHERE ${process.env.DB_SCHEMA}.employee.id = ${employeeId}`
    : "";
  const getEmployeeQuery = `
  SELECT ${process.env.DB_SCHEMA}.employee.id As id,
  ${process.env.DB_SCHEMA}.employee.firstName,
  ${process.env.DB_SCHEMA}.employee.lastName,
  ${process.env.DB_SCHEMA}.employee.phone,
  ${process.env.DB_SCHEMA}.employee.bankBranch,
  ${process.env.DB_SCHEMA}.employee.createdAt,
  ${process.env.DB_SCHEMA}.employee.updatedAt,
  ${process.env.DB_SCHEMA}.employee.bankAccount,
  ${process.env.DB_SCHEMA}.employee.isActive,
  (SELECT 
    dailywage
FROM
    ${process.env.DB_SCHEMA}.employeeDailyWage
WHERE
    startFromDate <= ?
        AND ${process.env.DB_SCHEMA}.employeeDailyWage.employeeId = ${process.env.DB_SCHEMA}.employee.id
ORDER BY startFromDate DESC
LIMIT 1) AS dailyWage,
(SELECT 
    startFromDate
FROM
    ${process.env.DB_SCHEMA}.employeeDailyWage
WHERE
    startFromDate <= ?
        AND ${process.env.DB_SCHEMA}.employeeDailyWage.employeeId = ${process.env.DB_SCHEMA}.employee.id
ORDER BY startFromDate DESC
LIMIT 1) AS startFromDate
 FROM ${process.env.DB_SCHEMA}.employee
 left join ${process.env.DB_SCHEMA}.employeeDailyWage
 on ${process.env.DB_SCHEMA}.employeeDailyWage.employeeId = ${process.env.DB_SCHEMA}.employee.id 
 ${serchV}
 ${employee}
 GROUP BY id 
  order by isActive
desc
${limitQuery}
  `;

  // `

  // SELECT * FROM ${process.env.DB_SCHEMA}.employee ${limitQuery};
  // `;
  const [rows] = await connection.execute(getEmployeeQuery, [
    currentDate,
    currentDate,
  ]);
  return rows;
}

async function getEmployeesCount() {
  const getEmployeesQuery = `SELECT count(*) as totalEmployees FROM ${process.env.DB_SCHEMA}.employee `;
  const [rows] = await connection.execute(getEmployeesQuery);
  return rows[0].totalEmployees;
}

async function editEmployee(employeeValues, employeeId) {
  const { firstName, lastName, phone, bankAccount, bankBranch, isActive } =
    employeeValues;
  const values = [
    firstName,
    lastName,
    phone,
    bankAccount,
    bankBranch,
    Number(isActive),

    employeeId,
  ];
  const updateQuery =
    "UPDATE `employee` SET `firstName` = ?, `lastName` = ?, `phone` = ?,  `bankAccount` = ? , `bankBranch` = ? , `isActive` = ? WHERE (`id` = ?);  ";
  const [rows] = await connection.execute(updateQuery, values);
  return rows;
}

async function deleteEmployeeById(employeeId) {
  const deleteQuery = "DELETE FROM employee WHERE (id = ?);";
  const [rows] = await connection.execute(deleteQuery, [employeeId]);
  return rows.affectedRows;
}

module.exports = {
  createEmployee,
  getEmployees,
  getEmployeeById,
  getEmployeesCount,
  deleteEmployeeById,
  editEmployee,
  addDailyWage,
};
