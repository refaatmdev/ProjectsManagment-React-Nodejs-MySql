require("dotenv").config();
const moment = require("moment");
const connection = require("../database/index");

async function getProjectWithEmoloyeeTimeSheet(projectId) {
  const currentDate = moment().format("YYYY-MM-DD hh:mm:ss");
  const values = [projectId];
  const getProjectWithEmoloyeeTimeSheetQuery = `

  SELECT 
  ${process.env.DB_SCHEMA}.employeesTimeSheet.id AS id,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.date AS date,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.startAt AS startAt,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.endAt AS endAt,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.duration AS duration,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.notes AS notes,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.payPerDay AS payPerDay,
  ${process.env.DB_SCHEMA}.employee.firstName AS firstName,
  ${process.env.DB_SCHEMA}.employee.id AS employeeId,
  ${process.env.DB_SCHEMA}.employee.lastName AS lastName,
  (SELECT 
          dailywage
      FROM
      ${process.env.DB_SCHEMA}.employeeDailyWage
      WHERE
          month(startFromDate) <= month(${process.env.DB_SCHEMA}.employeesTimeSheet.date) And YEAR(startFromDate) <= YEAR(${process.env.DB_SCHEMA}.employeesTimeSheet.date)
              AND ${process.env.DB_SCHEMA}.employeeDailyWage.employeeId = ${process.env.DB_SCHEMA}.employee.id
      ORDER BY startFromDate DESC
      LIMIT 1) AS dailyWage,
  (SELECT 
          startFromDate
      FROM
          ${process.env.DB_SCHEMA}.employeeDailyWage
      WHERE
          month(startFromDate) <= month(${process.env.DB_SCHEMA}.employeesTimeSheet.date) And YEAR(startFromDate) <= YEAR(${process.env.DB_SCHEMA}.employeesTimeSheet.date)
              AND ${process.env.DB_SCHEMA}.employeeDailyWage.employeeId = ${process.env.DB_SCHEMA}.employee.id
      ORDER BY startFromDate DESC
      LIMIT 1) AS startFromDate,
  IFNULL(GROUP_CONCAT(DISTINCT ${process.env.DB_SCHEMA}.workedProjects.projectId
              ORDER BY (${process.env.DB_SCHEMA}.workedProjects.projectId) DESC
              SEPARATOR ','),
          0) AS dayWorkedPlace
FROM
  ${process.env.DB_SCHEMA}.employeesTimeSheet
      LEFT JOIN
  ${process.env.DB_SCHEMA}.employee ON ${process.env.DB_SCHEMA}.employeesTimeSheet.employeeId = ${process.env.DB_SCHEMA}.employee.id
      LEFT JOIN
  ${process.env.DB_SCHEMA}.employeeDailyWage ON ${process.env.DB_SCHEMA}.employeeDailyWage.employeeId = ${process.env.DB_SCHEMA}.employee.id
      LEFT JOIN
  ${process.env.DB_SCHEMA}.workedProjects ON ${process.env.DB_SCHEMA}.workedProjects.dayId = ${process.env.DB_SCHEMA}.employeesTimeSheet.id
WHERE ${process.env.DB_SCHEMA}.workedProjects.projectId = ?
GROUP BY id 
ORDER BY date DESC   , dailyWage 


  `;

  const [rows] = await connection.execute(
    getProjectWithEmoloyeeTimeSheetQuery,
    values
  );
  return rows;
}

async function addNewMafrea(data) {
  const { employeeId, amount, notes, createdAt } = data;
  const values = [employeeId, amount, notes, createdAt];

  const query = `
  INSERT INTO ${process.env.DB_SCHEMA}.mafreaot (employeeId, amount, notes,createdAt) VALUES (?, ?, ?, ?);
  `;
  const [rows] = await connection.execute(query, values);
  return rows.insertId;
}

async function deleteMafrea(id) {
  const values = [id];
  const query = `
  DELETE FROM ${process.env.DB_SCHEMA}.mafreaot WHERE (id = ?);
  `;
  const [rows] = await connection.execute(query, values);
  return rows;
}

async function updateMafrea(data) {
  const { id, amount, notes, createdAt } = data;
  const values = [amount, notes, createdAt, id];
  const query = `
Update ${process.env.DB_SCHEMA}.mafreaot SET amount = ?, notes = ?, createdAt = ?  WHERE (id = ?);
`;
  const [rows] = await connection.execute(query, values);
  return rows;
}

