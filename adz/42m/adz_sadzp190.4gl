#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 13/01/17
#
#+ 程式代碼......: sadzp190
#+ 設計人員......: 
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp190.4gl
# Description    : SQL BUILDER
# Memo           :

 
IMPORT os
SCHEMA ds 

GLOBALS "../../cfg/top_global.inc"
 
{<Module define>}
 
#type 宣告
PRIVATE TYPE type_table1_d RECORD
   tab1_01 LIKE dzea_t.dzea001,  #Table
   tab1_02 LIKE type_t.chr20,    #Alias
   tab1_03 LIKE type_t.chr1,     #join type
   tab1_04 LIKE type_t.chr1000,  #連結欄位
   tab1_05 LIKE type_t.chr1000   #被連結欄位
   END RECORD

PRIVATE TYPE type_table2_d RECORD
   tab2_01 LIKE type_t.chr20,    #table alias
   tab2_02 LIKE dzeb_t.dzeb002,  #column
   tab2_03 LIKE type_t.chr20     #alias
   END RECORD

PRIVATE TYPE type_table3_d RECORD
   tab3_01 LIKE type_t.chr20,    #alias
   tab3_02 LIKE dzeb_t.dzeb002,  #column
   tab3_03 LIKE type_t.chr1,     #比較運算子
   tab3_04 LIKE type_t.chr100,   #條件值
   tab3_05 LIKE type_t.chr20,    #alias
   tab3_06 LIKE dzeb_t.dzeb002,  #column
   tab3_07 LIKE type_t.chr1,     #比較運算子
   tab3_09 LIKE type_t.chr1,     #(
   tab3_10 LIKE type_t.chr1      #)
   END RECORD

PRIVATE TYPE type_table4_d RECORD
   tab4_01 LIKE type_t.chr20,
   tab4_02 LIKE dzeb_t.dzeb002,
   tab4_03 LIKE type_t.chr1,
   tab4_04 LIKE type_t.chr100,
   tab4_05 LIKE type_t.chr20,
   tab4_06 LIKE dzeb_t.dzeb002,
   tab4_07 LIKE type_t.chr1,
   tab4_09 LIKE type_t.chr1,
   tab4_10 LIKE type_t.chr1
   END RECORD

PRIVATE TYPE type_table5_d RECORD
   tab5_01 LIKE type_t.chr20,   #alias
   tab5_02 LIKE dzeb_t.dzeb002  #column
   END RECORD

PRIVATE type type_table6_d RECORD
   tab6_01 LIKE type_t.chr20,   #alias
   tab6_02 LIKE dzeb_t.dzeb002, #column
   tab6_03 LIKE type_t.chr1     #排序
   END RECORD

PUBLIC TYPE T_OBJECT_LIST RECORD 
   OBJECT_NAME   LIKE type_t.chr30,
   OBJECT_DESC   LIKE type_t.chr100 
   END RECORD
                          
TYPE T_OBJECT_LIST2 RECORD
   ALIAS         LIKE type_t.chr30,
   OBJECT_NAME   LIKE type_t.chr30,
   OBJECT_DESC   LIKE type_t.chr100 
   END RECORD
                        
################################################################################
#定義SQL語法中使用的tag名稱常數
CONSTANT G_COUNT_START = "<count>"     #欄位代碼開始符
CONSTANT G_COUNT_END   = "</count>"     #欄位代碼開始符
CONSTANT G_FIELD_START = "<field>"     #欄位代碼開始符   
CONSTANT G_FIELD_END   = "</field>"    #欄位代碼結束符
CONSTANT G_TABLE_START = "<table>"     #資料表代碼開始符  
CONSTANT G_TABLE_END   = "</table>"    #資料表代碼結束符
CONSTANT G_WHERE_START = "<wc>"        #Where條件開始符  
CONSTANT G_WHERE_END   = "</wc>"       #Where條件結束符
CONSTANT G_INWC_START  = "<inwc>"      #input段要加入的條件開始符
CONSTANT G_INWC_END    = "</inwc>"     #input段要加入的條件結束符
CONSTANT cs_side_left  STRING = "LEFT"
CONSTANT cs_side_right STRING = "RIGHT"
CONSTANT cs_null_value STRING = "!@#"
#130221 By benson
################################################################################
## Define Combobox related SQLs
DEFINE ms_SQL_Sample         STRING
DEFINE ms_SQL_Global_var     STRING
################################################################################
 
#模組變數(Module Variables)
DEFINE l_ac                  LIKE type_t.num5
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_idx         LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num5              #table1目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num5              #table2目前所在筆數
DEFINE g_detail_idx3         LIKE type_t.num5              #table3目前所在筆數
DEFINE g_detail_idx4         LIKE type_t.num5              #table4目前所在筆數
DEFINE g_detail_idx5         LIKE type_t.num5              #table5目前所在筆數
DEFINE g_detail_idx6         LIKE type_t.num5              #table6目前所在筆數
DEFINE g_rec_b               LIKE type_t.num5              
DEFINE g_rec_b2              LIKE type_t.num5
DEFINE g_rec_b3              LIKE type_t.num5
DEFINE g_rec_b4              LIKE type_t.num5
DEFINE g_rec_b5              LIKE type_t.num5
DEFINE g_rec_b6              LIKE type_t.num5
DEFINE g_table1_d            DYNAMIC ARRAY OF type_table1_d
DEFINE g_table2_d            DYNAMIC ARRAY OF type_table2_d
DEFINE g_table3_d            DYNAMIC ARRAY OF type_table3_d
DEFINE g_table4_d            DYNAMIC ARRAY OF type_table4_d
DEFINE g_table5_d            DYNAMIC ARRAY OF type_table5_d
DEFINE g_table6_d            DYNAMIC ARRAY OF type_table6_d
DEFINE g_checkbox1           LIKE type_t.chr1
DEFINE g_checkbox2           LIKE type_t.chr1
DEFINE g_checkbox3           LIKE type_t.chr1
DEFINE g_textedit1           STRING
DEFINE g_textedit2           STRING
DEFINE g_textedit3           STRING
DEFINE g_rowcount            LIKE type_t.num5
DEFINE g_linesize            LIKE type_t.num5
DEFINE g_pagesize            LIKE type_t.num5
DEFINE g_type                LIKE type_t.chr10
DEFINE g_return              STRING 
{</Module define>}

#無回傳值 
PUBLIC FUNCTION sadzp190(p_code)
DEFINE 
  p_code STRING

  CALL sadzp190_initialize(p_code)
  CALL sadzp190_initial_form()
  CALL sadzp190_start()
  CALL sadzp190_finalize()

END FUNCTION 

#有回傳值 
PUBLIC FUNCTION sadzp190_rtn(p_code)
DEFINE 
  p_code STRING

  CALL sadzp190_initialize(p_code)
  CALL sadzp190_initial_form()
  CALL sadzp190_start()
  CALL sadzp190_finalize()

  RETURN g_return

END FUNCTION 

PRIVATE FUNCTION sadzp190_initialize(p_code)
DEFINE
  p_code STRING  
  
  #CALL cl_tool_init()
  
  LET g_return = NULL 
  LET g_textedit1 = NULL
  LET g_textedit2 = NULL
  LET g_textedit3 = NULL
  
  CASE p_code
    WHEN "adzi220"
      LET g_type = 'r.v'
    WHEN "azzi310"
      LET g_type = 'azzi310'
  OTHERWISE
    LET g_type = 'r.q'
  END CASE 
  
END FUNCTION

PRIVATE FUNCTION sadzp190_initial_form()
DEFINE 
  lw_window   ui.Window,
  lf_form     ui.Form,
  ls_cfg_path STRING,
  ls_4st_path STRING,
  ls_img_path STRING
  
  OPTIONS
  INPUT NO WRAP
  DEFER INTERRUPT
   
  OPEN WINDOW w_adzp190 WITH FORM cl_ap_formpath("adz","adzp190")
  CURRENT WINDOW IS w_adzp190
  TRY
    CLOSE WINDOW SCREEN
  CATCH
  END TRY  

  CALL cl_ui_wintitle(1) #工具抬頭名稱
  CALL cl_load_4ad_interface(NULL)

  LET lw_window = ui.Window.getCurrent()
  LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
  CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))
 
  LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
  LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
  CALL ui.Interface.loadStyles(ls_4st_path)

  #comboBox內容
  CALL cl_set_combo_scc('tab1_03','125')
  CALL cl_set_combo_scc('tab3_07','126')
  CALL cl_set_combo_scc('tab4_07','126')
  CALL cl_set_combo_scc('tab3_03','127')
  CALL cl_set_combo_scc('tab4_03','127')
  CALL cl_set_combo_scc('tab6_03','128')
  CALL cl_set_combo_scc_part('tab3_09','130','(') 
  CALL cl_set_combo_scc_part('tab3_10','130',')') 
  CALL cl_set_combo_scc_part('tab4_09','130','(') 
  CALL cl_set_combo_scc_part('tab4_10','130',')')
  
  CASE g_type
    WHEN "r.v"
      CALL cl_set_comp_visible("grid5",FALSE)
    WHEN "azzi310"
      CALL cl_set_comp_visible("run_sql",FALSE)
      CALL cl_set_comp_visible("lbl_page3",FALSE)
      CALL cl_set_comp_visible("lbl_page5",FALSE)
      CALL cl_set_comp_visible("grid4",FALSE)
  OTHERWISE
    CALL cl_set_comp_visible("grid5",TRUE)
  END CASE
   
  CALL cl_set_act_visible("insert,delete",FALSE)
  
END FUNCTION

PRIVATE FUNCTION sadzp190_finalize()
  #畫面關閉
  CLOSE WINDOW w_adzp190
END FUNCTION
    
