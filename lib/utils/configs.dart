const String stationNameKey = 'stationName';
const String stationIdKey = 'stationId';
const String urlKey = 'tatsUrl';
const String durationKey = 'duration';

const String consumerKey = 'com.cloudtats.dashboard';
const String consumerSecret = 'GHj3UhLip501CDCa';

const String baseTatsUrl = 'http://192.168.100.2:8888';
// const String baseTatsUrl = 'https://tats.phan-tec.com';
// const String baseTatsUrl = 'http://etims.saharafcs.com';
// const String baseTatsUrl = 'https://tats-test.phan-tec.com';

// login
const String authUrl = '$baseTatsUrl/auth/token';

// signup
const String signupUrl = '$baseTatsUrl/signup';

// userInfo
const String userInfoUrl = '$baseTatsUrl/userInfo';

String fetchPumpsUrl(String stationName) => '$baseTatsUrl/stations/pumps/$stationName';
String postTransactionUrl(String transactionId) => '$baseTatsUrl/v3/transactions/$transactionId';
String fetchTransactionsUrl({
  required String stationId,
  required String pumpId,
  bool isPosted = false,
  DateTime? fromDate,
  DateTime? toDate,
}) =>
    '$baseTatsUrl/v3/transactions?automationDeviceId=$stationId&pumpAddress=$pumpId&isPosted=$isPosted${fromDate == null ? "" : "&fromDate=$fromDate"}${toDate == null ? "" : "&toDate=$toDate"}';
