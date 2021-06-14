import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class ArScreen extends StatefulWidget {
  static String routeName = '/arScreen';
  @override
  _ArScreenState createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  ArCoreController arCoreController;
  bool _isDownloading = false;
  List<String> link;

  String objectSelected;

  @override
  Widget build(BuildContext context) {
    link = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Object on plane detected'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {});
              },
            )
          ],
        ),
        body: _isDownloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ArCoreView(
                enablePlaneRenderer: true,
                onArCoreViewCreated: _onArCoreViewCreated,
                enableTapRecognizer: true,
              ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void _addToucano(ArCoreHitTestResult plane) {
    setState(() {
      _isDownloading = true;
    });

    final toucanNode = ArCoreReferenceNode(
        name: "Toucano",
        objectUrl: link.first,
        //   "https://poly.googleusercontent.com/downloads/c/fp/1617116190444507/8L0cUhP3Xne/cO79STTi8Ta/model_New%20Qlone_20171023_184735172.gltf",
        //    "https://poly.googleusercontent.com/downloads/c/fp/1615814422773545/cH1j7_BN9wx/03AK0u13B-3/model.gltf",
        //    "https://poly.googleusercontent.com/downloads/c/fp/1621853194077590/bHyQe5jzdiQ/6vrI4luT8oi/FarmHouse.gltf", //working
        //   "https://ajax.googleapis.com/ajax/libs/threejs/r125/examples/js/loaders/GLTFLoader.js",
        //   "https://drive.google.com/file/d/1rszzywWmtmusEBysze1Mwao1hlpeT_QS/view",
        //    "https://raw.githubusercontent.com/ajailee/model/master/street/model.gltf",
        //    "https://raw.githubusercontent.com/ajailee/MyHome/main/assets/model/my.gltf",
        //  "https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/ToyCar/glTF/ToyCar.gltf",
        //  "https://poly.googleusercontent.com/downloads/c/fp/1622638281303021/b_UDhVGwfY8/bNoLD7xq3FU/SM_Fort.gltf",
        // "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf",
        position: plane.pose.translation,
        rotation: plane.pose.rotation);

    arCoreController.addArCoreNodeWithAnchor(toucanNode);
    setState(() {
      _isDownloading = false;
    });
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addToucano(hit);
  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Text('Remove $name?'),
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  arCoreController.removeNode(nodeName: name);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
