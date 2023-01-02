const multer = require("multer");
const path = require("path");
const fs = require('fs')
const storage = multer.diskStorage({
  destination: (_req, file, cb) => {
    const dir = `./images/checks/${_req.body.projectId }`
    fs.exists(dir, exist => {
    if (!exist) {
      return fs.mkdir(dir, error => cb(error, dir))
    }
    return cb(null, dir)
    })
  },
  filename: function (_req, file, cb) {
    if (!file) {
      cb(null, false);
      next();
    }else{
      cb(
        null,
        _req.body.projectId + "-" + _req.params.paidId + "-" +Date.now() + path.extname(file.originalname)
      );
    }
    
  },
});
var uploadCheck = multer({
  storage: storage,
  limits: {
    files:1,
    fields: 10,
    fieldNameSize: 50, // TODO: Check if this size is enough
    fieldSize: 2 * 1024 * 1024, //TODO: Check if this size is enough
    fileSize: 15000000, // 150 KB for a 1080x1080 JPG 90
  },
  fileFilter: async function (_req, file, cb) {
    checkFileType(file, cb);
  },
}).single("checkImg");

function checkFileType(file, cb) {
  const filetypes = /jpeg|jpg|png|gif/;
  const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
  const mimetype = filetypes.test(file.mimetype);
  if (mimetype && extname) {
    return cb(null, true);
  } else {
    cb("Error: Images Only!");
  }
}

module.exports = uploadCheck;
