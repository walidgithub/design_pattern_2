import 'package:design_pattern/design_pattern/structural/facade/smarthome_state.dart';

import '../apis/camera_api.dart';
import '../apis/playstation_api.dart';



class GamingFacade {
  final PlaystationApi _playstationApi = PlaystationApi();
  final CameraApi _cameraApi = CameraApi();

  void startGaming(SmartHomeState smartHomeState) {
    smartHomeState.gamingConsoleOn = _playstationApi.turnOn();
  }

  void stopGaming(SmartHomeState smartHomeState) {
    smartHomeState.gamingConsoleOn = _playstationApi.turnOff();
  }

  void startStreaming(SmartHomeState smartHomeState) {
    smartHomeState.streamingCameraOn = _cameraApi.turnCameraOn();
    startGaming(smartHomeState);
  }

  void stopStreaming(SmartHomeState smartHomeState) {
    smartHomeState.streamingCameraOn = _cameraApi.turnCameraOff();
    stopGaming(smartHomeState);
  }
}