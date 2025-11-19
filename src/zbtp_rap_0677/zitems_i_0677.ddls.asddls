@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items - Interface entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZITEMS_I_0677 
as projection on ZITEMS_R_0677
{
    key ItemUUID,
    OrderUUID,
    Id,
    Name,
    Description,
    ReleaseDate,
    DiscontinuedDate,
    @Semantics.amount.currencyCode: 'Currency'
    Price,
    Currency,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    Height,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    Width,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    Depth,
    Quantity,
    UnitOfMeasure,
    
    //local ETag field
    @Semantics.systemDateTime.localInstanceLastChangedAt: true    
    LocalLastChangedAt,
    
    /* Associations */
    _Header : redirected to parent ZHEADER_I_0677

}
