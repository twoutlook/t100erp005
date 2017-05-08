# Modify         : 2014/08/25 by Hiko : 增加dzep023(欄位大小寫)
#                : 2014/09/01 by Hiko : 直接維護欄位多語言(update_item).
#                : 2014/10/06 by Hiko : 1.公用欄位的多語言有可能有錯誤,所以乾脆就不檔了.
#                                       2.gzcc005(客製)要顯現
#                : 2014/10/08 by Hiko : 客製環境不可以修改(移除)狀態碼設定
#                : 2014/12/25 by Hiko : gzcc4004至少要有Y/N
#                : 2015/01/30 by Hiko : 直接維護欄位說明(update_item).
#                : 2015/04/07 by Hiko : 調整畫面
#                : 2015/06/24 by Hiko : 提醒有用到SCC的程式清單
#                : 2015/08/03 by Hiko : 修正edt_Search按下Enter就關閉程式的問題.
#                : 2015/10/01 by Hiko : 1.dzep011(SCC)只需要查看SCC代號/名稱即可.
#                                       2.dzep019(r.v)改成單選開窗.
#                                       3.將一堆ARR_CURR()改在BEFORE ROW設定即可.
#                                       4.dzep022(串查型態)='1.一般'的時候, 可開窗查詢作業代號.
#                                       5.除了狀態碼設定外, 其餘設定資料的xxxstus都拿來當作客製識別(s/c), 可避免客製Patch被覆蓋.
#                                       6.改成單筆COMMIT(ROW CHANGE/AFTER INSERT), 移除xxxcreate, 將xxxdelete放在xxxmodify內.
#                                       7.補上欄位檢查存在的段落
#                                       8.因為判斷不出來是標準欄位客戶修改, 或是客戶自己加上標準欄位的設定, 所以不控卡標準欄位不可刪除的情境.
#                : 2015/11/02 by Hiko : 調整公用欄位的判斷條件
#                : 2015/11/09 by Hiko : 有異動狀態碼設定, 就要將程式重產flag(dzay005)更新為Y.
#                : 2015/12/04 by Hiko : 1.查詢資料條件不要加上dzea003(模組),改用like dzea001(Table代號)即可.
#                                       2.程式一開啟預設查出第一個模組,加快開啟速度.
#                : 20160426   by Elena: 刪除lbl_dzep021，format不可修改
#                : 20160429 160429-00009 by Hiko : 1.查看欄位規格的修改資訊.
#                                                  2.查看目前有用到的SCC/狀態碼有哪些程式有用到.

IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

PRIVATE TYPE T_DZEA_T RECORD 
                      recordtype LIKE type_t.chr1,
                      dzeaseq    VARCHAR(4),
                      dzea003    LIKE dzea_t.dzea003,
                      dzea001    LIKE dzea_t.dzea001,
                      dzea002    LIKE dzea_t.dzea002,
                      dzea004    LIKE dzea_t.dzea004,
                      dzea014    LIKE dzea_t.dzea014  #20160329 by elena
                      END RECORD

PRIVATE TYPE T_DZEP_T RECORD
                      recordtype LIKE type_t.chr1,
                      dzepseq    VARCHAR(4),
                      dzep002    LIKE dzep_t.dzep002,  
                      dzebl003   LIKE dzebl_t.dzebl003, #顯示欄位稱用 dzebl003
                      dzebl004   LIKE dzebl_t.dzebl004, #顯示欄位說明 #2015/01/30 by Hiko
                      dzep005    LIKE dzep_t.dzep005,
                      dzep009    LIKE dzep_t.dzep009, 
                      dzep010    LIKE dzep_t.dzep010,
                      dzep011    LIKE dzep_t.dzep011,
                      dzep012    LIKE dzep_t.dzep012, 
                      dzep025    LIKE dzep_t.dzep025,
                      dzep013    LIKE dzep_t.dzep013,
                      dzep026    LIKE dzep_t.dzep026,
                      dzep014    LIKE dzep_t.dzep014,
                      dzep015    LIKE dzep_t.dzep015,
                      dzep016    LIKE dzep_t.dzep016,
                      dzep017    LIKE dzep_t.dzep017,
                      dzep018    LIKE dzep_t.dzep018,
                      dzep019    LIKE dzep_t.dzep019,
                      dzep022    LIKE dzep_t.dzep022,
                      dzep020    LIKE dzep_t.dzep020,
                      dzep021    LIKE dzep_t.dzep021,
                      dzep023    LIKE dzep_t.dzep023,
                      dzeb007    LIKE dzeb_t.dzeb007,
                      dzeb008    LIKE dzeb_t.dzeb008,
                      dzepmodid  LIKE dzep_t.dzepmodid,
                      dzepmoddt  LIKE dzep_t.dzepmoddt 
                      END RECORD

PRIVATE TYPE T_DZEQ_T RECORD
                      recordtype LIKE type_t.chr1,
                      dzeq006    LIKE dzeq_t.dzeq006,
                      dzeq007    LIKE dzeq_t.dzeq007,
                      dzeq008    LIKE dzeq_t.dzeq008,
                      dzeq009    LIKE dzeq_t.dzeq009   
                      END RECORD 

PRIVATE TYPE T_DZER_T RECORD
                      recordtype LIKE type_t.chr1,
                      dzer002    LIKE dzer_t.dzer002,
                      dzer003    LIKE dzer_t.dzer003,
                      dzer004    LIKE dzer_t.dzer004,
                      dzer005    LIKE dzer_t.dzer005,
                      dzer006    LIKE dzer_t.dzer006,
                      dzer008    LIKE dzer_t.dzer008,
                      dzer007    LIKE dzer_t.dzer007
                      END RECORD

PRIVATE TYPE T_DZEF_T RECORD
                      recordtype LIKE type_t.chr1,
                      dzef002    LIKE dzef_t.dzef002,
                      dzef010    LIKE dzef_t.dzef010, 
                      dzef003    LIKE dzef_t.dzef003,
                      dzef004    LIKE dzef_t.dzef004,
                      dzef005    LIKE dzef_t.dzef005,
                      dzef006    LIKE dzef_t.dzef006,
                      dzef007    LIKE dzef_t.dzef007,
                      dzef009    LIKE dzef_t.dzef009,
                      dzef008    LIKE dzef_t.dzef008
                      END RECORD

PRIVATE TYPE T_DZET_T RECORD
                      recordtype LIKE type_t.chr1, 
                      dzet002    LIKE dzet_t.dzet002,
                      dzet003    LIKE dzet_t.dzet003,
                      dzet004    LIKE dzet_t.dzet004,
                      dzet005    LIKE dzet_t.dzet005,
                      dzet006    LIKE dzet_t.dzet006,
                      dzet007    LIKE dzet_t.dzet007
                      END RECORD

PRIVATE TYPE T_GZCC_T RECORD
                      gzcc006    LIKE gzcc_t.gzcc006,
                      gzccstus   LIKE gzcc_t.gzccstus,
                      gzcc003    LIKE gzcc_t.gzcc003,
                      gzcc004    LIKE gzcc_t.gzcc004,
                      gzcc005    LIKE gzcc_t.gzcc005
                      END RECORD

#Begin:2015/10/01 by Hiko
PRIVATE TYPE T_VALID RECORD
                     checkbox LIKE type_t.chr1,
                     gzcc003  LIKE gzcc_t.gzcc003,
                     gzcc004  LIKE gzcc_t.gzcc004,
                     gzcbl004 LIKE gzcbl_t.gzcbl004,
                     gzcc005  LIKE gzcc_t.gzcc005,
                     modi     LIKE type_t.chr1 #2014/10/08 by Hiko
                     END RECORD

DEFINE g_gzcc_no_valid DYNAMIC ARRAY OF T_VALID
DEFINE g_gzcc_valid    DYNAMIC ARRAY OF T_VALID
#End:2015/10/01 by Hiko
             
PRIVATE TYPE T_DZEQ009 RECORD
                       col_name STRING,
                       col_desc STRING
                       END RECORD

PUBLIC TYPE T_MAPPING_DATA RECORD
                           md_global_variable VARCHAR(100),
                           md_db_function     VARCHAR(100),
                           md_column_type     VARCHAR(100)
                           END RECORD
            
################################################################################
## Define combobox related SQLs
DEFINE ms_sql_modules         STRING 
DEFINE ms_sql_mod_names       STRING
DEFINE ms_sql_genero_widgets  STRING
DEFINE ms_sql_status_setting  STRING
################################################################################

#定義模組變數
DEFINE m_dzea_t DYNAMIC ARRAY OF T_DZEA_T
DEFINE m_dzep_t DYNAMIC ARRAY OF T_DZEP_T
DEFINE m_dzeq_t DYNAMIC ARRAY OF T_DZEQ_T
DEFINE m_dzer_t DYNAMIC ARRAY OF T_DZER_T
DEFINE m_dzef_t DYNAMIC ARRAY OF T_DZEF_T
DEFINE m_dzet_t DYNAMIC ARRAY OF T_DZET_T
DEFINE m_gzcc_t DYNAMIC ARRAY OF T_GZCC_T

DEFINE m_old_dzep_t DYNAMIC ARRAY OF T_DZEP_T
DEFINE g_sys_type_code STRING

DEFINE mar_dzeq DYNAMIC ARRAY OF VARCHAR(20)

DEFINE mi_dzea_index  INTEGER

DEFINE ms_module      STRING
DEFINE ms_table_name  STRING
DEFINE mb_prog_start  BOOLEAN

DEFINE ms_lang STRING
#Begin:2014/09/01 by Hiko
DEFINE g_rtn_fields DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_fields DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#End:2014/09/01 by Hiko
DEFINE g_env LIKE dzaa_t.dzaa009 #2014/10/06 by Hiko:目前所在的環境:s.產中環境,c.客製環境
DEFINE g_first_module STRING #2015/12/04 by Hiko:第一個模組.
DEFINE g_topind STRING  #20160329 by elena 行業別
DEFINE m_date DATETIME YEAR TO SECOND #160429-00009

MAIN
  CALL adzi150_initialize()
  CALL adzi150_start()
END MAIN

FUNCTION adzi150_initialize()
DEFINE
  lo_combobox  ui.combobox 
   #Begin:2015/04/07 by Hiko
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_img_path STRING
   #End:2015/04/07 by Hiko

   LET ms_table_name = ARG_VAL(2)
   LET ms_module    = ARG_VAL(3)
   LET mb_prog_start = TRUE 

   LET g_env = FGL_GETENV("DGENV") CLIPPED #2014/10/06 by Hiko
   LET g_topind = FGL_GETENV("TOPIND") CLIPPED #20160329 by elena
   
   CALL ui.Dialog.setDefaultUnbuffered(TRUE)
   
   CLOSE WINDOW SCREEN
  
   CALL cl_tool_init()
   CALL cl_db_connect("ds", TRUE)
   LET ms_lang = g_lang
   OPEN WINDOW w_adzi150 WITH FORM cl_ap_formpath("ADZ","adzi150")

   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)
   #End:2015/04/07 by Hiko

   LET m_date = cl_get_current() #160429-00009

  CALL adzi150_initial_combobox_sql()
  CALL adzi150_initial_dzeq_arr()  
  
  LET lo_combobox = ui.combobox.forName("formonly.cb_moduleselect")
  CALL adzi150_fill_combobox(lo_combobox,ms_sql_modules)

  LET lo_combobox = ui.combobox.forName("formonly.lbl_dzea003")
  CALL adzi150_fill_combobox(lo_combobox,ms_sql_mod_names)

  LET lo_combobox = ui.combobox.forName("formonly.lbl_dzep010")
  CALL adzi150_fill_combobox(lo_combobox,ms_sql_genero_widgets)

  LET lo_combobox = ui.combobox.forName("formonly.cb_systemtypecode")
  CALL adzi150_fill_combobox(lo_combobox,ms_sql_status_setting)

  CALL cl_set_combo_scc('lbl_dzep022','135')

END FUNCTION

FUNCTION adzi150_initial_dzeq_arr()
  LET mar_dzeq[1] = "type"
  LET mar_dzeq[2] = "id"
  LET mar_dzeq[3] = "pid"
  LET mar_dzeq[4] = "desc"
  LET mar_dzeq[5] = "speed"
END FUNCTION

FUNCTION adzi150_initial_combobox_sql()
  LET ms_sql_mod_names = "SELECT ZO.GZZO001  MODULE_NAME,                       ",
                        "       ZO.GZZO001  MODULE_DESC                         ",
                        "  FROM GZZO_T ZO                                       ",
                        " ORDER BY ZO.GZZO001                                   " 

  LET ms_sql_modules = "SELECT ZO.GZZO001                     MODULE_NAME,           ",
                       "       ZO.GZZO001||'. '||ZOL.GZZOL003 MODULE_DESC            ",
                       "  FROM GZZO_T ZO                                             ",
                       "  LEFT OUTER JOIN GZZOL_T ZOL ON ZOL.GZZOL001 = ZO.GZZO001   ",
                       "                             AND ZOL.GZZOL002 = '",ms_lang,"'",                   
                       " ORDER BY ZO.GZZO001                                         " 
                       
  LET ms_sql_genero_widgets =  "SELECT EJ.DZEJ002 WIDGETS_TYPES,                        ",
                              "       EJ.DZEJ002||'. '||EJ.DZEJ003 WIDGETS_TYPES_DESC  ",
                              "  FROM DZEJ_T EJ                                        ",
                              " WHERE EJ.DZEJ001 = 'GENERO_WIDGETS'                  ",
                              " AND NOT EJ.DZEJ002 IN('18','19','20','21','22','24','27','29','31','32','33','16','17','23','25','26','30') ",
                              " ORDER BY EJ.DZEJ002                                    "
                              
  LET ms_sql_status_setting = "SELECT gzca001,gzca001||'. '||gzcal003  WIDGETS_TYPES_DESC FROM ds.gzca_t ",
                                 "LEFT JOIN ds.gzcal_t ON gzca001=gzcal001 AND gzcal002='",g_lang,"' ",
                                 " WHERE gzca001 IN ('13','17','50')"

END FUNCTION

