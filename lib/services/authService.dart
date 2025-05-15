import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future<UserCredential> signInWithGoogle() async {
  //   print("object");
  //   // Trigger Google Sign-In flow
  //   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //   print("object121");
  //   if (googleUser == null) {
  //     throw Exception('Sign-In aborted by user');
  //   }
  //   print("objectwd");
  //   // Obtain the auth details
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;
  //   print("object154");
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   print("object1564");
  //   print(credential);
  //   // Sign in to Firebase with the credential
  //   return await _auth.signInWithCredential(credential);
  // }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the Google Sign-In flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print(credential);

    var ab = await FirebaseAuth.instance.signInWithCredential(credential);
    print(ab);

    // Sign in to Firebase with the Google credential
    return ab;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
