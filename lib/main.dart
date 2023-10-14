import 'package:afshon_ar/presentation/main/presentation/pages/home_screen.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  // print("AR Core is Available?");
  // print(await ArCoreController.checkArCoreAvailability());
  // print("\n AR Services Installed?");
  // print(await ArCoreController.checkIsArCoreInstalled());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ArCoreController arCoreController;
  Map<int, ArCoreAugmentedImage> augmentedImagesMap = Map();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ArCoreView(
        onArCoreViewCreated: whenArCoreViewCreated2,
        // type: ArCoreViewType.AUGMENTEDIMAGES,
        enableTapRecognizer: true,
      ),
    );
  }

  void whenArCoreViewCreated2(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onPlaneTap = handleOnTapPlane;
  }

  void handleOnTapPlane(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    final node = ArCoreReferenceNode(
      name: 'tish.glb',
      object3DFileName: 'tish.glb',
      position: hit.pose.translation,
      rotation: hit.pose.rotation,
    );

    arCoreController.addArCoreNodeWithAnchor(node);
  }

  loadSingleImage() async {
    final ByteData byteData = await rootBundle.load("assets/ear.jpg");

    arCoreController.loadSingleAugmentedImage(
        bytes: byteData.buffer.asUint8List());
  }

  void whenArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    arCoreController.onTrackingImage = controlOnTrackingImage;

    // load Single Image

    loadSingleImage();
  }

  controlOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    if (!augmentedImagesMap.containsKey(augmentedImage.index)) {
      augmentedImagesMap[augmentedImage.index] = augmentedImage;

      addCube(arCoreController, augmentedImage);
    }
  }

  Future addCube(ArCoreController arCoreController,
      ArCoreAugmentedImage augmentedImage) async {
    // final materials = ArCoreMaterial(color: Colors.green, metallic: 1.0);
    //
    // final cube =
    //     ArCoreCube(size: vector.Vector3(0.1, 0.1, 0.1), materials: [materials]);

    // final node = ArCoreNode(shape: cube);
    final node = ArCoreReferenceNode(
        objectUrl:
            "https://65294282fcf08434c514843d--sunny-sunburst-b21cdc.netlify.app/assets/tish.glb");

    arCoreController.addArCoreNodeToAugmentedImage(node, augmentedImage.index);
    // arCoreController.addArCoreNode(node);
  }
}

class ModelViewScreen extends StatefulWidget {
  const ModelViewScreen({Key? key}) : super(key: key);

  @override
  State<ModelViewScreen> createState() => _ModelViewScreenState();
}

class _ModelViewScreenState extends State<ModelViewScreen> {
  Future<void> _launchARView(String modelUrl) async {
    final String encodedModelUrl = Uri.encodeComponent(modelUrl);
    final String arUrl =
        'https://arvr.google.com/scene-viewer/1.0?file=$encodedModelUrl&mode=ar_preferred';

    if (!await launchUrl(Uri.parse(arUrl))) {
      print("can not launch");
    }
  }

  final String url =
      "https://modelviewer.dev/shared-assets/models/Astronaut.glb";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Model Viewer'), actions: [
        ElevatedButton(onPressed: () => _launchARView(url), child: Text("OPEN"))
      ]),
      body: const ModelViewer(
        backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
        src: 'assets/yurak.glb',
        alt: 'A 3D model of an astronaut',
        ar: true,
        arScale: ArScale.fixed,
        arPlacement: ArPlacement.floor,
        autoRotate: true,
        iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
        disableZoom: true,
      ),
    );
  }
}
