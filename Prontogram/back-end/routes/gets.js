const router = require ('express').Router ();
const User = require('../models/User');
const Notification = require('../models/Notification');
const verify = require ('./verifyToken');

//GET USER BY ID
router.get ('/:id',verify, async (req, res) => {
    try {
        const user = await User.findById (req.params.id);
        res.json (user); 
    } catch (err) {
        res.json ({ message: err});
    }
    
});

//GET ALL USERS
router.get ('/',verify, async (req, res) => {
    try {
        const user = await User.find();
        res.json (user); 

    } catch (err) {
        res.json ({ message: err});
    }
    
});

//GET NOTIFICATION BY ID
router.get ('/notification/:id', async (req, res) => {
    try {
        const notification = await Notification.findById (req.params.id);
        res.json (notification); 
    } catch (err) {
        res.json ({ message: err});
    }
    
});

//GET ALL NOTIFICATIONS
router.get ('/find/notification', async (req, res) => {
    try {
        const notification = await Notification.find ();
        res.json (notification); 

    } catch (err) {
        res.json ({ message: err});
    }
    
});

module.exports = router;