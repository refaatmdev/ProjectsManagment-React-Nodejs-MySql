const connection = require("../database/index");

const fs = require("fs");
const path = require("path");

async function createProject(project) {
  const { projectName, clientFullName, clientPhone, location, createdAt } =
    project;
  const values = [
    projectName,
    clientFullName,
    clientPhone,
    location,
    createdAt,
  ];
  const createProjectQuery = `INSERT INTO ${process.env.DB_SCHEMA}.projects (projectName,clientFullName,clientPhone, location,createdAt) VALUES (?,?,?,?,?);`;
  const [rows] = await connection.execute(createProjectQuery, values);
  return rows.insertId;
}

async function checkIfProjectExist(id) {
  const [rows] = await connection.execute(
    `SELECT * FROM ${process.env.DB_SCHEMA}.projects where id = ?`,
    [id]
  );
  return rows[0];
}

async function insertQuotationForProject(projectId, data) {
  const { quotation, quotationNotes } = data;
  const values = [projectId, quotation, quotationNotes];
  const inserQuotationQuery = `INSERT INTO ${process.env.DB_SCHEMA}.project_quotation  (projectId, quotation, notes) VALUES (?, ?,?);`;
  const [rows] = await connection.execute(inserQuotationQuery, values);
  return rows;
}

async function insertPaidsForProject(paidData) {
  const { projectId, paid, method, paidDate, notes } = paidData;

  const values = [projectId, paid, method, paidDate, notes];
  const inserQuotationQuery = `INSERT INTO ${process.env.DB_SCHEMA}.project_pays  (projectId, paid,method,paidDate,notes) VALUES (?, ?, ?, ?, ?);`;
  const [rows] = await connection.execute(inserQuotationQuery, values);
  return rows.insertId;
}

async function editProject(updatedData, projectId) {
  const { projectName, clientFullName, clientPhone, location, createdAt } =
    updatedData;
  const values = [
    projectName,
    clientFullName,
    clientPhone,
    location,
    createdAt,
    projectId,
  ];
  const updateQuery =
    "UPDATE `projects` SET `projectName` = ?, `clientFullName` = ?, `clientPhone` = ?, `location` = ?, `createdAt` = ? WHERE (`id` = ?);  ";
  const [rows] = await connection.execute(updateQuery, values);
  return rows.affectedRows;
}

async function editPaid(paidData, paidId) {
  const { paidDate, paid, method, notes } = paidData;
  const values = [paidDate, paid, method, notes, paidId];
  console.log("values", values);
  const updatePaidQuery =
    "UPDATE `project_pays` SET `paidDate` = ?, `paid` = ?, `method` = ?, `notes` = ? WHERE (`id` = ?);";
  const [rows] = await connection.execute(updatePaidQuery, values);
  return rows.affectedRows;
}

async function updateQuotation(quotationcData, projectId) {
  const { quotation, quotationNotes } = quotationcData;
  const values = [quotation, quotationNotes, projectId];
  const updateQuotationQuery =
    "UPDATE `project_quotation` SET `quotation` = ? , `notes` = ? WHERE (`projectId` = ?);";
  const [rows] = await connection.execute(updateQuotationQuery, values);
  return rows.affectedRows;
}

async function deleteProjectById(projectId) {
  const deleteQuery = "DELETE FROM projects WHERE (id = ?);";
  const [rows] = await connection.execute(deleteQuery, [projectId]);
  return rows.affectedRows;
}

async function deletePaidById(paidId) {
  const deleteQuery = `DELETE FROM ${process.env.DB_SCHEMA}.project_pays WHERE (id = ?);`;
  const [rows] = await connection.execute(deleteQuery, [paidId]);
  return rows.affectedRows;
}

