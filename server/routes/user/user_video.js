const express = require('express');
const User = require('../../models/user');
const auth = require('../../middleware/auth');

const userVideoRoute = express.Router();

userVideoRoute.post('/user/video/add-favourite')

