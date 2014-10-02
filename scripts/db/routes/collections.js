var express = require('express')
var router = express.Router()
var db = require('mongoskin').db('mongodb://localhost:27017/node')

router.param('collectionName', function(req, res, next, collectionName){
    console.log('param collectionName: ' + collectionName + ' working');
    req.collection = db.collection(collectionName)
    next()
})

router.param('id', function(req, res, next, id){
    console.log('param id: ' + id + ' working')
    req.id = id;
    next()
})

router.get('/:collectionName', function(req, res){
    req.collection.find({}).toArray(function(err, result){
        if (err) next(err);
        res.send(result)
    })
})

router.get('/:collectionName/:id', function(req, res){
    req.collection.findById(req.id, function(err, result){
        if (err) next(err);
        res.send(result)
    })
})

router.get('/', function(req, res){
    res.send('test')
})

module.exports = router;
