import "package:flutter/material.dart";

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: MediaQuery.of(context).size.width,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFEE), Color(0xFF999999)],
            stops: [0.5, 1],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () => print("alert pressed"),
                child: Text("Alert"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAlertButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      height: 100,
      // color: Colors.red,
      child: FlatButton(
        onPressed: () => print("Alert pressed"),
        child: Text("Alert"),
      ),
    );
  }

  Widget buildPhoneNumberField(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.transparent,
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.phone),
          hintText: "Phone Number",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildNotificationContainer(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.access_alarm),
            SizedBox(width: 3),
            Text("We will send One Time Password on this mobile number"),
          ],
        ));
  }

  Widget buildLoginButton(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: FlatButton(
          child: Text("Login"),
          onPressed: () {
            print("Login pressed");
          },
        ));
  }

  Widget buildCompanyContainer(BuildContext context) {
    return Text(
      "Ganesh Pvt Ltd.",
      style: Theme.of(context).textTheme.display1,
    );
  }
}
