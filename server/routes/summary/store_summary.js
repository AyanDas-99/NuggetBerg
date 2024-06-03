const axios = require("axios");
const express = require("express");
const storeSummary = require("../../utils/store_summary");
const storeSummaryRoute = express.Router();

// Get summary (db or ai)
storeSummaryRoute.post("/summary/add", async (req, res) => {
  const {videoId, summary} = req.body;
  try {
    const summarydoc = await storeSummary(videoId, summary);
    res.json(summarydoc);
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
});


module.exports = storeSummaryRoute;