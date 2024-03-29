
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_flutter_course/Home/job_entries/job_entries_page.dart';
import 'package:time_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_flutter_course/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_flutter_course/jobs/edit_job_page.dart';
import 'package:time_flutter_course/jobs/job.dart';
import 'package:time_flutter_course/jobs/job_list_tile.dart';
import 'package:time_flutter_course/jobs/list_item_builder.dart';
import 'package:time_flutter_course/services/auth.dart';
import 'package:time_flutter_course/services/database.dart';

class JobsPage extends StatelessWidget {

 Future<void> _delete(BuildContext context, Job job) async {
   try {
     final database = Provider.of<Database>(context, listen: false);
     await database.deleteJob(job);
   } on FirebaseException catch (e) {
     showExceptionAlertDialog(
         context,
         title: 'Operation failed',
         exception: e,
     );
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => EditJobPage.show(
                context,
                database: Provider.of<Database>(context, listen: false)
            ),
          ),
        ],
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
   final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobListTile(
              job: job,
              onTap: () => JobEntriesPage.show(context, job),
            ),
          ),
        );
      },
    );
  }
}



