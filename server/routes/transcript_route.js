const axios = require("axios");
const express = require("express");
const getTranscript = require("../utils/get_transcript");

const transcriptRoute = express.Router();

transcriptRoute.get("/transcript", async (req, res) => {
    const { videoId } = req.query;
    try {
        const transcript = await getTranscript(videoId);
        if (transcript == null) {
            return res.status(204).json({ msg: 'Transcript not available' });
        }
        res.json(transcript);
    } catch (e) {
        res.status(500).json({
            error: e.message,
        });
    }
});

module.exports = transcriptRoute;
