@isTest
public class ApexFilterControllerTest {
	
    @isTest
    public static void TestFilter(){
        Datetime activityDate = System.today();
        Datetime endTime = activityDate+1;
        Public_Event__c event = new Public_Event__c(Subject__c = 'Aquatic Class', ActivityDate__c = activityDate, EndDateTime__c = endTime, IsAllDayEvent__c = false);
        insert event;
        ApexFilterController.FilterEvents(System.today());
    }
        
    
}