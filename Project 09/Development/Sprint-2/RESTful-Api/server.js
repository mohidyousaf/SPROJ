const http= require('http');
const app = require('./app')
const mongoose = require('mongoose');


mongoose.connect('mongodb+srv://node-pets:node-pets@petsapp-cluster.y1yhr.mongodb.net/PetsApp-Cluster?retryWrites=true&w=majority',
); 
const connection= mongoose.connection;
connection.once('open',()=>{
    console.log('db connected');
});


const port = process.env.PORT || 5000;
const server= http.createServer(app);

server.listen(port);