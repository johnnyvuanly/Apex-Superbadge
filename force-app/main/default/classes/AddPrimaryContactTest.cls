/* This class test the AddPrimaryContact queueable Apex class */

@isTest
private class AddPrimaryContactTest {

    @isTest
    private static void testQueueableClass() {

        // Load test data
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<500; i++) {
            Account acc = new Account(Name='Test Account');
            if (i<250) {
                acc.BillingState = 'NY'; // create 250 Account with billing state of NY
            } else {
                acc.BillingState = 'CA'; // create 250 Account with billing state of CA
            }
            accounts.add(acc);
        }
        insert accounts;

        // Orphan contact record to associate with Account 
        Contact contact = new Contact(FirstName='Simon', LastName='Connock');
        insert contact;

        // Perform the test 
        Test.startTest();
        /* enqueueJob method returns a job ID that you can monitor, again you create an 
        instance of the Queueable class which calls the constructor and pass in parameters */
        Id jobid = System.enqueueJob(new AddPrimaryContact(contact, 'CA'));
        Test.stopTest();

        // Check the results
        // grab Contact records who parent Account BillingState = CA
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Contact.Account.BillingState = 'CA'];
        System.assertEquals(200, contacts.size(), 'ERROR: Incorrect number of Contact records found');

    }
}
