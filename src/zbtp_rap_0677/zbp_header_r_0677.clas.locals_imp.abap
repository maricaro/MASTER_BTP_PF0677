CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF so_status,
        open   TYPE c LENGTH 1 VALUE 'O',
        accept TYPE c LENGTH 1 VALUE 'A',
        reject TYPE c LENGTH 1 VALUE 'X',
      END OF so_status.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE Header.

    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE Header.

    METHODS acceptSO FOR MODIFY
      IMPORTING keys FOR ACTION Header~acceptSO RESULT result.

    METHODS rejectSO FOR MODIFY
      IMPORTING keys FOR ACTION Header~rejectSO RESULT result.

    METHODS Resume FOR MODIFY
      IMPORTING keys FOR ACTION Header~Resume.

    METHODS setStatusToOpen FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Header~setStatusToOpen.

    METHODS setIdNumber FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~setIdNumber.

    METHODS validateCountry FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~validateCountry.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~validateDates.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD precheck_create.
  ENDMETHOD.

  METHOD precheck_update.
  ENDMETHOD.

  METHOD acceptSO.

    MODIFY ENTITIES OF zheader_r_0677 IN LOCAL MODE
    ENTITY Header
    UPDATE FIELDS ( OrderStatus )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                    OrderStatus = so_status-accept ) ).

    READ ENTITIES OF zheader_r_0677 IN LOCAL MODE
    ENTITY Header
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(headers).

    result = VALUE #( FOR header IN headers ( %tky = header-%tky
                                              %param = header ) ).

  ENDMETHOD.

  METHOD rejectSO.

    MODIFY ENTITIES OF zheader_r_0677 IN LOCAL MODE
    ENTITY Header
    UPDATE FIELDS ( OrderStatus )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                    OrderStatus = so_status-reject ) ).

    READ ENTITIES OF zheader_r_0677 IN LOCAL MODE
    ENTITY Header
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(headers).

    result = VALUE #( FOR header IN headers ( %tky = header-%tky
                                              %param = header ) ).

  ENDMETHOD.

  METHOD Resume.
  ENDMETHOD.

  METHOD setStatusToOpen.

     READ ENTITIES OF zheader_r_0677 IN LOCAL MODE
    ENTITY Header
    FIELDS ( OrderStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(headers).

    DELETE headers WHERE OrderID IS NOT INITIAL.

    CHECK headers IS NOT INITIAL.

    MODIFY ENTITIES OF zheader_r_0677 IN LOCAL MODE
    ENTITY Header
    UPDATE FIELDS ( OrderStatus )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                    OrderStatus = so_status-open ) ).



  ENDMETHOD.

  METHOD setIdNumber.

      READ ENTITIES OF zheader_r_0677 IN LOCAL MODE
    ENTITY Header
    FIELDS ( OrderID )
    WITH CORRESPONDING #( keys )
    RESULT DATA(headers).

    DELETE headers WHERE OrderID IS NOT INITIAL.

    CHECK headers IS NOT INITIAL.

    SELECT SINGLE FROM zheader_r_0677
    FIELDS MAX( CAST( OrderID as INT1 ) )
    INTO @DATA(max_Id).

    MODIFY ENTITIES OF zheader_r_0677 IN LOCAL MODE
    ENTITY Header
    UPDATE FIELDS ( orderid )
    WITH VALUE #( FOR header IN headers INDEX INTO i ( %tky = header-%tky
                                                       OrderID = max_id + i ) ).


  ENDMETHOD.

  METHOD validateCountry.

       read entities of zheader_r_0677 in local mode
        entity Header
        fields ( Country )
        with corresponding #( keys )
        result data(headers).

    data countries type sorted table of I_Country with unique key Country.

    countries = corresponding #( headers discarding duplicates mapping Country = Country except * ).
    delete countries where Country is initial.

    if countries is not initial.

      select from I_Country as ddbb
             inner join @countries as http_req on ddbb~Country = http_req~Country
             fields ddbb~Country
             into table @data(valid_countries).

    endif.


    loop at headers into data(header).

      append value #( %tky        = header-%tky
                      %state_area = 'VALIDATE_COUNTRIES' ) to reported-header.

      if header-Country is initial.

        append value #( %tky = header-%tky ) to failed-header.

        append value #( %tky = header-%tky
                        %state_area = 'VALIDATE_COUNTRIES'
                        %msg = new /dmo/cm_flight_messages( textid   = /dmo/cm_flight_messages=>currency_required
                                                            severity = if_abap_behv_message=>severity-error )
                        %element-country    = if_abap_behv=>mk-on ) to reported-header.

      elseif header-Country is not initial and not line_exists( valid_countries[ Country = header-Country ] ).

        append value #( %tky = header-%tky ) to failed-header.

        append value #( %tky = header-%tky
                        %state_area = 'VALIDATE_COUNTRIES'
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success text = 'Country Does not registered' )
                        %element-country    = if_abap_behv=>mk-on ) to reported-header.

      endif.

    endloop.

  ENDMETHOD.

  METHOD validateDates.
  ENDMETHOD.

ENDCLASS.
