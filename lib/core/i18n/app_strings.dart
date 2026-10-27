import 'package:flutter/widgets.dart';

/// Translations for the kiosk's user-facing text.
/// English keys are used as the source strings and fallback language.
class AppStrings {
  static const Map<String, Map<String, String>> _translations = {
    'Admin Settings': {'hi': 'एडमिन सेटिंग्स', 'gu': 'એડમિન સેટિંગ્સ'},
    'Appearance': {'hi': 'दिखावट', 'gu': 'દેખાવ'},
    'Dark Mode': {'hi': 'डार्क मोड', 'gu': 'ડાર્ક મોડ'},
    'Toggle between light and dark theme': {
      'hi': 'लाइट और डार्क थीम के बीच बदलें',
      'gu': 'લાઇટ અને ડાર્ક થીમ વચ્ચે બદલો',
    },
    'Localization': {'hi': 'भाषा', 'gu': 'ભાષા'},
    'Kiosk Language': {'hi': 'कियोस्क की भाषा', 'gu': 'કિઓસ્કની ભાષા'},
    'Select the default language': {
      'hi': 'डिफ़ॉल्ट भाषा चुनें',
      'gu': 'ડિફૉલ્ટ ભાષા પસંદ કરો',
    },
    'Branding (Brand Color)': {'hi': 'ब्रांड रंग', 'gu': 'બ્રાન્ડ રંગ'},
    'Select Brand Color': {
      'hi': 'ब्रांड का रंग चुनें',
      'gu': 'બ્રાન્ડનો રંગ પસંદ કરો',
    },
    'Select color shade': {
      'hi': 'रंग की छाया चुनें',
      'gu': 'રંગની છાયા પસંદ કરો',
    },
    'Select Host': {'hi': 'होस्ट चुनें', 'gu': 'હોસ્ટ પસંદ કરો'},
    'Search by name or department...': {
      'hi': 'नाम या विभाग से खोजें...',
      'gu': 'નામ અથવા વિભાગથી શોધો...',
    },
    'No Data Found': {
      'hi': 'कोई जानकारी नहीं मिली',
      'gu': 'કોઈ માહિતી મળી નથી',
    },
    'Something went wrong': {'hi': 'कुछ गलत हुआ', 'gu': 'કંઈક ખોટું થયું'},
    'Retry': {'hi': 'फिर से कोशिश करें', 'gu': 'ફરી પ્રયાસ કરો'},
    'Visitor Check-in': {'hi': 'विज़िटर चेक-इन', 'gu': 'મુલાકાતી ચેક-ઇન'},
    'Start Visitor Check-in': {
      'hi': 'विज़िटर चेक-इन शुरू करें',
      'gu': 'મુલાકાતી ચેક-ઇન શરૂ કરો',
    },
    "Today's Visitors": {'hi': 'आज के विज़िटर', 'gu': 'આજના મુલાકાતીઓ'},
    "Open Today's Visitors Log": {
      'hi': 'आज के विज़िटर रिकॉर्ड खोलें',
      'gu': 'આજના મુલાકાતીઓની યાદી ખોલો',
    },
    "Today's Visitor Logs": {
      'hi': 'आज के विज़िटर रिकॉर्ड',
      'gu': 'આજના મુલાકાતીઓના રેકોર્ડ',
    },
    'All': {'hi': 'सभी', 'gu': 'બધા'},
    'Checked In': {'hi': 'चेक-इन किया', 'gu': 'ચેક-ઇન થયા'},
    'Checked Out': {'hi': 'चेक-आउट किया', 'gu': 'ચેક-આઉટ થયા'},
    'Expected': {'hi': 'अपेक्षित', 'gu': 'અપેક્ષિત'},
    'Just now': {'hi': 'अभी', 'gu': 'હમણાં'},
    'Meeting: Host {host}\nPurpose: {purpose}': {
      'hi': 'मुलाक़ात: होस्ट {host}\nकारण: {purpose}',
      'gu': 'મુલાકાત: હોસ્ટ {host}\nહેતુ: {purpose}',
    },
    'Digital Badge': {'hi': 'डिजिटल बैज', 'gu': 'ડિજિટલ બેજ'},
    'Badge identifier unavailable. Please contact reception.': {
      'hi': 'बैज पहचान उपलब्ध नहीं है। कृपया रिसेप्शन से संपर्क करें।',
      'gu': 'બેજ ઓળખ ઉપલબ્ધ નથી. કૃપા કરીને રિસેપ્શનનો સંપર્ક કરો.',
    },
    'Check-in Successful!': {'hi': 'चेक-इन सफल हुआ!', 'gu': 'ચેક-ઇન સફળ થયું!'},
    'Visitor': {'hi': 'विज़िटर', 'gu': 'મુલાકાતી'},
    'Please scan this badge at the exit.': {
      'hi': 'कृपया बाहर जाते समय यह बैज स्कैन करें।',
      'gu': 'કૃપા કરીને બહાર નીકળતી વખતે આ બેજ સ્કેન કરો.',
    },
    'Return to Home': {'hi': 'होम पर लौटें', 'gu': 'હોમ પર પાછા જાઓ'},
    'Retake Photo': {'hi': 'फोटो दोबारा लें', 'gu': 'ફરી ફોટો લો'},
    'Take Photo': {'hi': 'फोटो लें', 'gu': 'ફોટો લો'},
    'Camera access was denied. Please allow camera permission to take a visitor photo.':
        {
          'hi': 'विज़िटर की फोटो लेने के लिए कैमरा अनुमति दें।',
          'gu': 'મુલાકાતીનો ફોટો લેવા માટે કેમેરાની પરવાનગી આપો.',
        },
    'Camera access is blocked. Open app settings to allow camera access.': {
      'hi': 'कैमरा बंद है। कैमरा अनुमति देने के लिए ऐप सेटिंग्स खोलें।',
      'gu': 'કેમેરા ઍક્સેસ બંધ છે. પરવાનગી આપવા માટે ઍપ સેટિંગ્સ ખોલો.',
    },
    'Camera is not available on this device.': {
      'hi': 'इस डिवाइस पर कैमरा उपलब्ध नहीं है।',
      'gu': 'આ ડિવાઇસ પર કેમેરા ઉપલબ્ધ નથી.',
    },
    'Camera failed to start. Please try again.': {
      'hi': 'कैमरा शुरू नहीं हो सका। फिर से कोशिश करें।',
      'gu': 'કેમેરા શરૂ થઈ શક્યો નથી. ફરી પ્રયાસ કરો.',
    },
    'Open Settings': {'hi': 'सेटिंग्स खोलें', 'gu': 'સેટિંગ્સ ખોલો'},
    'Please accept the consent terms.': {
      'hi': 'कृपया सहमति की शर्तें स्वीकार करें।',
      'gu': 'કૃપા કરીને સંમતિની શરતો સ્વીકારો.',
    },
    'Please take a photo.': {
      'hi': 'कृपया फोटो लें।',
      'gu': 'કૃપા કરીને ફોટો લો.',
    },
    'Meeting with: {host}': {
      'hi': 'मुलाक़ात: {host}',
      'gu': 'મુલાકાત: {host} સાથે',
    },
    'Full Name': {'hi': 'पूरा नाम', 'gu': 'પૂરું નામ'},
    'Email Address': {'hi': 'ईमेल पता', 'gu': 'ઈમેલ સરનામું'},
    'Mobile Number (10 digits)': {
      'hi': 'मोबाइल नंबर (10 अंक)',
      'gu': 'મોબાઇલ નંબર (10 અંક)',
    },
    'e.g. 9876543210': {'hi': 'उदा. 9876543210', 'gu': 'દા.ત. 9876543210'},
    'Purpose of Visit': {'hi': 'आने का कारण', 'gu': 'આવવાનું કારણ'},
    'I agree to the non-disclosure agreement and security policies of Naapbooks Limited.':
        {
          'hi': 'मैं Naapbooks Limited के गोपनीयता समझौते और सुरक्षा नीतियों से सहमत हूँ।',
          'gu': 'હું Naapbooks Limitedના ગુપ્તતા કરાર અને સુરક્ષા નીતિઓ સાથે સંમત છું.',
        },
    'Submit & Check-in': {
      'hi': 'जमा करें और चेक-इन करें',
      'gu': 'સબમિટ કરો અને ચેક-ઇન કરો',
    },
    'Please enter your name': {
      'hi': 'कृपया अपना नाम दर्ज करें',
      'gu': 'કૃપા કરીને તમારું નામ લખો',
    },
    'Name is too short': {'hi': 'नाम बहुत छोटा है', 'gu': 'નામ બહુ ટૂંકું છે'},
    'Please enter email': {
      'hi': 'कृपया ईमेल दर्ज करें',
      'gu': 'કૃપા કરીને ઈમેલ લખો',
    },
    'Please enter a valid email': {
      'hi': 'कृपया सही ईमेल दर्ज करें',
      'gu': 'કૃપા કરીને માન્ય ઈમેલ લખો',
    },
    'Please enter mobile number': {
      'hi': 'कृपया मोबाइल नंबर दर्ज करें',
      'gu': 'કૃપા કરીને મોબાઇલ નંબર લખો',
    },
    'Enter a valid 10-digit Indian mobile number (starts with 6-9)': {
      'hi':
          '6-9 से शुरू होने वाला सही 10 अंकों का भारतीय मोबाइल नंबर दर्ज करें',
      'gu': '6-9થી શરૂ થતો માન્ય 10 અંકનો ભારતીય મોબાઇલ નંબર લખો',
    },
    'Meeting': {'hi': 'बैठक', 'gu': 'મીટિંગ'},
    'Interview': {'hi': 'साक्षात्कार', 'gu': 'ઇન્ટરવ્યૂ'},
    'Delivery': {'hi': 'डिलीवरी', 'gu': 'ડિલિવરી'},
    'Vendor / Contractor': {
      'hi': 'विक्रेता / ठेकेदार',
      'gu': 'વિક્રેતા / કોન્ટ્રાક્ટર',
    },
    'Maintenance': {'hi': 'रखरखाव', 'gu': 'જાળવણી'},
    'Personal': {'hi': 'निजी', 'gu': 'અંગત'},
    'Check-in failed. Please check network connection.': {
      'hi': 'चेक-इन विफल हुआ। कृपया नेटवर्क कनेक्शन जाँचें।',
      'gu': 'ચેક-ઇન નિષ્ફળ થયું. કૃપા કરીને નેટવર્ક કનેક્શન તપાસો.',
    },
    'Connection timed out. Please check your internet connection and try again.':
        {
          'hi': 'कनेक्शन का समय समाप्त हुआ। इंटरनेट जाँचकर फिर कोशिश करें।',
          'gu': 'કનેક્શનનો સમય પૂરો થયો. ઇન્ટરનેટ તપાસીને ફરી પ્રયાસ કરો.',
        },
    'Bad request. Please check your inputs.': {
      'hi': 'अनुरोध सही नहीं है। कृपया दर्ज की गई जानकारी जाँचें।',
      'gu': 'વિનંતી યોગ્ય નથી. દાખલ કરેલી માહિતી તપાસો.',
    },
    'Unauthorized. Please login again.': {
      'hi': 'अनुमति नहीं मिली। कृपया फिर से लॉगिन करें।',
      'gu': 'પરવાનગી મળી નથી. કૃપા કરીને ફરી લૉગિન કરો.',
    },
    'Forbidden. You do not have permission.': {
      'hi': 'आपको इसकी अनुमति नहीं है।',
      'gu': 'તમને આ કરવાની પરવાનગી નથી.',
    },
    'Resource not found.': {
      'hi': 'जानकारी नहीं मिली।',
      'gu': 'માહિતી મળી નથી.',
    },
    'Internal server error. Please try again later.': {
      'hi': 'सर्वर में समस्या है। कृपया बाद में कोशिश करें।',
      'gu': 'સર્વરમાં સમસ્યા છે. કૃપા કરીને પછી ફરી પ્રયાસ કરો.',
    },
    'Request to API server was cancelled': {
      'hi': 'सर्वर अनुरोध रद्द किया गया।',
      'gu': 'સર્વર વિનંતી રદ કરવામાં આવી.',
    },
    'API server is unreachable. Check that it is running and the address is correct.':
        {
          'hi': 'API सर्वर उपलब्ध नहीं है। जाँचें कि सर्वर चल रहा है और पता सही है।',
          'gu': 'API સર્વર ઉપલબ્ધ નથી. સર્વર ચાલુ છે અને સરનામું સાચું છે તે તપાસો.',
        },
    'No internet connection or server is unreachable.': {
      'hi': 'इंटरनेट नहीं है या सर्वर उपलब्ध नहीं है।',
      'gu': 'ઇન્ટરનેટ નથી અથવા સર્વર ઉપલબ્ધ નથી.',
    },
    'Unexpected error occurred. Please try again.': {
      'hi': 'अनपेक्षित त्रुटि हुई। कृपया फिर कोशिश करें।',
      'gu': 'અનપેક્ષિત ભૂલ થઈ. કૃપા કરીને ફરી પ્રયાસ કરો.',
    },
    'Failed to load visitors. Please retry.': {
      'hi': 'विज़िटर लोड नहीं हो सके। कृपया फिर कोशिश करें।',
      'gu': 'મુલાકાતીઓ લોડ થઈ શક્યા નથી. ફરી પ્રયાસ કરો.',
    },
  };

  static String translate(
    BuildContext context,
    String source, [
    Map<String, String> arguments = const {},
  ]) {
    final languageCode = Localizations.localeOf(context).languageCode;
    var result = _translations[source]?[languageCode] ?? source;
    for (final argument in arguments.entries) {
      result = result.replaceAll('{${argument.key}}', argument.value);
    }
    return result;
  }
}

extension AppStringTranslation on String {
  String tr(BuildContext context, [Map<String, String> arguments = const {}]) =>
      AppStrings.translate(context, this, arguments);
}
