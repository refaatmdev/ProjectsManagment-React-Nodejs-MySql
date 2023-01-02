const express = require("express");
const router = express.Router();
const logger = require("../logger");
const moment = require("moment");
const bcrypt = require("bcryptjs");
const { signJWT, isAdmin } = require("../controllers/jwt");
const {
  isUserRegistered,
  createUser,
  changePassword,
} = require("../controllers/users");

const getValidationFunction = require("../validations/login.validation");
const currentTime = moment().utc();

router.post(
  "/login",
  getValidationFunction("login"),
  async (req, res, next) => {
    const { email, password } = req.body;

    try {
      logger.info(`tring to login - email: ${email} - ${currentTime}`);
      if (!email || !password) res.send("error");
      const result = await isUserRegistered(email);
      if (!result) throw new Error('Invalid email!"');
      const passwordIsValid = bcrypt.compareSync(password, result.password);
      if (!passwordIsValid) throw new Error('Invalid Password!"');
      if (result) {
        const token = await signJWT(result);
        logger.info(
          `currentTime: ${currentTime} ###### Logged User :${result.firstName}  Role : ${result.role}`
        );
        res.cookie("auth", token);

        return res.json({
          message: `redirect`,
          id: result.id,
          email: result.email,
          role: result.role,
          accessToken: token,
        });
      }
    } catch (error) {
      logger.error(`${currentTime} - Login Failed - ${error.message} `);
      return res.json({
        message: `Login Failed - ${error.message}`,
        status: 500,
      });
    }
  }
);

const _registerPath = "register";
router.post(
  `/${_registerPath}`,
  getValidationFunction(_registerPath),
  async (req, res, next) => {
    const { email } = req.body;
    try {
      const result = await isUserRegistered(email);
      console.log(result);
      if (result) throw new Error(`User ${result.email} is already exist`);
      const create = await createUser(req.body);
      if (create) {
        logger.info(
          `currentTime: ${currentTime} ###### Register New User :${email}`
        );
        return res.json({ message: `Registration completed`, complete: true });
      } else throw new Error("Registration Failed");
    } catch (error) {
      logger.error(`${currentTime} - Registration Failed - ${error.message} `);
      return next({ message: error.message, status: 500 });
    }
  }
);


const _changePasswordPath = "changePassword";
router.post(
  `/${_changePasswordPath}`,
  getValidationFunction(_changePasswordPath),
  async (req, res, next) => {
    const { email, password, newPassword, confirmNewPassword } = req.body;
    try {
      _validateConfirmPassword(newPassword, confirmNewPassword);

      const result = await isUserRegistered(email, password);
      if (!result) throw new Error(`Wrong Credentials`);
      const changePassResult = await changePassword(result.id, newPassword);
      if (changePassResult)
        return res.json({ message: "password has changed!!!" });
      else throw new Error(`[password] was not updated`);
    } catch (ex) {
      console.log(ex.message);
      return next({ message: ex.message, status: 400 });
    }

    function _validateConfirmPassword() {
      if (typeof newPassword !== "string") {
        console.log("newPassword type wrong");
        return;
      }
      if (newPassword !== confirmNewPassword)
        throw new Error(`confirm password error`);
    }
  }
);

module.exports = router;
