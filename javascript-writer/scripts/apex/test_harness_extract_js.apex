// Question__c myQuestion = [select Id from Question__c where Id = 'a01Qy00000uNHUs'];
Question__c myQuestion = [select Id from Question__c where Id = 'a01Qy00000uNHUb'];
ExtractCurrentJS.ExtractCurrentJSRequest request = new ExtractCurrentJS.ExtractCurrentJSRequest();
request.questionId = myQuestion.Id;
List<ExtractCurrentJS.ExtractCurrentJSRequest> requests = new List<ExtractCurrentJS.ExtractCurrentJSRequest>();
requests.add(request);
List<ExtractCurrentJS.ExtractCurrentJSResponse> responses = ExtractCurrentJS.getJavascriptForCurrentQuestion(requests);
for (ExtractCurrentJS.ExtractCurrentJSResponse response : responses) {
    System.debug(response);
}
// System.debug( ExtractCurrentJS.getJavascriptForCurrentQuestion(requests) );