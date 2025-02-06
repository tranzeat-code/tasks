// task5 login page

import 'package:flutter/material.dart';

class Task5 extends StatefulWidget {
  const Task5({super.key});

  @override
  State<Task5> createState() => _Task5State();
}

class _Task5State extends State<Task5> {
  // ***************************************** this part is for the login page data and validation
  // email TextEditingController
  final TextEditingController _emailController = TextEditingController();
  // password TextEditingController
  final TextEditingController _passwordController = TextEditingController();
  // form key
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // padding -> single child scroll view -> form -> column -> [text form filed email , text form filed password ,  login button]
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // network image logo
              // sized box height 16
              // text form field email
              // sized box height 16
              // text form field password
              // sized box height 16
              // login button
            ],
          ),
        ),
      ),
    );
  }
}
