trigger ClassRosterTrigger on Class_Roster__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    switch on trigger.operationType {
        when BEFORE_INSERT {
            ClassRosterTriggerHandler.AutoAddCharge(trigger.new);
        }
        when BEFORE_UPDATE {
            
        }
        when BEFORE_DELETE {
            
        }
        when AFTER_INSERT {
            
        }
        when AFTER_UPDATE {
            
        }
        when AFTER_DELETE {
            
        }
        when AFTER_UNDELETE {
            
        }
    }
}