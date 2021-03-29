const router = require ('express').Router ();
const User = require ('../models/User');
const {registerValidation, loginValidation} = require ('../validation');
const bcrypt = require ('bcryptjs');
const jwt = require ('jsonwebtoken');

//Validation
const Joi = require ('@hapi/joi');

//Registration
router.post ('/register', async (req, res) => {
    
    //Lets validate the data TODO !!! controllare lunghezza caratteri
    const {error} = registerValidation (req.body);
    if (error) return res.status (400).send (error.details[0].message);
    
    //check if the user already exists in db 
    //const emailExist = await User.findOne ({email: req.body.email});
    //if (emailExist) return res.status (400).send ('Email already exists');
    
    //Hash the password
    const salt = await bcrypt.genSalt (10);
    const hashedPassword = await bcrypt.hash (req.body.password, salt);

    //create a new user
    const user = new User ({
        name: req.body.name,
        secondName: req.body.secondName,
        username: req.body.username,
        password: hashedPassword
    });
    try {
        const savedUser = await user.save ();
        res.send ({user: user._id})
    }catch (err) {
        res.status (400).send (err); 
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
    
    //Check if the password is correct 
    const validPassword = await bcrypt.compare (req.body.password, user.password);
    if (!validPassword) return res.status (400).send ('Invalid password');

    //Create and assign a jwtoken
    const token = jwt.sign ({_id: user._id}, process.env.SECRET_TOKEN);
    user.token = token;
    res.header('auth-token', token).json(user);

});


module.exports = router;