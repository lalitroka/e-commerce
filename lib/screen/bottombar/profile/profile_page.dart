import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _AccountpageState();
}

class _AccountpageState extends State<ProfilePage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  String _defaultImagePath = 'asset/jordan.jpeg';

  String _userName = 'Loading...';
  String _userEmail = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        _defaultImagePath =
            userDoc.data()?['profileImageUrl'] ?? _defaultImagePath;

        if (userDoc.exists) {
          setState(() {
            _userName = userDoc.data()?['username'] ?? 'No name';
            _userEmail = user.email ?? 'No email';
            _defaultImagePath =
                userDoc.data()?['profileImageUrl'] ?? _defaultImagePath;
          });
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> _uploadImage(File imageFile, String userEmail) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$userEmail.jpg');

      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask;
      final imageUrl = await snapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      throw Exception('Error uploading image');
    }
  }

  Future<void> _updateUserProfile(String imageUrl) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'profileImageUrl': imageUrl,
        });
      }
    } catch (e) {
      throw Exception('Error updating user profile');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });

        final imageFile = File(pickedFile.path);
        final userEmail =
            FirebaseAuth.instance.currentUser?.email ?? 'user_email';

        final imageUrl = await _uploadImage(imageFile, userEmail);
        await _updateUserProfile(imageUrl);
  
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(height: 10),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _showImagePickerOptions,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: _image != null
                      ? DecorationImage(
                          image: FileImage(File(_image!.path)),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: AssetImage(_defaultImagePath) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _userName,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              _userEmail,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
            ),
            const SizedBox(height: 20),
            const Divider(height: 10),
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
                child: const Icon(Icons.person_3_outlined),
              ),
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
            const Divider(height: 10),
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
                child: const Icon(Icons.shopping_basket_outlined),
              ),
              title: const Text(
                'Order history',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/orderhistorypage');
              },
              trailing: const Icon(Icons.fast_forward_rounded),
            ),
            const Divider(height: 10),
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
                child: const Icon(Icons.logout_sharp),
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                try {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushNamed(context, '/loginpage');
                  });
                } catch (e) {
                  throw Exception(e);
                }
              },
              trailing: const Icon(Icons.fast_forward_rounded),
            ),
            const Divider(height: 10),
          ],
        ),
      ),
    );
  }
}
