public class IncidentTriggerHandler {
	
    //Creates and assigns a task to the manager based off of a list of incidents
    public static void AssignTasksToManager(List<Incident__c> newIncidents) {
        List<Task> tasksToAdd = new List<Task>();
        User manager = GetAQManager();
        for (Incident__c incident : newIncidents) {
            Task newTask = CreateIncidentTask(incident, manager);
            tasksToAdd.add(newTask);
        }
        Insert tasksToAdd;
    }
    
    //Creates a new incident and populates relevant fields based off of an incident
    @testVisible
    private static Task CreateIncidentTask(Incident__c newIncident, User manager) {
        if (newIncident == null) return null;
        Task newTask = new Task();
        
        //Retrieve the name of the record type from the Schema
        String recordTypeName = Schema.SObjectType.Incident__c.getRecordTypeInfosById().get(newIncident.recordtypeid).getname();
        newTask.Subject = 'New ' + recordTypeName;
        
        //Create a description for the task detailing the incident and time submitted
        newTask.Description = 'New incident created on: ' + newIncident.CreatedDate + 
            '. Incident description:\n' + newIncident.Incident_Description__c;
        
        newTask.OwnerId = manager.Id;
        newTask.Status = 'Not Started';
        newTask.Priority = GetPriority(newIncident);
        newTask.WhoId = newIncident.Victim__c;
        newTask.WhatId = newIncident.Id;
        
        return newTask;
    }
    
    //Get the priority of an incident based on whether an EAP was used or 911 was called
    @testVisible 
    private static String GetPriority(Incident__c newIncident) {
        if (newIncident.X911_Called__c || newIncident.EAP_Used__c != null)
            return 'High';
        return 'Low';
    }
    
    //Retrieve the aquatics manager. If no aquatics manager, retrieve a system admin
    @testVisible
    private static User GetAQManager() {
        UserRole managerSet = [SELECT name FROM UserRole WHERE name = 'Aquatics Manager'];
        User manager;
        try {
            //Assign the manager to an active user with an Aquatics Manager permission set
        	manager = [SELECT userRoleId, isActive FROM User WHERE userRoleId =: managerSet.Id AND isActive = true LIMIT 1];
        }
        catch(System.QueryException e) {
            //If no active manager, assign to an active system administrator
            Profile admin = [SELECT id FROM Profile WHERE name = 'System Administrator'];
            manager = [SELECT id, profileId FROM User WHERE ProfileId =: admin.Id AND isActive = true LIMIT 1];
        }
        return manager;
    }
}