async function getMafreaById(id) {
  const query = `
  SELECT * FROM projects_managment.mafreaot WHERE (id = ?)
  `;
  const [rows] = await connection.execute(query, [id]);
  return rows;
}

async function deleteMafrea(id) {
  const values = [id];
  const query = `
  DELETE FROM ${process.env.DB_SCHEMA}.mafreaot WHERE (id =?);
  `;
  const [rows] = await connection.execute(query, values);
}

async function getAllMafreaot(currentMonth, pageSize, currentPage, employeeId) {
  console.log(currentMonth, pageSize, currentPage, employeeId);
  const limitQuery =
    currentPage && pageSize > 0
      ? `LIMIT ${pageSize * (currentPage - 1) + "," + pageSize}`
      : "";
  const filterByEmployee = !isNaN(employeeId)
    ? `AND employeeId  = ${employeeId}`
    : "";
  const month = moment(currentMonth).month() + 1;
  const year = moment(currentMonth).year();
  const values = [month, year];

  const query = `
  SELECT  
  ${process.env.DB_SCHEMA}.mafreaot.id as id,
    ${process.env.DB_SCHEMA}.mafreaot.employeeId as employeeId,
    ${process.env.DB_SCHEMA}.mafreaot.amount as amount,
    ${process.env.DB_SCHEMA}.mafreaot.notes as notes,
    ${process.env.DB_SCHEMA}.mafreaot.createdAt as createdAt,
    ${process.env.DB_SCHEMA}.employee.firstName as firstName,
    ${process.env.DB_SCHEMA}.employee.lastName as lastName
  FROM ${process.env.DB_SCHEMA}.mafreaot
    left JOIN ${process.env.DB_SCHEMA}.employee ON ${process.env.DB_SCHEMA}.employee.id = ${process.env.DB_SCHEMA}.mafreaot.employeeId
  WHERE MONTH(${process.env.DB_SCHEMA}.mafreaot.createdAt) = ? AND YEAR(${process.env.DB_SCHEMA}.mafreaot.createdAt) = ? ${filterByEmployee}`;
  const [rows] = await connection.execute(query, values);
  return rows;
}

async function getEmoloyeeTimeSheet(id) {
  const getProjectWithEmoloyeeTimeSheetQuery = `
  SELECT * FROM ${process.env.DB_SCHEMA}.employeesTimeSheet
  JOIN ${process.env.DB_SCHEMA}.employee
   On ${process.env.DB_SCHEMA}.employee.id = ${process.env.DB_SCHEMA}.employeesTimeSheet.employeeId
    where ${process.env.DB_SCHEMA}.employeesTimeSheet.employeeId =? 
ORDER BY date `;
  const [rows] = await connection.execute(
    getProjectWithEmoloyeeTimeSheetQuery,
    [id]
  );
  return rows;
}

async function addEmployeeRecord(record) {
  const addRecord = await Promise.all(
    record.map(async (rec) => {
      const { date, startAt, endAt, employeeId, notes } = rec;
      const duration = moment.duration(moment(endAt).diff(moment(startAt)));
      if (parseFloat(duration.asHours()).toFixed(2) > 4)
        duration.subtract(0.5, "hour");
      var hours = duration.asHours();
      const values = [
        date,
        employeeId,
        startAt,
        endAt,
        (hours = parseFloat(duration.asHours()).toFixed(2)),
        notes,
      ];
      const addRecordReuslt = await _addRecordTimeSheet(values);
      addWorkPlace(rec, addRecordReuslt);
    })
  );
  return addRecord;
}

async function addWorkPlace(record, addRecordReuslt) {
  const records = record.projectId.map(async (projectId) => {
    await addWorkedProject(addRecordReuslt, projectId);
  });
  return records;
}

async function _addRecordTimeSheet(values) {
  const addEmployeeHrQuery = `INSERT INTO ${process.env.DB_SCHEMA}.employeesTimeSheet (date, employeeId, startAt, endAt, duration,notes) VALUES (?,?,?,?,?,?);`;
  const [rows] = await connection.execute(addEmployeeHrQuery, values);
  return rows.insertId;
}

async function addWorkedProject(dayId, projects) {
  let projectId;
  let notes = "";
  if (projects.projectId != undefined) {
    // const { projectId, notes } = projects;
    projectId = projects.projectId;
    notes = projects.notes;
  } else {
    projectId = projects;
  }
  const values = [dayId, projectId, notes];
  console.log(values);
  const addToWorkedProjectQuery = `
  INSERT INTO ${process.env.DB_SCHEMA}.workedProjects (dayId, projectId, notes) VALUES (?, ?,?);
  `;
  const [rows] = await connection.execute(addToWorkedProjectQuery, values);
  return rows;
}

