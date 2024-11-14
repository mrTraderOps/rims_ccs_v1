import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/feedback_service.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class FeedbackPage extends StatefulWidget {
  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedback = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Flag to track the loading state

  // Function to validate the email format
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Function to handle feedback submission
  Future<void> submitFeedback() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      // Send feedback email
      bool success = await sendFeedbackEmail(_emailController.text, _feedback.text);

      setState(() {
        _isLoading = false; // Hide loading indicator
      });

      if (success) {
        // Clear text controllers after successful submission
        _emailController.clear();
        _feedback.clear();

        // Optionally, show a success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Feedback sent successfully!'),
          backgroundColor: Colors.green,
        ));
      } else {
        // Optionally, show an error message if sending failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to send feedback. Please try again.'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Main Feedback Box
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title & Subtitle
                    Text(
                      "👋 Help us improve",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Let us know your concern and what we can improve.",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
            
                    // Feedback Form
                    Form(
                      key: _formKey, // Assign the key to the Form
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email Input with Validator
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: validateEmail,
                          ),
                          SizedBox(height: 20),
            
                          // Feedback Input
                          TextFormField(
                            controller: _feedback,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Anything else you’d like to share?',
                              hintText: 'I have feedback on...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
            
                          // Submit Button
                          ElevatedButton(
                            onPressed: _isLoading ? null : submitFeedback, // Disable button while loading
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Ui_Colors.darkBlue,
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  ) // Show loading indicator
                                : Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Robot Illustration at the Bottom
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                'assets/images/robot_feedback.png',
                fit: BoxFit.contain, // Add the robot image in your assets folder
                height: 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
