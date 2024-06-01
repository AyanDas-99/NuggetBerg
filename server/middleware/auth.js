const admin = require('firebase-admin')

const auth = async(req, res, next) => {
    try {
        const accessToken = req.header('accessToken');
        console.log(`TOken is .. ${accessToken}`);
        const decodedToken = await admin.auth().verifyIdToken(accessToken);
        console.log('Decoded token is..');
        console.log(decodedToken);
        const userEmail = decodedToken.email;
        req.email = userEmail;
        req.uid= decodedToken.uid;
        next();
    } catch(e) {
        res.status(500).json({error: e.message});
    }
}

module.exports = auth;