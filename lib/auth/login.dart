import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '9899999999');
  final TextEditingController _passwordController =
      TextEditingController(text: 'Laly#24#4gffg');
  final _formKey = GlobalKey<FormState>();

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
                 const  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: TextFormField(
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
                          return 'Digit should be only 10 number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter your Phone Number',
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
                      decoration: const InputDecoration(
                        labelText: 'Enter your Password',
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
                  const SizedBox(height: 30),
                  Flexible(
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, '/DashBoard');
                          }
                        },
                        child: const Text('LogIn'),
                      ),
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
                                      controller: _phoneNumberController,
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
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your password',
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
