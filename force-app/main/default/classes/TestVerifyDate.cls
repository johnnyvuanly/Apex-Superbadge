@isTest
public class TestVerifyDate {
    // Testing CheckDates method 
    @isTest static void within30Days() {
        // Pass two dates that are within 30 days of each other 
        Date returnDate = VerifyDate.CheckDates(date.valueOf('2022-07-12'), date.valueOf('2022-07-22'));
        // Second date should return because the first date is WITHIN 30 days of the second 
        System.assertEquals(date.valueOf('2022-07-22'), returnDate);
    }

    // Testing CheckDates method 
    @isTest static void notWithin30days() {
        // Pass two dates that are within 30 days of each other 
        Date returnDate2 = VerifyDate.CheckDates(date.valueOf('2022-07-12'), date.valueOf('2022-08-22'));
        // If date is NOT WITHIN 30 days the CheckDates method should return the end of the month of the first date
        System.assertEquals(date.valueOf('2022-07-31'), returnDate2);
    }
}