const express = require("express");
const path = require("path");

const { PORT, HOSTNAME } = require("./constants")
const { connect_database } = require("./models");
const { myCorsPolicy } = require("./middlewares");
const { errorHandler, routeNotFound } = require("./errors");
const routes = require("./routes");
const port = process.env.PORT || PORT;
const host = process.env.HOST || HOSTNAME;

const app = express();

app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(myCorsPolicy());

app.use("/api/", routes);
app.use(errorHandler);
app.use(routeNotFound);

app.use(express.static(path.join(__dirname, 'public')));

app.listen(port, () => {
    console.log("SERVER RUNNING AT " + host + ":" + port);
    connect_database();
});


module.exports = { app }