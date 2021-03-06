#該程式已解開Section, 不再透過樣板產出!
{<section id="asfp370.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-10-26 15:22:08), PR版次:0008(2017-01-10 09:35:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000058
#+ Filename...: asfp370
#+ Description: 發料前調撥作業
#+ Creator....: 00768(2014-07-01 14:03:22)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="asfp370.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150106 增加拨入库储选项
#160727-00019#18   2016/08/04 By 08734     临时表长度超过15码的减少到15码以下 p370_01_lock_b_t ——> asfp370_tmp01,asfp370_02_temp3 ——> asfp370_tmp03
#160706-00037#10   2016/10/26 By shiun     引導式作業調整的作法:進行到第二步時，針對勾選的資料中若有被別人處理中的單據提示"單據編號OOO+項次XX被其他使用者處理中"
#160706-00037#13   2016/11/14 By lienjunqi     整批加上
#                                          1.檢查第一步勾選的資料有沒有被別人處理中，測試資料有沒有被別人LOCK的EXECUTE前要先把變數清空
#                                          2.若排除掉被別人處理中的資料後，本次沒有需要處理的資料，l_where應補上1=2條件而非1=1
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
IMPORT FGL asf_asfp370_01
IMPORT FGL asf_asfp370_02
IMPORT FGL asf_asfp370_03
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
#GLOBALS "../4gl/asfp370_01.inc"
#GLOBALS "../4gl/asfp370_02.inc"
#GLOBALS "../4gl/asfp370_03.inc"
GLOBALS "../../asf/4gl/asfp370.inc"
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE li_step              LIKE type_t.num5
DEFINE gwin_curr            ui.Window
DEFINE gfrm_curr            ui.Form
DEFINE g_forupd_sql         STRING
DEFINE g_error_show         LIKE type_t.num5

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="asfp370.main" >}
#+ 作業開始
MAIN
   #add-point:main段define
   DEFINE l_success     LIKE type_t.num5
   #end add-point    
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("asf","")
 
   #add-point:作業初始化
   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0028') RETURNING g_ref_unit  #是否启用参考单位
   #end add-point
 
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE asfp370_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfp370 WITH FORM cl_ap_formpath("asf",g_code)
   
      #程式初始化
      CALL asfp370_init()
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      ##進入選單 Menu (='N')
      #CALL asfp370_ui_dialog()
      
      #建立各程式的temp table
      CALL asfp370_01_create_temp_table() RETURNING l_success
      IF NOT l_success THEN
         #dorislai-20150914-modify----(S)
#         EXIT PROGRAM
         CALL cl_ap_exitprogram("1")
         #dorislai-20150914-modify----(E)
      END IF
      CALL asfp370_02_create_temp_table() RETURNING l_success
      IF NOT l_success THEN
         #dorislai-20150914-modify----(S)
#         EXIT PROGRAM
         CALL cl_ap_exitprogram("1")
         #dorislai-20150914-modify----(E)
      END IF
      LET li_step = 1
      IF l_success THEN
         WHILE TRUE
            CASE li_step
               WHEN 1
                  CALL asfp370_ui_dialog_step1() RETURNING li_step
               WHEN 2
                  CALL asfp370_ui_dialog_step2() RETURNING li_step
               WHEN 3
                  CALL asfp370_ui_dialog_step3() RETURNING li_step
               WHEN 0
                  EXIT WHILE
               OTHERWISE
                  EXIT WHILE
            END CASE
         END WHILE
      END IF
 
      CALL asfp370_01_drop_temp_table() RETURNING l_success
      CALL asfp370_02_drop_temp_table() RETURNING l_success
   
      #畫面關閉
      CLOSE WINDOW w_asfp370
   END IF
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="asfp370.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION asfp370_init()
   #add-point:init段define

   #end add-point

   LET g_error_show  = 1


   #add-point:畫面資料初始化
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   #畫面嵌入
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp370_01"), "main_grid01", "VBox", "master")
   CALL asfp370_01_init()        #asfp370_01的畫面預設

   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp370_02"), "main_grid02", "VBox", "master")
   CALL asfp370_02_init()        #asfp370_02的畫面預設

   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp370_03"), "main_grid03", "VBox", "master")
   CALL asfp370_03_init()        #asfp370_03的畫面預設


   #先將嵌入的畫面都隱藏
   CALL cl_set_comp_visible("group_progress",FALSE)
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)

   #add-point:畫面資料初始化
   #CALL cl_set_combo_scc_part('pmdl005','2052','1,2')
   IF NOT cl_null(g_argv[1]) THEN
      LET g_sfdcdocno_01 = g_argv[1]
   END IF
   #end add-point

