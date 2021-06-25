const mongoose = require ('mongoose');
const userSchema = new mongoose.Schema ({
    name: {
        type: String,
        require: true,
        min:1
    },
    secondName: {
        type: String,
        require: true,
        min:1
    },
    username: {
        type: String,
        require: true,
        min:6
    },
    password: {
        type: String,
        require: true,
        max: 255,
        min: 6
    },
    token: {
        type: String,
        require: true
    },

});

module.exports = mongoose.model ('User', userSchema);