const mongoose = require('mongoose')

const videoSchema = new mongoose.Schema({
    video_id: {
        required: true,
        type: String
    }
},
    {
        timestamps: {
            createdAt: true,
            updatedAt: false
        }
    }
)

const userSchema = new mongoose.Schema({
    _id: String,
    email: {
        require: true,
        type: String,
        trip: true,
        validate: {
            validator: (value) => {
                const regex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(regex);
            },
            message: "Please enter a valid email",
        }
    },
    name: {
        required: false,
        type: String,
        trim: true,
    },
    favourites: [videoSchema],
    viewed: [videoSchema]
})

const User = mongoose.model('User', userSchema);

module.exports = User;