END FUNCTION
#第一步
PRIVATE FUNCTION asfp370_ui_dialog_step1()
   DEFINE l_cnt              LIKE type_t.num5
   DEFINE l_success          LIKE type_t.num5
   #add--160706-00037#10 By shiun--(S)
   DEFINE l_sql              STRING
   DEFINE l_sfdcdocno        LIKE sfdc_t.sfdcdocno
   DEFINE l_sfdcseq          LIKE sfdc_t.sfdcseq  
   DEFINE l_sfdc001          LIKE sfdc_t.sfdc001  
   DEFINE l_sfdc002          LIKE sfdc_t.sfdc002  
   DEFINE l_sfdc003          LIKE sfdc_t.sfdc003  
   DEFINE l_docno     LIKE sfdc_t.sfdcdocno
   DEFINE l_seq       LIKE sfdc_t.sfdcseq
   DEFINE l_sfdc001_2 LIKE sfdc_t.sfdc001
   DEFINE l_sfdc002_2 LIKE sfdc_t.sfdc002
   DEFINE l_sfdc003_2 LIKE sfdc_t.sfdc003
   #add--160706-00037#10 By shiun--(E)
   
   CLEAR FORM
   #INITIALIZE g_wc_01 TO NULL
   #CALL g_sfdc01_d.clear()

   #設定左方的流程圖  
   CALL gfrm_curr.setElementImage("step01","32/step01on.png")    #有on的是顏色不同的圖  
   CALL gfrm_curr.setElementImage("step02","32/step02.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",TRUE)       #將第一步的畫面顯示  
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)

   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("save",FALSE)              #收貨資料寫入 (使用於第一步)  
   CALL cl_set_comp_visible("back_step",FALSE)        #回上一步     (第一步,第四步不使用)
   CALL cl_set_comp_visible("next_step",TRUE)         #下一步       (第四步不使用) 
   CALL cl_set_comp_visible("continue",FALSE)         #處理其他資料 (使用於第四步) 

   #LET l_items = cl_getmsg('aqc-989',g_dlang)
   #CALL cl_set_comp_att_text("tc_qcs001",l_items CLIPPED)
   #CALL cl_set_comp_visible("delete_data,return_step01",FALSE) 
   
   #mark--160706-00037#6   2016/10/26 By shiun--(S)
