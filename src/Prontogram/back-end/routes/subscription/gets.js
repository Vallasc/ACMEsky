const router = require ('express').Router ();
const Subscription = require ('../../models/Subscription')

//Get all subscription
router.get ('/all', async (req, res) => {

    try {
        const subscriptions = await Subscription.find ();
        res.json (subscriptions); 
    } catch (err) {
        res.json ({ message: err});
    }
    
});
module.exports = router;