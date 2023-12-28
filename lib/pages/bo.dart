//  addMessage(bool sendClicked) {
//     if (messagecontroller.text != "") {
//       String message = messagecontroller.text;
//       messagecontroller.text = "";

//       DateTime now = DateTime.now();
//       String formattedDate = DateFormat('h:mma').format(now);
//       Map<String, dynamic> messageInfoMap = {
//         "message": message,
//         "sendBy": myUserName,
//         "ts": formattedDate,
//         "time": FieldValue.serverTimestamp(),
//         "imgUrl": myProfilePic,
//       };
//       messageId ??= randomAlphaNumeric(10);

//       DatabaseMethods()
//           .addMessage(chatRoomId!, messageId!, messageInfoMap)
//           .then((value) {
//         Map<String, dynamic> lastMessageInfoMap = {
//           "lastMessage": message,
//           "lastMessageSendTs": formattedDate,
//           "time": FieldValue.serverTimestamp(),
//           "lastMessageSendBy": myUserName,
//         };
//         DatabaseMethods()
//             .updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
//         if (sendClicked) {
//           messageId = null;
//         }
//       });
//     }
//   }