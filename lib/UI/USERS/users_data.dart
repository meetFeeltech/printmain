import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_data_bloc/userData_bloc.dart';
import '../../commonWidget/themeHelper.dart';
import '../../model/user_data_model.dart';
import '../../network/repositary.dart';


class USER_Data_Here extends StatefulWidget {
  const USER_Data_Here({Key? key}) : super(key: key);

  @override
  State<USER_Data_Here> createState() => _USER_Data_HereState();
}

class _USER_Data_HereState extends State<USER_Data_Here> {

  UserDataPageBloc UdBloc = UserDataPageBloc(Repository.getInstance());

  List<user_data_model>? allUsermodelData;

  @override
  void initState() {
    super.initState();
    loadui1();
  }

  loadui1() async {
    UdBloc.add(AllFetchDataForUserPageEvent());
    List<user_data_model> response = await Repository.getInstance().getUser();
    // print("response $response");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Data Page"),
      ),

      body: BlocProvider<UserDataPageBloc>(
        create: (context) => UdBloc..add(UserDataInitialEvent()),
        child: BlocConsumer<UserDataPageBloc, UserDataPageState>(
          builder: (context, state) {
            if (state is UserDataPageLoadingState) {
              return ThemeHelper.buildLoadingWidget();
            } else if (state is AllFetchDataForUserDataPageState) {
              allUsermodelData = state.alluserModel;
              // print("check up ${allUsermodelData.toString()}");
              // _allCategoryDataSource =
              //     AllCategoryDataSource(allcategorymodelData!,context);

              return mainBodyData(state);
            } else {
              return ThemeHelper.buildCommonInitialWidgetScreen();
            }
          },
          listener: (context, state) {
            if (state is ApiFailureState) {
              print(state.exception.toString());
            }
          },
        ),
      ),
    );
  }


  Widget mainBodyData(AllFetchDataForUserDataPageState state){

    List<user_data_model> response = state.alluserModel;
    List<user_data_model> userList= response!;

    // print(" data ${userList[index]}");

    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: userList.length,
            itemBuilder: (ctx,index){
              return Padding(padding: EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Name : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("${userList[index].firstName} ${userList[index].lastName}",
                              style: TextStyle(
                                fontSize: 20,
                              ),),
                          ],
                        ),

                        Row(
                          children: [
                            Text("Mobile No : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text("${userList[index].mobile}",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Text("Address : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("${userList[index].address}",
                              style: TextStyle(
                                fontSize: 20,
                              ),),
                          ],
                        ),

                        Row(
                          children: [
                            Text("Email : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("${userList[index].email}",
                              style: TextStyle(
                                fontSize: 20,
                              ),),
                          ],
                        ),


                        Row(
                          children: [
                            Text("Status : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("${userList[index].status}",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }


}
