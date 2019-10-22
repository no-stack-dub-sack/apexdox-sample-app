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
 * @see BotMessage
 * @example
 * // ...
 * if (session == null) {
 *     BotMessage message = new BotMessage('Bot', 'What City?');
 *     session = new Map<String, String>();
 *     session.put('nextCommand', 'HandlerFindProperties');
 *     session.put('step', 'city');
 *     return new BotResponse(message, session);
 * }
 * // ...
 */
public class BotResponse {

    @AuraEnabled public List<BotMessage> messages { get; set; }
    @AuraEnabled public Map<String, String> session { get; set; }
    
    public BotResponse() {
    }

    /**
     * Constructor to create a response with multiple messages.
     * @param messages A list of `BotMessage`s to create the response with.
     * @param messages 
     */    
    public BotResponse(BotMessage[] messages) {
        this.messages = messages;
    }

    /**
     * Constructor to create a response with multiple messages.
     * @param messages A list of `BotMessage`s to create the response with.
     * @param session The session to use.
     */ 
    public BotResponse(List<BotMessage> messages, Map<String, String> session) {
        this.messages = messages;
        this.session = session;
    }

    /**
     * Convenience constructor to create a response with a single message
     * @param message A `BotMessage` instance to create the response with.
     */
    public BotResponse(BotMessage message) {
        this.messages = new BotMessage[]{message};
    }

    /**
     * Convenience constructor to create a response with a single message
     * @param message A `BotMessage` instance to create the response with.
     * @param session The session to use.
     */    
    public BotResponse(BotMessage message, Map<String, String> session) {
        this.messages = new BotMessage[]{message};
        this.session = session;
    }
}