const mysqldump = require("mysqldump");
const moment = require("moment");
const { sendEmail } = require("../_helper/sendMail");

const { DB_SCHEMA, DB_USER, DB_PASSWORD, DB_PORT, DB_HOST } = process.env;

const fileName = `${DB_SCHEMA}_${moment().format("YYYY_MM_DD")}.sql`;
const path = "./backup/" + fileName;
async function createBackUp() {
  console.log("create backup");
  mysqldump({
    connection: {
      host: DB_HOST || "localhost",
      user: DB_USER,
      password: DB_PASSWORD,
      database: DB_SCHEMA,
      port: DB_PORT,
    },
    dumpToFile: path,
  });
  await mysqldump({
    connection: {
      host: DB_HOST || "localhost",
      user: DB_USER,
      password: DB_PASSWORD,
      database: DB_SCHEMA,
      port: DB_PORT,
    },
  })
    .then(() => console.log("DB Backup Completed!"))
    .catch((e) => console.log(e));

  await sendEmail(path, moment().format("YYYY_MM_DD"), DB_SCHEMA);
}
module.exports = { createBackUp };

// const moment = require("moment");
// const fs = require("fs");
// const { exec } = require("child_process");

// const spawn = require("child_process").spawn;
// const { DB_SCHEMA, DB_USER, DB_PASSWORD, DB_PORT, DB_HOST } = process.env;

// function createBackUp() {
//   const fs = require("fs");
//   const spawn = require("child_process").spawn;
//   const dumpFileName = `${Math.round(Date.now() / 1000)}.dump.sql`;

//   const writeStream = fs.createWriteStream(dumpFileName);

//   const mysqldump = spawn("mysqldump", [
//     "-h",
//     process.env.DB_HOST,
//     "-u",
//     process.env.DB_USER,
//     "-p" + process.env.DB_PASS,
//     "--port="+process.env.DB_PORT,
//     DB_SCHEMA,
//   ]);
//   mysqldump.stdout.on("error", reject).pipe(writeStream);

//   writeStream.on("finish", resolve);
//   writeStream.on("error", reject);
//   // mysqldump.stdout
//   //   .pipe(writeStream)
//   //   .on("finish", function () {
//   //     console.log("Completed");
//   //   })
//   //   .on("error", function (err) {
//   //     console.log(err);
//   //   });
//   // exec(
//   //   `mysqldump --user=${DB_USER} --host=${DB_HOST} --password=${DB_PASSWORD} --result-file=./dbBackup.sql --databases ${DB_SCHEMA} --port=${DB_PORT}`
//   // );

//   // // cron.schedule('0 0 * * *', () => {
//   // // Use moment.js or any other way to dynamically generate file name
//   // const fileName = `${DB_SCHEMA}_${moment().format("YYYY_MM_DD")}.sql`;
//   // const wstream = fs.createWriteStream(`./${fileName}`);
//   // console.log("---------------------");
//   // console.log("Running Database Backup Cron Job");
//   // const mysqldump = spawn("mysqldump", [
//   //   ` --user ${DB_USER} --port ${DB_PORT} --host ${DB_HOST} --password ${DB_PASSWORD} --result-file=./dbBackup.sql --databases ${DB_SCHEMA} `,
//   // ]);
//   // console.log(
//   //   ` --user ${DB_USER} --port ${DB_PORT} --host ${DB_HOST} --password ${DB_PASSWORD} --result-file=./dbBackup.sql --databases ${DB_SCHEMA}`
//   // );
//   // mysqldump.stdout
//   //   .pipe(wstream)
//   //   .on("finish", () => {
//   //     console.log("DB Backup Completed!");
//   //   })
//   //   .on("error", (err) => {
//   //     console.log("err");
//   //     console.log(err);
//   //   });
//   // // })
// }

// module.exports = { createBackUp };

// // const mysqldump = require("mysqldump");
// // const fs = require("fs");
// // const moment = require("moment");

// // const { DB_SCHEMA, DB_USER, DB_PASSWORD, DB_PORT, DB_HOST } = process.env;

// // function backup() {
// //   console.log("backuo");
// //   const now = new Date();
// //   const dateString = now.toJSON().substring(0, 16).replace(":", "");
// //   const filename = `db-${dateString}.sql`;
// //   const path = "./dumps/" + filename;

// //   mysqldump({
// //     connection: {
// //       host: DB_HOST || "localhost",
// //       port: DB_PORT,
// //       user: DB_USER,
// //       password: DB_PASSWORD,
// //       database: DB_SCHEMA,
// //     },
// //     dumpToFile: path,
// //     compressFile: true,
// //   });
// //   console.log("done", path);
// // }

// // // dump the result straight to a file
// // const fileName = `${DB_SCHEMA}_${moment().format("YYYY_MM_DD")}`;

// // mysqldump({
// //   connection: {
// //     host: DB_HOST || "localhost",
// //     port: DB_PORT,
// //     user: DB_USER,
// //     password: DB_PASSWORD,
// //     database: DB_SCHEMA,
// //   },
// //   dump: { schema: { table: { dropIfExist: true } } },

// //   dumpToFile: __dirname + `/db/backup/${fileName}.sql`,
// // });

// // mysqldump({
// //   connection: {
// //     host: DB_HOST || "localhost",
// //     port: DB_PORT,

// //     user: DB_USER,
// //     password: DB_PASSWORD,
// //     database: DB_SCHEMA,
// //   },
// //   dumpToFile: __dirname + `/db/backup/${fileName}.sql.gz`,
// //   compressFile: true,
// // });

// // // dump the result straight to a compressed file
// // mysqldump({
// //   connection: {
// //     host: DB_HOST || "localhost",
// //     port: DB_PORT,

// //     user: DB_USER,
// //     password: DB_PASSWORD,
// //     database: DB_SCHEMA,
// //   },
// //   dumpToFile: __dirname + `/db/backup/${fileName}.sql.gz`,
// //   compressFile: true,
// // });

// // // return the dump from the function and not to a file
// // const createDbBackUp = async () =>
// //   await mysqldump({
// //     connection: {
// //       host: DB_HOST || "localhost",
// //       port: DB_PORT,

// //       user: DB_USER,
// //       password: DB_PASSWORD,
// //       database: DB_SCHEMA,
// //     },
// //   })
// //     .then(() => console.log("DB Backup Completed!"))
// //     .catch((e) => console.log(e));

// // module.exports = { backup };
