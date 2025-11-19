@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header - Interface Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZHEADER_I_0677 
provider contract transactional_interface
as projection on ZHEADER_R_0677
{
    key OrderUUID,
    OrderID,
    Email,
    FirstName,
    LastName,
    Country,
    CreateOn, 
    DeliveryDate,
    OrderStatus,
    ImageUrl,    
    
    //local ETag field -> OData ETag
    LocalLastChangedAt,
    
    //total ETag field   
    LastChangedAt,
    
    /* Associations */
    _Country,
    _Items : redirected to composition child ZITEMS_I_0677

    
    
   
}
