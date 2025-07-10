import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vendor/pages/orders/mobile/mobile_order_page.dart';
import 'package:vendor/pages/splash/splash_screen.dart';
import 'package:vendor/utils/preference_utils.dart';
import 'package:vendor/utils/validation_utils.dart';

import 'constants/app_colors.dart';
import 'constants/app_style.dart';
import 'firebase/firebase_options.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'language/app_localizations.dart';
import 'model/firebase/firebase_order_response.dart';
import 'navigation/navigation_service.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("receive message");
  await Firebase.initializeApp(
    name: "4-square",
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCD307r1TTsBbvJ_9ibBwUp4254v5ySHPc',
      appId: '1:211166356684:android:67e26b0330c439e2968e69',
      messagingSenderId: '211166356684',
      projectId: 'square-new-d8e68',
      storageBucket: 'square-new-d8e68.appspot.com',
    ),
  );
  var firebaseOrderResponse = FirebaseOrderResponse();
  firebaseOrderResponse.type = message.data['type'];
  firebaseOrderResponse.message = message.data['message'];
  print(firebaseOrderResponse.toJson());
  if(firebaseOrderResponse.type == "on_notification"){
    showMessageNotification(firebaseOrderResponse);
  }else if(firebaseOrderResponse.type =="on_track"){
    playSound();
    showNotification();
  }else {
    showMessageNotification(firebaseOrderResponse);
  }
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isAndroid) {
    await Firebase.initializeApp(
      name: "4-square",
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCD307r1TTsBbvJ_9ibBwUp4254v5ySHPc',
        appId: '1:211166356684:android:67e26b0330c439e2968e69',
        messagingSenderId: '211166356684',
        projectId: 'square-new-d8e68',
        storageBucket: 'square-new-d8e68.appspot.com',
      ),
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   FirebaseOrderResponse firebaseOrderResponse = FirebaseOrderResponse();
    //   firebaseOrderResponse.type = message.data['type'];
    //   firebaseOrderResponse.orderid = message.data['orderid'];
    //   firebaseOrderResponse.message = message.data['message'];
    //   if(firebaseOrderResponse.type == "order_message" ) {
    //     showSimpleNotification(
    //       Text("New Order Note Message\n#${firebaseOrderResponse.orderid} \n${firebaseOrderResponse.message}"),
    //       leading: Icon(Icons.add_alert, color: Colors.white),
    //       background: Colors.green,
    //       duration: Duration(seconds: 3),
    //     );
    //   }
    // });
    _requestPermissions();
  }
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(const MyApp());
  ValidationUtils.disabledPages.add(MobileOrderPage);
  PreferenceUtils.saveCurrentPage('Home');
}

Future<void> _requestPermissions() async {
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> showMessageNotification(FirebaseOrderResponse firebaseOrderResponse) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channelId1',
    'channelName1',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher', // Ensure a valid icon is set
  );

  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    10,
    '4Square',
    firebaseOrderResponse.message,
    notificationDetails,
    payload: 'notification_payload',
  );
}

Future<void> showNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channelId',
    'channelName',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher', // Ensure a valid icon is set
  );

  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    10,
    'New food order found',
    'Tap to open the app',
    notificationDetails,
    payload: 'notification_payload',
  );
}



final AudioPlayer _audioPlayer = AudioPlayer();
bool isPlaying = false;

playSound() async {
  await _audioPlayer.play(AssetSource("sound/alert.mp3"));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp>  {

  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  void setThemeMode(ThemeMode mode) => setState(() {
    _themeMode = mode;
    FlutterFlowTheme.saveThemeMode(mode);
  });


  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: GlobalLoaderOverlay(
        overlayColor: Colors.grey.withOpacity(0.5),
        useDefaultLoading: false,
        overlayWidgetBuilder: (_) { //ignored progress for the moment
          return Center(
            child: SpinKitThreeBounce(
              color: AppColors.themeColor,
              size: 50.0,
            ),
          );
        },
        child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey, // set property
          locale: Locale('en'), // Default locale
          supportedLocales: [
            Locale('en', ''),
            Locale('es', ''),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData(brightness: Brightness.light),
          themeMode: ThemeMode.light,
          title: 'Thee4square',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.themeColor),
              useMaterial3: true,
              fontFamily: AppStyle.robotoRegular
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }

}