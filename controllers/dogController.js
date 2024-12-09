const Dog = require('../models/dog');

exports.getDogs = async (req, res) => {
  try {
    const dogs = await Dog.find().populate('owner');
    res.status(200).json(dogs);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

exports.createDog = async (req, res) => {
  const { name, age, gender, color, weight, location, about, owner, bio,image } = req.body;
  const imageUrl = req.file ? `/uploads/${req.file.filename}` : null;

  try {
    const newDog = new Dog({
      name,
      age,
      gender,
      color,
      weight,
      location,
      about,
      owner,
      bio,
      image :imageUrl,
    });
    await newDog.save();
    res.status(201).json(newDog);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

exports.updateDog = async (req, res) => {
  const { id } = req.params; 
  const { name, age, gender, color, weight, location, about, owner, bio } = req.body;

  try {
    const updatedDog = await Dog.findByIdAndUpdate(
      id,
      { name, age, gender, color, weight, location, about, owner, bio },
      { new: true } 
    );
    if (!updatedDog) {
      return res.status(404).json({ message: 'Dog not found' });
    }
    res.status(200).json(updatedDog);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

exports.deleteDog = async (req, res) => {
  const { id } = req.params; 

  try {
    const deletedDog = await Dog.findByIdAndDelete(id);
    if (!deletedDog) {
      return res.status(404).json({ message: 'Dog not found' });
    }
    res.status(200).json({ message: 'Dog deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
