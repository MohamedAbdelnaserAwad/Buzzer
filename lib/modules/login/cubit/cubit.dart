import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ko_buzzer/modules/login/cubit/states.dart';




class BuzzerLoginCubit extends Cubit<BuzzerLoginStates> {
  BuzzerLoginCubit() : super(BuzzerLoginInitialState());

  static BuzzerLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(BuzzerLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      emit(BuzzerLoginSuccessState(value.user!.uid));
    })
        .catchError((error)
    {
      emit(BuzzerLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(BuzzerLoginChangePasswordVisibilityState());
  }
}