function filterShorts(jsonData) {
    data = jsonData["items"].filter((item) => {
        var title = item["snippet"]["title"].toUpperCase();
        var description = item["snippet"]["description"].toUpperCase();
        return !title.includes("SHORTS") && !description.includes("SHORTS");
    });
    return data;
}

module.exports = filterShorts;