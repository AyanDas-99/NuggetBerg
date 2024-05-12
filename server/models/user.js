const mongoose = require('mongoose')

const userSchema = new mongoose.Schema({
    user_id: String,
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
        required: true,
        type: String,
        trim: true,
    },
})

const User = mongoose.model('User', userSchema);

module.exports = User;