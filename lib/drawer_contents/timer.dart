import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:intl/intl.dart';

import '../db_code/databaseUtilities.dart';
import '../models/order_model.dart';

class ItemTimer extends StatefulWidget {
  const ItemTimer({Key? key}) : super(key: key);

  @override
  _ItemTimerState createState() => _ItemTimerState();
}

class _ItemTimerState extends State<ItemTimer> {
  //TODO: Timer stays on when not on screen
  //TODO: Timer shows h:m:s instead of m:s:ms
  //TODO: Dropdown menu for in progress or pending orders
  //TODO: Note what time the timer started

  //(Supposed to) Capture when the timer started
  //Need to tie this to start button
  String timeData = DateFormat("hh:mm a").format(DateTime.now());

  //DateTime now = DateTime.now();
  String selectedValue = "Order/Project";

  late OrderModel _currentSelection;

  final _isSeconds = false;
  final _isMilliSeconds = false;
  final _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStop: () {
      print('onStop');
    },
    onEnded: () {
      print('onEnded');
    },
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff36454F),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: const Color(0xff3e505c),
                height: MediaQuery.of(context).size.height * 0.33,
              ),
              Container(
                color: const Color(0xff36454f),
                height: MediaQuery.of(context).size.height * 0.55,
              ),
            ],
          ),
          Positioned(
            // top: MediaQuery.of(context).size.height * 0.10, //120,
            // left: MediaQuery.of(context).size.width * 0.30, //50,
            //bottom: 50,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.30,
                    //   width: MediaQuery.of(context).size.width * 0.90,
                    //   // decoration: BoxDecoration(
                    //   //     border: Border.all(color: Colors.white)),
                    //   child: Center(
                    //     child: Text('Timer goes here'),
                    //   ),
                    // ),
                    //Display for timer
                    StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (context, snap) {
                        final value = snap.data!;
                        final displayTime = StopWatchTimer.getDisplayTime(value,
                            second: _isSeconds, milliSecond: _isMilliSeconds);
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                displayTime,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),

                //display when the timer started
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Text(
                    'STARTED AT $timeData)',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),

                //dropdown of order/project names
                // Container(

                //      height: MediaQuery.of(context).size.height * 0.1,
                //      width: MediaQuery.of(context).size.width * 0.90,
                //      decoration:
                //          BoxDecoration(border: Border.all(color: Colors.white)),
                //      child: FutureBuilder(
                //          future: DatabaseHelper.instance.getOrder(),
                //         builder: (context,
                //             AsyncSnapshot<List<OrderModel>> snapshot) {
                //           if (!snapshot.hasData) {
                //             return const CircularProgressIndicator();
                //           }
                //           // else {
                //           //   return DropdownButton(
                //           //     items: [],
                //           //     onChanged: (Object? value) {  },
                //           //     );
                //           // }
                //           // DropdownButton(
                //           //     value: _currentSelection,

                //           //     items: snapshot.data
                //           //         ?.map((order) => DropdownMenuItem<OrderModel>(
                //           //               child: Text(order.orderName),
                //           //               value: order,
                //           //             ))
                //           //         .toList());
                //         },
                //),
                //),
                Container(
                  //todo: before a timer starts, there is only one button, labeled START
                  //todo: after a timer starts, there ar two buttons, PAUSE and STOP
                  //TODO: on pausing a timer, PAUSE becomes STOP

                  //color: const Color(0xff997ABD),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: TextButton(
                    child: const Text('START'),
                    //start button
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      setState(() {
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  null;
                                },
                                child: const Text('PAUSE'),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  null;
                                },
                                child: const Text('stop'),
                              ),
                            ],
                          ),
                        );
                      });
                    },
                  ),
                ),
                Column(
                  children: [
                    Text("Recent"),
                    Row(
                      children: [
                        Text("Project name"),
                        Text("Last recorded time")
                        //TODO: last 3 timer recordings
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
