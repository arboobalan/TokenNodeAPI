const db = require("../config/db.class");
const jwt = require('jsonwebtoken');
const response = require('../response');
const dotenv = require("dotenv");
dotenv.config();

class user {
    constructor(db) {
        this.db = db.databaseConn;
    }

    async userAuthenticate(req, res) {
        const { email_id, pass_word } = req.body;
        try {
            var _sql = `SELECT ul.m_user_type_id, mut.user_type, ul.user_name, ul.email_id, ul.user_login_id
                        FROM user_login ul 
                        INNER JOIN m_user_type mut ON mut.m_user_type_id = ul.m_user_type_id
                        WHERE ul.email_id = ? AND ul.pass_word = MD5(?) AND ul.is_deleted = 0 
                        AND mut.is_deleted = 0`;

            await db.query(_sql, [email_id, pass_word], (error, result) => {
                if (error) {
                    return response(res, 'error', 'Internal server error');
                }

                if (result.length === 0) {
                    return response(res, 'error', 'Invalid credentials');
                }
                const token = jwt.sign({ email_id }, process.env.JWT_SECRET, { expiresIn: "1h" });
                const _rtoken = jwt.sign({ email_id }, process.env.REFRESH_KEY, { expiresIn: "7d" });

                const userData = result[0];
                userData._token = token;
                userData._rtoken = _rtoken;
                return response(res, 'success', 'Login Successfully', result[0]);
            });

        } catch (err) {
            return response(res, 'error', 'UserAuthenticate API Failed')
        }
    }

    async getUserType(req, res) {
        try {
            var _sql = `SELECT m_user_type_id AS 'm_user_type_id', CONCAT(UCASE(LEFT(user_type, 1)), SUBSTRING(user_type, 2)) 
                         AS 'user_type' FROM m_user_type WHERE is_deleted = 0 ORDER BY user_type ASC`;
            const result = await new Promise((resolve, reject) => {
                db.query(_sql, (err, rows) => {
                    if (err) {
                        reject('Error fetching user types');
                    } else {
                        resolve(rows);
                    }
                });
            });
            return response(res, 'success', 'Usertype Get Successfully.', result);
        } catch (err) {
            return response(res, 'error', 'UserType API Failed');
        }
    }

}

const userInfo = new user(db);
module.exports = userInfo;