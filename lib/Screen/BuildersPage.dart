import 'package:aj_ar/Model/BuilderModel.dart';
import 'package:aj_ar/Provider/BuilderProvider.dart';
import 'package:aj_ar/Widget/TableText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart' as velocity;
import 'package:provider/provider.dart';

class BuildersPage extends StatefulWidget {
  static String routeName = '/buildersPage';
  @override
  _BuildersPageState createState() => _BuildersPageState();
}

class _BuildersPageState extends State<BuildersPage> {
  @override
  Widget build(BuildContext context) {
    String builderName = ModalRoute.of(context).settings.arguments;

    final builderProvider = Provider.of<BuilderProvider>(context);
    return Scaffold(
      body: FutureBuilder(
        future: builderProvider.getBuilderById(builderName),
        builder: (context, AsyncSnapshot<BuilderModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final builder = snapshot.data;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 500.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Image.network(
                        builder.imageUrl,
                        fit: BoxFit.cover,
                      )),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    velocity.VxTextBuilder('Company Info')
                        .extraBold
                        .green600
                        .xl4
                        .center
                        .make()
                        .p12(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                          border: TableBorder
                              .all(), // Allows to add a border decoration around your table
                          children: [
                            TableRow(children: [
                              TableText(
                                'Name',
                              ),
                              TableText(builder.name.toString()),
                            ]),
                            TableRow(children: [
                              TableText('Licenses Id'),
                              TableText(builder.licienceId.toString()),
                            ]),
                            TableRow(children: [
                              TableText('No of Branch'),
                              TableText(builder.noOfBranch.toString()),
                            ]),
                            TableRow(children: [
                              TableText('No of Architect'),
                              TableText(builder.noOfArchitect.toString()),
                            ]),
                            TableRow(children: [
                              TableText('No of Civil Engineer'),
                              TableText(builder.noOfArchitect.toString()),
                            ]),
                            TableRow(children: [
                              TableText('No of Architect'),
                              TableText(builder.noOfCivilEngineer.toString()),
                            ]),
                            TableRow(children: [
                              TableText('No of Employee'),
                              TableText(builder.noOfEmployee.toString()),
                            ]),
                            TableRow(children: [
                              TableText('Experience of Year'),
                              TableText(builder.experience.toString()),
                            ]),
                            TableRow(children: [
                              TableText('Supply Raw Material'),
                              TableText(
                                  builder.supplyRawMaterial ? 'YES' : 'NO'),
                            ]),
                            TableRow(children: [
                              TableText('Supply Labour'),
                              TableText(builder.supplyLabour ? 'YES' : 'NO'),
                            ]),
                          ]),
                    ),
                    velocity.VxTextBuilder('Branch Address')
                        .extraBold
                        .extraBlack
                        .xl4
                        .make()
                        .p12(),
                    velocity.VxTextBuilder('Swipe ->')
                        .gray700
                        .bold
                        .make()
                        .p12(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 100,
                      width: 100,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: builder.branch.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue[200],
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Branch No ${index + 1}'),
                                    Text(builder.branch[index])
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    velocity.VxTextBuilder('Project Info')
                        .extraBold
                        .green600
                        .xl4
                        .center
                        .make()
                        .p12(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          child: SingleCircularSlider(
                            builder.noOfProjects == 0
                                ? 1
                                : builder.noOfProjects,
                            builder.noOfProjects,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Total Of Projects'),
                                TableText(builder.noOfProjects.toString())
                              ],
                            )),
                            baseColor: Colors.red,
                            selectionColor: Colors.green,
                          ),
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          child: SingleCircularSlider(
                            builder.noOfProjects == 0
                                ? 1
                                : builder.noOfProjects,
                            builder.governmentTender.length,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Government\nProject',
                                  softWrap: true,
                                ),
                                TableText(
                                    builder.governmentTender.length.toString() +
                                        '/' +
                                        builder.noOfProjects.toString())
                              ],
                            )),
                            baseColor: Colors.red,
                            selectionColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    velocity.VxTextBuilder('Work Type Offered')
                        .extraBold
                        .green600
                        .xl4
                        .center
                        .make()
                        .p12(),
                    Container(
                        child: Icon(
                      Icons.construction,
                      size: 50,
                      color: Colors.amber,
                    )),
                    createTable(builder.workMode),
                    velocity.VxTextBuilder('Government Tenders')
                        .extraBold
                        .green600
                        .xl4
                        .center
                        .make()
                        .p12(),
                    Container(
                        child: Icon(
                      Icons.apartment_rounded,
                      size: 50,
                      color: Colors.amber,
                    )),
                    createTable(builder.governmentTender),
                    velocity.VxTextBuilder('Awards')
                        .extraBold
                        .green600
                        .xl4
                        .center
                        .make()
                        .p12(),
                    Container(
                        child: Icon(
                      Icons.military_tech_rounded,
                      size: 50,
                      color: Colors.amber,
                    )),
                    createTable(builder.awards),
                    TextButton(
                      child: Text('Look At The WebSite'),
                      onPressed: () {
                        _launchURL(builder.siteUrl);
                      },
                    )
                  ]),
                ),
              ],
              //snapshot.data.name),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget createTable(List<String> list) {
    List<TableRow> rows = [];
    for (int i = 0; i < list.length; i++) {
      rows.add(TableRow(children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Text(
            list[i],
            style: TextStyle(fontSize: 20),
          ),
        ),
      ]));
    }
    return Table(children: rows);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true); //forceWebView
    } else {
      throw 'Could not launch $url';
    }
  }
}