FUNCTION adzi150_start()
DEFINE 
  lo_win                ui.Window,
  ls_module             STRING,
  ls_table_name         STRING,
  ls_search             STRING,
  li_index              INTEGER,
  lb_speed_valid        BOOLEAN,
  ls_message            STRING,
  g_sys_type_code       STRING,
  lb_result             BOOLEAN,  #20160329 by elena 
  ls_sql                STRING #160429-00009
 
  LET ls_module = ms_module
  LET ls_table_name = ms_table_name

  DISPLAY g_sys_type_code TO cb_systemtypecode 
  
  DIALOG ATTRIBUTES(UNBUFFERED) #如果加上FIELD ORDER FORM則focus不會在table list上.

    #Table Lists
    DISPLAY ARRAY m_dzea_t TO sr_tablelist.*
      BEFORE ROW 
        LET mi_dzea_index = ARR_CURR()
        
        IF mb_prog_start THEN
          FOR li_index = 1 TO m_dzea_t.getLength()
            IF m_dzea_t[li_index].dzea001 = ls_table_name THEN
              LET mi_dzea_index = li_index
              #LET ms_industry = m_dzea_t[li_index].dzea014
              EXIT FOR
            END IF  
          END FOR     
          CALL DIALOG.setCurrentRow("sr_tablelist",mi_dzea_index)
          LET mb_prog_start = FALSE
        END IF
        
        CALL adzi150_fill_dzep_t(m_dzea_t[mi_dzea_index].dzea001)
        CALL adzi150_fill_dzeq_t(m_dzea_t[mi_dzea_index].dzea001)
        CALL adzi150_fill_dzer_t(m_dzea_t[mi_dzea_index].dzea001)
        CALL adzi150_fill_dzef_t(m_dzea_t[mi_dzea_index].dzea001)
        CALL adzi150_fill_dzet_t(m_dzea_t[mi_dzea_index].dzea001)
        CALL adzi150_fill_gzcc_t(m_dzea_t[mi_dzea_index].dzea001)

    END DISPLAY

    #Table Columns
    DISPLAY ARRAY m_dzep_t TO sr_tablecolumns.*
    END DISPLAY

    #Table Index
    DISPLAY ARRAY m_dzeq_t TO sr_tabletreetype.*
    END DISPLAY

    #Table Multilang
    DISPLAY ARRAY m_dzer_t TO sr_tablemultilang.*
    END DISPLAY
        
    #Refernece Columns
    DISPLAY ARRAY m_dzef_t TO sr_tablereference.*
    END DISPLAY

    #Remember Columns
    DISPLAY ARRAY m_dzet_t TO sr_tableremember.*
    END DISPLAY

    #狀態碼分類值設定_無效
    DISPLAY ARRAY g_gzcc_no_valid TO sr_status_no_valid.*
    END DISPLAY

    #狀態碼分類值設定_有效
    DISPLAY ARRAY g_gzcc_valid TO sr_status_valid.*
    END DISPLAY
 
    #輸入模組搜尋條件
    INPUT ls_module FROM cb_ModuleSelect ATTRIBUTE(WITHOUT DEFAULTS)
      ON CHANGE cb_ModuleSelect
        CALL adzi150_fill_dzea_t(ls_module)
        #LET ms_module = ls_module #2015/12/04 by Hiko:不知道為何需要重新設定ms_module,因為都沒有用到了.

    END INPUT

    #輸入搜尋條件
    INPUT ls_search FROM edt_Search ATTRIBUTE(WITHOUT DEFAULTS)
      #Begin:2015/08/03 by Hiko
      AFTER FIELD edt_Search 
         CALL adzi150_fill_dzea_t(ls_search)
         NEXT FIELD cb_ModuleSelect #大重點.
      #End:2015/08/03 by Hiko
    END INPUT

    BEFORE DIALOG
      LET lo_win = ui.Window.getCurrent()
      #Begin:2015/12/04 by Hiko
      IF cl_null(ms_table_name) AND cl_null(ms_module) THEN #表示自己開啟程式.
         #預設第一個模組
         CALL adzi150_fill_dzea_t(g_first_module)
      ELSE #表示從r.t串過來
         CALL adzi150_fill_dzea_t(ms_table_name)
      END IF
      CALL DIALOG.setSelectionMode("sr_tablecolumns", TRUE)

    ON ACTION btn_Search   
      CALL adzi150_fill_dzea_t(ls_search)

    #欄位規格設定-修改功能
    ON ACTION btn_ColumnModify
      #Begin:20160329 by elena 新增行業判斷，行業環境不可修改標準資料
      CALL sadzp060_ind_check_modify_permissions(m_dzea_t[mi_dzea_index].dzea014,'u', true) RETURNING lb_result
      IF lb_result THEN
         CALL adzi150_modify_column_data()
      END IF
      #End:20160329 by elena

    #樹狀資料不能單筆刪除,所以控制方式和其他頁籤不同
    ON ACTION btn_TypeDelete
       #Begin:20160329 by elena 新增行業判斷，行業環境不可刪除標準資料
       CALL sadzp060_ind_check_modify_permissions(m_dzea_t[mi_dzea_index].dzea014,'d', true) RETURNING lb_result
       IF lb_result THEN
          IF cl_ask_confirm("adz-00713") THEN #確定要刪除整個樹狀結構的設定嗎?
             TRY 
                DELETE FROM DZEQ_T
                 WHERE DZEQ001 = m_dzea_t[mi_dzea_index].dzea001
    
                CALL adzi150_fill_dzeq_t(m_dzea_t[mi_dzea_index].dzea001)
             CATCH
               CALL FGL_WINMESSAGE("ERROR", "DELETE DZER_T : "||SQLCA.SQLCODE, "stop")
             END TRY  
          END IF
       END IF
      #End:20160329 by elena

    #樹狀結構設定-修改功能
    ON ACTION btn_TypeModify
      #Begin:20160329 by elena 新增行業判斷，行業環境不可修改標準資料
      CALL sadzp060_ind_check_modify_permissions(m_dzea_t[mi_dzea_index].dzea014,'u', true) RETURNING lb_result
      IF lb_result THEN
         IF m_dzeq_t.getLength() = 0 THEN
           CALL adzi150_fill_dzeq_arr(m_dzea_t[mi_dzea_index].dzea001,m_dzea_t[mi_dzea_index].dzea004)
         END IF
         CALL adzi150_modify_treetype_data()
      END IF
      #End:20160329 by elena

    #資料多語言設定-修改功能
    ON ACTION btn_MultilangModify
      #Begin:20160329 by elena 新增行業判斷，行業環境不可修改標準資料
      CALL sadzp060_ind_check_modify_permissions(m_dzea_t[mi_dzea_index].dzea014,'u', true) RETURNING lb_result
      IF lb_result THEN
         CALL adzi150_modify_multilang_data()
      END IF
      #End:20160329 by elena
      
    #欄位參考設定-修改功能
    ON ACTION btn_ReferenceModify
      #Begin:20160329 by elena 新增行業判斷，行業環境不可修改標準資料
      CALL sadzp060_ind_check_modify_permissions(m_dzea_t[mi_dzea_index].dzea014,'u', true) RETURNING lb_result
      IF lb_result THEN
         CALL adzi150_modify_reference_data()
      END IF
      #End:20160329 by elena
    #助記碼設定-修改功能
    ON ACTION btn_RememberModify
      #Begin:20160329 by elena 新增行業判斷，行業環境不可修改標準資料
      CALL sadzp060_ind_check_modify_permissions(m_dzea_t[mi_dzea_index].dzea014,'u', true) RETURNING lb_result
      IF lb_result THEN
         CALL adzi150_modify_remember_data()
      END IF
      #End:20160329 by elena
    #狀態碼分類值設定
    ON ACTION btn_status_type_modify
      #Begin:20160329 by elena 新增行業判斷，行業環境不可修改標準資料
      CALL sadzp060_ind_check_modify_permissions(m_dzea_t[mi_dzea_index].dzea014,'u', true) RETURNING lb_result
      IF lb_result THEN
         CALL adzi150_modify_status_type()
      END IF
      #End:20160329 by elena

    #Begin:160429-00009
    ON ACTION show_status_prog
       LET ls_sql = "SELECT distinct(dzag001) FROM dzag_t WHERE dzag002='",m_dzea_t[mi_dzea_index].dzea001 CLIPPED,"' ORDER BY dzag001"
       CALL adzi150_show_scc_prog(ls_sql, m_dzea_t[mi_dzea_index].dzea001)
    #End:160429-00009

    ON ACTION tbi_exit
      EXIT DIALOG
      
    ON ACTION CLOSE    
      EXIT DIALOG

  END DIALOG

END FUNCTION

PRIVATE FUNCTION adzi150_set_multilang_field(p_table)
   DEFINE p_table LIKE dzea_t.dzea001
   DEFINE ls_sql STRING
   DEFINE li_cnt LIKE type_t.num5
   DEFINE la_dzeb DYNAMIC ARRAY OF RECORD LIKE dzeb_t.*
   DEFINE l_return_fk STRING
   DEFINE l_return_lang STRING
   DEFINE l_return_value STRING
   DEFINE l_previous_flag LIKE type_t.chr1
   DEFINE l_replace_str      base.StringBuffer

   LET ls_sql = "SELECT *",
                 " FROM dzeb_t",
                 " WHERE dzeb001='",p_table,"' ORDER BY dzeb002"
   PREPARE dzeb_prep FROM ls_sql
   DECLARE dzeb_curs CURSOR FOR dzeb_prep
   
   LET li_cnt = 1
   
   LET l_previous_flag = "N"

   FOREACH dzeb_curs INTO la_dzeb[li_cnt].*
           
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "get data from dzeb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      IF la_dzeb[li_cnt].dzeb004 = "Y" THEN
         IF l_return_fk.getLength() = 0 THEN
            LET l_return_fk = la_dzeb[li_cnt].dzeb002
         ELSE
            LET l_return_fk = l_return_fk,",",la_dzeb[li_cnt].dzeb002
         END IF

         LET l_previous_flag = la_dzeb[li_cnt].dzeb004
      END IF

      IF la_dzeb[li_cnt].dzeb006 = "N801" THEN
         LET l_return_lang = la_dzeb[li_cnt].dzeb002
      END IF

      IF la_dzeb[li_cnt].dzeb004 = "N" AND l_previous_flag = "Y" THEN
         #LET l_return_lang = la_dzeb[li_cnt-1].dzeb002
         LET l_return_value = la_dzeb[li_cnt].dzeb002
         #LET l_return_fk = l_return_fk.subString(1,l_return_fk.getLength()-1)
         EXIT FOREACH
      END IF
   
      LET li_cnt = li_cnt + 1

      
   END FOREACH

   CALL la_dzeb.deleteElement(li_cnt)
   LET li_cnt = li_cnt - 1

   LET l_replace_str = base.StringBuffer.create() 
   CALL l_replace_str.append(l_return_fk)
   CALL l_replace_str.replace(","||l_return_lang,"", 1)
   
   LET l_return_fk = l_replace_str.toString()
   
   RETURN l_return_fk,l_return_lang,l_return_value
END FUNCTION

