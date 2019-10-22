/**
 * The `PostPriceChangeToSlack` class. Lorem ipsum dolor sit amet, consectetur adipiscing elit,
 * sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
 * veniam, quis nostrud exercitation ullamco laboris nis.
 *
 * @author Salesforce.com
 * @since Jul 2017
 * @see [License](https://github.com/dreamhouseapp/dreamhouse-sfdx/blob/master/LICENSE)
 * @see [Github](https://github.com/dreamhouseapp/dreamhouse-sfdx)
 * @group Dreamhouse Slack Bot
 */
public class PostPriceChangeToSlack {

    /**
     * Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
     * ut labore et dolore magna aliqua. Ut enim ad veniam, quis nostrud exercitation ullamco laboris nis.
     * @param propertyId A list of property IDs to post to Slack.
     */    
    @InvocableMethod(label='Post Price Change Notification to Slack')
    public static void postToSlack(List<Id> propertyId) {
		String slackURL;
	    Dreamhouse_Settings__c settings = Dreamhouse_Settings__c.getOrgDefaults();
        if (!Test.isRunningTest()) {
        	if (settings == null || settings.Slack_Property_Webhook_URL__c == null) {
		        System.Debug('Slack_Property_Webhook_URL not set. Aborting PostPriceChangeToSlack process action');
                return;
            } else {
            	slackURL = settings.Slack_Property_Webhook_URL__c;   
            }
        }
        Id propId = propertyId[0]; // If bulk, only post first to avoid spamming
        Property__c property = [SELECT Address__c, City__c, State__c, Price__c from Property__c WHERE Id=:propId];
        String message = 'Price change: ' + property.Address__c + ', ' + property.City__c + ' ' + property.State__c + ' is now *$' + property.Price__c.setScale(0).format() + '*';
        System.Debug(message);
        
		Map<String,Object> payload = new Map<String,Object>();
		payload.put('text', message);
		payload.put('mrkdwn', true);
        String body = JSON.serialize(payload);    
        System.Debug(body);
        System.enqueueJob(new QueueableSlackCall(slackURL, 'POST', body));
    }

    /**
     * An inner enum added to demonstrate how ApexDox VS Code handles inner
     * enums. They can only have description's, like properties. ApexDox
     * Should be able to handle to wonky way this enum is written in code.
     */    
    public enum Months { JANUARY, FEBRUARY,
        MARCH,
        APRIL,
        MAY, JUNE, JULY,
        AUGUST, SEPTEMBER
        , OCTOBER
        , NOVEMBER
        , DECEMBER
    }

    /**
     * An inner enum added to demonstrate how ApexDox VS Code handles inner
     * enums. They will be presented in a table and can only have
     * description's, like properties.
     */    
    public enum Days {
        MONDAY,
        TUESDAY,
        WEDNESDAY,
        THURSDAY,
        FRIDAY,
        SATURDAY,
        SUNDAY
    }

    /**
     * An inner enum added to demonstrate how ApexDox VS Code handles inner
     * enums. They will be presented in a table and can only have
     * description's, like properties.
     */    
    public enum Numbers {
        ONE,
        TWO,
        THREE,
        FOUR,
        FIVE,
        SIX,
        SEVEN,
        EIGHT,
        NINE,
        TEN
    }

    /**
     * A good example of how ApexDox VS Code handles inner classes.
     * Inner classes / interfaces support the same tags as their top-level
     * counterparts (i.e. top level type in a .cls file), but tags like 'author'
     * and 'since' are better left to the top-level class. Just for example's sake,
     * including an example tag here as well.
     * 
     * @example 
     * Dreamhouse_Settings__c settings = Dreamhouse_Settings__c.getOrgDefaults();
     * String slackUrl = settings.Slack_Property_Webhook_URL__c;  
     * String body = 'This is a message, equeued up to be posted on Slack!';
     * System.enqueueJob(new QueueableSlackCall(slackURL, 'POST', body));
     */    
    public class QueueableSlackCall implements System.Queueable, Database.AllowsCallouts {
        
        private final String url;
        private final String method;
        private final String body;
        
        /**
         * @param url The Slack Url to post the message to.
         * @param method The HTTP method to use
         * @param body The body of the message.
         */        
        public QueueableSlackCall(String url, String method, String body) {
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