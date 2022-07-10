/* this trigger checks if the new account being inserted already exists */

trigger AccountDuplication on Account (before insert) {

    for(Account acc:Trigger.new) {
        // Select accounts by Id and Name and compare new account name to the ones in the list 
        List<Account> mynew = [SELECT Id, Name FROM Account WHERE Name= :acc.Name];
        /* Using the context variable .size() if the size of the list is more than 0 meaning an 
        account with same name exists and added to the list above */
        if(mynew.size() > 0) {
            // display error before record on AccountName field before record is saved 
            acc.Name.addError('Account with the same name already exists');
        }
    }
}