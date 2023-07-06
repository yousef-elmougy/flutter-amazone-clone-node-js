const express = require("express");
const admin = require("../middleware/admin");
const { Product } = require("../models/product");
const Order = require("../models/order");
const adminRouter = express.Router();



adminRouter.post('/admin/product', admin, async (req, res) => {
  try {
    const { name, description, images, category, price, quantity } = req.body;



    const product = Product({
      name,
      description,
      images: images,
      category,
      price,
      quantity
    });

    await product.save();
    return res.json(product);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});
/// GET all Products
adminRouter.get("/admin/products", admin, async (_, res) => {
  try {
    const product = await Product.find({});
    return res.json(product);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

/// DELETE delete Product
adminRouter.delete("/admin/product/:_id", admin, async (req, res) => {
  try {
    const product = await Product.findByIdAndDelete(req.params._id);
    return res.json(product);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/orders/", admin, async (req, res) => {
  try {
    const orders = await Order.find({})
    res.json(orders)
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

adminRouter.put("/admin/order-status/:orderId", admin, async (req, res) => {
  try {

    const order = await Order.findByIdAndUpdate(req.params.orderId, { status: req.body.status }, { new: true })

    res.json(order)
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/analytics", admin, async (_, res) => {
  try {
    const orders = await Order.find({});
    let totalEarning = 0;
    for (let i = 0; i < orders.length; i++) {
      const items = orders[i].cartItems;
      for (let j = 0; j < items.length; j++) {
        const product = items[j].product;
        totalEarning += items[j].quantity * product.price
      }
    }
    const mobileEarning = await getTotalEarningByCategory('Mobiles')
    const electronicsEarning = await getTotalEarningByCategory('Electronics')
    const essentialsEarning = await getTotalEarningByCategory('Essentials')
    const appliancesEarning = await getTotalEarningByCategory('Appliances')
    const booksEarning = await getTotalEarningByCategory('Books')
    const fashionEarning = await getTotalEarningByCategory('Fashion')
    const earning = {
      totalEarning,
      mobileEarning,
      electronicsEarning,
      essentialsEarning,
      appliancesEarning,
      booksEarning,
      fashionEarning,
    }
    return res.json(earning);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

async function getTotalEarningByCategory(category) {
  let earning = 0;
  const orders = await Order.find({ 'cartItems.product.category': category })
  for (let i = 0; i < orders.length; i++) {
    const items = orders[i].cartItems;
    for (let j = 0; j < items.length; j++) {
      const product = items[j].product;
      earning += items[j].quantity * product.price
    }
  }
  return earning
}


module.exports = adminRouter;
