const router = require ('express').Router ();
const User = require ('../models/User');
const {registerValidation, loginValidation} = require ('../validation');
const bcrypt = require ('bcryptjs');
const jwt = require ('jsonwebtoken');

//Validation
const Joi = require ('@hapi/joi');

//Registration
router.post ('/register', async (req, res) => {
    
    //check if the user already exists in db 
    const usernameExist = await User.findOne ({username: req.body.username});
    if (usernameExist) return res.status (400).send ('username already exists');

    //Create a new user
    const user = new User ({
        name: req.body.name,
        secondName: req.body.secondName,
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

//Login
router.post ('/login', async (req, res) => {
    //Lets validate the data 
    const {error} = loginValidation (req.body);
    if (error) return res.status (400).send (error.details[0].message);

    //Checking if the username exists
    const user = await User.findOne ({username: req.body.username});
    if (!user) return res.status (400).send ('Username is not found');
    
    //const validPassword = await bcrypt.compare (req.body.password, user.password);
    if (req.body.password != user.password) return res.status (400).send ('Invalid password');

    //Create and assign a jwtoken
    const token = jwt.sign ({_id: user._id}, process.env.SECRET_TOKEN);
    user.token = token;
    res.header('auth-token', token).json(user);

});


module.exports = router;