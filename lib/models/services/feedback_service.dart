// import 'package:flutter_email_sender/flutter_email_sender.dart';

// Future<bool> sendFeedbackEmail(String email, String feedback) async {
//   bool success = false;

//   final Email emailToSend = Email(
//     body: feedback,
//     subject: 'User Feedback from $email, Your Created Apps named \'ROBOTRACK\'',
//     recipients: ['earlbandiola0403@gmail.com'],
//     isHTML: false,
//   );

//   try {
//     await FlutterEmailSender.send(emailToSend); 
//     success = true;
//   } catch (e) {
//     print("Error sending email: $e");
//   }

//   return success;
// }
