let rootPageResponse = """
{"type":"page","pageType":"root","title":"Viaplay - Streama TV, Serier, Film och Sport online","description":"Hyr filmer på nätet och se live sport som fotboll och Premier League. Viaplay har alla TV serier och kanaler online.","styles":[],"_links":{"curies":[{"name":"viaplay","href":"http://docs.viaplay.tv/rel/{rel}","templated":true}],"self":{"href":"https://content.viaplay.se/ios-se"},"viaplay:root":{"id":"root","title":"Start","href":"https://content.viaplay.se/ios-se{?dtg}","active":true},"viaplay:editorial":{"id":"editorial","href":"https://content.viaplay.se/ios-se/editorial{?dtg}"},"viaplay:search":{"title":"Sök","href":"https://content.viaplay.se/ios-se/search{?query,includeTvod,includeKidsBlock,dtg}","templated":true},"viaplay:autocomplete":{"title":"autocomplete","href":"https://content.viaplay.se/ios-se/autocomplete{?query,includeTvod,includeKidsBlock,dtg}","templated":true},"viaplay:byGuid":{"title":"byGuid","href":"https://content.viaplay.se/ios-se/byguid/{guid}{?returnFirstEpisode,seasonId,tveProgram,dtg}","templated":true},"viaplay:searchSuggestions":{"title":"byGuids","href":"https://content.viaplay.se/ios-se/search-suggestions/{guids}{?dtg}","templated":true},"viaplay:validateSession":{"id":"validateSession","href":"https://login.viaplay.se/api/validateSession/v1{?session}","templated":true},"viaplay:translations":{"id":"translations","href":"https://cms-service.viaplay.com/translations/ios","templated":false},"viaplay:technotifier":{"id":"technotifier","href":"https://viaplay.mtg-api.com/tech-notifications/v1/viaplay/sv-se/ios"},"viaplay:sections":[{"id":"35bb8a90-d40e-11e2-8b8b-0800200c9a66","title":"Serier","href":"https://content.viaplay.se/ios-se/serier{?dtg}","type":"vod","name":"series","templated":true},{"id":"2037b330-d411-11e2-8b8b-0800200c9a66","title":"Filmer","href":"https://content.viaplay.se/ios-se/film{?dtg}","type":"vod","name":"movie","templated":true},{"id":"8e5febf0-d4e0-11e2-8b8b-0800200c9a66","title":"Sport","href":"https://content.viaplay.se/ios-se/sport{?dtg}","type":"vod","name":"sport","templated":true},{"id":"1a6a2ec0-d4e2-11e2-8b8b-0800200c9a66","title":"Barn","href":"https://content.viaplay.se/ios-se/barn{?dtg}","type":"vod","name":"kids","templated":true}],"viaplay:geolocation":{"href":"https://viaplay.mtg-api.com/geolocation/viaplay/portability{?ip,country}"},"viaplay:retrieveUserInformation":{"id":"retrieveUserInformation","href":"https://viaplay.mtg-api.com/user-information/{brand}/users/{userId}","method":"GET","templated":true},"viaplay:localizationLanguages":{"id":"localizationLanguages","href":"https://viaplay.mtg-api.com/localization/languages/se","method":"GET"},"viaplay:localizationCountry":{"id":"localizationCountry","href":"https://viaplay.mtg-api.com/localization/countries/{countryCode}","method":"GET","templated":true},"viaplay:userJourneyGetJourney":{"id":"userJourneyGetJourney","href":"https://viaplay.mtg-api.com/user-journey/user/{userId}/profile/{profileId}/journey/{journeyId}","method":"GET","templated":true},"viaplay:getUser":{"id":"getUser","href":"https://viaplay.mtg-api.com/identity/viaplay/users/{userId}","method":"GET","templated":true},"viaplay:applePurchases":{"createAndLogin":{"id":"createAndLogin","href":"https://viaplay.mtg-api.com/identity/viaplay/auth/pwd/users","method":"POST"},"allowedToRegister":{"id":"allowedToRegister","href":"https://viaplay.mtg-api.com/identity/viaplay/emails/{email}/user/allowed-to-register","method":"GET","templated":true},"subscriptionProducts":{"id":"subscriptionProducts","href":"https://viaplay.mtg-api.com/commercial-products/viaplay/sv-se/ios/subscription-products","method":"GET"},"templatedSubscriptionProducts":{"id":"templatedSubscriptionProducts","href":"https://viaplay.mtg-api.com/commercial-products/viaplay/{locale}/ios/subscription-products","method":"GET","templated":true},"userCommercialInfo":{"id":"userCommercialInfo","href":"https://viaplay.mtg-api.com/purchases/viaplay/{locale}/users/{userId}/commercial-info","method":"GET","templated":true},"inAppPurchases":{"id":"inAppPurchases","href":"https://viaplay.mtg-api.com/purchases/viaplay/users/{userId}/apple-in-app-purchases","method":"POST","templated":true},"oneStepOrder":{"id":"oneStepOrder","href":"https://viaplay.mtg-api.com/purchases/viaplay/users/{userId}/purchases","method":"POST","templated":true},"activeContracts":{"id":"activeContracts","href":"https://viaplay.mtg-api.com/purchases/viaplay/{locale}/users/{userId}/active-contracts","method":"GET","templated":true},"receiptUserIdEnquiry":{"id":"receiptUserIdEnquiry","href":"https://viaplay.mtg-api.com/purchases/viaplay/apple-receipts/user-id-enquiry","method":"POST"},"termsAndConditions":{"id":"termsAndConditions","href":"https://viaplay.se/terms?iosmode=true","method":"GET"},"privacyPolicy":{"id":"privacyPolicy","href":"https://viaplay.se/privacy?iosmode=true","method":"GET"},"cookiePolicy":{"id":"cookiePolicy","href":"https://viaplay.se/cookies?iosmode=true","method":"GET"},"consumableProducts":{"id":"consumableProducts","href":"https://viaplay.mtg-api.com/commercial-products/viaplay/{locale}/ios/consumable-products","method":"GET","templated":true},"programEntitlements":{"id":"programEntitlements","href":"https://viaplay.mtg-api.com/pin-code-proxy/programEntitlements/users/{userId}/programs/{guid}{?pgPin}","method":"GET","templated":true}},"termsAndConditions":{"id":"termsAndConditions","href":"https://viaplay.se/terms?iosmode=true","method":"GET"},"privacyPolicy":{"id":"privacyPolicy","href":"https://viaplay.se/privacy?iosmode=true","method":"GET"},"cookiePolicy":{"id":"cookiePolicy","href":"https://viaplay.se/cookies?iosmode=true","method":"GET"},"viaplay:login":{"title":"Login","href":"https://login.viaplay.se/api/login/v1?deviceKey=ios-se&returnurl=https%3A%2F%2Fcontent.viaplay.se%2Fios-se{&username,password,persistent,forward}","templated":true},"viaplay:appleLogin":{"id":"appleLogin","href":"https://login.viaplay.se/api/appletv/login","method":"POST"},"viaplay:tokenLogin":{"href":"https://login.viaplay.se/api/tokenLogin?deviceKey=ios-se{&accessToken,refreshToken,persistent,returnurl}","method":"GET","templated":true},"viaplay:tokenRefresh":{"href":"https://login.viaplay.se/api/tokenRefresh/{userId}?deviceKey=ios-se","method":"POST","templated":true},"viaplay:setParentalControl":{"id":"setParentalControl","href":"https://viaplay.mtg-api.com/identity/{brand}/users/{userId}/parental-control","method":"POST","templated":true},"viaplay:userPwdUpdate":{"id":"userPwdUpdate","href":"https://viaplay.mtg-api.com/identity/{brand}/users/{userId}/password","method":"PUT","templated":true},"viaplay:userPwdLoginRequest":{"id":"userPwdLoginRequest","href":"https://viaplay.mtg-api.com/identity/{brand}/auth/pwd/sessions","method":"POST","templated":true},"viaplay:passwordToken":{"id":"createPasswordToken","href":"https://viaplay.mtg-api.com/identity/viaplay/emails/{email}/user/password-token","method":"POST","templated":true},"viaplay:resetPassword":{"id":"resetPassword","href":"https://viaplay.mtg-api.com/identity/viaplay/passwords","method":"PUT"},"viaplay:retrieveUserEmail":{"id":"retrieveUserEmail","href":"https://viaplay.mtg-api.com/identity/{brand}/reset-pwd-tokens/{+resetPwdToken}/user/email","method":"GET","templated":true},"viaplay:universalLinkResolver":{"id":"universalLinkResolver","href":"https://content.viaplay.se/ios-se/universalLink/{universalLink}{?dtg}","method":"GET","templated":true},"viaplay:userExperiments":{"id":"userExperiments","href":"https://viaplay.mtg-api.com/experiments/users/{userId}","method":"GET","templated":true},"viaplay:tracking":{"id":"tracking","href":"https://cronos-events.mtg-api.com/cronos-events/event/{brand}/ios-se/{clientVersion}/{sequenceNo}/{eventType}{?sessionId}","method":"POST","templated":true},"viaplay:multiPartial":{"id":"multiPartial","href":"https://content.viaplay.se/ios-se?multiPartial=true{&blockIds}","method":"GET","templated":true}},"_embedded":{"viaplay:blocks":[]},"responseCode":{"httpStatus":200,"statusCode":200,"code":1}}
"""

