const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);
// const db = admin.firestore();

// ============================================================
// exports.helloWorld = functions.database.ref('fcm-token/{id}')
//     .onWrite( (change, context) => {
// ============================================================
    exports.pushNoti = functions.firestore.document('users/{userId}')
        .onWrite((change, context) => {
// ============================================================
    //TODO: database => firestore 로 바꾸기
    var request = change.after.exists ? change.after.data() : null;
    const payload = {
        notification:{
            title : 'RUN TOGETHER !',
            body : request.userName + '님! 저와 Challenge 함께 해요!',
            badge : '1',
            sound : 'default' 
        } //TODO: notification 내용 어떻게 입맛에 맞게 바꿀 수 있는지?
    };

    // return admin.database().ref('fcm-token').once('value').then((allToken) => {
        // if(allToken.val()){
        //     console.log('token available');
        //     const token = Object.keys(allToken.val());
        //     return admin.messaging().sendToDevice(token, payload);
        // }else{
        //     return console.log('No token available');
        // }
        
    if(request.userTokenId){
        console.log('token availableg합니다..!!');
        const token = request.userTokenId;
        return admin.messaging().sendToDevice(token, payload);
    }
    else{
        return console.log('No token available합니다..ㅜㅠ');    
    }
    // });
});