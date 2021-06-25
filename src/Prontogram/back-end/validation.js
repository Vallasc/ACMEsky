//validation
const Joi = require ('@hapi/joi');

//Register validation
const registerValidation = data => {
const schema = {
    name: Joi.string ()
    .min (1)
    .required (),
    secondName: Joi.string ()
    .min (1)
    .required (),
    username: Joi.string ()
    .min (6)
    .required (),
    password: Joi.string ()
    .min (6)
    .required ()
    };
    
    var {error} = schema.secondName.validate (data.secondName);
    if (error) return {error};
    var {error} = schema.username.validate (data.username);
    if (error) return {error};
    var {error} = schema.name.validate (data.name);
    if (error) return {error};
    var {error} = schema.password.validate (data.password);
    if (error) return {error};
    else return 0;
    
}

//login validation
const loginValidation = data => {
    const schema = {
        username: Joi.string ()
        .min (6)
        .required (),
        password: Joi.string ()
        .min (6)
        .required ()
        };
        var {error} = schema.username.validate (data.username);
        if (error) return {error};
        var {error} = schema.password.validate (data.password);
        if (error) return {error};
        else return 0;
    }

module.exports.registerValidation = registerValidation;
module.exports.loginValidation = loginValidation;