import 'package:algenie/data/models/user_model.dart';
import 'package:algenie/presentation/screens/invite_friends_screen.dart';
import 'package:algenie/presentation/screens/terms_conditions_screen.dart';
import 'package:algenie/presentation/widgets/animated_dropdown_list_widget.dart';
import 'package:algenie/presentation/widgets/container_background_image_widget.dart';
import 'package:algenie/presentation/widgets/profile_image_widget.dart';
import 'package:algenie/presentation/widgets/primary_button_widget.dart';
import 'package:algenie/presentation/widgets/textfield_widget.dart';
import 'package:algenie/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? selectedFromDropdown;
  bool _emptyName = false;
  bool _emptyNumber = false;
  bool _emptyRole = false;
  bool _emptyBio = false;
  bool loading = false;

  checkFields() {
    if (nameController.text.isEmpty) {
      setState(() {
        _emptyName = true;
      });
    } else {
      setState(() {
        _emptyName = false;
      });
    }
    if (numberController.text.isEmpty) {
      setState(() {
        _emptyNumber = true;
      });
    } else {
      setState(() {
        _emptyNumber = false;
      });
    }
    if (selectedFromDropdown == null) {
      setState(() {
        _emptyRole = true;
      });
    } else {
      setState(() {
        _emptyRole = false;
      });
    }
    if (bioController.text.isEmpty) {
      setState(() {
        _emptyBio = true;
      });
    } else {
      setState(() {
        _emptyBio = false;
      });
    }
  }

  void handleRegister(context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    setState(() => loading = true);

    try {
      await Future.delayed(const Duration(seconds: 1));
      await auth.register(User(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          role: selectedFromDropdown!.toLowerCase(),
          number: numberController.text.trim()));
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const InviteFriendsScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed")),
      );
    }

    setState(() => loading = false);
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    bioController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ContainerBackgroundImage(
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(17),
                vertical: ScreenUtil().setHeight(30)),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.keyboard_arrow_left,
                          color: Color(0xFF252B37),
                          size: ScreenUtil().setSp(25))),
                  Expanded(
                    child: Text(
                      "Become a Genie",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "Poppin-semibold",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Image.asset('assets/logoCircle.png')
                ],
              ),

              createASpacer(20),

              ProfileImagePicker(),

              createASpacer(40),

              //name textfield
              TextFieldWidget(
                hint: 'Name',
                controller: nameController,
                icon: Icons.person,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp("[0-9a-zA-Z \$ @ &-_]")),
                ],
              ),

              _emptyName ? validateEmptyField() : Container(),

              createASpacer(5),

              //text this will be used as.....

              //padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(28)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "This will be used as your profile photo & name",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Poppin-semibold",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF4B4B4B),
                    ),
                  ),
                ],
              ),

              SizedBox(height: ScreenUtil().setHeight(8)),

              //number textfield
              TextFieldWidget(
                hint: 'Number',
                controller: numberController,
                icon: Icons.call,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),

              _emptyNumber ? validateEmptyField() : Container(),

              SizedBox(height: ScreenUtil().setHeight(16)),

              //role drop down list
              AnimatedDropdown(
                onChanged: (value) {
                  setState(() {
                    selectedFromDropdown = value;
                  });
                },
              ),

              SizedBox(height: ScreenUtil().setHeight(8)),

              _emptyRole ? validateEmptyField() : Container(),

              //text Insert a Bio
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Insert a Bio",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontFamily: "Poppin-semibold",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),

              SizedBox(height: ScreenUtil().setHeight(8)),

              TextFieldWidget(
                hint: 'Please, Insert your Bio here ...',
                controller: bioController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                height: 100,
              ),

              SizedBox(height: ScreenUtil().setHeight(16)),

              _emptyBio ? validateEmptyField() : Container(),

              //TODO add city and country later

              TextFieldWidget(
                  hint: 'Email',
                  controller: emailController,
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress),

              SizedBox(height: ScreenUtil().setHeight(16)),

              TextFieldWidget(
                  hint: 'Password',
                  controller: passwordController,
                  icon: Icons.password,
                  keyboardType: TextInputType.visiblePassword),

              SizedBox(height: ScreenUtil().setHeight(16)),

              //button
              //TODO ensure that all the field is not empty including the photo
              PrimaryButtonWidget(
                  color: Color(0xFFAB2929),
                  title: 'Register',
                  isLoading: loading,
                  function: () => {
                        checkFields(),
                        if (!(_emptyName ||
                            _emptyBio ||
                            _emptyNumber ||
                            _emptyRole ||
                            selectedFromDropdown == null))
                          {handleRegister(context)}
                      }),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox createASpacer(int height) {
    return SizedBox(
      height: ScreenUtil().setHeight(height),
    );
  }

  Widget validateEmptyField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(17)),
      child: Text(
        "Please fill this field it can't be empty..",
        style: const TextStyle(
          fontFamily: "Poppin-semibold",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.red,
        ),
      ),
    );
  }
}
