const express = require('express');
const router = express.Router();
const ownerController = require('../controllers/ownerController');

router.get('/', ownerController.getOwners);

router.post('/', ownerController.createOwner);

module.exports = router;
