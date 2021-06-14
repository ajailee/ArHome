import 'package:aj_ar/Model/ArchiModel.dart';
import 'package:aj_ar/Screen/BuildersPage.dart';
import 'package:aj_ar/Screen/Stepper.dart';
import 'package:aj_ar/Screen/TransformNode.dart';
import 'package:aj_ar/Widget/AvaliableWidget.dart';
import 'package:aj_ar/Widget/MoreImage.dart';
import 'package:aj_ar/Widget/MyIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart' as velocity;

class DetailedScreen extends StatelessWidget {
  static String routeName = '/detailedScreen';
  @override
  Widget build(BuildContext context) {
    ArchiModel model = ModalRoute.of(context).settings.arguments;
    return Hero(
      tag: model.id,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.black),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      CupertinoIcons.back,
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, TransformableNodeScreen.routeName,
                          arguments: model.arImage);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: 20, top: 20),
                      child: Icon(
                        Icons.view_in_ar,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  )
                ],
                backgroundColor: Colors.white,
                expandedHeight: 500.0,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            model.coverImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      MoreImage(model),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      velocity.VxTextBuilder('Description')
                          .extraBold
                          .extraBlack
                          .xl4
                          .make()
                          .p12(),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: FilterChip(
                          avatar: Icon(Icons.verified),
                          backgroundColor: Colors.green,
                          label: '${model.builderName}'
                              .text
                              .extraBlack
                              .extraBold
                              .size(20)
                              .make()
                              .shimmer(
                                  primaryColor: Colors.white,
                                  secondaryColor: Colors.black,
                                  duration: Duration(seconds: 1)),
                          onSelected: (val) {
                            Navigator.pushNamed(context, BuildersPage.routeName,
                                arguments: model.builderId);
                          },
                        ),
                      )
                    ],
                  ),
                  Wrap(
                    children: [
                      MyIcon(
                        Icons.king_bed_rounded,
                        model.noOfBedRoom.toString(),
                        model.category == 'Residential'
                            ? 'No of Bedroom'
                            : 'No of Cabine',
                      ),
                      MyIcon(Icons.bathtub_rounded,
                          model.noOfBathRoom.toString(), 'No of Bathroom'),
                      MyIcon(
                        Icons.fastfood_sharp,
                        model.noOfKitchen.toString(),
                        model.category == 'Residential'
                            ? 'No of Kitchen'
                            : 'No of mess',
                      ),
                      MyIcon(Icons.elevator_rounded, model.noOfFloor.toString(),
                          'No of Floor'),
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_size_select_small_sharp,
                              color: Colors.pink,
                              size: 25,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Length ${model.length} ft. & Width ${model.breath} ft.',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  '${model.sqft} sq. ft. ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      AvaliableWidget(
                        name: 'Attached Bathroom',
                        value: model.attachedBathRoom,
                      ),
                      AvaliableWidget(
                        name: 'Parking',
                        value: model.parking,
                      ),
                    ],
                  ),
                  'Approved Documnets'.text.xl2.make().p12(),
                  Container(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: model.approvedDoc.length,
                      itemBuilder: (context, index) =>
                          AvaliableWidget(name: model.approvedDoc[index]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, StepperDemo.routeName,
                          arguments: model);
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.shopping_bag_rounded),
                            color: Colors.pink,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, StepperDemo.routeName,
                                  arguments: model);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Column(
                            children: [
                              Text(
                                'Book The Model',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(model.des),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
