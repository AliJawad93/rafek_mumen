import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _notificationsEnabled = true;
  String _language = 'English';

  void _showFeedbackSheet() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Feedback & Contact',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: messageController,
              decoration: const InputDecoration(labelText: 'Message'),
              minLines: 2,
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Send'),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Thank you for your feedback!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const SizedBox.shrink(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB2DFDB), Color(0xFFE0F2F1), Color(0xFFF1F8E9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Decorative header with user profile
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 56, bottom: 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF80CBC4),
                    Color(0xFFB2DFDB),
                    Color(0xFFE0F2F1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: theme.colorScheme.primary.withOpacity(
                      0.13,
                    ),
                    child: Icon(
                      Icons.account_circle,
                      size: 54,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Welcome, User!',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Personalize your experience',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Appearance Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                color: Colors.white.withOpacity(0.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.brightness_6,
                            color: theme.colorScheme.primary,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Appearance',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.primary.withOpacity(
                          0.13,
                        ),
                        child: Icon(
                          Icons.brightness_6,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        'Theme',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'Choose light, dark, or system theme.',
                      ),
                      trailing: DropdownButton<ThemeMode>(
                        value: _themeMode,
                        underline: const SizedBox.shrink(),
                        onChanged: (mode) {
                          if (mode != null) setState(() => _themeMode = mode);
                        },
                        items: const [
                          DropdownMenuItem(
                            value: ThemeMode.system,
                            child: Text('System'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.light,
                            child: Text('Light'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.dark,
                            child: Text('Dark'),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            // General Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                color: Colors.white.withOpacity(0.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: theme.colorScheme.primary,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'General',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      secondary: CircleAvatar(
                        backgroundColor: theme.colorScheme.primary.withOpacity(
                          0.13,
                        ),
                        child: Icon(
                          Icons.notifications_active,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        'Notifications',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'Enable or disable app notifications.',
                      ),
                      value: _notificationsEnabled,
                      onChanged: (val) =>
                          setState(() => _notificationsEnabled = val),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.primary.withOpacity(
                          0.13,
                        ),
                        child: Icon(
                          Icons.language,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        'Language',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text('Select your preferred language.'),
                      trailing: DropdownButton<String>(
                        value: _language,
                        underline: const SizedBox.shrink(),
                        onChanged: (lang) {
                          if (lang != null) setState(() => _language = lang);
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'English',
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: 'Arabic',
                            child: Text('Arabic'),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            // About Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                color: Colors.white.withOpacity(0.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: theme.colorScheme.primary,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'About',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.primary.withOpacity(
                          0.13,
                        ),
                        child: Image.asset(
                          'assets/app_logo.png',
                          width: 28,
                          height: 28,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.apps,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      title: const Text('Islamic App'),
                      subtitle: const Text(
                        'Version 1.0.0\nDeveloped with Flutter',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          icon: const Icon(
                            Icons.star_rate,
                            color: Colors.amber,
                          ),
                          label: const Text('Rate App'),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Thank you for rating!'),
                              ),
                            );
                          },
                        ),
                        TextButton.icon(
                          icon: const Icon(
                            Icons.share,
                            color: Colors.blueAccent,
                          ),
                          label: const Text('Share App'),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Share link copied!'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.primary.withOpacity(
                          0.13,
                        ),
                        child: Icon(
                          Icons.feedback,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      title: const Text('Feedback & Contact'),
                      subtitle: const Text('Let us know your thoughts!'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                      onTap: _showFeedbackSheet,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
