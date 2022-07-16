/* This class scheduable Apex class updates lead records 
with a specific lead source everyday */

public without sharing class DailyLeadProcessor implements Schedulable{
    // Takes a context as a parameter 
    public void execute(SchedulableContext ctx) {

        // System.debug('Context' + ctx.getTriggerId()); // Returns the Id of the CronTrigger schedulable 

        // Get 200 lead records and modify the LeadSource field
        List <Lead> leads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null Limit 200];

        for (lead l : leads) {
            l.LeadSource = 'Dreamforce';
        }

        // Update the modified records
        update leads;
    }
}