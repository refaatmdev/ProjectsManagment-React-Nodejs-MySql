const Joi = require("@hapi/joi");

const projectSchema = Joi.object().keys({
  projectName: Joi.string().required(),
  clientFullName: Joi.string().required(),
  clientPhone: Joi.string().required(),
  location: Joi.string().required(),
  createdAt: Joi.date().required(),
});

const updateProjectSchema = Joi.object().keys({
  projectName: Joi.string().required(),
  clientFullName: Joi.string().required(),
  clientPhone: Joi.string().required(),
  location: Joi.string().required(),
  createdAt: Joi.date().optional(),
});

const getProjectByIdSchema = Joi.object().keys({
  projectId: Joi.string().required(),
});

const getProjectNotesId = Joi.object().keys({
  projectId: Joi.string().required(),
  id: Joi.string().required(),
});

const createPaidSchema = Joi.object().keys({
  paidDate: Joi.string().required(),
  projectId: Joi.string().required(),
  paid: Joi.number().required(),
  method: Joi.string().required(),
  notes: Joi.string().allow(null, "").optional(),
  file: Joi.optional(),
  checkImg: Joi.optional(),
  createdAt: Joi.date().optional(),
});

const getPaidsByIdSchema = Joi.object().keys({
  id: Joi.string().required(),
});

const getPaidByIdSchema = Joi.object().keys({
  paidId: Joi.string().required(),
});

const validationsObj = {
  project: (req, res, next) => {
    const { error } = projectSchema.validate(req.body);
    if (error) {
      console.log(error.details);
      return next(error.details);
    }
    return next();
  },

  updateProject: (req, res, next) => {
    const { error } = updateProjectSchema.validate(req.body);
    if (error) {
      console.log(error.details);
      return next(error.details);
    }
    return next();
  },
  getProjectById: (req, res, next) => {
    const { error } = getProjectByIdSchema.validate(req.params);
    if (error) {
      console.log(error.details);
      return next(error.details);
    }
    return next();
  },
  getProjectNotesId: (req, res, next) => {
    const { error } = getProjectNotesId.validate(req.params);
    if (error) {
      console.log(error.details);
      return next(error.details);
    }
    return next();
  },
  getPaidsById: (req, res, next) => {
    const { error } = getPaidsByIdSchema.validate(req.params);
    if (error) {
      console.log(error.details);
      return next(error.details);
    }
    return next();
  },

  createPaids: (req, res, next) => {
    const { error } = createPaidSchema.validate(req.body);
    if (error) {
      console.log(error.details);
      return next(error.details);
    }
    return next();
  },
  getPaidById: (req, res, next) => {
    const { error } = getPaidByIdSchema.validate(req.params);
    if (error) {
      console.log(error.details);
      return next(error.details);
    }
    return next();
  },
};

function getValidationFunction(path) {
  return validationsObj[path];
}

module.exports = getValidationFunction;
