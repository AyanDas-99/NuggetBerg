const { default: axios } = require("axios");
const getTranscript = require('./get_transcript');
const extractJson = require("./extractJson");
const {
  genAI,
  generationConfig,
  safetySettings,
  model,
} = require("./genai");



async function getSummaryAi(videoId) {
    try {
    const transcript = await getTranscript(videoId);
    console.log(JSON.stringify(transcript));
    if (transcript == undefined) {
      return res.status(500).json({ message: "Could not generate transcript" });
    }
    const chatSession = model.startChat({
      generationConfig,
      safetySettings,
      history: [
        {
          role: "user",
          parts: [
            {
              text: "A YouTube video transcript will be provided at the end of this prompt. Understand the core concepts of the video and generate a few key points that anyone can read and understand what the video is trying to teach. The transcript will be from an educational or motivational video.",
            },
            {
              text: "Title and description may be used to help generate the keypoints",
            },
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
The number of items and points in each item is dynamic`,
            },
          ],
        },
      ],
    });

    const result = await chatSession.sendMessage("");
    var data =
      result["response"]["candidates"][0]["content"]["parts"][0]["text"];
    jsondata = extractJson(data);
    console.log(jsondata);
    return jsondata;
    } catch (error) {
        console.error(error);
    }
}

module.exports = getSummaryAi;