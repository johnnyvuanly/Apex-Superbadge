/* The TestDataFactory class is a special type of class - it is a public class that is 
annotated with isTest. Test utility classes are excluded from the org's code size limit
Call appropriate method in test class for test data */

@isTest
public class TestDataFactory {
    public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
        List<Account> accts = new List<Account>();
        // creates the specified number of accounts and stores them in the accts list
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;

        List<Opportunity> opps = new List<Opportunity>();
        // creates the opportunities because each group of opportunities are linked to one account
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer k=0;k<numOppsPerAcct;k++) {
                opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=acct.Id));
            }
        }
        // Insert all opportunities for all accounts.
        insert opps;
        return accts; 
    }

    // This method creates test accounts with contacts 
    public static List<Account> createAccountsWithContacts(Integer numAccts2, Integer numContactsPerAccount) {
        List<Account> accts2 = new List<Account>();
        for(Integer i=0;i<numAccts2;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts2.add(a);
        }
        insert accts2; 

        List<Contact> contacts = new List<Contact>(); 
        List<Id> accountIds = new List<Id>();
        for (Integer j=0;j<numAccts2;j++) {
            Account acct2 = accts2[j];
            // For each account just inserted, add Contacts
            for (Integer k=0;k<numContactsPerAccount; k++) {
                contacts.add(new Contact(FirstName=acct2.Name, 
                                    LastName='TestContact' + k, 
                                    AccountId=acct2.Id));
                accountIds.add(acct2.Id);
            }

        } 
        insert contacts;
        return accts2;
    }

    // This method creates test accounts with contacts and returns the Id
    public static List<Id> createAccountsWithContactsReturnId() {
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<300; i++) {
            accounts.add(new Account(Name='Test Account' + i));
        }
        insert accounts;

        List<Contact> contacts = new List<Contact>();
        List<Id> accountIds = new List<Id>();
        for (Account acc: accounts) {
            contacts.add(new Contact(FirstName=acc.Name, LastName='TestContact', AccountId=acc.Id));
            accountIds.add(acc.Id);
        }
        insert contacts;
        return accountIds;
    }

}