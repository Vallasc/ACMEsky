const router = require ('express').Router ();
const verify = require ('../verifyToken');
const User = require('../../models/User');
const bcrypt = require ('bcryptjs');
const webpush = require('web-push');

//Create a new user
router.post('/new',verify, async (req, res) => {

    const usernameExist = await User.findOne ({username: req.body.username});
    if (usernameExist) return res.status (400).send ('username already exists');
    
    const user = new User ({
        name: req.body.name,
        secondName:req.body.secondName, 
        username: req.body.username, 
        password: req.body.password 
    });
    try {
        const saveUser= await user.save ();
        res.json (saveUser); 
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

//Update User
router.put ('/:userId',verify, async (req, res) => {
    try {
            const updateUser = await User.updateOne (
            {_id: req.params.userId}, 
            { $set : {name: req.body.name, secondName:req.body.secondName, username: req.body.username, password: req.body.password }}
            );
            res.json (updateUser);
    } catch (err) {
        res.json ({ message: err});
    }
    
});

module.exports = router;