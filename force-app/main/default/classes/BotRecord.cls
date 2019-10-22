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
 * @see BotField
 */
public class BotRecord {

    /**
     * Public, AuraEnabled list of `BotField` records. `BotRecord`s data.
     */    
    @AuraEnabled 
    public List<BotField> fields { get;set; }
    
    /**
     * Basic constructor for `BotRecord` class.
     * @param fields Fields param description.
     */    
    public BotRecord(List<BotField> fields) {
        this.fields = fields;
    }
}