#修改 Column 的資料
FUNCTION adzi150_modify_column_data()
DEFINE 
  lo_t_dzep_t    DYNAMIC ARRAY OF T_DZEP_T,
  li_rec_cnt     INTEGER,
  li_arr_curr    INTEGER,
  ls_dzep011     STRING,
  ls_dzep017     STRING,
  ls_dzep018     STRING,
  ls_dzep019     STRING,
  ls_dzep020     STRING,
  ls_main_table  STRING,
  ls_main_module STRING,
  lb_result      BOOLEAN,
  ls_error_code  STRING,
  ls_replace_arg STRING,
  lb_check_value BOOLEAN,
  li_loop        INTEGER,
  ls_dzep012     STRING,
  lo_mapping_data DYNAMIC ARRAY OF T_MAPPING_DATA,
  l_cnt          LIKE type_t.num5,
  l_nxt_row      LIKE type_t.num5
  #Begin:2015/10/01 by Hiko
  DEFINE ls_fields     STRING,
         lb_enabled    BOOLEAN,  
         l_tmp_dzep002 LIKE dzep_t.dzep002 
  DEFINE l_var_keys     DYNAMIC ARRAY OF STRING,
         l_field_keys   DYNAMIC ARRAY OF STRING,
         l_vars         DYNAMIC ARRAY OF STRING,
         l_fields       DYNAMIC ARRAY OF STRING,
         l_var_keys_bak DYNAMIC ARRAY OF STRING
  #End:2015/10/01 by Hiko
  DEFINE ls_sql STRING #160429-00009

  LET m_old_dzep_t.* = m_dzep_t.*
  
  DIALOG ATTRIBUTES(UNBUFFERED)
    
    INPUT ARRAY lo_t_dzep_t FROM sr_tablecolumns.* ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE ROW
         LET li_arr_curr = ARR_CURR()

         #Begin:2015/10/01 by Hiko:公用欄位都不可以編輯.
         LET ls_fields = "lbl_dzebl003,lbl_dzep005,",
                         "lbl_dzep009,lbl_dzep010,lbl_dzep011,lbl_dzep013,",
                         "lbl_dzep014,lbl_dzep015,lbl_dzep016,lbl_dzep017,lbl_dzep018,",
                         "lbl_dzep019,lbl_dzep020,lbl_dzep022,lbl_dzep023,",  #20160426 modify by elena  刪除lbl_dzep021，format不可修改
                         "lbl_dzep025,lbl_dzep026"
         LET lb_enabled = adzi150_is_not_common_filed(m_dzea_t[mi_dzea_index].dzea001, lo_t_dzep_t[li_arr_curr].dzep002)
         CALL cl_set_comp_entry(ls_fields, lb_enabled)
         #End:2015/10/01 by Hiko
         #Begin:160429-00009
         IF cl_null(lo_t_dzep_t[li_arr_curr].dzep011) THEN
            CALL DIALOG.setActionActive("show_scc_prog", FALSE)
         ELSE
            CALL DIALOG.setActionActive("show_scc_prog", TRUE)
         END IF
         #End:160429-00009
      
      BEFORE INPUT
        LET lo_t_dzep_t.* = m_dzep_t.*
        CALL DIALOG.setActionHidden("insert",TRUE)
        CALL DIALOG.setActionHidden("append",TRUE)
        CALL DIALOG.setActionHidden("delete",TRUE)

      #Begin:2015/10/01 by Hiko
      BEFORE FIELD lbl_dzep002
         LET l_tmp_dzep002 = lo_t_dzep_t[li_arr_curr].dzep002

      AFTER FIELD lbl_dzep002
         #因為INPUT ARRAY一定要有一個欄位可編輯, 所以就開放欄位代號進入編輯狀態, 只不過最後再還原即可.
         IF lo_t_dzep_t[li_arr_curr].dzep002<>l_tmp_dzep002 THEN
            LET m_dzep_t[li_arr_curr].dzep002 = l_tmp_dzep002
            LET lo_t_dzep_t[li_arr_curr].dzep002 = l_tmp_dzep002
         END IF

      AFTER FIELD lbl_dzep010 #若不是ComboBox或RadioGroupBox, 則清空dzep011.
         IF (lo_t_dzep_t[li_arr_curr].dzep010<>"03") AND (lo_t_dzep_t[li_arr_curr].dzep010<>"09") THEN
            LET lo_t_dzep_t[li_arr_curr].dzep011 = NULL
         END IF
      #End:2015/10/01 by Hiko

      BEFORE FIELD lbl_dzep011
         #只有comboxBox和radioGroup可以設定系統分類碼
         IF (lo_t_dzep_t[li_arr_curr].dzep010<>"03") AND (lo_t_dzep_t[li_arr_curr].dzep010<>"09") THEN
            NEXT FIELD lbl_dzep012
         END IF

      AFTER FIELD lbl_dzep011
         IF NOT cl_null(lo_t_dzep_t[li_arr_curr].dzep011) THEN
            #Begin:2015/10/01 by Hiko
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = lo_t_dzep_t[li_arr_curr].dzep011
            IF NOT cl_chk_exist("v_gzca001_01") THEN
               NEXT FIELD CURRENT
            ELSE
               IF cl_null(lo_t_dzep_t[li_arr_curr].dzep012) THEN
                  CALL cl_ask_pressanykey("adz-00391") #您有設定系統分類碼,建議也在r.t設定預設值.
               END IF
            END IF
            #End:2015/10/01 by Hiko
         END IF

      AFTER FIELD lbl_dzep012
        #離開欄位時也做 on change 的判定
        IF (lo_t_dzep_t[li_arr_curr].dzep012 IS NOT NULL) AND (lo_t_dzep_t[li_arr_curr].dzep012 <> ASCII(32)) THEN 
          GOTO _lbl_dzep012 
        END IF 

      ON CHANGE lbl_dzep012
        LABEL _lbl_dzep012:
        LET lb_check_value = TRUE
        CALL sadzi140_util_check_if_enable_set_default_value(lo_t_dzep_t[li_arr_curr].dzeb007) RETURNING lb_result
        IF NOT lb_result THEN
          LET ls_replace_arg = UPSHIFT(lo_t_dzep_t[li_arr_curr].dzeb007),"|"
          CALL sadzp000_msg_show_error(NULL, 'adz-00577', ls_replace_arg, 0)
          LET lo_t_dzep_t[li_arr_curr].dzep012 = NULL 
        ELSE 
          #先取得Mapping資料
          CALL sadzi140_util_get_global_var_to_db_func_mapping_data() RETURNING lo_mapping_data

          #比對輸入的值在 Mapping 表中是否存在
          FOR li_loop = 1 TO lo_mapping_data.getLength()
            LET ls_dzep012 = lo_t_dzep_t[li_arr_curr].dzep012
            IF ls_dzep012.toUpperCase() = lo_mapping_data[li_loop].md_global_variable THEN
              LET lo_t_dzep_t[li_arr_curr].dzep012 = lo_mapping_data[li_loop].md_global_variable
              LET lb_check_value = FALSE
              EXIT FOR 
            END IF  
          END FOR 
          
          IF lb_check_value THEN 
            #進行一般資料檢核
            CALL sadzi140_util_check_default_value(lo_t_dzep_t[li_arr_curr].dzeb007,lo_t_dzep_t[li_arr_curr].dzeb008,lo_t_dzep_t[li_arr_curr].dzep012) RETURNING lb_result,ls_error_code
            IF NOT lb_result THEN
              CALL sadzp000_msg_show_error(NULL, ls_error_code, NULL, 0)
              NEXT FIELD CURRENT
            END IF
          END IF  
        END IF    
        
      #Begin:2015/10/01 by Hiko
      AFTER FIELD lbl_dzep017
         IF NOT cl_null(lo_t_dzep_t[li_arr_curr].dzep017) THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = lo_t_dzep_t[li_arr_curr].dzep017
            IF NOT cl_chk_exist("v_dzca001") THEN
               NEXT FIELD CURRENT
            ELSE
               #預設adzi150的編輯時開窗要和查詢時開窗一致. 如果查詢時開窗已經有設定,則不要變成一致.
               IF cl_null(lo_t_dzep_t[li_arr_curr].dzep018) THEN
                 LET lo_t_dzep_t[li_arr_curr].dzep018 = lo_t_dzep_t[li_arr_curr].dzep017
               END IF
            END IF
         END IF

      AFTER FIELD lbl_dzep018
         IF NOT cl_null(lo_t_dzep_t[li_arr_curr].dzep018) THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = lo_t_dzep_t[li_arr_curr].dzep018
            IF NOT cl_chk_exist("v_dzca001") THEN
               NEXT FIELD CURRENT
            END IF
         END IF
      #End:2015/10/01 by Hiko

      #Begin:2014/09/01 by Hiko
      ON ACTION update_item
         CALL s_transaction_begin()
         CALL n_dzebl(lo_t_dzep_t[li_arr_curr].dzep002)
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = lo_t_dzep_t[li_arr_curr].dzep002
         CALL ap_ref_array2(g_ref_fields," SELECT dzebl003,dzebl004 FROM dzebl_t " #2015/01/30 by Hiko:增加回傳dzebl004(欄位說明)
                                         ||"WHERE dzebl001 = ? AND dzebl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
         CALL s_transaction_end('Y','0')
         LET lo_t_dzep_t[li_arr_curr].dzebl003 = g_rtn_fields[1]
         LET lo_t_dzep_t[li_arr_curr].dzebl004 = g_rtn_fields[2] #2015/01/30 by Hiko:增加回傳dzebl004(欄位說明)
         
         NEXT FIELD lbl_dzebl003
      #End:2014/09/01 by Hiko

      ON ACTION controlp INFIELD lbl_dzep011
         #系統分類碼查詢  adzi150_gzca
         INITIALIZE g_qryparam.* TO NULL 
         LET g_qryparam.state = "i"
         #CALL adzi150_gzca() #2015/10/01 by Hiko
         CALL q_gzca002()
         LET ls_dzep011 = g_qryparam.return1 CLIPPED
         LET lo_t_dzep_t[li_arr_curr].dzep011 = ls_dzep011
         DISPLAY lo_t_dzep_t[li_arr_curr].dzep011 TO lbl_dzep011
        
      ON ACTION controlp INFIELD lbl_dzep017
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = TRUE
         LET g_qryparam.default1 = lo_t_dzep_t[li_arr_curr].dzep017
         CALL q_dzca001()
         LET ls_dzep017 = g_qryparam.return1
         LET lo_t_dzep_t[li_arr_curr].dzep017 = ls_dzep017
         DISPLAY lo_t_dzep_t[li_arr_curr].dzep017 TO lbl_dzep017

      ON ACTION controlp INFIELD lbl_dzep018
         INITIALIZE g_qryparam.* TO NULL 
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = TRUE
         LET g_qryparam.default1 = lo_t_dzep_t[li_arr_curr].dzep018
         CALL q_dzca001()
         LET ls_dzep018 = g_qryparam.return1
         LET lo_t_dzep_t[li_arr_curr].dzep018 = ls_dzep018
         DISPLAY lo_t_dzep_t[li_arr_curr].dzep018 TO lbl_dzep018

      ON ACTION controlp INFIELD lbl_dzep019
         #Begin:2015/10/01 by Hiko
         #CALL adzi150_sclo_set_logic_order(lo_t_dzep_t[li_arr_curr].dzep019) RETURNING ls_dzep019
         INITIALIZE g_qryparam.* TO NULL 
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = TRUE
         LET g_qryparam.default1 = lo_t_dzep_t[li_arr_curr].dzep019
         CALL q_dzcd001()
         LET ls_dzep019 = g_qryparam.return1
         #End:2015/10/01 by Hiko
         LET lo_t_dzep_t[li_arr_curr].dzep019 = ls_dzep019
         DISPLAY lo_t_dzep_t[li_arr_curr].dzep019 TO lbl_dzep019
        
      #Begin:2015/10/01 by Hiko
      AFTER FIELD lbl_dzep019
         IF NOT cl_null(lo_t_dzep_t[li_arr_curr].dzep019) THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = lo_t_dzep_t[li_arr_curr].dzep019
            IF NOT cl_chk_exist("v_dzcd001") THEN
               NEXT FIELD CURRENT
            END IF
         END IF
      #End:2015/10/01 by Hiko

      #Begin:2015/10/01 by Hiko
      AFTER FIELD lbl_dzep022 #串查類型清空, 則串查程式也清空.
         IF cl_null(lo_t_dzep_t[li_arr_curr].dzep022) THEN
            LET ls_dzep020 = NULL
            LET lo_t_dzep_t[li_arr_curr].dzep020 = ls_dzep020
         END IF

      BEFORE FIELD lbl_dzep020
         IF cl_null(lo_t_dzep_t[li_arr_curr].dzep022) THEN
            NEXT FIELD lbl_dzep021
         END IF

      ON ACTION controlp INFIELD lbl_dzep020
         IF NOT cl_null(lo_t_dzep_t[li_arr_curr].dzep022) AND
            lo_t_dzep_t[li_arr_curr].dzep022='1' THEN
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = TRUE
            LET g_qryparam.default1 = lo_t_dzep_t[li_arr_curr].dzep020
            CALL q_gzzz001_1()
            LET ls_dzep020 = g_qryparam.return1
            LET lo_t_dzep_t[li_arr_curr].dzep020 = ls_dzep020
            DISPLAY lo_t_dzep_t[li_arr_curr].dzep020 TO lbl_dzep020
         END IF
        
      AFTER FIELD lbl_dzep020
         IF NOT cl_null(lo_t_dzep_t[li_arr_curr].dzep022) AND
            lo_t_dzep_t[li_arr_curr].dzep022='1' THEN
            IF NOT cl_null(lo_t_dzep_t[li_arr_curr].dzep020) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = lo_t_dzep_t[li_arr_curr].dzep020
               IF NOT cl_chk_exist("v_gzzz001") THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF
      #End:2015/10/01 by Hiko

      ON ROW CHANGE
         TRY 
           UPDATE DZEP_T
              SET DZEP005 = lo_t_dzep_t[li_arr_curr].dzep005,
                  DZEP009 = lo_t_dzep_t[li_arr_curr].dzep009,
                  DZEP010 = lo_t_dzep_t[li_arr_curr].dzep010,
                  DZEP011 = lo_t_dzep_t[li_arr_curr].dzep011,
                  DZEP012 = lo_t_dzep_t[li_arr_curr].dzep012,
                  DZEP013 = lo_t_dzep_t[li_arr_curr].dzep013,
                  DZEP014 = lo_t_dzep_t[li_arr_curr].dzep014,
                  DZEP015 = lo_t_dzep_t[li_arr_curr].dzep015,
                  DZEP016 = lo_t_dzep_t[li_arr_curr].dzep016,
                  DZEP017 = lo_t_dzep_t[li_arr_curr].dzep017,
                  DZEP018 = lo_t_dzep_t[li_arr_curr].dzep018,
                  DZEP019 = lo_t_dzep_t[li_arr_curr].dzep019,
                  DZEP020 = lo_t_dzep_t[li_arr_curr].dzep020,
                  DZEP025 = lo_t_dzep_t[li_arr_curr].dzep025,
                  DZEP026 = lo_t_dzep_t[li_arr_curr].dzep026,
                  DZEP021 = lo_t_dzep_t[li_arr_curr].dzep021,
                  DZEP022 = lo_t_dzep_t[li_arr_curr].dzep022,
                  DZEP023 = lo_t_dzep_t[li_arr_curr].dzep023,
                  DZEPSTUS = g_env,
                  DZEPMODDT = m_date, #160429-00009
                  DZEPMODID = g_user  #160429-00009
            WHERE DZEP001 = m_dzea_t[mi_dzea_index].dzea001
              AND DZEP002 = lo_t_dzep_t[li_arr_curr].dzep002

            #Begin:2015/10/01 by Hiko:補上多語言的異動
            INITIALIZE l_var_keys TO NULL
            INITIALIZE l_field_keys TO NULL
            INITIALIZE l_var_keys_bak TO NULL
            INITIALIZE l_vars TO NULL
            INITIALIZE l_fields TO NULL
            LET l_var_keys[1] = lo_t_dzep_t[li_arr_curr].dzep002
            LET l_var_keys[2] = g_dlang
            LET l_field_keys[1] = "dzebl001"
            LET l_field_keys[2] = "dzebl002"
            LET l_var_keys_bak[1] = lo_t_dzep_t[li_arr_curr].dzep002
            LET l_var_keys_bak[2] = g_dlang
            LET l_vars[1] = lo_t_dzep_t[li_arr_curr].dzebl003
            LET l_vars[2] = lo_t_dzep_t[li_arr_curr].dzebl004
            LET l_fields[1] = "dzebl003"
            LET l_fields[2] = "dzebl004"
            CALL s_transaction_begin()
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,"dzebl_t")
            CALL s_transaction_end('Y','0')
            #End:2015/10/01 by Hiko
         CATCH
           CALL FGL_WINMESSAGE("ERROR", "UPDATE DZEP_T : "||SQLCA.SQLCODE, "stop")
         END TRY  

    END INPUT

    ON ACTION btn_ColumnCancel
       CALL adzi150_fill_dzep_t(m_dzea_t[mi_dzea_index].dzea001)
       EXIT DIALOG

    #Begin:160429-00009
    #顯現SCC的使用程式清單.
    ON ACTION show_scc_prog
       LET ls_sql = "SELECT distinct(dzac001) FROM dzac_t WHERE dzac002='",lo_t_dzep_t[li_arr_curr].dzep002 CLIPPED,"' ORDER BY dzac001"
       CALL adzi150_show_scc_prog(ls_sql, lo_t_dzep_t[li_arr_curr].dzep002)
    #End:160429-00009

    ON ACTION btn_ColumnConfirm
       ACCEPT DIALOG

    ON ACTION CLOSE
       EXIT DIALOG 

    AFTER DIALOG
      CALL adzi150_gen_tbl_file()

  END DIALOG
  
END FUNCTION

#修改 Tree Type 的資料
FUNCTION adzi150_modify_treetype_data()
DEFINE 
  lo_t_dzeq_t    DYNAMIC ARRAY OF T_DZEQ_T ,
  li_rec_cnt     INTEGER,
  li_counts      INTEGER,
  li_arr_curr    INTEGER,
  lo_dzeq009     T_DZEQ009,
  lb_dzeq008     BOOLEAN,
  ls_message     STRING,  
  ls_main_table  STRING,
  ls_main_module STRING,
  lb_can_delete  BOOLEAN,
  li_idx         SMALLINT
  
  DIALOG ATTRIBUTES(UNBUFFERED)
    INPUT ARRAY lo_t_dzeq_t FROM sr_tabletreetype.* ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE ROW
         LET li_arr_curr = ARR_CURR()
      
      BEFORE INPUT
         LET lo_t_dzeq_t.* = m_dzeq_t.*
        ##Begin:2015/10/01 by Hiko:客製環境不可以刪除標準資料
        #LET lb_can_delete = adzi150_can_delete(m_dzea_t[mi_dzea_index].dzea001, "dzeq_t")
        #CALL cl_set_act_visible("btn_TypeDelete", lb_can_delete)
        ##End:2015/10/01 by Hiko         
         CALL DIALOG.setActionHidden("insert",TRUE)
         CALL DIALOG.setActionHidden("append",TRUE)
         CALL DIALOG.setActionHidden("delete",TRUE)
        
      ON CHANGE lbl_dzeq008
        #Begin:2015/10/01 by Hiko
        IF NOT cl_null(lo_t_dzeq_t[li_arr_curr].dzeq008) THEN
           IF NOT adzi150_chk_table_exist(lo_t_dzeq_t[li_arr_curr].dzeq008) THEN
              NEXT FIELD CURRENT
           END IF
        END IF
        #End:2015/10/01 by Hiko

      #表格名稱
      ON ACTION controlp INFIELD lbl_dzeq008
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        IF lo_t_dzeq_t[li_arr_curr].dzeq007 = "speed"  THEN
           CALL q_dzea004()
        ELSE
           CALL q_dzea002()
        END IF
        LET lo_t_dzeq_t[li_arr_curr].dzeq008 = g_qryparam.return1
        DISPLAY lo_t_dzeq_t[li_arr_curr].dzeq008 TO lbl_dzeq008

      BEFORE FIELD lbl_dzeq009
         IF lo_t_dzeq_t[li_arr_curr].dzeq007 = "speed" THEN
            NEXT FIELD lbl_dzeq008
         END IF

      ON ACTION controlp INFIELD lbl_dzeq009
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = "i"
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.where = "dzeb001 = '",lo_t_dzeq_t[li_arr_curr].dzeq008,"'"
        LET g_qryparam.default1 = ""
        LET g_qryparam.default2 = ""
        CALL q_dzeb001()
        LET lo_dzeq009.COL_NAME = g_qryparam.return1
        LET lo_t_dzeq_t[li_arr_curr].dzeq009 = lo_dzeq009.COL_NAME
        DISPLAY lo_t_dzeq_t[li_arr_curr].dzeq009 TO lbl_dzeq009

      AFTER FIELD lbl_dzeq009
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_exist(lo_t_dzeq_t[li_arr_curr].dzeq008, lo_t_dzeq_t[li_arr_curr].dzeq009, TRUE) THEN 
            NEXT FIELD CURRENT
         END IF
         #End:2015/10/01 by Hiko

      ON ROW CHANGE
         IF NOT cl_null(lo_t_dzeq_t[li_arr_curr].dzeq007) THEN
            TRY
              UPDATE DZEQ_T
                 SET DZEQ006 = li_arr_curr,
                     DZEQ008 = lo_t_dzeq_t[li_arr_curr].dzeq008,
                     DZEQ009 = lo_t_dzeq_t[li_arr_curr].dzeq009,
                     DZEQSTUS = g_env
               WHERE DZEQ001 = m_dzea_t[mi_dzea_index].dzea001  #Table Name
                 AND DZEQ007 = lo_t_dzeq_t[li_arr_curr].dzeq007 #Type 
            CATCH
               CALL FGL_WINMESSAGE("ERROR", "UPDATE DZEQ_T : "||SQLCA.SQLCODE, "stop")
            END TRY
         END IF
        
      AFTER INPUT #離開前要check all.
         #Begin:2015/10/01 by Hiko
         FOR li_idx=1 TO lo_t_dzeq_t.getLength()
            IF lo_t_dzeq_t[li_idx].dzeq007 <> "speed"  THEN
               IF NOT adzi150_chk_field_exist(lo_t_dzeq_t[li_idx].dzeq008, lo_t_dzeq_t[li_idx].dzeq009, TRUE) THEN 
                  CALL FGL_SET_ARR_CURR(li_idx) #將focus移到有問題的那一筆資料.
                  NEXT FIELD lbl_dzeq009
                  EXIT FOR
               END IF
            END IF
         END FOR
         #End:2015/10/01 by Hiko
       
    END INPUT

    ON ACTION btn_TypeCancel
      CALL adzi150_fill_dzeq_t(m_dzea_t[mi_dzea_index].dzea001)
      EXIT DIALOG

    ON ACTION btn_TypeConfirm
      ACCEPT DIALOG

    ON ACTION CLOSE
      EXIT DIALOG 

    AFTER DIALOG
      CALL adzi150_gen_tbl_file()

  END DIALOG
  
