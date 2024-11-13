import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_core/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: CustomDatePicker(),
    );
  }
}

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  CalendarController controller = CalendarController();
  DateRangePickerController datePickerController = DateRangePickerController();
  String? _headerText;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                color: Colors.white,
                child: TextButton(
                  child: Text(
                    _headerText ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    datePickerController.displayDate = selectedDate;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: SfDateRangePickerTheme(
                              data: const SfDateRangePickerThemeData(
                                backgroundColor: Colors.white,
                                headerBackgroundColor: Colors.white,
                                todayCellTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                                selectionColor: Color.fromRGBO(35, 188, 1, 1),
                                todayTextStyle: TextStyle(
                                  color: Color.fromRGBO(35, 188, 1, 1),
                                ),
                                todayHighlightColor:
                                    Color.fromRGBO(35, 188, 1, 1),
                                headerTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              child: SfDateRangePicker(
                                controller: datePickerController,
                                onSelectionChanged:
                                    (DateRangePickerSelectionChangedArgs args) {
                                  selectedDate = args.value;
                                  controller.displayDate = selectedDate;
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: SfCalendar(
              view: CalendarView.day,
              todayHighlightColor: const Color.fromRGBO(35, 188, 1, 1),
              headerHeight: 0,
              controller: controller,
              onViewChanged: (viewChangedDetails) {
                if (viewChangedDetails.visibleDates.isNotEmpty) {
                  _headerText = DateFormat('MMMM yyyy')
                      .format(viewChangedDetails.visibleDates[0]);
                  selectedDate = viewChangedDetails.visibleDates[0];
                }
                SchedulerBinding.instance.addPostFrameCallback(
                  (duration) {
                    setState(() {});
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
