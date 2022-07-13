/* This class is a create a contact test factory for test contacts data.. Trailhead challenege 
did not want you to annotate with @isTest and @testMethod but typically you would */

public class RandomContactFactory {
    /* This method returns a list of Contacts. Two parameters number of contacts to genereate 
    and the last name of the contact */
    public static List<Contact>generateRandomContacts (Integer numContacts, String lastName) {
        List<Contact> contacts = new List<Contact>();

        for(Integer i=0;i<numContacts;i++) {
            Contact c = new Contact(FirstName='TestContact' + i, LastName=lastName);
            contacts.add(c);
        }
        return contacts;
    }
}
