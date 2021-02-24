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

//Middleware
app.use (express.json ());
app.use (cors ());

//Route Middlewares
app.use ('/api/user', authRoute);
app.use ('/api/posts', postRoute);
app.use ('/api/gets', getRoute );

