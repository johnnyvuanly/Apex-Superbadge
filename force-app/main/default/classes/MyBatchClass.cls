/* Batch Apex is used to run large jobs (think thousands or millions of records). Using this 
you can proccess records asynchronously in batches. Each transaction starts with a new set of 
govenor limits, if one batch fails to process successfully, all other successful batch transactions 
aren't rolled back */

// To write a Batch Apex class it must implement the Database.Batchable interface and include three methods start, execute, finish

public class MyBatchClass implements Database.Batchable<sObject> {
    public (Database.QueryLocator | Iterable<sObject>) start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
    }
    public void execute(Database.BatchableContext bc, List<P> records){
        // process each batch of records
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}


/* 
// to invoke a batch class, simply instantiate it and then call Database.executeBatch with the instance
MyBatchClass myBatchObject = new MyBatchClass();
Id batchId = Database.executeBatch(myBatchObject);

// you can optionally pass a second scope parameter to specify the number of records that should be passed into the execute method for each 
// batch
Id batchId = Database.executeBatch(myBatchObject, 100);

// Each batch Apex invocation creates an AsyncApexJob record so that you can track the job's progress. You can view the progress via SOQL or 
// manage your job in the Apex Job Queue
AsyncApexJob job = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors FROM AsyncApexJob WHERE ID = :batchId ];

*/