/* The following trigger shows how to call a static method 
from a trigger if the trigger was fired because of an insert 
event, the exampe calls the static sendMail() method from the 
EmailManager class which sends an email to specified recipients 
and contains the number of contact records inserted */

trigger ExampleTrigger on Contact (after insert, after delete) {
    if (Trigger.isInsert) {
        Integer recordCount = Trigger.New.size();
        // Call a utility method from another class
        EmailManager.sendMail('Your email address', 'Trailhead Trigger Tutorial', 
                    recordCount + ' contact(s) were inserted.');
    }
    else if (Trigger.isDelete) {
        // Process after delete
    }
}