async function getEmployeeMothRecords(employeeId, month, year) {
  const values = [employeeId, month, year];
  const query = `
  SELECT * FROM ${process.env.DB_SCHEMA}.employeesTimeSheet where employeeId = ?
and month (date) = ? AND YEAR(date) = ? 
order by date 
asc`;
  const [rows] = await connection.execute(query, values);
  return rows;
}

async function getAllRecordsByMonth(
  currentMonth,
  pageSize,
  currentPage,
  employeeId
) {
  const limitQuery = currentPage
    ? `LIMIT ${pageSize * (currentPage - 1) + "," + pageSize}`
    : "";
  const filterByEmployee = !isNaN(employeeId)
    ? `AND ${process.env.DB_SCHEMA}.employee.id  = ${employeeId}`
    : "";
  const month = moment(currentMonth).month() + 1;
  const year = moment(currentMonth).year();
  const values = [currentMonth, currentMonth, month, year];
  const query = `
  SELECT 
  ${process.env.DB_SCHEMA}.employeesTimeSheet.id AS id,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.date AS date,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.startAt AS startAt,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.endAt AS endAt,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.duration AS duration,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.notes AS notes,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.payPerDay AS payPerDay,
  ${process.env.DB_SCHEMA}.employee.firstName AS firstName,
  ${process.env.DB_SCHEMA}.employee.id AS employeeId,
  ${process.env.DB_SCHEMA}.employee.lastName AS lastName,
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
        LIMIT 1) AS startFromDate,
  IFNULL(GROUP_CONCAT(DISTINCT ${process.env.DB_SCHEMA}.workedProjects.projectId
              ORDER BY (${process.env.DB_SCHEMA}.workedProjects.projectId) DESC
              SEPARATOR ','),
          0) AS dayWorkedPlace
FROM
  ${process.env.DB_SCHEMA}.employeesTimeSheet
      LEFT JOIN
  ${process.env.DB_SCHEMA}.employee ON ${process.env.DB_SCHEMA}.employeesTimeSheet.employeeId = ${process.env.DB_SCHEMA}.employee.id
      LEFT JOIN
  ${process.env.DB_SCHEMA}.employeeDailyWage ON ${process.env.DB_SCHEMA}.employeeDailyWage.employeeId = ${process.env.DB_SCHEMA}.employee.id
      LEFT JOIN
  ${process.env.DB_SCHEMA}.workedProjects ON ${process.env.DB_SCHEMA}.workedProjects.dayId = ${process.env.DB_SCHEMA}.employeesTimeSheet.id
WHERE
  MONTH(date) = ? AND YEAR(date) = ? ${filterByEmployee}
GROUP BY id 
ORDER BY date DESC   , dailyWage 
${limitQuery}
  `;
  const [rows] = await connection.execute(query, values);
  return rows;
}

