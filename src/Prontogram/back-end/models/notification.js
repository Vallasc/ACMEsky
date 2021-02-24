const mongoose = require ('mongoose');
const notificationSchema = new mongoose.Schema ({
    numeroVolo: {
        type: Number,
        require: true,
    },
    compagniaAerea: {
        type: String,
        require: true,
    },
    tokenVolo: {
        type: String,
        require: true,
    }
});

module.exports = mongoose.model ('Notification', notificationSchema);