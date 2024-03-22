import 'package:flutter/material.dart';


class MyDropdown extends StatelessWidget {
  final Function(String, String, Widget) onChanged;

  MyDropdown({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (int i = 0; i < countryCode.length; i++)
          ListTile(
            title: Row(
              children: [
                dropdownImages[i], // Use index to access corresponding image
                SizedBox(width: 8), // Add spacing between image and text
                Text(countryCode[i]??''),
                SizedBox(width: 8), // Add spacing between text
                Text(countryName[i]?? ''), // Use index to access corresponding country name
              ],
            ),
            onTap: () {
              onChanged(countryCode[i], countryName[i], dropdownImages[i]);
            },
          ),
      ],
    );
  }

  // List of items in our dropdown menu
  var countryCode = [
    'US',
    'GB',
    'SG',
    'CN',
    'NL',
    'ID'
  ];
  var countryName = [
    'United States',
    'United Kingdom',
    'Singapore',
    'China',
    'Netherlands',
    'Indonesia'
  ];
  List<Widget> dropdownImages = [
    Image.asset('assets/icons/US.png'),
    Image.asset('assets/icons/uk.png'),
    Image.asset('assets/icons/SG.png'),
    Image.asset('assets/icons/CN.png'),
    Image.asset('assets/icons/NL.png'),
    Image.asset('assets/icons/ID.png'), // Example image asset
  ];
}
