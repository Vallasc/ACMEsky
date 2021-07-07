const mongoose = require ('mongoose');
const notificationSchema = new mongoose.Schema ({
    flyBack: {
    },
    flyOutBound: {
    },
    offerToken: {
        type: String,
        require: true,
    },
    username: {
        type: String,
        require: true,
    }
});

module.exports = mongoose.model ('Notification', notificationSchema);