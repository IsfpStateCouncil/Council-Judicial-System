import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../data/staticdata.dart';
import '../providerclasses.dart/controllerNotification.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 240, 162, 46), //<-- SEE HERE
      title: Text("مجلس الدولة المصري",
          style: TextStyle(
            fontFamily: StaticData.fontFamily,
          )),
      centerTitle: true,
      elevation: 0,
      actions: [
        badges.Badge(
          badgeContent: Consumer<ProviderNotificationModel>(
              builder: (context, providerNotificationModel, child) {
            return Text(
              "${providerNotificationModel.dataNotificationModel.length}",
              style: TextStyle(fontFamily: StaticData.fontFamily),
            );
          }),
          position: badges.BadgePosition.topEnd(top: 0, end: 0),
          child: IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 35,
            ),
            onPressed: () {},
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
