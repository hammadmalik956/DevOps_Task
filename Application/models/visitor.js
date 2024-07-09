

const { DataTypes } = require('sequelize');
const { sequelize } = require('./index'); // Import sequelize instance from index.js

const Visitor = sequelize.define('visitor', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    name: {
        type: DataTypes.STRING,
        allowNull: false
    },
    visit_time: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {
    timestamps: false, 
    tableName: 'visitors' 
});

// Sync the model with the database
sequelize.sync()
    .then(() => {
        console.log('Visitors table synced with database');
    })
    .catch(err => {
        console.error('Error syncing visitors table:', err);
    });

module.exports = {Visitor};
