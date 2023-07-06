const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");
const authRouter = express.Router();

authRouter.post("/api/register", async (req, res) => {
    try {
        const { name, email, password } = req.body;
        const emailExist = await User.findOne({ email });
        if (emailExist) {
            return res.status(400).json({ message: "email is already exist" });
        }
        if (password.length < 6) {
            return res
                .status(400)
                .json({ message: "message: 'please inter a long password" });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);

        const user = User({ name, email, password: hashedPassword });
        await user.save();
        return res.json(user);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

authRouter.post("/api/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            return res
                .status(400)
                .json({ message: "User with this email does not exist!" });
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: "The Password is Wrong" });
        }
        const token = jwt.sign({ id: user._id }, "passwordKey");
        return res.json({ token, ...user._doc });
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token")
        if (!token) return res.json(false)
        const isVerify = jwt.verify(token, "passwordKey")
        if (!isVerify) return res.json(false)
        const user = User.findById(isVerify.id)
        if (!user) return res.json(false)
        return res.json(true)
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user)
    return res.json({ ...user._doc, token: req.token })
})

authRouter.put('/api/address', auth, async (req, res) => {
    const { address } = req.body
    const user = await User.findOneAndUpdate({ _id: req.user }, { address: address }, { new: true })
    return res.json(user)
})

module.exports = authRouter;
