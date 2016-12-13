trigger generateLeadTrackingNo on Lead (after insert) {

    List<ID> accountIdList = new List<ID>();
    List<ID> leadIdList = new List<ID>();
    Map<ID,Integer> AccountAndNoOfLeads = new Map<ID, Integer>();
    
    for(Lead l :trigger.new){
        accountIdList.add(l.account__c);
        leadIdList.add(l.id);
    }
    
    if(accountIdList!=null && accountIdList.size()>0){
        List<Lead> existingLead=[Select id,account__r.AccountNumber,account__c,recordtype.name, name from lead where account__c in :accountIdList];
        if(existingLead.size()>0){
            for(integer i=0;i<existingLead.size();i++){
                if(AccountAndNoOfLeads.containsKey(existingLead[i].account__c))
                    AccountAndNoOfLeads.put(existingLead[i].account__c,AccountAndNoOfLeads.get(existingLead[i].account__c)+1);
                else
                    AccountAndNoOfLeads.put(existingLead[i].account__c,2);   
            }
        }
        else{
            for(integer i=0;i<accountIdList.size();i++){
                AccountAndNoOfLeads.put(accountIdList[i],1);     
            }
        }
    }
    
    List<Lead> Leadlist=[Select id, name,account__r.AccountNumber,recordtype.name from lead where id in :leadIdList];
    for(Lead l :Leadlist){
        Integer count = AccountAndNoOfLeads.get(l.account__c);
        String countString = String.valueof(count);
        if(countString.length()==1)
            countString='000'+countString; 
        if(countString.length()==2)
            countString='00'+countString; 
        if(countString.length()==3)
            countString='0'+countString;  
        l.Lead_Tracking_No__c=l.recordtype.name+'-'+l.account__r.AccountNumber+'-'+countString;
    }
    
    update Leadlist;
}