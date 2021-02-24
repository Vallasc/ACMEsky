const router = require ('express').Router ();
const verify = require ('./verifyToken');
const User = require('../models/User');
const Notification = require('../models/Notification');
const bcrypt = require ('bcryptjs');
const USER_SUBSCRIPTIONS = require ('../models/Subscription')
const webpush = require('web-push');

//TODO NOTIFICATION
const vapidKeys = {
    "publicKey":"BMKtc1sW54C54akN2A0T_2g0DcCYVQqgmzW3Mx7um85HY28Vj4nmImOfx6KMzD807WABeeqAifOZgwnfkNU7erY",
    "privateKey":"T1zwAH8mOww_vxl5jpEMlmQrdIhw-YcREowrq0i19bk"
};


webpush.setVapidDetails(
    'mailto:example@yourdomain.org', 
    vapidKeys.publicKey, 
    vapidKeys.privateKey
    );

//SUBMIT a Notification
router.post('/notification', async (req, res) => {

    const notification = new Notification ({
        numeroVolo: req.body.numeroVolo, 
        compagniaAerea:req.body.compagniaAerea, 
        tokenVolo: req.body.tokenVolo, 
    });
    try {
        const saveNotification= await notification.save ();
        res.json (saveNotification); 
    } catch (err) {
        res.json ({ message: err});
    }
       
});

//SUBMIT ISCRIZIONE 
router.post('/sub', async (req, res) => {
    
    console.log('Received Subscription on the server: ', req.body);
    const userSub = new USER_SUBSCRIPTIONS ({
        info: req.body
    });
    console.log ("userSub" + userSub)
    try {
        const saveSubscription= await userSub.save ();
        res.json({message: "Subscription SUCCESS!!!" + saveSubscription});
    } catch (err) {
        res.json ({ message: err});
    }
        
});



//route to test send notification
router.post('/news',async (req, res) => {
   // console.log('Total subscriptions', USER_SUBSCRIPTIONS.length ());
    
    const userSub = await USER_SUBSCRIPTIONS.findOne();
    console.log ("SUBSCRIPTION USER " + userSub);
    // sample notification payload
    const notificationPayload = {
        "notification": {
            "title": "Angular News",
            "body": "Newsletter Available!",
            "icon": "assets/main-page-logo-small-hat.png",
            "vibrate": [100, 50, 100],
            "data": {
                "primaryKey": 1
            },
            "actions": [{
                "action": "explore",
                "title": "Go to the site"
            }]
        }
    };


    webpush.sendNotification(
        
        userSub.info, JSON.stringify(notificationPayload) )
        .then(() => res.status(200).json({message: 'Newsletter sent successfully.'}))
        .catch(err => {
            console.error("Error sending notification, reason: ", err);
            res.sendStatus(500);
        }); 
})

//SUBMIT a User
router.post('/notification',verify, async (req, res) => {

    //Hash the password
    const salt = await bcrypt.genSalt (10);
    const hashedPassword = await bcrypt.hash (req.body.password, salt);

    const user = new User ({
        name: req.body.name, 
        secondName:req.body.secondName, 
        username: req.body.username, 
        password: hashedPassword 
    });
    try {
        const saveUser= await user.save ();
        res.json (saveUser); 
    } catch (err) {
        res.json ({ message: err});
    }
       
});

//Delete Notification
router.delete ('/notification/:notificationId', async (req, res) => {
    try {
        const removeNotification = await Notification.remove ({_id: req.params.notificationId})
        res.json (removeNotification);
    } catch (err) {
        res.json ({ message: err});
    }
});

//Delete User
router.delete ('/:userId',verify, async (req, res) => {
    try {
        const removeUser = await User.remove ({_id: req.params.userId})
        res.json (removeUser);
    } catch (err) {
        res.json ({ message: err});
    }
});

//UPDATE Notification
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

//UPDATE User
router.patch ('/:userId',verify, async (req, res) => {
    try {
            //Hash the password
            const salt = await bcrypt.genSalt (10);
            const hashedPassword = await bcrypt.hash (req.body.password, salt);

            const updateUser = await User.updateOne (
            {_id: req.params.userId}, 
            { $set : {name: req.body.name, secondName:req.body.secondName, username: req.body.username, password: hashedPassword }}
            );
            res.json (updateUser);
    } catch (err) {
        res.json ({ message: err});
    }
    
});

module.exports = router;