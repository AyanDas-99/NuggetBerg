const axios = require("axios");
const express = require("express");
const filterShorts = require("../utils/filter_shorts");
const User = require('../models/user');
const auth = require('../middleware/auth');

const getVideoRoute = express.Router();

getVideoRoute.get("/videos", auth, async (req, res) => {
  const { nextPage } = req.query;
  try {
    axios
      .get("https://www.googleapis.com/youtube/v3/search", {
        params: {
          key: process.env.API_KEY,
          part: "snippet",
          type: "video",
          videoCategories: 25,
          q: "motivation+OR+self+help+OR+inspirational+OR+self+improvement+OR+TED+Ed",
          maxResults: 25,
          pageToken: nextPage,
        },
      })
      .then(async (result) => {
        result.data["items"] = filterShorts(result.data);
        res.json(result.data);
      })
      .catch((err) => {
        res.status(500).json(err);
      });
  } catch (e) {
    res.status(500).json({
      error: e.message,
    });
  }
});

getVideoRoute.get("/video-by-id",  async (req, res) => {
  const { id } = req.query;
  try {
    axios
      .get("https://www.googleapis.com/youtube/v3/videos", {
        params: {
          key: process.env.API_KEY,
          part: "snippet,contentDetails,statistics",
          type: "video",
          id: id, 
        },
      })
      .then(async (result) => {
        res.json(result.data);
      })
      .catch((err) => {
        res.status(500).json(err);
      });
  } catch (e) {
    res.status(500).json({
      error: e.message,
    });
  }
});

module.exports = getVideoRoute;
