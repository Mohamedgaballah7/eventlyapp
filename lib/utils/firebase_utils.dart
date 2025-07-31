import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyapproute/models/event.dart';

import '../models/user.dart';

class FirebaseUtils{
  static CollectionReference<Event> getEventsCollection(String id){
    return getUsersCollection().doc(id).collection(Event.collectionName)
        .withConverter<Event>(
      fromFirestore: (snapshot, options) => Event.fromFireStore(snapshot.data()!),
      toFirestore: (event, options) =>event.toFireStore() ,
    );
  }
  static CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, options) => MyUser.fromFireStore(snapshot.data()!),
      toFirestore: (user, options) =>user.toFireStore() ,
    );
  }

  static Future<void> addUserToFireStore(MyUser user){
    return getUsersCollection().doc(user.id).set(user);
    
  }
  static Future<MyUser?> readUserFromFireStore(String id)async{
    var querySnapShot=await getUsersCollection().doc(id).get();
    return querySnapShot.data();
  }
  static Future<void> addEventToFireStore(Event event,String id){
    var eventsCollection=getEventsCollection(id);
    DocumentReference<Event> docRef=eventsCollection.doc();
    event.id=docRef.id;
    return docRef.set(event);
  }
}