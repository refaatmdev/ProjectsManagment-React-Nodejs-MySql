

const Joi = require("@hapi/joi")

const getTimeSheetRecordaSchema = Joi.object().keys({
    pagesize:Joi.number().optional(),
    page:Joi.number().optional(),
    currentMonth:Joi.date().optional(),
    employeeId:Joi.string().optional(),
})

const createEmployeeSchema = Joi.object().keys({
    firstName: Joi.string().required(),
    lastName: Joi.string().required(),
    phone: Joi.string().required(),
    bankAccount :  Joi.number().required(),
    bankBranch: Joi.string().required(),
    createdAt: Joi.string().required(),
})


const wageSchema = Joi.object().keys({
    employeeId: Joi.number().required(),
    dailyWage: Joi.number().required(),
    startFrom: Joi.string().required(),
})
const getEmployeeByIdSchema = Joi.object().keys({
    employeeId: Joi.number().required(),
})

const validationsObj = {
    getTimeSheetRecorda: (req, res, next) => {
        const { error } = getTimeSheetRecordaSchema.validate(req.query)
        if (error) {
            return next(error.details)
        }
        return next()
    },
    
}

function getValidationFunctionTimeSheet(path) {
    return validationsObj[path]
}


module.exports = getValidationFunctionTimeSheet