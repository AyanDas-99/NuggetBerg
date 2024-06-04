const { default: axios, Axios, AxiosError } = require("axios");

async function getTranscript(videoId) {
    try {
        const response = await axios.get('https://youtube-transcriptor.p.rapidapi.com/transcript', {
            params: {
                video_id: videoId,
                lang: 'en'
            },
            headers: {
                'x-rapidapi-key': 'e0b6052bacmshcfe5da2fca3f2e5p14d484jsn5c655e5224c5',
                'x-rapidapi-host': 'youtube-transcriptor.p.rapidapi.com'
            }
        }
        );
        if (response.status == 200) {
            if(response.data[0] == undefined) return null;
            const data = response.data[0];
            return {
                title: data['title'],
                description: data['description'],
                transcript: data['transcriptionAsText']
            };

        }
        return null;
    } catch (error) {
        console.log(error);
        throw error;
    }
}

module.exports = getTranscript;