END FUNCTION

PUBLIC FUNCTION adzi150_set_comp_entry(ps_fields, pi_entry)
  DEFINE ps_fields     STRING
  DEFINE pi_entry      LIKE type_t.num5
  DEFINE lst_fields    base.StringTokenizer
  DEFINE ls_field_name STRING
  DEFINE lwin_curr     ui.Window
  DEFINE lnode_win     om.DomNode
  DEFINE llst_items    om.NodeList
  DEFINE li_i          LIKE type_t.num5
  DEFINE lnode_item    om.DomNode
  DEFINE ls_item_name  STRING

  IF (ps_fields IS NULL) THEN
     RETURN
  END IF

  LET ps_fields = ps_fields.toLowerCase()

  LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
 
  LET lwin_curr = ui.Window.getCurrent()
  LET lnode_win = lwin_curr.getNode()
 
  LET llst_items = lnode_win.selectByPath("//Form//*")
 
  WHILE lst_fields.hasMoreTokens()
    LET ls_field_name = lst_fields.nextToken()
    LET ls_field_name = ls_field_name.trim()

    IF (ls_field_name.getLength() > 0) THEN
       FOR li_i = 1 TO llst_items.getLength()
           LET lnode_item = llst_items.item(li_i)

           #先抓取Name (有含table.colname) 不存在再試抓 colName (不含table name)
           LET ls_item_name = lnode_item.getAttribute("name")
  
           IF (ls_item_name IS NULL) THEN
              LET ls_item_name = lnode_item.getAttribute("colName")
 
              IF (ls_item_name IS NULL) THEN
                 CONTINUE FOR
              END IF
           END IF
  
           LET ls_item_name = ls_item_name.trim()
           IF (ls_item_name.equals(ls_field_name)) THEN
              IF (pi_entry) THEN
                 CALL lnode_item.setAttribute("noEntry", "0")
                 CALL lnode_item.setAttribute("active", "1")
              ELSE
                 CALL lnode_item.setAttribute("noEntry", "1")
                 CALL lnode_item.setAttribute("active", "0")
              END IF
           
              EXIT FOR
           END IF
       END FOR
    END IF
  END WHILE
END FUNCTION

#修改 MultiLang 的資料
FUNCTION adzi150_modify_multilang_data()
DEFINE 
  lo_t_dzer_t   DYNAMIC ARRAY OF T_DZER_T,
  li_rec_cnt    INTEGER,
  ls_main_table  STRING,
  ls_main_module STRING,
  ls_dzer004    STRING,
  ls_dzer006    STRING,
  li_arr_curr   LIKE type_t.num5, 
  l_cnt         LIKE type_t.num5, 
  l_syn_flag    BOOLEAN,
  lb_can_delete BOOLEAN,
  li_idx        SMALLINT,
  lb_duplicate  BOOLEAN
  
  DIALOG ATTRIBUTES(UNBUFFERED)
  
    INPUT ARRAY lo_t_dzer_t FROM sr_tablemultilang.* ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE ROW
         LET li_arr_curr = ARR_CURR()
        ##Begin:2015/10/01 by Hiko:客製環境不可以刪除標準資料
        #LET lb_can_delete = adzi150_can_delete(m_dzea_t[mi_dzea_index].dzea001, lo_t_dzer_t[li_arr_curr].dzer002)
        #CALL cl_set_act_visible("btn_MultilangDelete", lb_can_delete)
        ##End:2015/10/01 by Hiko         
      
      BEFORE INPUT
        LET lo_t_dzer_t.* = m_dzer_t.*
        CALL DIALOG.setActionHidden("insert",TRUE)
        CALL DIALOG.setActionHidden("append",TRUE)
        CALL DIALOG.setActionHidden("delete",TRUE)

      #依附欄位名稱
      ON ACTION controlp INFIELD lbl_dzer002
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.arg1 = m_dzea_t[mi_dzea_index].dzea001
        CALL q_dzeb003()
        LET lo_t_dzer_t[li_arr_curr].dzer002 = g_qryparam.return1
        DISPLAY lo_t_dzer_t[li_arr_curr].dzer002 TO lbl_dzer002

      #依附欄位名稱
      AFTER FIELD lbl_dzer002
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_exist(m_dzea_t[mi_dzea_index].dzea001, lo_t_dzer_t[li_arr_curr].dzer002, FALSE) THEN 
            NEXT FIELD CURRENT
         ELSE
            #判斷是否重複
            LET lb_duplicate = FALSE
            FOR li_idx=1 TO lo_t_dzer_t.getLength()
               IF li_idx<>li_arr_curr THEN
                  IF lo_t_dzer_t[li_arr_curr].dzer002=lo_t_dzer_t[li_idx].dzer002 THEN
                     LET lb_duplicate = TRUE
                     EXIT FOR
                  END IF
               END IF
            END FOR
    
            IF lb_duplicate THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00042"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF

            IF cl_null(lo_t_dzer_t[li_arr_curr].dzer004) THEN
               #對應傳值設定要帶依附欄位為預設值
               LET lo_t_dzer_t[li_arr_curr].dzer004 = lo_t_dzer_t[li_arr_curr].dzer002
            END IF
         END IF        
         #End:2015/10/01 by Hiko

      #對應值設定
      ON ACTION controlp INFIELD lbl_dzer004
        CALL adzi150_sfo_set_field_order(m_dzea_t[mi_dzea_index].dzea001,lo_t_dzer_t[li_arr_curr].dzer004) RETURNING ls_dzer004
        LET lo_t_dzer_t[li_arr_curr].dzer004 = ls_dzer004
        DISPLAY lo_t_dzer_t[li_arr_curr].dzer004 TO lbl_dzer004

      AFTER FIELD lbl_dzer004
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_null_by_table(m_dzea_t[mi_dzea_index].dzea001,lo_t_dzer_t[li_arr_curr].dzer004) THEN
            NEXT FIELD CURRENT
         END IF
         #End:2015/10/01 by Hiko

     #多語言table
      ON ACTION controlp INFIELD lbl_dzer005
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.where = " dzeal001 LIKE '%l_t' "
        CALL q_dzea002()
        LET g_qryparam.where = ""
        LET lo_t_dzer_t[li_arr_curr].dzer005 = g_qryparam.return1
        DISPLAY lo_t_dzer_t[li_arr_curr].dzer005 TO lbl_dzer005

      #多語言table
      AFTER FIELD lbl_dzer005
        #Begin:2015/10/01 by Hiko
        IF NOT adzi150_chk_table_exist(lo_t_dzer_t[li_arr_curr].dzer005) THEN
           LET lo_t_dzer_t[li_arr_curr].dzer006 = NULL
           LET lo_t_dzer_t[li_arr_curr].dzer008 = NULL
           LET lo_t_dzer_t[li_arr_curr].dzer007 = NULL
           NEXT FIELD CURRENT
        #End:2015/10/01 by Hiko
        ELSE 
           CALL adzi150_set_multilang_field(lo_t_dzer_t[li_arr_curr].dzer005) 
           RETURNING lo_t_dzer_t[li_arr_curr].dzer006,
                     lo_t_dzer_t[li_arr_curr].dzer008,
                     lo_t_dzer_t[li_arr_curr].dzer007
        END IF

      ON ACTION controlp INFIELD lbl_dzer006
        CALL adzi150_sfo_set_field_order(lo_t_dzer_t[li_arr_curr].dzer005,lo_t_dzer_t[li_arr_curr].dzer006) RETURNING ls_dzer006
        LET lo_t_dzer_t[li_arr_curr].dzer006 = ls_dzer006
        DISPLAY lo_t_dzer_t[li_arr_curr].dzer006 TO lbl_dzer006
     
      AFTER FIELD lbl_dzer006
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_null_by_table(lo_t_dzer_t[li_arr_curr].dzer005,lo_t_dzer_t[li_arr_curr].dzer006) THEN
            NEXT FIELD CURRENT
         END IF
         #End:2015/10/01 by Hiko

      ON ACTION controlp INFIELD lbl_dzer008
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.arg1 = lo_t_dzer_t[li_arr_curr].dzer005
        CALL q_dzeb003()
        LET lo_t_dzer_t[li_arr_curr].dzer008 = g_qryparam.return1
        DISPLAY lo_t_dzer_t[li_arr_curr].dzer008 TO lbl_dzer008

      AFTER FIELD lbl_dzer008
         #Begin:2015/10/01 by Hiko
         IF NOT cl_null(lo_t_dzer_t[li_arr_curr].dzer008) THEN
            IF NOT adzi150_chk_field_exist(lo_t_dzer_t[li_arr_curr].dzer005, lo_t_dzer_t[li_arr_curr].dzer008, TRUE) THEN 
               NEXT FIELD CURRENT
            END IF
         END IF
         #End:2015/10/01 by Hiko

      ON ACTION controlp INFIELD lbl_dzer007
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.arg1 = lo_t_dzer_t[li_arr_curr].dzer005
        CALL q_dzeb003()
        LET lo_t_dzer_t[li_arr_curr].dzer007 = g_qryparam.return1
        DISPLAY lo_t_dzer_t[li_arr_curr].dzer007 TO lbl_dzer007

      AFTER FIELD lbl_dzer007
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_exist(lo_t_dzer_t[li_arr_curr].dzer005, lo_t_dzer_t[li_arr_curr].dzer007, TRUE) THEN 
            NEXT FIELD CURRENT
         END IF
         #End:2015/10/01 by Hiko

      ON ROW CHANGE
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_cnt(lo_t_dzer_t[li_arr_curr].dzer004, lo_t_dzer_t[li_arr_curr].dzer006) THEN
            NEXT FIELD lbl_dzer004
         END IF
         #End:2015/10/01 by Hiko

         TRY
            UPDATE DZER_T
               SET DZER003 = lo_t_dzer_t[li_arr_curr].dzer003,
                   DZER004 = lo_t_dzer_t[li_arr_curr].dzer004,
                   DZER005 = lo_t_dzer_t[li_arr_curr].dzer005,
                   DZER006 = lo_t_dzer_t[li_arr_curr].dzer006,
                   DZER007 = lo_t_dzer_t[li_arr_curr].dzer007,
                   DZER008 = lo_t_dzer_t[li_arr_curr].dzer008,
                   DZERSTUS = g_env
             WHERE DZER001 = m_dzea_t[mi_dzea_index].dzea001
               AND DZER002 = lo_t_dzer_t[li_arr_curr].dzer002   
         CATCH
            CALL FGL_WINMESSAGE("ERROR", "UPDATE DZER_T : "||SQLCA.SQLCODE, "stop")
         END TRY
        
      AFTER INSERT
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_cnt(lo_t_dzer_t[li_arr_curr].dzer004, lo_t_dzer_t[li_arr_curr].dzer006) THEN
            NEXT FIELD lbl_dzer004
         END IF
         #End:2015/10/01 by Hiko

         TRY
            INSERT INTO DZER_T(
                              DZER001,DZER002,DZER003,DZER004,DZER005,
                              DZER006,DZER007,DZER008,DZERSTUS
                              )
                       VALUES (
                              m_dzea_t[mi_dzea_index].dzea001,lo_t_dzer_t[li_arr_curr].dzer002,li_arr_curr,lo_t_dzer_t[li_arr_curr].dzer004,lo_t_dzer_t[li_arr_curr].dzer005,
                              lo_t_dzer_t[li_arr_curr].dzer006 ,lo_t_dzer_t[li_arr_curr].dzer007,lo_t_dzer_t[li_arr_curr].dzer008,g_env
                              )
         CATCH
            CALL FGL_WINMESSAGE("ERROR", "INSERT DZER_T : "||SQLCA.SQLCODE, "stop")
         END TRY

      ON ACTION btn_MultilangDelete
         IF cl_ask_del_detail() THEN
            IF NOT lb_duplicate THEN #這可以避免已經重複的情況下刪除2筆資料的情況.
               TRY 
                  DELETE FROM DZER_T 
                   WHERE DZER001 = m_dzea_t[mi_dzea_index].dzea001
                     AND DZER002 = lo_t_dzer_t[li_arr_curr].dzer002
               
                  CALL adzi150_fill_dzer_t(m_dzea_t[mi_dzea_index].dzea001)
               CATCH
                 CALL FGL_WINMESSAGE("ERROR", "DELETE DZER_T : "||SQLCA.SQLCODE, "stop")
               END TRY  
            END IF
         END IF

    END INPUT

    ON ACTION btn_MultilangCancel
      CALL adzi150_fill_dzer_t(m_dzea_t[mi_dzea_index].dzea001)
      EXIT DIALOG

    ON ACTION btn_MultilangConfirm
      ACCEPT DIALOG 
      
    ON ACTION CLOSE
      EXIT DIALOG 

    AFTER DIALOG
      CALL adzi150_gen_tbl_file()

  END DIALOG
  
END FUNCTION

