const { default: axios } = require("axios");
const {
  Summary,
  itemScheme,
  pointScheme,
  summaryScheme,
} = require("../models/summary");

async function storeSummary(videoId, summary) {
  try {
    const existingSummary = await Summary.findById(videoId);
    if (existingSummary) {
      console.log(existingSummary);
      return res.status(400).json({ msg: "Summary with the id exists" });
    }
    let summarydoc = new Summary({
      _id: videoId,
      items: summary["items"],
    });

    summarydoc = await summarydoc.save();
    return summarydoc;
  } catch (error) {
    console.error(error);
  }
}

module.exports = storeSummary;
