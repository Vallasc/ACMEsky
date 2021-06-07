const router = require ('express').Router ();
const Notification = require('../../models/Notification');
const verify = require ('../verifyToken');

//Get notification by Id
router.get ('/notification/:id', async (req, res) => {
    
    try {
        const notification = await Notification.findById (req.params.id);
        res.json (notification); 
    } catch (err) {
        res.json ({ message: err});
    }
    
});

//Get all notifications
router.get ('/all/:user_id', async (req, res) => {

    try {
        const notifications = await Notification.find ({user_id: req.params.user_id});
        res.json (notifications); 
    } catch (err) {
        res.json ({ message: err});
    }
    
});

module.exports = router;