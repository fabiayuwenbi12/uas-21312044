import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_get/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void signup (String emailAddress, String password) async {
    try {
  UserCredential myUser = await auth.createUserWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  await myUser.user!.sendEmailVerification();
  Get.defaultDialog(
    title: "Verifikasi Email",
    middleText: "Kami telah mengirimkan verifikasi ke email $emailAddress.",
    onConfirm: () {
      Get.back();//Close dialog
      Get.back();//Login
    },
    textConfirm: "Ok");
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
  }

  void login (String emailAddress, String password) async {
    try {
  UserCredential myUser = await auth.signInWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  if (myUser.user!.emailVerified){
    //untuk routing
    Get.offAllNamed(Routes.HOME);
  } else {
    Get.defaultDialog(
      title: "Verifikasi email",
      middleText: "Harap verifikasi email terlebih dahulu",
    );
  }
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
  }

  void logout () async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void resetPassword (String email) async {
    if(email != "" && GetUtils.isEmail(email)) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Get.defaultDialog(
        title: "Berhasil",
        middleText: "Kami telah mengirimkan reset password ke $email",
        onConfirm: () {
          Get.back();
          Get.back();
        },
        textConfirm: "Ok",
        );
      } catch (e) {
        Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "Tidak dapat melakukan reset password"
      );
      }
    } else {
      Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "Email tidak valid"
      );
    }
  }
}
