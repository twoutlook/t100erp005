#該程式已解開Section, 不再透過樣板產出!
{<section id="azzp990.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000005
#+ 
#+ Filename...: azzp990
#+ Description: 參數批次作業
#+ Creator....: 01856(2014/08/11)
#+ Modifier...: 00000(2013/01/01) -SD/PR- 01856
#+ Buildtype..: 應用 p01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="azzp990.global" >}

 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable)
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="azzp990.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define
   DEFINE lc_gzsz001 LIKE gzsz_t.gzsz001   #表格編號  
   DEFINE lc_type    LIKE type_t.chr1      #參數表種類
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
   LET g_bgjob = "Y"
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js
   LET lc_gzsz001 = g_argv[1]   #參數編號
   LET lc_type = g_argv[2]      #參數等級  A 系統級  E 企業級 S 據點級
 
   IF lc_type IS NULL THEN
      CALL azzp990_msg()
   ELSE
      CALL azzp990_ins_parameter(lc_gzsz001,lc_type)
   END IF
   #end add-point
 
#   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
#      CALL azzp990_process(ls_js)
#   ELSE
      #畫面開啟 (identifier)
#      OPEN WINDOW w_azzp990 WITH FORM cl_ap_formpath("azz",g_code)
# 
#      #瀏覽頁簽資料初始化
#      CALL cl_ui_init()
# 
#      #程式初始化
#      CALL azzp990_init()
# 
#      #進入選單 Menu (="N")
#      CALL azzp990_ui_dialog()
 
      #add-point:畫面關閉前

      #end add-point
#      #畫面關閉
#      CLOSE WINDOW w_azzp990
#   END IF
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="azzp990.init" >}
#+ 初始化作業
PRIVATE FUNCTION azzp990_init()
   #add-point:init段define

   #end add-point
 
#   LET g_error_show = 1
#   LET gwin_curr2 = ui.Window.getCurrent()
#   LET gfrm_curr2 = gwin_curr2.getForm()
#   CALL cl_schedule_import_4fd()
#   CALL cl_set_combo_scc("gzpa003","75")
#   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
#       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
#   END IF 
   #add-point:畫面資料初始化

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzp990.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzp990_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define
   
   #end add-point
 
   #add-point:ui_dialog段before dialog
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         
      
         #add-point:ui_dialog段construct
         
         #end add-point
         #add-point:ui_dialog段input
         
         #end add-point
         #add-point:ui_dialog段自定義display array
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL azzp990_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog
            
            #end add-point
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL azzp990_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET lc_param.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後
               
               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION batch_execute
            ACCEPT DIALOG
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE lc_param.* TO NULL
            #add-point:ui_dialog段qbeclear
            
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action
         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #add-point:ui_dialog段exit dialog
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         #LET g_jobid = cl_schedule_get_jobid(g_prog)
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL azzp990_process(ls_js)
            WHEN g_schedule.gzpa003 = "1"
            #    CALL cl_schedule_update_data(g_jobid,ls_js)
                 LET ls_js = azzp990_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="azzp990.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION azzp990_transfer_argv(ls_js)
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog     STRING,
             param    DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
 
   CALL util.JSON.parse(ls_js,la_param)
 
   LET la_cmdrun.prog = g_prog
   #add-point:transfer.argv段define
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="azzp990.process" >}
#+ 資料處理
PRIVATE FUNCTION azzp990_process(ls_js)
   DEFINE ls_js       STRING
   DEFINE lc_param    type_parameter
   DEFINE li_stus     LIKE type_t.num5
   DEFINE li_count    LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql      STRING             #主SQL
   #add-point:process段define

   #end add-point
 
   CALL util.JSON.parse(ls_js,lc_param)
 
   #add-point:process段前處理

   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress

      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE azzp990_process_cs CURSOR FROM ls_sql
#  FOREACH azzp990_process_cs INTO
   #add-point:process段process

   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理

      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理

      #end add-point
   END IF
