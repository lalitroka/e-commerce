import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/service/provider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _userNameController =
      TextEditingController(text: 'mina Agrawal');
  final TextEditingController _ageController =
      TextEditingController(text: 23.toString());
  final TextEditingController _countryController =
      TextEditingController(text: 'Nepal');
  final TextEditingController _emailController =
      TextEditingController(text: 'cimex55@gmail.com');
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '9899999999');
  final TextEditingController _passwordController =
      TextEditingController(text: 'Pass@2222');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: unused_local_variable
      final userProvider = Provider.of<ProductProvider>(context, listen: false);
    });
  }

  final _formkey = GlobalKey<FormState>();
  String? _selectGender;
  bool isCheck = false;

  bool _obscureText = true;

  void _tooglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //
          ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                ''' Let's Create Your Account''',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _userNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'only contain alphabetic characters ';
                        }
                        if (value.split(' ').length < 2) {
                          return 'Please enter both first and last name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter your full Name',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueGrey,
                          ),
                        ),
                        focusColor: Colors.amberAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _ageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Should only contain digits';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter your age',
                        prefixIcon: Icon(Icons.cake_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueGrey,
                          ),
                        ),
                        focusColor: Colors.amberAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select your Gender',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueGrey,
                          ),
                        ),
                        focusColor: Colors.amberAccent,
                      ),
                      value: _selectGender ?? 'Male',
                      items: ['Male', 'Female', 'Other'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectGender = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _countryController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your country name ';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Country  name shoould contain only aphabet';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter your Country Name',
                        prefixIcon: Icon(Icons.public),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueGrey,
                          ),
                        ),
                        focusColor: Colors.amberAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Phone Number';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Should only contain digits';
                        } else if (!value.startsWith('97') &&
                            !value.startsWith('98')) {
                          return 'Phone number should start with 97 or 98';
                        } else if (value.length != 10) {
                          return 'digit should be only 10 number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter your Phone Number',
                        prefixIcon: Icon(Icons.call),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueGrey,
                          ),
                        ),
                        focusColor: Colors.amberAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter your email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueGrey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.amberAccent,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: _obscureText,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (!RegExp(r'^[A-Z]').hasMatch(value)) {
                          return "Should start with a capital letter";
                        } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                          return "Should contain at least one small letter";
                        } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
                          return "Should contain at least one digit";
                        } else if (!RegExp(r'^(?=.*?[!@#\$&*~])')
                            .hasMatch(value)) {
                          return "Should contain at least one special character";
                        } else if (value.length <= 8) {
                          return "password should be at least 8 character";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter your Password ',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: _tooglePasswordVisibility,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueGrey,
                          ),
                        ),
                        focusColor: Colors.amberAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: isCheck,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheck = value!;
                              });
                            }),
                        const Flexible(
                            child: Text('I accept all terms and conditions'))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate() && isCheck) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          )
                              .then((userCredential) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(userCredential.user!.uid)
                                .set({
                              'username': _userNameController.text,
                              'age': _ageController.text,
                              'country': _countryController.text,
                              'phone': _phoneNumberController.text,
                              'email': _emailController.text,
                              'gender': _selectGender ?? 'Not Specified',
                            });

                            final userProvider = Provider.of<ProductProvider>(
                                context,
                                listen: false);
                            userProvider.updateUserData(
                              username: _userNameController.text,
                              age: _ageController.text,
                              country: _countryController.text,
                              phone: _phoneNumberController.text,
                              email: _emailController.text,
                              gender: _selectGender ?? 'Not Specified',
                            );
                            Navigator.pushReplacementNamed(
                                context, '/dashboardpage');
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${error.message}')),
                            );
                          });
                        }
                      },
                      child: const Text('Create Account'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(child: Text("Already have an account?")),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/loginpage',
                            );
                          },
                          child: const Text(
                            ' LogIn ',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
