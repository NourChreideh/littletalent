import 'package:flutter/material.dart';
import 'package:kidsnursery/Utility/localeprovider.dart';
import 'package:kidsnursery/l10n/l10n.dart';
import 'package:kidsnursery/main.dart';

import 'package:provider/provider.dart';

class LanguageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);

    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 72,
        child: Text(
          flag,
          style: TextStyle(fontSize: 80),
        ),
      ),
    );
  }
}

class LanguagePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('en');
    List<String> languagess=[
      "English",
      "French"
    ];

    return DropdownButtonHideUnderline(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
           color:  Color(0xffE85171).withOpacity(0.2),),
       
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: DropdownButton(
              
            value: locale,
            icon:Icon(Icons.arrow_drop_down),
            items: L10n.all.map(
              (locale) {
              
          
                return DropdownMenuItem(
                  child: Center(
          
                    child: 
                    Text(
                      locale.languageCode,
                      style: TextStyle(fontSize: 16,color:Colors.grey),
                    ),
                  ),
                  value: locale,
                  onTap: () {
                    final provider =
                        Provider.of<LocaleProvider>(context, listen: false);
          
                    provider.setLocale(locale);
                  },
                );
              },
            ).toList(),
            onChanged: (_) {},
          ),
        ),
      ),
    );
  }
}
