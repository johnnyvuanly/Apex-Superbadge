/* This batchable Apex class is used to update all Leads records in an org with a specific LeadSource */

public without sharing class LeadProcessor implements Database.Batchable<SObject> {

    // QueryLocator method allows us to consume up to 50 million records
    public Database.QueryLocator start(Database.BatchableContext dbc) {
        return Database.getQueryLocator([SELECT Id, Name FROM Lead]);
    }

    /* This method takes two arguements 1 being the Database.Batchable context and the 
    other is the scope in this case lead records. Here we set the batch size to the amount 
    of leads in the list */
    public void execute(Database.BatchableContext dbc, List<Lead> leads) {
        for (Lead l : leads) {
            l.LeadSource = 'Dreamforce';
        }
        update leads;
    }

    // Review, finish methods execute post processing like sending an email once after all batches are processed
    public void finish(Database.BatchableContext dbc) {
        System.debug('Done');
    }
}