async function getAllRecordsByMonthReact(
  currentMonth,
  pageSize,
  currentPage,
  employeeId
) {
  console.log(currentMonth, pageSize, currentPage, employeeId);
  const limitQuery =
    currentPage && pageSize > 0
      ? `LIMIT ${pageSize * (currentPage - 1) + "," + pageSize}`
      : "";
  const filterByEmployee = !isNaN(employeeId)
    ? `AND ${process.env.DB_SCHEMA}.employee.id  = ${employeeId}`
    : "";
  const month = moment(currentMonth).month() + 1;
  const year = moment(currentMonth).year();
  const values = [currentMonth, currentMonth, month, year];
  console.log(currentMonth, currentMonth, month, year);
  const query = `
  SELECT ${process.env.DB_SCHEMA}.employeesTimeSheet.id AS id,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.date AS date,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.startAt AS startAt,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.endAt AS endAt,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.duration AS duration,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.notes AS notes,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.payPerDay AS payPerDay,
  ${process.env.DB_SCHEMA}.employee.firstName AS firstName,
  ${process.env.DB_SCHEMA}.employee.id AS employeeId,
  ${process.env.DB_SCHEMA}.employee.lastName AS lastName,
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
        LIMIT 1) AS startFromDate,
 ${process.env.DB_SCHEMA}.workedProjects.projectId as projectId,
 ${process.env.DB_SCHEMA}.workedProjects.id as workedDayId,
 ${process.env.DB_SCHEMA}.projects.projectName as projectName,
 ${process.env.DB_SCHEMA}.workedProjects.notes as projectNotes
 FROM ${process.env.DB_SCHEMA}.employeesTimeSheet 
left join ${process.env.DB_SCHEMA}.workedProjects on ${process.env.DB_SCHEMA}.employeesTimeSheet.id = ${process.env.DB_SCHEMA}.workedProjects.dayId
LEFT JOIN
  ${process.env.DB_SCHEMA}.employee ON ${process.env.DB_SCHEMA}.employeesTimeSheet.employeeId = ${process.env.DB_SCHEMA}.employee.id
  left JOIN
  ${process.env.DB_SCHEMA}.employeeDailyWage ON ${process.env.DB_SCHEMA}.employeeDailyWage.employeeId = ${process.env.DB_SCHEMA}.employee.id
  LEFT JOIN
  ${process.env.DB_SCHEMA}.projects ON ${process.env.DB_SCHEMA}.projects.id = projectId
WHERE
  MONTH(date) = ? AND YEAR(date) = ?  ${filterByEmployee}
  group by workedDayId
ORDER BY date DESC 
${limitQuery}

  `;

  const [rows] = await connection.execute(query, values);
  return rows;
}
async function getRecordsCount(currentMonth) {
  const month = moment(currentMonth).month() + 1;
  const year = moment(currentMonth).year();
  const values = [month, year];
  const getProjectsQuery = `SELECT count(*) as totalRecords FROM ${process.env.DB_SCHEMA}.employeesTimeSheet WHERE
  MONTH(date) = ? AND YEAR(date) = ?`;
  const [rows] = await connection.execute(getProjectsQuery, values);
  return rows[0].totalRecords;
}

async function addOrUpdateSalary(currentMonth) {
  const calculateSalries = await _calculateSalary(currentMonth);
  const getMothSalaries = await getSalriesByMonth(currentMonth);

  const extractNewSalaries = calculateSalries.filter(
    (el) => !getMothSalaries.find((old) => old.employeeId === el.employeeId)
  );

  if (extractNewSalaries.length > 0) {
    const addReuslt = await _addSalary(extractNewSalaries, currentMonth);
  }
  const updateOldSalaries = calculateSalries.map(
    async (el) =>
      await getMothSalaries.map(async (old) => {
        if (old.employeeId === el.employeeId) {
          const updateResult = await _updateSalary(old.id, el.salary);
        }
      })
  );
  const extractDeletedSalaries = getMothSalaries.filter(
    (el) => !calculateSalries.find((old) => old.employeeId === el.employeeId)
  );

  if (extractDeletedSalaries.length > 0) {
    const resultOfDelete = extractDeletedSalaries.map(async (d) => {
      await _deleteSalaryForEmployee(d.employeeId, currentMonth);
    });
  }

  return updateOldSalaries;
}

async function _addSalary(newSalary, currentMonth) {
  const month = moment(currentMonth)
    .startOf("month")
    .format("YYYY-MM-DD HH:mm:ss");
  const addSalaray = newSalary.map(async (s) => {
    const values = [s.employeeId, s.salary, month];
    const addSalaryQuery = `
  INSERT INTO ${process.env.DB_SCHEMA}.salary (employeeId, salary,salaryDate) VALUES (?, ?, ?);
  `;
    const [rows] = await connection.execute(addSalaryQuery, values);
    return rows;
  });
  return addSalaray;
}

async function _updateSalary(id, salary) {
  const values = [salary, id];
  const updateEmployeeHrQuery = `UPDATE ${process.env.DB_SCHEMA}.salary SET salary = ? WHERE id = ?;`;
  const [rows] = await connection.execute(updateEmployeeHrQuery, values);
  return rows.affectedRows;
}

async function _deleteSalaryForEmployee(employeeId, salaryMonth) {
  const deleteQuery = `DELETE FROM ${process.env.DB_SCHEMA}.salary WHERE employeeId = ? AND salaryDate = ?;`;
  const [rows] = await connection.execute(deleteQuery, [
    employeeId,
    salaryMonth,
  ]);
  return rows.affectedRows;
}

