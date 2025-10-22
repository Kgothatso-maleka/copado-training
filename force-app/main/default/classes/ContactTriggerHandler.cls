public class ContactTriggerHandler {
    public static void publishBounceManagement(List<Contact> contactList,Map<Id,Contact> oldContactMap){
        List<Bounce_Management__e> bounceMngmList = new List<Bounce_Management__e>();
        for(Contact con:contactList){
            if(oldContactMap.get(con.Id).IsEmailBounced != con.IsEmailBounced){
                if(con.IsEmailBounced==true){
                    Bounce_Management__e bounceMngm = new Bounce_Management__e(
                        Email__c = con.Email,
                        Event_Date__c = System.Now(),
                        Reason__c = con.EmailBouncedReason,
                        WhoId__c = con.Id
                    );
                    bounceMngmList.add(bounceMngm);
                }
            }
            
            
        }
        if(!bounceMngmList.isEmpty()){
            List<Database.SaveResult> results = EventBus.publish(bounceMngmList);
            for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    System.debug('Successfully published event.');
                } else {
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('Error returned: ' +err.getStatusCode() +' - ' +err.getMessage());
                    }
                }    
            }
            
            
        }
    }
}