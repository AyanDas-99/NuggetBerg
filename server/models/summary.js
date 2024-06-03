const mongoose = require('mongoose')

const pointScheme = new mongoose.Schema({
    title: String,
    text: String,
});

const itemScheme = new mongoose.Schema({
    header: String,
    points: [pointScheme],
})

const summaryScheme = new mongoose.Schema({
    _id: String,
    items: [itemScheme],
});

const Summary = mongoose.model("Summary", summaryScheme);
module.exports = {Summary, pointScheme, itemScheme, summaryScheme};