CLASS zcl_vir_elem_sadl_0677 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_sadl_exit_calc_element_read.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_vir_elem_sadl_0677 IMPLEMENTATION.

METHOD if_sadl_exit_calc_element_read~calculate.

    DATA: lt_original_data TYPE STANDARD TABLE OF ZITEMS_C_0677 WITH DEFAULT KEY.

    lt_original_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).

      <fs_original_data>-PriceWithVAT = <fs_original_data>-Price * '1.21'.

    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_original_data ).

    FREE: lt_original_data.

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    CASE iv_entity.

      WHEN 'ZITEMS_C_0677'.

        LOOP AT it_requested_calc_elements INTO DATA(ls_calc_elem).

          IF ls_calc_elem = 'PRICEWITHVAT'.

            INSERT CONV #( 'PRICE' ) INTO TABLE et_requested_orig_elements.

          ENDIF.

        ENDLOOP.

    ENDCASE.

  ENDMETHOD.

ENDCLASS.