#修改 Reference 的資料
FUNCTION adzi150_modify_reference_data()
DEFINE 
  lo_t_dzef_t    DYNAMIC ARRAY OF T_DZEF_T,
  li_rec_cnt     INTEGER,
  ls_main_table  STRING,
  ls_main_module STRING,
  li_arr_curr    INTEGER, 
  ls_dzef003     STRING, 
  ls_dzef007     STRING,
  l_cnt          LIKE type_t.num5, 
  l_nxt_row      LIKE type_t.num5,
  lb_can_delete  BOOLEAN,
  li_idx        SMALLINT,
  lb_duplicate  BOOLEAN

  DIALOG ATTRIBUTES(UNBUFFERED)

    INPUT ARRAY lo_t_dzef_t FROM sr_tablereference.* ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE ROW
         LET li_arr_curr = ARR_CURR()
        ##Begin:2015/10/01 by Hiko:客製環境不可以刪除標準資料
        #LET lb_can_delete = adzi150_can_delete(m_dzea_t[mi_dzea_index].dzea001, lo_t_dzef_t[li_arr_curr].dzef002)
        #CALL cl_set_act_visible("btn_ReferenceDelete", lb_can_delete)
        ##End:2015/10/01 by Hiko         

      BEFORE INPUT
        LET lo_t_dzef_t.* = m_dzef_t.*
        CALL DIALOG.setActionHidden("insert",TRUE)
        CALL DIALOG.setActionHidden("append",TRUE)
        CALL DIALOG.setActionHidden("delete",TRUE)

      #依附欄位名稱
      ON ACTION controlp INFIELD lbl_dzef002
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.arg1 = m_dzea_t[mi_dzea_index].dzea001
        CALL q_dzeb003()
        LET lo_t_dzef_t[li_arr_curr].dzef002 = g_qryparam.return1
        DISPLAY lo_t_dzef_t[li_arr_curr].dzef002 TO lbl_dzef002

      #依附欄位名稱
      AFTER FIELD lbl_dzef002
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_exist(m_dzea_t[mi_dzea_index].dzea001, lo_t_dzef_t[li_arr_curr].dzef002, FALSE) THEN 
            NEXT FIELD CURRENT
         ELSE
            #判斷是否重複
            LET lb_duplicate = FALSE
            FOR li_idx=1 TO lo_t_dzef_t.getLength()
               IF li_idx<>li_arr_curr THEN
                  IF lo_t_dzef_t[li_arr_curr].dzef002=lo_t_dzef_t[li_idx].dzef002 THEN
                     LET lb_duplicate = TRUE
                     EXIT FOR
                  END IF
               END IF
            END FOR
    
            IF lb_duplicate THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00042"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF

            IF cl_null(lo_t_dzef_t[li_arr_curr].dzef003) THEN
               #對應傳值設定要帶依附欄位為預設值
               LET lo_t_dzef_t[li_arr_curr].dzef003 = lo_t_dzef_t[li_arr_curr].dzef002
            END IF
         END IF        
         #End:2015/10/01 by Hiko

      #對應值設定
      ON ACTION controlp INFIELD lbl_dzef003
         CALL adzi150_sfo_set_field_order(m_dzea_t[mi_dzea_index].dzea001,lo_t_dzef_t[li_arr_curr].dzef003) RETURNING ls_dzef003
         LET lo_t_dzef_t[li_arr_curr].dzef003 = ls_dzef003
         DISPLAY lo_t_dzef_t[li_arr_curr].dzef003 TO lbl_dzef003

      AFTER FIELD lbl_dzef003
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_null_by_table(m_dzea_t[mi_dzea_index].dzea001, lo_t_dzef_t[li_arr_curr].dzef003) THEN
            NEXT FIELD CURRENT
         END IF
         #End:2015/10/01 by Hiko

      #資料參考table
      ON ACTION controlp INFIELD lbl_dzef006
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        CALL q_dzea002()
        LET lo_t_dzef_t[li_arr_curr].dzef006 = g_qryparam.return1
        DISPLAY lo_t_dzef_t[li_arr_curr].dzef006 TO lbl_dzef006

      #資料參考table
      AFTER FIELD lbl_dzef006
        #Begin:2015/10/01 by Hiko
        IF NOT adzi150_chk_table_exist(lo_t_dzef_t[li_arr_curr].dzef006) THEN
           LET lo_t_dzef_t[li_arr_curr].dzef007 = NULL
           LET lo_t_dzef_t[li_arr_curr].dzef008 = NULL
           LET lo_t_dzef_t[li_arr_curr].dzef009 = NULL
           NEXT FIELD CURRENT
        #End:2015/10/01 by Hiko
        ELSE 
           CALL adzi150_set_multilang_field(lo_t_dzef_t[li_arr_curr].dzef006) 
                                            RETURNING lo_t_dzef_t[li_arr_curr].dzef007,
                                                      lo_t_dzef_t[li_arr_curr].dzef009,
                                                      lo_t_dzef_t[li_arr_curr].dzef008
        END IF

      #資料參考FK
      ON ACTION controlp INFIELD lbl_dzef007
        CALL adzi150_sfo_set_field_order(lo_t_dzef_t[li_arr_curr].dzef006,lo_t_dzef_t[li_arr_curr].dzef007) RETURNING ls_dzef007
        LET lo_t_dzef_t[li_arr_curr].dzef007 = ls_dzef007
        DISPLAY lo_t_dzef_t[li_arr_curr].dzef007 TO lbl_dzef007

      AFTER FIELD lbl_dzef007
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_null_by_table(lo_t_dzef_t[li_arr_curr].dzef006,lo_t_dzef_t[li_arr_curr].dzef007) THEN
            NEXT FIELD CURRENT
         END IF
         #End:2015/10/01 by Hiko

      #資料參考語系
      ON ACTION controlp INFIELD lbl_dzef009
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.arg1 = lo_t_dzef_t[li_arr_curr].dzef006
        CALL q_dzeb003()
        LET lo_t_dzef_t[li_arr_curr].dzef009 = g_qryparam.return1
        DISPLAY lo_t_dzef_t[li_arr_curr].dzef009 TO lbl_dzef009

      #資料參考語系
      AFTER FIELD lbl_dzef009
         #Begin:2015/10/01 by Hiko
         IF NOT cl_null(lo_t_dzef_t[li_arr_curr].dzef009) THEN
            IF NOT adzi150_chk_field_exist(lo_t_dzef_t[li_arr_curr].dzef006, lo_t_dzef_t[li_arr_curr].dzef009, TRUE) THEN 
               NEXT FIELD CURRENT
            END IF
         END IF
         #End:2015/10/01 by Hiko

      #資料參考回傳
      ON ACTION controlp INFIELD lbl_dzef008
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.arg1 = lo_t_dzef_t[li_arr_curr].dzef006
        CALL q_dzeb003()
        LET lo_t_dzef_t[li_arr_curr].dzef008 = g_qryparam.return1
        DISPLAY lo_t_dzef_t[li_arr_curr].dzef008 TO lbl_dzef008

      #資料參考回傳
      AFTER FIELD lbl_dzef008
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_exist(lo_t_dzef_t[li_arr_curr].dzef006, lo_t_dzef_t[li_arr_curr].dzef008, TRUE) THEN 
            NEXT FIELD CURRENT
         END IF
         #End:2015/10/01 by Hiko

      ON ROW CHANGE
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_cnt(lo_t_dzef_t[li_arr_curr].dzef003, lo_t_dzef_t[li_arr_curr].dzef007) THEN
            NEXT FIELD lbl_dzef003
         END IF
         #End:2015/10/01 by Hiko

         TRY
           UPDATE DZEF_T
              SET DZEF003 = lo_t_dzef_t[li_arr_curr].dzef003,
                  DZEF004 = lo_t_dzef_t[li_arr_curr].dzef004,
                  DZEF005 = lo_t_dzef_t[li_arr_curr].dzef005,
                  DZEF006 = lo_t_dzef_t[li_arr_curr].dzef006,
                  DZEF007 = lo_t_dzef_t[li_arr_curr].dzef007,
                  DZEF008 = lo_t_dzef_t[li_arr_curr].dzef008,
                  DZEF009 = lo_t_dzef_t[li_arr_curr].dzef009,
                  DZEFSTUS = g_env
            WHERE DZEF001 = m_dzea_t[mi_dzea_index].dzea001
              AND DZEF002 = lo_t_dzef_t[li_arr_curr].dzef002
              AND (DZEF010 = lo_t_dzef_t[li_arr_curr].dzef010 OR DZEF010 IS NULL)   
         CATCH
           CALL FGL_WINMESSAGE("ERROR", "UPDATE DZEF_T : "||SQLCA.SQLCODE, "stop")
         END TRY  
        
      AFTER INSERT
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_cnt(lo_t_dzef_t[li_arr_curr].dzef003, lo_t_dzef_t[li_arr_curr].dzef007) THEN
            NEXT FIELD lbl_dzef003
         END IF
         #End:2015/10/01 by Hiko

         TRY
            INSERT INTO DZEF_T(
                                DZEF001,DZEF002,DZEF003,DZEF004,DZEF005,
                                DZEF006,DZEF007,DZEF008,DZEF009,DZEF010,DZEFSTUS
                              )
                       VALUES (
                                m_dzea_t[mi_dzea_index].dzea001,lo_t_dzef_t[li_arr_curr].dzef002,lo_t_dzef_t[li_arr_curr].dzef003,lo_t_dzef_t[li_arr_curr].dzef004,lo_t_dzef_t[li_arr_curr].dzef005,
                                lo_t_dzef_t[li_arr_curr].dzef006,lo_t_dzef_t[li_arr_curr].dzef007,lo_t_dzef_t[li_arr_curr].dzef008,lo_t_dzef_t[li_arr_curr].dzef009,li_arr_curr,g_env
                              )
         CATCH
           CALL FGL_WINMESSAGE("ERROR", "INSERT DZEF_T : "||SQLCA.SQLCODE, "stop")
         END TRY  

      ON ACTION btn_ReferenceDelete
         IF cl_ask_del_detail() THEN
            IF NOT lb_duplicate THEN #這可以避免已經重複的情況下刪除2筆資料的情況.
               TRY 
                  DELETE FROM DZEF_T 
                   WHERE DZEF001 = m_dzea_t[mi_dzea_index].dzea001
                     AND DZEF002 = lo_t_dzef_t[li_arr_curr].dzef002
               
                  CALL adzi150_fill_dzef_t(m_dzea_t[mi_dzea_index].dzea001)
               CATCH
                 CALL FGL_WINMESSAGE("ERROR", "DELETE DZEF_T : "||SQLCA.SQLCODE, "stop")
               END TRY  
            END IF
         END IF
      
    END INPUT

    ON ACTION btn_ReferenceCancel
      CALL adzi150_fill_dzef_t(m_dzea_t[mi_dzea_index].dzea001)
      EXIT DIALOG

    ON ACTION btn_ReferenceConfirm
      ACCEPT DIALOG
      
    ON ACTION CLOSE
      EXIT DIALOG 

    AFTER DIALOG
      CALL adzi150_gen_tbl_file()

  END DIALOG

END FUNCTION

#修改 Remember 的資料
FUNCTION adzi150_modify_remember_data()
DEFINE 
  lo_t_dzet_t    DYNAMIC ARRAY OF T_DZET_T,
  li_rec_cnt     INTEGER,
  ls_main_table  STRING,
  ls_main_module STRING,
  ls_dzet004     STRING,
  li_arr_curr    LIKE type_t.num5, 
  l_cnt          LIKE type_t.num5, 
  lb_can_delete  BOOLEAN,
  li_idx        SMALLINT,
  lb_duplicate  BOOLEAN
  
  DIALOG ATTRIBUTES(UNBUFFERED) 
    
    INPUT ARRAY lo_t_dzet_t FROM sr_tableremember.* ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE ROW
         LET  li_arr_curr = ARR_CURR()
        ##Begin:2015/10/01 by Hiko:客製環境不可以刪除標準資料
        #LET lb_can_delete = adzi150_can_delete(m_dzea_t[mi_dzea_index].dzea001, lo_t_dzet_t[li_arr_curr].dzet002)
        #CALL cl_set_act_visible("btn_RememberDelete", lb_can_delete)
        ##End:2015/10/01 by Hiko         
      
      BEFORE INPUT
        LET lo_t_dzet_t.* = m_dzet_t.*
        CALL DIALOG.setActionHidden("insert",TRUE)
        CALL DIALOG.setActionHidden("append",TRUE)
        CALL DIALOG.setActionHidden("delete",TRUE)

      #欄位名稱
      ON ACTION controlp INFIELD lbl_dzet002
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.arg1  = m_dzea_t[mi_dzea_index].dzea001
        CALL q_dzeb002_2()
        LET lo_t_dzet_t[li_arr_curr].dzet002 = g_qryparam.return1
        DISPLAY lo_t_dzet_t[li_arr_curr].dzet002 TO lbl_dzet002

      #欄位名稱
      AFTER FIELD lbl_dzet002
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_exist(m_dzea_t[mi_dzea_index].dzea001, lo_t_dzet_t[li_arr_curr].dzet002, FALSE) THEN 
            NEXT FIELD CURRENT
         ELSE
            #判斷是否重複
            LET lb_duplicate = FALSE
            FOR li_idx=1 TO lo_t_dzet_t.getLength()
               IF li_idx<>li_arr_curr THEN
                  IF lo_t_dzet_t[li_arr_curr].dzet002=lo_t_dzet_t[li_idx].dzet002 THEN
                     LET lb_duplicate = TRUE
                     EXIT FOR
                  END IF
               END IF
            END FOR
    
            IF lb_duplicate THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00042"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
         END IF
         #End:2015/10/01 by Hiko

      #助記碼Table
      ON ACTION controlp INFIELD lbl_dzet003
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.where = ""
        CALL q_dzea002()
        LET lo_t_dzet_t[li_arr_curr].dzet003 = g_qryparam.return1
        DISPLAY lo_t_dzet_t[li_arr_curr].dzet003 TO lbl_dzet003

      #助記碼Table
      AFTER FIELD lbl_dzet003
        #Begin:2015/10/01 by Hiko
        IF NOT adzi150_chk_table_exist(lo_t_dzet_t[li_arr_curr].dzet003) THEN
           NEXT FIELD CURRENT
        END IF
        #End:2015/10/01 by Hiko

      #助記碼搜尋欄位
      ON ACTION controlp INFIELD lbl_dzet004
        CALL adzi150_sfo_set_field_order(lo_t_dzet_t[li_arr_curr].dzet003,lo_t_dzet_t[li_arr_curr].dzet004) RETURNING ls_dzet004
        LET lo_t_dzet_t[li_arr_curr].dzet004 = ls_dzet004
        DISPLAY lo_t_dzet_t[li_arr_curr].dzet004 TO lbl_dzet004

      AFTER FIELD lbl_dzet004
         #Begin:2015/10/01 by Hiko
         IF NOT adzi150_chk_field_null_by_table(lo_t_dzet_t[li_arr_curr].dzet003, lo_t_dzet_t[li_arr_curr].dzet004) THEN
            NEXT FIELD CURRENT
         END IF
         #End:2015/10/01 by Hiko

      #助記碼欄位
      ON ACTION controlp INFIELD lbl_dzet005
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.arg1  = lo_t_dzet_t[li_arr_curr].dzet003 
        CALL q_dzeb002_2()
        LET lo_t_dzet_t[li_arr_curr].dzet005 = g_qryparam.return1
        DISPLAY lo_t_dzet_t[li_arr_curr].dzet005 TO lbl_dzet005

      #助記碼欄位
      AFTER FIELD lbl_dzet005
         #Begin:2015/10/01 by Hiko
         IF NOT cl_null(lo_t_dzet_t[li_arr_curr].dzet005) THEN
            IF NOT adzi150_chk_field_exist(lo_t_dzet_t[li_arr_curr].dzet003, lo_t_dzet_t[li_arr_curr].dzet005, TRUE) THEN 
               NEXT FIELD CURRENT
            END IF
         END IF
         #End:2015/10/01 by Hiko

      #助記碼語系
      ON ACTION controlp INFIELD lbl_dzet006
        INITIALIZE g_qryparam.* TO NULL 
        LET g_qryparam.state = 'i'
        LET g_qryparam.reqry = FALSE
        LET g_qryparam.arg1  = lo_t_dzet_t[li_arr_curr].dzet003 
        CALL q_dzeb002_2()
        LET lo_t_dzet_t[li_arr_curr].dzet006 = g_qryparam.return1
        DISPLAY lo_t_dzet_t[li_arr_curr].dzet006 TO lbl_dzet006

      #助記碼語系
      AFTER FIELD lbl_dzet006
         #Begin:2015/10/01 by Hiko
         IF NOT cl_null(lo_t_dzet_t[li_arr_curr].dzet006) THEN
            IF NOT adzi150_chk_field_exist(lo_t_dzet_t[li_arr_curr].dzet003, lo_t_dzet_t[li_arr_curr].dzet006, TRUE) THEN 
               NEXT FIELD CURRENT
            END IF
         END IF
         #End:2015/10/01 by Hiko
        
      ON ROW CHANGE #UPDATE
         TRY
           UPDATE DZET_T
              SET DZET003 = lo_t_dzet_t[li_arr_curr].dzet003,
                  DZET004 = lo_t_dzet_t[li_arr_curr].dzet004,
                  DZET005 = lo_t_dzet_t[li_arr_curr].dzet005,
                  DZET006 = lo_t_dzet_t[li_arr_curr].dzet006,
                  DZET007 = lo_t_dzet_t[li_arr_curr].dzet007,
                  DZETSTUS = g_env
            WHERE DZET001 = m_dzea_t[mi_dzea_index].dzea001
              AND DZET002 = lo_t_dzet_t[li_arr_curr].dzet002   
         
         CATCH
           CALL FGL_WINMESSAGE("ERROR", "UPDATE DZET_T : "||SQLCA.SQLCODE, "stop")
         END TRY  
        
      AFTER INSERT
         TRY
           INSERT INTO DZET_T(
                               DZET001,DZET002,DZET003,DZET004,DZET005,
                               DZET006,DZET007,DZETSTUS
                             )
                      VALUES (
                               m_dzea_t[mi_dzea_index].dzea001,lo_t_dzet_t[li_arr_curr].dzet002,lo_t_dzet_t[li_arr_curr].dzet003,lo_t_dzet_t[li_arr_curr].dzet004,lo_t_dzet_t[li_arr_curr].dzet005,
                               lo_t_dzet_t[li_arr_curr].dzet006,lo_t_dzet_t[li_arr_curr].dzet007,g_env
                             )
         CATCH
           CALL FGL_WINMESSAGE("ERROR", "INSERT DZET_T : "||SQLCA.SQLCODE, "stop")
         END TRY  

      ON ACTION btn_RememberDelete
         IF cl_ask_del_detail() THEN
            IF NOT lb_duplicate THEN #這可以避免已經重複的情況下刪除2筆資料的情況.
               TRY 
                  DELETE FROM DZET_T 
                   WHERE DZET001 = m_dzea_t[mi_dzea_index].dzea001
                     AND DZET002 = lo_t_dzet_t[li_arr_curr].dzet002
               
                  CALL adzi150_fill_dzet_t(m_dzea_t[mi_dzea_index].dzea001)
               CATCH
                 CALL FGL_WINMESSAGE("ERROR", "DELETE DZET_T : "||SQLCA.SQLCODE, "stop")
               END TRY  
            END IF
         END IF

    END INPUT

    ON ACTION btn_RememberCancel
      CALL adzi150_fill_dzet_t(m_dzea_t[mi_dzea_index].dzea001)
      EXIT DIALOG

    ON ACTION btn_RememberConfirm
       ACCEPT DIALOG

    ON ACTION CLOSE
      EXIT DIALOG 

    AFTER DIALOG
      CALL adzi150_gen_tbl_file()

  END DIALOG
  
