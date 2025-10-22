trigger ContactTrigger on Contact (before insert,after insert,before update,after update,before delete,after delete,after undelete) {
    
      ContactTriggerDispatcher.run(Trigger.operationType, Trigger.new, Trigger.oldMap);
   
    //ContactTriggerDispatcher.run(Trigger.operationType);
}