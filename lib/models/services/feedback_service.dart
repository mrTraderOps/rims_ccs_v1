import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<bool> sendFeedbackEmail(String feedback) async {
  bool success = false;

  final Email emailToSend = Email(
    body: feedback,
    subject: 'ROBOTRACK : User Feedback',
    recipients: ['earlbandiola0403@gmail.com'],
    isHTML: false,
  );

  try {
    await FlutterEmailSender.send(emailToSend); 
    success = true;
  } catch (e) {
    print("Error sending email: $e");
  }

  return success;
}
