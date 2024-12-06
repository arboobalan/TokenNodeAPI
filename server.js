const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
const app = express();
dotenv.config();
const userInfo = require('./class/user.class');
const response = require('./response');

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const getStoredDataFromJwtToken = (token) => {
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        return decoded;
    } catch (err) {
        return null;
    }
};

const avoidApiType = ["userAuthenticate"];
const checkAuthorization = (req, res, next) => {
    const headerKey = 'X-manufacturer-Authorization';
    const jwtToken = req.headers[headerKey.toLowerCase()] || "";

    if (avoidApiType.includes(req.body.type)) {
        return next();
    }

    if (jwtToken) {
        const userDetail = getStoredDataFromJwtToken(jwtToken);
        if (!userDetail) {
            return response(res, 'token', 'Token Expired');
        }
        req.userDetail = userDetail;
        return next();
    } else {
        return response(res, 'invalidaccess', 'Access Denied');
    }
};

app.use(checkAuthorization);

app.post('/', async (req, res) => {
    const { type } = req.body;
    let result;

    switch (type) {
        case 'userAuthenticate':
            result = await userInfo.userAuthenticate(req, res);
            break;

        case 'getUserType':
            result = await userInfo.getUserType(req, res);
            break;

        default:
            return response(res, 'error', 'Invalid API type');
    }
});

const port = process.env.PORT;
app.listen(port, (err) => {
    if (err) {
        console.error('Server not connected');
    } else {
        console.log(`Server connected at : ${port}`);
    }
});