END FUNCTION

#修改狀態碼分類值設定的資料
FUNCTION adzi150_modify_status_type()
   DEFINE li_rec_cnt      LIKE type_t.num5,
          li_counts       LIKE type_t.num5,
          li_arr_curr     LIKE type_t.num5, 
          l_cnt           LIKE type_t.num5, 
          l_cb_text       STRING,
          lo_combobox     ui.combobox
   DEFINE g_gzcc_valid_old T_VALID #備份舊值用
   DEFINE l_str STRING
   DEFINE l_gzcc002 LIKE gzcc_t.gzcc002
   DEFINE l_gzcc003 LIKE gzcc_t.gzcc003
   DEFINE l_ac      LIKE type_t.num5
   DEFINE l_i       LIKE type_t.num5
   DEFINE lb_flag   BOOLEAN #2014/10/08 by Hiko
   #Begin:2015/06/24 by Hiko
   DEFINE ls_sql   STRING,
          la_prog  DYNAMIC ARRAY OF RECORD
                   dzag001 LIKE dzag_t.dzag001,
                   progname LIKE gzzal_t.gzzal003
                   END RECORD,
          li_idx   SMALLINT,
          lsb_prog base.StringBuffer
   #End:2015/06/24 by Hiko
   #Begin:2015/11/09 by Hiko
   DEFINE ls_run_cmd    STRING,
          lb_run_result BOOLEAN,
          ls_run_msg    STRING
   #End:2015/11/09 by Hiko

   LET lo_combobox = ui.combobox.forName("formonly.cb_systemtypecode")

   #判斷combox預設值
   FOR l_cnt = 1 TO lo_combobox.getItemCount()
      LET l_cb_text = lo_combobox.getItemText(l_cnt)

      #判斷combox預設值的規則
      IF l_cb_text MATCHES m_gzcc_t[1].gzcc003||". *" THEN
         LET g_sys_type_code = lo_combobox.getItemName(l_cnt)
         EXIT FOR
      END IF
   END FOR

   DISPLAY g_sys_type_code TO cb_systemtypecode

   DIALOG ATTRIBUTES(UNBUFFERED) 

      INPUT g_sys_type_code FROM cb_systemtypecode ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            DISPLAY g_sys_type_code TO cb_systemtypecode

         ON CHANGE cb_systemtypecode
            CALL m_gzcc_t.clear()
            #清空有效系統分類值群組
            CALL g_gzcc_valid.clear()
            #清空在無效系統分類值群組
            CALL g_gzcc_no_valid.clear()
            #及時更新新的系統分類碼到無效系統分類值群組,自動排除已經存在在無效系統分類值群組和有效系統分類值群組內的系統分類值
            CALL adzi150_fill_g_gzcc_no_valid(g_sys_type_code)
                        
      END INPUT
    
      INPUT ARRAY g_gzcc_no_valid FROM sr_status_no_valid.* ATTRIBUTE(WITHOUT DEFAULTS,AUTO APPEND = FALSE)
         BEFORE ROW
            LET l_ac = ARR_CURR()
      
         ON ROW CHANGE
             DISPLAY g_gzcc_no_valid[l_ac].* TO sr_status_no_valid[l_ac].*

         ON CHANGE lbl_select #左邊(失效)
            #程式簽核pattern中將狀態碼［W送簽中 / A已核准 / D抽單 / R已拒絕］四組狀態認定為簽核過程中，
            #皆需要具備的簽核流程狀態，在r.t挑選狀態碼設定時，就綁定在一起，只可同時全選或全不選 
            LET l_cnt = 0
            SELECT COUNT(1) INTO l_cnt FROM dzej_t 
               WHERE dzej001="stus_type_group1" AND 
                     dzej002=g_gzcc_no_valid[l_ac].gzcc004
            IF l_cnt > 0 THEN
               FOR l_i=1 TO g_gzcc_no_valid.getLength()
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM dzej_t 
                     WHERE dzej001="stus_type_group1" AND 
                           dzej002=g_gzcc_no_valid[l_i].gzcc004
                  IF l_cnt > 0 THEN
                     LET g_gzcc_no_valid[l_i].checkbox = g_gzcc_no_valid[l_ac].checkbox
                  END IF
               END FOR
            END IF 
            
         BEFORE INPUT
           
      END INPUT

      INPUT ARRAY g_gzcc_valid FROM sr_status_valid.* ATTRIBUTE(WITHOUT DEFAULTS,AUTO APPEND = FALSE)
         BEFORE ROW
            LET l_ac = ARR_CURR()
            
         ON ROW CHANGE
            DISPLAY g_gzcc_valid[l_ac].* TO sr_status_valid[l_ac].*

         ON CHANGE lbl_select1 #右邊:生效
            #程式簽核pattern中將狀態碼［W送簽中 / A已核准 / D抽單 / R已拒絕］四組狀態認定為簽核過程中，
            #皆需要具備的簽核流程狀態，在r.t挑選狀態碼設定時，就綁定在一起，只可同時全選或全不選 
            #2014.04.22 Ernest 解除此項限制
            #2014.05.14 Ernest 還原此項限制
            #Begin:2014/10/08 by Hiko
            LET lb_flag = TRUE
            IF g_env="c" THEN
               IF g_gzcc_valid[l_ac].gzcc005 = "s" THEN
                  LET g_gzcc_valid[l_ac].checkbox = "N"
                  LET lb_flag = FALSE
               END IF
            END IF
            #End:2014/10/08 by Hiko
            IF lb_flag THEN
               LET l_cnt = 0
               
               SELECT COUNT(1) 
                 INTO l_cnt 
                 FROM dzej_t 
                WHERE dzej001="stus_type_group1" 
                  AND dzej002=g_gzcc_valid[l_ac].gzcc004
                  
               IF l_cnt > 0 THEN
                  FOR l_i=1 TO g_gzcc_valid.getLength()
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt FROM dzej_t 
                        WHERE dzej001="stus_type_group1" AND 
                              dzej002=g_gzcc_valid[l_i].gzcc004
                     IF l_cnt > 0 THEN
                        LET g_gzcc_valid[l_i].checkbox = g_gzcc_valid[l_ac].checkbox
                     END IF
                        
                  END FOR
               END IF 
            END IF
           
         BEFORE INPUT

      END INPUT

      ON ACTION btn_status_type_cancel
         #重新從資料庫載入資料
         CALL adzi150_fill_gzcc_t(m_dzea_t[mi_dzea_index].dzea001)
         EXIT DIALOG

      ON ACTION btn_status_type_confirm
         LET m_dzea_t[mi_dzea_index].dzea004 = m_dzea_t[mi_dzea_index].dzea004 CLIPPED

         #以下的表格型態需要至少一個有效的系統分類值
         IF m_dzea_t[mi_dzea_index].dzea004 = "M" OR
            m_dzea_t[mi_dzea_index].dzea004 = "B" OR
            m_dzea_t[mi_dzea_index].dzea004 = "P" OR
            m_dzea_t[mi_dzea_index].dzea004 = "H" OR
            m_dzea_t[mi_dzea_index].dzea004 = "T" THEN

           IF g_gzcc_valid.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00227"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = m_dzea_t[mi_dzea_index].dzea001
               LET g_errparam.replace[2] = m_dzea_t[mi_dzea_index].dzea004
               CALL cl_err()
               NEXT FIELD lbl_select
            END IF

         END IF
   
         BEGIN WORK

         DELETE FROM gzcc_t WHERE gzcc001 = m_dzea_t[mi_dzea_index].dzea001

         LET l_str = m_dzea_t[mi_dzea_index].dzea001
         LET l_str = l_str.subString(1,l_str.getLength()-2)
         LET l_str = l_str,"stus"
         LET l_gzcc002 = l_str
         LET l_gzcc003 = g_sys_type_code
         
         FOR li_rec_cnt = 1 TO g_gzcc_no_valid.getLength()
            TRY
               #Begin:2014/10/08 by Hiko
               IF g_gzcc_no_valid[li_rec_cnt].modi="Y" THEN
                  INSERT INTO gzcc_t(gzcc001,gzcc002,gzcc003,gzcc004,gzcc006,gzccstus,gzcc005) 
                              VALUES(m_dzea_t[mi_dzea_index].dzea001,l_gzcc002,l_gzcc003,g_gzcc_no_valid[li_rec_cnt].gzcc004,"","N",g_env) 
               #End:2014/10/08 by Hiko
               ELSE 
                  INSERT INTO gzcc_t(gzcc001,gzcc002,gzcc003,gzcc004,gzcc006,gzccstus,gzcc005) 
                              VALUES(m_dzea_t[mi_dzea_index].dzea001,l_gzcc002,l_gzcc003,g_gzcc_no_valid[li_rec_cnt].gzcc004,"","N",g_gzcc_no_valid[li_rec_cnt].gzcc005)
               END IF
            CATCH
               CALL FGL_WINMESSAGE("ERROR", "UPDATE gzcc_t for no valid : "||SQLCA.SQLCODE, "stop")
            END TRY  
         END FOR

         FOR li_rec_cnt = 1 TO g_gzcc_valid.getLength()
            TRY
               #Begin:2014/10/08 by Hiko
               IF g_gzcc_valid[li_rec_cnt].modi="Y" THEN
                  INSERT INTO gzcc_t(gzcc001,gzcc002,gzcc003,gzcc004,gzcc006,gzccstus,gzcc005) 
                              VALUES(m_dzea_t[mi_dzea_index].dzea001,l_gzcc002,l_gzcc003,g_gzcc_valid[li_rec_cnt].gzcc004,li_rec_cnt,"Y",g_env)
               #End:2014/10/08 by Hiko
               ELSE
                  INSERT INTO gzcc_t(gzcc001,gzcc002,gzcc003,gzcc004,gzcc006,gzccstus,gzcc005) 
                              VALUES(m_dzea_t[mi_dzea_index].dzea001,l_gzcc002,l_gzcc003,g_gzcc_valid[li_rec_cnt].gzcc004,li_rec_cnt,"Y",g_gzcc_valid[li_rec_cnt].gzcc005)
               END IF
            CATCH
               CALL FGL_WINMESSAGE("ERROR", "UPDATE gzcc_t for valid: "||SQLCA.SQLCODE, "stop")
            END TRY  
         END FOR

         COMMIT WORK
         
         #重新從資料庫載入資料
         CALL adzi150_fill_gzcc_t(m_dzea_t[mi_dzea_index].dzea001)

         #Begin:2015/11/09 by Hiko : 大概取得清單即可.
         ##Begin:2015/06/24 by Hiko : 提醒有用到SCC的程式清單.
         #LET lsb_prog = base.StringBuffer.create()
         #LET ls_sql = "SELECT DISTINCT dzag001, progname as gzzal003",
         #             "  FROM dzag_t",
         #             " INNER JOIN (SELECT progid, progname",
         #             "               FROM (SELECT gzza001 progid, gzzal003 progname", #取得主程式
         #             "                       FROM gzza_t",
         #             "                       LEFT JOIN gzzal_t ON gzzal001 = gzza001 AND gzzal002 = ?",
         #             "                      WHERE gzza002 IN ('I','M','T')",
         #             "                     UNION",
         #             "                     SELECT gzde001 progid, gzdel003 progname",
         #             "                       FROM gzde_t",
         #             "                       LEFT JOIN gzdel_t ON gzdel001 = gzde001 AND gzdel002 = ?",
         #             "                      WHERE gzde003 = 'S'", #取得子程式
         #             "                        AND gzde005 IN ('I','M','T'))) data",
         #             "    ON dzag001 = data.progid",
         #             " WHERE dzag002 = ? AND dzagstus='Y'",
         #             " ORDER BY 1"
         ##DISPLAY "ls_sql=",ls_sql
         #PREPARE prep_dzag FROM ls_sql
         #DECLARE curs_dzag CURSOR FOR prep_dzag
         #OPEN curs_dzag USING g_lang,g_lang,m_dzea_t[mi_dzea_index].dzea001
         #LET li_idx = 1
         #FOREACH curs_dzag INTO la_prog[li_idx].*
         #   IF lsb_prog.getLength()>0 THEN
         #      CALL lsb_prog.append(",")
         #   END IF
         #   
         #   CALL lsb_prog.append(la_prog[li_idx].dzag001 CLIPPED)
         
         #   LET li_idx = li_idx + 1
         #END FOREACH
         
         #IF lsb_prog.getLength()>0 THEN
         #   INITIALIZE g_errparam TO NULL
         #   LET g_errparam.code = "adz-00642"
         #   LET g_errparam.replace[1] = m_dzea_t[mi_dzea_index].dzea001
         #   LET g_errparam.replace[2] = lsb_prog.toString()
         #   LET g_errparam.popup = TRUE
         #   CALL cl_err()
         #END IF
         ##End:2015/06/24 by Hiko

         CALL adzi150_scc_prog()
         #End:2015/11/09 by Hiko

         EXIT DIALOG
      
      ON ACTION CLOSE
         EXIT DIALOG 

      ON ACTION add_valid_item
         
         FOR l_cnt =1 TO g_gzcc_no_valid.getLength()
            IF g_gzcc_no_valid[l_cnt].checkbox = "Y" THEN
               CALL g_gzcc_valid.appendElement()
               LET g_gzcc_no_valid[l_cnt].checkbox = "N"
               LET g_gzcc_no_valid[l_cnt].gzcc005 = g_env #2014/10/08 by Hiko
               LET g_gzcc_no_valid[l_cnt].modi = "Y" #2014/10/08 by Hiko
               LET g_gzcc_valid[g_gzcc_valid.getLength()].* = g_gzcc_no_valid[l_cnt].*
               CALL g_gzcc_no_valid.deleteElement(l_cnt)
               LET l_cnt = l_cnt-1
            END IF
         END FOR

      ON ACTION add_no_valid_item
         #Begin:2014/12/25 by Hiko
         LET lb_flag = TRUE
         FOR l_cnt =1 TO g_gzcc_valid.getLength()
            IF g_gzcc_valid[l_cnt].checkbox = "Y" THEN
               IF g_gzcc_valid[l_cnt].gzcc004="Y" OR
                  g_gzcc_valid[l_cnt].gzcc004="N" THEN
                  IF NOT cl_ask_confirm_parm("adz-00484","") THEN
                     LET lb_flag = FALSE
                     EXIT FOR
                  END IF
               END IF
            END IF
         END FOR
         #End:2014/12/25 by Hiko
     
         IF lb_flag THEN #2014/12/25 by Hiko
            FOR l_cnt =1 TO g_gzcc_valid.getLength()
               IF g_gzcc_valid[l_cnt].checkbox = "Y" THEN
                  CALL g_gzcc_no_valid.appendElement()
                  LET g_gzcc_valid[l_cnt].checkbox = "N"
                  #2014/10/08 by Hiko:因為客戶不能移除標準,所以可以移除的話,一定是還原為標準
                  #另外,正常應該是要判斷此SCC值是否為客戶自己加上去的,但因為不影響操作正確性,所以就算是誤植為s的失效也是沒關係的.
                  LET g_gzcc_valid[l_cnt].gzcc005 = "s" #2014/10/08 by Hiko
                  LET g_gzcc_valid[l_cnt].modi = "N" #2014/10/08 by Hiko
                  LET g_gzcc_no_valid[g_gzcc_no_valid.getLength()].* = g_gzcc_valid[l_cnt].*
                  CALL g_gzcc_valid.deleteElement(l_cnt)
                  LET l_cnt = l_cnt-1
               END IF
            END FOR
         END IF

      ON ACTION check_all_of_no_valid
         FOR l_cnt =1 TO g_gzcc_no_valid.getLength()
            LET g_gzcc_no_valid[l_cnt].checkbox = "Y"
         END FOR

      ON ACTION check_nothing_of_no_valid
         FOR l_cnt =1 TO g_gzcc_no_valid.getLength()
            LET g_gzcc_no_valid[l_cnt].checkbox = "N"
         END FOR

      ON ACTION check_all_of_valid
         FOR l_cnt =1 TO g_gzcc_valid.getLength()
            #Begin:2014/10/08 by Hiko
            IF g_env="c" THEN
               IF g_gzcc_valid[l_cnt].gzcc005 = "s" THEN
                  LET g_gzcc_valid[l_cnt].checkbox = "N"
               ELSE
                  LET g_gzcc_valid[l_cnt].checkbox = "Y"
               END IF
            #End:2014/10/08 by Hiko
            ELSE
               LET g_gzcc_valid[l_cnt].checkbox = "Y"
            END IF
         END FOR

      ON ACTION check_nothing_of_valid
         FOR l_cnt =1 TO g_gzcc_valid.getLength()
            LET g_gzcc_valid[l_cnt].checkbox = "N"
         END FOR

      ON ACTION item_up
         LET l_cnt = DIALOG.getCurrentRow("sr_status_valid")

         IF l_cnt > 1 THEN
            #調換本筆資料和上一筆資料的內容
            LET g_gzcc_valid_old.* = g_gzcc_valid[l_cnt].* #備份本筆資料
            LET g_gzcc_valid[l_cnt].* = g_gzcc_valid[l_cnt-1].*
            LET g_gzcc_valid[l_cnt-1].* = g_gzcc_valid_old.*
         END IF

         #設定focus移到上一筆
         CALL DIALOG.setCurrentRow("sr_status_valid",l_cnt-1)

      ON ACTION item_down
         LET l_cnt = DIALOG.getCurrentRow("sr_status_valid")

         IF l_cnt < g_gzcc_valid.getLength() THEN
            #調換本筆資料和下一筆資料的內容
            LET g_gzcc_valid_old.* = g_gzcc_valid[l_cnt].* #備份本筆資料
            LET g_gzcc_valid[l_cnt].* = g_gzcc_valid[l_cnt+1].*
            LET g_gzcc_valid[l_cnt+1].* = g_gzcc_valid_old.*
         END IF

         #設定focus移到下一筆
         CALL DIALOG.setCurrentRow("sr_status_valid",l_cnt+1)

      BEFORE DIALOG
         #及時更新新的系統分類碼到無效系統分類值群組,自動排除已經存在在無效系統分類值群組和
         #有效系統分類值群組內的系統分類值
         CALL adzi150_fill_g_gzcc_no_valid(g_sys_type_code)
         
   END DIALOG
  
