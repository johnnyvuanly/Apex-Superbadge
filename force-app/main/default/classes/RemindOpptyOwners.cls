/* This sample class shows the syntax of an Apex class with Apex. Scheduler. Apex Scheduler lets you 
delay execution so that you can run Apex classes at a specified time. This ideal for daily or weekly 
maintenance tasks using Batch Apex. To take advantage of the scheduler, the Apex class has to implement 
the Schedulable interface, and then schedule it for execution on a specific schedule */


/* This class queries for open opportunities that should have closed by the current date, and creates a 
task on each one to remind the owner to update the opportunity */
public class RemindOpptyOwners implements Schedulable {
    // You can schedule your class to run either programmitcally or from the Apex Scheduler UI
    public void execute(SchedulableContext ctx) {
        List<Opportunity> opptys = [SELECT Id, Name, OwnerId, CloseDate
            FROM Opportunity
            WHERE IsClosed = False AND
            CloseDate < TODAY];
        // Create a task for each opportunity in the list
        TaskUtils.remindOwners(opptys);
    }
}

/* After you implement a class with the Schedulable interface, use the System.Schedule method to execute it. 

RemindOpptyOwners reminder = new RemindOpptyOwners();
// Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
String sch = '20 30 8 10 2 ?';
// Takes three arguements a name for the job, CRON expression used to represent time, and an instance of a 
// class that implements the schedulable interface
String jobID = System.schedule('Remind Opp Owners', sch, reminder);

*/
