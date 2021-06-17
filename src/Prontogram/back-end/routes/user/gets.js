const router = require ('express').Router ();
const User = require('../../models/User');
const verify = require ('../verifyToken');

//Get user by Id  TOLGO VERIFY ('/',verify, async (req, res) ==> ('/', async (req, res)
router.get ('/:id', async (req, res) => {
    try {
        const user = await User.findById (req.params.id);
        res.json (user); 
    } catch (err) {
        res.status(500).send({message:'username e/o password errati'});
    }
    
    
});

//Get all users TOLGO VERIFY ('/',verify, async (req, res) ==> ('/', async (req, res)
router.get ('all', async (req, res) => {
    try {
        const user = await User.find();
        res.json (user); 

    } catch (err) {
        res.json ({ message: "Errore durante la ricerca degli utenti"} );
    }
    
});

module.exports = router;

