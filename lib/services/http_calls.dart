import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpCalls {
 final String url = "https://api.paystack.co/bank/resolve_bvn/:";
 final String testSecretKey = 'sk_test_326221d896937e2ed99dd1f1b5f7938285e8b9f2';

  getRequest ({String bvn}) async {
    print(bvn.length.toString());
    var response = await http.get("https://api.paystack.co/bank/resolve_bvn/$bvn",
        headers: {"Authorization" : "Bearer sk_test_326221d896937e2ed99dd1f1b5f7938285e8b9f2",}
        );
    if(response.statusCode == 200) {
      var body = jsonDecode(response.body);
//      {status: true, message: BVN resolved,
//      data: {first_name: DAVID, last_name: MICHEAL, dob: 21-May-95,
//      formatted_dob: 1995-05-21, mobile: 08142*******, bvn: ********},
//      meta: {calls_this_month: 1, free_calls_left: 9}}
      return body['data'];
    }
  }


 sendMail ({String email}) async {
   var response = await http.get("https://us-central1-grasp-a4427.cloudfunctions.net/sendMailOverHTTP?dest=$email",);
 }
}


