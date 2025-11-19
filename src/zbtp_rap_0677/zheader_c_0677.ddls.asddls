@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
@Search.searchable: true

// capa de consumo
define root view entity ZHEADER_C_0677
provider contract transactional_query
as projection on ZHEADER_R_0677
{
  key OrderUUID,
  
      @Search.defaultSearchElement: true
      OrderID,
      Email, 
           
      @Search.defaultSearchElement: true      
      FirstName,            
      LastName,
      
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CountryVH',
                                      element: 'Country' },
                            useForValidation: true }] 
      @ObjectModel.text.element: [ 'CountryName' ]                           
      Country,
      _Country._Text.CountryName as CountryName : localized,
      
      @Search.defaultSearchElement: true
      CreateOn,
      
      @Search.defaultSearchElement: true
      DeliveryDate,         
 
      
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Overall_Status_VH',
                                                     element: 'OverallStatus'},
                                           useForValidation: true }]
      @ObjectModel.text.element: [ 'OrderStatusText' ]                                     
      OrderStatus,
      _Status._Text.Text         as OrderStatusText : localized,

      ImageUrl,
      
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      /* Associations */
      _Country,
      _Items : redirected to composition child ZITEMS_C_0677
     
}
