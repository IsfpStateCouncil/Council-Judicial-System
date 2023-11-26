import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../data/staticdata.dart';
import '../page/NotificationList.dart';
import '../providerclasses.dart/controllerNotification.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    super.key,
    this.languageProvider,
  });
  final languageProvider;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: StaticData.appBarColor, //<-- SEE HERE
      title: Text(
        "${languageProvider.getCurrentData('EgyptianStateCouncil')}",
        style: TextStyle(
          fontFamily: StaticData.fontFamily,
          // Add other text styles as needed
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        badges.Badge(
          badgeContent: Consumer<ProviderNotificationModel>(
              builder: (context, providerNotificationModel, child) {
            return Text(
              "${providerNotificationModel.dataNotificationModel.length}",
              style: TextStyle(color: Colors.white),
            );
          }),
          position: badges.BadgePosition.topEnd(top: 5, end: 5),
          child: IconButton(
            icon: Icon(
              Icons.notifications,
              color: StaticData.button,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationPage( notificationType: '',)),
              );
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage(notificationType: '',)),
            );
          },
        ),
      ],
    );
  }
}
