public with sharing class GenerateJavascriptSuggestion {
    @AuraEnabled
    public static String SuggestJavascript(String questionID) {
        // Create inputs
        Map<String, String> questionIDs = new Map<String, String>();
        questionIDs.put('id', questionID);
        ConnectApi.WrappedValue questionIDValue = new ConnectApi.WrappedValue();
        questionIDValue.value = questionIDs;
        Map<String, ConnectApi.WrappedValue> inputParams = new Map<String, ConnectApi.WrappedValue>();
        inputParams.put('Input:Question', questionIDValue);

        //TODO get from QuestionTagHelper
        List<String> validQuestionTags = new List<String>();
        String allCombinedTags =  QuestionTagHelper.getValidQuestionTagsFromIDAndJoin(questionID);
        ConnectApi.WrappedValue allCombinedTagsValue = new ConnectApi.WrappedValue();
        allCombinedTagsValue.value = allCombinedTags;   
        inputParams.put('Input:QuestionTags', allCombinedTagsValue);

        // Configure invocation parameters
        ConnectApi.EinsteinPromptTemplateGenerationsInput executeTemplateInput = new ConnectApi.EinsteinPromptTemplateGenerationsInput();
        executeTemplateInput.additionalConfig = new ConnectApi.EinsteinLlmAdditionalConfigInput();
        executeTemplateInput.additionalConfig.applicationName = 'PromptBuilderPreview';
        executeTemplateInput.isPreview = false;
        executeTemplateInput.inputParams = inputParams;

        try {
            // Call the service
            ConnectApi.EinsteinPromptTemplateGenerationsRepresentation generationsOutput = ConnectApi.EinsteinLLM.generateMessagesForPromptTemplate(
                'Generate_Javascript',
                executeTemplateInput
            );
            ConnectApi.EinsteinLLMGenerationItemOutput response = generationsOutput.generations[0];
            return response.text;
        } catch (Exception e) {
            System.debug(e.getMessage());
            throw e;
        }
    }
}