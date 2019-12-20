// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');




admin.initializeApp();


exports.sendNotification = functions.database.ref('/matches/{matchUid}')
    .onWrite(event => {
      const matches = event.data.val();
      const receiver=notes.receiver;
      const requester =notes.requester;
      console.log('We have a new match receiver:', receiver, 'requester:', requester);

      const receiverP= admin.auth().getUser(receiver);
      const requesterP=admin.auth().getUser(requester);
      const payloadReceiver={
            notification: {

                title: 'You have a match!'
                body:${requesterP.displayName} 'matched with you!'
            }

      }

      const payloadRequester={
              notification: {

                  title: 'You have a match!'
                  body:${receiverP.displayName} 'matched with you!'
              }

       }

      // Get the list of device notification tokens.
      const receiverToken = admin.database()
          .ref(`/users/${receiver}/tokens`).once('value');

      // Get the list of device notification tokens.
        const requesterToken = admin.database()
            .ref(`/users/${requester}/tokens`).once('value');


      console.log('Fetched receiver profile', receiverP);
      console.log('Fetched receiver profile', requesterP);

      // Send notifications to all tokens.
     admin.messaging().sendToDevice(receiverToken, payloadReceiver);
     admin.messaging().sendToDevice(requesterToken, payloadRequester);
      // For each message check if there was an error.
      const tokensToRemove = [];

      return Promise.all(tokensToRemove);
    });

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
