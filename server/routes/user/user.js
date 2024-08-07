const express = require('express');
const User = require('../../models/user');
const auth = require('../../middleware/auth');
const Settings = require('../../models/setting');
const { storeSettings, getSettings } = require('../../utils/store_retrieve_settings');

const userRoute = express.Router();

/*
Create user and try creating user settings
*/
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

        // try creating user settings
        storeSettings(user_id, true, true, true);
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

// Add nextPage string to user
userRoute.post('/user/add-nextpage', auth, async (req, res) => {
    try {
        const { nextPage } = req.body;
        let user = await User.findByIdAndUpdate(req.uid, { nextPage });
        user = await user.save();
        res.json(user);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
})

// Get user
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

// update user settings in settings collection
userRoute.post('/user/update-settings', auth, async (req, res) => {
    try {
        const user_id = req.uid;
        const { store_history, show_history, show_liked, profile} = req.body;
        const settings = await storeSettings(user_id, store_history, show_history, show_liked, profile);
        if (!settings) {
            return res.status(404).json({ msg: "Could not update settings" })
        }
        res.json(settings);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
}
)

// get settings from settings collection
userRoute.get('/user/settings', auth, async (req, res) => {
    try {
        const user_id = req.uid;
        const userSettings = await getSettings(user_id);
        if (!userSettings) {
            return res.status(404).json({ msg: "User settings not found" });
        }
        return res.json(userSettings);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
}
)

module.exports = userRoute;