END FUNCTION
 
{</section>}
 
{<section id="azzp990.get_buffer" >}
PRIVATE FUNCTION azzp990_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzp990.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp990_msg()
   DISPLAY "INFO:  r.r azzp990 參數編號  參數表種類"
   DISPLAY "Sample:r.r azzp990 E-SYS-0011  E"
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp990_ins_parameter(lc_gzsz001,lc_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp990_ins_parameter(lc_gzsz001,lc_type)
  DEFINE lc_gzsz001 LIKE gzsz_t.gzsz001   #表格編號  
   DEFINE lc_type    LIKE type_t.chr1      #參數表種類
   DEFINE lc_ooef001 LIKE ooef_t.ooef001   #營運據點(表)
   DEFINE l_array    DYNAMIC ARRAY OF RECORD
            gzou001  LIKE gzou_t.gzou001,  #企業編號(表)
            gzou003  LIKE gzou_t.gzou003   #實體資料庫
                     END RECORD
   DEFINE li_cnt     LIKE type_t.num5

   CASE
      WHEN lc_type = "A" #系統級,直接呼叫即可
         CALL azzp990_ins_data(lc_gzsz001,lc_type,"","")

      WHEN lc_type = "E" #企業級,FOREACH企業資料呼叫即可
         DECLARE azzp990_ins_param_gzou1_cs CURSOR FOR
          SELECT gzou001,gzou003 FROM gzou_t
           WHERE gzoustus = "Y"
           ORDER BY gzou001

         LET li_cnt = 1
         #列出所有enterprise
         FOREACH azzp990_ins_param_gzou1_cs INTO l_array[li_cnt].gzou001,l_array[li_cnt].gzou003
            LET li_cnt = li_cnt + 1
         END FOREACH
         CALL l_array.deleteElement(li_cnt)

         FOR li_cnt = 1 TO l_array.getLength()
            #gzou003:本號主資料庫
            CALL cl_db_connect(l_array[li_cnt].gzou003,TRUE)
            #新增一筆參數，所有enterprise 加一筆 
            CALL azzp990_ins_data(lc_gzsz001,lc_type,l_array[li_cnt].gzou001,"")
         END FOR

      WHEN lc_type = "S" #據點級,FOREACH企業資料,據點資料,呼叫
         DECLARE azzp990_ins_param_gzou2_cs CURSOR FOR
          SELECT gzou001,gzou003 FROM gzou_t
           WHERE gzoustus = "Y"
           ORDER BY gzou001

         LET li_cnt = 1
         #列出所有enterprise
         FOREACH azzp990_ins_param_gzou2_cs INTO l_array[li_cnt].gzou001,l_array[li_cnt].gzou003
            LET li_cnt = li_cnt + 1
         END FOREACH
         CALL l_array.deleteElement(li_cnt)

         FOR li_cnt = 1 TO l_array.getLength()
            #gzou003:本號主資料庫
	    CALL cl_db_connect(l_array[li_cnt].gzou003,TRUE)

            DECLARE azzp990_ins_param_ooef1_cs CURSOR FOR
             SELECT ooef001 FROM ooef_t
              WHERE ooefent = l_array[li_cnt].gzou001
                AND ooefstus = "Y"
              ORDER BY ooef001
            #抓取site
            FOREACH azzp990_ins_param_ooef1_cs INTO lc_ooef001
               #新增一筆參數，所有site 加一筆
               IF lc_ooef001 IS NOT NULL THEN
                  CALL azzp990_ins_data(lc_gzsz001,lc_type,l_array[li_cnt].gzou001,lc_ooef001)
               END IF
            END FOREACH
            CLOSE azzp990_ins_param_ooef1_cs
            FREE azzp990_ins_param_ooef1_cs
         END FOR
   END CASE

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp990_ins_data(lc_gzsz001,lc_type,li_enterprise,lc_site)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION azzp990_ins_data(lc_gzsz001,lc_type,li_enterprise,lc_site)
   DEFINE lc_gzsz001    LIKE gzsz_t.gzsz001   #表格編號  
   DEFINE lc_tableid    LIKE gzsz_t.gzsz001   #表格字首 (_t前面的)
   DEFINE lc_gzsz002    LIKE gzsz_t.gzsz002   #參數編號
   DEFINE lc_gzsz008    LIKE gzsz_t.gzsz008   #預設值
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE lc_type       LIKE type_t.chr1      #參數表種類
   DEFINE li_enterprise LIKE type_t.num5   #企業編號
   DEFINE lc_site       LIKE type_t.chr10  #營運據點
   DEFINE ls_sql        STRING
   DEFINE ls_sql2       STRING

   #找出表格字首
   LET ls_sql = lc_gzsz001 CLIPPED
   LET lc_tableid = ls_sql.subString(1,ls_sql.getIndexOf("_t",1)-1)

   #定義PRAPARED SQL
   #抓取目標table筆數
   CASE
      WHEN lc_type = "A"  #系統級 gzsz_t
         LET ls_sql = "SELECT COUNT(*) FROM ",lc_gzsz001 CLIPPED,
                      " WHERE ",lc_tableid,"001 = ? "
      WHEN lc_type = "E"  #企業級 ooaa_t
         LET ls_sql = "SELECT COUNT(*) FROM ",lc_gzsz001 CLIPPED,
                      " WHERE ",lc_tableid,"ent = '",li_enterprise USING "<<<<<","' ",
                        " AND ",lc_tableid,"001 = ? "
      WHEN lc_type = "S"  #據點級 ooab_t
         LET ls_sql = "SELECT COUNT(*) FROM ",lc_gzsz001 CLIPPED,
                      " WHERE ",lc_tableid,"ent = '",li_enterprise USING "<<<<<","' ",
                        " AND ",lc_tableid,"site = '",lc_site CLIPPED,"' ",
                        " AND ",lc_tableid,"001 = ? "
      WHEN lc_type = "D"  #單據級
   END CASE
   PREPARE s1 FROM ls_sql

   #寫回目標table
   CASE
      WHEN lc_type = "A"  
         LET ls_sql = "INSERT INTO ",
                       lc_gzsz001 CLIPPED," (",lc_tableid,"001,",lc_tableid,"002) ",
                      "VALUES ( ?,? ) "
      WHEN lc_type = "E"  #企業級
         LET ls_sql = "INSERT INTO ",
                       lc_gzsz001 CLIPPED," (",lc_tableid,"ent,", lc_tableid,"001, ",lc_tableid,"002) ",
                      "VALUES (",
                       li_enterprise USING "<<<<<",",?,?) "
      WHEN lc_type = "S"  #據點級
         LET ls_sql = "INSERT INTO ",
                       lc_gzsz001 CLIPPED," (",lc_tableid,"ent,",lc_tableid,"site,",
                                                                 lc_tableid,"001, ",lc_tableid,"002) ",
                      "VALUES (",
                       li_enterprise USING "<<<<<",",'",lc_site CLIPPED,"',? ,?) "
      WHEN lc_type = "D"  #單據級
   END CASE
   PREPARE s2 FROM ls_sql

   #開始進行單一table參數值的寫入
   DECLARE azzp990_ins_ent_cs CURSOR FOR
    SELECT gzsz002,gzsz008 FROM gzsz_t
     WHERE gzsz001 = lc_gzsz001
     ORDER BY gzsz002

   FOREACH azzp990_ins_ent_cs INTO lc_gzsz002,lc_gzsz008
      EXECUTE s1 USING lc_gzsz002 INTO li_cnt
      #項目不存在的時候給予新增
      IF li_cnt = 0 THEN
         EXECUTE s2 USING lc_gzsz002,lc_gzsz008
      ELSE
      END IF
   END FOREACH

   FREE s1
   FREE s2
END FUNCTION

#end add-point
 
{</section>}
 
