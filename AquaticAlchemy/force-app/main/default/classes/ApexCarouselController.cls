public class ApexCarouselController {
    
    @AuraEnabled 
    public static List<Public_Event__c> GetEvents(){
        List<Public_Event__c> events = [SELECT ActivityDate__c, Description__c, Name FROM Public_Event__c WHERE ActivityDate__c = NEXT_90_DAYS];
        return events;
    }

}