require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const api = express();
const cors = require("cors");
const logger = require("./logger");
const cron = require("node-cron");

const auth = require("./routes/auth");
const projects = require("./routes/projects");
const employee = require("./routes/employee");
const timesSheet = require("./routes/timeSheets");
const company = require("./routes/company");
const { createBackUp } = require("./database/backup");

logger.info("Server started!");

const envParams = ["MAX_SESSION_TIME", "PORT"];
function validateEnvParams() {
  envParams.forEach((envParamName) => {
    if (!process.env[envParamName]) {
      console.log("\x1b[33m%s\x1b[0m", `Missing env param: ${envParamName}`);
      logger.error(`Missing env param: ${envParamName}`);
      setTimeout(() => {
        process.exit(1);
      }, 2000);
    }
  });
}

validateEnvParams();

api.use("/images", express.static(__dirname + "/images"));

api.use("/", express.static("public/project"));

api.use(express.json());
api.use(express.urlencoded({ extended: false }));
api.use(cookieParser());
api.use(bodyParser.json());

api.use(
  cors({
    origin: ["http://localhost:3000", "http://localhost:3001"],
    credentials: true,
  })
);

api.get("/health-check", (req, res, next) => {
  res.send("Api working");
});

api.use("/auth", auth);
api.use("/projects", projects);
api.use("/employee", employee);
api.use("/timesSheet", timesSheet);
api.use("/company", company);

cron.schedule("0 1 * * *", function () {
  createBackUp();
});

api.use((error, req, res, next) => {
  console.log("error handler", error);
  const status = error.status || 500;
  res.status(status).json(error.message);
});

api.listen(process.env.PORT, () => {
  console.log(`Server is listening to Port ${process.env.PORT}`);
});
