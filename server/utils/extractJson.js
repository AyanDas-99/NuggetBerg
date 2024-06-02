// Extract json from GeminiAPI text response
function extractJson(text) {
    const openingIndex = text.indexOf('{');
    const closingIndex = text.lastIndexOf('}');
    if (openingIndex !== -1 && closingIndex !== -1 && closingIndex > openingIndex) {
        return JSON.parse(text.substring(openingIndex, closingIndex + 1).replaceAll("\n", "")); // Include closing brace
    }
    return null; // Not found
}

module.exports = extractJson;


