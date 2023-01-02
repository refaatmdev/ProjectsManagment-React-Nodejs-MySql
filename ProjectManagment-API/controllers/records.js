const connection = require("../database/index");
const moment = require("moment");

async function getRecordById(recordId) {
  const getReocordQuery = `
  SELECT * FROM ${process.env.DB_SCHEMA}.employeesTimeSheet
	left join 
	  ${process.env.DB_SCHEMA}.workedProjects ON ${process.env.DB_SCHEMA}.workedProjects.dayId = ${process.env.DB_SCHEMA}.employeesTimeSheet.id
where ${process.env.DB_SCHEMA}.employeesTimeSheet.id = ${recordId}
  `;
  const [rows] = await connection.execute(getReocordQuery);
  return rows;
}

async function checkIfRecordEx(date) {
  const getReocordQuery = `
  SELECT * FROM ${process.env.DB_SCHEMA}.employeesTimeSheet where date = ?
  `;
  const [rows] = await connection.execute(getReocordQuery, [date]);
  return rows;
}

async function editRecord(oldRecords, newRecords) {
  const checkIfProjectsChanged = await _checkProjectsIfChanged(
    oldRecords,
    newRecords
  );
}

async function checkProjectsIfChanged(oldRecords, newRecords) {
  const extractRemovedProjects = oldRecords.filter(
    (el) => !newRecords.projectId.includes(el.projectId)
  );
  if (extractRemovedProjects.length > 0)
    await extractRemovedProjects.map((oldProject) =>
      _deleteDailyWorkPlace(oldProject.id)
    );
  const extractNewProjects = newRecords.projectId.filter(
    (el) => !oldRecords.find((old) => old.projectId === el)
  );

  if (extractNewProjects.length > 0) {
    const newRecs = {
      ...newRecords,
      employeeId: newRecords.employeeId[0],
      projectId: extractNewProjects,
    };
    //--> const newRecs =await _splitProjectsId(extractNewProjects,newRecords);
    //--> const result = await addUpdatedRecords(newRecs);
    const records = newRecs.projectId.map(async (projectId) => {
      // console.log("newRecs", projectId);
      await addWorkedProject(newRecs.id, projectId); //dayId,projectId
    });
  }
}
async function checkProjectsIfChangedReact(oldRecords, newRecords) {
  const extractRemovedProjects = oldRecords.filter(
    (el) => !newRecords.projectId.includes(el.projectId)
  );
  if (extractRemovedProjects.length > 0)
    await extractRemovedProjects.map((oldProject) =>
      _deleteDailyWorkPlace(oldProject.id)
    );
  const extractNewProjects = newRecords.projectId.filter(
    (el) => !oldRecords.find((old) => old.projectId === el)
  );

  if (extractNewProjects.length > 0) {
    const newRecs = {
      ...newRecords,
      employeeId: newRecords.employeeId,
      projectId: extractNewProjects,
    };
    //--> const newRecs =await _splitProjectsId(extractNewProjects,newRecords);
    //--> const result = await addUpdatedRecords(newRecs);
    const records = newRecs.projectId.map(async (project) => {
      // console.log("newRecs", projectId);
      await addWorkedProject(newRecs.id, project); //dayId,projectId
    });
  }
}

async function addWorkedProject(dayId, project) {
  const { projectId, notes = "" } = project;
  const values = [dayId, projectId, notes];
  const addToWorkedProjectQuery = `
  INSERT INTO ${process.env.DB_SCHEMA}.workedProjects (dayId, projectId,notes) VALUES (?, ?, ?);
  `;
  const [rows] = await connection.execute(addToWorkedProjectQuery, values);
  return rows;
}

async function _deleteDailyWorkPlace(id) {
  const deleteQuery = `DELETE FROM ${process.env.DB_SCHEMA}.workedProjects WHERE (id = ?);`;
  const [rows] = await connection.execute(deleteQuery, [id]);
  return rows.affectedRows;
}

async function _splitProjectsId(projectsIds, newRecords) {
  const records = projectsIds
    .map((projectId) => ({
      id: newRecords.id,
      date: newRecords.date,
      employeeId: newRecords.employeeId[0],
      projectId: projectId,
      startAt: newRecords.startAt,
      endAt: newRecords.endAt,
      notes: newRecords.notes,
      createdAt: newRecords.createdAt,
    }))
    .flat();
  return records;
}

async function updateRecord(data) {
  const { date, startAt, endAt, employeeId, notes, id } = data;
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
    id,
  ];
  console.log(values);
  const updateEmployeeHrQuery = `UPDATE ${process.env.DB_SCHEMA}.employeesTimeSheet SET date = ?, employeeId = ?, startAt = ?, endAt = ?, duration = ?,notes = ? WHERE id = ?;`;
  const [rows] = await connection.execute(updateEmployeeHrQuery, values);
  return rows.affectedRows;
}
async function addUpdatedRecords(record) {
  const { date, startAt, endAt, employeeId, notes, id } = record;
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
    id,
  ];
  const addRecordReuslt = await _updateRecordTimeSheet(values);
  return addWorkPlace(record, id);
}

async function addWorkPlace(record, addRecordReuslt) {
  const records = record.projectId.map(async (projectId) => {
    await addWorkedProject(addRecordReuslt, projectId);
  });
  return records;
}

async function _updateRecordTimeSheet(values) {
  const updateEmployeeHrQuery = `UPDATE ${process.env.DB_SCHEMA}.employeesTimeSheet SET date = ?, employeeId = ?, startAt = ?, endAt = ?, duration = ?,notes = ? WHERE id = ?;`;
  const [rows] = await connection.execute(updateEmployeeHrQuery, values);
  return rows.affectedRows;
}

async function deleteRecordById(recordId) {
  const deleteQuery = "DELETE FROM employeesTimeSheet WHERE (id = ?);";
  const [rows] = await connection.execute(deleteQuery, [recordId]);
  return rows.affectedRows;
}

module.exports = {
  updateRecord,
  getRecordById,
  checkProjectsIfChanged,
  checkProjectsIfChangedReact,
  deleteRecordById,
  checkIfRecordEx,
};
