
const functions = require('firebase-functions');

const nodemailer = require('nodemailer');

const admin = require('firebase-admin');

admin.initializeApp();


var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'davidomini@gmail.com',
        pass: '**************'
    }
});


exports.sendMailOverHTTP = functions.https.onRequest((req, res) => {

        const mailOptions = {
            from: 'no-reply@grasp.com',
            to: req.query.dest,
            subject: 'KYC Processing',
            html: "<h1>KYC Status</h1><p><b>Document is being processed. Thanks</b></p>"
        };


        return transporter.sendMail(mailOptions, (error, data) => {
            if (error) {
                console.log(error)
                return
            }
            console.log("Sent!")
        });
    });




