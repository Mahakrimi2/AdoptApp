const mongoose = require('mongoose');

const dogSchema = new mongoose.Schema({
  name: { type: String, required: true },
  age: { type: Number, required: true },
  gender: { type: String, required: true },
  color: { type: String, required: true },
  weight: { type: Number, required: true },
  location: { type: String, required: true },
  about: { type: String, required: true },
  owner: { type: String, required: true },
  bio: { type: String, required: true },
  image: { type: String, required: false } 

});

module.exports = mongoose.model('Dog', dogSchema);
