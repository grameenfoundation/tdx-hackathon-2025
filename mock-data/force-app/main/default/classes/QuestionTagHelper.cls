public with sharing class QuestionTagHelper {
    @InvocableMethod(
        label='QuestionTag Helper'
        description='QuestionTag Helper for a list of questions'
    )
    public static List<QuestionTagResponse> getValidQuestionTags(
        List<QuestionTagRequest> requests
    ) {

        // Create the response for the agent
        QuestionTagResponse response = new QuestionTagResponse();
        List<String> validQuestionTags = new List<String>();
        //TODO actual SOQL query
        validQuestionTags.add(getValidQuestionTagFromID(requests[0].questionID)[0]);
        return new List<QuestionTagResponse>{ response };
    }

    public static List<String> getValidQuestionTagFromID(Id questionID) {
        List<String> validQuestionTags = new List<String>();
        //SOQL Query - get all questions that have the same SurveyVersion__c as this question
        // First, get the SurveyVersion__c for the given questionID
        Question__c question = [
            SELECT SurveyVersion__c, Position__c, Parent__c, Parent__r.Name__c, Parent__r.Position__c
            FROM Question__c 
            WHERE Id = :questionID
            LIMIT 1
        ];

        // Then, get all questions that have the same SurveyVersion__c
        List<Question__c> questions = [
            SELECT Id, Name__c, Position__c, Parent__c, Parent__r.Name__c, Parent__r.Position__c
            FROM Question__c 
            WHERE SurveyVersion__c = :question.SurveyVersion__c
        ];

        // Filter out only the questions before this one in the form - either the Parent Position is less than this question's Parent Position or the Parent Position is the same and the question's Position is less than this question's Position
        // Also include this question as a valid tag
        for (Question__c q : questions) {
            if (
                (q.Parent__r.Position__c < question.Parent__r.Position__c) ||
                (q.Parent__r.Position__c == question.Parent__r.Position__c && q.Position__c < question.Position__c) ||
                (q.Id == question.Id)
            ) {
                validQuestionTags.add('tw.' + q.Parent__r.Name__c + '.' + q.Name__c + '.value');
            }
        }

        return validQuestionTags;
    }

    public static String getValidQuestionTagsFromIDAndJoin(Id questionID) {
        List<String> validQuestionTags = getValidQuestionTagFromID(questionID);
        return '[' + String.join(validQuestionTags, ',') + ']';

    }

    public class QuestionTagRequest {
        @InvocableVariable(
            required=true
            description='Question ID to retrieve related question tags'
        )
        public Id questionID;
    }

    public class QuestionTagResponse {
        @InvocableVariable(
            description='List of valid question tags'
        )
        public List<String> listOfValidQuestionTags;
    }
}