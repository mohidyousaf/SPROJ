const http= require('http');
const app = require('./app')
const mongoose = require('mongoose');

// connecting to mongoDB via link we obtained.
mongoose.connect('mongodb+srv://node-pets:node-pets@petsapp-cluster.y1yhr.mongodb.net/PetsApp-Cluster?retryWrites=true&w=majority',
); 
const connection= mongoose.connection;
connection.once('open',()=>{
    console.log('db connected');
});

// The port is either dynamically allocated by the server as we deployed it on heroku or we use default port.
const port = process.env.PORT || 5000;
// we are creaeted server with given port and routes as defined in app.
const server= http.createServer(app);

server.listen(port);