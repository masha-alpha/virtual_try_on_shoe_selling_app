import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;


class Custom3dObjectScreen extends StatefulWidget
{
  const Custom3dObjectScreen({super.key});

  @override
  State<Custom3dObjectScreen> createState() => _Custom3dObjectScreenState();
}



class _Custom3dObjectScreenState extends State<Custom3dObjectScreen>
{
  ARSessionManager? sessionManager;
  ARObjectManager? objectManager;
  ARAnchorManager? anchorManager;

  List<ARNode> allNodes = [];
  List<ARAnchor> allAnchor = [];

  whenARViewCreated(ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager)
  {
    sessionManager = arSessionManager;
    objectManager = arObjectManager;
    anchorManager = arAnchorManager;

    sessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: true,
      handlePans: true,
      handleRotation: true,
    );
    objectManager!.onInitialize();

    sessionManager!.onPlaneOrPointTap = whenPlaneDetectedAndUserTapped;
    objectManager!.onPanStart = whenOnPanStarted;
    objectManager!.onPanChange = whenOnPanChanged;
    objectManager!.onPanEnd = whenOnPanEnded;
    objectManager!.onRotationStart = whenOnRotationStarted;
    objectManager!.onRotationChange = whenOnRotationChanged;
    objectManager!.onRotationEnd = whenOnRotationEnded;
  }

  whenOnPanStarted(String node3dObjectName)
  {
    print("Started Panning Node = " + node3dObjectName);
  }

  whenOnPanChanged(String node3dObjectName)
  {
    print("Continued Panning Node = " + node3dObjectName);
  }

  whenOnPanEnded(String node3dObjectName, Matrix4 transform)
  {
    print("Ended Panning Node = " + node3dObjectName);

    final pannedNode = allNodes.firstWhere((node) => node.name == node3dObjectName);
  }

  whenOnRotationStarted(String node3dObjectName)
  {
    print("Started Rotating Node = " + node3dObjectName);
  }

  whenOnRotationChanged(String node3dObjectName)
  {
    print("Continued Rotating Node = " + node3dObjectName);
  }

  whenOnRotationEnded(String node3dObjectName, Matrix4 transform)
  {
    print("Ended Rotating Node = " + node3dObjectName);

    final pannedNode = allNodes.firstWhere((node) => node.name == node3dObjectName);
  }

  Future<void> whenPlaneDetectedAndUserTapped(List<ARHitTestResult> tapResults) async
  {
    var userHitTestResult = tapResults.firstWhere((userTap) => userTap.type == ARHitTestResultType.plane);

    if(userHitTestResult != null)
    {
      //new anchor
      var newPlaneARAnchor = ARPlaneAnchor(transformation: userHitTestResult.worldTransform);

      bool? isAnchorAdded = await anchorManager!.addAnchor(newPlaneARAnchor);

      if(isAnchorAdded!)
      {
        allAnchor.add(newPlaneARAnchor);

        //new node
        var nodeNew3dObject = ARNode(
          type: NodeType.webGLB, //.glb 3d model //size upto 30MB or lower than 30
          uri: "https://firebasestorage.googleapis.com/v0/b/fitstudio-a439e.appspot.com/o/scaled.glb?alt=media&token=1c45448b-2c89-4a75-a0a5-130e54f2c274",
          scale: vector64.Vector3(0.8, 0.8, 0.8),
          position: vector64.Vector3(0, 0, 0),
          rotation: vector64.Vector4(1.0, 0, 0, 0),
        );

        bool? isNewNodeAddedToNewAnchor = await objectManager!.addNode(nodeNew3dObject, planeAnchor: newPlaneARAnchor);

        if(isNewNodeAddedToNewAnchor!)
        {
          allNodes.add(nodeNew3dObject);
        }
        else
        {
          sessionManager!.onError("Attaching Node to Anchor Failed.");
        }
      }
      else
      {
        sessionManager!.onError("Adding Anchor Failed.");
      }
    }
  }

  Future<void> removeEveryObject() async
  {
    allAnchor.forEach((eachAnchor)
    {
      anchorManager!.removeAnchor(eachAnchor);
    });

    allAnchor = [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    sessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Virtual Try-on"
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Stack(
          children: [
            ARView(
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
              onARViewCreated: whenARViewCreated,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Align(
                alignment: FractionalOffset.bottomRight,
                child: ElevatedButton(
                  onPressed: ()
                  {
                    removeEveryObject();
                  },
                  
                  child: Text(
                    "Remove",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
