const express = require("express");
const router = express.Router();
const upload = require("./../_helper/uploader");
const uploadCheck = require("./../_helper/uploaderCheck");
const getValidationFunction = require("../validations/project.validation");
const logger = require("../logger");
const moment = require("moment");
const currentTime = moment().utc();
const {
  createProject,
  checkIfProjectExist,
  insertQuotationForProject,
  insertPaidsForProject,
  insertCheckPhotoToDB,
  getCheckByPaidId,
  editPaid,
  updateQuotation,
  getProjectPaids,
  checkIfPaidExist,
  editProject,
  updateCheckPhotoToDB,
  deleteProjectById,
  deletePaidById,
  getProjects,
  getAgreementByProjectId,
  getProjectById,
  getProjectsCount,
  insertPhotoToDB,
  updatePhotoToDB,
  _deleteImageFromStorage,
  deleteProjectAgreement,
  getNotesForProject,
  insertNotesForProject,
  updateNotesForProject,
  deleteNotesForProject,
} = require("../controllers/project");

// create project
router.post("/", getValidationFunction("project"), async (req, res, next) => {
  try {
    const createproje = await createProject(req.body);
    if (!createproje) throw new Error("Project was not created");
    logger.info(
      `currentTime: ${currentTime} ###### New Project has been created`
    );
    res.json({
      message: "project  created",
    });
  } catch (ex) {
    logger.error(
      `${currentTime} - Creating Project Failed - ${error.message} `
    );
    return next({ message: ex.message, status: 400 });
  }
});

//update project
router.put(
  "/:projectId",
  getValidationFunction("getProjectById"),
  getValidationFunction("updateProject"),
  async (req, res, next) => {
    try {
      const projectId = req.params.projectId;
      const checkIfExist = await checkIfProjectExist(projectId);
      if (!checkIfExist) throw new Error('Invalid Project!"');
      const result = await editProject(req.body, projectId);
      if (!result) throw new Error("some thing went wrong with editing");
      logger.info(
        `currentTime: ${currentTime} ###### updated Project ${checkIfExist.projectName} has been updated sucssfully`
      );
      res.json({
        result,
      });
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} - updated Project ${checkIfExist.projectName} Faild- ${error.message} `
      );
      return next({ message: ex.message, status: 400 });
    }
  }
);

//get projects
router.post("/getProjects", async (req, res, next) => {
  const pageSize = +req.query.pagesize;
  const currentPage = +req.query.page;
  try {
    currentPage
      ? (projects = await getProjects(
          pageSize,
          currentPage,
          req.body.searchValue
        ))
      : (projects = await getProjects());
    if (!projects) throw new Error("No Projects");
    const total = await getProjectsCount();
    if (!total) throw new Error("error occured");
    logger.info(`currentTime: ${currentTime} ###### get Projects sucssfully`);
    res.json({ result: projects, total: total });
  } catch (error) {
    logger.error(
      `currentTime: ${currentTime} - get Projects Faild- ${error.message} `
    );
    return next({ message: error.message, status: 400 });
  }
});

//get project by id
router.get(
  "/:projectId",
  getValidationFunction("getProjectById"),
  async (req, res, next) => {
    const { projectId } = req.params;
    try {
      console.log("ehhlo");
      const result = await getProjectById(projectId);
      if (!result) throw new Error("No Project Found");
      logger.info(
        `currentTime: ${currentTime} ###### get Project ${result.projectName} sucssfully`
      );
      res.json(result);
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ###### get Project faild - ${error.message}`
      );
      return next({ message: "GENERAL ERROR", status: 400 });
    }
  }
);

//get paids by project id
router.get(
  "/getPaids/:id",
  getValidationFunction("getPaidsById"),
  async (req, res, next) => {
    const { id } = req.params;
    try {
      const result = await getProjectPaids(id);
      logger.info(
        `currentTime: ${currentTime} ###### get Paids ${id} sucssfully`
      );
      if (!result) throw new Error("something went wrong");
      res.json({ paids: result });
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ###### get Paids ${id} faild - ${error.message}`
      );
      return next({ message: ex.message, status: 400 });
    }
  }
);

