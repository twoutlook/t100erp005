#+ 程式版本......: T6 Version 1.00.00 Build-0317 at 12/09/21
#
#+ 程式代碼......: adzp010
#+ 設計人員......: hiko
#樣板功能名稱: 無

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp200_type.inc"

DEFINE ga_base_item DYNAMIC ARRAY OF RECORD #基礎資料清單
                    sel LIKE type_t.chr1,
                    value LIKE dzej_t.dzej002,
                    item LIKE dzej_t.dzej003,
                    desc1 LIKE dzej_t.dzej004
                    END RECORD

MAIN

END MAIN

{ #將原本的程式全部註解掉, 改成設計器組的測試程式.
MAIN
   DEFINE ls_prog STRING,
          ls_type STRING,
          ls_module STRING
   DEFINE lb_result BOOLEAN,
          ls_err_msg STRING,
          lo_dzaf T_DZAF_T

   CALL cl_tool_init()

   CLOSE WINDOW screen

   OPEN WINDOW w_adzp010 WITH FORM cl_ap_formpath("adz","adzp010")
 
   CALL cl_load_4ad_interface(NULL)

   #進入選單 Menu (='N')
   CALL adzp010_ui_dialog()

   #畫面關閉
   CLOSE WINDOW w_adzp010
END MAIN

PRIVATE FUNCTION adzp010_ui_dialog()
   DEFINE li_i SMALLINT,
          lb_flag BOOLEAN
   DEFINE l_ac LIKE type_t.num5

   CALL adzp010_prepare_base_item()

   CALL ui.Dialog.setDefaultUnbuffered(TRUE)

   DIALOG
      INPUT ARRAY ga_base_item FROM s_base_item.*
            ATTRIBUTE(WITHOUT DEFAULTS, INSERT ROW=0, DELETE ROW=0, APPEND ROW=0)
      END INPUT

      ON ACTION sel_all
         CALL adzp010_sel("Y")

      ON ACTION sel_none
         CALL adzp010_sel("N")

      ON ACTION gen
         CALL adzp010_gen()

      ON ACTION controlg
         CALL cl_cmdask()

      ON ACTION close
         EXIT PROGRAM

   END DIALOG
END FUNCTION

#準備[基礎資料清單].
PRIVATE FUNCTION adzp010_prepare_base_item()
   DEFINE ls_trigger STRING
   DEFINE ls_sql STRING
   DEFINE li_cnt SMALLINT

   TRY
      LET ls_trigger = "adzp010 : get dzej_t data"
      LET ls_sql = "SELECT 'N',dzej002,dzej003,dzej004",
                    " FROM dzej_t",
                   " WHERE dzej001='adzp010'",
                   " ORDER BY dzej002" 
      PREPARE dzej_prep FROM ls_sql
      DECLARE dzej_curs CURSOR FOR dzej_prep
      LET li_cnt = 1
      FOREACH dzej_curs INTO ga_base_item[li_cnt].*
         LET li_cnt = li_cnt + 1
      END FOREACH
      CALL ga_base_item.deleteElement(li_cnt)
   CATCH 
      #todo : 這段程式之後要改.
      DISPLAY "ls_trigger=",ls_trigger
      IF SQLCA.SQLCODE THEN
         CALL FGL_WINMESSAGE("SQL ERROR", ls_trigger||":"||SQLCA.SQLCODE, "stop")
      ELSE
         CALL FGL_WINMESSAGE("OTHER ERROR", ls_trigger||":Please notify administrator", "stop")
      END IF
      EXIT PROGRAM
   END TRY
END FUNCTION

#設定[基礎資料清單]的全選/全不選.
PRIVATE FUNCTION adzp010_sel(p_value)
   DEFINE p_value LIKE type_t.chr1
   DEFINE li_i    SMALLINT

   FOR li_i=1 TO ga_base_item.getLength()
       LET ga_base_item[li_i].sel = p_value
   END FOR
END FUNCTION

#按下"產生"後執行作業
PRIVATE FUNCTION adzp010_gen()
   DEFINE li_i    SMALLINT
   DEFINE lb_result BOOLEAN

   IF NOT cl_ask_sure() THEN RETURN END IF

   FOR li_i=1 TO ga_base_item.getLength()
      IF ga_base_item[li_i].sel = 'Y' THEN
         CASE ga_base_item[li_i].value
            WHEN 'a' CALL sadzp010_1_gen_checks_xml() RETURNING lb_result      #校驗帶值設計資料檔
            WHEN 'b' CALL sadzp010_1_gen_zooms_xml() RETURNING lb_result       #開窗設計資料檔
            WHEN 'c' CALL sadzp010_1_gen_items_xml() RETURNING lb_result       #系統分類碼資料檔
            WHEN 'd' CALL sadzp010_1_gen_prog_rel_xml() RETURNING lb_result    #格式串查設定檔
            WHEN 'e' CALL sadzp010_1_gen_sub_xml() RETURNING lb_result         #應用元件資訊檔
            WHEN 'f' CALL sadzp010_1_gen_lib_xml() RETURNING lb_result         #系統元件資訊檔
            WHEN 'g' CALL sadzp010_1_gen_tables_xml()                          #資料表清單檔 #2013/08/27 by Hiko
            WHEN 'h' CALL sadzp010_1_gen_messages_xml() RETURNING lb_result    #訊息資訊檔 #2013/09/06 by Hiko
            WHEN 'i' CALL sadzp010_1_gen_code_sample_xml() RETURNING lb_result #範本代碼檔 #2013/09/27 by Hiko
         END CASE
      END IF
      #因為每個檔案都是獨立事件,所以就算中間有失敗的情況,也不影響其他檔案的建立.
   END FOR

   CALL cl_ask_pressanykey('lib-026')
END FUNCTION
}
