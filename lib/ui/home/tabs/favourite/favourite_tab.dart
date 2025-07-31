import 'package:eventlyapproute/l10n/app_localizations.dart';
import 'package:eventlyapproute/ui/widgets/custom_text_form_field.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:eventlyapproute/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/event_list_provider.dart';
import '../home/widgets/events_items_container.dart';
class FavouriteTab extends StatefulWidget {
   FavouriteTab ({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
TextEditingController searchEditingController=TextEditingController();
late EventListProvider eventListProvider;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      eventListProvider.favouriteList;
    },);
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
     eventListProvider=Provider.of<EventListProvider>(context);

    return SafeArea(
      child: Column(
        children: [
          CustomTextFormField(
            controller: searchEditingController,
            hintName: AppLocalizations.of(context)!.search_for_event,
            prefixIcon: Icon(Icons.search,color: AppColors.primaryLight,),
            borderColor: AppColors.primaryLight,
            textStyle: AppStyles.medium14Primary,
          ),
          Expanded(
            child:eventListProvider.favouriteList.isEmpty?
            Center(child: Text(AppLocalizations.of(context)!.no_event,style: AppStyles.bold20Primary,)):
            ListView.separated(
                padding: EdgeInsets.only(top: height*0.02),
                itemBuilder: (context, index) {
                  return EventsItemsContainer(event: eventListProvider.favouriteList[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height*0.01,);
                },
                itemCount: eventListProvider.favouriteList.length),
          ),
        ],
      ),
    );
  }
}
