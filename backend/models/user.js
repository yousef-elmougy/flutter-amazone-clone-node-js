const mongoose = require("mongoose");
// const { productSchema } = require("./product");
const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: [true, 'name is required'],
        trim: true,
    },
    email: {
        type: String,
        required: [true, 'email is required'],
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re)
            },
            message: 'please inter a valid email address',
        },
    },
    password: {
        type: String,
        required: [true, 'password is required'],
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    // cart: [{
    //     product: productSchema,
    //     quantity: {
    //         type: Number,
    //         default:0
    //     }, 
    // }],
})

const User = mongoose.model('User', userSchema)

module.exports = User