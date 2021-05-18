public class ApexGetOrderItems {
    
    @AuraEnabled
    public static List<OrderItem> GetOrderItems(){
       //Id userID = UserInfo.getUserId();
       Id AccountId = id.valueof('0015e0000053HRJAA2');
      
       Account userAccount = [SELECT Id, OwnerId FROM Account WHERE Id =: accountId];
       List<Order> userOrder = [SELECT Id, AccountId FROM Order WHERE AccountId =: userAccount.Id];
       List<OrderItem> itemsList = [SELECT Product2Id FROM OrderItem WHERE OrderId IN: userOrder];
       return itemsList;
    }

}