const axios = require('axios');
const express = require('express')
const getTranscript = require('../utils/get_transcript')
const extractJson = require('../utils/extractJson')
const { genAI, generationConfig, safetySettings, model } = require('../utils/genai')

const getSummaryRoute = express.Router();

const format = {
    items: [
        {
            header: 'header',
            points: [
                {
                    title: 'title',
                    text: 'text',
                },
                {
                    title: 'title',
                    text: 'text',
                },
            ]
        },
        {
            header: 'header',
            points: [
                {
                    title: 'title',
                    text: 'text',
                },
                {
                    title: 'title',
                    text: 'text',
                },
            ]
        },
    ]
};

getSummaryRoute.get("/summary", async (req, res) => {
    const { videoId } = req.query;
    try {
        const transcript = await getTranscript(videoId);
        console.log(JSON.stringify(transcript))
        if (transcript == undefined) {
            return res.status(500).json({ message: 'Could not generate transcript' });
        }
        const chatSession = model.startChat({
            generationConfig,
            safetySettings,
            history: [
                {
                    role: "user",
                    parts: [
                        { text: "A YouTube video transcript will be provided at the end of this prompt. Understand the core concepts of the video and generate a few key points that anyone can read and understand what the video is trying to teach. The transcript will be from an educational or motivational video." },
                        { text: "Title and description may be used to help generate the keypoints" },
                        { text: JSON.stringify(transcript) },
                        {
                            text: `Return the points in JSON using the following structure:
{
"items":[
{
"header":{header},
"points":[
{
"title": {title},
"text": {text},
},
]
}
]
}
The number of items and points in each item is dynamic` },
                    ],
                },
            ],
        });

        const result = await chatSession.sendMessage("");
        var data = result['response']['candidates'][0]['content']['parts'][0]['text'];
        jsondata = extractJson(data);
        console.log(jsondata);

        res.json(jsondata);
    } catch (e) {
        res.status(500).json({
            error: e.message
        })
    }
})

module.exports = getSummaryRoute;