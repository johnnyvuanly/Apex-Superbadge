// Most efficient Trigger with a SOQL query template

trigger SoqlTriggerBulk on Account(after update) {  
    // Perform SOQL query once.    
    // Get the related opportunities for the accounts in this trigger,
    // and iterate over those records.
    for(Opportunity opp : [SELECT Id,Name,CloseDate FROM Opportunity
        WHERE AccountId IN :Trigger.New]) {
  
        // Do some other processing
    }
}

/* Notes on unefficient triggers and SOQL 

Query Pattern to avoid - this example makes a SOQL query inside the for loop
to get related opp for each acc. This could result in too many SOQL queries 

trigger SoqlTriggerNotBulk on Account(after update) {   
    for(Account a : Trigger.New) {
        // Get child records for each account
        // Inefficient SOQL query as it runs once for each account!
        Opportunity[] opps = [SELECT Id,Name,CloseDate 
                             FROM Opportunity WHERE AccountId=:a.Id];
        
        // Do some other processing
    }
}

Recommended approach - SOQL query called outside the main loop. The SOQL query 
uses an inner query to get related opp of acc. The SOQL query is connected to 
the trigger context records by using the IN clause and binding Trigger.new. The 
WHERE condition filters the accounts to only those records that fired this trigger

trigger SoqlTriggerBulk on Account(after update) {  
    // Perform SOQL query once.    
    // Get the accounts and their related opportunities.
    List<Account> acctsWithOpps = 
        [SELECT Id,(SELECT Id,Name,CloseDate FROM Opportunities) 
         FROM Account WHERE Id IN :Trigger.New];
  
    // Iterate over the returned accounts    
    for(Account a : acctsWithOpps) { 
        Opportunity[] relatedOpps = a.Opportunities;  
        // Do some other processing
    }
}

Alternatively - you don't need the account parent records so you can retrieve only
 the opp that are related to the accounts within this trigger context 

trigger SoqlTriggerBulk on Account(after update) {  
    // Perform SOQL query once.    
    // Get the related opportunities for the accounts in this trigger.
    List<Opportunity> relatedOpps = [SELECT Id,Name,CloseDate FROM Opportunity
        WHERE AccountId IN :Trigger.New];
  
    // Iterate over the related opportunities    
    for(Opportunity opp : relatedOpps) { 
        // Do some other processing
    }
}

*/