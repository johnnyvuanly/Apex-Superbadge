/* Future methods are typically used for callouts to web services, 
operations you want to run on your own thread, when time permits such 
as some sort of resource intensive calculation or processing of records, 
and Isolating DML operations on different sObject types to prevent the 
mixed DML error */

/* Future methods must be static methods, and can only return a void type. 
Parameters must be primitive data types, arrays of primitive data types, or 
collections of primitive datta types. Can't take standard or custom objects 
as arguements */
public class futureMethodSyntax {
    @future
    public static void someFutureMethod(List<Id> recordIds) {
      List<Account> accounts = [Select Id, Name from Account Where Id IN :recordIds];
      // process account records to do awesome stuff
    }
}
