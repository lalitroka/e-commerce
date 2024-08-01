import 'package:flutter/material.dart';
import 'package:myshop/service/provider.dart';
import 'package:provider/provider.dart';
class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<ProductProvider>(context, listen: false);
      userProvider.fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ProductProvider>(context);

    if (userProvider.user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: const Center(child: Text('No data here')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${userProvider.user!.username}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Age: ${userProvider.user!.age}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Country: ${userProvider.user!.country}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Phone: ${userProvider.user!.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Email: ${userProvider.user!.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Gender: ${userProvider.user!.gender}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
