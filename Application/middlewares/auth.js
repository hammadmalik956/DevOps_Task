const JWT = require("jsonwebtoken");
const config = require("config");
const { sendResponse } = require("../utils");

const JWT_SECRET_KEY = config.get('JWT_SECRET_KEY');

const authorize = async (req, res, next) => {
    const bearerHeader = req.headers['authorization'];
    if (typeof bearerHeader !== "undefined") {
        const bearerToken = bearerHeader.split(' ')[1];
        JWT.verify(bearerToken, JWT_SECRET_KEY, async (err, data) => {
            if (err) {
                return sendResponse(res, "fail", 401, req.t("invalidToken"));
            } else {
                next();
            }
        });
    } else {
        return sendResponse(res, "fail", 401, req.t("noToken"));
    }
}

module.exports = { authorize };