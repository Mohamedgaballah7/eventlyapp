class Event{
  static const String collectionName='Events';
  int index;
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
    required this.index,
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
    index: data['index'] ?? 0,
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
      'index': index,
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