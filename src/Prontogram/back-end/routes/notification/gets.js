const router = require ('express').Router ();
const Notification = require('../../models/notification');
const verify = require ('../verifyToken');

//Get notification by Id
router.get ('/:notificationId', async (req, res) => {
    
    try {
        const notification = await Notification.findById (req.params.notificationId);
        res.json (notification); 
    } catch (err) {
        res.json ({ message: err});
    }
    
});

//Get all notifications
router.get ('/all/:username', async (req, res) => {

    try {
        const notifications = await Notification.find ({username: req.params.username});
        res.json (notifications); 
    } catch (err) {
        res.json ({ message: err});
    }
    
});

module.exports = router;