#   #160120-00002#9 s983961--add(s)   
#   #開啟transaction 
#   CALL s_transaction_begin()
#   #160120-00002#9 s983961--add(e)
   #mark--160706-00037#6   2016/10/26 By shiun--(E)
   
   CALL asfp370_01_b_fill()
   LET g_asfp370_01_m.rdo_sel = '1'  #add 150106
   CALL cl_set_comp_entry("inaa001,inab002",FALSE)
   CALL cl_set_comp_required("inab002",FALSE)
   
   LET g_action_choice = ''
   WHILE TRUE

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         SUBDIALOG asf_asfp370_01.asfp370_01_construct
         SUBDIALOG asf_asfp370_01.asfp370_01_input0   #add 150106
         SUBDIALOG asf_asfp370_01.asfp370_01_input
         
         BEFORE DIALOG
            
         ON ACTION continue
         
         ON ACTION back_step
            
         ON ACTION next_step
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM asfp370_01_temp WHERE sel = 'Y'
            IF l_cnt > 0 THEN
               CALL asfp370_01_save()
               #add--160706-00037#10 By shiun--(S)
               CALL s_transaction_begin()
               
               CALL cl_err_collect_init()
               
               LET l_sql = "SELECT sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003 ",
                           "  FROM asfp370_tmp01 ",
                           " ORDER BY sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003 "
               PREPARE p370_chk_lock_prep FROM l_sql
               DECLARE p370_chk_lock_curs CURSOR WITH HOLD FOR p370_chk_lock_prep
               
               LET l_sql = "SELECT sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003 ",
                           "  FROM sfdc_t ",
                           " WHERE sfdcent = '",g_enterprise,"' ",
                           "   AND sfdcdocno = ? ",
                           "   AND sfdcseq   = ? ",
                           "   AND sfdc001  = ? ",
                           "   AND sfdc002  = ? ",
                           "   AND sfdc003  = ? ",
                           "   FOR UPDATE SKIP LOCKED "
               PREPARE p370_test_lock_prep FROM l_sql
               
               LET l_sfdcdocno = ''   LET l_sfdcseq   = ''
               LET l_sfdc001   = ''   LET l_sfdc002   = ''
               LET l_sfdc003   = ''
               FOREACH p370_chk_lock_curs INTO l_sfdcdocno,l_sfdcseq,l_sfdc001,l_sfdc002,l_sfdc003
                  LET l_docno = ''   LET l_seq   = ''
                  LET l_sfdc001_2   = ''   
                  LET l_sfdc002_2   = ''
                  LET l_sfdc003_2   = ''
                  EXECUTE p370_test_lock_prep USING l_sfdcdocno,l_sfdcseq,l_sfdc001,l_sfdc002,l_sfdc003
                                               INTO l_docno,l_seq,l_sfdc001_2,l_sfdc002_2,l_sfdc003_2
                  IF cl_null(l_docno) OR cl_null(l_seq) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'apm-01117' 
                     LET g_errparam.popup  = TRUE
                     LET g_errparam.replace[1] = l_sfdcdocno
                     LET g_errparam.replace[2] = l_sfdcseq
               
                     CALL cl_err()
               
                     DELETE FROM asfp370_01_temp
                      WHERE sfdcdocno = l_sfdcdocno
                        AND sfdcseq   = l_sfdcseq
                        AND sfdc001  = l_sfdc001
                        AND sfdc002  = l_sfdc002
                        AND sfdc003  = l_sfdc003
               
                     DELETE FROM asfp370_tmp01
                      WHERE sfdcdocno = l_sfdcdocno
                        AND sfdcseq   = l_sfdcseq
                        AND sfdc001  = l_sfdc001
                        AND sfdc002  = l_sfdc002
                        AND sfdc003  = l_sfdc003
               
                  END IF
               
                  LET l_sfdcdocno = ''   LET l_sfdcseq   = ''
                  LET l_sfdc001   = ''   LET l_sfdc002   = ''
                  LET l_sfdc003   = ''
               END FOREACH
               
               CALL cl_err_collect_show()
               
               CALL s_transaction_end('Y','0')
               #add--160706-00037#10 By shiun--(E)
               CALL asfp370_02_insert_asfp370_02_temp2() RETURNING l_success
               IF l_success THEN
                  LET g_action_choice = "next_step"
                  EXIT DIALOG
               END IF
            ELSE
               #拟调拨料号中没有选择要处理的资料,請先選擇要處理的資料!
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00355'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            
         ON ACTION step01
               
         ON ACTION step02
         
         ON ACTION step03

         ON ACTION CLOSE
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
            
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF 

      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
   
   #mark--160706-00037#6   2016/10/26 By shiun--(S)
#   #160120-00002#1 s983961--add(s)   
#   CALL s_transaction_end('Y','0')
#   #160120-00002#1 s983961--add(e) 
   #mark--160706-00037#6   2016/10/26 By shiun--(E)
   
   CASE g_action_choice
      WHEN "next_step"
         LET g_action_choice = ''
         RETURN 2
      OTHERWISE
         RETURN 0
   END CASE

END FUNCTION

