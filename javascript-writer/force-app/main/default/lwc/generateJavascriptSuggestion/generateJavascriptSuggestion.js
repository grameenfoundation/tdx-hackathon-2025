import { api, LightningElement, wire } from "lwc";
import SuggestJavascript from "@salesforce/apex/GenerateJavascriptSuggestion.SuggestJavascript";
import { updateRecord, getRecord, getFieldValue } from "lightning/uiRecordApi";
import { generateRecordInputForUpdate } from 'lightning/uiRecordApi';


import ID_FIELD from "@salesforce/schema/Question__c.Id";
import JS_FIELD from "@salesforce/schema/Question__c.DynamicOperation__c";


export default class GenerateJavascriptSuggestion extends LightningElement {
  currentJS;
  error;
  showSpinner = false;
  @api recordId;

  @wire(getRecord, { recordId: '$recordId', layoutTypes: 'Full' }) question;

  get initialJS() {
    return getFieldValue(this.question.data, JS_FIELD);
  }

  async suggestJavascript() {
    this.showSpinner = true;
    try {
      const suggestion = await SuggestJavascript({
        questionID: this.recordId
      });
       this.currentJS = suggestion;
      this.error = undefined;
    } catch (error) {
      this.currentJS = undefined;
      this.error = error;
    } finally {
      this.showSpinner = false;
    }
  }

  handleChange(event) {
    this.currentJS = event.target.value;
}
  
  async handleClick() {
        const fields = {};

        fields[JS_FIELD.fieldApiName] = this.currentJS;
        fields[ID_FIELD.fieldApiName] = this.recordId;
            
        const recordInput = {
            fields: fields
        };
        console.log(fields);
        console.log(recordInput);

        try {
            const record = await updateRecord(recordInput);
            console.log(record);
        } catch (error) {
            console.error(error);
        }
    }
  
}