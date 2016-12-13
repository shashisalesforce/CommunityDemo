public with sharing class LeadCreationClass {

    public lead ld;
    public boolean showExistingLead{get;set;}
    public boolean disableSave{get;set;}
    
    Public List<Lead>LeadList {get;set;}
    public LeadCreationClass(ApexPages.StandardController controller) {
        ld=(Lead)controller.getRecord();
        LeadList =new list<lead>();
    }

    
     public PageReference saveRec(){
        LeadList=[Select id, FirstName,LastName, Email from lead where lastname =:ld.lastname];
        if(LeadList.size()>0){
            showExistingLead=true;
            disableSave=true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'A lead with similar information already exists'));
            return null;
        }
        else{
            insert ld;
            pagereference page = new pagereference('/'+ld.id);
            page.setredirect(true);
            return page;
        }
     }

}