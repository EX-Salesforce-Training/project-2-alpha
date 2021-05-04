trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    switch on trigger.operationType {
        when BEFORE_INSERT {
            
        }
        when BEFORE_UPDATE {
            
        }
        when BEFORE_DELETE {
            
        }
        when AFTER_INSERT {
            AccountTriggerHandler.LinkPrimary(trigger.new);
        }
        when AFTER_UPDATE {
            AccountTriggerHandler.LinkPrimary(trigger.new);
        }
        when AFTER_DELETE {
            
        }
        when AFTER_UNDELETE {
            
        }
    }
}