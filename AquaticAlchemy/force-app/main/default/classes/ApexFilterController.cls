public class ApexFilterController {
    
    @AuraEnabled 
    public static List<Public_Event__c> FilterEvents(Date filterCriteria){
        List<Public_Event__c> events = [SELECT Subject__c, ActivityDate__c, EndDateTime__c, IsAllDayEvent__c FROM Public_Event__c WHERE DAY_ONLY(convertTimeZone(ActivityDate__c)) =: filterCriteria];
        return events;
    }

}