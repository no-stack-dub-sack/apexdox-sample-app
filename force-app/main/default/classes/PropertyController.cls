/**
 * The `PropertyController` class. Lorem ipsum dolor sit amet, consectetur adipiscing elit,
 * sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
 * veniam, quis nostrud exercitation ullamco laboris nis.
 *
 * @author Salesforce.com
 * @since Jul 2017
 * @see [License](https://github.com/dreamhouseapp/dreamhouse-sfdx/blob/master/LICENSE)
 * @see [Github](https://github.com/dreamhouseapp/dreamhouse-sfdx)
 */
global with sharing class PropertyController {

    /**
     * @description           If you're reading this in code, this is what it looks like when you have
     *                        the `ApexDox.docBlock.alignItems` setting set to `true` and are not
     *                        ommiting the description tag via `ApexDox.docBlock.omitDescriptionTag`.
     * @param searchKey       Incididunt ut labore et dolore magna aliqua
     * @param minPrice        Incididunt ut labore et dolore magna aliqua
     * @param maxPrice        Incididunt ut labore et dolore magna aliqua
     * @param numberBedrooms  Incididunt ut labore et dolore magna aliqua
     * @param numberBathrooms Incididunt ut labore et dolore magna aliqua
     * @param visualSearchKey Incididunt ut labore et dolore magna aliqua
     * @returns               Returns a `Property__c[]` list
     * @see                   [ApexDox Settings](https://github.com/no-stack-dub-sack/apexdox-vs-code#extension-settings)
     */            
    @AuraEnabled(cacheable=true)
    public static Property__c[] getPropertyList(String searchKey, Decimal minPrice, Decimal maxPrice, Integer numberBedrooms, Integer numberBathrooms, String visualSearchKey) {
        String key = '%' + searchKey + '%';
        String visualKey = '%' + visualSearchKey + '%';
        return [SELECT Id, address__c, city__c, state__c, description__c, price__c, baths__c, beds__c, thumbnail__c, location__latitude__s, location__longitude__s FROM property__c
                      WHERE (title__c LIKE :key OR city__c LIKE :key OR tags__c LIKE :key)
                      AND (title__c LIKE :visualKey OR city__c LIKE :visualKey OR tags__c LIKE :visualKey)
                      AND price__c >= :minPrice
					  AND price__c <= :maxPrice
                      AND beds__c >= :numberBedrooms
                      AND baths__c >= :numberBathrooms
                      ORDER BY price__c LIMIT 100];
    }
  
    /**
     * If you're reading this in code, this is what it looks like when you have 
     * the `ApexDox.docBlock.alignItems` setting set to `true` and are ommiting
     * the descrition tag via `ApexDox.docBlock.omitDescriptionTag`.
     * @param searchKey       Incididunt ut labore et dolore magna aliqua
     * @param minPrice        Incididunt ut labore et dolore magna aliqua
     * @param maxPrice        Incididunt ut labore et dolore magna aliqua
     * @param numberBedrooms  Incididunt ut labore et dolore magna aliqua
     * @param numberBathrooms Incididunt ut labore et dolore magna aliqua
     * @param visualSearchKey Incididunt ut labore et dolore magna aliqua
     * @param pageSize        Incididunt ut labore et dolore magna aliqua
     * @param pageNumber      Incididunt ut labore et dolore magna aliqua
     * @returns               Returns a `PropertyListPage`.
     * @see                   [ApexDox Settings](https://github.com/no-stack-dub-sack/apexdox-vs-code#extension-settings)
     */
    @AuraEnabled(cacheable=true)
    public static PropertyListPage getPropertyListPage(String searchKey, Decimal minPrice, Decimal maxPrice, Integer numberBedrooms, Integer numberBathrooms, String visualSearchKey, Decimal pageSize, Decimal pageNumber) {
		Integer pSize = (Integer)pageSize;
        String key = '%' + searchKey + '%';
        String visualKey = '%' + visualSearchKey + '%';
        Integer offset = ((Integer)pageNumber - 1) * pSize;
        PropertyListPage page =  new PropertyListPage();
        page.pageSize = pSize;
        page.pageNumber = (Integer) pageNumber;
        page.total = [SELECT count() FROM property__c 
                      WHERE (title__c LIKE :key OR city__c LIKE :key OR tags__c LIKE :key)
                      AND (title__c LIKE :visualKey OR city__c LIKE :visualKey OR tags__c LIKE :visualKey)
                      AND price__c >= :minPrice
                  	  AND price__c <= :maxPrice
                      AND beds__c >= :numberBedrooms
                      AND baths__c >= :numberBathrooms];
          page.properties = [SELECT Id, address__c, city__c, state__c, description__c, price__c, baths__c, beds__c, thumbnail__c FROM property__c 
                      WHERE (title__c LIKE :key OR city__c LIKE :key OR tags__c LIKE :key)
                      AND (title__c LIKE :visualKey OR city__c LIKE :visualKey OR tags__c LIKE :visualKey)
                      AND price__c >= :minPrice
					  AND price__c <= :maxPrice
                      AND beds__c >= :numberBedrooms
                      AND baths__c >= :numberBathrooms
                      ORDER BY price__c LIMIT :pSize OFFSET :offset];
        return page;
    }

    /**
     * Incididunt ut labore et dolore magna aliqua.
     * @param propertyId Incididunt ut labore et dolore magna aliqua
     * @returns Incididunt ut labore et dolore magna aliqua
     */        
    @AuraEnabled(cacheable=true)
    public static Property__c findById(Id propertyId) {
        return [SELECT id, name, beds__c, baths__c, address__c, city__c, state__c, assessed_value__c, price__c, Date_Listed__c, Location__Latitude__s, Location__Longitude__s 
                FROM Property__c
                WHERE Id=:propertyId];
    }

    /**
     * Incididunt ut labore et dolore magna aliqua
     * @returns Incididunt ut labore et dolore magna aliqua
     */    
    @AuraEnabled
    public static Property__c[] getAvailableProperties() {
        return [SELECT id, name, address__c, city__c, price__c, Date_Listed__c, Days_On_Market__c, Date_Agreement__c, Location__Latitude__s, Location__Longitude__s 
                FROM Property__c
                WHERE Date_Listed__c != NULL AND (Date_Agreement__c = NULL OR Date_Agreement__c = LAST_N_DAYS:90)];
    }
    
    /**
     * Incididunt ut labore et dolore magna aliqua
     * @returns Incididunt ut labore et dolore magna aliqua
     */ 
    @AuraEnabled
    public static Property__c[] getAtRiskProperties() {
        return [SELECT id, name, address__c, city__c, price__c, Thumbnail__c, Predicted_Days_On_Market__c 
                FROM Property__c
                WHERE Predicted_Days_On_Market__c > 30];
    }

    /**
     * Incididunt ut labore et dolore magna aliqua
     * @param propertyId Incididunt ut labore et dolore magna aliqua
     * @returns `List<Property__c>`
     */    
    @AuraEnabled(cacheable=true)
    public static List<Property__c> getComparableProperties(Id propertyId) {
        Property__c property = [SELECT Id, Price__c FROM Property__c WHERE Id = :propertyId];
        return [
            SELECT Id, Name, Address__c, City__c, State__c, Zip__c, Beds__c, Baths__c, Price__c, Predicted_Days_On_Market__c 
                FROM Property__c WHERE Id != :propertyId AND Price__c > :property.Price__c - 100000 AND Price__c < :property.Price__c + 100000 LIMIT 8
        ];
    }

    /**
     * Incididunt ut labore et dolore magna aliqua. Incididunt ut labore et dolore magna aliqua.
     * @param propertyId Incididunt ut labore et dolore magna aliqua
     * @param bedrooms Incididunt ut labore et dolore magna aliqua
     * @param price Incididunt ut labore et dolore magna aliqua
     * @param searchCriteria Incididunt ut labore et dolore magna aliqua
     * @returns `List<Property__c>`
     */    
    @AuraEnabled(cacheable=true)
    public static List<Property__c> getSimilarProperties (Id propertyId, Decimal bedrooms, Decimal price, String searchCriteria) {
        if (searchCriteria == 'Bedrooms') {
            return [
                SELECT Id, Name, Address__c, City__c, State__c, Zip__c, Beds__c, Baths__c, Price__c, Broker__c, Status__c, Thumbnail__c 
                FROM Property__c WHERE Id != :propertyId AND Beds__c = :bedrooms
            ];
        } else {
            return [
                SELECT Id, Name, Address__c, City__c, State__c, Zip__c, Beds__c, Baths__c, Price__c, Broker__c, Status__c, Thumbnail__c 
                FROM Property__c WHERE Id != :propertyId AND Price__c > :price - 100000 AND Price__c < :price + 100000
            ];
        }
    }

    /**
     * Incididunt ut labore et dolore magna aliqua. Incididunt ut labore et dolore magna aliqua.
     * @param propertyId Incididunt ut labore et dolore magna aliqua
     * @returns `List<ContentVersion>`
     */    
    @AuraEnabled
    public static List<ContentVersion> getPictures (Id propertyId) {

        List<ContentDocumentLink> links = [select id, LinkedEntityId, ContentDocumentId from ContentDocumentLink where LinkedEntityId=:propertyId];

        if (links.isEmpty()) {
            return null;
        }

        Set<Id> contentIds = new Set<Id>();

        for (ContentDocumentLink link :links) {
            contentIds.add(link.ContentDocumentId);
        }

        return [SELECT Id, Title FROM ContentVersion WHERE ContentDocumentId IN :contentIds AND IsLatest=true];
    }
}