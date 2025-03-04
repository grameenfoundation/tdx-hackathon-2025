public class PromptInvokableQuestionTag {
    @InvocableMethod(label='Get Question Tags for Question ID'
        description='Get Question Tags for a given Question ID')
    public static List<Response> getQuestionTags(List<Request> requests) {
        // Validate the expected number of requests as an input
        if (requests.size() != 1)
          throw new ListException('The requests list must contain one entry only');
        System.debug('Request: ' + requests);
        Id q = requests[0].desiredQuestion.Id;
        System.debug('Question ID: ' + q);
        List<Response> responses = new List<Response>();
        Response res = new Response();
        res.Prompt = QuestionTagHelper.getValidQuestionTagsFromIDAndJoin(q);
        System.debug(res.Prompt);
        responses.add(res);
        return responses;
    }
    
    public class Request {
        @InvocableVariable(required=true)
        public Question__c desiredQuestion;
    }
    
    public class Response {
        @InvocableVariable
        public String Prompt;
    }
}