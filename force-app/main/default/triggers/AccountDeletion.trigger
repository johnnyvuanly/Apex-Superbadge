/* The following trigger prevents the deletion of an account if it has related opportunties */

trigger AccountDeletion on Account (before delete) {
   
    // Prevent the deletion of accounts if they have related opportunities.
    for (Account a : [SELECT Id FROM Account
                     WHERE Id IN (SELECT AccountId FROM Opportunity) AND
                     Id IN :Trigger.old]) {
        /* calling addError() causes the entire set of operations to roll back, 
        except when bulk DML is called with partial success */
        Trigger.oldMap.get(a.Id).addError(
            'Cannot delete account with related opportunities.');
    }
    
}