const Settings = require('../models/setting');



async function getSettings(user_id) {
    const userSettings = await Settings.findOne({ user_id });
    return userSettings;

}

async function storeSettings(user_id, store_history, show_history, show_liked) {
    let settings = await Settings.findOneAndReplace({
        user_id
    }, { store_history, show_history, show_liked, user_id }, { upsert: true, new: true });

    settings = await settings.save();
    return settings;
}

module.exports = { getSettings, storeSettings }