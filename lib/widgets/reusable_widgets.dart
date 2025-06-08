import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Column reusableTextField(
  String text,
  IconData? icon,
  bool showText,
  TextEditingController controller, {
  Function()? toggleOnOff,
  TextInputType? keyboardType,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 3),
        child: Text('$text:'),
      ),
      TextField(
        controller: controller,
        obscureText: !showText,
        enableSuggestions: showText,
        cursorColor: Colors.teal,
        style: const TextStyle(color: Colors.black),
        keyboardType:
            keyboardType ??
            (!showText
                ? TextInputType.visiblePassword
                : TextInputType.emailAddress),
        inputFormatters:
            keyboardType == TextInputType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon, color: Colors.teal[100]) : null,
          filled: true,
          fillColor: Colors.teal[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          ),
          suffixIcon:
              toggleOnOff == null
                  ? null
                  : IconButton(
                    onPressed: toggleOnOff,
                    icon: Icon(
                      showText ? Icons.visibility_off : Icons.visibility,
                      color: hexToColor('005954'),
                    ),
                  ),
        ),
      ),
    ],
  );
}

//........................................................................................

Image logoAuth(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitHeight,
    height: 200,
    // width: 200,

    //color: Colors.black,
  );
}

//........................................................................................

Container myButton(
  BuildContext context,
  Function onTap,
  String buttonText, {
  TextStyle buttonTextStyle = const TextStyle(color: Colors.white),
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    // width: 150,
    height: 50.0,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hexToColor('005954'),
        elevation: 1,
      ),
      onPressed: () {
        onTap();
      },
      child: Text(buttonText, style: buttonTextStyle),
    ),
  );
}

Card myCard(
  Text cardTitle,
  String imageName,
  String firstEntry,
  String secondEntry,
  VoidCallback onTap,
) {
  TextStyle entryStyle = const TextStyle(fontWeight: FontWeight.w200);
  return Card(
    // margin: EdgeInsets.only(left: 30),
    color: Colors.teal[50],
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      splashColor: Colors.teal[50],
      child: SizedBox(
        width: 260,
        height: 140,
        child: Row(
          children: [
            Image.asset(imageName, fit: BoxFit.cover, height: 90, width: 90),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cardTitle,
                Text(firstEntry, style: entryStyle),
                Text(secondEntry, style: entryStyle),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

//........................................................................................
ListTile nozzleTile(String nozzleProduct) {
  TextStyle nozzleProductStyle = TextStyle(fontSize: 12);
  return ListTile(
    tileColor: Colors.grey,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    leading: Icon(Icons.water_drop_rounded),
    title: Text(nozzleProduct, style: nozzleProductStyle),
  );
}

//........................................................................................
Color hexToColor(String hex) {
  return Color(int.parse('0xFF$hex'));
}

//........................................................................................

//........................................................................................

Container dialogButtons(
  BuildContext context,
  Function onTap,
  String buttonText,
) {
  TextStyle buttonTextStyle = TextStyle(color: Colors.white, fontSize: 16);
  return Container(
    width: 120,
    // width: 150,
    height: 50.0,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hexToColor('005954'),
        elevation: 1,
      ),
      onPressed: () {
        onTap();
      },
      child: Text(buttonText, style: buttonTextStyle),
    ),
  );
}
//........................................................................................

Container cancelButtons(
  BuildContext context,
  Function onTap,
  String buttonText,
) {
  TextStyle buttonTextStyle = TextStyle(color: hexToColor('005954'));
  return Container(
    width: 120,
    // width: 150,
    height: 50.0,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: TextButton(
      onPressed: () {
        onTap();
      },
      style: TextButton.styleFrom(
        //backgroundColor: hexToColor('005954'),
      ),
      child: Text(buttonText, style: buttonTextStyle),
    ),
  );
}
//........................................................................................

Container exitButtons(BuildContext context, Function onTap, String buttonText) {
  TextStyle buttonTextStyle = TextStyle(color: Colors.white);
  return Container(
    width: 120,
    // width: 150,
    height: 50.0,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hexToColor('005954'),
        elevation: 1,
      ),
      onPressed: () {
        onTap();
      },
      child: Text(buttonText, style: buttonTextStyle),
    ),
  );
}
//........................................................................................