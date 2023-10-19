import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginationexp/controller.dart';
import 'package:paginationexp/model.dart';

class CustomPaginationPage extends StatefulWidget {
  const CustomPaginationPage({super.key});

  @override
  State<CustomPaginationPage> createState() => _CustomPaginationPageState();
}

class _CustomPaginationPageState extends State<CustomPaginationPage> {
  final controller = Get.put(ExampleController());
  ScrollController _scrollController = ScrollController();
  Future<Demomodel?>? future;
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.getSeconData();
      }
    });

    future = controller.getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: GetBuilder<ExampleController>(
            init: ExampleController(),
            initState: (_) {},
            builder: (_) {
              return FutureBuilder(
                  future: future,
                  builder: (context, snapShot) {
                    print(snapShot.data);
                    if (snapShot.hasData) {
                      return GetBuilder<ExampleController>(
                        init: ExampleController(),
                        initState: (_) {},
                        builder: (_) {
                          return Stack(
                            children: [
                              Column(
                                children: [
                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: _.result.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 100,
                                          child: ListTile(
                                            title: Text(_.result[index].name),
                                          ),
                                        );
                                      }),
                                  Container(
                                    height: 50,
                                  ),
                                  // _.isLoading
                                  //     ? Container(
                                  //         height: 50,
                                  //         child: Center(
                                  //           child: CircularProgressIndicator(),
                                  //         ),
                                  //       )
                                  //     : Container(),
                                  // _.isEmpty
                                  //     ? Center(
                                  //         child: Text("No Data Found"),
                                  //       )
                                  //     : Container(),
                                ],
                              ),
                              Positioned(
                                  left: 50,
                                  bottom: 0,
                                  child: GetBuilder<ExampleController>(
                                    init: ExampleController(),
                                    initState: (_) {},
                                    builder: (_) {
                                      if (_.isLoading == true &&
                                          _.isEmpty == false) {
                                        return _.isLoading
                                            ? Container(
                                                height: 50,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              )
                                            : Container();
                                      } else if (_.isLoading == false &&
                                          _.isEmpty == true) {
                                        return _.isEmpty
                                            ? Center(
                                                child: Text("No Data Found"),
                                              )
                                            : Container();
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ))
                            ],
                          );
                        },
                      );
                    } else if (snapShot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Center(child: Text("No Data Found"));
                    }
                  });
            },
          ),
        ),
      ),
    );
  }
}
