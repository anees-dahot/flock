import 'package:flock/features/add%20posts/repository/add_post_repository.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'uploadPost':
        final repository = AddPostRepository();
        final flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();

        // Initialize notifications
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const InitializationSettings initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);
        await flutterLocalNotificationsPlugin
            .initialize(initializationSettings);

        // Show initial notification
        await _showProgressNotification(flutterLocalNotificationsPlugin, 0);

        try {
          final response = await repository.addPost(
            postText: inputData!['postText'],
            postVideos: List<String>.from(inputData['postVideos']),
          );

          if (response['status'] == 200) {
            await _showSuccessNotification(
                flutterLocalNotificationsPlugin, response['message']);
          } else {
            await _showErrorNotification(
                flutterLocalNotificationsPlugin, response['message']);
          }
        } catch (e) {
          await _showErrorNotification(
              flutterLocalNotificationsPlugin, e.toString());
        }
        break;
    }
    return Future.value(true);
  });
}

Future<void> _showProgressNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    int progress) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'upload_channel',
    'Upload Notifications',
    channelDescription: 'Notifications for post uploads',
    importance: Importance.max,
    priority: Priority.high,
    onlyAlertOnce: true,
    showProgress: true,
    maxProgress: 100,
    progress: 0,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Uploading Post',
    'Upload in progress',
    platformChannelSpecifics,
  );
}

Future<void> _showSuccessNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'upload_channel',
    'Upload Notifications',
    channelDescription: 'Notifications for post uploads',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Upload Complete',
    message,
    platformChannelSpecifics,
  );
}

Future<void> _showErrorNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String error) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'upload_channel',
    'Upload Notifications',
    channelDescription: 'Notifications for post uploads',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Upload Failed',
    error,
    platformChannelSpecifics,
  );
}
