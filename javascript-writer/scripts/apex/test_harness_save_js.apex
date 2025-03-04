// Question__c myQuestion = [select Id from Question__c where Id = 'a01Qy00000uNHUs'];
Question__c myQuestion = [select Id from Question__c where Id = 'a01Qy00000uNHUb'];
SaveJS.SaveJSRequest request = new SaveJS.SaveJSRequest();
request.questionId = myQuestion.Id;
request.newJS = 'w.community_information.form_record_type.value = "Project Assessment"; //HELLO';
List<SaveJS.SaveJSRequest> requests = new List<SaveJS.SaveJSRequest>();
requests.add(request);
List<SaveJS.SaveJSResponse> responses = SaveJS.saveJavascriptForCurrentQuestion(requests);
for (SaveJS.SaveJSResponse response : responses) {
    System.debug(response);
}
// System.debug( SaveJS.getJavascriptForCurrentQuestion(requests) );