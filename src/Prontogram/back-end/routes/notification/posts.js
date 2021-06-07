const router = require ('express').Router ();
const verify = require ('../verifyToken');
const Notification = require('../../models/Notification');
const Subscription = require ('../../models/Subscription')
const webpush = require('web-push');
const http = require('http');

//TODO NOTIFICATION
const vapidKeys = {
    "publicKey":"BA161ZnkX9G6CwYOZifUyGpOxslxcANly0PfMtti7y1rDO9NZlPNI1yepdaTodQXX0gVHqXHVApmArL1MUNsBoM",
    "privateKey":"tazdVUkOukWUSxJKfGLBQhEnghj0tLvq6VNKqJEdOc8"
};

webpush.setVapidDetails(
    'mailto:example@yourdomain.org', 
    vapidKeys.publicKey, 
    vapidKeys.privateKey
    );

//Create a new notification

router.post('/new', async (req, res) => {

    const notification = new Notification ({
        flyNumber: req.body.flyNumber, 
        flyCompany: req.body.flyCompany, 
        flyToken: req.body.flyToken, 
    });
    try {
        sendNotification (notification)
        const saveNotification= await notification.save ();
        res.json (saveNotification); 
    } catch (err) {
        res.json ({ message: err});
    }
       
});

async function sendNotification (notification) {

        const userSub = await Subscription.find();

        if (userSub) {
            const notificationPayload = {
                "notification": {
                    "title": "Notifica Volo",
                    "actions": [
                      {
                        "action": "openNotification",
                        "title": "Apri notifica"
                      }
                    ],
                    "body": "Accedi a Prontogram per vedere i dettagli del volo",
                    "dir": "auto",
                    "icon": "",
                    "badge": "",
                    "lang": "en",
                    "renotify": true,
                    "requireInteraction": true,
                    "tag": 926796012340920300,
                    "vibrate": [
                      300,
                      100,
                      400
                    ],
                    "data": {
                      "url": "http://127.0.0.1:8080/notification",
                      "created_at": Date.now (),
                      "flyNumber": notification.flyNumber,
                      "flyCompany": notification.flyCompany,
                      "flyToken": notification.flyToken
                    }
                }
            };

            Promise.all(userSub.map(sub => webpush.sendNotification(
                sub.info, JSON.stringify(notificationPayload) )));
                //TODO gestire errori 
                /*.then(() => res.status(200).json({message: 'Newsletter sent successfully.'}))
                .catch(err => {
                    console.error("Error sending notification, reason: ", err);
                    res.sendStatus(500);
                })*/
        }
    
}
//Subscribe user
router.post('/sub', async (req, res) => {

    const userSub = new Subscription ({
        info: req.body
    });
    try {
        const saveSubscription= await userSub.save ();
        res.json({message: "Subscription success" + saveSubscription});
    } catch (err) {
        res.json ({ message: err});
    }
        
});

//Unsubscribe user
router.delete('/:subendpoint', async (req, res) => {
    
    try {
        const removeNotification = await Subscription.remove ({endpoint: req.params.subendpoint.endpoint})
        res.json ({message: "Unsubscription success" + removeNotification});
    } catch (err) {
        res.json ({ message: err});
    }
});

//Send notification to user
/*router.post('/news',async (req, res) => {
    
    try{
        const userSub = await Subscription.find();

        if (userSub) {
            const notificationPayload = {
                "notification": {
                    "title": "Notifica Volo",
                    "actions": [
                      {
                        "action": "openNotification",
                        "title": "Apri notifica"
                      }
                    ],
                    "body": "Accedi a Prontogram per vedere i dettagli del volo",
                    "dir": "auto",
                    "icon": "",
                    "badge": "",
                    "lang": "en",
                    "renotify": true,
                    "requireInteraction": true,
                    "tag": 926796012340920300,
                    "vibrate": [
                      300,
                      100,
                      400
                    ],
                    "data": {
                      "url": "http://127.0.0.1:8080/notification",
                      "created_at": Date.now (),
                      "flyNumber": req.body.flyNumber,
                      "flyCompany":  req.body.flyCompany,
                      "flyToken":  req.body.flyToken
                    }
                }
            };

            Promise.all(userSub.map(sub => webpush.sendNotification(
                sub.info, JSON.stringify(notificationPayload) )))
                .then(() => res.status(200).json({message: 'Newsletter sent successfully.'}))
                .catch(err => {
                    console.error("Error sending notification, reason: ", err);
                    res.sendStatus(500);
                });
        }
    
    }catch(err) {
        res.json ({ message: err});
    }
})*/

//Delete Notification
router.delete ('/notification/:notificationId', async (req, res) => {
    try {
        const removeNotification = await Notification.remove ({_id: req.params.notificationId})
        res.json (removeNotification);
    } catch (err) {
        res.json ({ message: err});
    }
});

//Update notification
router.patch ('/notification/:notificationId', async (req, res) => {
    try {
            const updateNotification = await Notification.updateOne (
            {_id: req.params.notificationId}, 
            { $set : {numeroVolo: req.body.numeroVolo, compagniaAerea:req.body.compagniaAerea, tokenVolo: req.body.tokenVolo}}
            );
            res.json (updateNotification);
    } catch (err) {
        res.json ({ message: err});
    }
    
});

module.exports = router;