import { LightningElement, track } from 'lwc';

export default class HelloWorld extends LightningElement {
    buttonLabel = 'Click Me';

    @track showMessage = false;
    @track message = '';

    handleClick() {
        this.showMessage = true;
        this.message = 'Hello from the Salesforce Demo! 🚀';
    }
}
