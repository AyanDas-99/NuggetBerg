const mongoose = require("mongoose")

const settingsScheme = new mongoose.Schema({
    user_id: String,
    store_history: Boolean,
    show_history: Boolean,
    show_liked: Boolean,
    profile: String,
})

const Settings = mongoose.model('Settings', settingsScheme);

module.exports = Settings;