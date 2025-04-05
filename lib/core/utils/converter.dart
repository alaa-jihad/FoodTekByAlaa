import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class Converter {
  static Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
    String assetName, [
    ui.Size size = const ui.Size(24, 24),
  ]) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);

    double devicePixelRatio =
        ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
    int width = (size.width * devicePixelRatio).toInt();
    int height = (size.height * devicePixelRatio).toInt();

    final scaleFactor = min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );

    final recorder = ui.PictureRecorder();

    ui.Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);

    final rasterPicture = recorder.endRecording();

    final image = rasterPicture.toImageSync(width, height);
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  static double? convertToDouble(var value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.parse(value);
    } else {
      return null;
    }
  }

  static Future<http.Response> convertStreamedResponse({
    required http.StreamedResponse streamedResponse,
  }) async {
    // Read the response stream and collect the data
    final responseBytes = await streamedResponse.stream.toBytes();

    // Create a new Response object with the collected data
    return http.Response.bytes(
      responseBytes,
      streamedResponse.statusCode,
      request: streamedResponse.request,
      headers: streamedResponse.headers,
      isRedirect: streamedResponse.isRedirect,
      persistentConnection: streamedResponse.persistentConnection,
      reasonPhrase: streamedResponse.reasonPhrase,
    );
  }

  static Future<File> saveUint8ListToFile({
    required Uint8List data,
    required String filename,
  }) async {
    // Get the temporary directory
    final directory = await getTemporaryDirectory();

    // Create a File object with the desired file path
    final file = File('${directory.path}/$filename');

    // Write the Uint8List data to the file
    await file.writeAsBytes(data);

    // Return the file
    return file;
  }

  static String formatDate(String date) {
    return DateFormat('yyyy/MM/dd').format(DateTime.parse(date));
  }

  static String formatTime(String time) {
    return DateFormat('hh:mm a').format(DateTime.parse(time));
  }

  static String formatDateTime(String dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.parse(dateTime));
  }

  static String formatDateTimeWithoutLine(String dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.parse(dateTime));
  }

  static String? differentBetweenCurrentDateTimeAndGivenDateTime({
    required String dateTime,
  }) {
    try {
      DateTime slaDate = DateTime.parse(dateTime);
      DateTime currentDate = DateTime.now();

      Duration remainingTime = slaDate.difference(currentDate);
      int remainingHours = remainingTime.inHours;
      if (remainingHours < 0) {
        remainingHours = 0;
      }
      return remainingHours.toString();
    } catch (error) {
      return null;
    }
  }
}