#第二步
PRIVATE FUNCTION asfp370_ui_dialog_step2()
   DEFINE l_cnt              LIKE type_t.num5
   DEFINE l_success          LIKE type_t.num5
   #160120-00002#9 s983961--add(s)   
   DEFINE l_sql              STRING
   DEFINE l_where            STRING
   DEFINE l_sfdcdocno        LIKE sfdc_t.sfdcdocno
   DEFINE l_sfdcseq          LIKE sfdc_t.sfdcseq  
   DEFINE l_sfdc001          LIKE sfdc_t.sfdc001  
   DEFINE l_sfdc002          LIKE sfdc_t.sfdc002  
   DEFINE l_sfdc003          LIKE sfdc_t.sfdc003  
   #160120-00002#9 s983961--add(e)
   
   CLEAR FORM
   #INITIALIZE g_asfp370_02_m.* TO NULL
   #INITIALIZE g_wc_02 TO NULL
   #CALL g_sfdc02_d.clear()
   #CALL g_inag_d.clear()
   #CALL g_inai_d.clear()
   
   #設定左方的流程圖  
   CALL gfrm_curr.setElementImage("step01","32/step01.png")    #有on的是顏色不同的圖  
   CALL gfrm_curr.setElementImage("step02","32/step02on.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",FALSE)       #將第一步的畫面顯示  
   CALL cl_set_comp_visible("main_vbox02",TRUE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)

   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("save",FALSE)             #收貨資料寫入 (使用於第一步)  
   CALL cl_set_comp_visible("back_step",TRUE)         #回上一步     (第一步,第三步不使用)
   CALL cl_set_comp_visible("next_step",TRUE)         #下一步       (第三步不使用) 
   CALL cl_set_comp_visible("continue",FALSE)         #處理其他資料 (使用於第四步) 

   #160120-00002#9 s983961--add(s)   
   #開啟transaction 
   CALL s_transaction_begin()
   
   LET l_sql = "SELECT sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003 ",
               "  FROM asfp370_tmp01 ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 p370_01_lock_b_t ——> asfp370_tmp01
               " ORDER BY sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003 "
   PREPARE asfp370_lock2_prep FROM l_sql
   DECLARE asfp370_lock2_curs CURSOR FOR asfp370_lock2_prep

   LET l_sql = "SELECT sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003 ",
               "  FROM sfdc_t ",
               #160706-00037#10-s-mod
#               " WHERE "
               " WHERE sfdcent = ",g_enterprise," AND ("
               #160706-00037#10-e-mod

   LET l_where = ''
   FOREACH asfp370_lock2_curs INTO l_sfdcdocno,l_sfdcseq,l_sfdc001,l_sfdc002,l_sfdc003
      IF cl_null(l_where) THEN
         LET l_where = "(sfdcdocno = '",l_sfdcdocno,"' AND sfdcseq = '",l_sfdcseq,"' AND sfdc001 = '",l_sfdc001,"' AND sfdc002 = '",l_sfdc002,"' AND sfdc003 = '",l_sfdc003,"') "
      ELSE
         LET l_where = l_where," OR ","(sfdcdocno = '",l_sfdcdocno,"' AND sfdcseq = '",l_sfdcseq,"' AND sfdc001 = '",l_sfdc001,"' AND sfdc002 = '",l_sfdc002,"' AND sfdc003 = '",l_sfdc003,"') "
      END IF
   END FOREACH
   #add--160706-00037#13-s
   IF cl_null(l_where) THEN
      LET l_where  = " 1=2 "
   END IF
   LET l_where = l_where," )"
   #add--160706-00037#13-e
   LET l_sql = l_sql,l_where," FOR UPDATE "
   PREPARE asfp370_lock2_body_prep FROM l_sql 
   DECLARE asfp370_lock2_body_curs CURSOR FOR asfp370_lock2_body_prep
   OPEN asfp370_lock2_body_curs
   #160120-00002#9 s983961--add(e)

   CALL asfp370_02_b_fill('Y')

   IF cl_null(g_asfp370_02_m.chief_default) THEN
      LET g_asfp370_02_m.chief_default = 'N'
   END IF
   
   LET g_action_choice = ''
   
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         SUBDIALOG asf_asfp370_02.asfp370_02_construct
         SUBDIALOG asf_asfp370_02.asfp370_02_input
         SUBDIALOG asf_asfp370_02.asfp370_02_display2
        #SUBDIALOG asf_asfp370_02.asfp370_02_input3        #151118-00029#10 mark
         SUBDIALOG asf_asfp370_02.asfp370_02_display3      #151118-00029#10 add
        #SUBDIALOG asf_asfp370_02.asfp370_02_input5        #151118-00029#10 mark
         SUBDIALOG asf_asfp370_02.asfp370_02_display5      #151118-00029#10 add
         
         BEFORE DIALOG

         ON ACTION save
         
         ON ACTION continue
         
         #--151118-00029#10--add--(S)
         ON ACTION modify_detail3
            CALL asfp370_02_b3() 

         ON ACTION modify_detail5
            CALL asfp370_02_b5() 
         #--151118-00029#10--add--(E)
         
         ON ACTION back_step
            IF cl_ask_confirm('apm-00541') THEN 
               LET g_action_choice = "back_step"
               EXIT DIALOG
            END IF
            
         ON ACTION next_step
            #chk
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM asfp370_tmp03  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp370_02_temp3 ——> asfp370_tmp03
             WHERE sel = 'Y'
               AND qty > 0
            IF l_cnt > 0 THEN
               CALL asfp370_02_upd_temp('0') RETURNING l_success #此处只能做更新，不能做检查数量相平 因为测试单身编辑状态可直接按这个按钮，不过ON ROW CHANGE
               IF l_success THEN
                  LET g_action_choice = "next_step"
                  EXIT DIALOG
               END IF
            ELSE
               #没有选择要拨出的库存资料,請先選擇要處理的資料!
               #没有选择有实际拨出数量的库存资料
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00368'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            
         ON ACTION step01
            
         ON ACTION step02
         
         ON ACTION step03

         ON ACTION CLOSE
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG

         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF 
      
      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE
   
   #160120-00002#9 s983961--add(s)   
   CALL s_transaction_end('Y','0')
   #160120-00002#9 s983961--add(e) 
   
   CASE g_action_choice
      WHEN "next_step"
         RETURN 3
      WHEN "back_step"
         CALL asfp370_02_delete_temp_table()
         RETURN 1
      OTHERWISE
         RETURN 0
   END CASE