async function getProjects(pageSize, currentPage, searchValue) {
  const serchV = searchValue
    ? `WHERE ${process.env.DB_SCHEMA}.projects.projectName  LIKE '%${searchValue}%' `
    : "";

  const limitQuery = currentPage
    ? `LIMIT ${pageSize * (currentPage - 1) + "," + pageSize}`
    : "";
  const getProjectsQuery = `SELECT 
  projects.id As id,
  projects.projectName as projectName,
  projects.clientFullName as clientFullName,
  projects.clientPhone as clientPhone,
  projects.location as location,
  projects.createdAt as createdAt,
  projects.updatedAt as updatedAt,
  agreement.imagePath as agreement,
  project_quotation.quotation as quotation,
  (SELECT 
    SUM(paid)
FROM
    ${process.env.DB_SCHEMA}.project_pays
WHERE
    ${process.env.DB_SCHEMA}.project_pays.projectId = ${process.env.DB_SCHEMA}.projects.id
GROUP BY ${process.env.DB_SCHEMA}.project_pays.projectId) AS paid
  FROM
${process.env.DB_SCHEMA}.projects
      LEFT JOIN
           ${process.env.DB_SCHEMA}.agreement ON projects.id = ${process.env.DB_SCHEMA}.agreement.projectId
       LEFT JOIN 
          ${process.env.DB_SCHEMA}.project_quotation ON projects.id = ${process.env.DB_SCHEMA}.project_quotation.projectId
       LEFT JOIN 
          ${process.env.DB_SCHEMA}.project_pays ON projects.id = ${process.env.DB_SCHEMA}.project_pays.projectId
          ${serchV}
group by id,projectName,agreement,quotation
order by projects.createdAt desc
       ${limitQuery}
       
  `;

  const [rows] = await connection.execute(getProjectsQuery);
  return rows;
}

async function getProjectsCount() {
  const getProjectsQuery = `SELECT count(*) as totalProjects FROM ${process.env.DB_SCHEMA}.projects `;
  const [rows] = await connection.execute(getProjectsQuery);
  return rows[0].totalProjects;
}

async function getAgreementByProjectId(projectId) {
  const getAgreementByProjectIdQuery = `SELECT *
  FROM agreement 
  where projectId = ?`;
  const [rows] = await connection.execute(getAgreementByProjectIdQuery, [
    projectId,
  ]);
  if (rows.length > 0) return rows[0].imagePath;
  return;
}

async function getCheckByPaidId(paidId) {
  const getCheckByPaidIdQuery = `SELECT *
  FROM ${process.env.DB_SCHEMA}.checks_imgs 
  where payId = ?`;
  const [rows] = await connection.execute(getCheckByPaidIdQuery, [paidId]);
  if (rows.length > 0) return rows[0].checksImgPath;
  return;
}

async function deleteProjectById(projectId) {
  const deleteQuery = "DELETE FROM projects WHERE (id = ?);";
  const [rows] = await connection.execute(deleteQuery, [projectId]);
  return rows.affectedRows;
}

async function deleteProjectAgreement(projectId) {
  const deleteQuery = "DELETE FROM agreement WHERE (projectId = ?);";
  const [rows] = await connection.execute(deleteQuery, [projectId]);
  return rows.affectedRows;
}

async function insertPhotoToDB(filePath, id) {
  const PhotoQuery =
    "INSERT INTO `agreement`  (`imagePath`,`projectId`) VALUES (?,?)";
  const [rows] = await connection.execute(PhotoQuery, [filePath, id]);
  return rows.affectedRows;
}
async function getNotesForProject({
  pageSize,
  currentPage,
  projectId,
  noteId,
}) {
  const limitQuery = currentPage
    ? `LIMIT ${pageSize * (currentPage - 1) + "," + pageSize}`
    : "";
  const project = projectId
    ? `WHERE ${process.env.DB_SCHEMA}.project_notes.projectId = ${projectId}`
    : "";
  const id = noteId
    ? `WHERE ${process.env.DB_SCHEMA}.project_notes.id = ${noteId}`
    : "";

  const query = `SELECT * FROM projects_managment.project_notes ${project} ${id} ${limitQuery}`;
  const [rows] = await connection.execute(query, []);
  return rows;
}
async function insertNotesForProject(data, projectId) {
  console.log("notes data", data);
  const { notes, createdAt } = data;
  const values = [projectId, notes, createdAt];
  const NotesQuery =
    "INSERT INTO `project_notes`  (`projectId`, `notes`, `createdAt`) VALUES (?,?,?)";
  const [rows] = await connection.execute(NotesQuery, values);
  return rows;
}

