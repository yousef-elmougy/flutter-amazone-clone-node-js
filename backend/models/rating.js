const mongoose = require("mongoose");
const RatingSchema = mongoose.Schema({
    userId: {
        type: String,
        required: [true, "userId is required"],
    },
    rating: {
        type: Number,
        required: [true, "rating is required"],
    },
});


module.exports = RatingSchema;
