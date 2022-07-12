@isTest
public class TestRestrictContactByName {
    @isTest static void createBadContact() {
        // Test data setup 
        // Create a contact with the invalid last name 
        Contact con = new Contact(FirstName='John', LastName='INVALIDNAME');

        // perform test
        Test.startTest();
        // Inserting the new contact through a database method instead of, insert con; statement
        Database.SaveResult result = Database.insert(con, false);
        Test.stopTest();

        // Verify that the insertion was not a success
        System.assert(!result.isSuccess());
    }
}
