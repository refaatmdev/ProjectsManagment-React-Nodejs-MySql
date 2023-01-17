const express = require("express");
const router = express.Router();
const logger = require("../logger");
const moment = require("moment");
const currentTime = moment().utc();
const getValidationFunctionEmployee = require("../validations//employee.validation");

const {
  createEmployee,
  getEmployees,
  getEmployeeById,
  getEmployeesCount,
  editEmployee,
  deleteEmployeeById,
  addDailyWage,
} = require("../controllers/employee");
const { protect } = require("../controllers/jwt");

router.use(protect);
//create new employee
router.post(
  "/",
  getValidationFunctionEmployee("createNewEmployee"),
  async (req, res, next) => {
    console.log(req.body);
    try {
      const createEmployeeResult = await createEmployee(req.body);
      if (!createEmployeeResult) throw new Error("something went worng");
      logger.info(
        `currentTime: ${currentTime} ###### New Employee has been created`
      );
      res.json({ message: "employee created" });
    } catch (ex) {
      logger.error(
        `${currentTime} - Creating Employee Failed - ${error.message} `
      );
      return next({ message: ex.message, status: 500 });
    }
  }
);

router.post(
  "/addDailyWage",
  getValidationFunctionEmployee("wage"),
  async (req, res, next) => {
    const { employeeId, dailyWage, startFrom } = req.body;
    console.log(req.body);
    try {
      const checkIfEmployeeExist = await getEmployeeById(employeeId);
      if (!checkIfEmployeeExist) throw new Error("Invalid employee");
      const result = await addDailyWage(employeeId, dailyWage, startFrom);
      if (!result) throw new Error("error in deleteing employee");
      logger.info(
        `currentTime: ${currentTime} ###### new Daily wage for ${employeeId} - ${dailyWage} - start from ${startFrom}`
      );
      res
        .status(200)
        .json(
          `new Daily wage for ${employeeId} - ${dailyWage} - start from ${startFrom}`
        );
    } catch (ex) {
      logger.error(
        `${currentTime} - Update / Add Wage Failed - ${error.message} `
      );
      next({ message: ex.message, status: 400 });
    }
  }
);

router.post("/getEmployees", async (req, res, next) => {
  const pageSize = +req.query.pagesize;
  const currentPage = +req.query.page;
  console.log(pageSize, currentPage, req.body.searchValue, req.body);
  try {
    currentPage
      ? (employees = await getEmployees(
          pageSize,
          currentPage,
          req.body.searchValue
        ))
      : (employees = await getEmployees(null, null, null, req.body.employeeId));
    if (!employees) throw new Error("no employees");
    const total = await getEmployeesCount();
    if (!total) throw new Error("error occured");
    logger.info(`currentTime: ${currentTime} ###### fetch employee succses`);
    res.json({ result: employees, total: total });
  } catch (error) {
    logger.error(`${currentTime} - fetch employee  Failed - ${error.message} `);
    return next({ message: error.message, status: 400 });
  }
});

router.get(
  "/:employeeId",
  getValidationFunctionEmployee("getEmployeeById"),
  async (req, res, next) => {
    const id = req.params.employeeId;
    console.log("dfgdfwd", id);
    try {
      const result = await getEmployeeById(id);
      if (!result) throw new Error("no employees");
      console.log(result);
      res.json(result);
    } catch (ex) {
      return next({ message: ex.message, status: 401 });
    }
  }
);

router.put(
  "/:employeeId",
  getValidationFunctionEmployee("getEmployeeById"),
  getValidationFunctionEmployee("createNewEmployee"),
  async (req, res, next) => {
    console.log(req.body);
    console.log(req.params);
    try {
      var employeeId = req.params.employeeId;
      const checkIfEmployeeExist = await getEmployeeById(employeeId);
      if (!checkIfEmployeeExist) throw new Error("Invalid employee");
      const result = await editEmployee(req.body, employeeId);
      if (!result) throw new Error("some thing went wrong with editing");
      logger.info(
        `currentTime: ${currentTime} ###### updating employee succses`
      );
      res.json({
        result,
      });
    } catch (ex) {
      logger.error(
        `${currentTime} - updating employee ${employeeId} Failed - ${ex.message} `
      );
      return next({ message: ex.message, status: 400 });
    }
  }
);

router.delete(
  "/:employeeId",
  getValidationFunctionEmployee("getEmployeeById"),
  async (req, res, next) => {
    const employeeId = req.params.employeeId;
    try {
      const checkIfEmployeeExist = await getEmployeeById(employeeId);
      if (!checkIfEmployeeExist) throw new Error("Invalid employee");
      const result = await deleteEmployeeById(employeeId);
      if (!result) throw new Error("error in deleteing employee");
      res.status(200).json(`you have deleted employeeId ${employeeId}`);
      // logger.info(`${req.user.userName} has deleted vacationId ${vacationId}`);
    } catch (ex) {
      return next({ message: ex.message, status: 400 });
    }
  }
);

module.exports = router;
