const express = require ('express');
const mongoose = require ('mongoose');
const dotenv = require ('dotenv');
const postRoute = require ('./routes/posts');
const getRoute = require ('./routes/gets');
const cors = require ('cors');
const webpush = require ('web-push');
const bodyParser = require ('body-parser');
const path = require("path");

const app = express ();

app.use (bodyParser.json ());

app.listen(9000, () => {
    console.log('The server started on port 9000 !!!!!!');
  });
  
dotenv.config ();

//connect db 
mongoose.connect(
    process.env.DB_CONNECT, 
    { useNewUrlParser: true },
    () => console.log ('connect to db')
    );

//imports routes
const authRoute = require ('./routes/auth');
const postNotificationRoute = require ('./routes/notification/posts');
//const getNotificationRoute = require ('./routes/notification/gets');
const postSubscriptionRoute = require ('./routes/subscription/posts');
const getSubscriptionRoute = require ('./routes/subscription/gets');

const postUserRoute = require ('./routes/user/posts');
const getUserRoute = require ('./routes/user/gets');

//Middleware
app.use (express.json ());
app.use (cors ());

//Route Middlewares
app.use ('/api/auth', authRoute);
app.use ('/api/notification/', postNotificationRoute);
//app.use ('/api/notification/', getNotificationRoute);
app.use ('/api/subscription/', postSubscriptionRoute);
app.use ('/api/subscription/', getSubscriptionRoute);
app.use ('/api/user/', postUserRoute );
app.use ('/api/user/', getUserRoute );

