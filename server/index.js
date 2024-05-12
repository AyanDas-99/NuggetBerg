const express = require('express')
const mongoose = require('mongoose')
require('dotenv').config()
const cors = require('cors')
const getVideoRoute = require('./routes/get_video')
// const getSummaryRoute = require('./routes/get_summary')

const PORT = process.env.PORT || 3000
const DB = `mongodb+srv://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@cluster0.zqk6qge.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`

const app = new express()

app.use(cors())
app.use(express.json())
app.use(getVideoRoute)
// app.use(getSummaryRoute)


app.get("/", (req, res) => {
    res.send("Welcome " + process.env.API_KEY)
})


// connect to mongoose
mongoose.connect(DB).then(()=> {
    console.log('DB connection succesfull')
}).catch(e => {
    console.log(e)
})

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected to port: ${PORT} ${process.env.MONGO_USERNAME} ${process.env.MONGO_PASSWORD}`)
});