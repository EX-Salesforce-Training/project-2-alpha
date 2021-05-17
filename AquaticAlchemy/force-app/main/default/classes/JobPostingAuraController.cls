///////////////////////////////////////////////////////////////
//
// Name: JobPostingAuraController.cls
// Author: David Serrano, Salesforce Developer
// Created: 05/8/21
// Updated: 05/13/21
// Description: Apex Aura controller to query the job postings available to be applied for.
//
///////////////////////////////////////////////////////////////

public class JobPostingAuraController {
	
    @AuraEnabled
    public static List<Job_Postings__c> getPosts(){
        List<Job_Postings__c> postings = [SELECT Id, Name, Description__c, Post_Date__c FROM Job_Postings__c LIMIT 10];
        return postings;
    }
    
}