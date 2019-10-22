/**
 * The `PushPriceChangeNotification` class. Lorem ipsum dolor sit amet, consectetur adipiscing elit,
 * sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
 * veniam, quis nostrud exercitation ullamco laboris nis.
 *
 * @author Salesforce.com
 * @since Jul 2017
 * @see [License](https://github.com/dreamhouseapp/dreamhouse-sfdx/blob/master/LICENSE)
 * @see [Github](https://github.com/dreamhouseapp/dreamhouse-sfdx)
 * @group Dreamhouse Slack Bot
 */
public with sharing class PushPriceChangeNotification {
    /**
     * Incididunt ut labore et dolore magna aliqua, quis autem vel eum iure reprehenderit qui incididunt.
     * @param propertyId Incididunt ut labore et dolore magna aliqua
     */    
    @InvocableMethod(label='Push Price Change Notification')
    public static void pushNotification(List<Id> propertyId) {
        String pushServerURL;
	    Dreamhouse_Settings__c settings = Dreamhouse_Settings__c.getOrgDefaults();
        if (!Test.isRunningTest()) {
        	if (settings == null || settings.Push_Server_URL__c == null) {
	            System.debug('Push_Server_URL not set. Aborting PushPriceChangeNotification process action');
                return;
            } else {
            	pushServerURL = settings.Push_Server_URL__c;    
            }
        }
        Id propId = propertyId[0]; // If bulk, only post first to avoid spamming
        Property__c property = [SELECT Name, Price__c from Property__c WHERE Id=:propId];
        String message = property.Name + '. New Price: $' + property.Price__c.setScale(0).format();
        
        Set<String> userIds = new Set<String>();

        List<Property_Favorite__c> favorites = [SELECT user__c from Property_Favorite__c WHERE property__c=:propId];
        for (Property_Favorite__c favorite : favorites) {
        	userIds.add(favorite.user__c);	    
        }
        
		Map<String,Object> payload = new Map<String,Object>();
		payload.put('message', message);
		payload.put('userIds', userIds);
        String body = JSON.serialize(payload);    
        System.enqueueJob(new QueueablePushCall(pushServerURL, 'POST', body));
    }
    
    /**
     * An inner enum added to demonstrate how ApexDox VS Code handles inner
     * enums. They can only have description's, like properties. ApexDox
     * Should be able to handle to wonky way this enum is written in code.
     */    
    public enum SomeEnumAddedForExamplePurposes { JANUARY, FEBRUARY,
        MARCH,
        APRIL,
        MAY, JUNE, JULY,
        AUGUST, SEPTEMBER
        , OCTOBER
        , NOVEMBER
        , DECEMBER
    }

    /**
     * A good example of how ApexDox VS Code handles inner classes.
     * Inner classes / interfaces support the same tags as their top-level
     * counterparts (i.e. top level type in a .cls file), but tags like 'author'
     * and 'since' are better left to the top-level class. Just for example's sake,
     * including an example tag here as well.
     * @group Group tags in inner classes or interfaces will be ignored
     * 
     * @example 
     * Dreamhouse_Settings__c settings = Dreamhouse_Settings__c.getOrgDefaults();
     * String pushServerURL = settings.Push_Server_URL__c;  
     * String body = 'This is a message, equeued up to be posted on Slack!';
     * System.enqueueJob(new QueueablePushCall(pushServerURL, 'POST', body));
     */   
    public class QueueablePushCall implements System.Queueable, Database.AllowsCallouts {
        
        private final String url;
        private final String method;
        private final String body;
        
        /**
         * @param url The Server Url to post the message to.
         * @param method The HTTP method to use
         * @param body The body of the message.
         */
        public QueueablePushCall(String url, String method, String body) {
            this.url = url;
            this.method = method;
            this.body = body;
        }
        
        /**
         * The execute method implements the `System.Queueable` interface. And
         * handle's the queueable's execution.
         * @param ctx The `System.QueueableContext` for the execute method.
         */    
        public void execute(System.QueueableContext ctx) {
            HttpRequest req = new HttpRequest();
            req.setMethod(method);
            req.setHeader('Content-Type', 'application/json');
            req.setBody(body);
            Http http = new Http();
            HttpResponse res;
            if (!Test.isRunningTest()) {
	            req.setEndpoint(url);
	        	res = http.send(req);
            }
        }
    }
}