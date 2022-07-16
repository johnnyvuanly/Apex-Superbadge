/* This queueable Apex class inserts the same Contact for each Account for a specific state */

public without sharing class AddPrimaryContact implements Queueable {
    
    private Contact contact;
    private String state; 
    
    /* Create a constructor of the class that accepts as its first arguement 
    a contact sObject and a second arguement as the state abbreviation */
    public AddPrimaryContact(Contact inputContact, String inputState) {
        // This keyword indicates, this instance of the class. Used when you make an instance of the class
        this.contact = inputContact;  
        this.state= inputState;
    }

    /* This method queries for a maximum of 200 Accounts with the BillingState specified in the constructor 
    and insert the Contact sObject record associated to each Account */
    public void execute(QueueableContext context) {
        // Queueable class have one method execute

        // Retrieve 200 Account Records 
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200];

        // Create empty list of Contacts records
        List<Contact> contacts = new List<Contact>(); 

        // Iterate through the Account records
        for (Account acc : accounts) {
            // Clone the Contact record, make the clone a child of the specifc Account record
            // and add to the list of Contacts
            Contact contactClone = contact.clone(); // Take contact passed in and clone it 
            contactClone.AccountId = acc.Id; // Set the relationship fields 
            contacts.add(contactClone); // add to empty list 
        }

        insert contacts; 

    }
}