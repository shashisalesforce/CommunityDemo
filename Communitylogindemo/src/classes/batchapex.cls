//sample
public class batchapex implements Database.batchable<account__c>{

    public Iterable<account__c> start(Database.BatchableContext bc){
        List<account__c> lc = [Select name, account_number__c from account__c];
        return lc;
    }
    public void execute(Database.BatchableContext bc, List<account__c> lc)
    {
        for(account__c c:lc){
            c.name = 'abc';
            update c;
        }
        
    }
    public void finish(Database.BatchableContext bc){
        system.debug('Finishhhhhhhhhhhh');
        
    }
}