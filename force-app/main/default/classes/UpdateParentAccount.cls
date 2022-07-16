/* Queueable Apex - future methods and batch Apex combine together. Simple interface 
without start and finish methods and allow you to utilize more than just primitive arguements

- Your Queueable class can contain member variables of non primitive data types such as sObjects or custom Apex types
- Monitoring by invoking the System.enqueueJob method. The method returns the ID of the AsyncApexJob record
- Chaining jobs by chaining one job to another job by starting starting a second job from a running job

Queueable versus Future
Because queueable methods are functionally equivalent to future methods, most time you'll 
probably want to use queueable instead of future methods. Use future methods when your 
functionality is sometimes executed synchronously and sometimes asynchronously

A common scenario is to take some set of sObject records, execute some processing 
such as making a callout to an external REST endpoint or perform some calculations and 
then update them in the database asynchronously */

/* The following code takes a collecction of Account records, sets the parentId for each 
record, and then updates the records in the database*/
public class UpdateParentAccount implements Queueable {
    private List<Account> accounts;
    private ID parent;
    public UpdateParentAccount(List<Account> records, ID id) {
        this.accounts = records;
        this.parent = id;
    }
    public void execute(QueueableContext context) {
        for (Account account : accounts) {
          account.parentId = parent;
          // perform other processing or callout
        }
        update accounts;
    }
}