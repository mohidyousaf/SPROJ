const express = require('express')
const router= express.Router()

router.get('/',(req,resp)=>{
    resp.status(200).json({
        message: 'get request for order working'
    })

})

router.post('/',(req,res,next)=>{

    console.log(req.body);

     const order = {
        productID: req.body.productID,
        price: req.body.price
    };

    res.status(201).json({
        message: 'post  request working',
        order: order   
    });

});

module.exports = router