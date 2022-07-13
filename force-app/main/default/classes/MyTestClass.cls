/* Apex testing framework enables you to write and execute tests for your 
Apex classes and triggers. Apex code can only be written in a sandbox environment 
or Developer org. Before you can deploy your code or package if for the Lightning 
Platform AppExchange, at least 75% of Apex code must be covered by tests. Each 
trigger must have some coverage */


// Test methods are defined using the isTest annotation
@isTest
private class MyTestClass {
    /* Visibility of a test method doesnt matter, so declaring test method as public 
    or private doesn't make a difference as the testing framework is always able to 
    access test methods */
    @isTest static void myTest() {
        // code_block
    }
}