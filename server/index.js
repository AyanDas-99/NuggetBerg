const express = require('express')
const mongoose = require('mongoose')
const firebaseAdmin = require('firebase-admin')
require('dotenv').config()
const cors = require('cors')
const getVideoRoute = require('./routes/get_video')
const userRoute = require('./routes/user')
const getSummaryRoute = require('./routes/summary/get_summary')
const storeSummaryRoute = require('./routes/summary/store_summary')
require('./utils/genai');

const PORT = process.env.PORT || 3000
// Mongo DB init
const DB = `mongodb+srv://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@cluster0.zqk6qge.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`
const app = new express()

app.use(cors())
app.use(express.json())
app.use(getVideoRoute)
app.use(userRoute)
app.use(getSummaryRoute)
app.use(storeSummaryRoute)


app.get("/", (req, res) => {
    res.send("Welcome " + process.env.API_KEY)
})

// Firebase admin initialization
var serviceAccount = require("/home/ayan/Downloads/nuggetberg-7bbed-firebase-adminsdk-rmucu-1ec60f0316.json");

firebaseAdmin.initializeApp({
    credential: firebaseAdmin.credential.cert(serviceAccount),
});



// connect to mongoose
mongoose.connect(DB).then(() => {
    console.log('DB connection succesfull')
}).catch(e => {
    console.log(e)
})

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected to port: ${PORT} ${process.env.MONGO_USERNAME} ${process.env.MONGO_PASSWORD}`)
});