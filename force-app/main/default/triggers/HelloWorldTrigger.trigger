/* Apex triggers enable yout to perform custom actions 
before or after events to records such as insertions, 
updates, or deletions 

Before Triggers - Used to update or validate record values 
before they're saved to the data base

After Triggers - used to access field values that are set 
by the system like Id or LastModifiedDate field and to affect 
changes in other records */

trigger HelloWorldTrigger on Account (before insert) {
    /* Trigger.New is a context variable that contains all the 
    records that were inserted in insert or update triggers */
    for(Account a : Trigger.New) {
        /* Iterate over each account in a for loop and updates 
        the Description field for each */
        a.Description = 'New description';
    }   
}

/* Open Execute Anonymous Window code
Account a = new Account(Name='Test Trigger');
insert a;
*/