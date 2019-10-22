/**
 * Basic webservice class included here to for demo purposes. Try filtering
 * by webService using the scoping / 'show' panel. <br><br>
 * This class should be hidden / shown in the menu when you toggle the webService scope.
 *
 * @author Salesforce.com
 * @since 2019
 * @group Global Utils
 */
global class MyWebService {
    webservice static Id makeContact(String contactLastName, Account a) {
        Contact c = new Contact(lastName = contactLastName, AccountId = a.Id);
        insert c;
        return c.id;
    }
}