async function deleteNotesForProject(id) {
  const deleteQuery = "DELETE FROM project_notes WHERE (id = ?);";
  const [rows] = await connection.execute(deleteQuery, [id]);
  return rows.affectedRows;
}

async function updateNotesForProject(data, projectId) {
  const { notes, createdAt, id } = data;
  const values = [notes, createdAt, id, projectId];
  const updateNoteQuery =
    "UPDATE `project_notes` SET `notes` = ? , `createdAt` = ? WHERE (`id` = ?) AND (`projectId` = ?);";
  const [rows] = await connection.execute(updateNoteQuery, values);
  return rows.affectedRows;
}

async function updatePhotoToDB(filePath, projectId) {
  const PhotoQuery =
    "UPDATE agreement SET `imagePath` = ? WHERE (`projectId` =?);";
  const [rows] = await connection.execute(PhotoQuery, [filePath, projectId]);
  console.log(rows);
  return rows.affectedRows;
}

async function updateCheckPhotoToDB(filePath, paidId) {
  const PhotoQuery =
    "UPDATE checks_imgs SET `checksImgPath` = ? WHERE (`payId` =?);";
  const [rows] = await connection.execute(PhotoQuery, [filePath, paidId]);
  return rows.affectedRows;
}

function _deleteImageFromStorage(imgPath) {
  const filePath = imgPath;
  if (fs.existsSync(filePath)) {
    const deleteImage = fs.unlinkSync(filePath);
  }
  return true;
}

function _deleteCheckDirectory(paidId) {
  fs.rmdir(
    `./images/checks/${paidId}`,
    { recursive: true, force: true },
    (err) => {
      if (err) {
        return console.log("error occurred in deleting directory", err);
      }
      console.log("Directory deleted successfully");
    }
  );
  return true;
}

async function getProjectById(projectId) {
  const getProjectQuery = `SELECT 
  ${process.env.DB_SCHEMA}.projects.id As id,
  ${process.env.DB_SCHEMA}.projects.projectName as projectName,
  ${process.env.DB_SCHEMA}.projects.clientFullName as clientFullName,
  ${process.env.DB_SCHEMA}.projects.clientPhone as clientPhone,
  ${process.env.DB_SCHEMA}.projects.location as location,
  ${process.env.DB_SCHEMA}.projects.createdAt as createdAt,
  ${process.env.DB_SCHEMA}.projects.updatedAt as updatedAt,
  ${process.env.DB_SCHEMA}.agreement.imagePath as agreement,
  ${process.env.DB_SCHEMA}.project_quotation.quotation as quotation,
  ${process.env.DB_SCHEMA}.project_quotation.notes as quotationNotes,
  (SELECT 
    SUM(paid)
FROM
    ${process.env.DB_SCHEMA}.project_pays
WHERE
    ${process.env.DB_SCHEMA}.project_pays.projectId = ${process.env.DB_SCHEMA}.projects.id
GROUP BY ${process.env.DB_SCHEMA}.project_pays.projectId) AS paid
FROM
${process.env.DB_SCHEMA}.projects  
      LEFT JOIN
       ${process.env.DB_SCHEMA}.agreement ON ${process.env.DB_SCHEMA}.projects.id = ${process.env.DB_SCHEMA}.agreement.projectId
      LEFT JOIN
       ${process.env.DB_SCHEMA}.project_quotation ON projects.id = ${process.env.DB_SCHEMA}.project_quotation.projectId
      LEFT JOIN 
       ${process.env.DB_SCHEMA}.project_pays ON projects.id = ${process.env.DB_SCHEMA}.project_pays.projectId
      where projects.id = ?`;
  const [rows] = await connection.execute(getProjectQuery, [projectId]);
  return rows[0];
}

