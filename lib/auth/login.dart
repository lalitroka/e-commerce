import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/service/provider.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController =
      TextEditingController(text: 'cimex12@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'Pass@1212');
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  void _tooglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Center(child: Text('Login Page')),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 699) {
            return Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(
                    width: 100,
                    height: 100,
                    child: Image(image: AssetImage('asset/loginpage.png')),
                  ),
                  Text(
                    'place the order',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[300]),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Text(
                      'receive within 24 hour inside the kathmandu valley',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: TextFormField(
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
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Enter your email ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueGrey,
                          ),
                        ),
                        focusColor: Colors.amberAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
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
                          return "Password should be at least 8 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: _tooglePasswordVisibility,
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            )),
                        labelText: 'Enter your Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blueGrey,
                          ),
                        ),
                        focusColor: Colors.amberAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                  
                            // Fetch user data from Firestore
                            DocumentSnapshot documentSnapshot =
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userCredential.user!.uid)
                                    .get();
                  
                            if (documentSnapshot.exists) {
                              final userData = documentSnapshot.data()
                                  as Map<String, dynamic>;
                  
                              // Update the provider with the fetched user data
                              final userProvider =
                                  // ignore: use_build_context_synchronously
                                  Provider.of<ProductProvider>(context,
                                      listen: false);
                              userProvider.updateUserData(
                                username: userData['username'],
                                age: userData['age'],
                                country: userData['country'],
                                phone: userData['phone'],
                                email: userData['email'],
                                gender: userData['gender'],
                              );
                                  Navigator.pushReplacementNamed(
                                  // ignore: use_build_context_synchronously
                                  context, '/dashboardpage');
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("User data not found")),
                              );
                            }
                       
                  
                          } on FirebaseAuthException catch (e) {
                            String errorMessage = 'An error occurred';
                            if (e.code == 'user-not-found') {
                              errorMessage = "No user found with that email";
                            } else if (e.code == 'wrong-password') {
                              errorMessage = 'Incorrect password';
                            } else if (e.code == 'invalid-email') {
                              errorMessage = "Incorrect email format";
                            }
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)),
                            );
                          }
                        }
                      },
                      child: const Text('LogIn'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Text(
                            "Don't have an account?",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/registerpage');
                          },
                          child: const Flexible(
                            child: Text(
                              ' Register ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          //
          //
          //
          //
          //
          //
          //

          else if (constraints.maxWidth > 700) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Column(
                      children: [
                        SizedBox(
                          width: 300,
                          height: 400,
                          child:
                              Image(image: AssetImage('asset/loginpage.png')),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            'place the order',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[300]),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              'receive within 24 hour inside the kathmandu valley',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Form(
                              key: _formKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 70),
                                    child: TextFormField(
                                      controller: _emailController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter your phone number';
                                        } else if (!RegExp(r'^[0-9]+$')
                                            .hasMatch(value)) {
                                          return 'Contain only digit';
                                        } else if (!value.startsWith('98') &&
                                            !value.startsWith('97')) {
                                          return 'Phone number should start with 97 or 98';
                                        } else if (value.length != 10) {
                                          return 'Phone number should be ten digits only';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email_rounded),
                                        hintText: 'Enter your user id / email',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        focusColor: Colors.amberAccent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 70),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please fill your password';
                                        } else if (!RegExp(r'^[A-Z]')
                                            .hasMatch(value)) {
                                          return "Should start with a capital letter";
                                        } else if (!RegExp(r'[a-z]')
                                            .hasMatch(value)) {
                                          return "Should contain at least one small letter";
                                        } else if (!RegExp(r'^(?=.*?[0-9])')
                                            .hasMatch(value)) {
                                          return "Should contain at least one digit";
                                        } else if (!RegExp(
                                                r'^(?=.*?[!@#\$&*~])')
                                            .hasMatch(value)) {
                                          return "Should contain at least one special character";
                                        } else if (value.length <= 8) {
                                          return "Password should be at least 8 characters";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
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
                                        hintText: 'Enter your password',
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        focusColor: Colors.amberAccent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.pushNamed(
                                              context, '/DashBoard');
                                        }
                                      },
                                      child: const Text('LogIn'),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Don't have an account?"),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/registerpage');
                                        },
                                        child: const Text(
                                          ' Register ',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Text('null');
        },
      ),
    );
  }
}
