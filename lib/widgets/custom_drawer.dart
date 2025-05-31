import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../constants/constants.dart';
import '../constants/texts.dart';

class DrawerMenu extends StatelessWidget {
  final void Function(Map<String, String>)? onAddNote;

  const DrawerMenu({super.key, this.onAddNote});

  void _navigate(BuildContext context, String route) {
    Navigator.pop(context); // Drawer'ı kapat

    if (route == '/diary') {
      Navigator.pushNamed(context, route).then((newNote) {
        if (newNote != null && newNote is Map<String, String>) {
          onAddNote?.call(newNote);
        }
      });
    } else {
      if (ModalRoute.of(context)?.settings.name != route) {
        Navigator.pushReplacementNamed(context, route);
      }
    }
  }

  Future<void> _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppTexts.logout),
          content: Text(AppTexts.logoutConfirm),
          actions: [
            TextButton(
              child: Text(AppTexts.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(AppTexts.yes),
              onPressed: () async {
                Navigator.of(context).pop();

                try {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();

                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppTexts.logoutSuccess)),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${AppTexts.logoutError}$e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppConstants.primaryColor,
            ),
            accountName: Text(user?.displayName ?? AppTexts.noPhoto),
            accountEmail: Text(user?.email ?? AppTexts.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : const AssetImage(AppConstants.defaultAvatarPath) as ImageProvider,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.looks_one),
            title: Text(AppTexts.home),
            onTap: () => _navigate(context, AppConstants.homeRoute),
          ),
          ListTile(
            leading: const Icon(Icons.looks_two),
            title: Text(AppTexts.addDiary),
            onTap: () => _navigate(context, AppConstants.diaryRoute),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(AppTexts.profile),
            onTap: () => _navigate(context, AppConstants.profileRoute),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppTexts.settings),
            onTap: () => _navigate(context, AppConstants.settingsRoute),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(AppTexts.logout),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