END FUNCTION

FUNCTION adzi150_refresh_master(p_module_name)
DEFINE 
  p_module_name STRING
DEFINE
  lo_combobox   ui.combobox,
  ls_module_name STRING

  LET ls_module_name = p_module_name
  
  LET lo_combobox = ui.combobox.forName("formonly.cb_moduleselect")
  CALL adzi150_fill_combobox(lo_combobox,ms_sql_modules)

  CALL adzi150_fill_dzea_t(ls_module_name)
  CALL adzi150_fill_dzep_t(m_dzea_t[mi_dzea_index].dzea001)
  CALL adzi150_fill_dzeq_t(m_dzea_t[mi_dzea_index].dzea001)
  CALL adzi150_fill_dzer_t(m_dzea_t[mi_dzea_index].dzea001)
  CALL adzi150_fill_dzef_t(m_dzea_t[mi_dzea_index].dzea001)
  CALL adzi150_fill_dzet_t(m_dzea_t[mi_dzea_index].dzea001)
  CALL adzi150_fill_gzcc_t(m_dzea_t[mi_dzea_index].dzea001)
END FUNCTION

FUNCTION adzi150_fill_combobox(p_combobox,p_sql)
DEFINE 
  p_combobox ui.combobox,
  p_sql      STRING
DEFINE
  ls_sql      STRING,
  li_index    INTEGER,
  li_count    INTEGER, 
  ls_combobox RECORD 
                combobox_NAME VARCHAR(50),
                combobox_DESC VARCHAR(255)
              END RECORD  
  
  LET li_index = 0
  LET ls_sql = p_sql
  
  PREPARE lpre_combobox FROM ls_sql
  DECLARE lcur_combobox SCROLL CURSOR FOR lpre_combobox

  CALL p_combobox.clear()
  INITIALIZE ls_combobox.* TO NULL

  LET li_count = 1

  FOREACH lcur_combobox INTO ls_combobox.*  
    IF SQLCA.SQLCODE THEN
      EXIT FOREACH
    END IF
    #Begin:2015/12/04 by Hiko:為了自行開啟adzi150的程式可以預設第一個模組,加快開啟速度.
    IF li_count=1 THEN 
       IF p_combobox.getColumnName()="cb_moduleselect" THEN
          LET g_first_module = ls_combobox.combobox_NAME
       END IF
    END IF
    #End:2015/12/04 by Hiko
    CALL p_combobox.addItem(ls_combobox.combobox_NAME,ls_combobox.combobox_DESC)
    INITIALIZE ls_combobox.* TO NULL
    LET li_count = li_count + 1
  END FOREACH

  FREE lcur_combobox
  FREE lpre_combobox

END FUNCTION

FUNCTION adzi150_fill_dzea_t(p_search_name)
DEFINE
  p_search_name STRING
DEFINE 
  ls_search_name STRING,
  ls_sql         STRING,
  ls_sql_cond    STRING,
  li_count       INTEGER 

  LET ls_search_name = DOWNSHIFT(p_search_name)

  IF ls_search_name IS NULL THEN
    LET ls_sql_cond = " WHERE 1=1 "
  ELSE
    #Begin:2015/12/04 by Hiko
    IF cl_null(ms_table_name) AND cl_null(ms_module) THEN #表示自己開啟程式.
       #這段條件是原本的程式.
       LET ls_sql_cond = " WHERE (DZEA003='",ls_search_name.toUpperCase(),"'       ",
                         "    OR DZEA003 LIKE '%",ls_search_name.toUpperCase(),"%' ", 
                         "    OR DZEA001 LIKE '%",ls_search_name,"%' )             "
 
    ELSE #表示從r.t串過來
       LET ls_sql_cond = " WHERE DZEA001 LIKE '%",ls_search_name,"%'              "
    END IF
    #End:2015/12/04 by Hiko

  END IF 
  
  #Begin:20160329 by elena 標準環境只能查詢到標準表格，行業環境只能查詢到標準和該行業表格
  IF sadzp060_ind_check_area() THEN
     LET ls_sql_cond = ls_sql_cond, " AND DZEA014 in ('sd','", g_topind ,"') "
  ELSE
     #標準環境只能看到標準程式，客製環境可以看到標準和所有行業程式
     IF g_env = 's' THEN 
        LET ls_sql_cond = ls_sql_cond, " AND DZEA014 in ('sd') "
     END IF
  END IF

  LET ls_sql = "SELECT '', '',                         ",
               "       DZEA003,DZEA001,DZEA002,DZEA004,DZEA014 ",  #20160329 by elena 增加DZEA014 for行業判斷
               "  FROM DZEA_T                          ", 
               ls_sql_cond,
               " ORDER BY DZEA003,DZEA001              "
  PREPARE lpre_dzea_t FROM ls_sql
  DECLARE lcur_dzea_t CURSOR FOR lpre_dzea_t

  CALL m_dzea_t.clear()
  
  LET li_count = 1
  
  FOREACH lcur_dzea_t INTO m_dzea_t[li_count].*  
    IF SQLCA.SQLCODE THEN
      EXIT FOREACH
    END IF
    LET m_dzea_t[li_count].dzeaseq = li_count
    LET li_count = li_count + 1
  END FOREACH
  CALL m_dzea_t.deleteElement(li_count)
    
END FUNCTION

FUNCTION adzi150_fill_dzep_t(p_table_name)
DEFINE
  p_table_name STRING  
DEFINE 
  ls_table_name  STRING,
  ls_sql         STRING,
  li_count       INTEGER 

  LET ls_table_name = p_table_name 

  LET ls_sql = "SELECT '','',                                                     ",
               "       EP.DZEP002,EBL.DZEBL003,EBL.DZEBL004,EP.DZEP005,  EP.DZEP009,",
               "       EP.DZEP010,EP.DZEP011,  EP.DZEP012,  EP.DZEP025,  EP.DZEP013,",
               "       EP.DZEP026,EP.DZEP014,  EP.DZEP015,  EP.DZEP016,  EP.DZEP017,",
               "       EP.DZEP018,EP.DZEP019,  EP.DZEP022,  EP.DZEP020,  EP.DZEP021,",
               "       EP.DZEP023,EB.DZEB007,  EB.DZEB008,  EP.DZEPMODID,EP.DZEPMODDT", #160429-00009:增加DZEPMODID,DZEPMODDT
               "  FROM DZEP_T EP                                                  ",
               "       INNER JOIN DZEB_T EB ON EB.DZEB001 = EP.DZEP001            ",
               "                           AND EB.DZEB002 = EP.DZEP002            ",
               "       LEFT JOIN DZEBL_T EBL ON EBL.DZEBL001 = EP.DZEP002         ",   
               "                            AND EBL.DZEBL002 = '",g_lang,"'       ",  
               " WHERE EP.DZEP001 = '",ls_table_name,"'                           ",   
               " ORDER BY EB.DZEB021,EP.DZEP002                                   "

  PREPARE lpre_dzep_t FROM ls_sql
  DECLARE lcur_dzep_t CURSOR FOR lpre_dzep_t

  CALL m_dzep_t.clear()
  
  LET li_count = 1
  
  FOREACH lcur_dzep_t INTO m_dzep_t[li_count].*    
    IF SQLCA.SQLCODE THEN
      EXIT FOREACH
    END IF
    LET m_dzep_t[li_count].dzepseq = li_count
    LET li_count = li_count + 1
  END FOREACH
  CALL m_dzep_t.deleteElement(li_count)

END FUNCTION

FUNCTION adzi150_fill_dzeq_t(p_table_name)
DEFINE
  p_table_name STRING  
DEFINE 
  ls_table_name   STRING,
  ls_sql         STRING,
  li_count       INTEGER 

  LET ls_table_name = p_table_name 

  LET ls_sql = "SELECT '',                                     ",
               "       DZEQ006,DZEQ007,DZEQ008,DZEQ009         ",
               "  FROM DZEQ_T                                  ", 
               " WHERE DZEQ001 = '",ls_table_name, "'           ",
               " ORDER BY DZEQ006,DZEQ007                      "
  
  PREPARE lpre_dzeq_t FROM ls_sql
  DECLARE lcur_dzeq_t CURSOR FOR lpre_dzeq_t

  CALL m_dzeq_t.clear()
  
  LET li_count = 1
  
  FOREACH lcur_dzeq_t INTO m_dzeq_t[li_count].*    
    IF SQLCA.SQLCODE THEN
      EXIT FOREACH
    END IF
    LET li_count = li_count + 1
  END FOREACH
  CALL m_dzeq_t.deleteElement(li_count)

END FUNCTION

FUNCTION adzi150_fill_dzer_t(p_table_name)
DEFINE
  p_table_name STRING  
DEFINE 
  ls_table_name   STRING,
  ls_sql         STRING,
  li_count       INTEGER

  LET ls_table_name = p_table_name 
  
  LET ls_sql = "SELECT '',                                     ",
               "       DZER002,DZER003,DZER004,DZER005,DZER006,",
               "       DZER008,DZER007                         ",
               "  FROM DZER_T                                  ", 
               " WHERE DZER001 = '",ls_table_name, "'           ",
               " ORDER BY DZER002,DZER003                      "
  
  PREPARE lpre_dzer_t FROM ls_sql
  DECLARE lcur_dzer_t CURSOR FOR lpre_dzer_t

  CALL m_dzer_t.clear()
  
  LET li_count = 1
  
  #DISPLAY ls_table_name
  FOREACH lcur_dzer_t INTO m_dzer_t[li_count].*    
    IF SQLCA.SQLCODE THEN
      EXIT FOREACH
    END IF
    
    LET li_count = li_count + 1
  END FOREACH
  CALL m_dzer_t.deleteElement(li_count)

END FUNCTION

FUNCTION adzi150_fill_dzef_t(p_table_name)
DEFINE
  p_table_name STRING  
DEFINE 
  ls_table_name   STRING,
  ls_sql         STRING,
  li_count       INTEGER 

  LET ls_table_name = p_table_name 
  
  LET ls_sql = "SELECT '',                                     ",
               "       DZEF002,DZEF010,DZEF003,DZEF004,DZEF005,",
               "       DZEF006,DZEF007,DZEF009,DZEF008         ",
               "  FROM DZEF_T                                  ", 
               " WHERE DZEF001 = '",ls_table_name, "'           ",
               " ORDER BY DZEF002                              "
  
  PREPARE lpre_dzef_t FROM ls_sql
  DECLARE lcur_dzef_t CURSOR FOR lpre_dzef_t

  CALL m_dzef_t.clear()
  
  LET li_count = 1
  
  #DISPLAY ls_table_name
  FOREACH lcur_dzef_t INTO m_dzef_t[li_count].*    
    IF SQLCA.SQLCODE THEN
      EXIT FOREACH
    END IF
    LET li_count = li_count + 1
  END FOREACH
  CALL m_dzef_t.deleteElement(li_count)

END FUNCTION

FUNCTION adzi150_fill_dzet_t(p_table_name)
DEFINE
  p_table_name STRING  
DEFINE 
  ls_table_name   STRING,
  ls_sql         STRING,
  li_count       INTEGER 

  LET ls_table_name = p_table_name 
  
  LET ls_sql = "SELECT '',                                      ",
               "       DZET002,DZET003,DZET004,DZET005,DZET006, ",
               "       DZET007                                  ",
               "  FROM DZET_T                                   ", 
               " WHERE DZET001 = '",ls_table_name, "'           ",
               " ORDER BY DZET002                               "
  
  PREPARE lpre_dzet_t FROM ls_sql
  DECLARE lcur_dzet_t CURSOR FOR lpre_dzet_t

  CALL m_dzet_t.clear()
  
  LET li_count = 1
  
  FOREACH lcur_dzet_t INTO m_dzet_t[li_count].*    
    IF SQLCA.SQLCODE THEN
      EXIT FOREACH
    END IF
    LET li_count = li_count + 1
  END FOREACH
  CALL m_dzet_t.deleteElement(li_count)

END FUNCTION

