const express = require("express");
const auth = require("../middleware/auth");
const {Product} = require("../models/product");
const productRouter = express.Router();


/// GET all Products
productRouter.get("/api/products", auth, async (req, res) => {
    try {
        const product = await Product.find({ category: req.query.category });
        return res.json(product);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

/// GET search
productRouter.get("/api/search", auth, async (req, res) => {
    try {
        const product = await Product.find({
            name: {
                $regex: req.query.query, $options: "i"
            }
        });
        return res.json(product);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

/// POST add rating
productRouter.post("/api/product/:_id/rating", auth, async (req, res) => {
    try {
        const { _id } = req.params;
        const { rating } = req.body;

        const product = await Product.findById(_id);
        if (!product) {
            return res.status(400).json({ message: "Product not found" });
        }

        const existingRating = product.ratings.find(
            (rating) => rating.userId === req.user
        );
        if (existingRating) {
            product.ratings = product.ratings.filter(
                (rating) => rating.userId !== req.user
            );
        }

        const newRating = { userId: req.user, rating };
        product.ratings.push(newRating);
        product.averageRating = calculateAverageRating(product.ratings);

        const updatedProduct = await product.save();
        return res.json(updatedProduct);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

function calculateAverageRating(ratings) {
    const totalRatings = ratings.length;
    const sumRatings = ratings.reduce((acc, rating) => acc + rating.rating, 0);
    return totalRatings > 0 ? sumRatings / totalRatings : 0;
}
/// GET  product
productRouter.get("/api/product/:_id", auth, async (req, res) => {
    try {
        const _id = req.params
        const product = await Product.findById(_id)
        if (!product) {
            return res.status(400).json({ message: 'Product not found' });
        }
        return res.json(product);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

/// sort products by averageRating
productRouter.get("/api/products/sorted-by-rating", auth, async (req, res) => {
    try {
        const products = await Product.aggregate([
            {
                $project: {
                    name: 1,
                    price: 1,
                    images: 1,
                    description: 1,
                    averageRating: { $avg: "$ratings.rating" },
                },
            },
            { $sort: { averageRating: -1 } },
            { $limit: 10 },
        ]);

        if (products.length === 0) {
            return res.status(404).json({ message: "No products found" });
        }

        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = productRouter;
