const connection = require("../database/index");

async function calc(employeeRecords) {
  employeeRecords.map(async(record) => {
    const dailyWageFixed = Math.round(
      ((record.dailyWage / 8.5) * record.duration).toFixed(2)
    );
const values = [dailyWageFixed,record.id]
const updateDailyWage = "UPDATE `employeesTimeSheet` SET `payPerDay` = ? WHERE (`id` = ?);";
    const [rows] = await connection.execute(updateDailyWage, values);
     return rows;
   });
  return employeeRecords;
}
module.exports = { calc };
