import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/components/buttons/full_button.dart';
import 'package:smart_pay/components/selectCountry.dart';
import 'package:smart_pay/helpers/size_calculator.dart';
import 'package:smart_pay/providers/user_provider.dart';

import '../../components/general_textfield.dart';
import '../../helpers/colors.dart';
import '../../helpers/regex.dart';
import '../../helpers/routes.dart';

class IDScreen extends StatefulWidget {
  const IDScreen({super.key});

  @override
  State<IDScreen> createState() => _IDScreenState();
}

class _IDScreenState extends State<IDScreen> {
  String? selectedCountryCode;
  String? selectedCountryName;
  Widget? selectedCountryImage;

  bool? isChecked = false;
  final _formKeyFullName = GlobalKey<FormState>();
  final _formKeyUserName = GlobalKey<FormState>();
  String countryValue = "";
  bool _isloading = false;

  final _formKeyEmail = GlobalKey<FormState>();

  String? _email;
  // ApiService apiService = ApiService();
  TextEditingController countryEditingController = TextEditingController();
  TextEditingController fullNameEditingController = TextEditingController();
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  bool obscurePassword = true;

  bool get areFieldsNotEmpty {
    return fullNameEditingController.text.isNotEmpty &&
        userNameEditingController.text.isNotEmpty &&
        passwordEditingController.text.length >= 6;
  }

  @override
  void dispose() {
    countryEditingController.dispose();
    fullNameEditingController.dispose();
    userNameEditingController.dispose();
    // focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
    final authProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: sizer(true, 16, context),
                  right: sizer(true, 16, context),
                  top: sizer(true, 60, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const AuthenticationHeader(),
                  Text(
                    "Hey there! tell us a bit about ",
                    style: TextStyle(
                        fontSize: sizer(true, 24, context),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary),
                  ),
                  Row(
                    children: [
                      Text(
                        "about ",
                        style: TextStyle(
                            fontSize: sizer(true, 24, context),
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary),
                      ),
                      Text(
                        "yourself",
                        style: TextStyle(
                            fontSize: sizer(true, 24, context),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff0A6375)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizer(false, 28, context),
                  ),

                  GeneralTextField(
                      key: _formKeyFullName,
                      hintText: ' Full Name',
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: fullNameFocusNode,
                      textController: fullNameEditingController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: sizer(false, 20, context),
                  ),

                  GeneralTextField(
                    key: _formKeyUserName,
                    obscureText: false,
                    hintText: 'Username',
                    focusNode: userNameFocusNode,
                    textController: userNameEditingController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: sizer(false, 20, context),
                  ),

                  TextFormField(
                    readOnly: true,
                    onTap: () {
                      _showCountryPicker(context);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Select country',
                      suffixIcon: Icon(Icons.keyboard_arrow_down),
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(
                      text: selectedCountryCode != null
                          ? '$selectedCountryCode  $selectedCountryName'
                          : '',
                    ),
                  ),
                  if (selectedCountryImage !=
                      null) // Display selected country image
                    const SizedBox(height: 10),
                  selectedCountryImage ?? const SizedBox(),

                  GeneralTextField(
                    // key: _,
                    obscureText: obscurePassword,
                    textController: passwordEditingController,
                    hintText: 'Enter password',
                    keyboardType: TextInputType.emailAddress,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: passwordVal,
                    onChanged: (val) => setState(() {
                      _email = val;
                    }),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: sizer(true, 24, context),
                        color: AppColors.text1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizer(false, 20, context),
                  ),

                  FullButton(
                    buttonFunction: () async {
                      print('print somethinf');
                      print('are all field filled: $areFieldsNotEmpty');
                      print(
                          'this is the country ${countryEditingController.text} ooorrrr naaaaa thisssss   ${selectedCountryCode}');

                      setState(() {
                        _isloading = true;
                      });

                      bool authRegistered = await authProvider.register(
                          fullNameEditingController.text,
                          userNameEditingController.text,
                          selectedCountryCode!,
                          passwordEditingController.text,
                          context);
                      print('this is the email outside: $authRegistered');
                      if (areFieldsNotEmpty && authRegistered) {
                        print('this is the email: $authRegistered');
                        setState(() {
                          _isloading = false;
                        });
                        Navigator.pushNamed(
                            context, RouteHelper.CreatePinScreenRoute);
                      } else {
                        //   // If registration fails, show a dialog
                        setState(() {
                          _isloading = false;
                        });
                      }
                    },
                    buttonText: 'Continue',
                    isloading: _isloading,
                  ),

                  SizedBox(
                    height: sizer(false, 20, context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MyDropdown(
                  onChanged: (countryCode, countryName, countryImage) {
                    setState(() {
                      selectedCountryCode = countryCode;
                      selectedCountryName = countryName;
                      selectedCountryImage = countryImage;
                    });
                    Navigator.pop(
                        context); // Close the modal when a country is selected
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
