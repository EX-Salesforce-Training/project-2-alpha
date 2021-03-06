@isTest
public class AccountTriggerTest {
	
    @testSetup
    private static void AccountSetup() {
        Account linkedAccount = new Account();
        linkedAccount.name = 'Linked';
        
        Contact newContact = new Contact();
        newContact.lastName = 'Test';
        
        Insert newContact;
        
        linkedAccount.Primary__c = newContact.Id;
        Insert linkedAccount;
        
        linkedAccount.Primary__c = newContact.Id;
        
        Update linkedAccount;
    }
    
    @isTest
    private static void TP_GetAndLinkPrimary() {
        Account unlinkedAccount = new Account();
        Contact predictedContact = [SELECT id FROM Contact LIMIT 1];
        unlinkedAccount.Primary__c = predictedContact.Id;
        
        Contact actualContact = AccountTriggerHandler.GetAndLinkPrimary(unlinkedAccount, predictedContact);
        System.assert(predictedContact.Id == actualContact.Id && actualContact.AccountId == unlinkedAccount.Id);
    }
    
    @isTest
    private static void NP_GetAndLinkPrimary() {
        Contact nullContact = AccountTriggerHandler.GetAndLinkPrimary(null, null);
        System.assert(nullContact == null);
    }
    
    @isTest
    private static void TP_GetAccountToContactMap() {
        Account testAcc = [SELECT Primary__c FROM Account LIMIT 1];
        Contact testContact = [SELECT AccountId FROM Contact LIMIT 1];
        
        Map<Account, Contact> accountMap = AccountTriggerHandler.GetAccountToContactMap(new List<Account>{testAcc});
        
        System.assertEquals(testContact.Id, accountMap.get(testAcc).Id);
    }
    
    @isTest
    private static void TP_LinkPrimary() {
        Contact newContact = new Contact();
        newContact.lastName = 'Test';
        Insert newContact;
        
        Account unlinkedAccount = new Account();
        unlinkedAccount.name = 'Test Account';
        unlinkedAccount.Primary__c = newContact.Id;
        Insert unlinkedAccount;
        newContact = [SELECT AccountId FROM Contact WHERE id =: newContact.Id];
        
        System.assertEquals(newContact.AccountId, unlinkedAccount.Id);
    }
    
    @isTest
    private static void TB_LinkPrimary() {
        List<Contact> contactList = new List<Contact>();
        for (Integer i = 0; i < 151; i++) {
            Contact newContact = new Contact();
            newContact.lastName = 'Test' + (i + 1);
            newContact.AccountId = null;
            contactList.add(newContact);
        }
        Insert contactList;
        
        List<Account> accountList = new List<Account>();
        for (Integer i = 0; i < 151; i++) {
            Account newAccount = new Account();
            newAccount.name = 'Test Account ' + (i + 1);
            newAccount.Primary__c = contactList.get(i).Id;
            accountList.add(newAccount);
        }
        
        Insert accountList;
        
        //Offset 1 to get past the test contact from setup
        contactList = [SELECT accountId FROM Contact OFFSET 1];
        for (Integer i = 0; i < 151; i++) {
            System.assertEquals(accountList.get(i).Id, contactList.get(i).accountId);
            System.debug('Successes: ' + (i + 1));
        }
    }
    
}