const config = require("config");

module.exports = {
    NAME: config.get("NAME"),
    PORT: config.get("PORT"),
    HOSTNAME: config.get("HOSTNAME"),

    JWT_SECRET_KEY: config.get("JWT_SECRET_KEY"),

    DATABASE_NAME: config.get("DATABASE.NAME"),
    DATABASE_URL: config.get("DATABASE.URL"),
    DATABASE_USERNAME: config.get("DATABASE.USERNAME"),
    DATABASE_PASSWORD: config.get("DATABASE.PASSWORD"),

    STRIPE_SECRET_KEY: config.get("STRIPE.SECRET_KEY"),
    STRIPE_PUBLISH_KEY: config.get("STRIPE.PUBLISH_KEY"),

    ADMIN: "ADMIN",
    USER: "USER"
}
