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
      prefixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Color(0x66DA6509),
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
                  color: Colors.brown[600],
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

Container myButton(BuildContext context, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50.0,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFA6642D)),
      onPressed: () {
        onTap();
      },
      child: Text('LOG IN', style: TextStyle(color: Colors.white)),
    ),
  );
}

Card myCard(Text cardTitle, String imageName) {
  return Card(
    color: Colors.orange[300],
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    child: SizedBox(
      width: 180,
      height: 150,
      child: Column(
        children: [
          Image.asset(imageName, fit: BoxFit.fitWidth, width: 120),
          cardTitle,
        ],
      ),
    ),
  );
}
