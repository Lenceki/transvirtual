import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trans_virtual/application/bloc/auth_bloc.dart';
import 'package:trans_virtual/application/bloc/result_state.dart';
import 'package:trans_virtual/domain/model/user_login.dart';

import '../widget/orange_button_widget.dart';
import 'dashboard_page_widget.dart';
class LoginPageWidget extends StatefulWidget {

  const LoginPageWidget({super.key});
  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    userNameController.text = "flutter@slat3r";
    passwordController.text = "123flutter";
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.blue,
        body: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(

                  child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 100, 20, 100),

                      constraints: BoxConstraints(minHeight: constraint.maxHeight),

                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("TransVirtual", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                            Expanded(child: Container()),
                            Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    TextFormField(
                                      cursorColor: Colors.white,
                                      controller: userNameController,
                                      style: const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Colors.white
                                          ),
                                          labelStyle: TextStyle(
                                              color: Colors.white
                                          ),

                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white, width: 0.0),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          labelText: 'Username',
                                          suffixIcon: Icon(Icons.email, size: 14, color: Colors.white)
                                      ),
                                      validator: (String? value) {
                                        return (value != null && value.isEmpty ) ? 'Please insert username' : null;
                                      },
                                    ),
                                    TextFormField(
                                      cursorColor: Colors.white,
                                      controller: passwordController,
                                      style: const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        labelStyle: TextStyle(color: Colors.white),
                                        suffixIcon: Icon(Icons.lock, size: 14, color: Colors.white),
                                        labelText: 'Password',
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white, width: 0.0),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      validator: (String? value) {
                                        return (value != null && value.isEmpty ) ? 'Please insert password' : null;
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                    BlocConsumer<AuthBloc, ResultStateType>(
                                        listener: (context, state) {
                                          switch (state) {
                                            case final ResultSuccess<UserLogin> state:
                                              Navigator.pushNamed(context, "/dashboard");


                                          case final ResultError error:
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text(error.message)
                                          ));
                                        }
                                        },
                                        builder: (context, state) {
                                          return OrangeButtonWidget(
                                              tittleWidget: Container(
                                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                child: const Text("Login"),
                                              ), onTap: () {
                                                if (state is ResultLoading) return;
                                                if (_formKey.currentState?.validate() ?? false) {
                                                  context.read<AuthBloc>().login(userNameController.text, passwordController.text);
                                                }
                                            },
                                            suffixWidget: (state is ResultLoading) ? const SizedBox( width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : null
                                          );
                                        }
                                    )

                                  ],
                                )
                            )
                          ],
                        ),
                      )
                  )
              );
            }
        ),
    );
  }


}