/**
 * The `PropertyListPage` class. Lorem ipsum dolor sit amet, consectetur adipiscing elit,
 * sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
 * veniam, quis nostrud exercitation ullamco laboris nis.
 *
 * @author Salesforce.com
 * @since Jul 2017
 * @see [License](https://github.com/dreamhouseapp/dreamhouse-sfdx/blob/master/LICENSE)
 * @see [Github](https://github.com/dreamhouseapp/dreamhouse-sfdx)
 */
public class PropertyListPage {
    
    /** The description column will show up any time there's a description on a property. */    
    @AuraEnabled
    public Integer pageSize { get;set; }
    
    @AuraEnabled
    public Integer pageNumber { get;set; }
    
    @AuraEnabled
    public Integer total { get;set; }
    
    @AuraEnabled
    public List<Property__c> properties { get;set; }
}