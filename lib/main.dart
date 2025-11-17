import 'package:algenie/presentation/screens/auth/login_screen.dart';
import 'package:algenie/presentation/screens/invite_friends_screen.dart';
import 'package:algenie/presentation/screens/splash_screen.dart';
import 'package:algenie/providers/auth_provider.dart';
import 'package:algenie/startup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final authProvider = Provider.of<AuthProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: authProvider.isLoggedIn ? StartupWidget() : SplashScreen(),
      
    );
  }
}
