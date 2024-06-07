const express = require('express');
const User = require('../../models/user');
const auth = require('../../middleware/auth');

const userRoute = express.Router();

userRoute.post('/user/create', auth, async (req, res) => {
    try {
        const email = req.email;
        const user_id = req.uid;
        const existingUser = await User.findById(user_id);
        if (existingUser) {
            console.log(existingUser)
            return res.status(400).json({ msg: 'User with email already exists' });
        }

        let user = new User({
            _id: user_id,
            email,
        });
        user = await user.save();
        res.json(user);
    } catch (e) {
        return res.status(500).json({ error: e.message })
    }
})

// video will be removed from favourite, if already liked
userRoute.post('/user/add-to-favourite', auth, async (req, res) => {
    const { video_id } = req.body;
    try {
        const email = req.email;
        let user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: 'User with token not found' })
        }
        const indexOfVideoInFavourites = user.favourites.findIndex(item => item.video_id == video_id);
        if (indexOfVideoInFavourites < 0) {
            // Add to liked
            user.favourites.push({
                video_id: video_id
            })
        } else {
            // Already liked, remove
            user.favourites.splice(indexOfVideoInFavourites, 1);
        }
        await user.save();
        res.json(user);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
})

// Video will be added to viewed if not already
userRoute.post('/user/add-to-viewed', auth, async (req, res) => {
    const { video_id } = req.body;
    try {
        const email = req.email;
        let user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: 'User with token not found' })
        }
        const indexOfVideoInFavourites = user.viewed.findIndex(item => item.video_id == video_id);
        if (indexOfVideoInFavourites < 0) {
            // Add to liked
            user.viewed.push({
                video_id: video_id
            })
        } else {
            // Already viewed, return as is 
            return res.json(user);
        }
        await user.save();
        res.json(user);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
})

userRoute.get('/user', auth, async (req, res) => {
    try {
        const user_id = req.uid;

        const existingUser = await User.findById(user_id);
        if (!existingUser) {
            return res.status(204).json({ msg: "User with email doesn't exit" });
        }
        res.json(existingUser);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
}
)

module.exports = userRoute;