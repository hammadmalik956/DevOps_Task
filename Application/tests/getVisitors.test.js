const request = require('supertest')
const expect = require('chai').expect;
const {app} = require('../index');
const { Visitor } = require('../models/visitor');
describe('GET /api/visitors', () => {
    it('should fetch all visitors', async () => {
        // Create a visitor first for testing purposes
        await Visitor.create({ name: 'Malik Hammad Dummy' });
        const res = await request(app)
            .get('/api/visitors');
        expect(res.body.code).to.equal(200);
        expect(res.body.status).to.equal('success');
        expect(res.body.message).to.equal('visitorsFetched');
        expect(res.body.result).to.be.an('array');
        expect(res.body.result.length).to.be.at.least(1)
        
    });
});
