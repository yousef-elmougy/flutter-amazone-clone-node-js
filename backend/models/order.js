const mongoose = require("mongoose");
const { cartItemSchema } = require("./cart");


const orderSchema = new mongoose.Schema({
  userId: {
    type: String,
    required: true,
  },
  cartItems: [cartItemSchema],
  totalOrderPrice: {
    type: Number,
    required: true,
  },
  address:{
    type: String,
    required: true,
  },
  orderAt:{
    type: Number,
    required: true,
  },
  status:{
    type: Number,
    default:0,
  },

});

const Order = mongoose.model("Order", orderSchema);

module.exports = Order