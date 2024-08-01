import 'package:flutter/material.dart';

class PaymentInfoPage extends StatefulWidget {
  const PaymentInfoPage({super.key});

  @override
  State<PaymentInfoPage> createState() => _PaymentInfoPageState();
}

class _PaymentInfoPageState extends State<PaymentInfoPage> {
  final TextEditingController _emailController =
      TextEditingController(text: 'cimex55@gmail.com');
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '9899999999');
  final TextEditingController _userNameController =
      TextEditingController(text: 'mina Agrawal');
  final TextEditingController _addressController =
      TextEditingController(text: 'koteshor');
  final TextEditingController _cardController =
      TextEditingController(text: '68766677875454554 ');

  final _formkeyshop = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
      final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
  final productshop = arguments['productshop'];
final pricevalue = arguments['pricevalue'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping & payment info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formkeyshop,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
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
                height: 20,
              ),
              TextFormField(
                controller: _addressController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address ';
                  }
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Country  name shoould contain only aphabet';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter your address',
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
                height: 20,
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
                height: 20,
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
                height: 20,
              ),
              TextFormField(
                controller: _cardController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Card Number';
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Should only contain digits';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter your card Number',
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
                height: 40,
              ),
              TextButton(
                  onPressed: () {
                     if (_formkeyshop.currentState!.validate()) {
                    Navigator.pushNamed(
                      context,
                      '/ordercheckoutpage',
                      arguments: {
                        'productshop': productshop,
                       'pricevalue': pricevalue,
                         'userName': _userNameController.text,
                        'address': _addressController.text,
                        'phoneNumber': _phoneNumberController.text,
                        'email': _emailController.text,
                        'cardNumber': _cardController.text,
                      },
                    );
                  }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const  Center(
                      child: Text('Procees To Checkout'),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
