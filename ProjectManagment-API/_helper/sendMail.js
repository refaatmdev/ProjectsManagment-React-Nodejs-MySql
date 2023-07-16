const nodemailer = require("nodemailer");
var fs = require("fs");

async function sendEmail(file, date, project) {
  const mail = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 465, // Port
    secure: true,
    auth: {
      user: "rafe.mulla@gmail.com",
      pass: "pjklallrpwfpbaxh",
    },
  });

  const mailOptions = {
    from: "rafe.mulla@gmail.com",
    to: "rafe.mulla@gmail.com",
    subject: `BACKUP FOR ${project} - ${date}`,
    html: `BACKUP FOR ${project} - ${date}`,
    attachments: [
      {
        filename: file,
        path: file,
      },
    ],
  };

  await mail.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
    } else {
      console.log("Email sent: " + info.response);
      if (info.response) {
        fs.unlink(file, () => {
          console.log("backup file deleted");
        });
      }
    }
  });
}

module.exports = { sendEmail };
