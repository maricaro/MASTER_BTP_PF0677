@AbapCatalog.viewEnhancementCategory: [#NONE]

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items SalerOrder - Root entity'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZITEMS_R_0677 
as select from ztitems_0677_a

  association to parent ZHEADER_R_0677  as _Header on $projection.OrderUUID = _Header.OrderUUID
  
{
  key item_uuid             as ItemUUID,
      order_uuid            as OrderUUID,
      id                    as Id,
      name                  as Name,
      description           as Description,
      releasedate           as ReleaseDate,
      discontinueddate      as DiscontinuedDate,
      @Semantics.amount.currencyCode: 'Currency'
      price                 as Price,
      currency              as Currency, //CurrencyCode,
      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      height                as Height,
      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      width                 as Width,
      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      depth                 as Depth,
      quantity              as Quantity,
      unitofmeasure         as UnitOfMeasure,

      //local ETag field
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

     _Header
 
}
