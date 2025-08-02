import 'package:eventlyapproute/models/event.dart';
import 'package:eventlyapproute/providers/user_provider.dart';
import 'package:eventlyapproute/ui/home/add_event/event_lists/event_lists.dart';
import 'package:eventlyapproute/ui/widgets/custom_elavated_button.dart';
import 'package:eventlyapproute/ui/widgets/custom_text_form_field.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:eventlyapproute/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../providers/event_list_provider.dart';
import '../home/tabs/home/widgets/events_items.dart';

class EditEvent extends StatefulWidget {
  EditEvent({super.key});
  @override
  State<EditEvent> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<EditEvent> {
  late Event args;
  int selectedIndex=0;
  TextEditingController titleEditingController=TextEditingController();
  TextEditingController descriptionEditingController=TextEditingController();
  final formKey=GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String formatedTime='';
  bool visibleDate=false;
  bool visibleTime=false;
  String selectedImage='';
  String selectedEventName='';
  late EventListProvider eventListProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (titleEditingController.text.isEmpty) {
        titleEditingController.text = args.title;
      }
      if (descriptionEditingController.text.isEmpty) {
        descriptionEditingController.text = args.description;
      }
    },);

  }
  @override
  Widget build(BuildContext context) {
    args=ModalRoute.of(context)?.settings.arguments as Event;
    List<String>eventsNameList=[
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
    selectedImage=EventList.eventsImageList[selectedIndex];
    selectedEventName=eventsNameList[selectedIndex];
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var themeProvider=Provider.of<AppThemeProvider>(context);
    eventListProvider=Provider.of<EventListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.edit_event,style: AppStyles.bold16Primary,),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.025,vertical: height*0.01),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(width*0.025),
                child: Image.asset(
                  args.image,
                  height: height*0.25,
                  width: double.infinity,
                  fit: BoxFit.fill,),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: height*0.01),
                child: SizedBox(
                  height: height*0.04,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            selectedIndex=index;
                            setState(() {

                            });
                          },
                          child: EventsItems(
                            selectedBorderColor: AppColors.transparentColor,
                            unSelectedBorderColor: AppColors.primaryLight,
                            selectedBackGroundColor: AppColors.primaryLight,
                            unSelectedBackGroundColor: AppColors.transparentColor,
                            selectedTextStyle: Theme.of(context).textTheme.headlineSmall,
                            unSelectedTextStyle: AppStyles.bold16Primary,
                            isSelected: selectedIndex==index,
                            eventName: eventsNameList[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: width*0.002,);
                      },
                      itemCount: eventsNameList.length),
                ),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.title,style: Theme.of(context).textTheme.labelSmall,),
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.mode_edit_outline_outlined,color: Theme.of(context).primaryColorLight,),
                        hintName: '',
                        controller: titleEditingController,
                        validator: (text){
                          if(text==null||text.trim().isEmpty)
                          {
                            return AppLocalizations.of(context)!.please_enter_title;
                          }
                          return null;
                        },
                      ),
                      Text(AppLocalizations.of(context)!.description,style: Theme.of(context).textTheme.labelSmall,),
                      CustomTextFormField(hintName: '',
                        controller: descriptionEditingController,
                        validator: (text){
                          if(text==null||text.trim().isEmpty)
                          {
                            return AppLocalizations.of(context)!.please_enter_description;
                          }
                          return null;
                        },
                        maxLines: 6,
                      ),
                      builtEventDateAndTime(
                        icon: Icon(Icons.calendar_month,
                          color: themeProvider.isDarkMode()?
                          AppColors.whiteColor
                              :AppColors.blackColor,),
                        sizeBox: width*0.02,
                        text: AppLocalizations.of(context)!.event_date,
                        textButton:selectedDate==null?'${args.dateTime.day}/${args.dateTime.month}/${args.dateTime.year}':
                        '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                        onPressed: setDate,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                              visible: visibleDate,
                              child: Text(AppLocalizations.of(context)!.please_enter_date,style: AppStyles.medium14Primary.copyWith(color: AppColors.redColor),)),
                        ],),
                      builtEventDateAndTime(
                        icon: Icon(Icons.access_time_outlined,
                          color: themeProvider.isDarkMode()?
                          AppColors.whiteColor
                              :AppColors.blackColor,),
                        sizeBox: width*0.02,
                        text: AppLocalizations.of(context)!.event_time,
                        textButton:selectedTime==null? args.time:
                        formatedTime,
                        onPressed: setTime,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                              visible: visibleTime,
                              child: Text(AppLocalizations.of(context)!.please_enter_time,style: AppStyles.medium14Primary.copyWith(color: AppColors.redColor),)),
                        ],),

                      Text(AppLocalizations.of(context)!.location,style: Theme.of(context).textTheme.labelSmall,),
                      Container(
                        margin:  EdgeInsets.symmetric(horizontal: width*0.025,vertical: height*0.01),
                        padding:  EdgeInsets.symmetric(horizontal: width*0.025,vertical: height*0.01),
                        decoration: BoxDecoration(
                            color: AppColors.transparentColor,
                            borderRadius: BorderRadius.circular(width*0.03),
                            border: Border.all(
                              color: AppColors.primaryLight,
                              width: 1.5,
                            )
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding:  EdgeInsets.symmetric(horizontal: width*0.025,vertical: height*0.01),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(width*0.03),
                              ),
                              child: Icon(Icons.place,color: themeProvider.isDarkMode()?
                              AppColors.blackColor
                                  :AppColors.whiteColor,),
                            ),
                            SizedBox(width: width*0.03,),
                            Text(AppLocalizations.of(context)!.choose_event_location,style:AppStyles.medium14Primary,),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,
                              color: AppColors.primaryLight,)
                          ],
                        ),
                      ),
                      CustomElavatedButton(onPressed: (){
                        updateEventCheck();
                      },
                          textName: AppLocalizations.of(context)!.update_event),
                    ],
                  )),
            ],
          ),
        ),
      ),

    );
  }
  Widget builtEventDateAndTime({
    required Icon icon,
    required double sizeBox,
    required String text,
    required String textButton,
    required void Function()? onPressed
  }){
    return Row(
      children: [
        icon,
        SizedBox(width: sizeBox,),
        Text(text,style: Theme.of(context).textTheme.labelSmall,),
        Spacer(),
        Column(
          children: [
            TextButton(onPressed:onPressed,
              child:  Text(textButton,style: AppStyles.bold16Primary,),),

          ],
        )
      ],
    );
  }
  void updateEventCheck() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    Event updatedEvent = Event(
      id: args.id,
      index: selectedIndex,
      image: args.image,
      eventName: args.eventName,
      title: titleEditingController.text,
      description: descriptionEditingController.text,
      dateTime: args.dateTime,
      time: args.time,
      /*'image': event.image,
      'eventName': event.eventName,
      'title': event.title,
      'description': event.description,
      'dateTime': event.dateTime,
      'time': event.time,*/
    );

    eventListProvider.updateEventFromFireStore(updatedEvent, context, userProvider.currentUser!.id);
  }


  void setDate()async{
    var chooseDate=await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365),
        )
    );
    selectedDate=chooseDate;
    setState(() {

    });
  }
  void setTime()async{
    var chooseTime=await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    selectedTime=chooseTime;
    formatedTime=selectedTime!.format(context);
    setState(() {

    });
  }

}