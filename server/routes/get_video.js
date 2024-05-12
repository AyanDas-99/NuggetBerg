const axios = require('axios');
const express = require('express')

const getVideoRoute = express.Router();

getVideoRoute.get("/video", async (req, res) => {
    const { nextPage } = req.params
    try {
    axios.get("https://www.googleapis.com/youtube/v3/search", {
        params: {
            key: process.env.API_KEY,
            part: "snippet",
            type: "video",
            channelId: "UCsooa4yRKGN_zEE8iknghZA",
            maxResults: 10,
            pageToken: nextPage
        }
    }).then((result) => {
        console.log(result)
        res.json(result.data) 
    }).catch((err) => {
        res.status(500).json(err)
    });
} catch (e) {
    res.status(500).json({
        error: e.message
    })
}
})

module.exports = getVideoRoute;