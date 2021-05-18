/*    Name: ClassRegistrationTriggerHandler 
 //    Author: Andreology
 //    Created: 05/10/2021
 //    Updated: 05/16/2021
 //    Description: Trigger class for Class Registrations which will either add items(classes) to an order 
 //                 or create a new order and then add items to order 
*/
public with sharing class ClassRegistrationTriggerHandler {
    public ClassRegistrationTriggerHandler() {

    }
    //Method to cycle through all new class registrations and and items to order of account user. 
    public static void HandleAfterInsert(List<Class_Registration__c> registrations) {
        //go through new registration 
        List<OrderItem> orderItems = new List<OrderItem>();
        orderItems = [SELECT OrderId, Product2Id, TotalPrice FROM OrderItem];
        List<Order> orders = [SELECT Id, Name, AccountId FROM Order WHERE status='Draft'];
        //traverse all class registrations that are new. 
        for (Integer i = 0; i < registrations.size(); i++) {
            //if an order exists 
            Class_Registration__c currRegistration = registrations.get(i);
            Id accId = currRegistration.Account__c;
            Id classId = currRegistration.Class__c;
            Id productId = GetProductId(classId);
            Class__c curr_class = [SELECT Id, class_price__c FROM Class__c WHERE Id=:classId];
            string stringPrice = curr_class.Class_Price__c;
            stringPrice = stringPrice.replace('$', '');
            Decimal price = Decimal.valueOf(stringPrice);

            Id priceBookId = GetPriceBook2Id(); 
            Id priceBookEntrId = GetPriceBookEntryId(priceBookId, productId);
            //check if orders exists
            if (orders.size() > 0) {
                boolean found = false;
                boolean nvrFound = true;
                //Searching all orders for an existing draft order currently in DB by curr user account.
                 for(integer x = 0; x < orders.size(); x++) {
                    if(orders.get(x).AccountId == accId && !found){
                       OrderItem classProduct = new OrderItem();
                        classProduct.Product2Id = productId;
                        classProduct.OrderId = orders.get(x).Id;
                        classProduct.UnitPrice = price;
                        classProduct.Quantity = 1.0;
                        //need pricebook id 
                        classProduct.PricebookEntryId = priceBookEntrId;
                        insert classProduct;
                        found = true;
                        nvrFound = false;
                    }
                 }//else if an order doesn't already exists in the DB related to the curr user account, create a new order
                 if (nvrFound) {
                     
                        System.debug('inside not found CHECKING ACCid ' + accId);
                     System.debug('inside nvrFound');
                     Order newOrder = new Order();
                        newOrder.AccountId =  accId;
                        newOrder.Status = 'Draft';
                        newOrder.EffectiveDate = System.today();
                        newOrder.Pricebook2Id = priceBookId;
                        insert newOrder;
                        OrderItem classProduct = new OrderItem();
                        //need product id 
                        classProduct.Product2Id = productId;
                        classProduct.OrderId = newOrder.Id;
                        classProduct.UnitPrice = price;
                        classProduct.Quantity = 1.0;
                        //need pricebook id 
                        classProduct.PricebookEntryId = priceBookEntrId;
                        insert classProduct;
                 }
            }else { //else if there is new Orders extant, then just create a new order. 
                Order newOrder = new Order();
                newOrder.AccountId =  accId;
                newOrder.Status = 'Draft';
                newOrder.EffectiveDate = System.today();
                newOrder.Pricebook2Id = priceBookId;
                insert newOrder;
                OrderItem classProduct = new OrderItem();
                //need product id 
                classProduct.Product2Id = productId;
                classProduct.OrderId = newOrder.Id;
                classProduct.UnitPrice = price;
                classProduct.Quantity = 1.0;
                //need pricebook id 
                classProduct.PricebookEntryId = priceBookEntrId;
                insert classProduct;
            }
            
        }
        
    }
    //method to get current Book Entry Id 
    public static Id GetPriceBookEntryId(Id priceBookId, Id productId) {
        PriceBookEntry entry = [SELECT Id, Pricebook2Id, Product2Id FROM PriceBookEntry WHERE Pricebook2Id=:priceBookId AND Product2Id=:productId];
        return entry.Id;
    }
    //method to get current price book Id 
    public static Id GetPriceBook2Id() {
        PriceBook2 priceBook = [SELECT id, isActive, isStandard FROM pricebook2 WHERE isActive=true];
        return priceBook.Id;
    }
    //method to get current product  Id 
    public static Id GetProductId(Id classId) {
        Class__c product = [SELECT Product__c, Id FROM Class__c WHERE Id=:classId];
        return product.Product__c;
    }
}