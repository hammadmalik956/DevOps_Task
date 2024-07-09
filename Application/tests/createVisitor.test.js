const request = require('supertest')
const expect = require('chai').expect;
const {app} = require('../index'); 
describe('POST /api/visitor', () => {
    it('should create a visitor', async () => {
        const res = await request(app)
            .post('/api/visitor')
            .send({ name: 'Malik Hammad Hameed' });
        expect(res.body.code).to.equal(201);
        expect(res.body.status).to.equal('success');
        expect(res.body.statusMessage).to.equal('Created');
        expect(res.body.message).to.be.equal('userCreated');
        expect(res.body.result).to.equal(null)
    });
    it('should handle errors during visitor creation', async () => {
        // Test case for handling errors (e.g., invalid data)
        const res = await request(app)
            .post('/api/visitor')
            .send({});
        expect(res.body.code).to.equal(505);
        expect(res.body.status).to.equal('error');
        expect(res.body.message).to.equal('Error creating Visitor');
    });
});
