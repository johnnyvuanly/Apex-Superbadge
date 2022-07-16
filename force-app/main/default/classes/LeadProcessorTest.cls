@isTest
private class LeadProcessorTest {

    @isTest
    private static void testBatchClass() {

        // load test data
        List<Lead> leads = new List<Lead>();
        for (Integer i=0; i<200; i++) {
            leads.add(new Lead(LastName='Connock', Company='Salesforce'));
        }
        insert leads;

        // perform test
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        // Takes an instance of the batch class and optionally a batch size 
        Id batchId = Database.executeBatch(lp, 200);
        Test.stopTest();

        // check the result
        List<Lead> updatedLeads = [SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce'];
        // Asserting that expected value is 200 and the actual size is the size of updatedLeads list
        System.assertEquals(200, updatedLeads.size(), 'Error at least 1 lead record not updated correctly');

    }
}