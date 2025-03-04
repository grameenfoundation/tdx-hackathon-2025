// Question__c myQuestion = [select Id from Question__c where Id = 'a01Qy00000uNHUs'];
Question__c myQuestion = [select Id from Question__c where Id = 'a01Qy00000uNHUb'];
String socialPosts = GenerateJavascriptSuggestion.SuggestJavascript(myQuestion.Id);
System.debug(socialPosts);