public with sharing class ExtractCurrentJS {
    @InvocableMethod(
        label='ExtractCurrentJS Helper'
        description='ExtractCurrentJS Helper for a single of questions'
    )
    public static List<ExtractCurrentJSResponse> getJavascriptForCurrentQuestion(
        List<ExtractCurrentJSRequest> requests
    ) {

        // Create the response for the agent
        ExtractCurrentJSResponse response = new ExtractCurrentJSResponse();
        List<String> validExtractCurrentJS = new List<String>();
        Id questionID = requests[0].questionID;
        Question__c question = [
            SELECT Id, DynamicOperation__c
            FROM Question__c 
            WHERE Id = :questionID
            LIMIT 1
        ];
        System.debug(question.DynamicOperation__c);
        validExtractCurrentJS.add(question.DynamicOperation__c);
        response.listOfValidExtractCurrentJSs = validExtractCurrentJS;
        List<ExtractCurrentJSResponse> responses = new List<ExtractCurrentJSResponse>();
        responses.add(response);
        return responses;
    }

    public class ExtractCurrentJSRequest {
        @InvocableVariable(
            required=true
            description='Question ID to retrieve related question tags'
        )
        public Id questionID;
    }

    public class ExtractCurrentJSResponse {
        @InvocableVariable(
            description='List of valid extracted JS'
        )
        public List<String> listOfValidExtractCurrentJSs;
    }
}