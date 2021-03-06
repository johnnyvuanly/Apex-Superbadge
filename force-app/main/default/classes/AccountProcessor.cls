// without sharing here as a best practice. Use the sharing model or not
public without sharing class AccountProcessor {
    // Future methods must be public static and return nothing 
    @future
    public static void countContacts(List<Id> accountIds) {
        /* For each Account Id passed to the method, count the number of Contact 
        records associated to it and update the Number_of_Contacts custom field */

        // Query for account recordsand pull related contacts with the sub query. Notice plural of contacts in sub query
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds];

        // Iterate over returned list of accounts 
        for (Account acc : accounts) {
            // Make field equal to the number of Contacts related to the Account. acc.Contacts gives you a list of records 
            acc.Number_of_Contacts__c = acc.Contacts.size();
        }

        // Throw it back into the database
        update accounts;
        
    }
}