/// PACKAGES
const express = require('express')
const mongoose = require('mongoose')
///IMPORTS
const userRouter = require('./routes/user')
const adminRouter = require('./routes/admin')
const productRouter = require('./routes/product')
const cartRouter = require('./routes/cart')
const orderRouter = require('./routes/order')

/// INIT
const app = express()
const PORT = 3000
const hostname = '0.0.0.0'
const DB = ''

/// Middleware
app.use(express.json({limit: '50mb'}))
app.use(express.urlencoded({limit: '50mb', extended: true}));
app.use(userRouter)
app.use(adminRouter)
app.use(productRouter)
app.use(cartRouter)
app.use(orderRouter)

mongoose.connect(DB)
    .then(() => console.log("Connected to DB Successfully"))
    .catch((e) => console.log(e))


app.listen(PORT, hostname, () =>
    console.log(`Server running at http://${hostname}:${PORT}/`)
)

