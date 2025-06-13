import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
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
                  'Terms of Service',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black45,
                        offset: Offset(1, 1),
                      ),
                    ],
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
                          Icons.description,
                          size: 80,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      Positioned(
                        left: 40,
                        top: 40,
                        child: Icon(
                          Icons.gavel,
                          size: 60,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.handshake,
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
                          subtitle: 'Welcome to our service',
                        ),
                        _buildSectionContent(
                          'These Terms of Service ("Terms") govern your access to and use of our services. '
                              'By accessing or using our services, you agree to be bound by these Terms.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.account_circle,
                          title: 'Accounts',
                          subtitle: 'Your responsibilities',
                        ),
                        _buildSectionContent(
                          'You must provide accurate information when creating an account. You are responsible '
                              'for safeguarding your account and for any activities or actions under your account. '
                              'Immediately notify us of any unauthorized use of your account.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.security,
                          title: 'User Conduct',
                          subtitle: 'Acceptable use',
                        ),
                        _buildSectionContent(
                          'You agree not to misuse our services. For example, you must not:\n'
                              '• Violate any laws or regulations\n'
                              '• Interfere with or disrupt our services\n'
                              '• Send spam or unsolicited messages\n'
                              '• Access, tamper with, or use non-public areas of the service',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.copyright,
                          title: 'Intellectual Property',
                          subtitle: 'Rights and permissions',
                        ),
                        _buildSectionContent(
                          'We retain all rights, title, and interest in and to our services, including all '
                              'associated intellectual property rights. These Terms do not grant you any rights '
                              'to our trademarks, logos, or other brand features.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.money_off,
                          title: 'Payment Terms',
                          subtitle: 'For premium services',
                        ),
                        _buildSectionContent(
                          'If you purchase any of our paid services, you agree to pay the specified fees. '
                              'Fees are non-refundable except as required by law. We may change our fees at any time '
                              'by posting the changes on our website.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.block,
                          title: 'Termination',
                          subtitle: 'Ending your access',
                        ),
                        _buildSectionContent(
                          'We may suspend or terminate your access to our services at any time, with or without '
                              'cause or notice. Upon termination, your right to use the services will immediately cease.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.warning,
                          title: 'Disclaimers',
                          subtitle: 'Service limitations',
                        ),
                        _buildSectionContent(
                          'Our services are provided "as is" without any warranties, express or implied. '
                              'We do not warrant that the services will be uninterrupted, secure, or error-free. '
                              'Your use of the services is at your sole risk.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.balance,
                          title: 'Limitation of Liability',
                          subtitle: 'Our responsibilities',
                        ),
                        _buildSectionContent(
                          'To the maximum extent permitted by law, we shall not be liable for any indirect, '
                              'incidental, special, consequential, or punitive damages, or any loss of profits or '
                              'revenues, whether incurred directly or indirectly.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.gavel,
                          title: 'Governing Law',
                          subtitle: 'Legal jurisdiction',
                        ),
                        _buildSectionContent(
                          'These Terms shall be governed by the laws of the State of California without regard '
                              'to conflict of law principles. Any disputes relating to these Terms will be subject '
                              'to the exclusive jurisdiction of the courts located in San Francisco County.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.update,
                          title: 'Changes to Terms',
                          subtitle: 'Updates and modifications',
                        ),
                        _buildSectionContent(
                          'We may modify these Terms at any time. We will provide notice of significant changes '
                              'through our services or by other means. By continuing to use our services after changes '
                              'become effective, you agree to be bound by the revised Terms.',
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                          icon: Icons.contact_support,
                          title: 'Contact Us',
                          subtitle: 'Questions and concerns',
                        ),
                        _buildSectionContent(
                          'If you have any questions about these Terms, please contact us at support@yourapp.com. '
                              'We typically respond within 2 business days.',
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
            'Acceptance of Terms',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'By using our services, you acknowledge that you have read, understood, '
                'and agree to be bound by these Terms of Service. If you do not agree to '
                'these Terms, you may not access or use our services.',
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
        ],
      ),
    );
  }
}