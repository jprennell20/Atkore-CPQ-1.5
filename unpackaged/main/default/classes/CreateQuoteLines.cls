global class CreateQuoteLines {
    
    public class FlowInputs{

        @InvocableVariable
        public List<AddProduct__c> addproducts;
        
        @InvocableVariable
        public Id quoteId;
        
        @InvocableVariable
        public Id pricebookId;
    }

    private static List<boolean> boolList = new List<boolean>{true};
    @InvocableMethod(label='Create Quote Lines' description='Creates a QuoteLine for each Product Id and child and grandchild found in the list of Product Ids in params' category='QuoteLine')
    public static List<boolean> createQuoteLines(List<FlowInputs> flowInputs) {
        SBQQ.TriggerControl.disable();
        try {
                
        //Variable Setting/Definitions
        for(integer i = 1; i < flowInputs.Size(); i++) {
            boolList.add(false);
        }
        FlowInputs flowInput = flowInputs[0];
        List<AddProduct__c> addproducts = flowInput.addproducts;
        Id quoteId = flowInput.quoteId;
        Id pricebookId = flowInput.priceBookId;
        List<Product2> products = new List<Product2>();
        List<SBQQ__QuoteLine__c> quoteLinesToCreate = new List<SBQQ__QuoteLine__c>();
        
        

        //CODE 1 Iteration
        Integer qlNumber = 1000;
        for (AddProduct__c addproduct : addproducts) {
           
           System.debug(addproduct);
           //create quoteline and add to list for each product
           SBQQ__QuoteLine__c quoteLine = new SBQQ__QuoteLine__c();
           quoteLine.SBQQ__Product__c = addproduct.Product__c;
           quoteLine.SBQQ__PricebookEntryId__c = pricebookId;
           quoteLine.SBQQ__Quote__c = quoteId;
           quoteLine.Quantity_User__c = addproduct.Quantity__c;
           quoteline.SBQQ__Number__c = qlNumber;
           quoteLine.Multiplier__c = addproduct.Multiplier__c;
           quoteLine.Part_Number_Override__c = addproduct.User_Entered_Product_Key__c;
           
          
           //Twin fields from product record
           quoteline.ABC_Code_1_Sales_Inventory__c = addproduct.Product__r.ABC_Code_1_Sales_Inventory__c;
           quoteline.Agent_Commission_Percentage__c = addproduct.Product__r.Agent_Commission_Percentage__c;
           quoteline.Category_Code_9__c = addproduct.Product__r.Category_Code_9__c;
           quoteline.Current_Cost__c = addproduct.Product__r.Current_Cost__c;
           quoteline.PGMIS6__c = addproduct.Product__r.PGMIS6__c;
           quoteline.PGSGMT__c = addproduct.Product__r.PGSGMT__c;
           quoteline.Pricing_Division_Code__c = addproduct.Product__r.Pricing_Division_Code__c;
           quoteline.Pricing_Group__c = addproduct.Product__r.Pricing_Group__c;
           quoteline.Sales_Rpt_06_Product_Line_Revenue__c = addproduct.Product__r.Sales_Rpt_06_Product_Line_Revenue__c;
           quoteline.SBQQ__BatchQuantity__c = addproduct.Product__r.SBQQ__BatchQuantity__c;
           quoteline.SBQQ__BillingFrequency__c = addproduct.Product__r.SBQQ__BillingFrequency__c;
           quoteline.SBQQ__BillingType__c = addproduct.Product__r.SBQQ__BillingType__c;
           quoteline.SBQQ__ChargeType__c = addproduct.Product__r.SBQQ__ChargeType__c;
           quoteline.SBQQ__CompoundDiscountRate__c = addproduct.Product__r.SBQQ__CompoundDiscountRate__c;
           quoteline.SBQQ__CostEditable__c = addproduct.Product__r.SBQQ__CostEditable__c;
           quoteline.SBQQ__DiscountSchedule__c = addproduct.Product__r.SBQQ__DiscountSchedule__c;
           quoteline.SBQQ__GenerateContractedPrice__c = addproduct.Product__r.SBQQ__GenerateContractedPrice__c;
           quoteline.SBQQ__HasConsumptionSchedule__c = addproduct.Product__r.SBQQ__HasConsumptionSchedule__c;
           quoteline.SBQQ__Hidden__c = addproduct.Product__r.SBQQ__Hidden__c;
           quoteline.SBQQ__NonDiscountable__c = addproduct.Product__r.SBQQ__NonDiscountable__c;
           quoteline.SBQQ__NonPartnerDiscountable__c = addproduct.Product__r.SBQQ__NonPartnerDiscountable__c;
           quoteline.SBQQ__Optional__c = addproduct.Product__r.SBQQ__Optional__c;
           quoteline.SBQQ__PriceEditable__c = addproduct.Product__r.SBQQ__PriceEditable__c;
           quoteline.SBQQ__PricingMethod__c = addproduct.Product__r.SBQQ__PricingMethod__c;
           quoteline.SBQQ__PricingMethodEditable__c = addproduct.Product__r.SBQQ__PricingMethodEditable__c;
           quoteline.SBQQ__SubscriptionBase__c = addproduct.Product__r.SBQQ__SubscriptionBase__c;
           quoteline.SBQQ__SubscriptionCategory__c = addproduct.Product__r.SBQQ__SubscriptionCategory__c;
           quoteline.SBQQ__SubscriptionPercent__c = addproduct.Product__r.SBQQ__SubscriptionPercent__c;
           quoteline.SBQQ__SubscriptionPricing__c = addproduct.Product__r.SBQQ__SubscriptionPricing__c;
           quoteline.SBQQ__SubscriptionTerm__c = addproduct.Product__r.SBQQ__SubscriptionTerm__c;
           quoteline.SBQQ__SubscriptionType__c = addproduct.Product__r.SBQQ__SubscriptionType__c;
           quoteline.SBQQ__Taxable__c = addproduct.Product__r.SBQQ__Taxable__c;
           quoteline.SBQQ__TaxCode__c = addproduct.Product__r.SBQQ__TaxCode__c;
           quoteline.SBQQ__TermDiscountSchedule__c = addproduct.Product__r.SBQQ__TermDiscountSchedule__c;
           quoteline.Standard_Cost__c = addproduct.Product__r.Standard_Cost__c;
           quoteline.Unit_of_Measure_Pricing__c = addproduct.Product__r.Unit_of_Measure_Pricing__c;
           quoteline.UPC_Number__c = addproduct.Product__r.UPC_Number__c;
           quoteline.Weight__c = addproduct.Product__r.Weight__c;
           quoteline.Weight_Unit_of_Measure__c = addproduct.Product__r.Weight_Unit_of_Measure__c;

            
           quoteLinesToCreate.add(quoteLine);

           qlNumber = qlNumber + 100;
        }
        insert quoteLinesToCreate;
}
        finally {
            SBQQ.TriggerControl.enable();
            }
        return boolList;
  }

}