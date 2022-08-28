
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ko_buzzer/modules/register/cubit/states.dart';
import '../../../models/social_user_model.dart';

class BuzzerRegisterCubit extends Cubit<BuzzerRegisterStates> {
  BuzzerRegisterCubit() : super(BuzzerRegisterInitialState());

  static BuzzerRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {

    emit(BuzzerRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        uId: value.user!.uid,
        phone: phone,
        email: email,
        name: name,

      );

      emit(BuzzerCreateUserSuccessState());
    }).catchError((error) {
      emit(BuzzerRegisterErrorState(error.toString()));
    });
  }
 String? userId;
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    BuzzerUserModel model = BuzzerUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,

    );

    userId = uId;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(BuzzerCreateUserSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(BuzzerCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(BuzzerRegisterChangePasswordVisibilityState());
  }
}