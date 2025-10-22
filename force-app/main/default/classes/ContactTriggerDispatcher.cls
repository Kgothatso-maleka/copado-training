public class ContactTriggerDispatcher {
    public static void run(System.TriggerOperation opt,List<SObject> newList,Map<Id,SObject> oldMap){
        switch on opt{
            WHEN AFTER_UPDATE{
                List<Contact> contacts = (List<Contact>) newList;
                Map<Id, Contact> oldContacts = (Map<Id, Contact>) oldMap;
                ContactTriggerHandler.publishBounceManagement(contacts, oldContacts);
            }
        }
    }
}