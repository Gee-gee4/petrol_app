import 'package:flutter/material.dart';
import 'package:petrol_app/model/transaction_model.dart';
import 'package:petrol_app/modules/transaction_module.dart';

Column reusableTextField(
  String text,
  IconData? icon,
  bool showText,
  TextEditingController controller, {
  Function()? toggleOnOff,
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
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon, color: Colors.teal[100]) : null,
          // labelText: text,
          // labelStyle: TextStyle(color: Colors.black),
          filled: true,
          // floatingLabelBehavior: FloatingLabelBehavior.never,
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
        keyboardType:
            !showText
                ? TextInputType.visiblePassword
                : TextInputType.emailAddress,
      ),
    ],
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
    margin: EdgeInsets.only(left: 50),
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
AlertDialog myDialogBox(BuildContext context, TransactionModel transaction) {
  //, TIN,phone number , .=post
  final TextEditingController taxPayerTextController = TextEditingController();
  final TextEditingController tinTextController = TextEditingController();
  final TextEditingController phonenoTextController = TextEditingController();

  return AlertDialog(
    backgroundColor: hexToColor('d7eaee'),
    title: Text('Post Sales:-'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        reusableTextField('Tax payer name', null, true, taxPayerTextController),
        SizedBox(height: 10),
        reusableTextField('TIN', null, true, tinTextController),
        SizedBox(height: 10),
        reusableTextField('Phone Number', null, true, phonenoTextController),
        SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dialogButtons(context, () async {
                final TransactionModule transactionModule = TransactionModule();

                await transactionModule.postTransaction(
                  transactionModel: transaction,
                  taxPayerName: taxPayerTextController.text,
                  tin: tinTextController.text,
                  phoneNumber: phonenoTextController.text,
                );
                //post logic
                if (context.mounted) Navigator.pop(context);
              }, 'POST'),
              dialogButtons(context, () {
                Navigator.pop(context);
              }, 'CANCEL'),
            ],
          ),
        ),
      ],
    ),
  );
}

//........................................................................................

Container dialogButtons(
  BuildContext context,
  Function onTap,
  String buttonText,
) {
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
