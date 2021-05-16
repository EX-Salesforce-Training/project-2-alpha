///////////////////////////////////////////////////////////////
//
// Name: JobPostingAuraControllerTest.cls
// Author: David Serrano, Salesforce Developer
// Created: 05/8/21
// Updated: 05/13/21
// Description: Apex test class to help run unit tests against the JobPostingAuraController class.
//
///////////////////////////////////////////////////////////////

@isTest
public class JobPostingAuraControllerTest {

    // loadPostsTests creates a harded coded amount of job posts that would be displayed on the component
    // The tests asserts the lists received from the Aura controller is equal to the amount of job posts created.
    @isTest
    public static void loadPostsTest(){
        List<Job_Postings__c> jList = new List<Job_Postings__c>();
        for(Integer i = 0; i < 8; i++){
            Datetime dt = Datetime.now();
            Job_Postings__c j = new Job_Postings__c(Name='job'+i, Post_Date__c= dt.date());
            jList.add(j);
        }
        insert jList;
        
        List<Job_Postings__c> generatedList = JobPostingAuraController.getPosts();
        
        system.assertEquals(jList.size(), generatedList.size());  
    }
    
    // loadMaxPostTests creates an amount of jobs posts higher than the amount to be displayed on the component. 
    // The tests asserts that the returned list from the Aura controller does not exceed the cap (10).
    @isTest
    public static void loadMaxPostTest(){
        List<Job_Postings__c> jList = new List<Job_Postings__c>();
        for(Integer i = 0; i < 25; i++){
            Datetime dt = Datetime.now();
            Job_Postings__c j = new Job_Postings__c(Name='job'+i, Post_Date__c= dt.date());
            jList.add(j);
        }
        insert jList;
        
        List<Job_Postings__c> generatedList = JobPostingAuraController.getPosts();
        
        system.assertEquals(10, generatedList.size());  
    }
    
}