async function _calculateSalary(currentMonth) {
  const month = moment(currentMonth).month() + 1;
  const year = moment(currentMonth).year();
  const values = [month, year];
  const query = `
  SELECT 
  ${process.env.DB_SCHEMA}.employee.id AS employeeId,
  ${process.env.DB_SCHEMA}.employee.firstName AS firstName,
  ${process.env.DB_SCHEMA}.employee.lastName AS lastName,
  SUM(${process.env.DB_SCHEMA}.employeesTimeSheet.payPerDay) as salary
FROM
  ${process.env.DB_SCHEMA}.employeesTimeSheet
  Left Join
 ${process.env.DB_SCHEMA}.employee ON ${process.env.DB_SCHEMA}.employeesTimeSheet.employeeId = ${process.env.DB_SCHEMA}.employee.id

WHERE
  MONTH(date) = ? AND YEAR(date) = ?
GROUP BY  ${process.env.DB_SCHEMA}.employee.id
ORDER BY ${process.env.DB_SCHEMA}.employee.id asc  
  `;
  const [rows] = await connection.execute(query, values);
  return rows;
}

async function getSalriesByMonth(currentMonth) {
  const month = moment(currentMonth).month() + 1;
  const year = moment(currentMonth).year();
  const values = [month, year];
  const query = `
  SELECT * FROM ${process.env.DB_SCHEMA}.salary
WHERE
  MONTH(salaryDate) = ? AND YEAR(salaryDate) = ?
  `;
  const [rows] = await connection.execute(query, values);
  return rows;
}

async function getSalaries() {
  const query = `
  SELECT SUM(${process.env.DB_SCHEMA}.salary.salary) as total,
	${process.env.DB_SCHEMA}.salary.salaryDate
 FROM ${process.env.DB_SCHEMA}.salary
GROUP BY ${process.env.DB_SCHEMA}.salary.salaryDate
ORDER BY ${process.env.DB_SCHEMA}.salary.salaryDate DESC
  `;
  const [rows] = await connection.execute(query);
  return rows;
}

async function getSalaryByMonth(currentMonth) {
  const month = moment(currentMonth).month() + 1;
  const year = moment(currentMonth).year();
  const values = [currentMonth, currentMonth, month, year];
  console.log(values);
  const query = `
  SELECT 
  ${process.env.DB_SCHEMA}.salary.salaryDate as salaryDate,
  ${process.env.DB_SCHEMA}.employee.id AS employeeId,
  ${process.env.DB_SCHEMA}.employee.firstName AS firstName,
  ${process.env.DB_SCHEMA}.employee.lastName AS lastName,
  ${process.env.DB_SCHEMA}.salary.salary AS salary,
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
FROM
  ${process.env.DB_SCHEMA}.employeesTimeSheet
  Left Join					
 ${process.env.DB_SCHEMA}.employee ON ${process.env.DB_SCHEMA}.employeesTimeSheet.employeeId = ${process.env.DB_SCHEMA}.employee.id
  left join 
${process.env.DB_SCHEMA}.salary ON ${process.env.DB_SCHEMA}.salary.employeeId = ${process.env.DB_SCHEMA}.employee.id
WHERE
  MONTH(salaryDate) = ? AND YEAR(salaryDate) = ?
GROUP BY  ${process.env.DB_SCHEMA}.employee.id
ORDER BY ${process.env.DB_SCHEMA}.employee.id asc  
`;
  const [rows] = await connection.execute(query, values);
  return rows;
}

async function getDuration(currentMonth) {
  const month = moment(currentMonth).month() + 1;
  const year = moment(currentMonth).year();
  const values = [month, year];
  const query = `
  SELECT  ${process.env.DB_SCHEMA}.employeesTimeSheet.employeeId,
  sum(${process.env.DB_SCHEMA}.employeesTimeSheet.duration) as duration
FROM
  ${process.env.DB_SCHEMA}.employeesTimeSheet
WHERE
    MONTH(employeesTimeSheet.date) = ? AND YEAR(employeesTimeSheet.date) = ? 
group by  ${process.env.DB_SCHEMA}.employeesTimeSheet.employeeId
order by ${process.env.DB_SCHEMA}.employeesTimeSheet.employeeId asc
  `;
  const [rows] = await connection.execute(query, values);
  return rows;
}

module.exports = {
  getSalaries,
  getDuration,
  getSalaryByMonth,
  getProjectWithEmoloyeeTimeSheet,
  getEmoloyeeTimeSheet,
  addEmployeeRecord,
  addOrUpdateSalary,
  getAllRecordsByMonth,
  getRecordsCount,
  addWorkedProject,
  getAllRecordsByMonthReact,
  addNewMafrea,
  updateMafrea,
  deleteMafrea,
  getAllMafreaot,
  getMafreaById,
  deleteMafrea,
};
