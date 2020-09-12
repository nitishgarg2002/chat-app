const functions = require('firebase-functions');
exports.myFunction = functions.firestore
.document('chat/{messages}')
.onCreate ((change,context)=> {
    console.log(change.after,data());
});