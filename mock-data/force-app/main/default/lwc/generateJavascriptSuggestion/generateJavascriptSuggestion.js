import { api, LightningElement } from "lwc";
import SuggestJavascript from "@salesforce/apex/GenerateJavascriptSuggestion.SuggestJavascript";

export default class GenerateJavascriptSuggestion extends LightningElement {
  generatedJS;
  error;
  showSpinner = false;
  @api recordId;

  async suggestJavascript() {
    this.showSpinner = true;
    try {
      const suggestion = await SuggestJavascript({
        questionID: this.recordId
      });
       this.generatedJS = suggestion;
      this.error = undefined;
    } catch (error) {
      this.generatedJS = undefined;
      this.error = error;
    } finally {
      this.showSpinner = false;
    }
  }
}