const express = require('express');
const router = express.Router();
const dogController = require('../controllers/dogController');

router.get('/', dogController.getDogs);

router.post('/', dogController.createDog);

router.put('/:id', dogController.updateDog);

router.delete('/:id', dogController.deleteDog);

module.exports = router;
