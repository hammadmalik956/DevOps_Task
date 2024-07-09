const { generatePassword } = require("../utils");
const { Schema, model } = require("mongoose");
const Joi = require("joi");

const UserSchema = new Schema({
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, require: true }
}, {
    timestamps: true,
});

UserSchema.pre("save", async function (next) {
    const user = this;
    if (user.isModified("password")) {
        user.password = await generatePassword(user.password);
    }
    next();
});

const validateUser = (user) => {
    const schema = Joi.object().keys({
        name: Joi.string().required().min(3),
        password: Joi.string().required().min(6).max(15),
        email: Joi.string().required().email(),
    });
    return schema.validate(user);
};

module.exports = model("user", UserSchema);
module.exports.validateUser = validateUser;