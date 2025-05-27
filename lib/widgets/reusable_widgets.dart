import 'package:flutter/material.dart';

TextField reusableTextField(
  String text,
  IconData? icon,
  bool showText,
  TextEditingController controller, {
  Function()? toggleOnOff,
}) {
  return TextField(
    controller: controller,
    obscureText: !showText,
    enableSuggestions: showText,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white60),
    decoration: InputDecoration(
      prefixIcon: icon != null ? Icon(icon, color: Colors.white70) : null,
      labelText: text,
      labelStyle: TextStyle(color: Colors.white60),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.green[300],
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
                  color: Colors.green[900],
                ),
              ),
    ),
    keyboardType:
        !showText ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

//........................................................................................

Image logoAuth(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    
    //color: Colors.black,
  );
}

//........................................................................................

Container myButton(BuildContext context, Function onTap, String buttonText) {
  TextStyle buttonTextStyle = TextStyle(color: Colors.white);
  return Container(
    width: MediaQuery.of(context).size.width,
    // width: 150,
    height: 50.0,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hexToColor('159947'),
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
    margin: EdgeInsets.only(left: 50),
    color: Colors.grey[350],
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      splashColor: Colors.green[50],
      child: SizedBox(
        width: 260,
        height: 140,
        child: Row(
          children: [
            Image.asset(imageName, fit: BoxFit.fitWidth, width: 100),
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
