/* This class tests the AccountProcessor Apex class */

@isTest
private class AccountProcessorTest {
    @isTest
    private static void countContactsTest() {
        // load test data
        // creates one account with one contact using a method in the TestDataFactory class 
        Id[] ids = TestDataFactory.createAccountsWithContactsReturnId();

        // Do the test
        // wrap any asynchronous Apex with startTest() and stopTest(), get its own set of gov limits
        Test.startTest();
        AccountProcessor.countContacts(ids);
        Test.stopTest();
        
        // Check results 
        List<Account> accs = [SELECT Id, Number_of_Contacts__c FROM Account];
        for (Account acc : accs) {
            System.assertEquals(1, acc.Number_of_Contacts__c, 'ERROR: At least 1 Account record with incorrect Contact');
        }
    }
}