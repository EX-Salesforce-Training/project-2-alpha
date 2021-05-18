@isTest
public class ApexCarouselControllerTest {
    
    @isTest
    public static void CarouselTest(){
        Datetime activityDate = System.today()+24;
        Public_Event__c event = new Public_Event__c(ActivityDate__c = activityDate);
        insert event;
        ApexCarouselController.GetEvents();
    }

}