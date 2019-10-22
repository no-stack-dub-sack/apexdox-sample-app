/**
 * Handler Mapping inner class. Lorem ipsum dolor sit amet, consectetur adipiscing elit,
 * sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
 * veniam, quis nostrud exercitation ullamco laboris nis.
 * <br><br>
 * If you're reading this in code, this is the only class in the "Dreamhouse Bot" group
 * which includes a `group-content` tag. It only needs to be defined once for the entire
 * group.
 *
 * @author Salesforce.com
 * @since Jul 2017
 * @group Dreamhouse Bot
 * @group-content ./doc-assets/Bot.html
 * @see [License](https://github.com/dreamhouseapp/dreamhouse-sfdx/blob/master/LICENSE)
 * @see [Github](https://github.com/dreamhouseapp/dreamhouse-sfdx)
 * @see ThisClass.andMethodDoNotExist
 */
public with sharing class BotController {

    /**
     * Handler Mapping inner class. Lorem ipsum dolor sit amet, consectetur adipiscing elit,
     * sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
     */
    class HandlerMapping {
        
        public String handlerClassName;
        public Pattern utterancePattern;

        public HandlerMapping(String handlerClassName, String patternStr) {
            this.handlerClassName = handlerClassName;
            this.utterancePattern = Pattern.compile(patternStr);
        }

    }

    /**
     * A list of `HandlerMapping` instances.
     */    
    static List<HandlerMapping> handlerMappings;
    
    static {
        List<Bot_Command__c> commands = [SELECT apex_class__c, pattern__c FROM Bot_Command__c WHERE Active__c = True ORDER BY Name];
        System.debug(commands);
        List<HandlerMapping> mappings = new List<HandlerMapping>();
        for (Bot_Command__c command : commands) {
			mappings.add(new HandlerMapping(command.apex_class__c, command.pattern__c));
        }
        handlerMappings = mappings;
    }
    
    /**
     * The method that handles submitting the data. `Lorem ipsum dolor` sit amet, consectetur
     * adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
     * @param utterance Utterance description. 
     * @param session Session description.
     * @param fileName Filename description.
     * @param fileContent FileContent description.
     * @returns Returns a `BotResponse` instance.
     * @see BotHandler.handle
     */    
    @AuraEnabled
    public static BotResponse submit(String utterance, Map<String, String> session, String fileName, String fileContent) {
        
        try {
            
            if (session != null) {
                String nextCommand = session.get('nextCommand');
                if (nextCommand != null) {
                    Type t = Type.forName('', nextCommand);
                    BotHandler h = (BotHandler)t.newInstance();
                    return h.handle(utterance, null, session, fileName, fileContent);
                }
            }
        
            for (HandlerMapping mapping : BotController.handlerMappings) {
                Matcher utteranceMatcher = mapping.utterancePattern.matcher(utterance);
                if (utteranceMatcher.matches()) {
                    Type t = Type.forName('', mapping.handlerClassName);
                    BotHandler h = (BotHandler)t.newInstance();
                    List<String> params = new List<String>();
                    for (Integer i=1; i<=utteranceMatcher.groupCount(); i=i+1) {
                        params.add(utteranceMatcher.group(i).trim());
                    }
                    return h.handle(utterance, params, session, fileName, fileContent);
                }
            }
            
            return new BotResponse(new BotMessage('Bot', 'I don\'t know how to answer that'));
            
        } catch (Exception e) {
            System.debug(e);                
            return new BotResponse(new BotMessage('Bot', 'Oops, something went wrong invoking that command'));
        }
        
    }
    
}