public class ApexGetOrderItems {
    
    @AuraEnabled
    public static List<OrderItem> GetOrderItems(){
       //Id userID = UserInfo.getUserId();
       Id AccountId = id.valueof('0015e000005NCiKAAW');
      
       Account userAccount = [SELECT Id, OwnerId FROM Account WHERE Id =: accountId];
       List<Order> userOrder = [SELECT Id, AccountId FROM Order WHERE AccountId =: userAccount.Id AND Status =: 'Draft'];
       List<OrderItem> itemsList = [SELECT Product2Id FROM OrderItem WHERE OrderId IN: userOrder];
       return itemsList;
    }
    @AuraEnabled
    public static List<Order> GetOrders(){
       //Id userID = UserInfo.getUserId();
       Id AccountId = id.valueof('0015e000005NCiKAAW');
      
       Account userAccount = [SELECT Id, OwnerId FROM Account WHERE Id =: accountId];
       List<Order> userOrders = [SELECT Id, AccountId, Status FROM Order WHERE AccountId =: userAccount.Id AND Status =: 'Draft'];
       return userOrders;
    }

}