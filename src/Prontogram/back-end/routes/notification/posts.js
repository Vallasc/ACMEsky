const router = require ('express').Router ();
const verify = require ('../verifyToken');
const Notification = require('../../models/notification');
const Subscription = require ('../../models/subscription')
const webpush = require('web-push');

const vapidKeys = {
    "publicKey":"BA161ZnkX9G6CwYOZifUyGpOxslxcANly0PfMtti7y1rDO9NZlPNI1yepdaTodQXX0gVHqXHVApmArL1MUNsBoM",
    "privateKey":"tazdVUkOukWUSxJKfGLBQhEnghj0tLvq6VNKqJEdOc8"
};

webpush.setVapidDetails(
    'mailto:example@yourdomain.org', 
    vapidKeys.publicKey, 
    vapidKeys.privateKey
    );

//Create new notification

router.post('/', async (req, res) => {
    const notification = new Notification ({
        username: req.body.username,
        message: req.body.message,
        info: req.body.info
    });
    console.log ("NOTIFICATION ", notification)
    try {
        const userToSendNotification = await Subscription.find ({username: notification.username})
        if (userToSendNotification.length) {
            sendNotification (notification, userToSendNotification)
            const saveNotification= await notification.save ();
            res.json (saveNotification); 
        } else {
            res.status(404).send("There is no user to sent notification!");
        }
    } catch (err) {
        res.json ({ message: err});
    }
       
});

//Send notification to user
async function sendNotification (notification, userSub) {
        if (userSub) {
            const notificationPayload = {
                "notification": {
                    "title": "ACMESky",
                    "actions": [
                      {
                        "action": "openNotification",
                        "title": "Apri notifica"
                      }
                    ],
                    "body": notification.info,
                    "dir": "auto",
                    "icon": "back-end/assets/icon/prontogram.jpg",
                    "badge": "back-end/assets/icon/prontogram.png",
                    "lang": "it",
                    "renotify": true,
                    "requireInteraction": true,
                    "tag": 926796012340920300,
                    "vibrate": [
                      300,
                      100,
                      400
                    ],
                    "data": {
                      "url": "http://127.0.0.1:8051/notification",
                      "username": notification.username,
                      "message": notification.message
                    }
                }
            };

            Promise.all(userSub.map(sub => webpush.sendNotification(
                sub.info, JSON.stringify(notificationPayload) )));
        }
    
}
//Delete Notification
router.delete ('/:notificationId', async (req, res) => {
    try {
        const removeNotification = await Notification.remove ({_id: req.params.notificationId})
        res.json (removeNotification);
    } catch (err) {
        res.json ({ message: err});
    }
});

//Update notification
router.put ('/notification/:notificationId', async (req, res) => {
    try {
            const updateNotification = await Notification.updateOne (
            {_id: req.params.notificationId}, 
            { $set : {flyBack: req.body.flyBack, flyOutBound:req.body.flyOutBound, offerToken: req.body.offerToken}}
            );
            res.json (updateNotification);
    } catch (err) {
        res.json ({ message: err});
    }
    
});

module.exports = router;