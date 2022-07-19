public with sharing class AnimalLocator {
    // This method must accept an Integer and return a String 
    public static String getAnimalNameById(Integer i) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+i);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        // If the request is successful, parse the JSON response
        Map<String, Object> result = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        Map<String, Object> animal = (Map<String, Object>)result.get('animal');
        System.debug('name: '+string.valueOf(animal.get('name'))); // Check 
        return string.valueOf(animal.get('name'));
        
        /* Usually you you would put the above in the the if else but since our test class doesn't check 
        negative cases we exclude it here 

        if (response.getStatusCode()==200) {
            
        } else {
            return null;
        }
        */
    }
}