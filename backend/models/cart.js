const mongoose = require("mongoose");
const { productSchema } = require("./product");

const cartItemSchema = new mongoose.Schema({
  product: productSchema,
  quantity: {
    type: Number,
    min: [1, "Quantity must be at least 1"],
    required: true,
  },
});

const cartSchema = new mongoose.Schema({
  userId: {
    type: String,
    required: true,
  },
  cartItems: [cartItemSchema],
  subtotal: {
    type: Number,
    default: 0,
  },
});

const Cart = mongoose.model("Cart", cartSchema);

module.exports = {Cart , cartItemSchema};