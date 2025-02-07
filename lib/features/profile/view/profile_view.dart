import 'package:eagri_pro/common/components/snack_bar_custom.dart';
import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:eagri_pro/core/utils/router/routes.dart';
import 'package:eagri_pro/features/auth/bloc/login/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/function_utils.dart';
import '../../auth/domain/entities/user_entity.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late UserEntity account;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    account = context.read<AuthBloc>().state.account!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mon profil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: ColorConstants.primaryColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor:
                    ColorConstants.primaryColor.withValues(alpha: .1),
                child: Text(
                  'JD',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: ColorConstants.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Column(
              children: [
                Text(
                  '${account.user.firstName} ${account.user.lastName}',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'john.doe@example.com',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Profile Sections
          _buildSection(
            context,
            'Informations personnelles',
            [
              _buildProfileItem(
                context,
                Icons.phone_outlined,
                'Téléphone',
                formatPhoneNumber(account.user.phone),
                'phone',
              ),
              const SizedBox(height: 12),
              _buildProfileItem(
                context,
                Icons.location_on_outlined,
                'Adresse',
                account.user.address,
                'location',
              ),
              const SizedBox(height: 12),
              _buildProfileItem(
                context,
                Icons.business_outlined,
                'Entreprise',
                account.user.organism.name,
                'business',
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildSection(
            context,
            'Paramètres',
            [
              _buildSettingItem(
                context,
                Icons.notifications_outlined,
                'Notifications',
                type: 'notifications',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                context,
                Icons.lock_outline,
                'Mot de passe',
                type: 'security',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                context,
                Icons.language_outlined,
                'Langue',
                value: 'Français',
                type: 'language',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildSection(
            context,
            'Application',
            [
              _buildSettingItem(
                context,
                Icons.help_outline,
                'Aide',
                type: 'help',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                context,
                Icons.info_outline,
                'À propos',
                type: 'info',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                context,
                Icons.logout,
                'Déconnexion',
                type: 'logout',
                textColor: Colors.red,
                showArrow: false,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Déconnexion'),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      content: const Text(
                        'Êtes-vous sûr de vouloir vous déconnecter ?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: Text(
                            'Annuler',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(SendRequestLogout(
                                userName: account.user.username));
                            context.goNamed(Routes.login.name);
                            SnackBarCustom.show(
                              context: context,
                              message: 'Vous avez bien été déconnecté',
                              type: SnackBarType.success,
                            );
                            SnackBarCustom.show(
                              context: context,
                              message: 'Vous êtes déconnecté',
                              type: SnackBarType.success,
                            );
                          },
                          child: const Text(
                            'Déconnexion',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
          ),
        ),
        Column(
          children: children,
        )
      ],
    );
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'phone':
      case 'business':
        return ColorConstants.primaryColor;
      case 'location':
        return Colors.blue;
      case 'security':
        return Colors.orange;
      case 'notifications':
        return Colors.purple;
      case 'logout':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildProfileItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    String type,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getColorForType(type).withValues(alpha: .05),
        border: Border.all(
          color: _getColorForType(type).withValues(alpha: .1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getColorForType(type).withValues(alpha: .1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: _getColorForType(type),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    IconData icon,
    String label, {
    String? value,
    required String type,
    Color? textColor,
    bool showArrow = true,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _getColorForType(type).withOpacity(0.05),
          border: Border.all(
            color: _getColorForType(type).withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getColorForType(type).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: _getColorForType(type),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: textColor ?? Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            if (value != null) ...[
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(width: 8),
            ],
            if (showArrow)
              Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.grey[400],
              ),
          ],
        ),
      ),
    );
  }
}
