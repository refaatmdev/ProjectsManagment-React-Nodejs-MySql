const express = require("express");
const router = express.Router();
const {
  getCompanyDetails,
  insertCompanyDetails,
  insertTables,
} = require("../controllers/company");
const { protect } = require("../controllers/jwt");
const { createUser } = require("../controllers/users");

router.use(protect);
router.get("/getCompanyDetails", async (req, res, next) => {
  try {
    const result = await getCompanyDetails();
    res.json(result);
  } catch (ex) {
    return next({ message: ex.message, status: 401 });
  }
});

router.post("/insertCompanyDetails", async (req, res, next) => {
  try {
    console.log(req.body);
    const result = await insertCompanyDetails(req.body);
    if (!result)
      throw new Error("something went wrong with inserting company details");
    let obj = {
      email: req.body.email,
      firstName: req.body.owner,
      lastName: req.body.lastName,
      password: req.body.password,
      role: "User",
    };
    const createNewUser = await createUser(obj);
    if (!createNewUser)
      throw new Error("something went wrong with creating new user");
    res.json({
      msg: "setting up the company succse",
      result: result,
      user: createNewUser,
    });
  } catch (ex) {
    return next({ message: ex.message, status: 401 });
  }
});

router.get("/setUp", async (req, res, next) => {
  try {
    const getDetails = await getCompanyDetails();
    res.json({ msg: "done", resultL: getDetails });
  } catch (ex) {
    console.log("inserting.....");
    const insert = await insertTables();
    if (insert) console.log("done!!");
    res.json({ msg: "done", resultL: insert });
  }
});

module.exports = router;
