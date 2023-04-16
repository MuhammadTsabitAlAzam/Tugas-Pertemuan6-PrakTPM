import 'package:flutter/material.dart';
import 'api_data_source.dart';
import 'detail_user_model.dart';

class PageDetailUser extends StatelessWidget {
  final int userId;

  const PageDetailUser({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User'),
      ),
      body: _buildDetailUserBody(),
    );
  }

  Widget _buildDetailUserBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadDetailUser(userId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            DetailUserModel userData = DetailUserModel.fromJson(snapshot.data);
            return _buildSuccessSection(userData.data!);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text('Error');
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(Data usersData) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(usersData.avatar!),
            radius: 50,
          ),
          SizedBox(height: 20),
          Text(
            usersData.firstName! + ' ' + usersData.lastName!,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(usersData.email!, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
