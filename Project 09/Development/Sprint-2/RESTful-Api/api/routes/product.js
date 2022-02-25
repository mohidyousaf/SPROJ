const express= require('express');
const router = express.Router();
const bodyparser= require('body-parser');
const Product= require('../models/productModel');

// These are defining routes, where we use express.router as middleware and handles all the path that followed by 'bar'
// router handles various post and get http requests.
router.get('/',(req,resp)=>{

    Product.find()
    .exec()
    .then(docs=>{
        console.log(docs)
        resp.status(200).json(docs)
    }
    )
    .catch(err=>{
        resp.status(500).json({error:err})
    })

});

router.post('/',(req,resp,next)=>{
    // using our prodel model here

    const product = new Product({
        name: req.body.name,
        price: req.body.price
    });


    //save is model function of mongoose, and we return a promise or catch errors
    product.save().then(()=>{
        console.log('product is added');
        
        resp.status(201).json({
            message: 'post  request working',
            createdProduct: product   
        });

    })
    .catch((err)=>{
        next(err);
    })

});

router.get('/:id',(req,resp)=>{
    const id= req.params.id;

    resp.status(200).json({
        message: `id is ${id}`
    })

})


module.exports= router;