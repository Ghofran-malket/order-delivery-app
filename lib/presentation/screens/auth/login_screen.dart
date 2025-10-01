import 'package:algenie/presentation/screens/auth/register_screen.dart';
import 'package:algenie/presentation/screens/invite_friends_screen.dart';
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
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final sizeAware = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: ListView(
          children: [
            Stack(
              children: [
                //Screen background
                Container(
                  height: sizeAware.height,
                  width: sizeAware.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),

                //logo
                Positioned(
                  top: 0,
                  bottom: sizeAware.height * 0.5,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: SizedBox(
                      height: sizeAware.height * 0.3,
                      child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Image.asset('assets/algenie_logo.png')),
                    ),
                  ),
                ),

                //Container of textfields email and password
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(17)),
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
                            style: const TextStyle(
                              fontFamily: "Poppin-semibold",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
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
                            
                        loading ? CircularProgressIndicator() : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(10)),
                          child: Container(
                            width: sizeAware.width,
                            height: ScreenUtil().setHeight(40),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(7),
                              ),
                            ),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateColor.fromMap({
                                  WidgetState.any: Colors.indigo,
                                })
                                    //color: Config.secondaryColor,

                                    ),
                                onPressed: () { handleLogin(context);},
                                child: Text(
                                  'Sign In',
                                  style: const TextStyle(
                                    fontFamily: "Poppin-semibold",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),

                        Center(
                            child: Text(
                          "Don't Have an Account?",
                          style: TextStyle(
                              fontFamily: "Poppin-semibold",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey //HexColor('#999999'),
                              ),
                        )),


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
                              style: TextStyle(
                                fontFamily: "Poppin-semibold",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.red, //('#AB2929'),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: ScreenUtil().setHeight(10)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
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
        style: const TextStyle(
          fontFamily: "Poppins-Medium",
          fontSize: 15,
          // color: HexColor("#252B37"),
        ),
      )),
    );
  }
}
