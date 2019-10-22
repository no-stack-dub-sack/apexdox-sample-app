/**
 * The `PostPriceChangeToSlack` test class.
 *
 * @author Salesforce.com
 * @since Jul 2017
 * @see [License](https://github.com/dreamhouseapp/dreamhouse-sfdx/blob/master/LICENSE)
 * @see [Github](https://github.com/dreamhouseapp/dreamhouse-sfdx)
 * @group Dreamhouse Slack Bot
 */
@isTest
public class PostPriceChangeToSlackTest {
    
    static testMethod void testPost() {
        Boolean success = true;
        try {
            Property__c p = new Property__c(Name='test property', Price__c=200000);
            insert p;
	        PostPriceChangeToSlack.postToSlack(new List<Id> { p.Id });
        } catch (Exception e) {
            System.debug(e);
            success = false;
        } finally {
	        System.assert(success);
        }
    }
}