#載入狀態碼分類值設定的資料
FUNCTION adzi150_fill_gzcc_t(p_table_name)

  DEFINE p_table_name   LIKE dzea_t.dzea001,  
         ls_table_name  LIKE dzea_t.dzea001,
         ls_sql         STRING,
         li_count       LIKE type_t.num5,
         l_gzcbl004     LIKE gzcbl_t.gzcbl004,
         lo_combobox    ui.combobox,
         #g_sys_type_code STRING,
         l_cb_text      STRING

         
   LET ls_table_name = p_table_name 
  
   LET ls_sql = "SELECT gzcc006,gzccstus,gzcc003,gzcc004,gzcc005 ",
                "  FROM ds.gzcc_t                                ", 
                " WHERE gzcc001 = '",ls_table_name, "'            ",
                " ORDER BY gzcc006, gzcc004                             "

   PREPARE lpre_gzcc_t FROM ls_sql
   DECLARE lcur_gzcc_t CURSOR FOR lpre_gzcc_t

   CALL m_gzcc_t.clear()
   CALL g_gzcc_no_valid.clear()
   CALL g_gzcc_valid.clear()
  
   LET li_count = 1
  
   FOREACH lcur_gzcc_t INTO m_gzcc_t[li_count].* 
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF

      LET  l_gzcbl004 = ""
      #載入說明的多語言(gzcbl_t)
      SELECT gzcbl004 INTO l_gzcbl004 FROM ds.gzcbl_t 
         WHERE gzcbl001= m_gzcc_t[li_count].gzcc003 
           AND gzcbl003 = g_lang 
           AND gzcbl002 = m_gzcc_t[li_count].gzcc004

      IF m_gzcc_t[li_count].gzccstus = "N" THEN
         CALL g_gzcc_no_valid.appendElement()
         LET g_gzcc_no_valid[g_gzcc_no_valid.getLength()].checkbox = "N"
         LET g_gzcc_no_valid[g_gzcc_no_valid.getLength()].gzcc003 = m_gzcc_t[li_count].gzcc003
         LET g_gzcc_no_valid[g_gzcc_no_valid.getLength()].gzcc004 = m_gzcc_t[li_count].gzcc004
         LET g_gzcc_no_valid[g_gzcc_no_valid.getLength()].gzcbl004 = l_gzcbl004
         LET g_gzcc_no_valid[g_gzcc_no_valid.getLength()].gzcc005 = m_gzcc_t[li_count].gzcc005
      END IF

      IF m_gzcc_t[li_count].gzccstus = "Y" THEN
         CALL g_gzcc_valid.appendElement()
         LET g_gzcc_valid[g_gzcc_valid.getLength()].checkbox = "N"
         LET g_gzcc_valid[g_gzcc_valid.getLength()].gzcc003 = m_gzcc_t[li_count].gzcc003
         LET g_gzcc_valid[g_gzcc_valid.getLength()].gzcc004 = m_gzcc_t[li_count].gzcc004
         LET g_gzcc_valid[g_gzcc_valid.getLength()].gzcbl004 = l_gzcbl004
         LET g_gzcc_valid[g_gzcc_valid.getLength()].gzcc005 = m_gzcc_t[li_count].gzcc005
      END IF

      LET li_count = li_count + 1
   END FOREACH
   CALL m_gzcc_t.deleteElement(li_count)

   LET lo_combobox = ui.combobox.forName("formonly.cb_systemtypecode")

   #判斷combox預設值
   FOR li_count = 1 TO lo_combobox.getItemCount()
      LET l_cb_text = lo_combobox.getItemText(li_count)

      #判斷combox預設值的規則
      IF l_cb_text MATCHES m_gzcc_t[1].gzcc003||". *" THEN
         LET g_sys_type_code = lo_combobox.getItemName(li_count)
         EXIT FOR
      ELSE
         LET g_sys_type_code = NULL
      END IF
   END FOR

   DISPLAY g_sys_type_code TO cb_systemtypecode

END FUNCTION

FUNCTION adzi150_fill_g_gzcc_no_valid(p_gzcb001)
  DEFINE p_gzcb001   LIKE gzcb_t.gzcb001,  
         ls_gzcb001 LIKE gzcb_t.gzcb001,
         ls_sql         STRING,
         li_count       LIKE type_t.num5,
         l_wc           STRING

   IF g_gzcc_no_valid.getLength()>0 OR g_gzcc_valid.getLength()>0 THEN
   
      FOR li_count =1 TO g_gzcc_no_valid.getLength()
         LET l_wc = l_wc,"'",g_gzcc_no_valid[li_count].gzcc004,"',"
      END FOR

      FOR li_count =1 TO g_gzcc_valid.getLength()
         LET l_wc = l_wc,"'",g_gzcc_valid[li_count].gzcc004,"',"
      END FOR

      LET l_wc = l_wc.subString(1,l_wc.getLength()-1)
      LET l_wc = "AND gzcb002 NOT IN (", l_wc,")"
   ELSE
      LET l_wc ="AND 1=1"
   END IF

   IF NOT cl_null(p_gzcb001) THEN
      LET ls_gzcb001 = p_gzcb001
      LET ls_sql = "SELECT 'N',gzcb001,gzcb002,gzcbl004,'s' ",
                   " FROM ds.gzcb_t LEFT JOIN ds.gzcbl_t     ", 
                   " ON gzcbl001 = gzcb001 AND gzcbl002 = gzcb002 AND gzcbl003='",g_lang,"'",
                   " WHERE gzcb001 = ",ls_gzcb001," ",l_wc," ORDER BY gzcb002"
      PREPARE lpre_gzcc_no_valid FROM ls_sql
      DECLARE lcur_gzcc_no_valid CURSOR FOR lpre_gzcc_no_valid

      IF g_gzcc_no_valid.getLength()= 0 THEN
         LET li_count = 1
      ELSE 
         LET li_count = g_gzcc_no_valid.getLength()+1
      END IF
      
      FOREACH lcur_gzcc_no_valid INTO g_gzcc_no_valid[li_count].* 
         IF SQLCA.SQLCODE THEN
            EXIT FOREACH
         END IF
        
         LET li_count = li_count + 1
      END FOREACH
      CALL g_gzcc_no_valid.deleteElement(li_count)
   END IF 

END FUNCTION

FUNCTION adzi150_fill_dzeq_arr(p_table_name,p_table_type)
DEFINE
  p_table_name STRING,
  p_table_type STRING
DEFINE 
  li_index        INTEGER,
  li_dzeq_length  INTEGER
DEFINE l_dzea009 LIKE dzea_t.dzea009,
       l_cnt     LIKE type_t.num5

  CALL m_dzeq_t.clear()

  #若Table本身是提速檔, 則不秀 speed
  IF p_table_type.toUpperCase() = "V" THEN
    LET li_dzeq_length = mar_dzeq.getLength() - 2
  ELSE
    LET li_dzeq_length = mar_dzeq.getLength()
  END IF
  
  FOR li_index = 1 TO li_dzeq_length
    LET m_dzeq_t[li_index].dzeq006 = li_index
    #若Table本身是提速檔, 則前面加 s
    IF p_table_type.toUpperCase() = "V" THEN
      LET m_dzeq_t[li_index].dzeq007 = "s",mar_dzeq[li_index]
    ELSE
      LET m_dzeq_t[li_index].dzeq007 = mar_dzeq[li_index]
    END IF  
    
    IF mar_dzeq[li_index] = "pid" OR mar_dzeq[li_index] = "id" OR mar_dzeq[li_index] = "type" THEN
      LET m_dzeq_t[li_index].dzeq008 = p_table_name
    END IF

    IF mar_dzeq[li_index] = "speed" THEN
      LET l_dzea009 = p_table_name
      SELECT COUNT(*) INTO l_cnt FROM dzea_t 
         WHERE dzea009 = l_dzea009 AND dzea004 = 'V'
       
      IF l_cnt > 0 THEN
         SELECT dzea001 INTO m_dzeq_t[li_index].dzeq008 FROM dzea_t 
            WHERE dzea009 = l_dzea009 AND dzea004 = 'V'
      END IF
    END IF
    
    #Begin:2015/10/01 by Hiko:樹狀結構是整個刪除, 所以在一開始就先塞值會比較簡單.
    TRY
       INSERT INTO DZEQ_T(
                           DZEQ001,DZEQ006,DZEQ007,DZEQ008,DZEQ009,DZEQSTUS
                         )
                  VALUES (
                           m_dzea_t[mi_dzea_index].dzea001,li_index,m_dzeq_t[li_index].dzeq007,m_dzeq_t[li_index].dzeq008,m_dzeq_t[li_index].dzeq009,g_env
                         )
    CATCH
       CALL FGL_WINMESSAGE("ERROR", "INSERT DZEQ_T : "||SQLCA.SQLCODE, "stop")
    END TRY
    #End:2015/10/01 by Hiko
  END FOR     
  
END FUNCTION

#重新產生xxx.tbl.
FUNCTION adzi150_gen_tbl_file()
   DEFINE ls_table_name  STRING
   DEFINE ls_module_name STRING
   DEFINE ls_module_env  STRING
   DEFINE ls_tbl_Name    STRING

   LET ls_table_name  = m_dzea_t[mi_dzea_index].dzea001
   LET ls_module_name = m_dzea_t[mi_dzea_index].DZEA003
   LET ls_module_env = FGL_GETENV(ls_module_name)
   LET ls_tbl_Name = os.path.join(os.path.join(os.path.join(os.path.join(ls_module_env, "dzx"),"tbl"), ms_lang), ls_table_name||".tbl")
   CALL sadzi140_xml_gen_table_contents_XML(ls_table_name,ls_tbl_Name,ms_lang)
END FUNCTION

#Begin:2015/10/01 by Hiko
#判斷是否為公用欄位.
FUNCTION adzi150_is_not_common_filed(p_table, p_field)
   DEFINE p_table LIKE dzeb_t.dzeb001,
          p_field LIKE dzeb_t.dzeb002
   DEFINE l_dzeb022  LIKE dzeb_t.dzeb022,
          ls_dzeb022 STRING,
          li_cnt     SMALLINT,
          lb_enabled BOOLEAN

   LET lb_enabled = TRUE

   #公用欄位都不可以改.
   #Begin:2015/11/02 by Hiko
   #SELECT dzeb022 INTO l_dzeb022 FROM dzeb_t WHERE dzeb001=p_table AND dzeb002=p_field
   #LET ls_dzeb022 = l_dzeb022 CLIPPED
   #IF ls_dzeb022.getIndexOf("cdfUserDefine", 1)=0 AND #不是自定義欄位
   #   ls_dzeb022.getIndexOf("cdfSerialNumber", 1)=0 THEN #不是流水號欄位
   #   LET lb_enabled = FALSE 
   #END IF

   SELECT COUNT(*) INTO li_cnt FROM dzeb_t
    WHERE dzeb001=p_table AND dzeb002=p_field
      AND dzeb022 NOT IN (SELECT dzej003 FROM dzej_t WHERE dzej001='adzi150_dzep_std')
   IF li_cnt=0 THEN #欄位是屬於公用欄位.
      LET lb_enabled = FALSE
   END IF
   #End:2015/11/02 by Hiko

   RETURN lb_enabled
END FUNCTION

#判斷是否可以刪除標準設定.
FUNCTION adzi150_can_delete(p_table, p_field)
   DEFINE p_table LIKE dzeb_t.dzeb001,
          p_field LIKE dzeb_t.dzeb002
   DEFINE l_dzeb030     LIKE dzeb_t.dzeb030,
          lb_can_delete BOOLEAN

   LET lb_can_delete = TRUE

   IF g_env='c' THEN #客製環境才要判斷
      LET lb_can_delete = FALSE #客製環境預設不可以改
      IF p_field CLIPPED="dzeq_t" THEN #只有樹狀設定才傳遞dzeq_t.
         SELECT dzea018 INTO l_dzeb030 FROM dzea_t WHERE dzea001=p_table #共用l_dzeb030這個變數,不用介意.
         LET lb_can_delete = (l_dzeb030='c')
      ELSE #傳遞欄位名稱
         SELECT dzeb030 INTO l_dzeb030 FROM dzeb_t WHERE dzeb001=p_table AND dzeb002=p_field
         LET lb_can_delete = (l_dzeb030='c')
      END IF
   END IF

   RETURN lb_can_delete
END FUNCTION

#判斷欄位對應個數是否相一致.
FUNCTION adzi150_chk_field_cnt(p_field1, p_field2)
   DEFINE p_field1 STRING,
          p_field2 STRING
   DEFINE l_tok1    base.StringTokenizer,
          l_tok2    base.StringTokenizer,
          lb_result BOOLEAN

   LET lb_result = TRUE
   LET l_tok1 = base.StringTokenizer.create(p_field1, ",")
   LET l_tok2 = base.StringTokenizer.create(p_field2, ",")
   IF l_tok1.countTokens()<>l_tok2.countTokens() THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00714"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET lb_result = FALSE
   END IF

   RETURN lb_result
END FUNCTION

#判斷欄位是否存在.
FUNCTION adzi150_chk_field_exist(p_table, p_field, p_allow_NULL)
   DEFINE p_table      LIKE dzeb_t.dzeb001,
          p_field      LIKE dzeb_t.dzeb002,
          p_allow_NULL BOOLEAN #是否允許空白
   DEFINE lb_result BOOLEAN 

   LET lb_result = TRUE
   IF NOT cl_null(p_field) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = p_table
      LET g_chkparam.arg2 = p_field
      IF NOT cl_chk_exist("v_dzeb002") THEN
         LET lb_result = FALSE
      END IF
   ELSE
      IF p_allow_NULL THEN
         LET lb_result = adzi150_chk_field_null_by_table(p_table, p_field)
      ELSE
         LET lb_result = FALSE
      END IF
   END IF

   RETURN lb_result
END FUNCTION

#有條件地判斷欄位是否為空.
FUNCTION adzi150_chk_field_null_by_table(p_table, p_field)
   DEFINE p_table LIKE dzeb_t.dzeb001,
          p_field LIKE dzeb_t.dzeb002
   DEFINE lb_result BOOLEAN 

   LET lb_result = TRUE
   IF NOT cl_null(p_table) THEN #若欄位對應的Table不是NULL, 則欄位本身也不可為NULL.
      IF cl_null(p_field) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "azz-00736" #此欄位不可空白,請輸入資料！
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET lb_result = FALSE
      END IF
   END IF

   RETURN lb_result
END FUNCTION

#檢查Table是否存在, 並判斷Table是否為空.
FUNCTION adzi150_chk_table_exist(p_table)
   DEFINE p_table LIKE dzea_t.dzea001
   DEFINE lb_result BOOLEAN 

   LET lb_result = TRUE
   IF NOT cl_null(p_table) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = p_table
      IF NOT cl_chk_exist("v_dzea001_1") THEN
         LET lb_result = FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "azz-00736" #此欄位不可空白,請輸入資料！
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET lb_result = FALSE
   END IF

   RETURN lb_result
END FUNCTION
#End:2015/10/01 by Hiko

PRIVATE FUNCTION adzi150_scc_prog()
   DEFINE ls_cmd  STRING         
   DEFINE l_ch    base.Channel
   DEFINE ls_line STRING
   DEFINE li_idx  SMALLINT
 
   LET ls_cmd = "r.r adzp144 ",m_dzea_t[mi_dzea_index].dzea001," 2>&1"
   LET l_ch = base.Channel.create()
   CALL l_ch.setDelimiter("")
   CALL l_ch.openPipe(ls_cmd,"r") #執行指令
   
   WHILE TRUE
      CALL l_ch.readLine() RETURNING ls_line
      IF l_ch.isEof() THEN
         EXIT WHILE
      END IF
 
      DISPLAY ls_line #顯示背景訊息
      LET li_idx = ls_line.getIndexOf("NEEDREGEN", 1)
      IF li_idx>0 THEN
         LET ls_line = ls_line.subString(li_idx+10, ls_line.getLength())
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00642"
         LET g_errparam.replace[1] = m_dzea_t[mi_dzea_index].dzea001
         LET g_errparam.replace[2] = ls_line
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT WHILE
      END IF
   END WHILE

   CALL l_ch.close()
END FUNCTION

#Begin:160429-00009
#顯現SCC/狀態碼有影響的程式清單.
PRIVATE FUNCTION adzi150_show_scc_prog(p_sql, p_replace)
   DEFINE p_sql     STRING,
          p_replace STRING
   DEFINE li_idx  SMALLINT,
          la_prog DYNAMIC ARRAY OF RECORD
                  progid LIKE dzag_t.dzag001
                  END RECORD,
          ls_prog STRING
 
   PREPARE dzag_prep FROM p_sql
   DECLARE dzag_curs CURSOR FOR dzag_prep
   LET li_idx = 1
   FOREACH dzag_curs INTO la_prog[li_idx].*
      IF li_idx=1 THEN
         LET ls_prog = la_prog[li_idx].progid
      ELSE
         LET ls_prog = ls_prog,", ",la_prog[li_idx].progid
      END IF
      
      LET li_idx = li_idx + 1
   END FOREACH

   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = "adz-00642"
   LET g_errparam.replace[1] = p_replace
   LET g_errparam.replace[2] = ls_prog
   LET g_errparam.popup = TRUE
   CALL cl_err()
END FUNCTION
#End:160429-00009