let sectionResponse = """
{
  "type": "page",
  "pageType": "section",
  "sectionId": "2037b330-d411-11e2-8b8b-0800200c9a66",
  "title": "Film på nätet - Streama film online eller ladda ned",
  "description": "Viaplay erbjuder film på nätet för hela familjen. Streama filmer online i hög kvalitet eller ladda ned till tablet eller mobil!",
  "_links": {
    "viaplay:sections": [
      {
        "id": "35bb8a90-d40e-11e2-8b8b-0800200c9a66",
        "title": "Serier",
        "href": "https://content.viaplay.se/ios-se/serier{?dtg}",
        "type": "vod",
        "name": "series",
        "templated": true
      },
      {
        "id": "2037b330-d411-11e2-8b8b-0800200c9a66",
        "title": "Filmer",
        "href": "https://content.viaplay.se/ios-se/film{?dtg}",
        "type": "vod",
        "name": "movie",
        "templated": true,
        "active": true
      },
      {
        "id": "8e5febf0-d4e0-11e2-8b8b-0800200c9a66",
        "title": "Sport",
        "href": "https://content.viaplay.se/ios-se/sport{?dtg}",
        "type": "vod",
        "name": "sport",
        "templated": true
      },
      {
        "id": "1a6a2ec0-d4e2-11e2-8b8b-0800200c9a66",
        "title": "Barn",
        "href": "https://content.viaplay.se/ios-se/barn{?dtg}",
        "type": "vod",
        "name": "kids",
        "templated": true
      }
    ]
  }
}
"""

