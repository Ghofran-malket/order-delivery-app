import 'package:algenie/data/models/order_model.dart';
import 'package:algenie/presentation/screens/genie_screens/order_notification_screen.dart';
import 'package:algenie/presentation/screens/splash_screen.dart';
import 'package:algenie/providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background message: ${message.data}");
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authProvider = AuthProvider();
  await authProvider.loadToken();
  await authProvider.loadUserFromStorage();

  runApp(
    ChangeNotifierProvider(
      create: (_) => authProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message: ${message.notification?.title}");
      showModalBottomSheet(
          context: navigatorKey.currentContext!,
          isScrollControlled: true, // important
          backgroundColor: Colors.transparent,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.75,
              child: OrderNotificationScreen(
                order: Order.fromFirebaseNotification(message.data),
              ),
            );
          });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Opened from notification");
      showModalBottomSheet(
        context: navigatorKey.currentContext!,
        isScrollControlled: true, // important
        backgroundColor: Colors.transparent,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.75,
            child: OrderNotificationScreen(
              order: Order.fromFirebaseNotification(message.data),
            ),
          );
        });
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final authProvider = Provider.of<AuthProvider>(context);
    print("authProvider.isLoggedIn.toString()" +
        authProvider.isLoggedIn.toString());
    return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Poppins',
            textTheme: const TextTheme(
              headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          home:  SplashScreen(),
        
      );
  }
}
