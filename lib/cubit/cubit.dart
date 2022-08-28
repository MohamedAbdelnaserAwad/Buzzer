import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ko_buzzer/cubit/states.dart';

import '../models/social_user_model.dart';
import '../shared/network/local/cache_helper.dart';

class BuzzerCubit extends Cubit<BuzzerStates> {
  BuzzerCubit() : super(BuzzerInitialState());

  static BuzzerCubit get(context) => BlocProvider.of(context);

  List<dynamic> users = [];


  Future<void> getData() async {
    emit(BuzzerGetAllUsersLoadingState());
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('users');
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    emit(BuzzerGetAllUsersSuccessState());
    // Get data from docs and convert map to List
    users = querySnapshot.docs.map((doc) => doc.data()).toList();
    removeCurrentUser();
  }

  String getUIdImage() {
     String image = '';
    // users.forEach((map) {
    //   if (map.containsKey("uId")) {
    //     if (map["uId"] == CacheHelper.getData(key: 'uId')) {
    //       image = map["image"];
    //     }
    //   }
    // });
    image = currentUser['image'].toString();

    return image;
  }

  var currentUser;
  removeCurrentUser(){
    for(int i = 0 ;i < users.length; i++ ){
      if(CacheHelper.getData(key: 'uId') != null
          && users[i]['uId']
              == CacheHelper.getData(key: 'uId')){
        currentUser = users[i];
        //print(currentUser);
        users.remove(currentUser);
        emit(BuzzerGetUserSuccessState());
      }
    }
  }

}