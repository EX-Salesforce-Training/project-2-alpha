trigger ClassRegistrationTrigger on Class_Registration__C (after insert) {
    switch on trigger.operationType {
        when AFTER_INSERT {
            ClassRegistrationTriggerHandler.HandleAfterInsert(Trigger.New);
        }
    }
}