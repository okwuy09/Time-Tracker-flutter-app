import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_flutter_course/Home/job_entries/Home_page.dart';
import 'package:time_flutter_course/services/auth.dart';
import 'package:time_flutter_course/services/database.dart';
import 'package:time_flutter_course/sign_in/sign_in_Page.dart';

import '../jobs/jobs_page.dart';


class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User> (
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active){
          final user = snapshot.data;
          if (user ==null ) {
            return SignInPage.create(context);
          }
          return Provider<Database>(
            create: (_) => FirestoreDatabase(uid: user.uid),
              child: HomePage());
        }
        return Scaffold(
          body: Center (
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
