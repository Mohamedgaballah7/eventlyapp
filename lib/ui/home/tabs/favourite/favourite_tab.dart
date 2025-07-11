import 'package:eventlyapproute/l10n/app_localizations.dart';
import 'package:eventlyapproute/ui/widgets/custom_text_form_field.dart';
import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:eventlyapproute/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../home/widgets/events_items_container.dart';
class FavouriteTab extends StatelessWidget {
   FavouriteTab ({super.key});
TextEditingController searchEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
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
            child: ListView.separated(
                padding: EdgeInsets.only(top: height*0.02),
                itemBuilder: (context, index) {
                  return EventsItemsContainer();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height*0.01,);
                },
                itemCount: 10),
          ),
        ],
      ),
    );
  }
}
