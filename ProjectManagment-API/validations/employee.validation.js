const Joi = require("@hapi/joi");

const createEmployeeSchema = Joi.object().keys({
  id: Joi.number().optional(),
  firstName: Joi.string().required(),
  lastName: Joi.string().required(),
  phone: Joi.string().required(),
  bankAccount: Joi.string().required(),
  bankBranch: Joi.string().required(),
  createdAt: Joi.string().required(),
  isActive: Joi.number().optional(),
});

const wageSchema = Joi.object().keys({
  employeeId: Joi.number().required(),
  dailyWage: Joi.number().required(),
  startFrom: Joi.string().required(),
});
const getEmployeeByIdSchema = Joi.object().keys({
  employeeId: Joi.number().required(),
});

const validationsObj = {
  createNewEmployee: (req, res, next) => {
    const { error } = createEmployeeSchema.validate(req.body);
    if (error) {
      return next(error.details);
    }
    return next();
  },
  wage: (req, res, next) => {
    const { error } = wageSchema.validate(req.body);
    if (error) {
      console.log(error.details);
      return next(error.details);
    }
    return next();
  },
  getEmployeeById: (req, res, next) => {
    const { error } = getEmployeeByIdSchema.validate(req.params);
    if (error) {
      console.log(error.details);
      return next(error.details);
    }
    return next();
  },
};

function getValidationFunctionEmployee(path) {
  return validationsObj[path];
}

module.exports = getValidationFunctionEmployee;
