import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yatayat/components/button.dart';
import 'package:yatayat/services/database.dart';
import 'package:yatayat/shared/constants.dart';

class FeedbackContact extends StatefulWidget {
  const FeedbackContact({Key? key}) : super(key: key);
  static const id = 'feedbackContact';

  @override
  _FeedbackContactState createState() => _FeedbackContactState();
}

class _FeedbackContactState extends State<FeedbackContact> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  String? _subjectError;
  String? _messageError;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback & Contact (प्रतिक्रिया र सम्पर्क)'),
        backgroundColor: kThemeColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Contact us by send us your feedbacks, messages or problems regarding Hamro Yatayat and its services.\n\nहाम्रो सेवा र यसका सेवाहरू बारे आफ्नो प्रतिक्रिया, सन्देश वा समस्याहरू पठाएर हामीलाई सम्पर्क गर्नुहोस्।',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: TextField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    hintText: 'Enter Subject (विषय लेख्नुहोस्)',
                    labelText: 'Subject',
                    errorText: _subjectError,
                    errorMaxLines: 3,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey1,
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText:
                        'Enter Message or Feedback (सन्देश वा प्रतिक्रिया लेख्नुहोस्)',
                    labelText: 'Message',
                    errorText: _messageError,
                    errorMaxLines: 3,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.message,
                    ),
                  ),
                  maxLines: 10,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              YatayatButton(
                label: 'Send Message (सन्देश पठाउनुहोस्)',
                onClick: () async {
                  setState(() {
                    if (_subjectController.text.length < 5) {
                      _subjectError =
                          'Subject must be more than 5 characters in length. (विषयको लम्बाइमा ५ वर्ण भन्दा बढी हुनुपर्छ।)';
                    } else {
                      _subjectError = null;
                    }
                    if (_messageController.text.length < 10) {
                      _messageError =
                          'Message must be more than 10 characters in length. (सन्देशको लम्बाइ १० वर्ण भन्दा बढी हुनुपर्छ।)';
                    } else {
                      _messageError = null;
                    }
                  });

                  if (_subjectError == null && _messageError == null) {
                    print(_messageController.text);
                    print(_subjectController.text);
                    try {
                      await Database.sendMessage(
                          customerId: _auth.currentUser!.uid,
                          subject: _subjectController.text,
                          messsage: _messageController.text);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Success !'),
                          content: Text(
                              'Message or Feedback sent successfully !! \n(सन्देश वा प्रतिक्रिया सफलतापूर्वक पठाइयो !!)'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('Ok (ठिक छ)'),
                            )
                          ],
                        ),
                      );
                    } catch (e) {
                      print(e);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error !'),
                          content: Text(
                              'Uh oh! Error occured while sending message! Please try again later ! \n(ओहो! सन्देश पठाउँदा केहि त्रुटि भयो! फेरी प्रयास गर्नु होला !)'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('Ok (ठिक छ)'))
                          ],
                        ),
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
