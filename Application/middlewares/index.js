const compression = require("compression");
const helmet = require("helmet");

const { authorize } = require("./auth");
const { multiLanguage } = require("./i18next");
const { limiter } = require("./limiter");
const { log_saver, logger } = require("./logger");
const { myCorsPolicy } = require("./cors")

module.exports = {
    myCorsPolicy,
    compression,
    helmet,
    limiter,
    authorize,
    log_saver,
    logger,
    multiLanguage
}