class Event{
  static const String collectionName='Events';
  String id;
  String image;
  String eventName;
  String title;
  String description;
  DateTime dateTime;
  String time;
  bool isFavourite;
  Event({
    this.id='',
    required this.image,
    required this.eventName,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.time,
    this.isFavourite=false
});
  Event.fromFireStore(Map<String,dynamic>data):this(
    id: data['id'],
    image: data['image'],
    eventName: data['eventName'],
    title: data['title'],
    description: data['description'],
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    time: data['time'],
    isFavourite: data['isFavourite'],
  );
  Map<String,dynamic>toFireStore(){
    return {
      'id':id,
      'image':image,
      'eventName':eventName,
      'title':title,
      'description':description,
      'dateTime':dateTime.millisecondsSinceEpoch,
      'time':time,
      'isFavourite':isFavourite,
    };
  }
}