const mongoose = require("mongoose");
const ratingSchema = require("./rating");

const productSchema = mongoose.Schema({
  name: {
    type: String,
    required: [true, "name is required"],
    trim: true,
  },
  description: {
    type: String,
    required: [true, "description is required"],
    trim: true,
  },
  category: {
    type: String,
    required: [true, "category is required"],
  },
  price: {
    type: Number,
    required: [true, "price is required"],
  }, 
  quantity: {
    type: Number,
    required: [true, "quantity is required"],
  },
  images: [
    {
      type: String,
      required: [true, "images is required"],
    },
  ],
  ratings: [ratingSchema],
  averageRating: {
    type: Number,
    default:0,
  },
});

const Product = mongoose.model("Product", productSchema);

module.exports = {Product , productSchema};
