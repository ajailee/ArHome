import 'package:aj_ar/Theme/MyThem.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class TransformableNodeScreen extends StatefulWidget {
  static String routeName = '/transform';
  @override
  _TransformableNodeState createState() => _TransformableNodeState();
}

class _TransformableNodeState extends State<TransformableNodeScreen> {
  ArCoreController arCoreController;
  int _scale = 100;
  String selectedNode;
  Map<String, dynamic> link;
  bool _isDownloading = false;
  String selectedLink;
  bool _isLocked = false;
  final nodesMap = <String, ArCoreNode>{};
  @override
  Widget build(BuildContext context) {
    link = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          textTheme: MyTheme.lightTheme.textTheme,
          backgroundColor: Colors.black,
          title: _isDownloading
              ? Text(
                  'Loading Ar ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  selectedNode ?? '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext bc) {
                return link.keys
                    .map((day) => PopupMenuItem(
                          child: Text(day),
                          value: link[day],
                        ))
                    .toList();
              },
              onSelected: (value) {
                selectedLink = value;
                setState(() {});
              },
            ),
            IconButton(
              icon: _isLocked ? Icon(Icons.lock) : Icon(Icons.lock_open),
              onPressed: () {
                setState(() {
                  _isLocked = !_isLocked;
                });
              },
            ),
            if (selectedNode != null)
              IconButton(
                icon: Icon(Icons.photo_size_select_small),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            child: SingleCircularSlider(
                              200,
                              _scale,
                              child: Text(
                                _scale.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              showHandlerOutter: true,
                              onSelectionChange: (a, b, c) {
                                setState(() {
                                  _scale = b;
                                });
                              },
                              onSelectionEnd: (a, b, c) {
                                final value = b == 0 ? 0.1 : b / 100;
                                if (nodesMap.containsKey(selectedNode)) {
                                  final node = nodesMap[selectedNode];
                                  node.changeScale(
                                      vector.Vector3(value, value, value));
                                  Navigator.pop(context, true);
                                  setState(() {});
                                }
                              },
                            ),
                            color: Colors.black,
                          ),
                        );
                      });
                },
              ),
          ],
        ),
        body: IgnorePointer(
          ignoring: _isLocked,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ArCoreView(
                onArCoreViewCreated: _onArCoreViewCreated,
                enablePlaneRenderer: true,
                enableTapRecognizer: true,
                enableUpdateListener: true,
                debug: true,
              ),
              if (_isDownloading)
                AlertDialog(
                  content: Text(
                    'Your Object is Downloading Please wait',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onPlaneTap = _handleOnPlaneTap;
    arCoreController.onNodeTap = (node) {
      print('TransformableNodeScreen: onNodeTap $node');
      setState(() {
        selectedNode = node;
      });
    };
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addToucano(hit);
  }

  Future<void> _addToucano(ArCoreHitTestResult plane) async {
    if (_isDownloading) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text(
            'Your Object is Downloading Please wait',
          ),
        ),
      );
      return;
    }
    setState(() {
      _isDownloading = true;
    });
    var usdKey = link.keys.firstWhere((k) => link[k] == selectedLink,
        orElse: () => link.keys.first);

    final toucanNode = ArCoreReferenceNode(
        name: usdKey,
        objectUrl: selectedLink ?? link[link.keys.first],
        position: plane.pose.translation,
        rotation: plane.pose.rotation);
    if (nodesMap.containsKey(toucanNode.name)) {
      showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            setState(() {
              _isDownloading = false;
            });
            return AlertDialog(content: Text('You Already Placed This Object'));
          });
      return;
    }
    nodesMap[toucanNode.name] = toucanNode;

    await arCoreController.addArCoreNodeWithAnchor(toucanNode);

    setState(() {
      _isDownloading = false;
      selectedNode = usdKey;
    });
  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('onNodeTap on $name')),
    );
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
