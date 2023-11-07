// List<NotificationModel> notificationsList = /* Your list of NotificationModel objects */;
// String desiredDescription = /* The description you want to filter by */;

// List<NotificationModel> filteredList = notificationsList
//     .where((notification) => notification.notificationDesc == desiredDescription)
//     .toList();



///////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///
// List<NotificationModel> notificationsList = /* Your list of NotificationModel objects */;
// String searchString = /* The substring you want to filter by */;

// List<NotificationModel> filteredList = notificationsList
//     .where((notification) => notification.notificationDesc.contains(searchString))
//     .toList();



   // MaterialButton(
                        //   onPressed: () async {
                        //     await providerNotificationModel.list_Data_Class(
                        //         "${StaticData.urlConnectionConst}${StaticData.notificationConst}?userName=$userName&password=$password");
                        //   },
                        //   child: Text("click"),
                        // ),