async function getProjectPaids(id) {
  const values = [id];
  const getPaidsQuery = `
  SELECT 
        ${process.env.DB_SCHEMA}.project_pays.id as id,
        ${process.env.DB_SCHEMA}.project_pays.paidDate as paidDate,
        ${process.env.DB_SCHEMA}.project_pays.projectId as projectId,
        ${process.env.DB_SCHEMA}.project_pays.paid as paid,
        ${process.env.DB_SCHEMA}.project_pays.method as method,
        ${process.env.DB_SCHEMA}.project_pays.createdAt as createdAt,
        ${process.env.DB_SCHEMA}.project_pays.notes as notes,
        ${process.env.DB_SCHEMA}.checks_imgs.checksImgPath as checkImg
        FROM ${process.env.DB_SCHEMA}.project_pays
  left join ${process.env.DB_SCHEMA}.checks_imgs
on ${process.env.DB_SCHEMA}.checks_imgs.payId = ${process.env.DB_SCHEMA}.project_pays.id  
  where projectId = ?
  `;
  const [rows] = await connection.execute(getPaidsQuery, values);
  return rows;
}

async function insertCheckPhotoToDB(filePath, id) {
  const CheckPhotoQuery = `INSERT INTO ${process.env.DB_SCHEMA}.checks_imgs  (checksImgPath,payId) VALUES (?,?)`;
  const [rows] = await connection.execute(CheckPhotoQuery, [filePath, id]);
  return rows.affectedRows;
}

async function checkIfPaidExist(id) {
  const [rows] = await connection.execute(
    `       
SELECT 
${process.env.DB_SCHEMA}.project_pays.id as id,
${process.env.DB_SCHEMA}.project_pays.paidDate as paidDate,
${process.env.DB_SCHEMA}.project_pays.projectId as projectId,
${process.env.DB_SCHEMA}.project_pays.paid as paid,
${process.env.DB_SCHEMA}.project_pays.method as method,
${process.env.DB_SCHEMA}.project_pays.createdAt as createdAt,
${process.env.DB_SCHEMA}.checks_imgs.checksImgPath as checksImgPath
FROM ${process.env.DB_SCHEMA}.project_pays
left join ${process.env.DB_SCHEMA}.checks_imgs
on ${process.env.DB_SCHEMA}.checks_imgs.payId = ${process.env.DB_SCHEMA}.project_pays.id  
where project_pays.id  = ?`,
    [id]
  );
  return rows[0];
}

async function getProjectWithEmoloyeeTimeSheet(projectId) {
  const getProjectWithEmoloyeeTimeSheetQuery = `SELECT 
  ${process.env.DB_SCHEMA}.employeesTimeSheet.date AS 'date',
  CONCAT(${process.env.DB_SCHEMA}.employee.firstName,
          ' ',
          ${process.env.DB_SCHEMA}.employee.lastName) AS employeeName,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.startAt,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.endAt,
  ROUND(TIMESTAMPDIFF(MINUTE, startAt, endAt) / 60,
          2) AS 'hours',
  ${process.env.DB_SCHEMA}.employee.wagePerDay AS wagePerDay,
  ${process.env.DB_SCHEMA}.employeesTimeSheet.notes
FROM
  ${process.env.DB_SCHEMA}.employeesTimeSheet
      JOIN
  ${process.env.DB_SCHEMA}.employee ON ${process.env.DB_SCHEMA}.employeesTimeSheet.employeeId = ${process.env.DB_SCHEMA}.employee.id
      JOIN
  ${process.env.DB_SCHEMA}.projects ON ${process.env.DB_SCHEMA}.employeesTimeSheet.projectId = ${process.env.DB_SCHEMA}.projects.id
  WHERE ${process.env.DB_SCHEMA}.projects.id = ? 
ORDER BY date `;
  const [rows] = await connection.execute(
    getProjectWithEmoloyeeTimeSheetQuery,
    [projectId]
  );
  return rows[0];
}

module.exports = {
  createProject,
  checkIfProjectExist,
  insertQuotationForProject,
  insertPaidsForProject,
  checkIfPaidExist,
  updateQuotation,
  insertCheckPhotoToDB,
  editProject,
  updateCheckPhotoToDB,
  getCheckByPaidId,
  getAgreementByProjectId,
  getProjectPaids,
  getProjects,
  getProjectById,
  editPaid,
  deletePaidById,
  _deleteCheckDirectory,
  getProjectsCount,
  deleteProjectById,
  insertPhotoToDB,
  deleteProjectAgreement,
  updatePhotoToDB,
  _deleteImageFromStorage,
  getNotesForProject,
  insertNotesForProject,
  updateNotesForProject,
  deleteNotesForProject,
};
