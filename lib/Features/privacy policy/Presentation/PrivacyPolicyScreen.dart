import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade100,
              Colors.white,
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 220.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                    Shadow(
                    blurRadius: 10.0,
                    color: Colors.black45,
                    offset: Offset(1, 1),
                    )],
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade700,
                        Colors.blue.shade500,
                        Colors.lightBlue.shade300,
                      ],
                      stops: [0.1, 0.5, 0.9],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 30,
                        bottom: 20,
                        child: Icon(
                          Icons.lock,
                          size: 80,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      Positioned(
                        left: 40,
                        top: 40,
                        child: Icon(
                          Icons.security,
                          size: 60,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.privacy_tip,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 32.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          icon: Icons.description,
                          title: 'Introduction',
                          subtitle: 'Your privacy matters to us',
                        ),
                        _buildSectionContent(
                          'We are committed to protecting your personal information and your right to privacy. '
                              'This Privacy Policy explains how we collect, use, disclose, and safeguard your information '
                              'when you use our services.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.collections_bookmark,
                          title: 'Information Collection',
                          subtitle: 'What we collect and why',
                        ),
                        _buildSectionContent(
                          'We collect personal information that you voluntarily provide to us when you register, '
                              'express interest in our services, or contact us. This may include:\n'
                              '• Contact information (name, email, phone number)\n'
                              '• Account credentials (username, password)\n'
                              '• Device information (model, OS version)\n'
                              '• Usage data (features accessed, time spent)',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.data_usage,
                          title: 'Data Usage',
                          subtitle: 'How we use your information',
                        ),
                        _buildSectionContent(
                          'We use personal information collected via our services for various business purposes:\n'
                              '• To provide and operate our services\n'
                              '• To personalize your experience\n'
                              '• To send administrative information\n'
                              '• To protect our services and users\n'
                              '• For business transfers (mergers, acquisitions)\n'
                              '• For legal compliance and fraud prevention',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.share,
                          title: 'Data Sharing',
                          subtitle: 'When we share information',
                        ),
                        _buildSectionContent(
                          'We may share your information in the following situations:\n'
                              '• With service providers who perform services for us\n'
                              '• With business partners to offer you certain products or services\n'
                              '• During business transfers (merger, sale of assets)\n'
                              '• With law enforcement when required by law\n'
                              '• With third-party advertisers for marketing purposes',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.security,
                          title: 'Data Security',
                          subtitle: 'Protecting your information',
                        ),
                        _buildSectionContent(
                          'We implement appropriate technical and organizational security measures designed to protect '
                              'the security of any personal information we process. These include:\n'
                              '• Encryption of data in transit and at rest\n'
                              '• Regular security audits and vulnerability scanning\n'
                              '• Access controls and authentication mechanisms\n'
                              '• Incident response planning\n\n'
                              'Despite our safeguards, no electronic transmission over the internet can be guaranteed to be 100% secure.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.cookie,
                          title: 'Cookies & Tracking',
                          subtitle: 'Technologies we use',
                        ),
                        _buildSectionContent(
                          'We may use cookies and similar tracking technologies to access or store information. '
                              'Specific information about how we use such technologies and how you can refuse certain cookies '
                              'is set out in our Cookie Policy.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.policy,
                          title: 'Data Retention',
                          subtitle: 'How long we keep your information',
                        ),
                        _buildSectionContent(
                          'We retain your personal information only for as long as necessary to fulfill the purposes '
                              'outlined in this policy, unless a longer retention period is required or permitted by law. '
                              'When we no longer need to process your personal information, we will delete or anonymize it.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.public,
                          title: 'International Transfers',
                          subtitle: 'Global data processing',
                        ),
                        _buildSectionContent(
                          'Your information may be transferred to, and maintained on, computers located outside of your '
                              'country where data protection laws may differ. We ensure appropriate safeguards are in place '
                              'for such transfers as required by applicable laws.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.child_care,
                          title: "Children's Privacy",
                          subtitle: 'Protecting young users',
                        ),
                        _buildSectionContent(
                          'Our services do not address anyone under the age of 13. We do not knowingly collect personal '
                              'information from children under 13. If we become aware that we have collected personal information '
                              'from a child under 13, we take steps to remove that information.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.settings,
                          title: 'Your Privacy Rights',
                          subtitle: 'Control over your information',
                        ),
                        _buildSectionContent(
                          'Depending on your location, you may have rights including:\n'
                              '• Accessing, updating, or deleting your information\n'
                              '• Correcting inaccurate information\n'
                              '• Objecting to processing of your information\n'
                              '• Requesting data portability\n'
                              '• Withdrawing consent\n\n'
                              'To exercise these rights, please contact us using the details provided below.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.notifications_active,
                          title: 'Policy Updates',
                          subtitle: 'Staying informed',
                        ),
                        _buildSectionContent(
                          'We may update this privacy policy from time to time. The updated version will be indicated by an '
                              'updated "Revised" date and will be effective as soon as accessible. We encourage you to review this '
                              'privacy policy frequently to stay informed.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.contact_support,
                          title: 'Contact Us',
                          subtitle: 'Questions and concerns',
                        ),
                        _buildSectionContent(
                          'If you have questions or comments about this policy, you may contact our Data Protection Officer at:\n\n'
                              'Email: privacy@yourapp.com\n'
                              'Address: 123 Privacy Lane, San Francisco, CA 94105\n'
                              'Phone: +1 (555) 123-4567\n\n'
                              'We aim to respond to all requests within 30 days.',
                        ),
                        const SizedBox(height: 40),
                        _buildAcceptanceBox(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      {required IconData icon, required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade300, width: 2),
            ),
            child: Icon(
              icon,
              size: 28,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContent(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.blue.shade100, width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.6,
          color: Colors.black87,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildAcceptanceBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade700,
            Colors.blue.shade500,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade300,
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Your Privacy Matters',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'By using our services, you acknowledge that you have read and understood '
                'this Privacy Policy. We are committed to protecting your personal information '
                'and providing transparency about our data practices.',
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text(
              'Last Updated: June 13, 2025',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Version 2.1',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}