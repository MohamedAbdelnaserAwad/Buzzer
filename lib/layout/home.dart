import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuzzerCubit, BuzzerStates>(
      listener: (context, state){

      },
      builder: (context, state){
        var cubit = BuzzerCubit.get(context);
        cubit.getData();
        return ConditionalBuilder(
          condition: cubit.users.length > 0,
          builder: (context) => Scaffold(
            appBar:AppBar(
              title: Text(
                '${cubit.currentUser['name'].toString().toUpperCase()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,

                ),
              ),
            ),
            body: Container(
              color: Colors.black12,
              child:Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  CircleAvatar(
                    radius: 75.0,
                    backgroundColor: Colors.black45,
                    child: CircleAvatar(
                      radius: 68.0,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        radius: 64.0,
                        child: ClipOval(
                          child: new SizedBox(
                            // width: 180.0,
                            // height: 180.0,
                            child:
                            Image.network(cubit.getUIdImage(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: (context,index){

                      return GestureDetector(
                        onTap: (){

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Card(
                            color: Colors.blueGrey[300],
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius:50.0,
                                  backgroundColor: Colors.black54,
                                  child: CircleAvatar(
                                    radius:45.0 ,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                      radius: 40.0,
                                      child: Image.network(cubit.users[index]['image']),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width : 15.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '${cubit.users[index]['name']}',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                  child: SizedBox.fromSize(
                                    size: Size(56, 56),
                                    child: ClipOval(
                                      child: Material(
                                        color: Colors.blueGrey,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.notifications_active_sharp), // <-- Icon
                                              Text("CALL"), // <-- Text
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: cubit.users.length,
                    shrinkWrap: true,

                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                    scrollDirection: Axis.vertical,
                  ),
                ],
              ),

            ),

          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
}
