// // class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

// // class MockHttpClient extends Mock implements http.Client {}

// // void main() {
// //   group('APIService', () {
// //     late APIService apiService;
// //     late MockFlutterSecureStorage mockStorage;
// //     late MockHttpClient mockHttpClient;

// //     setUp(() {
// //       mockStorage = MockFlutterSecureStorage();
// //       mockHttpClient = MockHttpClient();
// //       apiService = APIService();

// //     });

// //     test('GetAPIToken - Success', () async {
// //       // Mocking FlutterSecureStorage response
// //       when(mockStorage.read(key: 'Secret'))
// //           .thenAnswer((_) => Future.value('your_secret'));

// //       // Mocking HTTP response
// //       when(mockHttpClient.get(any))
// //           .thenAnswer((_) async => http.Response('your_response', 200));

// //       apiService.GetAPIToken(mockStorage, User(uid: 'your_uid'));

// //       // You can add assertions based on your expected behavior
// //     });

// //     test('GetAPIToken - Failure', () async {
// //       // Mocking FlutterSecureStorage response
// //       when(mockStorage.read(key: 'Secret'))
// //           .thenAnswer((_) => Future.value('your_secret'));

// //       // Mocking HTTP response
// //       when(mockHttpClient.get(any))
// //           .thenAnswer((_) async => http.Response('error_response', 500));

// //       apiService.GetAPIToken(mockStorage, User(uid: 'your_uid'));

// //       // You can add assertions based on your expected behavior
// //     });

// //     // Add more tests for other methods as needed

// //     tearDown(() {
// //       // Reset mock interactions
// //       reset(mockStorage);
// //       reset(mockHttpClient);
// //     });
// //   });
// // }

// import 'dart:convert';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:mockito/mockito.dart';
// import 'package:svendeproeve_klatreapp/models/grips_model.dart';
// import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

// class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

// class MockClient extends Mock implements http.Client {}

// void main() {
//   const String _baseUrlLocal = 'https://10.0.2.2:7239/';

//   group('APIService Tests', () {
//     test('getAllGrips - Successful response', () async {
//       // Mock FlutterSecureStorage and http.Client
//       final storage = MockFlutterSecureStorage();
//       final client = MockClient();
//       final apiService = APIService();

//       // Mock a successful http response with multiple grips
//       when(client.get(
//         Uri.parse('${_baseUrlLocal}Grips/GetGrips'),
//         headers: anyNamed('headers'),
//       )).thenAnswer((_) async => http.Response(
//           jsonEncode([
//             {
//               "description":
//                   "Crimps is the perfect grip for holding onto small edges and holds...",
//               "image_Location":
//                   "https://www.99boulders.com/wp-content/uploads/2018/02/crimp-climbing-hold.png",
//               "name": "Crimps"
//             },
//             {
//               "description": "Jugs are a firm favourite amongst climbers...",
//               "image_Location":
//                   "https://static.wixstatic.com/media/003ebe_868ef5895e9647f78e1e816043d8da40~mv2.jpeg/v1/fill/w_640,h_640,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/003ebe_868ef5895e9647f78e1e816043d8da40~mv2.jpeg",
//               "name": "Jugs"
//             },
//             // Add more grips as needed
//           ]),
//           200));

//       // Mock the token read from storage
//       when(storage.read(key: 'Token')).thenAnswer((_) async => 'mocked_token');

//       // Set up the GripsModel instances you expect in the response
//       final expectedGrips = [
//         GripsModel(
//             gripImg: '',
//             gripName: 'Crimps',
//             gripDescription:
//                 'Crimps is the perfect grip for holding onto small edges and holds...'),
//         GripsModel(
//             gripImg: '',
//             gripName: 'Jugs',
//             gripDescription: 'Jugs are a firm favourite amongst climbers...'),
//         // Add more GripsModel instances as needed
//       ];

//       // Call the method under test
//       final result = await apiService.getAllGrips();

//       // Verify that the correct URL and headers were used
//       verify(client.get(
//         Uri.parse('${_baseUrlLocal}Grips/GetGrips'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer mocked_token',
//         },
//       ));

//       // Verify that the expected GripsModel instances are in the result
//       expect(result, expectedGrips);
//     });

//     // Add more tests for different scenarios
//   });
// }
