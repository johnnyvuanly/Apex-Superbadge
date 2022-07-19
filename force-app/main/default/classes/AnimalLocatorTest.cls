@isTest
private class AnimalLocatorTest {
    
    @isTest
    static void AnimalLocatorTest1() {
        // First set our mock
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String actual = AnimalLocator.getAnimalNameById(1);
        String expected = 'moose';
        System.assertEquals(actual, expected);
    }
}