END FUNCTION

#第三步
PRIVATE FUNCTION asfp370_ui_dialog_step3()
   
   CLEAR FORM
   
   #設定左方的流程圖  
   CALL gfrm_curr.setElementImage("step01","32/step01.png")  
   CALL gfrm_curr.setElementImage("step02","32/step02.png")
   CALL gfrm_curr.setElementImage("step03","32/step03on.png")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",TRUE)

   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("save",FALSE)             #收貨資料寫入 (使用於第一步)  
   CALL cl_set_comp_visible("back_step",TRUE)        #回上一步     (第一步,第三步不使用)
   CALL cl_set_comp_visible("next_step",FALSE)        #下一步       (第三步不使用) 
   CALL cl_set_comp_visible("continue",TRUE)          #處理其他資料 (使用於第四步) 
   
   LET g_asfp370_03_m.indcdocdt = cl_get_today()
   LET g_asfp370_03_m.post = 'Y'
   
   LET g_action_choice = ''
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         SUBDIALOG asf_asfp370_03.asfp370_03_input 
         SUBDIALOG asf_asfp370_03.asfp370_03_display1

         BEFORE DIALOG

         ON ACTION save
         
         ON ACTION continue
            LET g_action_choice = "continue"
            EXIT DIALOG
            
         ON ACTION back_step
            IF NOT cl_null(g_asfp370_03_m.indcdocno_03) THEN 
               #已产生调拨单，不可返回上一步;请选择“处理其他资料”
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00396'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE
               LET g_action_choice = "back_step"
               EXIT DIALOG
            END IF
            
         #ON ACTION next_step
            
         ON ACTION step01
            
         ON ACTION step02
         
         ON ACTION step03

         ON ACTION CLOSE
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG

         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF 
      
      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE
   
   CASE g_action_choice
      WHEN "continue"
         CALL asfp370_delete_temp()
         LET g_asfp370_03_m.indcent_03 = ''
         LET g_asfp370_03_m.indcdocno_03 = ''
         LET g_asfp370_03_m.indcdocdt_03 = ''
         CALL g_indd_d.clear()
         RETURN 1
      WHEN "back_step"
         RETURN 2
      OTHERWISE
         RETURN 0
   END CASE

END FUNCTION

#删除临时表
PRIVATE FUNCTION asfp370_delete_temp()
   CALL asfp370_01_delete_temp_table()
   CALL asfp370_02_delete_temp_table()
END FUNCTION

#end add-point
 
{</section>}
 
