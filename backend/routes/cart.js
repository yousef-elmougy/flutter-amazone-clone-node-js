const express = require("express");
const auth = require("../middleware/auth");
const { Product } = require("../models/product");
const cartRouter = express.Router();
const { Cart } = require("../models/cart");


function calculateSubtotal(cart) {
    const subtotal = cart.cartItems.reduce((total, item) =>
        total + (item.product.price * item.quantity)
        , 0);
    cart.subtotal = subtotal;
    return subtotal
}

cartRouter.post('/api/cart/add', auth, async (req, res) => {
    const { productId } = req.body;
    const userId = req.user;


    try {
        let cart = await Cart.findOne({ userId });
        if (!cart) {
            cart = new Cart({ userId });
        }

        const product = await Product.findById(productId);
        if (!product) {
            return res.status(400).json({ message: 'Product not found' });
        }

        const existingItem = cart.cartItems.find(
            (item) => item.product._id.toString() === productId
        );

        if (product.quantity === 0 || (existingItem && product.quantity === existingItem.quantity)) {
            return res.status(400).json({ message: `this is the MAX amount of ${product.name}` });
        } else {
            if (existingItem && existingItem.quantity >= product.quantity) {
                return res.status(400).json({ message: `this is the MAX amount of ${product.name}` });

            } else {
                if (existingItem) {
                    existingItem.quantity += 1;
                } else {
                    cart.cartItems.push({ product: product, quantity: 1 });
                }


            }

        }
        calculateSubtotal(cart)


        await cart.save();
        res.json(cart);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'An error occurred while adding item to cart' });
    }
});

// DELETE /api/cart/remove/:productId
cartRouter.delete("/api/cart/remove/:productId", auth, async (req, res) => {
    try {

        const { productId } = req.params;
        const product = await Product.findById(productId);

        let cart = await Cart.findOne({ userId: req.user });
        if (!cart) {
            return res.status(400).json({ message: 'Cart not found' });
        }

        const cartItem = cart.cartItems.find(
            (item) => item.product._id.toString() === productId
        );

        if (!cartItem) {
            return res.status(400).json({ message: 'Cart item not found' });
        }

        if (cartItem.quantity > 1) {
            cart = await Cart.findOneAndUpdate(
                { userId: req.user, "cartItems.product": product },
                { $inc: { "cartItems.$.quantity": -1 }, $set: { subtotal: cart.subtotal - product.price } },
                { new: true }
            );

        } else {
            cart = await Cart.findOneAndUpdate(
                { userId: req.user },
                { $pull: { cartItems: { product: product } }, $set: { subtotal: cart.subtotal - product.price } },
                { new: true }
            );
        }
        res.json(cart);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// DELETE /api/cart/delete/:productId
cartRouter.delete("/api/cart/delete/:productId", auth, async (req, res) => {
    try {
        const { productId } = req.params;
        const product = await Product.findById(productId);
        if (!product) {
            return res.status(400).json({ message: 'Product not found' });
        }

        const cart = await Cart.findOneAndUpdate(
            { userId: req.user },
            { $pull: { cartItems: { product: product } } },
           { new: true }
        );


        const subtotal = calculateSubtotal(cart);
        await Cart.findOneAndUpdate(
            { userId: req.user },
            { $set: { subtotal: subtotal } }
        )

        res.json(cart);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
cartRouter.get('/api/cart/', auth, async (req, res) => {
    try {
        const cart = await Cart.findOne({ userId: req.user })

        res.json(cart);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'An error occurred while adding item to cart' });
    }
})


module.exports = cartRouter