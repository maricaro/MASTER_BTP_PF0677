CLASS zcl_salesorder_datagen_0677 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_salesorder_datagen_0677 IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.

    DATA: lt_header TYPE STANDARD TABLE OF ztheader_0677_a,
          lt_items  TYPE STANDARD TABLE OF ztitems_0677_a.

    out->write( 'Insert Sales Order data' ).

*  Header data
    DELETE FROM ztheader_0677_a.

    TRY.
        lt_header = VALUE #( (  order_uuid  = cl_system_uuid=>create_uuid_x16_static( )
                                id           = '1'
                                email        = 'vvalencia@gmail.com'
                                firstname    = 'Victor'
                                lastname     = 'Valencia'
                                country      = 'US'
                                createon     = cl_abap_context_info=>get_system_date( )
                                deliverydate = cl_abap_context_info=>get_system_date( )
                                orderstatus  = 'O'
                                imageurl     = 'https://logos-world.net/wp-content/uploads/2025/07/IC-Bus-Logo.png'
                                ) ).

*                             (  order_uuid  = cl_system_uuid=>create_uuid_x16_static( )
*                                id           = '2'
*                                email        = 'mtorres@gmail.com'
*                                firstname    = 'María'
*                                lastname     = 'Torres'
*                                country      = 'US'
*                                createon     = cl_abap_context_info=>get_system_date( )
*                                deliverydate = cl_abap_context_info=>get_system_date( )
*                                orderstatus  = 'O'
*                                imageurl     = 'https://logos-world.net/wp-content/uploads/2020/08/BP-Logo.png'
*                                )
*
*                             (  order_uuid  = cl_system_uuid=>create_uuid_x16_static( )
*                                id           = '3'
*                                email        = 'atorres@gmail.com'
*                                firstname    = 'Alfredo'
*                                lastname     = 'Torres'
*                                country      = 'US'
*                                createon     = cl_abap_context_info=>get_system_date( )
*                                deliverydate = cl_abap_context_info=>get_system_date( )
*                                orderstatus  = 'O'
*                                imageurl     = 'https://logos-world.net/wp-content/uploads/2022/11/AAA-Logo.png'
*                                )
*
*                             (  order_uuid  = cl_system_uuid=>create_uuid_x16_static( )
*                                id           = '4'
*                                email        = 'rpeña@gmail.com'
*                                firstname    = 'Raquel'
*                                lastname     = 'Peña'
*                                country      = 'US'
*                                createon     = cl_abap_context_info=>get_system_date( )
*                                deliverydate = cl_abap_context_info=>get_system_date( )
*                                orderstatus  = 'O'
*                                imageurl     = 'https://logos-world.net/wp-content/uploads/2022/11/4h-Logo.png'
*                                )
*
*                             (  order_uuid  = cl_system_uuid=>create_uuid_x16_static( )
*                                id           = '5'
*                                email        = 'fmadrigal@gmail.com'
*                                firstname    = 'Frank'
*                                lastname     = 'Madrigal'
*                                country      = 'US'
*                                createon     = cl_abap_context_info=>get_system_date( )
*                                deliverydate = cl_abap_context_info=>get_system_date( )
*                               orderstatus  = 'O'
*                                imageurl     = 'https://logos-world.net/wp-content/uploads/2020/11/World-Wide-Fund-for-Nature-Logo.png'
*                                )


      CATCH cx_uuid_error INTO DATA(lx_uuid_error).
        out->write( lx_uuid_error->get_text( ) ).
        RETURN.
    ENDTRY.

*    INSERT ztheader_0677_a FROM TABLE @lt_header.
    IF sy-subrc NE 0.
      RETURN.
    ENDIF.

    out->write( 'Header data inserted successfully!' ).

*  Header data
    DELETE FROM ztitems_0677_a.

    TRY.

        LOOP AT lt_header ASSIGNING FIELD-SYMBOL(<ls_header>).

          INSERT VALUE #( item_uuid        = cl_system_uuid=>create_uuid_x16_static( )
                          order_uuid       = <ls_header>-order_uuid
                          id               = 1
                          name             = 'Round  chrome watering can'
                          description      = 'Aqua Nuova round chrome watering can'
                          releasedate      = cl_abap_context_info=>get_system_date( )
                          discontinueddate =  cl_abap_context_info=>get_system_date( ) + 30  " discontinued after 30 days
                          price            = '7.50'
                          currency         = 'USD'
                          height           = 14
                          width            = 5
                          depth            = '2.5'
                          quantity         = 10
                          unitofmeasure    = 'IN'  )
                   INTO TABLE lt_items.

          INSERT VALUE #( item_uuid        = cl_system_uuid=>create_uuid_x16_static( )
                          order_uuid       = <ls_header>-order_uuid
                          id               = 2
                          name             = 'Bathroom sink faucet'
                          description      = 'Chrome single-lever basin tap'
                          releasedate      = cl_abap_context_info=>get_system_date( )
                          discontinueddate = cl_abap_context_info=>get_system_date( ) + 90 " discontinued after 30 days
                          price            = '5.90'
                          currency         = 'USD'
                          height           = 8
                          width            = 5
                          depth            = '4.5'
                          quantity         = 3
                          unitofmeasure    = 'IN'  )
                   INTO TABLE lt_items.

          INSERT VALUE #( item_uuid        = cl_system_uuid=>create_uuid_x16_static( )
                          order_uuid       = <ls_header>-order_uuid
                          id               = 3
                          name             = 'Blackout curtain'
                          description      = 'Blue color'
                          releasedate      = cl_abap_context_info=>get_system_date( )
                          discontinueddate = cl_abap_context_info=>get_system_date( ) + 70 " discontinued after 30 days
                          price            = '10.78'
                          currency         = 'USD'
                          height           = '2'
                          width            = '1.5'
                          depth            = '0.1'
                          quantity         = 20
                          unitofmeasure    = 'IN'  )
                   INTO TABLE lt_items.

          INSERT VALUE #( item_uuid        = cl_system_uuid=>create_uuid_x16_static( )
                          order_uuid       = <ls_header>-order_uuid
                          id               = 4
                          name             = 'Chenille Rug'
                          description      = 'light beige color'
                          releasedate      = cl_abap_context_info=>get_system_date( )
                          discontinueddate = cl_abap_context_info=>get_system_date( ) + 50 " discontinued after 30 days
                          price            = '5.80'
                          currency         = 'USD'
                          height           = 10
                          width            = '10'
                          depth            = '1'
                          quantity         = 3
                          unitofmeasure  = 'IN'  )
                   INTO TABLE lt_items.

        ENDLOOP.

      CATCH cx_uuid_error INTO lx_uuid_error.
        out->write( lx_uuid_error->get_text( ) ).
        RETURN.
    ENDTRY.

*    INSERT ztitems_0677_a FROM TABLE @lt_items.
    IF sy-subrc NE 0.
      RETURN.
    ENDIF.

    out->write( 'Items data inserted successfully!' ).

  ENDMETHOD.

ENDCLASS.
