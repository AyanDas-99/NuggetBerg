# NuggetBerg - AI powered micro-learning app

The app provides concise, easily digestible summaries, saving time while delivering valuable information. This innovative approach ensures that users get the most out of personal growth content without the need to watch entire videos.

- Summarizes personal growth videos from YouTube into key knowledge points.
- Saves time by providing concise, actionable summaries.

## Installation

### Prerequisites

  - MongoDB account
  - Firebase Account
  - Gemini API key
  - Youtube Data API

### Steps
#### 1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/your-repo-name.git```
```

#### 2. In the `server/` folder, add a `.env` file
```
PORT=
MONGO_USERNAME=
MONGO_PASSWORD=
API_KEY=<Youtube data api>
GEMINI_API_KEY=
``` 


#### 3. Get all the pub packages

    - Get all flutter packages
    ```
    Flutter pub get
    ```
    - Get all the npm packages
    ```
    npm i
    ```

#### 4. Run the server
  - Open `server/` folder
  - Run command `npm run dev`
  
#### 5. Run the Flutter app with android

## License:

- MIT License