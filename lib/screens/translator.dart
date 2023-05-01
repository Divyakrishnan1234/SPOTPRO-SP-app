String Translate(String text, String lang ){
  switch(text) {
    case "Notifications": {
      if(lang == 'ml')return "അറിയിപ്പുകൾ";
      else if (lang == 'hi') return "सूचनाएं";
      else return text;
    }
    break;

    case "Hi": {
      if(lang == 'ml')return "നമസ്ക്കാരം";
      else if (lang == 'hi') return "नमस्ते";
      else return text;
    }
    break;

    case "Profile": {
      if(lang == 'ml')return "പ്രൊഫൈൽ";
      else if (lang == 'hi') return "प्रोफ़ाइल";
      else return text;
    }
    break;

    case "Set your current location.": {
      if(lang == 'hi')return "अपना वर्तमान स्थान सेट करें.";
  else if (lang == 'ml') return "നിലവിലെ സ്ഥാനം സജ്ജമാക്കുക.";
  else return text;
  }
  break;

  case "Home" : {
  if(lang == 'ml')return "ഹോം";
  else if (lang == 'hi') return "होम";
  else return text;
  }
  break;

  case "Log Out" : {
  if(lang == 'ml')return "ലോഗ് ഔട്ട് ചെയ്യുക";
  else if (lang == 'hi') return " लॉग आउट";
  else return text;
  }
  break;

  case "AC Repair" : {
  if(lang == 'ml')return "എസി റിപ്പയർ";
  else if (lang == 'hi') return "एसी की मरम्मत";
  else return text;
  }
  break;

  case "Painter" : {
  if(lang == 'ml')return "ചിത്രകാരൻ";
  else if (lang == 'hi') return "चित्रकार";
  else return text;
  }
  break;

  case "Carpenter" : {
  if(lang == 'ml')return "ആശാരി";
  else if (lang == 'hi') return "बढ़ई";
  else return text;
  }
  break;

  case "Electrician" : {
  if(lang == 'ml')return "ഇലക്ട്രീഷ്യൻ";
  else if (lang == 'hi') return "इलेक्ट्रीशियन";
  else return text;
  }
  break;

  case "hr" : {
  if(lang == 'ml')return "മണിക്കൂർ";
  else if (lang == 'hi') return "घंटा";
  else return text;
  }
  break;

  case "Select Privacy Setting" : {
  if(lang == 'ml')return "സ്വകാര്യത ക്രമീകരണം തിരഞ്ഞെടുക്കുക";
  else if (lang == 'hi') return "गोपनीयता सेटिंग का चयन करें";
  else return text;
  }
  break;

  case "Chef" : {
  if(lang == 'ml')return "ഷെഫ്";
  else if (lang == 'hi') return "बावर्ची";
  else return text;
  }
  break;

  case "Public" : {
  if(lang == 'ml')return "പബ്ലിക് ";
  else if (lang == 'hi') return "पब्लिक";
  else return text;
  }
  break;

  case "On request" : {
  if(lang == 'ml')return "അഭ്യർത്ഥന പ്രകാരം";
  else if (lang == 'hi') return "निवेदन पर";
  else return text;
  }
  break;

  case "Message" : {
  if(lang == 'ml')return "മെസ്സേജ് ";
  else if (lang == 'hi') return "मैसेज";
  else return text;
  }
  break;

  case "Plumber" : {
  if(lang == 'ml')return "പ്ളംബര്";
  else if (lang == 'hi') return "प्लंबर";
  else return text;
  }
  break;

  case "Cleaning" : {
  if(lang == 'ml')return "വൃത്തിയാക്കൽ";
  else if (lang == 'hi') return "सफाई ";
  else return text;
  }
  break;

  case "Search for services..." : {
  if(lang == 'ml')return "സേവനങ്ങൾക്കായി തിരയുക";
  else if (lang == 'hi') return " सेवाओं की खोज करें ";
  else return text;
  }
  break;

  case "Accept" : {
  if(lang == 'ml')return "സ്വീകരിക്കുക";
  else if (lang == 'hi') return "स्वीकार ";
  else return text;
  }
  break;

  case "Reject" : {
  if(lang == 'ml')return "നിരസിക്കുക";
  else if (lang == 'hi') return "अस्वीकार ";
  else return text;
  }
  break;

  case "SpotPro" : {
  if(lang == 'ml')return "സ്പോട്ട് പ്രോ";
  else if (lang == 'hi') return "स्पॉट प्रो";
  else return text;
  }
  break;

  case "One step away" : {
  if(lang == 'ml')return "ഒരു പടി അകലെ";
  else if (lang == 'hi') return "एक कदम दूर ";
  else return text;
  }
  break;

  case "Continue" : {
  if(lang == 'ml')return "തുടരുക";
  else if (lang == 'hi') return "जारी रखना";
  else return text;
  }
  break;

  case "FullName" : {
  if(lang == 'ml')return "പേര്";
  else if (lang == 'hi') return "पूरा नाम ";
  else return text;
  }
  break;

  case "Location" : {
  if(lang == 'ml')return "സ്ഥലം";
  else if (lang == 'hi') return "स्थान ";
  else return text;
  }
  break;

  case "Job Category" : {
  if(lang == 'ml')return "തൊഴിൽ വിഭാഗം";
  else if (lang == 'hi') return "कार्य श्रेणी";
  else return text;
  }
  break;

  case "Job description" : {
  if(lang == 'ml')return "ജോലി വിവരണം";
  else if (lang == 'hi') return "कार्य विवरण";
  else return text;
  }
  break;

  case "Rate per hour" : {
  if(lang == 'ml')return "മണിക്കൂറിൽ നിരക്ക്";
  else if (lang == 'hi') return "प्रति घंटे की कीमत";
  else return text;
  }
  break;

  case "Upload your ID Proof" : {
  if(lang == 'ml')return "നിങ്ങളുടെ ഐഡി പ്രൂഫ് അപ്‌ലോഡ് ചെയ്യുക";
  else if (lang == 'hi') return "अपना आईडी प्रूफ अपलोड करें";
  else return text;
  }
  break;

  case "Register" : {
  if(lang == 'ml')return "രജിസ്റ്റർ ചെയ്യുക";
  else if (lang == 'hi') return "रजिस्टर";
  else return text;
  }
  break;

  case "Please fill all the fields" : {
  if(lang == 'ml')return "ദയവായി എല്ലാ ഫീൽഡുകളും പൂരിപ്പിക്കുക";
  else if (lang == 'hi') return "कृपया सभी फ़ील्ड भरें";
  else return text;
  }
  break;


  case "Please upload your ID Proof" : {
  if(lang == 'ml')return "നിങ്ങളുടെ ഐഡി പ്രൂഫ് അപ്‌ലോഡ് ചെയ്യുക";
  else if (lang == 'hi') return "अपना आईडी प्रूफ अपलोड करें";
  else return text;
  }
  break;


  case "This field is required" : {
  if(lang == 'ml')return "ഈ ഫീൽഡ് പൂരിപ്പിക്കേണ്ടതുണ്ട്";
  else if (lang == 'hi') return "यह फ़ील्ड आवश्यक है";
  else return text;
  }
  break;

  case "Enter your phone number. You will receive a verification code shortly." : {
  if(lang == 'ml')return "നിങ്ങളുടെ ഫോൺ നമ്പർ നൽകുക. ഉടൻ തന്നെ നിങ്ങൾക്ക് ഒരു അറിയിപ്പ് ലഭിക്കും";
  else if (lang == 'hi') return "अपना फ़ोन नंबर दर्ज करें। आपको शीघ्र ही एक सूचना प्राप्त होगी";
  else return text;
  }
  break;

  case "Enter phone number" : {
  if(lang == 'ml')return "നിങ്ങളുടെ ഫോൺ നമ്പർ നൽകുക";
  else if (lang == 'hi') return "अपना फ़ोन नंबर दर्ज करें";
  else return text;
  }
  break;

  case "Login/SignUp" : {
  if(lang == 'ml')return "ലോഗിൻ/സൈൻ അപ്പ്";
  else if (lang == 'hi') return "लॉगइन / साइनअप";
  else return text;
  }
  break;

  case "Rating" : {
  if(lang == 'ml')return "റേറ്റിംഗ്";
  else if (lang == 'hi') return "रेटिंग";
  else return text;
  }
  break;

  case "Description" : {
  if(lang == 'ml')return "വിവരണം";
  else if (lang == 'hi') return "विवरण";
  else return text;
  }
  break;

  case "Available At:" : {
  if(lang == 'ml')return "എന്ന വിലാസത്തിൽ ലഭ്യമാണ്:";
  else if (lang == 'hi') return "विवरण";
  else return text;
  }
  break;

  case "Set Availabilty" : {
  if(lang == 'ml')return "സേവന ലഭ്യത";
  else if (lang == 'hi') return "सर्विस की उपलब्धता";
  else return text;
  }
  break;

  case "Reviews" : {
  if(lang == 'ml')return "അവലോകനം";
  else if (lang == 'hi') return "समीक्षा";
  else return text;
  }
  break;

  case "Edit Profile" : {
  if(lang == 'ml')return "പ്രൊഫൈൽ തിരുത്തുക";
  else if (lang == 'hi') return "प्रोफ़ाइल में परिवर्तन";
  else return text;
  }
  break;

  case "Full Name" : {
  if(lang == 'ml')return "പേര്";
  else if (lang == 'hi') return "पूरा नाम";
  else return text;
  }
  break;

  case "Upload promotion images" : {
  if(lang == 'ml')return "പ്രമോഷൻ ചിത്രങ്ങൾ അപ്‌ലോഡ് ചെയ്യുക";
  else if (lang == 'hi') return "प्रचार चित्र अपलोड करें";
  else return text;
  }
  break;

  case "Save" : {
  if(lang == 'ml')return "സേവ്";
  else if (lang == 'hi') return "सेव";
  else return text;
  }
  break;


  case "okay" : {
  if(lang == 'ml')return "ശരി";
  else if (lang == 'hi') return "ठीक है";
  else return text;
  }
  break;

  case "Data saved successfully!" : {
  if(lang == 'ml')return "ഡാറ്റ വിജയകരമായി ശേഖരിച്ചു";
  else if (lang == 'hi') return "डेटा सफलतापूर्वक सहेजा गया";
  else return text;
  }
  break;

  case "Cancel" : {
  if(lang == 'ml')return "റദ്ദാക്കുക";
  else if (lang == 'hi') return "रद्द करें";
  else return text;
  }
  break;

  case "Saved images" : {
  if(lang == 'ml')return "ശേഖരിച്ച ചിത്രങ്ങൾ";
  else if (lang == 'hi') return " सहेजे गए तस्वीर";
  else return text;
  }
  break;

  case "No images present" : {
  if(lang == 'ml')return "ചിത്രങ്ങളൊന്നുമില്ല";
  else if (lang == 'hi') return ",कोई तस्वीर मौजूद नहीं है";
  else return text;
  }
  break;

  case "No File selected" : {
  if(lang == 'ml')return "ഫയലൊന്നും തിരഞ്ഞെടുത്തിട്ടില്ല";
  else if (lang == 'hi') return "कोई फ़ाइल चयनित नहीं";
  else return text;
  }
  break;

  case "Image Uploaded" : {
  if(lang == 'ml')return "ചിത്രം അപ്ലോഡ് ചെയ്തു";
  else if (lang == 'hi') return "तस्वीर उपलायडेड";
  else return text;
  }
  break;

  case "Upload Image" : {
  if(lang == 'ml')return " നിങ്ങളുടെ ചിത്രം അപ്‌ലോഡ് ചെയ്യുക";
  else if (lang == 'hi') return "तस्वीर अपलोड करें";
  else return text;
  }
  break;

  case "No image selected" : {
  if(lang == 'ml')return "ചിത്രമൊന്നും തിരഞ്ഞെടുത്തിട്ടില്ല";
  else if (lang == 'hi') return " कोई भी तस्वीर सिलेक्टेड नहीं है";
  else return text;
  }
  break;

  case "Select Image" : {
  if(lang == 'ml')return "ചിത്രം തിരഞ്ഞെടുക്കുക";
  else if (lang == 'hi') return "तस्वीर चुने";
  else return text;
  }
  break;

  case "Image uploaded successfully!" : {
  if(lang == 'ml')return "ചിത്രം അപ്ലോഡ്  വിജയകരമായി പൂർത്തിയായി";
  else if (lang == 'hi') return "तस्वीर  अपलोड सफलतापूर्वक हो गया";
  else return text;
  }
  break;

  case "Select image first" : {
  if(lang == 'ml')return "ആദ്യം ചിത്രം തിരഞ്ഞെടുക്കുക";
  else if (lang == 'hi') return "पहले तस्वीर चुनें";
  else return text;
  }
  break;

  case "View saved Images" : {
  if(lang == 'ml')return "ശേഖരിച്ച ചിത്രങ്ങൾ കാണുക";
  else if (lang == 'hi') return "सहेजे गए तस्वीर को देखें";
  else return text;
  }
  break;

  case "Confirmed Bookings" : {
  if(lang == 'ml')return "സ്ഥിരീകരിച്ച ബുക്കിംഗ്";
  else if (lang == 'hi') return "कनफर्म्ड बुकिंग";
  else return text;
  }
  break;
    case "My Bookings" : {
      if(lang == 'ml')return "ബുക്കിംഗ്";
      else if (lang == 'hi') return "बुकिंग";
      else return text;
    }
    break;
  case "user" : {
  if(lang == 'ml')return "ഉപയോക്താവ് ";
  else if (lang == 'hi') return "उपयोगकर्ता";
  else return text;
  }
  break;

  case "locality" : {
  if(lang == 'ml')return "പ്രദേശം";
  else if (lang == 'hi') return "इलाका";
  else return text;
  }
  break;

  case "job" : {
  if(lang == 'ml')return "ജോലി";
  else if (lang == 'hi') return "काम";
  else return text;
  }
  break;

  case "Contact" : {
  if(lang == 'ml')return "കോൺടാക്റ്റ്";
  else if (lang == 'hi') return "संपर्क";
  else return text;
  }
  break;

  case "Location" : {
  if(lang == 'ml')return "സ്ഥലം";
  else if (lang == 'hi') return "स्थान";
  else return text;
  }
  break;

  case "Do you want to cancel the booking?" : {
  if(lang == 'ml')return "നിങ്ങൾക്ക് ബുക്കിംഗ് റദ്ദാക്കണോ?";
  else if (lang == 'hi') return "क्या आप बुकिंग रद्द करना चाहते हैं";
  else return text;
  }
  break;

  case "Yes" : {
  if(lang == 'ml')return "അതെ";
  else if (lang == 'hi') return "हाँ";
  else return text;
  }
  break;

  case "No" : {
  if(lang == 'ml')return "ഇല്ല";
  else if (lang == 'hi') return "नहीं";
  else return text;
  }
  break;

  default: {
  return text;
  }
  break;
}

}