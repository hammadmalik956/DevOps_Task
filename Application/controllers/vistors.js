const  {Visitor} =  require('../models/visitor')

const { sendResponse } = require("../utils")


const createVisitor = async (req, res) => {
    try {
        const { name } = req.body;
        await Visitor.create({name});
        return sendResponse(res, "success", 201, "userCreated");
    } catch (err) {
        console.error('Error creating visitor:');
        return sendResponse(res, "error", 505, "Error creating Visitor");
    }
};

const getVisitors = async (req, res) => {
    const visitors = await Visitor.findAll();
    return sendResponse(res, "success", 200, "visitorsFetched", visitors);
}



module.exports = {
    getVisitors,
    createVisitor
}