/* One of the best features of Queueable Apex is job chaining. To chain a job to 
another job, submit the second job from the execute() method of your queuable class. 
You can add only one job from an executing job, which means that only one child job 
can exist for each parent job */

public class FirstJob implements Queueable {
    public void execute(QueueableContext context) {
        // Awesome processing logic here
        // Chain this job to next job by submitting the next job
        System.enqueueJob(new SecondJob());
    }
}
