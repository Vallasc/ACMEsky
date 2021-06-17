const router = require ('express').Router ();
const Subscription = require ('../../models/Subscription')

//Subscribe user
router.post('/new', async (req, res) => {
    const userSub = new Subscription ({
        info: req.body.subscription,
        user_id: req.body.user_id
    });
    console.log (req.body.subscription)
    try {
        const alreadySub= await Subscription.findOne({user_id:req.body.user_id})
        if(alreadySub) {
            console.log ("User already subscribed!")
        }
        else {
            const saveSubscription= await userSub.save ();
            res.json({message: "Subscription success" + saveSubscription});
        }
        
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

module.exports = router;