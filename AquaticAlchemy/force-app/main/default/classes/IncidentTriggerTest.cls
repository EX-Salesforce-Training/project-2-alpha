@isTest
public class IncidentTriggerTest {
	
    @isTest
    private static void TP_CreateIncidentTask() {
        Incident__c newIncident = new Incident__c();
        newIncident.RecordTypeId = Schema.SObjectType.Incident__c.getRecordTypeInfosByDeveloperName().get('Minor_Incident').recordTypeId;

        User manager = IncidentTriggerHandler.GetAQManager();
        
        Task newTask = IncidentTriggerHandler.CreateIncidentTask(newIncident, manager);
        
        System.assert(newTask.Description.contains('New incident created on: '));
        System.assert(newTask.Description.contains('' + newIncident.CreatedDate));
    }
    
    @isTest
    private static void NP_CreateIncidentTask() {
        Task newTask = IncidentTriggerHandler.CreateIncidentTask(null, null);
        
        System.assert(newTask == null);
    }
    
    @isTest
    private static void TP_GetAQManager() {
        UserRole managerSet = [SELECT name FROM UserRole WHERE name = 'Aquatics Manager'];
        User manager = IncidentTriggerHandler.GetAQManager();
        User test;
        Profile admin = [SELECT id FROM Profile WHERE name = 'System Administrator'];
        try {
        	test = [SELECT userRoleId, isActive FROM User WHERE userRoleId =: managerSet.Id AND isActive = true LIMIT 1];
        }
        catch (System.QueryException e) {
            test = null;
        }
        
        if (test == null) {
            System.assert(manager.ProfileId == admin.Id);
        }
        else {
            System.assert(manager.UserRoleId == managerSet.Id);
        }
    }
    
    @isTest
    private static void TP_AssignTasksToManager() {
        Contact c = new Contact();
        c.lastName = 'test';
        Insert c;
        
        Incident__c newIncident = new Incident__c();
        newIncident.Incident_Description__c = 'Test description';
        newIncident.Incident_Time__c = System.now();
        newIncident.Incident_Area__c = 'Deck';
        newIncident.Victim__c = c.Id;
        newIncident.Location_of_Incident__c = 'Deck - Entry';
        
        Insert newIncident;
        
        Task generatedTask = [SELECT subject FROM Task LIMIT 1];
        
        System.assert(generatedTask.subject.contains('Incident'));
    }
    
    @isTest
    private static void TB_AssignTasksToManager() {
        Contact c = new Contact();
        c.lastName = 'test';
        Insert c;
        
        List<Incident__c> newIncidents = new List<Incident__c>();
        for (Integer i = 0; i < 151; i++) {
            Incident__c newIncident = new Incident__c();
        	newIncident.Incident_Description__c = 'Test description ' + (i + 1);
        	newIncident.Incident_Time__c = System.now();
        	newIncident.Incident_Area__c = 'Deck';
            newIncident.Victim__c = c.Id;
        	newIncident.Location_of_Incident__c = 'Deck - Entry';
            newIncidents.add(newIncident);
        }
        User manager = IncidentTriggerHandler.GetAQManager();
        
        Insert newIncidents;
        
        List<Task> createdTasks = [SELECT OwnerId FROM Task];
        System.assertEquals(151, createdTasks.size());
        for (Task task : createdTasks) {
            System.assertEquals(manager.Id, task.OwnerId);
        }
    }
    
    @isTest
    private static void TP_GetPriority() {
        Incident__c lowPriority = new Incident__c();
        Incident__c highPriority = new Incident__c();
        highPriority.X911_Called__c = true;
        
        String low = IncidentTriggerHandler.GetPriority(lowPriority);
        String high = IncidentTriggerHandler.GetPriority(highPriority);
        
        System.assert(low == 'Low' && high == 'High');
    }
}