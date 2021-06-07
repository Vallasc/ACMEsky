const express = require ('express');
const mongoose = require ('mongoose');
const dotenv = require ('dotenv');
const cors = require ('cors');
const webpush = require ('web-push');
const bodyParser = require ('body-parser');
const path = require("path");

const app = express()
app.use(cors())
app.use(bodyParser.json())

const port = 8000;
app.listen(port, () => {
    console.log('The server started on port: '+port );
  });
  
dotenv.config ();

//connect db 
mongoose.connect(
  process.env.MONGO_CONNECTION,
    { useNewUrlParser: true },
    () => console.log ('connect to db')
    );

//imports routes
const authRoute = require ('./routes/auth');
const postNotificationRoute = require ('./routes/notification/posts');
const getNotificationRoute = require ('./routes/notification/gets');
const postUserRoute = require ('./routes/user/posts');
const getUserRoute = require ('./routes/user/gets');

//Middleware
app.use (express.json ());

//Route Middlewares
app.use ('/api/auth', authRoute);
app.use ('/api/notification/posts', postNotificationRoute);
app.use ('/api/notification/gets', getNotificationRoute);
app.use ('/api/user/posts', postUserRoute );
app.use ('/api/user/gets', getUserRoute );

