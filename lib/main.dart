import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ko_buzzer/cubit/cubit.dart';
import 'package:ko_buzzer/cubit/states.dart';
import 'package:ko_buzzer/modules/login/buzzer_login.dart';
import 'package:ko_buzzer/shared/component/components.dart';
import 'package:ko_buzzer/shared/network/local/cache_helper.dart';

import 'layout/home.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());

  showToast(text: 'on background message', state: ToastStates.SUCCESS,);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print("token =  ${token}");


  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on message opened app');
    print(event.data.toString());
    showToast(text: 'on message opened app', state: ToastStates.SUCCESS,);
  });


  FirebaseMessaging.onMessage.listen((event) {
    print('success');
  }).onError((error) {
    print('error');
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await CacheHelper.init();
  var uId = CacheHelper.getData(key: 'uId');
  Widget widget = uId == null ? BuzzerLoginScreen() : Home() ;
  runApp( MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  MyApp({

    required this.startWidget
  });
  final Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BuzzerCubit()..getData(),
      child: BlocConsumer<BuzzerCubit,BuzzerStates>(
          listener: (context, state) {},
          builder: (context,state){
            return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Buzzer',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    appBarTheme: AppBarTheme(
                      titleSpacing: 20.0,
                      color: Colors.grey[600],
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.grey,
                        statusBarIconBrightness: Brightness.light,
                      ),

                    ),
                  ),
                  home:startWidget ,
                );
          },
      ),
    );


    //   MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Buzzer',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home:startWidget ,
    // );
  }
}


