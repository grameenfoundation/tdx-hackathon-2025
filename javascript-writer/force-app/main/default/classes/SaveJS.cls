public with sharing class SaveJS {
    @InvocableMethod(
        label='SaveJS Helper'
        description='SaveJS Helper for a single questions'
    )
    public static List<SaveJSResponse> saveJavascriptForCurrentQuestion(
        List<SaveJSRequest> requests
    ) {

        // Create the response for the agent
        String responseString = '';
        Id questionID = requests[0].questionID;
        Question__c question = [
            SELECT Id, DynamicOperation__c
            FROM Question__c 
            WHERE Id = :questionID
            LIMIT 1
        ];
        System.debug('Before: ' + question.DynamicOperation__c);
        question.DynamicOperation__c = requests[0].newJS;
        try {
        update question;
        System.debug('After: ' + question.DynamicOperation__c); 
        responseString = 'Successful JS Update';
        }
        catch (Exception e) {
            System.debug(e.getMessage());
            responseString = e.getMessage();
        }


        SaveJSResponse response = new SaveJSResponse();
        List<String> validSaveJS = new List<String>();
        validSaveJS.add(responseString);
        response.listOfValidSaveJSs = validSaveJS;
        List<SaveJSResponse> responses = new List<SaveJSResponse>();
        responses.add(response);
        return responses;
    }

    public class SaveJSRequest {
        @InvocableVariable(
            required=true
            description='Question ID to retrieve related question tags'
        )
        public Id questionID;
        @InvocableVariable(
            required=true
            description='Question ID to retrieve related question tags'
        )
        public String newJS;
    }

    public class SaveJSResponse {
        @InvocableVariable(
            description='List of valid extracted JS'
        )
        public List<String> listOfValidSaveJSs;
    }
}