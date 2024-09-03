import 'package:flock/features/add%20posts/repository/add_post_repository.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart, // onStart is the callback to run when service starts
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: null,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Setup service configuration
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // Your background task logic
  service.on('uploadPost').listen((inputData) async {
    final repository = AddPostRepository();
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Initialize notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Show initial notification
    await _showProgressNotification(flutterLocalNotificationsPlugin, 0);

    try {
      final response = await repository.addPost(
        postText: inputData!['postText'],
        postVideos:[],
        onProgress: (progress) async {
         await _showProgressNotification(
            flutterLocalNotificationsPlugin, (progress * 100).toInt());
        },
      );

      if (response['status'] == 200) {
        await _showSuccessNotification(
            flutterLocalNotificationsPlugin, response['message']);
        print('ran');    
      } else {
        await _showErrorNotification(
            flutterLocalNotificationsPlugin, response['message']);
        print(response['message']);
        // print(response['status']);
      }
    } catch (e) {
      await _showErrorNotification(
          flutterLocalNotificationsPlugin, e.toString());
      print(e.toString());
    }
  });
}

Future<void> _showProgressNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    int progress) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'upload_channel',
    'Upload Notifications',
    channelDescription: 'Notifications for post uploads',
    importance: Importance.max,
    priority: Priority.high,
    onlyAlertOnce: true,
    showProgress: true,
    maxProgress: 100,
    progress: progress,
  );
  NotificationDetails platformChannelSpecifics =
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
