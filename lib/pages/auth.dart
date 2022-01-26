import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vaccination/pages/search.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/search': (context) => Search(),
    '/results': (context) => Result(),
  },
));

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(child: Text('Sign In'),
            onPressed: () async{
              await _googleSignIn.signIn();

              setState(() {});
            }),
            ElevatedButton(child: Text('Sign Out'),
                onPressed: () async{
                  await _googleSignIn.signOut();
                  setState(() {});
                }),
          ]
        )
      )
    );
  }
}
