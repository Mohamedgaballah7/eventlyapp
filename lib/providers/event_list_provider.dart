
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:eventlyapproute/utils/snack_bar_message.dart';
import 'package:flutter/material.dart';

import '../utils/firebase_utils.dart';
import '../l10n/app_localizations.dart';
import '../models/event.dart';

class EventListProvider extends ChangeNotifier{
  int selectedIndex=0;
  List<Event>eventList=[];
  List<Event>filterEventList=[];
  List<String>eventsNameList=[];
  List<Event>favouriteList=[];
  List<String> getEventsNameList(BuildContext context){
    return eventsNameList=[
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookclub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }
  void getAllEvents(String id)async{
    QuerySnapshot<Event> querySnapShot=await FirebaseUtils.getEventsCollection(id).get();
    eventList=querySnapShot.docs.map((doc) {
      return doc.data();
    },).toList();
    filterEventList=eventList;
    //sorting....
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    },);
    notifyListeners();
  }
  void getFilterEventsFromFireStore(String id)async{
    var querySnapshot=await FirebaseUtils.getEventsCollection(id)
        .where('eventName',isEqualTo:eventsNameList[selectedIndex] ).get();
    filterEventList=querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    //sorting....
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    },);
    notifyListeners();
  }
  void changeToSelectedIndex(int newSelectedIndex,String id){
    selectedIndex=newSelectedIndex;
    selectedIndex==0?getAllEvents(id):getFilterEventsFromFireStore(id);
  }
  void updateIsFavourite(Event event,BuildContext context,String id){
    FirebaseUtils.getEventsCollection(id).doc(event.id)
        .update({'isFavourite':!event.isFavourite})
        .then(
      (value) {
         snackBarMessage(context,
            text: AppLocalizations.of(context)!.favourite_update,
            color: AppColors.greenColor);
        selectedIndex==0?getAllEvents(id):getFilterEventsFromFireStore(id);
        getAllFavouriteFromFireStore(id);
        notifyListeners();
      },
      
    );
        //todo:used timeout when network is disable => (offline)
        // .timeout(Duration(milliseconds: 500),
        // onTimeout: () {
        //   snackBarMessage(context,
        //       text: AppLocalizations.of(context)!.favourite_update,
        //       color: AppColors.greenColor);
        // selectedIndex==0?getAllEvents(id):getFilterEventsFromFireStore(id);
        // getAllFavouriteFromFireStore(id);
        // notifyListeners();
        // },);

  }
  void getAllFavouriteFromFireStore(String id)async{
    var querySnapShot=await FirebaseUtils.getEventsCollection(id)
        .where('isFavourite',isEqualTo: true)
        .orderBy('dateTime').get();
    favouriteList=querySnapShot.docs.map((doc) {
      return doc.data();
    },).toList();
    notifyListeners();
  }
  void deleteSpecificEventFromFireStore(Event event,BuildContext context,String id)async{
    await FirebaseUtils.getEventsCollection(id)
        .doc(event.id)
        .delete()
          .then(
            (value) {
          snackBarMessage(context,
              text: AppLocalizations.of(context)!.update_event,
              color: AppColors.greenColor);
          selectedIndex==0?getAllEvents(id):getFilterEventsFromFireStore(id);
          getAllFavouriteFromFireStore(id);
          notifyListeners();
        },

      );

    }
  void updateEventFromFireStore(Event event,BuildContext context,String uId){
    FirebaseUtils.getEventsCollection(uId).doc(event.id).update({
      'image': event.image,
      'eventName': event.eventName,
      'title': event.title,
      'description': event.description,
      'dateTime': event.dateTime,
      'time': event.time,
    })
        .then((value)  {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.update_event,
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppColors.whiteColor),
          textAlign: TextAlign.center,)
        ,backgroundColor: AppColors.greenColor,
      ));
      //Changeindex(0, uId);
       selectedIndex == 0 ? getAllEvents(uId) : getFilterEventsFromFireStore(uId);
    },);
    notifyListeners();
  }
}

