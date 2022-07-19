/* To test your POST callout in the Animals Callout class we implement the HttpCalloutMock interface. This enables you to 
specify the response that's sent in the respond method. Your test class instructs Apex runtime to send this fake response 
by calling Test.setMock. First arguement, pass HttpCalloutMock.class and the second argument pass AnimalsHttpCalloutMock */

@isTest
global class AnimalsHttpCalloutMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}');
        response.setStatusCode(200);
        return response; 
    }
}