const { visitorController } = require("../controllers");
const { errorCatcher } = require("../errors")
const express = require("express");
const router = express.Router();


router.post("/visitor",errorCatcher(visitorController.createVisitor))
router.get("/visitors", errorCatcher(visitorController.getVisitors));

module.exports = router;