// mongoose works with models and schemas to create objects and add into clusters. 
const mongoose= require('mongoose');
const { stringify } = require('nodemon/lib/utils');



const Product = mongoose.Schema ({

    name:{
        // _id: mongoose.Types.ObjectId, 
        type: String,
        required: true,
        unique:true
    },

    price:{
        type: String,
        required: true
    }

});


//here model initiates the object,  by wrapping into a model 
// Mongoose mainly use models and models has functions such as saving in database
module.exports = mongoose.model("Product",Product)