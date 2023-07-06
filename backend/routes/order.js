const express = require("express");
const auth = require("../middleware/auth");
const { Cart } = require("../models/cart");
const Order = require("../models/order");
const { Product } = require("../models/product");
const orderRouter = express.Router();

orderRouter.post("/api/order/:cartId", auth, async (req, res) => {
    try {
        const { address } = req.body
        const { cartId } = req.params
        const cart = await Cart.findById(cartId)
        if (!cart) {
            return res.status(400).json({ message: 'Cart not found' });
        }
        const order = new Order({
            userId: req.user,
            address,
            totalOrderPrice: cart.subtotal,
            orderAt: new Date().getTime(),
            cartItems: cart.cartItems
        });

        await order.save();

        for (let i = 0; i < cart.cartItems.length; i++) {
            const cartItem = cart.cartItems[i];
            const product = cartItem.product;
            await Product.findOneAndUpdate(
                { _id: product._id },
                { $inc: { quantity: -product.quantity } },
                { new: true }
            );
        }

        await Cart.findByIdAndDelete(cartId)
        res.json(order)
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});


orderRouter.get("/api/orders/", auth, async (req, res) => {
    try {
        const order = await Order.find({ userId: req.user });
        res.json(order)
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});




module.exports = orderRouter;
