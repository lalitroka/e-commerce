import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _AccountpageState();
}

class _AccountpageState extends State<ProfilePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My profile',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('asset/jordan.jpeg'),
                      fit: BoxFit.cover)),
            ),
            const Text(
              'Harsadh mehta',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Text(
              'harsadhmehta21@gmail.com',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 10,
            ),
            ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.cyan,
                    ),
                  ),
                  child: const Icon(Icons.person_3_outlined)),
              title: const Text(
                'Personal info',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/personalinfopage');
              },
              trailing: const Icon(Icons.fast_forward_rounded),
            ),
            const Divider(
              height: 10,
            ),
            ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.cyan,
                    ),
                  ),
                  child: const Icon(Icons.shopping_basket_outlined)),
              title: const Text(
                'Order history',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/personalinfopage');
              },
              trailing: const Icon(Icons.fast_forward_rounded),
            ),
            const Divider(height: 10,),
              ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.cyan,
                    ),
                  ),
                  child: const Icon(Icons.shopping_basket_outlined)),
              title: const Text(
                'Sell your product',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              trailing: const Icon(Icons.fast_forward_rounded),
            ),
            const Divider(
              height: 10,
            ),
            ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.cyan,
                    ),
                  ),
                  child: const Icon(Icons.wallet_giftcard_outlined)),
              title: const Text(
                'My promocodes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/personalinfopage');
              },
              trailing: const Icon(Icons.fast_forward_rounded),
            ),
            const Divider(
              height: 10,
            ),
            ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.cyan,
                    ),
                  ),
                  child: const Icon(Icons.phone_android_sharp)),
              title: const Text(
                'Verify phone number',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/personalinfopage');
              },
              trailing: const Icon(Icons.fast_forward_rounded),
            ),
            const Divider(
              height: 10,
            ),
            ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.cyan,
                    ),
                  ),
                  child: const Icon(Icons.mail_rounded)),
              title: const Text(
                'Veryfy email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/personalinfopage');
              },
              trailing: const Icon(Icons.fast_forward_rounded),
            ),
            const Divider(
              height: 10,
            ),
            ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.cyan,
                    ),
                  ),
                  child: const Icon(Icons.logout_sharp)),
              title: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/personalinfopage');
              },
              trailing: const Icon(Icons.fast_forward_rounded),
            ),
            const Divider(
              height: 10,
            ),
            ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.cyan,
                    ),
                  ),
                  child: const Icon(Icons.delete)),
              title: const Text(
                'Delete account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/personalinfopage');
              },
              trailing: const Icon(Icons.fast_forward_rounded),
            ),
            const Divider(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
