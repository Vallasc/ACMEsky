const router = require ('express').Router ();
const Notification = require('../../models/Notification');
const verify = require ('../verifyToken');

//Get notification by Id
router.get ('/findOne/:notificationId', async (req, res) => {
    
    try {
        const notification = await Notification.findById (req.params.notificationId);
        res.json (notification); 
    } catch (err) {
        res.json ({ message: err});
    }
    
});

//Get all notifications
router.get ('/notificationByUserId', async (req, res) => {

    try {
        const notifications = await Notification.find ({user_id: req.params.notificationByUserId});
        res.json (notifications); 
    } catch (err) {
        res.json ({ message: err});
    }
    
});

module.exports = router;