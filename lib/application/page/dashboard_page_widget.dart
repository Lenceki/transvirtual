import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trans_virtual/application/bloc/auth_bloc.dart';
import 'package:trans_virtual/application/bloc/result_state.dart';
import 'package:trans_virtual/application/page/login_page_widget.dart';
import 'package:trans_virtual/domain/model/user_login.dart';
import 'package:intl/intl.dart';

import '../widget/orange_button_widget.dart';

class DashBoardPageWidget extends StatefulWidget {
  const DashBoardPageWidget({super.key});
  @override
  State<DashBoardPageWidget> createState() => _DashBoardPageWidgetState();
}

class _DashBoardPageWidgetState extends State<DashBoardPageWidget>  {
  late String time;
  late StreamSubscription<ConnectivityResult> subscription;
  String connectionName = "unknown";
  @override
  void initState() {

    time = DateFormat("h:mma").format(DateTime.now());

    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectionName = result.name;
      });
      // Got a new connectivity status!
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('TransVirtual'),

      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                BlocProvider.
                of<AuthBloc>(context).logout();
              },
            ),
          ],
        ),
      ),
      body: BlocConsumer<AuthBloc, ResultStateType>(
          bloc:  BlocProvider.of<AuthBloc>(context),
          listener: (context, state) {

            switch (state) {
              case ResultLogout logout:
              Navigator.of(context).popUntil((route) => route.isFirst);
            case final ResultError error:
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.message)
              ));
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                                Text(time, style: const TextStyle(color: Colors.blueGrey))

                              ]
                          ),
                          const SizedBox(height: 10),
                          OrangeButtonWidget(
                              tittleWidget: Container(
                                padding: const EdgeInsets.only(top: 20, bottom: 20),
                                child: const Text("Search"),
                              ), onTap: () {},
                              prefixWidget: const Icon(Icons.search, color: Colors.white)
                          ),
                          const SizedBox(height: 10),
                          OrangeButtonWidget(
                              tittleWidget: Container(
                                padding: const EdgeInsets.only(top: 20, bottom: 20),
                                child: const Text("Movements"),
                              ), onTap: () {},
                              prefixWidget: const Icon(Icons.shopping_cart_rounded, color: Colors.white)
                          ),
                          const SizedBox(height: 10),
                          OrangeButtonWidget(
                              tittleWidget: Container(
                                padding: const EdgeInsets.only(top: 20, bottom: 20),
                                child: const Text("Stock Take"),
                              ), onTap: () {},
                              prefixWidget: const Icon(Icons.list_alt, color: Colors.white)
                          ),
                          const SizedBox(height: 10),
                          ...infoWidget(state)

                        ]

                    ),
                  )
              )
            );
          }
      ),
    );
  }

  List<Widget> infoWidget(ResultStateType stateType)  {
    switch (stateType) {
      case final ResultSuccess<UserLogin> state:
        return [
            infoItemWidget("TransVirtual #", state.data.transVirtualNumber ?? ""),
            infoItemWidget("Company", state.data.currentClientName ?? "unknown warehouse"),
            infoItemWidget("Warehouse", state.data.warehouseTitle ?? "unknown warehouse"),
            infoItemWidget("status", connectionName)
          ];
        default:
          return [];
    }

  }

  Widget infoItemWidget(String tittle, String value) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5)
      ),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Row(
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                width: constraint.maxWidth * 0.30,
                  color: Colors.lightBlue,
                  child: Text(tittle, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey))
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  width: constraint.maxWidth * 0.70,
                  child: Text(value)
              )
            ],
          );
        }
      )
    );
  }

}