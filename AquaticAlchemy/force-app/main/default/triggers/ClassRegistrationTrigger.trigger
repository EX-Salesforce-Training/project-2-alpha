trigger ClassRegistrationTrigger on ClassRegistation__C (after insert) {
    switch on trigger.operationType {
        when AFTER_INSERT {
            OrderBookTriggerHandler.HandleBeforeInsert(Trigger.New);
        }
    }
}