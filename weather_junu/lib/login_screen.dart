import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'weather_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}
class LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isSigningIn = false;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isSigningIn = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() {
          _isSigningIn = false;
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (!mounted) return;

      if (userCredential.user != null) {
        Navigator.of(context).pushReplacementNamed('/weather');
      }
    } catch (e) {
      if (!mounted) return;  // Check if the widget is still in the tree.

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('구글 로그인에 실패했습니다. 나중에 다시 시도해 주세요.'),
        ),
      );
    }finally {
      if (mounted) {
        setState(() {
          _isSigningIn = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: _isSigningIn
            ? const CircularProgressIndicator()
            : ElevatedButton(
          onPressed: _signInWithGoogle,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(300, 50),
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xffd3d3d3)),
            shadowColor: Colors.transparent,
          ),
          child: const Text("구글로 시작하기",
            style: TextStyle(color: Colors.black,fontSize: 15),
          ),
        ),
      ),
    );
  }
}