//create new paid
router.post(
  "/paids",
  uploadCheck,
  getValidationFunction("createPaids"),
  async (req, res, next) => {
    try {
      const checkIfExist = await checkIfProjectExist(req.body.projectId);
      if (!checkIfExist) throw new Error('Invalid Project!"');
      const result = await insertPaidsForProject(req.body);
      if (!result) throw new Error("some thing went wrong to add paids");
      if (req.file) {
        const insertCheckImgToDb = await insertCheckPhotoToDB(
          req.file.path,
          result
        );
        if (!insertCheckImgToDb)
          throw new Error("some thing went wrong with insertImg Path");
      }
      logger.info(`currentTime: ${currentTime} ###### Created Paid Done`);
      res.json(result);
    } catch (error) {
      logger.error(
        `currentTime: ${currentTime} ###### Post New Paid  faild - ${error.message}`
      );
      next({ message: ex.message, status: 400 });
    }
  }
);

//update paid by id
router.put(
  "/paid/:paidId",
  uploadCheck,
  getValidationFunction("getPaidById"),
  getValidationFunction("createPaids"),
  async (req, res, next) => {
    const paidId = req.params.paidId;
    try {
      const checkIfPaidIsExist = await checkIfPaidExist(paidId);
      if (!checkIfPaidIsExist) throw new Error("paid id dosnt exist");
      const getOldChekImagePath = await getCheckByPaidId(paidId);
      const result = await editPaid(req.body, paidId);
      if (!result) throw new Error("some thing went wrong with editing");
      if (req.file) _deleteImageFromStorage(getOldChekImagePath);
      getOldChekImagePath === undefined && req.file
        ? await insertCheckPhotoToDB(req.file.path, paidId)
        : await updateCheckPhotoToDB(req.file.path, paidId);
      logger.info(
        `currentTime: ${currentTime} ###### Update Paid - ${paidId} Done`
      );
      res.json({
        result,
      });
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ###### Update Paid ${paidId} faild - ${ex.message}`
      );
      next({ message: ex.message, status: 400 });
    }
  }
);

router.post(
  "/quotation/:projectId",
  getValidationFunction("getProjectById"),
  upload,
  async (req, res, next) => {
    console.log(req.file);
    try {
      const checkIfExist = await checkIfProjectExist(req.params.projectId);
      if (!checkIfExist) throw new Error('Invalid Project!"');
      const result = await insertQuotationForProject(
        req.params.projectId,
        req.body
      );
      if (!result) throw new Error("somethin went wrong");
      if (req.file != undefined) {
        const insertArgegment = await insertPhotoToDB(
          req.file.path,
          req.params.projectId
        );
      }
      logger.info(
        `currentTime: ${currentTime} ###### Create Quotation for project - ${req.params.projectId} Done`
      );
      res.json({ msg: "insert succsce" });
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ###### Create Quotation for project - ${req.params.projectId}- ${ex.message}`
      );
      next({ message: ex.message, status: 400 });
    }
  }
);

router.post(
  "/notes/:projectId",
  getValidationFunction("getProjectById"),
  async (req, res, next) => {
    const projectId = req.params.projectId;
    console.log(req.params.projectId);
    try {
      const checkIfExist = await checkIfProjectExist(req.params.projectId);
      if (!checkIfExist) throw new Error('Invalid Project!"');
      const result = await insertNotesForProject(
        req.body,
        req.params.projectId
      );
      res.json(result);
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ###### Create Note for project - ${req.params.projectId}- ${ex.message} failed`
      );
      next({ message: ex.message, status: 400 });
    }
  }
);
router.get(
  "/notes/:projectId",
  getValidationFunction("getProjectById"),
  async (req, res, next) => {
    const projectId = req.params.projectId;
    console.log(req.params.projectId);
    try {
      const result = await getNotesForProject({ projectId: projectId });
      res.json({
        result,
      });
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ###### Create Note for project - ${req.params.projectId}- ${ex.message} failed`
      );
      next({ message: ex.message, status: 400 });
    }
  }
);
router.put(
  "/notes/:projectId",
  getValidationFunction("getProjectById"),
  async (req, res, next) => {
    const projectId = req.params.projectId;
    try {
      const checkIfExist = await checkIfProjectExist(req.params.projectId);
      if (!checkIfExist) throw new Error('Invalid Project!"');
      const checlIfNoteISExist = await getNotesForProject({
        projectId: req.params.projectId,
      });
      const result = await updateNotesForProject(
        req.body,
        req.params.projectId
      );
      res.json("result");
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ###### update Note for project - ${req.params.projectId}- ${ex.message} failed`
      );
      next({ message: ex.message, status: 400 });
    }
  }
);
router.delete(
  "/notes/:projectId/:id",
  getValidationFunction("getProjectNotesId"),
  async (req, res, next) => {
    const { projectId, id } = req.params;
    try {
      const checkIfExist = await getNotesForProject({
        projectId: projectId,
        id: id,
      });
      if (!checkIfExist) throw new Error('Invalid Project!"');
      const result = await deleteNotesForProject(id);
      console.log(result);
      if (result) res.json({ msg: "note have been deleted" });
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ###### Delete Note for project - ${projectId}- ${ex.message} failed`
      );
      next({ message: ex.message, status: 400 });
    }
  }
);

