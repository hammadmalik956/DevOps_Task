// index.js

const { Sequelize } = require("sequelize");
const { DATABASE_URL, DATABASE_NAME, DATABASE_PASSWORD, DATABASE_USERNAME } = require("../constants");
const sequelize = new Sequelize(
    DATABASE_NAME,
    DATABASE_USERNAME,
    DATABASE_PASSWORD,
    {
        dialect: 'mysql',
        host: DATABASE_URL
    }
);

const connect_database = async () => {
    try {
        await sequelize.authenticate();
        console.log("Successfully Connected to Database");
    } catch (err) {
        console.log("MySQL database error:", err);
    }
};

module.exports = {
    connect_database,
    sequelize
};
