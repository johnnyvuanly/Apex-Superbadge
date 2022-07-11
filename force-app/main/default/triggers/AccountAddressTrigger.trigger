/* This trigger sets the accounts shipping postal code to match the billing 
postal code, if the custom field check box is selected */

trigger AccountAddressTrigger on Account (before insert, before update) {

    // For every account that is going to be inserted or updated
    for(Account a : Trigger.New) {
        if (a.Match_Billing_Address__c == true ) {
            // refactored code so that the entire shipping address matches billing
            a.ShippingPostalCode = a.BillingPostalCode;
            a.ShippingStreet = a.BillingStreet;
            a.ShippingCity = a.BillingCity;
            a.ShippingState = a.BillingState;
            a.shippingcountry = a.BillingCountry;
        }
    }
}


