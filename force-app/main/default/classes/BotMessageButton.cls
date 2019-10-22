/**
 * The `BotMessageButton` class. Lorem ipsum dolor sit amet, consectetur adipiscing elit,
 * sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
 * veniam, quis nostrud exercitation ullamco laboris nis.
 *
 * @author Salesforce.com
 * @since Jul 2017
 * @see [License](https://github.com/dreamhouseapp/dreamhouse-sfdx/blob/master/LICENSE)
 * @see [Github](https://github.com/dreamhouseapp/dreamhouse-sfdx)
 * @group Dreamhouse Bot
 */
public class BotMessageButton {

    @AuraEnabled public String label { get;set; }
    @AuraEnabled public String value { get;set; }

    /**
     * Convenience constructor to create a simple bot message button.
     * @param label Label param description
     * @param value value param description
     */    
    public BotMessageButton(String label, String value) {
        this.label = label;
        this.value = value;
    }
}