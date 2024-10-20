import 'package:flutter/material.dart';
import 'package:flutter_easy_faq/flutter_easy_faq.dart';
import 'package:vibehunt/utils/constants.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(
          'Terms and Conditions',
          style: j24,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: ListView(
          children: const [
            _TermsTile(
              question: '1. Acceptance of Terms',
              answer:
                  'By accessing or using VibeHunt, you agree to be bound by these Terms and Conditions, as well as our Privacy Policy. If you do not agree with any part of these terms, you must not use our services.',
            ),
            _TermsTile(
              question: '2. User Accounts',
              answer:
                  '- Registration: To use VibeHunt, you must create an account with a valid email address and accurate personal information.\n- Responsibility: You are responsible for maintaining the confidentiality of your account and password and for restricting access to your device. You agree to accept responsibility for all activities that occur under your account.',
            ),
            _TermsTile(
              question: '3. Privacy and Data Security',
              answer:
                  '- Data Collection: We collect and process your personal data as described in our Privacy Policy.\n- Data Encryption: All your data on VibeHunt is encrypted using industry-standard encryption technologies.\n- Data Safety: We are committed to maintaining the confidentiality and security of your information.',
            ),
            _TermsTile(
              question: '4. User Conduct',
              answer:
                  'You agree not to use VibeHunt to:\n- Post any content that is unlawful, harmful, threatening, abusive, or otherwise objectionable.\n- Violate any local, state, national, or international law.\n- Harass or impersonate any person or entity.\n- Use VibeHunt for any unauthorized commercial purposes.',
            ),
            _TermsTile(
              question: '5. Content Ownership and Rights',
              answer:
                  '- User Content: You retain ownership of all the content you post. By posting content, you grant VibeHunt a worldwide, non-exclusive, royalty-free license to use and display it.\n- VibeHunt Content: All other content on VibeHunt is owned by VibeHunt or its licensors and is protected by intellectual property laws.',
            ),
            _TermsTile(
              question: '6. Modifications to the Service',
              answer:
                  'VibeHunt reserves the right to modify or discontinue the service with or without notice. VibeHunt will not be liable to you or any third party for any modification, suspension, or discontinuation of the service.',
            ),
            _TermsTile(
              question: '7. Termination',
              answer:
                  'VibeHunt reserves the right to terminate or suspend your account for conduct that violates these Terms and Conditions or is harmful to other users or third parties.',
            ),
            _TermsTile(
              question: '8. Disclaimers and Limitation of Liability',
              answer:
                  '- Service Provided "As Is": VibeHunt is provided on an "as is" basis without warranties.\n- Limitation of Liability: VibeHunt will not be liable for any indirect, incidental, or special damages.',
            ),
            _TermsTile(
              question: '9. Governing Law',
              answer:
                  'These Terms and Conditions are governed by the laws of [Your Jurisdiction], without regard to its conflict of law principles.',
            ),
            _TermsTile(
              question: '10. Changes to Terms and Conditions',
              answer:
                  'VibeHunt may revise these terms from time to time. By continuing to use the app, you agree to be bound by the revised terms.',
            ),
            _TermsTile(
              question: '11. Contact Us',
              answer:
                  'If you have any questions about these Terms and Conditions, please contact us at support@vibehunt.com.',
            ),
          ],
        ),
      ),
    );
  }
}

class _TermsTile extends StatelessWidget {
  final String question;
  final String answer;

  const _TermsTile({required this.question, required this.answer, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: EasyFaq(
        question: question,
        answer: answer,
        questionTextStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        anserTextStyle: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
