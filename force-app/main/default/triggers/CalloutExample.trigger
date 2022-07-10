/* When making a callout from a trigger, the callout must be done asynchronously 
so that the trigger process doesn't block you from working while waiting for the 
external service's response is recieved when the external service returns it. To 
make a callout from a trigger, call a class method that executes asynchronously. 
Such a method is called a future method and is annotated with @future(callout=true) */

trigger CalloutExample on Account (before insert, before update) {
    CalloutClass.makeCallout();
}