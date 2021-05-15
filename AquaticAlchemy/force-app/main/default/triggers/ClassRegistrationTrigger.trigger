trigger ClassRegistrationTrigger on ClassRegistation__C (after insert) {
    switch on trigger.operationType {
        when AFTER_INSERT {
            ClassRegistrationTriggerHandler.HandleAfterInsert(Trigger.New);
        }
    }
}