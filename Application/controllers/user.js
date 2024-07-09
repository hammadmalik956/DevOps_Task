const { User } = require("../models");
const { validateUser } = require("../models/user");
const { sendResponse, castToMongoID, validationError, isMongoID } = require("../utils")

const createUser = async (req, res) => {
    const { error } = validateUser(req.body);
    if (error) {
        return sendResponse(res, "error", 422, validationError(error));
    }
    const { email, password, name } = req.body;
    const user = new User({ email, password, name });
    await user.save();
    return sendResponse(res, "success", 201, req.t("userCreated"));
}

const getUser = async (req, res) => {
    const { id } = req.params;
    if (!isMongoID(id)) {
        return sendResponse(res, "error", 500, req.t("isInvalidMongoID"));
    }
    const user = await User.findById(castToMongoID(id));
    if (!user) {
        return sendResponse(res, "error", 404, req.t("idNotFound"));
    }
    return sendResponse(res, "success", 200, req.t("userFetched"), user);
}

const removeUser = async (req, res) => {
    const { id } = req.params;
    if (!isMongoID(id)) {
        return sendResponse(res, "error", 500, req.t("isInvalidMongoID"));
    }
    const user = await User.deleteOne({ _id: castToMongoID(id) });
    if (user.deletedCount === 0) {
        return sendResponse(res, "error", 404, req.t("idNotFound"));
    }
    return sendResponse(res, "success", 200, req.t("userDeleted"));
}

const updateUser = async (req, res) => {
    const { id } = req.params;
    if (!isMongoID(id)) {
        return sendResponse(res, "error", 500, req.t("isInvalidMongoID"));
    }
    const { email, name, password } = req.body;
    const user = await User.updateOne({ _id: castToMongoID(id) }, { email, name, password });
    if (user.modifiedCount === 0) {
        return sendResponse(res, "error", 404, req.t("idNotFound"));
    }
    return sendResponse(res, "success", 200, req.t("userUpdated"));
}

const getUsers = async (req, res) => {
    const users = await User.find();
    return sendResponse(res, "success", 200, req.t("usersFetched"), users);
}

module.exports = {
    createUser,
    getUser,
    removeUser,
    updateUser,
    getUsers
}