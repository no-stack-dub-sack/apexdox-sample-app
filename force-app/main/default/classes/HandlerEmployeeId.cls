/**
 * Handle emp. id `BotHandler` implementation.
 * @see BotHandler
 * @author Salesforce.com
 * @since Jul 2017
 * @see [License](https://github.com/dreamhouseapp/dreamhouse-sfdx/blob/master/LICENSE)
 * @see [Github](https://github.com/dreamhouseapp/dreamhouse-sfdx)
 * @group Dreamhouse Bot Handlers
 */
public with sharing class HandlerEmployeeId implements BotHandler {
    
    public BotResponse handle(String utterance, String[] params, Map<String, String> session, String fileName, String fileContent) {
        return new BotResponse(new BotMessage('Bot', 'Your employee id is 9854'));
    }
    
}