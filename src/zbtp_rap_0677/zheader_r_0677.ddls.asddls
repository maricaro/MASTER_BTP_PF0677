
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header - Root Entity'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZHEADER_R_0677 
as select from ztheader_0677_a

  composition [1..*] of ZITEMS_R_0677        as _Items

  association [0..1] to I_Country                as _Country   on $projection.Country = _Country.Country
  association [1..1] to /DMO/I_Overall_Status_VH as _Status on $projection.OrderStatus = _Status.OverallStatus
    
{
   key order_uuid           as OrderUUID,
      id                    as OrderID,
      email                 as Email,
      firstname             as FirstName,
      lastname              as LastName,
      country               as Country,
      createon              as CreateOn,      
      deliverydate          as DeliveryDate,
      orderstatus           as OrderStatus,
      imageurl              as ImageUrl,

      //Campos Administrativos   
      //usuario        
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      
      //Fecha y hora de quien cambio
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      
      //ultimo cambio
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
    
      // ETag
      //local ETag field -> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      //total ETag field
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      
  // Make association public
      _Items,
      _Status,
      _Country
}
