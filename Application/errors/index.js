const { sendResponse } = require("../utils");

const routeNotFound = (req, res) => {
    console.log("Error = > Route Not Found");
    return sendResponse(res, "error", 404, req.t("routeNotFound"));
}

const welcome = (req, res, next) => {
    return sendResponse(res, "success", 200, req.t("welcome"))
}

const errorHandler = (error, req, res, next) => {
    console.log("Error Name", error.name);
    switch (error.name) {
        case "MongoServerError": // Or MongoError
            if (error.code === 11000) {
                const field = Object.keys(error.keyValue)[0];
                const message = field.toUpperCase() + " " + req.t("isDuplcate");
                console.log("Error = > ", message)
                return sendResponse(res, "fail", 409, message);
            }
            break;
        default:
            break;
    }

    const STRIPE_ERROR_TYPES = ["StripeCardError", "StripeRateLimitError", "StripeInvalidRequestError", "StripeAPIError", "StripeConnectionError", "StripeAuthenticationError"];

    if (error.type && error.type.includes(STRIPE_ERROR_TYPES)) {
        const errorMessage = error.message + " (" + error.param + ")";
        console.log("Error = > ", errorMessage);
        return sendResponse(res, "fail", error.statusCode, errorMessage);
    }

    const status = error.status || 500;
    console.log("Error = > ", error.message);
    return sendResponse(res, "error", status, error.message);
}

const errorCatcher = (controller) => {
    return (req, res, next) => {
        Promise.resolve(controller(req, res, next).catch(next));
    }
}

module.exports = {
    routeNotFound,
    errorHandler,
    errorCatcher,
    welcome
}