import 'package:flutter/material.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/home_screen/controller/home_controller.dart';
import 'package:reminder_app/presentation/reminder_screen/widgets/reminder_body.dart';
import 'package:reminder_app/presentation/search_screen/controller/search_controller.dart';
import 'package:reminder_app/theme/app_style.dart';

var category = [
  "Warranty Card",
  "Coupon",
  "PUC",
  "Property Rent",
  "Premium",
  "Bill Payment",
  "Credit Card",
  "Recharge",
  "EMI",
  "Loan",
];

class SearchScreen extends GetWidget<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstant.green,
            title: Get.find<HomeScreenController>().searchValue.value.isEmpty
                ? Text("Search")
                : Text(Get.find<HomeScreenController>()
                    .searchValue
                    .value
                    .toString()),
            actions: [
              //custome_popupmenu()

              PopupMenuButton(
                  icon: Icon(Icons.category, color: ColorConstant.white),
                  color: ColorConstant.white,
                  itemBuilder: (context) => category
                      .map((item) => PopupMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: AppStyle.popupCategorySearch,
                            ),
                          ))
                      .toList(),
                  onSelected: (item) async {
                    Get.find<HomeScreenController>()
                        .setSearchValue(item.toString());

                    await Get.find<HomeScreenController>()
                        .fetchSearchTasks(catName: item.toString());
                  })
            ],
            leading: IconButton(
                onPressed: () {
                  Get.find<HomeScreenController>().searchValue.value = 'All';
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorConstant.white,
                )),
          ),
          body: Container(
            child: list_display(),
          ),
        ));
  }
}

Widget list_display() {
  return Get.find<HomeScreenController>().searchData.length <= 0
      ? //taskController.fetchTasks()
      Center(
          child: Image.asset(
          'assets/noData.png',
          scale: 4,
        ))
      : Obx(
          () => ListView.builder(
              physics:
                  NeverScrollableScrollPhysics(), // <-- this will disable scroll
              shrinkWrap: true,
              itemCount: Get.find<HomeScreenController>().searchData.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: (Colors.grey[350]!), width: 0.7),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    elevation: 0,
                    child: InkWell(
                      onTap: () {
                        // Get.to(() => add_Remainders(), arguments: {
                        //   "testArg": Get.find<SearchController>().searchData[index],
                        // });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 12, bottom: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(
                                    Get.find<HomeScreenController>()
                                        .searchData[index]
                                        .taskTitle
                                        .toString(),
                                    style: AppStyle.cardTitleTextStyle,
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Icon(
                                    Icons.category,
                                    color: ColorConstant.green,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    Get.find<HomeScreenController>()
                                        .searchData[index]
                                        .categoryName
                                        .toString(),
                                    style: AppStyle.cardEventTextStyle,
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.watch_later_sharp,
                                    color: ColorConstant.green,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '05:25 PM',
                                    style: AppStyle.cardEventTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
}
