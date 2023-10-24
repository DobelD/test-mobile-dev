import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraPageController extends GetxController {
  late CameraController cameraController;
  var isCameraInitialized = false.obs;
  var changeCamera = false;
  var flashCamera = false;
  XFile? imageFile;

  Future<void> initCamera(bool isFront) async {
    isCameraInitialized(true);
    update();
    final cameras = await availableCameras();

    CameraDescription? firstCamera;
    for (final camera in cameras) {
      if (camera.lensDirection ==
          (isFront ? CameraLensDirection.front : CameraLensDirection.back)) {
        firstCamera = camera;
        break;
      }
    }
    cameraController = CameraController(firstCamera!, ResolutionPreset.medium);
    await cameraController.initialize();
    await cameraController.startImageStream((CameraImage image) {
      // You can use the camera image stream for real-time image processing if needed.
    });
    isCameraInitialized(false);
    update();
  }

  switchCamera() {
    changeCamera = !changeCamera;
    update();
    if (changeCamera) {
      initCamera(true);
      update();
    } else {
      initCamera(false);
      update();
    }
  }

  togleFlashCamera() async {
    flashCamera = !flashCamera;
    update();
    if (flashCamera) {
      await cameraController.setFlashMode(FlashMode.torch);
      update();
    } else {
      await cameraController.setFlashMode(FlashMode.off);
      update();
    }
  }

  Future<void> captureImage() async {
    // ignore: unnecessary_null_comparison
    if (cameraController != null) {
      try {
        imageFile = await cameraController.takePicture();

        // Path gambar yang diambil
        final String imagePath = imageFile!.path;
        update();

        // Lakukan sesuatu dengan imagePath, misalnya menampilkan, menyimpan, atau mengirimnya ke server
        // Contoh: menampilkan path gambar
        print('Image captured: $imagePath');
      } catch (e) {
        print('Error taking picture: $e');
      }
    }
  }

  deletePreview() {
    imageFile = null;
    update();
  }

  @override
  void onInit() {
    initCamera(false);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    cameraController.dispose();
  }
}
