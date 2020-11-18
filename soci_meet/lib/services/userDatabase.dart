import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socimeet/models/user.dart';



class UserDatabaseService {
  final String uid;

  UserDatabaseService(
      { this.uid, String first_name, String last_name, String gender, String email});

//collection  reference
  final CollectionReference userCollection = Firestore.instance.collection(
      'users');

  Future updateUserData(String emailAddress, String first_name,
      String last_name, String gender,
      Map<String, String> userEventsIdList) async
  {
    return await userCollection.document(uid).setData({
      'emailAddress': emailAddress,
      'first_name': first_name,
      'last_name': last_name,
      'gender': gender,
      'userEventsIdList': userEventsIdList,
    });
  }
  Future updateUserEvents(User user) async { //update the events of specific user in firebase
    try {
      print("now update..."+user.userEventsIdList.toString());
      return await userCollection.document(user.uid).updateData({
        'userEventsIdList': user.userEventsIdList,
      });
    }
    catch (e) {
      print("the userEventIdList is not updated"+e);
    }
  }

}

