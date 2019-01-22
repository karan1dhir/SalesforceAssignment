public with sharing class makeOrder {
    
  
   
    public ProductOrderWrapper productOrderWrapperObj {get;set;}
    public List<ProductOrderWrapper> productOrderWrapperList {get;private set;}

    public List<MyOrder__c> ordersInDbList {get;set;}
    public List<MapProductToOrder__c> productsInDbList {get;set;}


    public makeOrder() {
       
        productOrderWrapperObj = new ProductOrderWrapper();
        productOrderWrapperList = new List<ProductOrderWrapper>();
        ordersInDbList = new List<MyOrder__c>();
        productsInDblist = new List<MapProductToOrder__c>();
    }
   
   public Pagereference addPage(){
    
      addToOrderList(productOrderWrapperObj);
      productOrderWrapperObj = new ProductOrderWrapper();
      return null;

   }
   public void addToOrderList(ProductOrderWrapper productOrderWrapperObj){

      
      ProductOrderWrapper newProductOrderObj = new ProductOrderWrapper();
     if(productOrderWrapperObj!=NULL){
         List<ProductLineItemWrapper> products = new List<ProductLineItemWrapper>();    
         for(ProductLineItemWrapper productLineItemWrapperObj : productOrderWrapperObj.productLineItemWrapperList){      
              ProductLineItemWrapper newProduct = new ProductLineItemWrapper(new MapProductToOrder__c());
              newProduct.productItem.MyProduct__c = productLineItemWrapperObj.productItem.MyProduct__c;
              products.add(newProduct);
         }
          newProductOrderObj.productLineItemWrapperList = products;
          productOrderWrapperList.add(newProductOrderObj);
     }      
   }
    public void saveOrder(){

        for(ProductOrderWrapper productOrderWrapperObj :productOrderWrapperList){
            ordersInDbList.add(productOrderWrapperObj.order);
        }
        insert ordersInDbList;
        
        for(ProductOrderWrapper productOrderWrapperObj : productOrderWrapperList){
            for(ProductLineItemWrapper productLineItemWrapperObj: productOrderWrapperObj.productLineItemWrapperList){
                productLineItemWrapperObj.productItem.orderID__c = productOrderWrapperObj.order.ID;
                productsInDblist.add(productLineItemWrapperObj.productItem);
            }
        }
        insert productsInDblist;
   }
    public class ProductLineItemWrapper {
        public MapProductToOrder__c productItem {get;set;}
        public ProductLineItemWrapper (MapProductToOrder__c productItem){
            this.productItem = productItem;
        }
    }
    public class ProductOrderWrapper {
        public MyOrder__c order {get;set;}
        public List<ProductLineItemWrapper> productLineItemWrapperList {get;set;}
        public ID ProductID {get;set;}
        public ProductLineItemWrapper productLineItemWrapperObj {get;set;}
        public ProductOrderWrapper(){
            order = new MyOrder__c();
            ProductLineItemWrapperObj = new ProductLineItemWrapper(new MapProductToOrder__c());
            productLineItemWrapperList = new List<ProductLineItemWrapper>();
        }
     public Pagereference addSection(){
      addToList(productLineItemWrapperObj);
      productLineItemWrapperObj = new ProductLineItemWrapper(new MapProductToOrder__c());
      System.debug('newcreated'+productLineItemWrapperObj);
      return null;
      }
        public void addToList(ProductLineItemWrapper productLineItemObj){
        if(productLineItemObj.productItem.MyProduct__c != null){
            ProductLineItemWrapper newProductLineItemWrapperObj = new ProductLineItemWrapper(new MapProductToOrder__c());
            newProductLineItemWrapperObj.productItem.MyProduct__c = productLineItemObj.productItem.MyProduct__c;
            productLineItemWrapperList.add(newProductLineItemWrapperObj);
        }
      }
       public void deleteProduct(){    
       Integer getIndex =0;
       for(Integer i=0;i<productLineItemWrapperList.size();i++){
           if(ProductID == productLineItemWrapperList.get(i).productItem.MyProduct__c){
               getIndex =i;
               break;
           }
       }
       productLineItemWrapperList.remove(getIndex);
     }
    }
}