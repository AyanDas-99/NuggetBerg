const axios = require("axios");
const express = require("express");
const { Summary } = require("../../models/summary");
const getSummaryAi = require("../../utils/get_summary_ai");
const storeSummary = require("../../utils/store_summary");
const {
  genAI,
  generationConfig,
  safetySettings,
  model,
} = require("../../utils/genai");

const getSummaryRoute = express.Router();
/*
Get summary from DB if exists or AI 

To be used generally used by app
*/
getSummaryRoute.get("/summary", async (req, res) => {
  const { videoId } = req.query;
  try {
    // If summary exists get that
    const existingSummary = await Summary.findById(videoId);
    if (existingSummary) {
      return res.json(existingSummary);
    }
    // Get summary from ai
    const summary = await getSummaryAi(videoId);
    storeSummary(videoId, summary);
    res.json({
      _id: videoId,
      items: summary["items"]
    });
  } catch (error) {
    res.status(500).json({
      error: e.message,
    });
  }
});

/*
Get summary from ai
Usage not recommended
*/
getSummaryRoute.get("/summary/ai", async (req, res) => {
  const { videoId } = req.query;
  try {
    const summary = await getSummaryAi(videoId);
    res.json(summary);
  } catch (e) {
    res.status(500).json({
      error: e.message,
    });
  }
});

/*
Get summary from db 
Usage not recommended
*/
getSummaryRoute.get("/summary/db", async (req, res) => {
  const { videoId } = req.query;
  try {
    const summary = await Summary.findById(videoId);
    if(!summary) {
      return res.status(204).json({msg: 'No summary for this videoId is available on the server'});
    }
    res.json(summary);
  } catch (err) {
    res.status(500).json({
      error: e.message,
    });
  }
});

module.exports = getSummaryRoute;
