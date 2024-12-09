const Owner = require('../models/owner');

exports.getOwners = async (req, res) => {
  try {
    const owners = await Owner.find();
    res.status(200).json(owners);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

exports.createOwner = async (req, res) => {
  const { name, bio, image } = req.body;

  try {
    const newOwner = new Owner({ name, bio, image });
    await newOwner.save();
    res.status(201).json(newOwner);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
