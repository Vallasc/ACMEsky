const mongoose = require ('mongoose');
const notificationSchema = new mongoose.Schema ({
    flyNumber: {
        type: Number,
        require: true,
    },
    flyCompany: {
        type: String,
        require: true,
    },
    flyToken: {
        type: String,
        require: true,
    }
});

module.exports = mongoose.model ('Notification', notificationSchema);