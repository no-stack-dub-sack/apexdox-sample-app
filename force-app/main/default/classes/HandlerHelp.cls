/**
 * Handle help `BotHandler` implementation.
 * @see BotHandler
 * @author Salesforce.com
 * @since Jul 2017
 * @see [License](https://github.com/dreamhouseapp/dreamhouse-sfdx/blob/master/LICENSE)
 * @see [Github](https://github.com/dreamhouseapp/dreamhouse-sfdx)
 * @group Dreamhouse Bot Handlers
 */
public with sharing class HandlerHelp implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
        
		List<Bot_Command__c> commands = 
            [SELECT Id, Sample_Utterance__c FROM Bot_Command__c
             WHERE Sample_Utterance__c != null And Active__C = True ORDER BY Sample_Utterance__c];

		List<BotItem> items = new List<BotItem>();
        
        for (Bot_Command__c c : commands) {
            items.add(new BotItem(c.Sample_Utterance__c));
        }

        BotMessage message = new BotMessage('Bot', 'You can ask me things like:', items);
        return new BotResponse(message);
    }
    
}