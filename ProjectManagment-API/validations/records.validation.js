const Joi = require("@hapi/joi");

const postRecordsSchema = Joi.object().keys({
  id: Joi.number().optional(),
  date: Joi.date().required(),
  employeeId: Joi.array().required(),
  projectId: Joi.array().required(),
  startAt: Joi.date().required(),
  endAt: Joi.date().required(),
  notes: Joi.string().allow(null, "").optional(),
  createdAt: Joi.date().required(),
});

const updateRecordsSchema = Joi.object().keys({
  id: Joi.number().required(),
  date: Joi.date().required(),
  employeeId: Joi.number().required(),
  projectId: Joi.array().required(),
  startAt: Joi.date().required(),
  endAt: Joi.date().required(),
  notes: Joi.string().allow(null, "").optional(),
  createdAt: Joi.date().optional(),
});

const recordIdSchema = Joi.object().keys({
  recordId: Joi.number().required(),
});

const currentMonthSchema = Joi.object().keys({
  currentMonth: Joi.date().required(),
});
const validationsObj = {
  postRecords: (req, res, next) => {
    const { error } = postRecordsSchema.validate(req.body);
    if (error) {
      return next(error.details);
    }
    return next();
  },
  updateRecords: (req, res, next) => {
    const { error } = updateRecordsSchema.validate(req.body);
    if (error) {
      return next(error.details);
    }
    return next();
  },
  recordId: (req, res, next) => {
    const { error } = recordIdSchema.validate(req.params);
    if (error) {
      return next(error.details);
    }
    return next();
  },
  currentMonth: (req, res, next) => {
    const { error } = currentMonthSchema.validate(req.body);
    if (error) {
      return next(error.details);
    }
    return next();
  },
};

function getValidationFunctionRecords(path) {
  return validationsObj[path];
}

module.exports = getValidationFunctionRecords;