router.put(
  "/updateQuotation/:projectId",
  getValidationFunction("getProjectById"),
  upload,
  async (req, res, next) => {
    try {
      const checkIfExist = await checkIfProjectExist(req.params.projectId);
      if (!checkIfExist) throw new Error('Invalid Project!"');
      const result = await updateQuotation(req.body, req.params.projectId);
      if (!result) throw new Error("somethin went wrong");
      const getOldImagePath = await getAgreementByProjectId(
        req.params.projectId
      );
      if (req.file) _deleteImageFromStorage(getOldImagePath);
      getOldImagePath === undefined && req.file
        ? await insertPhotoToDB(req.file.path, req.params.projectId)
        : await updatePhotoToDB(req.file.path, req.params.projectId);
      logger.info(
        `currentTime: ${currentTime} ###### Update Quotation for project - ${req.params.projectId} Done`
      );
      res.json({ msg: "edit succsce" });
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ######  Update Quotation for project - ${req.params.projectId}- ${ex.message}`
      );
      next({ message: "url : " + req.url + " " + ex.message, status: 400 });
    }
  }
);

router.delete(
  "/:projectId",
  getValidationFunction("getProjectById"),
  async (req, res, next) => {
    const projectId = req.params.projectId;
    console.log("req.params.projectId", req.params.projectId);
    try {
      const checkIfProjectExist = await getProjectById(projectId);
      if (!checkIfProjectExist) throw new Error("Invalid project");
      const result = await deleteProjectById(projectId);
      if (!result) throw new Error("error in deleteing project");
      console.log(checkIfProjectExist.agreement);
      const deleteImage = _deleteImageFromStorage(
        checkIfProjectExist.agreement
      );
      logger.info(
        `currentTime: ${currentTime} ###### delete project - ${req.params.projectId} Done`
      );
      res.status(200).json(`you have deleted projectId ${projectId}`);
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ######  delete project - ${req.params.projectId} - ${ex.message}`
      );
      return next({ message: ex.message, status: 400 });
    }
  }
);

router.delete(
  "/agreement/:projectId",
  getValidationFunction("getProjectById"),
  async (req, res, next) => {
    const projectId = req.params.projectId;
    console.log("req.params.projectId", req.params.projectId);
    try {
      const checkIfProjectExist = await getProjectById(projectId);
      if (!checkIfProjectExist) throw new Error("Invalid project");
      const result = await deleteProjectAgreement(projectId);
      if (!result) throw new Error("error in deleteing agreement");
      console.log(checkIfProjectExist.agreement);
      const deleteImage = _deleteImageFromStorage(
        checkIfProjectExist.agreement
      );
      logger.info(
        `currentTime: ${currentTime} ###### delete project - ${req.params.projectId} Done`
      );
      res.status(200).json(`you have deleted projectId ${projectId}`);
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ######  delete project - ${req.params.projectId} - ${ex.message}`
      );
      return next({ message: ex.message, status: 400 });
    }
  }
);

router.delete(
  "/paidById/:paidId",
  getValidationFunction("getPaidById"),
  async (req, res, next) => {
    const paidId = req.params.paidId;
    try {
      const checkIfPaidIsExist = await checkIfPaidExist(paidId);
      if (!checkIfPaidIsExist) throw new Error("Invalid Paid");
      const result = await deletePaidById(paidId);
      if (!result) throw new Error("error in deleteing project");
      const deleteImage = _deleteImageFromStorage(
        checkIfPaidIsExist.checksImgPath
      );
      if (!deleteImage) throw new Error("something went wrong");
      logger.info(
        `currentTime: ${currentTime} ###### delete paid - ${req.params.paidId} Done`
      );
      res.status(200).json(`you have deleted paid ${paidId}`);
    } catch (ex) {
      logger.error(
        `currentTime: ${currentTime} ######  delete paid - ${req.params.paidId} - ${ex.message}`
      );
      return next({ message: ex.message, status: 400 });
    }
  }
);

module.exports = router;