#+ 功能選單
PRIVATE FUNCTION sadzp190_start()
DEFINE l_allow_insert   LIKE type_t.num5                #可新增否 
DEFINE l_allow_delete   LIKE type_t.num5                #可刪除否 
DEFINE l_alias_cnt      LIKE type_t.chr5
DEFINE l_i              LIKE type_t.num5
DEFINE lo_left_array    DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE lo_right_array   DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE lo_left_array2   DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE lo_right_array2  DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE ls_tables        STRING
DEFINE ls_cols          STRING
DEFINE l_table_string   STRING
DEFINE l_file_name      STRING  
DEFINE l_run_sql        STRING 
DEFINE l_num1           LIKE type_t.num5
DEFINE l_num2           LIKE type_t.num5
DEFINE l_num            LIKE type_t.num5
DEFINE l_str            STRING
  
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   #該樣板不需此段落CALL gfrm_curr.setElementHidden("worksheet",1)
   
   CALL cl_set_act_visible("accept,cancel", FALSE) 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")

   DIALOG ATTRIBUTES(UNBUFFERED)#,FIELD ORDER FORM)

      INPUT ARRAY g_table1_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            
         AFTER FIELD tab1_01
            IF NOT cl_null(g_table1_d[l_ac].tab1_01) THEN 
               #預設alias 
               IF g_checkbox1 = 'Y' AND cl_null(g_table1_d[l_ac].tab1_02) THEN
                  LET l_alias_cnt = l_ac
                  LET g_table1_d[l_ac].tab1_02 = 't',l_alias_cnt
                  DISPLAY BY NAME g_table1_d[l_ac].tab1_02
               END IF 
               #預設join type
               IF l_ac > 1 AND cl_null(g_table1_d[l_ac].tab1_03) THEN
                  LET g_table1_d[l_ac].tab1_03 = '1'
                  DISPLAY BY NAME g_table1_d[l_ac].tab1_03
               END IF 
            END IF 

         AFTER FIELD tab1_02
            FOR l_i = 1 TO g_table1_d.getLength()
               IF l_i <> l_ac 
                AND NOT cl_null(g_table1_d[l_ac].tab1_02) 
                AND NOT cl_null(g_table1_d[l_i].tab1_02)
                AND g_table1_d[l_ac].tab1_02 = g_table1_d[l_i].tab1_02 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adz-00254'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD tab1_02
               END IF 
            END FOR 

         BEFORE FIELD tab1_03
            IF l_ac = 1 THEN
               IF g_table1_d.getLength() > 1 THEN 
                  CALL DIALOG.setCurrentRow('s_detail1',l_ac+1)
                  LET l_ac = l_ac +1
                  NEXT FIELD tab1_01
               ELSE
                  CALL g_table1_d.appendElement() 
                  CALL DIALOG.setCurrentRow('s_detail1',l_ac+1)
                  LET l_ac = l_ac +1
                  NEXT FIELD tab1_01
               END IF 
            END IF

         BEFORE FIELD tab1_04
            IF l_ac = 1 THEN
               NEXT FIELD tab1_03
            END IF

         BEFORE FIELD tab1_05
            IF l_ac = 1 THEN
               NEXT FIELD tab1_03
            END IF

         ON ACTION controlp INFIELD tab1_01
            #依現有資料產生右邊table資料
            CALL sadzp190_get_right_array() RETURNING lo_right_array
            #產生左邊table資料
            CALL sadzp190_get_table_list() RETURNING lo_left_array
            #開窗
            CALL sadzp190_tbls_run(lo_left_array,lo_right_array) RETURNING lo_right_array
            #顯示回傳資料
            CALL sadzp190_fill_tables(lo_right_array)

         ON ACTION controlp INFIELD tab1_04
            #依欄位產生右邊table資料
            CALL sadzp190_get_right_array3(g_table1_d[l_ac].tab1_04) RETURNING lo_right_array2
            #產生左邊table資料
            CALL sadzp190_get_table_list2(lo_right_array2,"tab1_04") RETURNING lo_left_array2
            #開窗
            CALL sadzp190_tbls_run2(lo_left_array2,lo_right_array2) RETURNING lo_right_array2
            #回傳資料
            CALL sadzp190_get_cols(lo_right_array2) RETURNING g_table1_d[l_ac].tab1_04

         ON ACTION controlp INFIELD tab1_05
            CALL sadzp190_get_right_array3(g_table1_d[l_ac].tab1_05) RETURNING lo_right_array2
            CALL sadzp190_get_table_list2(lo_right_array2,"tab1_05") RETURNING lo_left_array2
            CALL sadzp190_tbls_run2(lo_left_array2,lo_right_array2) RETURNING lo_right_array2
            CALL sadzp190_get_cols(lo_right_array2) RETURNING g_table1_d[l_ac].tab1_05

      
         #刪除
         ON ACTION delete_row
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL FGL_SET_ARR_CURR(l_ac-1)
            CALL g_table1_d.deleteElement(l_ac)
         #新增欄位
         ON ACTION insert_row
            IF NOT cl_null(g_table1_d[l_ac].tab1_01) THEN
               CALL g_table1_d.insertElement(l_ac)
            END IF 
            
         AFTER ROW
            #新增欄位後不輸入
            IF cl_null(g_table1_d[l_ac].tab1_01) THEN
               CALL g_table1_d.deleteElement(l_ac)
            ELSE
               IF NOT cl_null(g_table1_d[l_ac].tab1_03) THEN
                  IF cl_null(g_table1_d[l_ac].tab1_04) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "adz-00260"
                     LET g_errparam.extend =  ""
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD tab1_04
                  END IF 
                  IF cl_null(g_table1_d[l_ac].tab1_05) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "adz-00260"
                     LET g_errparam.extend =  ""
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD tab1_05
                  END IF 
                  #檢查數量
                  LET l_num1 = 0
                  LET l_str = g_table1_d[l_ac].tab1_04
                  LET l_num = l_str.getIndexOf(",",1)
                  IF l_num > 0 THEN 
                     LET l_num1 = 1
                  END IF 
                  WHILE l_num > 0
                     LET l_num = l_str.getIndexOf(",",l_num + 1)
                     IF l_num > 0 THEN
                        LET l_num1 = l_num1 + 1
                     END IF
                  END WHILE
                  LET l_num2 = 0
                  LET l_str = g_table1_d[l_ac].tab1_05
                  LET l_num = l_str.getIndexOf(",",1)
                  IF l_num > 0 THEN 
                     LET l_num2 = 1
                  END IF 
                  WHILE l_num > 0
                     LET l_num = l_str.getIndexOf(",",l_num + 1)
                     IF l_num > 0 THEN
                        LET l_num2 = l_num2 + 1
                     END IF
                  END WHILE
                  IF l_num1 <> l_num2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "adz-00260"
                     LET g_errparam.extend =  ""
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     IF l_num1 < l_num2 THEN 
                        NEXT FIELD tab1_04
                     ELSE
                        NEXT FIELD tab1_05
                     END IF 
                  END IF 
               ELSE
                  IF NOT cl_null(g_table1_d[l_ac].tab1_04) THEN
                     LET g_table1_d[l_ac].tab1_04 = NULL
                     DISPLAY BY NAME g_table1_d[l_ac].tab1_04
                  END IF 
                  IF NOT cl_null(g_table1_d[l_ac].tab1_05) THEN
                     LET g_table1_d[l_ac].tab1_05 = NULL
                     DISPLAY BY NAME g_table1_d[l_ac].tab1_05
                  END IF 
               END IF
            END IF
             
      END INPUT 

      INPUT ARRAY g_table2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         BEFORE ROW
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx2 

         AFTER FIELD tab2_02
            IF NOT cl_null(g_table2_d[l_ac].tab2_02) THEN 
               #預設alias 
               IF g_checkbox2 = 'Y' AND cl_null(g_table2_d[l_ac].tab2_03) THEN
                  LET l_alias_cnt = l_ac
                  LET g_table2_d[l_ac].tab2_03 = 'c',l_alias_cnt
                  DISPLAY BY NAME g_table2_d[l_ac].tab2_03
               END IF
            END IF 
            
         AFTER FIELD tab2_03
            FOR l_i = 1 TO g_table2_d.getLength()
               IF l_i <> l_ac 
                 AND NOT cl_null(g_table2_d[l_ac].tab2_03)
                 AND NOT cl_null(g_table2_d[l_i].tab2_03)
                 AND g_table2_d[l_ac].tab2_03 = g_table2_d[l_i].tab2_03 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adz-00254'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD tab2_03
               END IF 
            END FOR 

         ON ACTION controlp INFIELD tab2_02
            CALL sadzp190_get_right_array2() RETURNING lo_right_array2
            CALL sadzp190_get_table_list2(lo_right_array2,"tab2_02") RETURNING lo_left_array2
            CALL sadzp190_tbls_run2(lo_left_array2,lo_right_array2) RETURNING lo_right_array2
            CALL sadzp190_fill_tables2(lo_right_array2)
         #刪除 
         ON ACTION delete_row
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            CALL FGL_SET_ARR_CURR(l_ac-1)
            CALL g_table2_d.deleteElement(l_ac)

         #新增欄位
         ON ACTION insert_row
            IF NOT cl_null(g_table2_d[l_ac].tab2_02) THEN
               CALL g_table2_d.insertElement(l_ac)
            END IF 
            
         AFTER ROW
            #新增欄位後不輸入
            IF cl_null(g_table2_d[l_ac].tab2_02) THEN
               CALL g_table2_d.deleteElement(l_ac)
            END IF
      END INPUT       


      INPUT ARRAY g_table3_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b3,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         BEFORE ROW
            LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = g_detail_idx3
            IF l_ac > 1 THEN 
               IF g_table3_d[l_ac-1].tab3_03 = 'A' OR g_table3_d[l_ac-1].tab3_03 = 'B' THEN
                  CALL cl_set_comp_required("tab3_02,tab3_03",FALSE)
               ELSE 
                  CALL cl_set_comp_required("tab3_02,tab3_03",TRUE)
               END IF 
            END IF 

         BEFORE INSERT 
            IF l_ac > 1 THEN
               LET g_table3_d[l_ac].tab3_07 = '1'
            END IF 

         AFTER FIELD tab3_02
            IF cl_null(g_table3_d[l_ac].tab3_03) AND NOT cl_null(g_table3_d[l_ac].tab3_02) THEN
               LET g_table3_d[l_ac].tab3_03 = '1'
               DISPLAY BY NAME g_table3_d[l_ac].tab3_03
            END IF 

         AFTER FIELD tab3_04
            IF NOT cl_null(g_table3_d[l_ac].tab3_04) THEN
               IF NOT cl_null(g_table3_d[l_ac].tab3_06) THEN
                  LET g_table3_d[l_ac].tab3_05 = NULL
                  LET g_table3_d[l_ac].tab3_06 = NULL
                  DISPLAY BY NAME g_table3_d[l_ac].tab3_05,g_table3_d[l_ac].tab3_06
               END IF 
            END IF 

         AFTER FIELD tab3_06
            IF NOT cl_null(g_table3_d[l_ac].tab3_06) THEN
               IF NOT cl_null(g_table3_d[l_ac].tab3_04) THEN
                  LET g_table3_d[l_ac].tab3_04 = NULL
                  DISPLAY BY NAME g_table3_d[l_ac].tab3_04
               END IF 
            END IF

         AFTER FIELD tab3_07
            IF l_ac = 1 THEN
               IF NOT cl_null(g_table3_d[l_ac].tab3_07) THEN 
                  LET g_table3_d[l_ac].tab3_07 = NULL
                  DISPLAY BY NAME g_table3_d[l_ac].tab3_07
               END IF 
            ELSE
               IF cl_null(g_table3_d[l_ac].tab3_07) THEN
                  NEXT FIELD tab3_07
               END IF 
            END IF 

         ON ACTION controlp INFIELD tab3_02
            CALL sadzp190_get_tables(g_table1_d) RETURNING l_table_string
            IF NOT cl_null(l_table_string) THEN 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "dzeb001 IN(",l_table_string,")"
               CALL q_dzeb002_5()                           #呼叫開窗
               LET g_table3_d[l_ac].tab3_02 = g_qryparam.return2
               DISPLAY BY NAME g_table3_d[l_ac].tab3_02
               FOR l_i = 1 TO g_table1_d.getLength()
                  IF g_table1_d[l_i].tab1_01 = g_qryparam.return1 THEN
                     LET g_table3_d[l_ac].tab3_01 = g_table1_d[l_i].tab1_02
                     EXIT FOR 
                  END IF 
               END FOR 
            END IF 
            NEXT FIELD tab3_02

         ON ACTION controlp INFIELD tab3_04
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "129"
            CALL q_gzcb001()                           #呼叫開窗
            LET g_table3_d[l_ac].tab3_04 = g_qryparam.return1
            DISPLAY BY NAME g_table3_d[l_ac].tab3_04
            NEXT FIELD tab3_04
            
         ON ACTION controlp INFIELD tab3_06
            CALL sadzp190_get_tables(g_table1_d) RETURNING l_table_string
            IF NOT cl_null(l_table_string) THEN 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "dzeb001 IN(",l_table_string,")"
               CALL q_dzeb002_5()                           #呼叫開窗
               LET g_table3_d[l_ac].tab3_06 = g_qryparam.return2
               DISPLAY BY NAME g_table3_d[l_ac].tab3_06
               FOR l_i = 1 TO g_table1_d.getLength()
                  IF g_table1_d[l_i].tab1_01 = g_qryparam.return1 THEN
                     LET g_table3_d[l_ac].tab3_05 = g_table1_d[l_i].tab1_02
                     EXIT FOR 
                  END IF 
               END FOR 
            END IF 
            NEXT FIELD tab3_06
            
         #刪除
         ON ACTION delete_row
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            CALL FGL_SET_ARR_CURR(l_ac-1)
            CALL g_table3_d.deleteElement(l_ac)

         #新增欄位
         ON ACTION insert_row
            IF NOT cl_null(g_table3_d[l_ac].tab3_02) THEN
               CALL g_table3_d.insertElement(l_ac)
            END IF 
            
         AFTER ROW
            #新增欄位後不輸入
            IF cl_null(g_table3_d[l_ac].tab3_02) THEN
               IF l_ac > 1 THEN 
                  IF g_table3_d[l_ac-1].tab3_03 <> 'A' AND  g_table3_d[l_ac-1].tab3_03 <> 'B' THEN
                     CALL g_table3_d.deleteElement(l_ac)
                  END IF 
               ELSE
                  CALL g_table3_d.deleteElement(l_ac)
               END IF 
            END IF

         AFTER INPUT
            LET l_num1 = 0
            LET l_num2 = 0
            FOR l_i = 1 TO g_table3_d.getLength()
               IF NOT cl_null(g_table3_d[l_i].tab3_09) THEN
                  LET l_num1 = l_num1 + 1
               END IF 
               IF NOT cl_null(g_table3_d[l_i].tab3_10) THEN
                  LET l_num2 = l_num2 + 1
               END IF 
            END FOR 
            IF l_num1 <> l_num2 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00262"
               LET g_errparam.extend =  ""
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD tab3_10
            END IF 
      END INPUT 

      INPUT ARRAY g_table4_d FROM s_detail4.*
          ATTRIBUTE(COUNT = g_rec_b4,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         BEFORE ROW
            LET g_detail_idx4 = DIALOG.getCurrentRow("s_detail4")
            LET l_ac = g_detail_idx4
            IF l_ac > 1 THEN 
               IF g_table4_d[l_ac-1].tab4_03 = 'A' OR g_table4_d[l_ac-1].tab4_03 = 'B' THEN
                  CALL cl_set_comp_required("tab4_02,tab4_03",FALSE)
               ELSE 
                  CALL cl_set_comp_required("tab4_02,tab4_03",TRUE)
               END IF 
            END IF 

         BEFORE INSERT 
            IF l_ac > 1 THEN
               LET g_table4_d[l_ac].tab4_07 = '1'
            END IF 
            
         AFTER FIELD tab4_02
            IF cl_null(g_table4_d[l_ac].tab4_03) AND NOT cl_null(g_table4_d[l_ac].tab4_02) THEN
               LET g_table4_d[l_ac].tab4_03 = '1'
               DISPLAY BY NAME g_table4_d[l_ac].tab4_03
            END IF 
            
         AFTER FIELD tab4_04
            IF NOT cl_null(g_table4_d[l_ac].tab4_04) THEN
               IF NOT cl_null(g_table4_d[l_ac].tab4_06) THEN
                  LET g_table4_d[l_ac].tab4_05 = NULL
                  LET g_table4_d[l_ac].tab4_06 = NULL
                  DISPLAY BY NAME g_table4_d[l_ac].tab4_05,g_table4_d[l_ac].tab4_06
               END IF 
            END IF 

         AFTER FIELD tab4_06
            IF NOT cl_null(g_table4_d[l_ac].tab4_06) THEN
               IF NOT cl_null(g_table4_d[l_ac].tab4_04) THEN
                  LET g_table4_d[l_ac].tab4_04 = NULL
                  DISPLAY BY NAME g_table4_d[l_ac].tab4_04
               END IF 
            END IF 

         AFTER FIELD tab4_07
            IF l_ac <> 1 THEN
               IF cl_null(g_table4_d[l_ac].tab4_07) THEN
                  NEXT FIELD tab4_07
               END IF 
            END IF
            
         ON ACTION controlp INFIELD tab4_02
            CALL sadzp190_get_tables(g_table1_d) RETURNING l_table_string
            IF NOT cl_null(l_table_string) THEN 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "dzeb001 IN(",l_table_string,")"
               CALL q_dzeb002_5()                           #呼叫開窗
               LET g_table4_d[l_ac].tab4_02 = g_qryparam.return2
               DISPLAY BY NAME g_table4_d[l_ac].tab4_02
               FOR l_i = 1 TO g_table1_d.getLength()
                  IF g_table1_d[l_i].tab1_01 = g_qryparam.return1 THEN
                     LET g_table4_d[l_ac].tab4_01 = g_table1_d[l_i].tab1_02
                     EXIT FOR 
                  END IF 
               END FOR 
            END IF 
            NEXT FIELD tab4_02

         ON ACTION controlp INFIELD tab4_04
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "129"
            CALL q_gzcb001()                           #呼叫開窗
            LET g_table4_d[l_ac].tab4_04 = g_qryparam.return1
            DISPLAY BY NAME g_table4_d[l_ac].tab4_04
            NEXT FIELD tab4_04
            
         ON ACTION controlp INFIELD tab4_06
            CALL sadzp190_get_tables(g_table1_d) RETURNING l_table_string
            IF NOT cl_null(l_table_string) THEN 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "dzeb001 IN(",l_table_string,")"
               CALL q_dzeb002_5()                           #呼叫開窗
               LET g_table4_d[l_ac].tab4_06 = g_qryparam.return2
               DISPLAY BY NAME g_table4_d[l_ac].tab4_06
               FOR l_i = 1 TO g_table1_d.getLength()
                  IF g_table1_d[l_i].tab1_01 = g_qryparam.return1 THEN
                     LET g_table4_d[l_ac].tab4_05 = g_table1_d[l_i].tab1_02
                     EXIT FOR 
                  END IF 
               END FOR 
            END IF 
            NEXT FIELD tab4_06
         #刪除
         ON ACTION delete_row
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
            CALL FGL_SET_ARR_CURR(l_ac-1)
            CALL g_table4_d.deleteElement(l_ac)

         #新增欄位
         ON ACTION insert_row
            IF NOT cl_null(g_table4_d[l_ac].tab4_02) THEN
               CALL g_table4_d.insertElement(l_ac)
            END IF 
            
         AFTER ROW
            #新增欄位後不輸入
            IF cl_null(g_table4_d[l_ac].tab4_02) THEN
               IF l_ac > 1 THEN 
                  IF g_table4_d[l_ac-1].tab4_03 <> 'A' AND g_table4_d[l_ac-1].tab4_03 <> 'B' THEN
                     CALL g_table4_d.deleteElement(l_ac)
                  END IF 
               ELSE
                  CALL g_table4_d.deleteElement(l_ac)
               END IF 
            END IF

         AFTER INPUT
            LET l_num1 = 0
            LET l_num2 = 0
            FOR l_i = 1 TO g_table4_d.getLength()
               IF NOT cl_null(g_table4_d[l_i].tab4_09) THEN
                  LET l_num1 = l_num1 + 1
               END IF 
               IF NOT cl_null(g_table4_d[l_i].tab4_10) THEN
                  LET l_num2 = l_num2 + 1
               END IF 
            END FOR 
            IF l_num1 <> l_num2 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00262"
               LET g_errparam.extend =  ""
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD tab4_10
            END IF 
      END INPUT 

      INPUT ARRAY g_table5_d FROM s_detail5.*
          ATTRIBUTE(COUNT = g_rec_b5,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         BEFORE ROW
            LET g_detail_idx5 = DIALOG.getCurrentRow("s_detail5")
            LET l_ac = g_detail_idx5

         ON ACTION controlp INFIELD tab5_02
            CALL sadzp190_get_tables(g_table1_d) RETURNING l_table_string
            IF NOT cl_null(l_table_string) THEN 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "dzeb001 IN(",l_table_string,")"
               CALL q_dzeb002_5()                           #呼叫開窗
               LET g_table5_d[l_ac].tab5_02 = g_qryparam.return2
               DISPLAY BY NAME g_table5_d[l_ac].tab5_02
               FOR l_i = 1 TO g_table1_d.getLength()
                  IF g_table1_d[l_i].tab1_01 = g_qryparam.return1 THEN
                     LET g_table5_d[l_ac].tab5_01 = g_table1_d[l_i].tab1_02
                     EXIT FOR 
                  END IF 
               END FOR 
            END IF 
            NEXT FIELD tab5_02
            
         #刪除
         ON ACTION delete_row
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
            CALL FGL_SET_ARR_CURR(l_ac-1)
            CALL g_table5_d.deleteElement(l_ac)

         #新增欄位
         ON ACTION insert_row
            IF NOT cl_null(g_table5_d[l_ac].tab5_02) THEN
               CALL g_table5_d.insertElement(l_ac)
            END IF 
            
         AFTER ROW
            #新增欄位後不輸入
            IF cl_null(g_table5_d[l_ac].tab5_02) THEN
               CALL g_table5_d.deleteElement(l_ac)
            END IF
      END INPUT 

      INPUT ARRAY g_table6_d FROM s_detail6.*
          ATTRIBUTE(COUNT = g_rec_b6,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         BEFORE ROW
            LET g_detail_idx6 = DIALOG.getCurrentRow("s_detail6")
            LET l_ac = g_detail_idx6
            
         AFTER FIELD tab6_02
            IF NOT cl_null(g_table6_d[l_ac].tab6_02) AND cl_null(g_table6_d[l_ac].tab6_03) THEN 
               LET g_table6_d[l_ac].tab6_03 = '1'
               DISPLAY BY NAME g_table6_d[l_ac].tab6_03
            END IF 

         ON ACTION controlp INFIELD tab6_02
            CALL sadzp190_get_tables(g_table1_d) RETURNING l_table_string
            IF NOT cl_null(l_table_string) THEN 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "dzeb001 IN(",l_table_string,")"
               CALL q_dzeb002_5()                           #呼叫開窗
               LET g_table6_d[l_ac].tab6_02 = g_qryparam.return2
               DISPLAY BY NAME g_table6_d[l_ac].tab6_02
               FOR l_i = 1 TO g_table1_d.getLength()
                  IF g_table1_d[l_i].tab1_01 = g_qryparam.return1 THEN
                     LET g_table6_d[l_ac].tab6_01 = g_table1_d[l_i].tab1_02
                     EXIT FOR 
                  END IF 
               END FOR 
            END IF 
            NEXT FIELD tab6_02
            
         #刪除    
         ON ACTION delete_row
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail6")
            CALL FGL_SET_ARR_CURR(l_ac-1)
            CALL g_table6_d.deleteElement(l_ac)

         #新增欄位
         ON ACTION insert_row
            IF NOT cl_null(g_table6_d[l_ac].tab6_02) THEN
               CALL g_table6_d.insertElement(l_ac)
            END IF 
            
         AFTER ROW
            #新增欄位後不輸入
            IF cl_null(g_table6_d[l_ac].tab6_02) THEN
               CALL g_table6_d.deleteElement(l_ac)
            END IF
      END INPUT

      INPUT g_checkbox1,g_checkbox2,g_checkbox3,g_textedit1,g_textedit2,g_rowcount,g_linesize,g_pagesize
       FROM checkbox1,checkbox2,checkbox3,textedit1,textedit2,rowcount,linesize,pagesize

       #AFTER FIELD textedit1
       #      CALL adzp190_gen_sql2(g_textedit1) RETURNING g_textedit2
       #      DISPLAY g_textedit2 TO textedit2

       #AFTER FIELD textedit2
       #      CALL adzp190_gen_sql3(g_textedit2) RETURNING g_textedit1
       #      DISPLAY g_textedit1 TO textedit1
             
      END INPUT 
      
      BEFORE DIALOG
         LET g_checkbox1 = 'N'
         LET g_checkbox2 = 'N'
         IF g_type = "r.q" THEN 
            LET g_checkbox3 = 'Y'
         ELSE 
            LET g_checkbox3 = 'N'
         END IF 
         LET g_rowcount = 10
         LET g_linesize = 300
         LET g_pagesize = 10

      ON ACTION run_sql
         #加入行數限制
         CALL sadzp190_sql_rowcount(g_textedit1,g_rowcount) RETURNING l_run_sql
         #產生sql檔
         CALL sadzp190_db_gen_sql_file(l_run_sql,g_linesize,g_pagesize + 3) RETURNING l_file_name
         #執行sqlplus
         CALL sadzp190_db_run(l_file_name,g_rowcount) RETURNING g_textedit3
         DISPLAY g_textedit3 TO textedit3
     
      ON ACTION gen_sql
         #產生SQL
         CALL adzp190_gen_sql1('1') RETURNING g_textedit1
         DISPLAY g_textedit1 TO textedit1
         CALL adzp190_gen_sql1('2') RETURNING g_textedit2
         DISPLAY g_textedit2 TO textedit2
         #產生回傳SQL,需考慮r.q r.v
         #CALL adzp190_gen_sql2(g_textedit1) RETURNING g_textedit2
         #DISPLAY g_textedit2 TO textedit2
         CONTINUE DIALOG 

      ON ACTION return_sql
         IF sadzp190_sql_verify(g_textedit2) THEN 
           CASE g_type
             WHEN "r.v"
               LET g_return = g_textedit2
             WHEN "azzi310"
             LET g_return = g_textedit1
           OTHERWISE
             LET g_return = g_textedit2
           END CASE
           EXIT DIALOG 
         END IF 

      ON ACTION clear_sql
         CALL g_table1_d.clear()
         CALL g_table2_d.clear()
         CALL g_table3_d.clear()
         CALL g_table4_d.clear()
         CALL g_table5_d.clear()
         CALL g_table6_d.clear()
         LET g_textedit1 = NULL
         LET g_textedit2 = NULL
         LET g_textedit3 = NULL
         DISPLAY g_textedit3 TO textedit3
       
      ON ACTION close
         LET INT_FLAG=FALSE        
         EXIT DIALOG     
       
      #ON ACTION exit
      #   EXIT DIALOG

      ON ACTION exit_prog
         IF cl_ask_confirm('adz-00261') THEN
            EXIT DIALOG
         END IF 

      #主選單用ACTION
      #&include "main_menu.4gl"
      #交談指令共用ACTION
      #&include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION

#產生左邊table資料
FUNCTION sadzp190_get_table_list()
DEFINE lo_table_array   DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE li_rec_cnt       LIKE type_t.num10
DEFINE ls_sql           STRING
DEFINE lo_return        DYNAMIC ARRAY OF T_OBJECT_LIST




  LET ls_sql = "SELECT EA.DZEA001,  EAL.DZEAL003                                   ",
               "  FROM DZEA_T EA                                                   ",
               "       LEFT OUTER JOIN DZEAL_T EAL ON EAL.DZEAL001 = EA.DZEA001    ",
               "                                  AND EAL.DZEAL002 = '",g_lang,"' ",
               " WHERE 1=1                                                         ",
               " ORDER BY EA.DZEA001                       "
                                
                                                      
  PREPARE lpre_get_table_list FROM ls_sql
  DECLARE lcur_get_table_list CURSOR FOR lpre_get_table_list

  LET li_rec_cnt = 1

  CALL lo_table_array.Clear()

  OPEN lcur_get_table_list
  FOREACH lcur_get_table_list INTO lo_table_array[li_rec_cnt].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_rec_cnt = li_rec_cnt + 1

  END FOREACH
  CALL lo_table_array.deleteElement(li_rec_cnt)
  
  CLOSE lcur_get_table_list

  FREE lpre_get_table_list
  FREE lcur_get_table_list   

  LET lo_return.* = lo_table_array.*

  RETURN lo_return

END FUNCTION
#顯示回傳資料
FUNCTION sadzp190_fill_tables(p_tables)
DEFINE p_tables         DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE li_index         LIKE type_t.num5
DEFINE ls_tables        DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_i              LIKE type_t.num5
DEFINE l_alias_num      LIKE type_t.chr5
DEFINE l_table1_d       DYNAMIC ARRAY OF type_table1_d

  LET ls_tables.* = p_tables.*

  #備份畫面資料
  FOR l_i = 1 TO g_table1_d.getLength()
     LET l_table1_d[l_i].* = g_table1_d[l_i].*
  END FOR 
  CALL g_table1_d.clear()

  LET l_cnt = 1
  FOR li_index = 1 TO ls_tables.getLength()
      IF NOT cl_null(ls_tables[li_index].OBJECT_NAME) THEN 
         IF g_checkbox1 = 'Y' THEN
            LET l_alias_num = l_cnt
            LET g_table1_d[l_cnt].tab1_02 = 't',l_alias_num
         END IF 
         LET g_table1_d[l_cnt].tab1_01 = ls_tables[li_index].OBJECT_NAME
         IF l_cnt > 1 THEN
            LET g_table1_d[l_cnt].tab1_03 = '1'
         END IF 
         FOR l_i = 1 TO l_table1_d.getLength()
            IF l_table1_d[l_i].tab1_01 = ls_tables[li_index].OBJECT_NAME THEN
               LET g_table1_d[l_cnt].* = l_table1_d[l_i].*
               CALL l_table1_d.deleteElement(l_i)
               EXIT FOR 
            END IF 
         END FOR 
         DISPLAY BY NAME g_table1_d[l_cnt].*
         LET l_cnt = l_cnt + 1
      END IF 
  END FOR 
  
END FUNCTION
#依現有資料產生右邊table資料
FUNCTION sadzp190_get_right_array()
DEFINE ls_tables        DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE lo_return        DYNAMIC ARRAY OF T_OBJECT_LIST
DEFINE l_i              LIKE type_t.num5

  FOR l_i = 1 TO g_table1_d.getLength()
     LET ls_tables[l_i].OBJECT_NAME = g_table1_d[l_i].tab1_01
     SELECT EAL.DZEAL003 
       INTO ls_tables[l_i].OBJECT_DESC
       FROM DZEAL_T EAL WHERE EAL.DZEAL002 = g_lang
        AND EAL.DZEAL001 = ls_tables[l_i].OBJECT_NAME
  END FOR 
  LET lo_return.* = ls_tables.*
  
  RETURN lo_return
END FUNCTION 
#產生左邊table資料
FUNCTION sadzp190_get_table_list2(p_cols,p_type)
DEFINE p_cols           DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE p_type           LIKE type_t.chr10
DEFINE ls_cols          DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE lo_col_array     DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE li_rec_cnt       LIKE type_t.num10
DEFINE ls_sql           STRING
DEFINE lo_return        DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE l_i              LIKE type_t.num5
DEFINE l_j              LIKE type_t.num5
DEFINE l_dzeb002        LIKE dzeb_t.dzeb002
DEFINE l_dzebl003       LIKE dzebl_t.dzebl003
DEFINE l_flag           LIKE type_t.chr1

  LET ls_cols.* = p_cols.*

  LET ls_sql = "SELECT EB.DZEB002,  EBL.DZEBL003                                   ",
               "  FROM DZEB_T EB                                                   ",
               "       LEFT OUTER JOIN DZEBL_T EBL ON EBL.DZEBL001 = EB.DZEB002    ",
               "                                  AND EBL.DZEBL002 = '",g_lang,"'  ",
               " WHERE 1=1                                                         ",
               "   AND EB.DZEB001 = ?                                              ",
               " ORDER BY EB.DZEB002                                               "
                                                      
  PREPARE lpre_get_table_list2 FROM ls_sql
  DECLARE lcur_get_table_list2 CURSOR FOR lpre_get_table_list2

  LET li_rec_cnt = 1

  CALL lo_col_array.Clear()

  FOR l_i = 1 TO g_table1_d.getLength()
  
     OPEN lcur_get_table_list2 USING g_table1_d[l_i].tab1_01
     FOREACH lcur_get_table_list2 INTO l_dzeb002,l_dzebl003
       IF SQLCA.sqlcode THEN
         EXIT FOREACH
       END IF
       LET l_flag = 'N'
       FOR l_j = 1 TO ls_cols.getLength()
          IF (ls_cols[l_j].ALIAS = g_table1_d[l_i].tab1_02 
            OR (cl_null(ls_cols[l_j].ALIAS) AND cl_null(g_table1_d[l_i].tab1_02)))
             AND ls_cols[l_j].OBJECT_NAME = l_dzeb002 THEN
             
             LET l_flag = 'Y'
             EXIT FOR 
          END IF 
       END FOR 
       IF l_flag = 'N' THEN 
          LET lo_col_array[li_rec_cnt].ALIAS = g_table1_d[l_i].tab1_02
          LET lo_col_array[li_rec_cnt].OBJECT_NAME = l_dzeb002
          LET lo_col_array[li_rec_cnt].OBJECT_DESC = l_dzebl003
          LET li_rec_cnt = li_rec_cnt + 1
       END IF 
     END FOREACH
     CALL lo_col_array.deleteElement(li_rec_cnt)
  END FOR 
  CLOSE lcur_get_table_list2

  FREE lpre_get_table_list2
  FREE lcur_get_table_list2  
  IF p_type = "tab2_02" THEN 
     IF g_type = "r.v" THEN
        CALL lo_col_array.insertElement(1)
        LET lo_col_array[1].OBJECT_NAME = "COUNT(*)"
     END IF   
  END IF 
  IF p_type = "tab1_05" THEN
     CALL lo_col_array.insertElement(1)
     LET lo_col_array[1].OBJECT_NAME = ":USER"
     CALL lo_col_array.insertElement(1)
     LET lo_col_array[1].OBJECT_NAME = ":TODAY"
     CALL lo_col_array.insertElement(1)
     LET lo_col_array[1].OBJECT_NAME = ":SITE"
     CALL lo_col_array.insertElement(1)
     LET lo_col_array[1].OBJECT_NAME = ":LEGAL"
     CALL lo_col_array.insertElement(1)
     LET lo_col_array[1].OBJECT_NAME = ":LANG"
     CALL lo_col_array.insertElement(1)
     LET lo_col_array[1].OBJECT_NAME = ":ENT"
     CALL lo_col_array.insertElement(1)
     LET lo_col_array[1].OBJECT_NAME = ":DLANG"
     CALL lo_col_array.insertElement(1)
     LET lo_col_array[1].OBJECT_NAME = ":DEPT"
  END IF 

  LET lo_return.* = lo_col_array.*

  RETURN lo_return

END FUNCTION
#依畫面欄位產生右邊table值
FUNCTION sadzp190_get_right_array2()
DEFINE ls_cols          DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE lo_return        DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE l_i              LIKE type_t.num5

  FOR l_i = 1 TO g_table2_d.getLength()
     LET ls_cols[l_i].ALIAS = g_table2_d[l_i].tab2_01
     LET ls_cols[l_i].OBJECT_NAME = g_table2_d[l_i].tab2_02
     SELECT EBL.DZEBL003 
       INTO ls_cols[l_i].OBJECT_DESC
       FROM DZEBL_T EBL WHERE EBL.DZEBL002 = g_lang
        AND EBL.DZEBL001 = ls_cols[l_i].OBJECT_NAME
  END FOR 
  LET lo_return.* = ls_cols.*
  
  RETURN lo_return
END FUNCTION 
#回填畫面值
FUNCTION sadzp190_fill_tables2(p_tables)
DEFINE p_tables         DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE li_index         LIKE type_t.num5
DEFINE ls_tables        DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_i              LIKE type_t.num5
DEFINE l_alias_num      LIKE type_t.chr5
DEFINE l_table2_d       DYNAMIC ARRAY OF type_table2_d

  LET ls_tables.* = p_tables.*

  #備份畫面資料
  FOR l_i = 1 TO g_table2_d.getLength()
     LET l_table2_d[l_i].* = g_table2_d[l_i].*
  END FOR 
  CALL g_table2_d.clear()

  LET l_cnt = 1
  FOR li_index = 1 TO ls_tables.getLength()
     IF NOT cl_null(ls_tables[li_index].OBJECT_NAME) THEN
        IF g_checkbox2 = 'Y' THEN
           LET l_alias_num = l_cnt
           LET g_table2_d[l_cnt].tab2_03 = 'c',l_alias_num
        END IF
        LET g_table2_d[l_cnt].tab2_01 = ls_tables[li_index].ALIAS
        LET g_table2_d[l_cnt].tab2_02 = ls_tables[li_index].OBJECT_NAME
        FOR l_i = 1 TO l_table2_d.getLength()
           IF l_table2_d[l_i].tab2_02 = ls_tables[li_index].OBJECT_NAME THEN
              LET g_table2_d[l_cnt].* = l_table2_d[l_i].*
              CALL l_table2_d.deleteElement(l_i)
              EXIT FOR 
           END IF 
        END FOR 
        #DISPLAY BY NAME g_table2_d[l_cnt].*
        LET l_cnt = l_cnt + 1
     END IF 
  END FOR 

END FUNCTION
#依欄位產生右邊table資料
FUNCTION sadzp190_get_right_array3(p_cols)
DEFINE p_cols           STRING 
DEFINE ls_colmns        DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE ls_return        DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE li_index         LIKE type_t.num5
DEFINE ls_cols          STRING 
DEFINE ls_cols_char     STRING
DEFINE ls_cols_string   STRING
DEFINE ls_cols_queue    STRING
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_num            LIKE type_t.num5

  LET ls_cols = p_cols
  LET ls_cols_queue  = "" 
  LET ls_cols_string = ""
  LET l_cnt = 1
  
  FOR li_index = 1 TO ls_cols.getLength()
    LET ls_cols_char = NVL(ls_cols.subString(li_index,li_index),cs_null_value) 
    IF ls_cols_char MATCHES "," THEN
       LET l_num = ls_cols_string.getIndexOf(".",1)
       IF l_num > 0 THEN
          LET ls_colmns[l_cnt].ALIAS = ls_cols_string.subString(1,l_num-1)
          LET ls_cols_string = ls_cols_string.subString(l_num+1,ls_cols_string.getLength())
       END IF 
       LET ls_colmns[l_cnt].OBJECT_NAME = ls_cols_string
       SELECT EBL.DZEBL003 
         INTO ls_colmns[l_cnt].OBJECT_DESC
         FROM DZEBL_T EBL WHERE EBL.DZEBL002 = g_lang
          AND EBL.DZEBL001 = ls_colmns[l_cnt].OBJECT_NAME
       LET ls_cols_string = ""
       LET l_cnt = l_cnt + 1
    ELSE
      LET ls_cols_string = ls_cols_string,ls_cols_char 
    END IF    
  END FOR

  #最後一組或僅有一組要加入Queue
  LET l_num = ls_cols_string.getIndexOf(".",1)
  IF l_num > 0 THEN
     LET ls_colmns[l_cnt].ALIAS = ls_cols_string.subString(1,l_num-1)
     LET ls_cols_string = ls_cols_string.subString(l_num+1,ls_cols_string.getLength())
  END IF 
  LET ls_colmns[l_cnt].OBJECT_NAME = ls_cols_string
  SELECT EBL.DZEBL003 
    INTO ls_colmns[l_cnt].OBJECT_DESC
    FROM DZEBL_T EBL WHERE EBL.DZEBL002 = g_lang
     AND EBL.DZEBL001 = ls_colmns[l_cnt].OBJECT_NAME

  LET ls_return.* = ls_colmns.*
  
  RETURN ls_return

END FUNCTION 
#回傳資料
FUNCTION sadzp190_get_cols(p_cols)
DEFINE p_cols           DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE ls_cols          DYNAMIC ARRAY OF T_OBJECT_LIST2
DEFINE ls_colmns        STRING
DEFINE ls_return        STRING
DEFINE l_i              LIKE type_t.num5

  LET ls_cols.* = p_cols.*
  FOR l_i = 1 TO ls_cols.getLength()
     IF NOT cl_null(ls_cols[l_i].OBJECT_NAME) THEN 
        IF NOT cl_null(ls_colmns) THEN
           LET ls_colmns = ls_colmns,","
        END IF 
        IF NOT cl_null(ls_cols[l_i].ALIAS) THEN
           LET ls_colmns = ls_colmns,ls_cols[l_i].ALIAS,".",ls_cols[l_i].OBJECT_NAME
        ELSE
           LET ls_colmns = ls_colmns,ls_cols[l_i].OBJECT_NAME
        END IF 
     END IF
  END FOR 

  LET ls_return = ls_colmns
  RETURN ls_return
END FUNCTION 
#將資料組成string
FUNCTION sadzp190_get_tables(p_tables)
DEFINE p_tables         DYNAMIC ARRAY OF type_table1_d
DEFINE ls_tables        DYNAMIC ARRAY OF type_table1_d
DEFINE ls_string        STRING
DEFINE ls_return        STRING
DEFINE l_i              LIKE type_t.num5

  LET ls_tables.* = p_tables.*
  FOR l_i = 1 TO ls_tables.getLength()
     IF NOT cl_null(ls_tables[l_i].tab1_01) THEN 
        IF NOT cl_null(ls_string) THEN
           LET ls_string = ls_string,","
        END IF 
        LET ls_string = ls_string,"'",ls_tables[l_i].tab1_01,"'"
     END IF
  END FOR 

  LET ls_return = ls_string
  RETURN ls_return
END FUNCTION 
#由畫面產生SQL
FUNCTION adzp190_gen_sql1(p_type)
DEFINE p_type     LIKE type_t.chr1
DEFINE l_return   STRING
DEFINE l_select   STRING
DEFINE l_from     STRING
DEFINE l_where    STRING
DEFINE l_where2   STRING
DEFINE l_group    STRING 
DEFINE l_order    STRING 
DEFINE l_i        LIKE type_t.num5
DEFINE l_str1     STRING
DEFINE l_str2     STRING
DEFINE l_sub      STRING
DEFINE l_num      LIKE type_t.num5
DEFINE l_on       STRING 
DEFINE l_str      STRING 
DEFINE l_start    LIKE type_t.num5
DEFINE l_end      LIKE type_t.num5

   #from
   LET l_from = "FROM "
   IF p_type = '2' THEN
      LET l_from = l_from, G_TABLE_START#"<table>"
   END IF 
   FOR l_i = 1 TO g_table1_d.getLength()
      IF NOT cl_null(g_table1_d[l_i].tab1_01) THEN
         IF l_i = 1 THEN
            LET l_from = l_from,g_table1_d[l_i].tab1_01
            IF NOT cl_null(g_table1_d[l_i].tab1_02) THEN
               LET l_from = l_from," ",g_table1_d[l_i].tab1_02
            END IF
         ELSE 
            IF cl_null(g_table1_d[l_i].tab1_03) THEN   #沒選join type
               LET l_from = l_from,",",g_table1_d[l_i].tab1_01
               IF NOT cl_null(g_table1_d[l_i].tab1_02) THEN
                  LET l_from = l_from," ",g_table1_d[l_i].tab1_02
               END IF
            ELSE
               CASE g_table1_d[l_i].tab1_03
                  WHEN 1
                     LET l_from = l_from," INNER JOIN ",g_table1_d[l_i].tab1_01
                  WHEN 2
                     LET l_from = l_from," LEFT OUTER JOIN ",g_table1_d[l_i].tab1_01
                     WHEN 3
                     LET l_from = l_from," RIGHT OUTER JOIN ",g_table1_d[l_i].tab1_01
               END CASE   
               IF NOT cl_null(g_table1_d[l_i].tab1_02) THEN
                  LET l_from = l_from," ",g_table1_d[l_i].tab1_02
               END IF
               LET l_from = l_from," ON "
               #組合join的關係
               LET l_str1 = g_table1_d[l_i].tab1_04
               LET l_str2 = g_table1_d[l_i].tab1_05

               LET l_num = 1 
               LET l_on = NULL 
               WHILE l_num > 0 
                  LET l_num = l_str1.getIndexOf(",",1)
                  IF l_num > 0 THEN
                     LET l_sub = l_str1.subString(1,l_num-1)
                     LET l_str1 = l_str1.subString(l_num+1,l_str1.getLength())
                     IF NOT cl_null(l_on) THEN
                        LET l_on = l_on," AND "
                     END IF 
                     LET l_on = l_on,l_sub
                     LET l_on = l_on," = "
                  END IF
                  LET l_num = l_str2.getIndexOf(",",1)
                  IF l_num > 0 THEN
                     LET l_sub = l_str2.subString(1,l_num-1)
                     LET l_str2 = l_str2.subString(l_num+1,l_str2.getLength())
                     LET l_on = l_on,l_sub
                  END IF
               END WHILE
               #最後一組 
               IF NOT cl_null(l_str1) THEN
                  IF NOT cl_null(l_on) THEN
                     LET l_on = l_on," AND "
                  END IF 
                  LET l_on = l_on,l_str1
                  LET l_on = l_on," = "
               END IF
               IF NOT cl_null(l_str2) THEN
                  LET l_on = l_on,l_str2
               END IF 
               IF l_i <> g_table1_d.getLength() THEN 
                  LET l_from = l_from,l_on,"\n"
               ELSE 
                  LET l_from = l_from,l_on
               END IF 
            END IF 
         END IF 
      END IF 
   END FOR 
   IF p_type = '2' THEN
      LET l_from = l_from, G_TABLE_END#"</table>"
   END IF 
   #select
   IF p_type = '2' THEN
      LET l_start = 0
      LET l_end = 0
      FOR l_i = 1 TO g_table2_d.getLength()
         LET l_str1 = g_table2_d[l_i].tab2_02
         LET l_num = l_str1.getIndexOf("COUNT",1)
         IF l_num= 0 THEN
            LET l_num = l_str1.getIndexOf("count",1)
         END IF 
         IF l_num > 0 THEN
            IF l_start = 0 THEN
               LET l_start = l_i
            END IF
            LET l_end = l_i
         END IF 
      END FOR 
   END IF 
   LET l_select = "SELECT "
   FOR l_i = 1 TO g_table2_d.getLength()
      IF NOT cl_null(g_table2_d[l_i].tab2_02) THEN
         IF l_i= 1 THEN
            IF g_checkbox3 = 'Y' THEN
               LET l_select = l_select,"DISTINCT "
            END IF 
            IF p_type = '2' THEN
               IF l_start = 1 THEN
                  LET l_select = l_select,G_COUNT_START#"<count>"
               ELSE
                  LET l_select = l_select,G_FIELD_START#"<field>"
               END IF 
            END IF 
         ELSE 
            LET l_select = l_select,","
         END IF 
         IF p_type = '2' THEN
            IF l_i<> 1 THEN
               IF l_start = l_i THEN
                  LET l_select = l_select,G_COUNT_START#"<count>"
               END IF 
               IF l_end+1 = l_i THEN
                  LET l_select = l_select,G_FIELD_START#"<field>"
               END IF 
            END IF 
         END IF 
         IF NOT cl_null(g_table2_d[l_i].tab2_01) THEN
            LET l_select = l_select,g_table2_d[l_i].tab2_01,"."
         END IF 
         LET l_select = l_select,g_table2_d[l_i].tab2_02
         IF NOT cl_null(g_table2_d[l_i].tab2_03) THEN
            LET l_select = l_select," ",g_table2_d[l_i].tab2_03
         END IF 
         IF p_type = '2' THEN
            IF l_end = l_i THEN
               LET l_select = l_select,G_COUNT_END#"</count>"
            END IF 
            IF l_start-1 = l_i THEN
               LET l_select = l_select,G_FIELD_END#"</field>"
            END IF
            IF l_i = g_table2_d.getLength() THEN
               IF l_end <> l_i THEN
                  LET l_select = l_select,G_FIELD_END#"</field>"
               END IF  
            END IF 
         END IF 
      END IF 
   END FOR 
   #where
   LET l_where = "WHERE 1=1"
   IF p_type = '2' THEN
      LET l_where = "WHERE ",G_WHERE_START,"1=1"#"<wc>"
   ELSE 
      LET l_where = "WHERE 1=1 "
   END IF 
   FOR l_i = 1 TO g_table3_d.getLength()
      IF NOT cl_null(g_table3_d[l_i].tab3_02) THEN
         IF l_i =1 THEN
            LET l_where = l_where, "\nAND "
         ELSE 
            #邏輯
            IF NOT cl_null(g_table3_d[l_i].tab3_07) THEN
               CASE g_table3_d[l_i].tab3_07
                  WHEN 1
                     LET l_where = l_where,"\nAND "
                  WHEN 2
                     LET l_where = l_where,"\nOR "
               END CASE 
            END IF 
         END IF 
         IF NOT cl_null(g_table3_d[l_i].tab3_09) THEN
            LET l_where = l_where,g_table3_d[l_i].tab3_09
         END IF 
         IF NOT cl_null(g_table3_d[l_i].tab3_01) THEN
            LET l_where = l_where,g_table3_d[l_i].tab3_01,"."
         END IF 
         LET l_where = l_where,g_table3_d[l_i].tab3_02
         #比較
         CASE g_table3_d[l_i].tab3_03
            WHEN 1
               LET l_where = l_where," = "
            WHEN 2
               LET l_where = l_where," > "
            WHEN 3
               LET l_where = l_where," < "
            WHEN 4
               LET l_where = l_where," >= "
            WHEN 5
               LET l_where = l_where," <= "
            WHEN 6
               LET l_where = l_where," <> "
            WHEN 7
               LET l_where = l_where," LIKE "
            WHEN 8
               LET l_where = l_where," NOT LIKE "
            WHEN 'A'
               LET l_where = l_where," BETWEEN "
            WHEN 'B'
               LET l_where = l_where," NOT BETWEEN "
         END CASE 

         IF NOT cl_null(g_table3_d[l_i].tab3_04) THEN
            LET l_str = g_table3_d[l_i].tab3_04
            IF l_str.getIndexOf(":",1) > 0 THEN
               LET l_where = l_where,g_table3_d[l_i].tab3_04
            ELSE 
               IF g_table3_d[l_i].tab3_03 = "A" OR g_table3_d[l_i].tab3_03 = "B" THEN
                  IF l_str.getIndexOf("AND",1) > 0 OR l_str.getIndexOf("and",1) > 0 THEN
                     LET l_where = l_where,g_table3_d[l_i].tab3_04
                  ELSE
                     LET l_where = l_where,"'",g_table3_d[l_i].tab3_04,"'"
                  END IF 
               ELSE 
                  LET l_where = l_where,"'",g_table3_d[l_i].tab3_04,"'"
               END IF 
            END IF 
         ELSE
            IF NOT cl_null(g_table3_d[l_i].tab3_05) THEN
               LET l_where = l_where,g_table3_d[l_i].tab3_05,"."
            END IF 
            LET l_where = l_where,g_table3_d[l_i].tab3_06
         END IF
         IF NOT cl_null(g_table3_d[l_i].tab3_10) THEN
            LET l_where = l_where,g_table3_d[l_i].tab3_10
         END IF
      ELSE
         IF l_ac > 1 THEN
            IF g_table3_d[l_i-1].tab3_03 = 'A' OR g_table3_d[l_i-1].tab3_03 = 'B' THEN
               IF NOT cl_null(g_table3_d[l_i].tab3_07) THEN
                 LET l_where = l_where," AND "
               END IF 
               IF NOT cl_null(g_table3_d[l_i].tab3_04) THEN
                  LET l_str = g_table3_d[l_i].tab3_04
                  IF l_str.getIndexOf(":",1) > 0 THEN
                     LET l_where = l_where,g_table3_d[l_i].tab3_04
                  ELSE 
                     LET l_where = l_where,"'",g_table3_d[l_i].tab3_04,"'"
                  END IF 
               ELSE
                  IF NOT cl_null(g_table3_d[l_i].tab3_05) THEN
                     LET l_where = l_where,g_table3_d[l_i].tab3_05,"."
                  END IF 
                  LET l_where = l_where,g_table3_d[l_i].tab3_06
               END IF
               IF NOT cl_null(g_table3_d[l_i].tab3_10) THEN
                  LET l_where = l_where,g_table3_d[l_i].tab3_10
               END IF
            END IF 
         END IF 
      END IF 
   END FOR 
   IF p_type = '2' THEN
      LET l_where = l_where,G_WHERE_END#"</wc>"
   END IF  
   #where2  
   FOR l_i = 1 TO g_table4_d.getLength() 
      IF NOT cl_null(g_table4_d[l_i].tab4_02) THEN
         IF l_i = 1 THEN
            IF cl_null(g_table4_d[l_i].tab4_07) THEN
               LET l_where2 = "AND "
            ELSE
               CASE g_table4_d[l_i].tab4_07
                  WHEN 1
                     LET l_where2 = l_where2,"AND "
                  WHEN 2
                     LET l_where2 = l_where2,"OR "
               END CASE 
            END IF 
         ELSE 
            #邏輯
            IF NOT cl_null(g_table4_d[l_i].tab4_07) THEN
               CASE g_table4_d[l_i].tab4_07
                  WHEN 1
                     LET l_where2 = l_where2,"\nAND "
                  WHEN 2
                     LET l_where2 = l_where2,"\nOR "
               END CASE 
            END IF 
         END IF
         IF NOT cl_null(g_table4_d[l_i].tab4_09) THEN
            LET l_where2 = l_where2,g_table4_d[l_i].tab4_09
         END IF
         IF NOT cl_null(g_table4_d[l_i].tab4_01) THEN
            LET l_where2 = l_where2,g_table4_d[l_i].tab4_01,"."
         END IF 
         LET l_where2 = l_where2,g_table4_d[l_i].tab4_02
         #比較
         CASE g_table4_d[l_i].tab4_03
            WHEN 1
               LET l_where2 = l_where2," = "
            WHEN 2
               LET l_where2 = l_where2," > "
            WHEN 3
               LET l_where2 = l_where2," < "
            WHEN 4
               LET l_where2 = l_where2," >= "
            WHEN 5
               LET l_where2 = l_where2," <= "
            WHEN 6
               LET l_where2 = l_where2," <> "
            WHEN 7
               LET l_where2 = l_where2," LIKE "
            WHEN 8
               LET l_where2 = l_where2," NOT LIKE "
            WHEN 'A'
               LET l_where2 = l_where2," BETWEEN "
            WHEN 'B'
               LET l_where2 = l_where2," NOT BETWEEN "
         END CASE 

         IF NOT cl_null(g_table4_d[l_i].tab4_04) THEN
            LET l_str1 = g_table4_d[l_i].tab4_04
            IF l_str1.getIndexOf(":",1) > 0 THEN
               LET l_where2 = l_where2,g_table4_d[l_i].tab4_04
            ELSE 
               
               IF g_table4_d[l_i].tab4_03 = "A" OR g_table4_d[l_i].tab4_03 = "B" THEN
                  IF l_str.getIndexOf("AND",1) > 0 OR l_str.getIndexOf("and",1) > 0 THEN
                     LET l_where2 = l_where2,g_table4_d[l_i].tab4_04
                  ELSE
                     LET l_where2 = l_where2,"'",g_table4_d[l_i].tab4_04,"'"
                  END IF 
               ELSE 
                  LET l_where2 = l_where2,"'",g_table4_d[l_i].tab4_04,"'"
               END IF 
            END IF 
         ELSE
            IF NOT cl_null(g_table4_d[l_i].tab4_05) THEN
               LET l_where2 = l_where2,g_table4_d[l_i].tab4_05,"."
            END IF 
            LET l_where2 = l_where2,g_table4_d[l_i].tab4_06
         END IF
         IF NOT cl_null(g_table4_d[l_i].tab4_10) THEN
            LET l_where2 = l_where2,g_table4_d[l_i].tab4_10
         END IF
      ELSE
         IF l_ac > 1 THEN
            IF g_table4_d[l_i-1].tab4_03 = 'A' OR g_table4_d[l_i-1].tab4_03 = 'B' THEN
               IF NOT cl_null(g_table4_d[l_i].tab4_07) THEN
                 LET l_where2 = l_where2," AND "
               END IF 
               IF NOT cl_null(g_table4_d[l_i].tab4_04) THEN
                  LET l_str = g_table4_d[l_i].tab4_04
                  IF l_str.getIndexOf(":",1) > 0 THEN
                     LET l_where2 = l_where2,g_table4_d[l_i].tab4_04
                  ELSE 
                     LET l_where2 = l_where2,"'",g_table4_d[l_i].tab4_04,"'"
                  END IF 
               ELSE
                  IF NOT cl_null(g_table4_d[l_i].tab4_05) THEN
                     LET l_where2 = l_where2,g_table4_d[l_i].tab4_05,"."
                  END IF 
                  LET l_where2 = l_where2,g_table4_d[l_i].tab4_06
               END IF
               IF NOT cl_null(g_table4_d[l_i].tab4_10) THEN
                  LET l_where2 = l_where2,g_table4_d[l_i].tab4_10
               END IF
            END IF 
         END IF 
      END IF 
   END FOR 
   IF p_type = '2' THEN 
      IF g_table4_d.getLength() > 0 THEN 
         LET l_where2 = G_INWC_START#"<inwc>"
                       ,l_where2,G_INWC_END#"</inwc>"
      END IF 
   END IF 
   #group
   FOR l_i = 1 TO g_table5_d.getLength()
      IF NOT cl_null(g_table5_d[l_i].tab5_02) THEN
         IF l_i = 1 THEN
            LET l_group = 'GROUP BY '
         ELSE
            LET l_group = l_group,","
         END IF 
         IF NOT cl_null(g_table5_d[l_i].tab5_01) THEN
            LET l_group = l_group,g_table5_d[l_i].tab5_01,"."
         END IF 
         LET l_group = l_group,g_table5_d[l_i].tab5_02
      END IF 
   END FOR 
   #order
   FOR l_i = 1 TO g_table6_d.getLength()
      IF NOT cl_null(g_table6_d[l_i].tab6_02) THEN
         IF l_i = 1 THEN
            LET l_order = 'ORDER BY '
         ELSE
            LET l_order = l_order,","
         END IF 
         IF NOT cl_null(g_table6_d[l_i].tab6_01) THEN
            LET l_order = l_order,g_table6_d[l_i].tab6_01,"."
         END IF
         LET l_order = l_order,g_table6_d[l_i].tab6_02
         CASE g_table6_d[l_i].tab6_03
            WHEN 1
               LET l_order = l_order," ASC"
            WHEN 2
               LET l_order = l_order," DESC"
         END CASE 
      END IF 
   END FOR 
   
   LET l_return = l_select,'\n',l_from,'\n',l_where
   IF NOT cl_null(l_where2) THEN
      LET l_return = l_return,'\n',l_where2
   END IF 
   IF NOT cl_null(l_group) THEN
      LET l_return = l_return,'\n',l_group
   END IF 
   IF NOT cl_null(l_order) THEN
      LET l_return = l_return,'\n',l_order
   END IF
   RETURN l_return
END FUNCTION 

#產生SQL轉成回傳SQL(不用)
FUNCTION adzp190_gen_sql2(p_sql)
DEFINE p_sql       STRING 
DEFINE l_return    STRING 
DEFINE l_sql       STRING
DEFINE l_str       STRING
DEFINE l_num       LIKE type_t.num5
DEFINE l_i         LIKE type_t.num5
DEFINE l_where2    STRING 
DEFINE l_str1      STRING

   LET l_sql = p_sql
   #r.v有count 控制在 from之前
   LET l_num = l_sql.getIndexOf("COUNT(*)",1)
   IF l_num = 0 THEN 
   LET l_num = l_sql.getIndexOf("count(*)",1)
   END IF 
   IF l_num > 0 THEN 
      LET l_str = l_sql.subString(1,l_num-1)
      LET l_str = l_str,"<count>COUNT(*)</count>"
      LET l_sql = l_sql.subString(l_num+8,l_sql.getLength())
      LET l_num = l_sql.getIndexOf(",",1)
      IF l_num > 0 THEN
         LET l_str = l_str,l_sql.subString(1,l_num)
         LET l_sql = l_sql.subString(l_num+1,l_sql.getLength())
         LET l_str = l_str,G_FIELD_START#"<field>"
         LET l_num = l_sql.getIndexOf("\nFROM",1)
         IF l_num > 0 THEN
            LET l_str = l_str,l_sql.subString(1,l_num-1)
            LET l_sql = l_sql.subString(l_num,l_sql.getLength())
            LET l_str = l_str,G_FIELD_END#"</field>"
         END IF 
      END IF 
   ELSE 
      #r.q
      LET l_num = l_sql.getIndexOf("DITINCT ",1)
      IF l_num = 0 THEN 
         LET l_num = l_sql.getIndexOf("SELECT ",1)
         LET l_str = l_sql.subString(1,l_num+6)
         LET l_sql = l_sql.subString(l_num+6,l_sql.getLength())
         LET l_str = l_str,G_FIELD_START#"<field>"
      ELSE 
         LET l_str = l_str,l_sql.subString(1,l_num+7)
         LET l_sql = l_sql.subString(l_num+7,l_sql.getLength())
         LET l_str = l_str,G_FIELD_START#"<field>"
      END IF 

      LET l_num = l_sql.getIndexOf("\nFROM",1)
      IF l_num > 0 THEN
         LET l_str = l_str,l_sql.subString(1,l_num-1)
         LET l_sql = l_sql.subString(l_num,l_sql.getLength())
         LET l_str = l_str,G_FIELD_END#"</field>"
      END IF 
   END IF 

   LET l_num = l_sql.getIndexOf("FROM",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num+4)
      LET l_sql = l_sql.subString(l_num+4,l_sql.getLength())
      LET l_str = l_str,G_TABLE_START#"<table>"
   END IF 

   LET l_num = l_sql.getIndexOf("\nWHERE",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num-1)
      LET l_sql = l_sql.subString(l_num,l_sql.getLength())
      LET l_str = l_str,G_TABLE_END#"</table>"
   END IF

   LET l_num = l_sql.getIndexOf("WHERE",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num+5)
      LET l_sql = l_sql.subString(l_num+5,l_sql.getLength())
      LET l_str = l_str,G_WHERE_START#"<wc>"
   END IF

   LET l_num = l_sql.getIndexOf("\nGROUP",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num-1)
      LET l_sql = l_sql.subString(l_num,l_sql.getLength())
      LET l_str = l_str,G_WHERE_END#"</wc>"
   ELSE
      LET l_num = l_sql.getIndexOf("\nORDER",1)
      IF l_num > 0 THEN
         LET l_str = l_str,l_sql.subString(1,l_num-1)
         LET l_sql = l_sql.subString(l_num,l_sql.getLength())
         LET l_str = l_str,G_WHERE_END#"</wc>"
      ELSE
         LET l_str = l_str,l_sql,G_WHERE_END#"</wc>"
         LET l_sql = NULL 
      END IF 
   END IF 
   IF g_type = "r.q" AND g_table4_d.getLength() > 0 THEN 
   #where2  
   FOR l_i = 1 TO g_table4_d.getLength() 
      IF NOT cl_null(g_table4_d[l_i].tab4_02) THEN
         IF l_i = 1 THEN
            IF cl_null(g_table4_d[l_i].tab4_07) THEN
               LET l_where2 = "AND "
            ELSE
               CASE g_table4_d[l_i].tab4_07
                  WHEN 1
                     LET l_where2 = l_where2,"\n","AND "
                  WHEN 2
                     LET l_where2 = l_where2,"\n","OR "
               END CASE 
            END IF 
         ELSE 
            #邏輯
            IF NOT cl_null(g_table4_d[l_i].tab4_07) THEN
               CASE g_table4_d[l_i].tab4_07
                  WHEN 1
                     LET l_where2 = l_where2,"\n","AND "
                  WHEN 2
                     LET l_where2 = l_where2,"\n","OR "
               END CASE 
            END IF 
         END IF
         IF NOT cl_null(g_table4_d[l_i].tab4_09) THEN
            LET l_where2 = l_where2,g_table4_d[l_i].tab4_09
         END IF
         IF NOT cl_null(g_table4_d[l_i].tab4_01) THEN
            LET l_where2 = l_where2,g_table4_d[l_i].tab4_01,"."
         END IF 
         LET l_where2 = l_where2,g_table4_d[l_i].tab4_02
         #比較
         CASE g_table4_d[l_i].tab4_03
            WHEN 1
               LET l_where2 = l_where2," = "
            WHEN 2
               LET l_where2 = l_where2," > "
            WHEN 3
               LET l_where2 = l_where2," < "
            WHEN 4
               LET l_where2 = l_where2," >= "
            WHEN 5
               LET l_where2 = l_where2," <= "
            WHEN 6
               LET l_where2 = l_where2," <> "
            WHEN 7
               LET l_where2 = l_where2," LIKE "
            WHEN 8
               LET l_where2 = l_where2," NOT LIKE "
            WHEN 'A'
               LET l_where2 = l_where2," BETWEEN "
            WHEN 'B'
               LET l_where2 = l_where2," NOT BETWEEN "
         END CASE 

         IF NOT cl_null(g_table4_d[l_i].tab4_04) THEN
            LET l_str1 = g_table4_d[l_i].tab4_04
            IF l_str1.getIndexOf(":",1) > 0 THEN
               LET l_where2 = l_where2,g_table4_d[l_i].tab4_04
            ELSE 
               
               IF g_table4_d[l_i].tab4_03 = "A" OR g_table4_d[l_i].tab4_03 = "B" THEN
                  IF l_str.getIndexOf("AND",1) > 0 OR l_str.getIndexOf("and",1) > 0 THEN
                     LET l_where2 = l_where2,g_table4_d[l_i].tab4_04
                  ELSE
                     LET l_where2 = l_where2,"'",g_table4_d[l_i].tab4_04,"'"
                  END IF 
               ELSE 
                  LET l_where2 = l_where2,"'",g_table4_d[l_i].tab4_04,"'"
               END IF 
            END IF 
         ELSE
            IF NOT cl_null(g_table4_d[l_i].tab4_05) THEN
               LET l_where2 = l_where2,g_table4_d[l_i].tab4_05,"."
            END IF 
            LET l_where2 = l_where2,g_table4_d[l_i].tab4_06
         END IF
         IF NOT cl_null(g_table4_d[l_i].tab4_10) THEN
            LET l_where2 = l_where2,g_table4_d[l_i].tab4_10
         END IF
      ELSE
         IF l_ac > 1 THEN
            IF g_table4_d[l_i-1].tab4_03 = 'A' OR g_table4_d[l_i-1].tab4_03 = 'B' THEN
               IF NOT cl_null(g_table4_d[l_i].tab4_07) THEN
                 LET l_where2 = l_where2," AND "
               END IF 
               IF NOT cl_null(g_table4_d[l_i].tab4_04) THEN
                  LET l_str = g_table4_d[l_i].tab4_04
                  IF l_str.getIndexOf(":",1) > 0 THEN
                     LET l_where2 = l_where2,g_table4_d[l_i].tab4_04
                  ELSE 
                     LET l_where2 = l_where2,"'",g_table4_d[l_i].tab4_04,"'"
                  END IF 
               ELSE
                  IF NOT cl_null(g_table4_d[l_i].tab4_05) THEN
                     LET l_where2 = l_where2,g_table4_d[l_i].tab4_05,"."
                  END IF 
                  LET l_where2 = l_where2,g_table4_d[l_i].tab4_06
               END IF
               IF NOT cl_null(g_table4_d[l_i].tab4_10) THEN
                  LET l_where2 = l_where2,g_table4_d[l_i].tab4_10
               END IF
            END IF 
         END IF 
      END IF 
   END FOR 
   LET l_str = l_str,G_INWC_START#"<inwc>"
                    ,l_where2,G_INWC_END#"</inwc>"
   END IF 
   LET l_str = l_str,l_sql
   
   LET l_return = l_str
   RETURN l_return
END FUNCTION 
#回傳SQL轉成產生SQL(不用)
FUNCTION adzp190_gen_sql3(p_sql)
DEFINE p_sql       STRING
DEFINE l_return    STRING 
DEFINE l_str       STRING
DEFINE l_sql       STRING 
DEFINE l_num       LIKE type_t.num5
DEFINE l_num2      LIKE type_t.num5

   LET l_sql = p_sql
   LET l_num = l_sql.getIndexOf("<inwc>",1)
   LET l_num2 = l_sql.getIndexOf("</inwc>",1)
   IF l_num >0 AND l_num2 > 0 THEN 
      LET l_str = l_sql.subString(1,l_num-1)
      LET l_str = l_str,l_sql.subString(l_num2+7,l_sql.getLength())
      LET l_sql = l_str
      LET l_str = ''
   END IF 

   LET l_num = l_sql.getIndexOf("<count>",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num-1)
      LET l_sql = l_sql.subString(l_num+7,l_sql.getLength())
   END IF

   LET l_num = l_sql.getIndexOf("</count>",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num-1)
      LET l_sql = l_sql.subString(l_num+8,l_sql.getLength())
   END IF

   LET l_num = l_sql.getIndexOf("<field>",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num-1)
      LET l_sql = l_sql.subString(l_num+7,l_sql.getLength())
   END IF

   LET l_num = l_sql.getIndexOf("</field>",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num-1)
      LET l_sql = l_sql.subString(l_num+8,l_sql.getLength())
   END IF

   LET l_num = l_sql.getIndexOf("<table>",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num-1)
      LET l_sql = l_sql.subString(l_num+7,l_sql.getLength())
   END IF

   LET l_num = l_sql.getIndexOf("</table>",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num-1)
      LET l_sql = l_sql.subString(l_num+8,l_sql.getLength())
   END IF

   LET l_num = l_sql.getIndexOf("<wc>",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num-1)
      LET l_sql = l_sql.subString(l_num+4,l_sql.getLength())
   END IF

   LET l_num = l_sql.getIndexOf("</wc>",1)
   IF l_num > 0 THEN
      LET l_str = l_str,l_sql.subString(1,l_num-1)
      LET l_sql = l_sql.subString(l_num+5,l_sql.getLength())
   END IF
   LET l_str = l_str,l_sql

   
   LET l_return = l_str
   RETURN l_return
END FUNCTION 
#加入rownum
FUNCTION sadzp190_sql_rowcount(p_sql,p_rowcount)
DEFINE p_sql          STRING
DEFINE p_rowcount     LIKE type_t.num5
DEFINE l_str          STRING
DEFINE l_return       STRING
DEFINE l_num          LIKE type_t.num5
DEFINE l_rowcount     STRING 
   LET l_rowcount = p_rowcount
   #LET l_num = p_sql.getIndexOf("GROUP",1)
   #IF l_num > 0 THEN
   #   LET l_str = l_str,p_sql.subString(1,l_num-1)
   #   LET l_str = l_str,"AND ROWNUM <=",l_rowcount,"\n"
   #   LET l_str = l_str,p_sql.subString(l_num,p_sql.getLength())
   #ELSE 
   #   LET l_num = p_sql.getIndexOf("ORDER",1)
   #   IF l_num > 0 THEN
   #      LET l_str = l_str,p_sql.subString(1,l_num-1)
   #      LET l_str = l_str,"AND ROWNUM <=",l_rowcount,"\n"
   #      LET l_str = l_str,p_sql.subString(l_num,p_sql.getLength())
   #   ELSE 
   #      LET l_str = p_sql," AND ROWNUM <=",l_rowcount
   #   END IF 
   #END IF
   LET l_str = "SELECT * FROM (",p_sql,") WHERE ROWNUM <=",l_rowcount
   LET l_return = l_str
   
   RETURN l_return
END FUNCTION 

#+ 進行SQL驗證
PUBLIC FUNCTION sadzp190_sql_verify(p_sql)
   DEFINE p_sql      STRING
   DEFINE l_sql      base.StringBuffer
   DEFINE l_index        LIKE type_t.num5
   DEFINE l_err          STRING
   DEFINE r_value        BOOLEAN


   
   #SQL指令必須是由SELECT 語法開始
   LET p_sql = p_sql.trim()
   IF NOT p_sql MATCHES "SELECT *" AND NOT p_sql MATCHES "select *"  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00022"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  " SQL must be 「SELECT xxxxxx」 ! "
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #檢查相關tag是否已存在SQL中,避免下面一連串的判斷錯誤
   LET l_err = sadzp190_tag_exist(p_sql)
   IF l_err IS NOT NULL THEN
      #CALL FGL_WINMESSAGE("ERROR", l_err, "stop")
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00022"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_err 
      CALL cl_err()
      #CALL cl_err('',SQLCA.sqlcode,0)
      RETURN FALSE
   END IF
   
   TRY
      LET l_sql = base.StringBuffer.create() 
      CALL l_sql.append(p_sql)

      LET  r_value = FALSE

      #因為可提供使用者不輸入where條件的開窗SQL,如:
      #SELECT DISTINCT <field>dzeb001</field>
      #  FROM <table>dzeb_t</table>
      #  WHERE <wc></wc>
      #而目前又要求一定要留WHERE <wc></wc>這行字和標籤,以方便後面產生開窗4GL時的判斷
      #所以這裡的驗證SQL就必須要將WHERE <wc></wc>這行字變成空白
      #以免將SQL驗證時,發生 WHERE 後面沒有加條件式的錯誤情況發生
      LET l_index = l_sql.getIndexOf(G_WHERE_END.trim(), 1)
      IF l_index > 0 THEN
         #判斷一下開窗SQL是否有WHERE <wc></wc>裡沒有where條件的情況
         #如果有條件會像:WHERE <wc>1=1</wc>
         #所以當("</wc>"的index位置) - ("<wc>"的index位置) = ("<wc>"的字串長度):表示裡面應該沒有where條件式的輸入
         IF (l_index - l_sql.getIndexOf(G_WHERE_START.trim(), 1)) = G_WHERE_START.getLength() THEN
            #因為ls_where是個變數,所以在q_xxx的4gl程式中,加入字串為:[", ls_where CLIPPED, "]
            #這樣產生回開窗程式時字串相加才不會錯,ls_where也才會有作用
            CALL l_sql.replace("WHERE", "", 1)
         END IF 
      END IF
   
      #為了要進行SQL驗證,必須將相關tag的字元符先行剔除,才有辦法執行這句SQL
      CALL l_sql.replace(G_COUNT_START, " ", 1)
      CALL l_sql.replace(G_COUNT_END, " ", 1) 
      CALL l_sql.replace(G_FIELD_START, " ", 1)
      CALL l_sql.replace(G_FIELD_END, " ", 1) 
      CALL l_sql.replace(G_TABLE_START, " ", 1)
      CALL l_sql.replace(G_TABLE_END, " ", 1) 
      CALL l_sql.replace(G_WHERE_START, " ", 1)
      CALL l_sql.replace(G_WHERE_END, " ", 1)
      CALL l_sql.replace(G_INWC_START, " ", 1)
      CALL l_sql.replace(G_INWC_END, " ", 1)
      
      #henry:替換掉預設的外部變數名稱，避免影響SQL指令的執行
      CALL l_sql.replace("arg1", "1", 0)
      CALL l_sql.replace("arg2", "1", 0)
      CALL l_sql.replace("arg3", "1", 0)
      CALL l_sql.replace("arg4", "1", 0)
      CALL l_sql.replace("arg5", "1", 0)
      CALL l_sql.replace("arg6", "1", 0)
      CALL l_sql.replace("arg7", "1", 0)
      CALL l_sql.replace("arg8", "1", 0)
      CALL l_sql.replace("arg9", "1", 0)

      #130201 By benson --- S
      #SQL允許使用的公用變數代碼
      CALL l_sql.replace(":DLANG", "'1'", 0)
      CALL l_sql.replace(":LANG", "'1'", 0) 
      CALL l_sql.replace(":LEGAL", "'1'", 0)
      CALL l_sql.replace(":SITE", "'1'", 0)
      CALL l_sql.replace(":USER", "'1'", 0)
      CALL l_sql.replace(":DEPT", "'1'", 0)
      CALL l_sql.replace(":ENT", "'1'", 0)
      #CALL l_sql.replace(":TODAY", " TO_DATE('2013/11/20','yyyy/mm/dd') ", 0)
      CALL l_sql.replace(":TODAY", "'2013/11/20'", 0)
      #130201 By benson --- E
      
      #另外怕使用者輸入";"會影響SQL執行,因此也先行剔除
      CALL l_sql.replace(";", "", 1)
      
      #因為只是為了要驗證SQL是否可以執行正常而已,所以只SELECT第一筆資料
      #這行以後應該要為了支援多種DB TOOL,要進行不同DB TOOL的語法改寫(CASE...WHEN)
      #LET p_sql = "SELECT * FROM (", l_sql.toString(), ") WHERE ROWNUM = 1"
      #LET p_sql = "SELECT COUNT(1) FROM (", l_sql.toString(), ") "

      LET p_sql = l_sql.toString()

      #DISPLAY "sql_verify:", p_sql

      PREPARE chk_sql_pre FROM  p_sql
      DECLARE chk_sql_cs CURSOR FOR chk_sql_pre

      OPEN chk_sql_cs
      #實際進行驗證
      #EXECUTE IMMEDIATE p_sql

      #MESSAGE 'Verify OK!'                    #130201 By benson 
      
      LET r_value = TRUE
   CATCH
      #todo : 這段程式之後要改.
      DISPLAY "Hiko:SQLCA.SQLCODE=",SQLCA.SQLCODE
      #LET g_sqlcode = SQLCA.SQLCODE
      IF SQLCA.SQLCODE THEN
         #CALL FGL_WINMESSAGE("SQL ERROR", SQLCA.SQLCODE || ASCII 10 || "SQL:" || ASCII 10 || l_sql.toString(), "stop")
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00024"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = p_sql
         CALL cl_err()
      ELSE
         #CALL FGL_WINMESSAGE("OTHER ERROR", "Please notify administrator." || ";SQL:" || l_sql.toString(), "stop")
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00023"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  "Please notify administrator." 
         CALL cl_err()
      END IF
      DISPLAY "sql for chk = ",p_sql
      LET r_value = FALSE
   END TRY

   FREE chk_sql_cs
   FREE chk_sql_pre 

   RETURN r_value
END FUNCTION

#+ 判斷相關tag,是否存在SQL語句中
PRIVATE FUNCTION sadzp190_tag_exist(p_sql)    
   DEFINE p_sql               STRING 
   DEFINE lsb_sql         base.StringBuffer
   DEFINE l_index             LIKE type_t.num5
   DEFINE ls_err              STRING
   
   LET ls_err = ""
   
   #取得開窗設計器原始SQL
   LET lsb_sql = base.StringBuffer.create() 
   CALL lsb_sql.append(p_sql CLIPPED) 
   IF g_type <> 'r.v' THEN 
      LET l_index = 0
      LET l_index = lsb_sql.getIndexOf(G_FIELD_START, 1)
      IF l_index = 0 THEN LET ls_err = ls_err, G_FIELD_START, " is not exist!", ASCII 10 END IF

      LET l_index = 0
      LET l_index = lsb_sql.getIndexOf(G_FIELD_END, 1)
      IF l_index = 0 THEN LET ls_err = ls_err, G_FIELD_END, " is not exist!", ASCII 10 END IF
   END IF 
   
   LET l_index = 0 
   LET l_index = lsb_sql.getIndexOf(G_TABLE_START, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_TABLE_START, " is not exist!", ASCII 10 END IF

   LET l_index = 0 
   LET l_index = lsb_sql.getIndexOf(G_TABLE_END, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_TABLE_END, " is not exist!", ASCII 10 END IF

   LET l_index = 0 
   LET l_index = lsb_sql.getIndexOf(G_WHERE_START, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_WHERE_START, " is not exist!", ASCII 10 END IF

   LET l_index = 0
   LET l_index = lsb_sql.getIndexOf(G_WHERE_END, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_WHERE_END, " is not exist!", ASCII 10 END IF

   IF ls_err IS NOT NULL THEN
      LET ls_err = "Necessary tag: ", ASCII 10, ls_err
   END IF
   
   RETURN ls_err
END FUNCTION



