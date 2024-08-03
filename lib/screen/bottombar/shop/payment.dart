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
      TextEditingController(text: '68766677875454554');

  final _formKey = GlobalKey<FormState>();
  String _selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    final productshop = arguments['productshop'];
    final pricevalue = arguments['pricevalue'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping & Payment Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // User Details
              buildTextField(
                controller: _userNameController,
                label: 'Enter your full Name',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Only contain alphabetic characters';
                  }
                  if (value.split(' ').length < 2) {
                    return 'Please enter both first and last name';
                  }
                  return null;
                },
              ),
              buildTextField(
                controller: _addressController,
                label: 'Enter your address',
                icon: Icons.public,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Address should contain only alphabetic characters';
                  }
                  return null;
                },
              ),
              buildTextField(
                controller: _phoneNumberController,
                label: 'Enter your Phone Number',
                icon: Icons.call,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phone Number';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Should only contain digits';
                  } else if (!value.startsWith('97') &&
                      !value.startsWith('98')) {
                    return 'Phone number should start with 97 or 98';
                  } else if (value.length == 10) {
                    return 'Phone number should be 10 digits';
                  }
                  return null;
                },
              ),
              buildTextField(
                controller: _emailController,
                label: 'Enter your email',
                icon: Icons.email_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              buildTextField(
                controller: _cardController,
                label: 'Enter your Card Number',
                icon: Icons.credit_card,
                validator: (value) {
                  if (_selectedPaymentMethod == 'card') {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Card Number';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Should only contain digits';
                    } else if (value.length == 16) {
                      return 'Card number should be 16 digits';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Payment Method Selection
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Card'),
                      leading: Radio<String>(
                        value: 'card',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('eSewa'),
                      leading: Radio<String>(
                        value: 'esewa',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_selectedPaymentMethod.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a payment method')),
                      );
                      return;
                    }
                    
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
                        'cardNumber': _selectedPaymentMethod == 'card'
                            ? _cardController.text
                            : '', // Only include card number if method is card
                        'paymentMethod': _selectedPaymentMethod,
                      },
                    );
                  }
                },
                child: const Text('Proceed To Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
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
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 2,
              color: Colors.amberAccent,
            ),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
