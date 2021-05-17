public class AccountController {
    
	@AuraEnabled
    public static Account checkMethod(){
        //Uncomment when we have a user
        //Id currentUser = UserInfo.getUserId();
    	//User you = [SELECT Name, ContactID FROM User where id =: currentUser];
    	id theId = id.valueOf('0015e0000052xLsAAI');
        Account userAcct = [Select Name,Type,Phone,Primary__c FROM Account WHERE id =: theId];
        return userAcct;
    }
    @AuraEnabled
    public static List<Contact> getAccociatedContact(String account){
        Id acctId = Id.valueOf(account);
        List<Contact> contactList = [SELECT Name,Email,Phone FROM Contact Where AccountId =: acctId];
        return contactList;
    }
}