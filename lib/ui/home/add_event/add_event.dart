import 'package:eventlyapproute/ui/home/add_event/event_lists/event_lists.dart';
import 'package:eventlyapproute/ui/home/tabs/home/widgets/events_items.dart';
import 'package:eventlyapproute/ui/widgets/custom_elavated_button.dart';
import 'package:eventlyapproute/ui/widgets/custom_text_form_field.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:eventlyapproute/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';

class AddEventScreen extends StatefulWidget {
   AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
int selectedIndex=0;
TextEditingController titleEditingController=TextEditingController();
TextEditingController descriptionEditingController=TextEditingController();
final formKey=GlobalKey<FormState>();
DateTime? selectedDate;
TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
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
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var themeProvider=Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.create_event,style: AppStyles.bold16Primary,),
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
                  themeProvider.isDarkMode()?
                  EventList.eventsImageDarkList[selectedIndex]
                      :EventList.eventsImageList[selectedIndex],
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
                    hintName: AppLocalizations.of(context)!.event_title,
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
                  CustomTextFormField(hintName: AppLocalizations.of(context)!.event_description,
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
                      textButton:selectedDate==null?AppLocalizations.of(context)!.choose_date:
                          '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    onPressed: setDate,
                  ),
                  builtEventDateAndTime(
                      icon: Icon(Icons.access_time_outlined,
                        color: themeProvider.isDarkMode()?
                        AppColors.whiteColor
                            :AppColors.blackColor,),
                      sizeBox: width*0.02,
                      text: AppLocalizations.of(context)!.event_time,
                      textButton:selectedTime==null? AppLocalizations.of(context)!.choose_time:
                    selectedTime!.format(context),
                    onPressed: setTime,
                  ),
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
                    addEventCheck();
                  },
                      textName: AppLocalizations.of(context)!.add_event),
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
        TextButton(onPressed:onPressed,
          child:  Text(textButton,style: AppStyles.bold16Primary,),)
      ],
    );
  }
  void addEventCheck(){
    if(formKey.currentState!.validate()){}
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
  setState(() {

  });
}
}
