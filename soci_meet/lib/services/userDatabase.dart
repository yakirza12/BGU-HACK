import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socimeet/models/user.dart';



class UserDatabaseService{
  final String uid;
  UserDatabaseService({ this.uid, String first_name,String last_name, String gender, String email});

//collection  reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String emailAddress ,String first_name ,String last_name, String gender, Map<String,String> userEventsIdList) async
  {
    print("THIS IS USERCOLLECTION:  "+userCollection.document(uid).get().toString());
    return await userCollection.document(uid).setData({
      'emailAddress': emailAddress,
      'first_name' : first_name,
      'last_name' : last_name,
      'gender' : gender,
      'userEventsIdList' : userEventsIdList,
    });
  }

  Future addGuestData(String index ,String proximityGroup ,String last_name ,String first_name,int quantity_invited) async {
    return await userCollection.document(uid).collection('guests').document(index).
    setData({
      'proximityGroup': proximityGroup,
      'last_name' : last_name,
      'first_name' : first_name,
      'quantity_invited' : quantity_invited
    });

  }
// /* For Update The data Cell**/
//   Future updateGuestsData(String proximityGroup ,String last_name ,String first_name,int quantity_invited) async
//   {
//     return await guestsCollection.document(uid).setData({
//       'proximityGroup': proximityGroup,
//       'last_name' : last_name,
//       'first_name' : first_name,
//       'quantity_invited' : quantity_invited
//     });
//   }

/*
  //get list guests from snapshot
  List<Guest> _guestsListFromSnapshot(QuerySnapshot snapshot){
      return snapshot.documents.map( (doc) {
        return Guest(
           proximityGroup: doc.data['proximityGroup'] ?? '',
             last_name :doc.data['last_name'] ?? '',
            first_name : doc.data['first_name'] ?? '',
            quantity_invited: doc.data['quantity_invited'] ?? 0,
        );
      }).toList();
  }
 //get guests stream
  Stream<List<Guest>> get guests{
  return  guestsCollection.document(uid).collection('guests').snapshots().map(
    _guestsListFromSnapshot);
  }



}
*/
}