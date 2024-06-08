import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nugget_berg/state/auth/%20repositories/user_storage_repository.dart';
import 'package:nugget_berg/state/auth/models/auth_result.dart';
import 'package:nugget_berg/state/auth/models/auth_state.dart';
import 'package:nugget_berg/state/providers/scaffold_messenger.dart';
import 'package:nugget_berg/view/components/custom_snackbar.dart';
import 'dart:developer' as developer;

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
class AuthRepositoryNotifier extends _$AuthRepositoryNotifier {
  @override
  AuthState build() {
    if (_fAUth.currentUser != null &&
        _fAUth.currentUser?.emailVerified == true) {
      return AuthState(
          authResult: AuthResult.success,
          isLoading: false,
          userId: _fAUth.currentUser?.uid);
    }
    return const AuthState.unknown();
  }

  final FirebaseAuth _fAUth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final userStorage = UserStorageRepository();
  Future googleLogin() async {
    state = state.copyWithIsLoading(true);
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      await _fAUth.signInWithCredential(credential);
      // store in db
      await userStorage.storeUserToDb(ref);
      //
      state = AuthState(
          authResult: AuthResult.success,
          isLoading: false,
          userId: _fAUth.currentUser?.uid);
      developer.log(state.toString());
    } catch (e) {
      developer.log("Google login error", error: e);
    }
    state = state.copyWithIsLoading(false);
    developer.log(state.toString());
  }

  Future createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    state = state.copyWithIsLoading(true);
    try {
      await _fAUth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _fAUth.currentUser?.sendEmailVerification();
      developer.log("Email verification sent");
      // show scaffold messenger

      ref
          .read(scaffoldMessengerProvider)
          .showSnackBar(successSnackbar('Verfication email sent to $email'));

      state = state.copyWithIsLoading(false);
      //
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWithIsLoading(true);

      int timer = 6;
      while (timer > 0) {
        await Future.delayed(const Duration(seconds: 5));
        await _fAUth.currentUser?.reload();
        if (_fAUth.currentUser?.emailVerified == true) {
          await userStorage.storeUserToDb(ref);
          state = AuthState(
              authResult: AuthResult.success,
              isLoading: false,
              userId: _fAUth.currentUser?.uid);
          break;
        }
        timer--;
      }
    } on FirebaseAuthException catch (e) {
      ref.read(scaffoldMessengerProvider).showSnackBar(failureSnackbar(e.code));
    } catch (e) {
      developer.log(e.toString());
    }
    state = state.copyWithIsLoading(false);
  }

  Future emailLogin({required String email, required String password}) async {
    state = state.copyWithIsLoading(true);
    try {
      await _fAUth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

      await userStorage.storeUserToDb(ref);
      state = AuthState(
          authResult: AuthResult.success,
          isLoading: false,
          userId: _fAUth.currentUser?.uid);
    } on FirebaseAuthException catch (e) {
      ref.read(scaffoldMessengerProvider).showSnackBar(failureSnackbar(e.code));
    }
    // state = false;
    state = state.copyWithIsLoading(false);
  }

  Future<bool> forgotPassword({required String email}) async {
    state = state.copyWithIsLoading(true);
    try {
      await _fAUth.sendPasswordResetEmail(email: email);
      ref
          .read(scaffoldMessengerProvider)
          .showSnackBar(successSnackbar('Password reset email sent to $email'));

      state = state.copyWithIsLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      ref.read(scaffoldMessengerProvider).showSnackBar(failureSnackbar(e.code));

      return false;
    } catch (e) {
      ref
          .read(scaffoldMessengerProvider)
          .showSnackBar(failureSnackbar(e.toString()));

      return false;
    } finally {
      state = state.copyWithIsLoading(false);
    }
  }

  Future<void> signOut() async {
    state = state.copyWithIsLoading(true);
    try {
      _fAUth.signOut();
      _googleSignIn.signOut();
      state = const AuthState.unknown();
    } catch (e) {
      developer.log("Sign out error", error: e);
    }
    state = state.copyWithIsLoading(false);
  }
}
