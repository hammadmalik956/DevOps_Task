const { userController } = require("../controllers");
const { errorCatcher } = require("../errors")
const express = require("express");
const router = express.Router();


router.post("/user", errorCatcher(userController.createUser));
router.get("/user/:id", errorCatcher(userController.getUser));
router.delete("/user/:id", errorCatcher(userController.removeUser));
router.put("/user/:id", errorCatcher(userController.updateUser));
router.get("/users", errorCatcher(userController.getUsers));

module.exports = router;