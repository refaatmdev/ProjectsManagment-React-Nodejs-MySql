async function getSalaryByMonth(currentMonth) {
  const month = moment(currentMonth).month() + 1;
  const year = moment(currentMonth).year();
  const values = [currentMonth, currentMonth, month, year];
  const query = `
  SELECT 
  projects_managment.salary.salaryDate as salaryDate,
  projects_managment.employee.id AS employeeId,
  projects_managment.employee.firstName AS firstName,
  projects_managment.employee.lastName AS lastName,
  projects_managment.salary.salary,
(SELECT 
          dailywage
      FROM
          projects_managment.employeeDailyWage
      WHERE
          startFromDate <= ?
              AND projects_managment.employeeDailyWage.employeeId = projects_managment.employee.id
      ORDER BY startFromDate DESC
      LIMIT 1) AS dailyWage,
(SELECT 
          startFromDate
      FROM
          projects_managment.employeeDailyWage
      WHERE
          startFromDate <= ?
              AND projects_managment.employeeDailyWage.employeeId = projects_managment.employee.id
      ORDER BY startFromDate DESC
      LIMIT 1) AS startFromDate,
SUM(projects_managment.employeesTimeSheet.duration) as duration
FROM
  projects_managment.employeesTimeSheet
  Left Join					
 projects_managment.employee ON projects_managment.employeesTimeSheet.employeeId = projects_managment.employee.id
  left join 
projects_managment.salary ON projects_managment.salary.employeeId = projects_managment.employee.id
WHERE
  MONTH(date) = ? AND YEAR(date) = ?
GROUP BY  projects_managment.employee.id
ORDER BY projects_managment.employee.lastName asc  
`;

  // SELECT
  // projects_managment.salary.salaryDate as salaryDate,
  // projects_managment.employee.id as employeeId,
  // projects_managment.employee.firstName as firstName,
  // projects_managment.employee.lastName as lastName,
  // projects_managment.salary.salary
  //  FROM projects_managment.salary
  // LEFT JOIN projects_managment.employee
  // ON projects_managment.employee.id = projects_managment.salary.employeeId
  // WHERE
  //   MONTH(salaryDate) = ? AND YEAR(salaryDate) = ?
  // ORDER BY projects_managment.salary.salary
  const [rows] = await connection.execute(query, values);
  return rows;
}
