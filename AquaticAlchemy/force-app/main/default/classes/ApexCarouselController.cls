public class ApexCarouselController {
    
    @AuraEnabled 
    public static List<Public_Event__c> GetEvents(){
        List<Public_Event__c> events = [SELECT Image__c, ActivityDate__c, Description__c, Name, Subject__c FROM Public_Event__c WHERE ActivityDate__c = NEXT_90_DAYS AND Subject__c != 'Private Event'];
        return events;
    }

}