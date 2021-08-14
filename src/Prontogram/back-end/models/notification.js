const mongoose = require ('mongoose');
const notificationSchema = new mongoose.Schema ({
    username: {
        type: String,
        require: true,
    },
    message: {
        type: String,
        require: true,
    },
    info: {
        type: String,
        require: true,
    }
});

module.exports = mongoose.model ('Notification', notificationSchema);