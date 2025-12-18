import 'package:algenie/presentation/screens/auth/register_screen.dart';
import 'package:algenie/presentation/screens/invite_friends_screen.dart';
import 'package:algenie/presentation/widgets/container_background_image_widget.dart';
import 'package:algenie/presentation/widgets/primary_button_widget.dart';
import 'package:algenie/presentation/widgets/textfield_widget.dart';
import 'package:algenie/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void handleLogin(context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    setState(() => loading = true);
    try {
      await auth.login(emailController.text, passwordController.text);
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const InviteFriendsScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login failed")));
      print("failed");
    }
    setState(() => loading = false);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ContainerBackgroundImage(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SizedBox(
                    height: sizeAware.height * 0.3,
                    child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Image.asset('assets/algenie_logo.png')),
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(17)),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.31),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.12),
                      offset: Offset(
                        0.0,
                        ScreenUtil().setWidth(1.0),
                      ), //(x,y)
                      blurRadius: ScreenUtil().setWidth(6.0),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenUtil().setWidth(11)),
                      topRight: Radius.circular(ScreenUtil().setWidth(11))),
                ),
                height: sizeAware.height * 0.45,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: ScreenUtil().setHeight(10),
                          top: ScreenUtil().setHeight(5)),
                      child: SizedBox(
                        height: ScreenUtil().setHeight(2.0),
                        width: ScreenUtil().setWidth(43),
                        child: DecoratedBox(
                          decoration:
                              BoxDecoration(color: Colors.blue //("#C4C4C4")
                                  ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(15)),
                      child: Text(
                        "Welcome back, Glad to see you again",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),

                    //email text field
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(5)),
                        child: TextFieldWidget(
                          hint: 'Email',
                          controller: emailController,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress
                        )),

                    // password text field
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(5)),
                        child: TextFieldWidget(
                          hint: 'Password',
                          controller: passwordController,
                          icon: Icons.password,
                        )),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(10)),
                      child: PrimaryButtonWidget(
                          color: Color(0xFFAB2929),
                          title: 'Sign in',
                          isLoading: loading,
                          function: () => {handleLogin(context)}
                      ),
                    ),
                    Center(
                        child: Text(
                      "Don't Have an Account?",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
                    )),
                    
                    SizedBox(height: ScreenUtil().setHeight(10)),

                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Register Now",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Color(0xFFAB2929)),
                        ),
                      ),
                    ),

                    SizedBox(height: ScreenUtil().setHeight(10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget accountDoesNotExist() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(
        "Account doesn't Exist please Register",
        style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Color(0xFFAB2929))
      )),
    );
  }
}
