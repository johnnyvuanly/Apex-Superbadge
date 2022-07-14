/* This is a sample batch Apex code. This class finds all accounts that passed in 
by the start(0 method using a QueryLocator and updates the associated contacts with 
their account's mailing address. Finally, it sends off an email with the result of 
the bulk job and, since we are using Database.Stateful totrack state, the number of 
records updated. Database.Stateful in the class definition allows you to maintain state 
across all transactions as batch Apex is typically stateless */

public class UpdateContactAddresses implements
    Database.Batchable<sObject>, Database.Stateful {
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    /* start method provides the collection of all records that the execute method will 
    process in indiviudal batches */
    public Database.QueryLocator start(Database.BatchableContext bc) {
        /* Returns the list of records to be processed by calling Database.getQueryLocator */
        return Database.getQueryLocator(
            'SELECT ID, BillingStreet, BillingCity, BillingState, ' +
            'BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, ' +
            'MailingState, MailingPostalCode FROM Contacts) FROM Account ' +
            'Where BillingCountry = \'USA\''
        );
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of 200 records
        List<Contact> contacts = new List<Contact>();
        for (Account account : scope) {
            for (Contact contact : account.contacts) {
                // sets each contact's mailing address to the accounts billing address 
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                // add contact to list to be updated
                contacts.add(contact);
                // increment the instance member counter
                recordsProcessed = recordsProcessed + 1;
            }
        }
        update contacts;
    }
    /* finish method performs a query on the AsyncApexJob object  to get the status of the job and 
    then sends a notification email */
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
        EmailUtils.sendMessage(job, recordsProcessed);
    }
}
