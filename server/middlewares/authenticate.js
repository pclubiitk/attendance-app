const { getUser } = require("../Queries/userQueries");

const jwt = require("jsonwebtoken");

// Need to add time limit or expiry time for token
exports.authenticateToken = (req, res, next) => {
  console.log("authenticate middleware got hit");
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) {
    return res.status(401).json({ message: "No token, authorization denied" });
  }
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.userId = decoded.user.userId;
    next();
  } catch (err) {
    if (err.name === "TokenExpiredError") {
      return res.status(401).json({ message: "Token expired" });
    }
    res
      .status(401)
      .json({ message: "Verification failed, token is not valid" });
  }
};
// TODO: Do we need, to again check the role, as already in token?
exports.authenticateUserRole = async (req, res, next) => {
  try {
    const userId = req.userId;
    const user = await getUser(userId);
    if (user.role === "ADMIN") {
      next();
    } else {
      res.status(401).json({ message: "User does not have authority" });
    }
  } catch (error) {
    res.status(500).json({ error });
  }
};
