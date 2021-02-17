import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:webfix_task/Authentication.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 100,
          padding: EdgeInsets.only(left: 15,right: 15),
          child: Column(
            children: [
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                shape: StadiumBorder(),
                child: Text("Edit Profile"),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: (){},
              ),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                shape: StadiumBorder(),
                child: Text("Logout"),
                textColor: Colors.white,
                color: Colors.deepOrange,
                onPressed: context.read<AuthenticationProvider>().signOut
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<Map<String,dynamic>>(
              future: context.read<AuthenticationProvider>().userData, // async work
              builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting: return Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height/2,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  // borderRadius: BorderRadius.only(
                                  //   bottomRight: Radius.circular(50),
                                  //   bottomLeft: Radius.circular(50)
                                  // )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProfileAvatar(
                                      '${snapshot.data["picture"]["data"]["url"]}',
                                      radius: 120,
                                      elevation: 1.0,
                                      foregroundColor: Colors.black.withOpacity(0.1),
                                      cacheImage: true,
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.logout),
                                    color: Colors.white,
                                    onPressed: () {
                                      context.read<AuthenticationProvider>().signOut();
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                         Container(
                           padding: EdgeInsets.all(20),
                           child: Column(
                             children: [
                               ListTile(
                                leading: Icon(Icons.person),
                                 trailing: Text('${snapshot.data["name"]}',
                                         style: TextStyle(
                                         fontSize: 12,
                                         fontWeight: FontWeight.w500
                                          ),),
                                 title: Text('Name',
                                   style: TextStyle(
                                       fontSize: 12,
                                     color: Colors.grey,
                                       fontWeight: FontWeight.w500
                                   ),),
                               ),
                               Divider(),
                               ListTile(
                                 leading: Icon(Icons.mail),
                                 trailing: Text('${snapshot.data["email"]}',
                                   style: TextStyle(
                                     fontSize: 14,
                                       fontWeight: FontWeight.w500
                                   ),),
                                 title: Text('Email',
                                   style: TextStyle(
                                       fontSize: 12,
                                       color: Colors.grey,
                                       fontWeight: FontWeight.w500
                                   ),),
                               ),
                             ],
                           ),
                         ),
                          
                        ],
                      );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}




