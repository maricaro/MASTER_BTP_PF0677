@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items - Consumption entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
@Search.searchable: true


define view entity ZITEMS_C_0677
 as projection on ZITEMS_R_0677
{
  key ItemUUID,
      OrderUUID,
      
      @Search.defaultSearchElement: true
      Id,
      
      @Search.defaultSearchElement: true
      Name,
      Description,
      
      @Search.defaultSearchElement: true
      ReleaseDate,
      
      @Search.defaultSearchElement: true
      DiscontinuedDate,
      
     @Semantics.amount.currencyCode: 'Currency'
      Price,
    
      // Virtual element
       @Semantics.amount.currencyCode: 'Currency'
       @EndUserText.label: 'VAT Included'
       @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIR_ELEM_SADL_0677'  
       virtual PriceWithVAT : /dmo/total_price,   
           
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH',
                                                     element: 'Currency' },
                                           useForValidation: true }]
      Currency,
      
      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Height,
      
      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Width,
      
      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      Depth,
      
      Quantity,
      
      UnitOfMeasure,
      
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      
      /* Associations */
      _Header : redirected to parent ZHEADER_C_0677

}
