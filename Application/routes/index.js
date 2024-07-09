const userRoutes = require("./user");
const visitorRoutes = require("./visitor")
module.exports = [].concat(
    userRoutes,
    visitorRoutes
)