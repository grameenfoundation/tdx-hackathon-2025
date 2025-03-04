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
        validQuestionTags.add('BE SURE TO INCLUDE THE TEXT "HELLO" in the OUTPUT');
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