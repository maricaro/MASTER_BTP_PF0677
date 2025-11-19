CLASS lhc_Items DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS setIdItems FOR DETERMINE ON SAVE
      IMPORTING keys FOR Items~setIdItems.

    METHODS validateCurrency FOR VALIDATE ON SAVE
      IMPORTING keys FOR Items~validateCurrency.

ENDCLASS.

CLASS lhc_Items IMPLEMENTATION.

  METHOD setIdItems.

    DATA:
      Items_u TYPE TABLE FOR UPDATE zheader_r_0677\\Items,
      max_id  TYPE ztitems_0677_a-id.

    READ ENTITIES OF zheader_r_0677 IN LOCAL MODE
    ENTITY Items BY \_Header
    FIELDS ( OrderID )
    WITH CORRESPONDING #( keys )
    RESULT DATA(headers).


    LOOP AT headers INTO DATA(header).

      READ ENTITIES OF zheader_r_0677 IN LOCAL MODE
      ENTITY Header BY \_Items
      FIELDS ( ItemUUID )
      WITH VALUE #( ( %tky = header-%tky ) )
      RESULT DATA(items).

      CLEAR max_id.

      LOOP AT items INTO DATA(item).
        IF item-Id > max_id.
          max_id = item-id.
        ENDIF.
      ENDLOOP.

      LOOP AT items INTO item  WHERE Id IS INITIAL.
        max_id += 1.
        APPEND VALUE #( %tky = item-%tky
                        Id   = max_id ) TO items_u.
      ENDLOOP.

    ENDLOOP.

    MODIFY ENTITIES OF zheader_r_0677 IN LOCAL MODE
    ENTITY Items
    UPDATE
    FIELDS ( Id )
    WITH items_u.

  ENDMETHOD.

  METHOD validateCurrency.
  ENDMETHOD.

ENDCLASS.
