public class AccountTriggerHandler {
	
    //Links contacts to accounts that list them as primaries
    public static void LinkPrimary(List<Account> newAccounts) {
        List<Contact> updatedContacts = new List<Contact>();
        Map<Account, Contact> accountMap = GetAccountToContactMap(newAccounts);
        
        //Iterate through the accounts and link each primary
        for (Account newAccount : newAccounts) {
            Contact linkedContact = GetAndLinkPrimary(newAccount, accountMap.get(newAccount));
            if (linkedContact != null)
            	updatedContacts.add(linkedContact);
        }
        Database.Update(updatedContacts, false);
    }
    
    //Links the primary to the account and returns the contact for update
    @testVisible
    private static Contact GetAndLinkPrimary(Account account, Contact primary) {
        if (account == null || primary == null) return null;
        
        primary.AccountId = account.Id;
        return primary;
    }
    
    //Maps accounts to their primary contacts
    @testVisible
    private static Map<Account, Contact> GetAccountToContactMap(List<Account> accounts) { 
        if (accounts == null) return new Map<Account, Contact>();
        
        //Retrieve all primary contacts
        Set<Id> contactSet = new Set<Id>();
        for (Account account : accounts) {
            contactSet.add(account.Primary__c);
        }
        if (contactSet.size() == 0) return new Map<Account, Contact>();
        List<Contact> possibleContacts = [SELECT accountId FROM Contact WHERE id IN :contactSet];
        
        //Map students to classes
        Map<Account, Contact> accountMap = new Map<Account, Contact>();
        for (Account account : accounts) {
            for (Contact contact : possibleContacts) {
                if (account.Primary__c == contact.Id) {
                    accountMap.put(account, contact);
                    break;
                }
            }
        }
        return accountMap;
    }
}