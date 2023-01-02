

const Joi = require("@hapi/joi")

const allowedValues = ["Business", "Private", "Investments"]

const accountSchema = Joi.object().keys({
    type: Joi.string().valid(...allowedValues).required(),
    users: Joi.array().items(Joi.number()),
})

const getAccountsSchema = Joi.object().keys({
    userId: Joi.number().optional(),
})

const validationsObj = {
    account: (req, res, next) => {
        const { error } = accountSchema.validate(req.body)
        if (error) {
            console.log(error.details)
            return next(error.details)
        }
        return next()
    },
    getAccounts: (req, res, next) => {
        const { error } = getAccountsSchema.validate(req.query)
        if (error) {
            console.log(error.details)
            return next(error.details)
        }
        return next()
    },
}

function getValidationFunction(path) {
    return validationsObj[path]
}


module.exports = getValidationFunction