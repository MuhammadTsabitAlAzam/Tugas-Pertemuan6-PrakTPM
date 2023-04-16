import 'package:flutter/material.dart';
import 'package:pertemuan6/api_data_source.dart';
import 'package:pertemuan6/users_model.dart';
import 'page_details_users.dart';


class PageListUsers extends StatelessWidget {
  const PageListUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Dari User'),
      ),
      body: _buildListUsersBody(),
    );
  }
}

Widget _buildListUsersBody(){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadUsers(),
      builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasError){
          return _buildErrorSection();
        }
        if(snapshot.hasData){
          UsersModel usersModel = UsersModel.fromJson(snapshot.data);
          return _buildSuccessSection(usersModel);
        }
        return _buildLoadingSection();
      },
    ),
  );
}

Widget _buildErrorSection(){
  return Text('Error');
}

Widget _buildLoadingSection(){
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget _buildSuccessSection(UsersModel users){
  return ListView.builder(
    itemCount: users.data!.length,
    itemBuilder: (context, index) {
      return _buildItemUsers(users.data![index], context);
    },
  );
}

Widget _buildItemUsers(Data userData, context){
  return InkWell(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageDetailUser(userId: userData.id!),
        ),
      );
    },
    child: Card(
      child: Row(
        children: [
          Container(
            width: 100,
            child: Image.network(userData.avatar!),
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userData.firstName!+ " " + userData.lastName!),
              Text(userData.email!),
            ],
          ),
        ],
      ),
    ),
  );
}

