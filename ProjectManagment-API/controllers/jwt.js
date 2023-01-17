const jwt = require("jsonwebtoken");
const authSec = require("./../config/auth.config");
const { isUserRegistered } = require("../controllers/users");
const asyncHandler = require("express-async-handler");

async function signJWT(data) {
  return new Promise((resolve, reject) => {
    jwt.sign(
      { exp: Math.floor(Date.now() / 1000) + 60 * 60 * 8, data },
      authSec.secret,
      function (err, token) {
        if (err) {
          console.log(err);
          reject(err);
        }
        resolve(token);
      }
    );
  });
}

const generateToken = (email) => {
  return jwt.sign({ email }, process.env.JWT_SECRET, { expiresIn: "4h" });
};

const protect = asyncHandler(async (req, res, next) => {
  try {
    const token = req.cookies.token;
    if (!token) {
      res.status(401);
      throw new Error("Not authorized, please login");
    }

    // Verify token
    const verified = jwt.verify(token, process.env.JWT_SECRET);
    // Get user id from token
    const user = await isUserRegistered(verified.email);
    if (!user) {
      res.status(404);
      throw new Error("User not found");
    }
    if (user.role === "suspended") {
      res.status(400);
      throw new Error("User suspended, please contact support");
    }

    req.user = user;
    next();
  } catch (ex) {
    return next({ message: ex.message, status: 401 });
  }
});

async function verifyToken(req, res, next) {
  if (!req.headers["x-access-token"]) {
    return res.status(401).json({ message: "No authorization header found" });
  }
  const token = req.cookie || req.headers["x-access-token"];
  if (!token) {
    return res.status(403).json({ message: "no token found" });
  }
  return jwt.verify(token, authSec.secret, (err, decoded) => {
    if (err) {
      if (err.expiredAt < new Date() || decoded == undefined) {
        return res.status(500).json({
          message: "token has expired , please login again",
          token: null,
        });
      }
    }
    req.user = decoded.data;
    next();
  });
}

async function isAdmin(req, res, next) {
  const result = await isUserRegistered(req.user.userName);
  if (!result) {
    return res.status(401).send({
      message: "Unauthorized!",
    });
  }
  if (result.role !== "Admin") return res.json("Require Admin Role!");
  if (result.role === "Admin") {
    next();
    return;
  }
}
module.exports = { signJWT, isAdmin, verifyToken, generateToken, protect };
