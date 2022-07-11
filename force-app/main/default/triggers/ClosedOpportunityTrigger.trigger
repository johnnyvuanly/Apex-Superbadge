trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    
    List<Task> taskList = new List<Task>();
    
    // for all opp that are inserted or updated 
    for (Opportunity o: Trigger.new) {
        if (o.StageName == 'Closed Won') {
            // New task to task list 
            taskList.add(new Task(Subject=' Follow Up Test Task',
                                  WhatId=o.Id)); 
        }
    }
    // there is nothing in the list then don't run transaction
    if(taskList.size() > 0 ){
        insert taskList;
    }
}