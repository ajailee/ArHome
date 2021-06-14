import 'package:aj_ar/Model/BuilderModel.dart';
import 'package:aj_ar/Provider/BuilderProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BuildersPage.dart';

class BuilderScreen extends StatefulWidget {
  static String routeName = '/search';
  @override
  _BuilderScreenState createState() => _BuilderScreenState();
}

class _BuilderScreenState extends State<BuilderScreen> {
  bool _isLoading = false;
  bool _isInit = true;
  ScrollController _controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  @override
  Future<void> didChangeDependencies() async {
    setState(() {
      _isLoading = true;
    });
    if (_isInit)
      await Provider.of<BuilderProvider>(context).getFullBuilderList();
    setState(() {
      _isLoading = false;
    });
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller.addListener(() {
      double value = _controller.offset / 199;
      setState(() {
        topContainer = value;
        closeTopContainer = _controller.offset > 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<BuilderModel> _list =
        Provider.of<BuilderProvider>(context).builderList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Builders',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: size.height,
              child: RefreshIndicator(
                onRefresh:
                    Provider.of<BuilderProvider>(context).refreshFullList,
                child: ListView.builder(
                  controller: _controller,
                  physics: BouncingScrollPhysics(),
                  itemCount: _list == null ? 0 : _list.length,
                  itemBuilder: (context, index) {
                    double scale = 1.0;
                    if (topContainer > 0.5) {
                      scale = index + 0.5 - topContainer;
                      if (scale < 0) {
                        scale = 0;
                      } else if (scale > 1) {
                        scale = 1;
                      }
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, BuildersPage.routeName,
                            arguments: _list[index].id);
                      },
                      child: Opacity(
                        opacity: scale,
                        child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()..scale(scale, scale),
                          child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor: .70,
                            child: Container(
                                height: 150,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withAlpha(100),
                                          blurRadius: 10.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _list[index].name,
                                            style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Id: ' + _list[index].id,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'no.of projects done: ' +
                                                _list[index]
                                                    .noOfProjects
                                                    .toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                          _list[index].imageUrl,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                    // return ListTile(
                    //   title: Text(_list[index].name),
                    //   trailing: Image.network(
                    //       'https://acropolis-wp-content-uploads.s3.us-west-1.amazonaws.com/how-to-start-a-construction-company-hero.png'),
                    // );
                  },
                ),
              ),
            ),
    );
  }
}
