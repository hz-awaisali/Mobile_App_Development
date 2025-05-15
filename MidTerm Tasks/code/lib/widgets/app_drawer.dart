import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppTexts.appName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: AppTexts.homeTitle,
            route: AppRoutes.home,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.storage,
            title: AppTexts.storageTitle,
            route: AppRoutes.storage,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.api,
            title: AppTexts.apiTitle,
            route: AppRoutes.api,
          ),
          const Spacer(),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('App Version: 1.0.0'),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    final bool isSelected = ModalRoute.of(context)?.settings.name == route;
    
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? AppColors.primary : null,
        ),
      ),
      selected: isSelected,
      onTap: () {
        if (!isSelected) {
          Navigator.pop(context); // Close drawer
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }
}