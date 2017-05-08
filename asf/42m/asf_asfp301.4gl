#該程式已解開Section, 不再透過樣板產出!
{<section id="asfp301.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2016-09-19 13:43:11), PR版次:0017(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000066
#+ Filename...: asfp301
#+ Description: 訂單轉工單作業
#+ Creator....: ()
#+ Modifier...: 07804 -SD/PR- 00000
 
{</section>}
 
{<section id="asfp301.global" >}
#151118-00029#8  2016/03/31  By earl     針對第四步由input改為display顯示
#160615-00018#1  2016/08/01  By zhangllc 最後一步增加“繼續”按鈕，不要每次執行完拋轉還要把當前的作業窗口關掉，再重新開一個窗口，很不方便
#160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 p301_01_lock_b_t ——> asfp301_tmp01
#160706-00037#8  2016/08/25  By Sarah    引導式作業調整的作法:進行到第二步時，針對勾選的資料中若有被別人處理中的單據提示"單據編號OOO+項次XX被其他使用者處理中"
#160909-00062#1  2016/09/19  By Ann_Huang 1.畫面規格新增QBE條件"客戶料號(xmdc027)"
#                                         2.加入xmdc027條件資料
#161026-00021#1  2016/11/04  By lixiang   調整工單單別需增加模具工單的單別
#160706-00037#13 2016/11/14  By lienjunqi     整批加上
#                                          1.檢查第一步勾選的資料有沒有被別人處理中，測試資料有沒有被別人LOCK的EXECUTE前要先把變數清空
#                                          2.若排除掉被別人處理中的資料後，本次沒有需要處理的資料，l_where應補上1=2條件而非1=1
#161128-00036#1  2017/01/23  By shiun     調整留置訂單也可拋轉工單
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
IMPORT util
IMPORT FGL asf_asfp301_01
IMPORT FGL asf_asfp301_02
IMPORT FGL asf_asfp301_03  
IMPORT FGL asf_asfp301_04  
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../asf/4gl/asfp301.inc"
 
 
#add-point:free_style模組變數(Module Variable)
 
#end add-point
 
#add-point:自定義模組變數(Module Variable)
DEFINE li_step              LIKE type_t.num5
DEFINE gwin_curr            ui.Window
DEFINE gfrm_curr            ui.Form
DEFINE g_forupd_sql         STRING
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_sfaadocno_t        LIKE sfaa_t.sfaadocno
DEFINE g_sfaadocdt_t        LIKE sfaa_t.sfaadocdt
DEFINE g_xmdadocno_t        LIKE xmda_t.xmdadocno
DEFINE g_xmdadocdt_t        LIKE xmda_t.xmdadocdt
DEFINE g_xmdd011_t          LIKE xmdd_t.xmdd011
DEFINE g_xmda004_t          LIKE xmda_t.xmda004
DEFINE g_imaa009_t          LIKE imaa_t.imaa009
DEFINE g_imae011_t          LIKE imae_t.imae011
DEFINE g_imae012_t          LIKE imae_t.imae012 
DEFINE g_xmdc027_t          LIKE xmdc_t.xmdc027   #160909-00062#1 add
#end add-point
 
{</section>}
 
{<section id="asfp301.main" >}
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
 
   #end add-point
 
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE asfp301_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfp301 WITH FORM cl_ap_formpath("asf",g_code)
   
      #程式初始化
      CALL asfp301_init()
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
      
     ##建立各程式的temp table 
      CALL asfp301_01_create_temp_table() RETURNING l_success
      IF NOT l_success THEN
         #dorislai-20150914-modify----(S)
#         EXIT PROGRAM
         CALL cl_ap_exitprogram("1")
         #dorislai-20150914-modify----(E)
      END IF
      CALL asfp301_03_create_temp_table() RETURNING l_success
      IF NOT l_success THEN
         #dorislai-20150914-modify----(S)
#         EXIT PROGRAM
         CALL cl_ap_exitprogram("1")
         #dorislai-20150914-modify----(E)
      END IF
      CALL asfp301_04_create_temp_table() RETURNING l_success
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
                  CALL asfp301_ui_dialog_step1() RETURNING li_step
               WHEN 2
                  CALL asfp301_ui_dialog_step2() RETURNING li_step
               WHEN 3
                  CALL asfp301_ui_dialog_step3() RETURNING li_step
               WHEN 4
                  CALL asfp301_ui_dialog_step4() RETURNING li_step
#                 CALL asfp301_delete_temp()
               WHEN 0
                  EXIT WHILE
               OTHERWISE
                  EXIT WHILE
            END CASE
         END WHILE
      END IF
      
      CALL asfp301_01_drop_temp_table() RETURNING l_success
      CALL asfp301_03_drop_temp_table() RETURNING l_success
      CALL asfp301_04_drop_temp_table() RETURNING l_success
   
      #畫面關閉
      CLOSE WINDOW w_asfp301
   END IF
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="asfp301.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION asfp301_init()
   #add-point:init段define

   #end add-point

   LET g_error_show = 1
   LET g_errshow = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   
   #畫面嵌入 
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp301_01"), "main_grid01", "Group", "master")
   CALL asfp301_01_init()        #asfp301_01的畫面預設   
   
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp301_02"), "main_grid02", "VBox", "vb_master")
   CALL cl_set_combo_scc('choice1','4036') 
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp301_03"), "main_grid03", "VBox", "master")
   CALL asfp301_03_init()        #asfp301_03的畫面預設   

   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp301_04"), "main_grid04", "VBox", "master")
   CALL asfp301_04_init()        #asfp301_03的畫面預設 
   
   #先將嵌入的畫面都隱藏  
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)
   CALL cl_set_comp_visible("main_vbox04",FALSE)

   #end add-point

END FUNCTION

PRIVATE FUNCTION asfp301_process(ls_js)
   DEFINE ls_js       STRING
   #DEFINE lc_param    type_parameter
   DEFINE li_stus     LIKE type_t.num5
   DEFINE li_count    LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql      STRING             #主SQL
   #add-point:process段define

   #end add-point

   #CALL util.JSON.parse(ls_js,lc_param)

   #add-point:process段前處理

   #end add-point

   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress

      #end add-point
   END IF

   #主SQL及相關FOREACH前置處理
#  DECLARE asfp301_process_cs CURSOR FROM ls_sql
#  FOREACH asfp301_process_cs INTO
   #add-point:process段process

   #end add-point
#  END FOREACH

   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理

      #end add-point
      CALL cl_ask_confirm("std-00012") RETURNING li_stus
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理

      #end add-point
   END IF
END FUNCTION

PRIVATE FUNCTION asfp301_transfer_argv(ls_js)
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog     STRING,
             param    DYNAMIC ARRAY OF STRING
                  END RECORD
   #DEFINE la_param    type_parameter

   #CALL util.JSON.parse(ls_js,la_param)

   LET la_cmdrun.prog = g_prog
   #add-point:transfer.argv段define

   #end add-point

   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION

PRIVATE FUNCTION asfp301_ui_dialog_step1()
   DEFINE l_ooef004    LIKE ooef_t.ooef004
   DEFINE l_sfaa       RECORD
                       sfaadocno       LIKE sfaa_t.sfaadocno,
                       sfaadocno_desc  LIKE oobxl_t.oobxl004,
                       sfaadocdt       LIKE sfaa_t.sfaadocdt
                       END RECORD
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   
                   
   #設定左方的流程圖  
   CALL gfrm_curr.setElementImage("step01","32/step01on.png")    #有on的是顏色不同的圖  
   CALL gfrm_curr.setElementImage("step02","32/step02.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png")
   CALL gfrm_curr.setElementImage("step04","32/step04.png")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",TRUE)       #將第一步的畫面顯示  
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)
   CALL cl_set_comp_visible("main_vbox04",FALSE)

   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("back_step",FALSE)       
   CALL cl_set_comp_visible("next_step",TRUE)        
   
   CALL cl_set_comp_visible("condition_vbox",TRUE)
   CALL cl_set_comp_visible("main_grid_7,main_grid_9,cmt_main_grid_11",FALSE)
   CALL cl_set_comp_visible("main_grid_2",TRUE)  
   CALL cl_set_comp_visible('done',FALSE)
   CALL cl_set_comp_visible('continue',FALSE)  #add 160615-00018#1

#160706-00037#8-s mark
#   #160120-00002#7 s983961--add(s)   
#   #開啟transaction 
#   CALL s_transaction_begin()
#   #160120-00002#7 s983961--add(e)  
#160706-00037#8-e mark

   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   
   WHILE TRUE
      LET g_sfaadocno = ''
      LET g_sfaadocdt = ''
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         INPUT BY NAME l_sfaa.sfaadocno,l_sfaa.sfaadocdt
         
             BEFORE INPUT
                IF cl_null(l_sfaa.sfaadocdt) THEN LET l_sfaa.sfaadocdt = cl_get_today() END IF
                
             AFTER FIELD sfaadocno
                IF cl_null(l_sfaa.sfaadocno) THEN NEXT FIELD sfaadocno END IF
                CALL asfp301_chk_sfaadocno(l_sfaa.sfaadocno)
                     RETURNING l_success
                IF NOT l_success THEN
                   LET l_sfaa.sfaadocno = ''
                   LET l_sfaa.sfaadocno_desc = ''
                   DISPLAY BY NAME l_sfaa.sfaadocno_desc
                   NEXT FIELD CURRENT                
                END IF
                CALL s_aooi200_get_slip_desc(l_sfaa.sfaadocno) RETURNING l_sfaa.sfaadocno_desc
                DISPLAY BY NAME l_sfaa.sfaadocno_desc
                LET g_sfaadocno = l_sfaa.sfaadocno
             
             AFTER FIELD sfaadocdt
                IF cl_null(l_sfaa.sfaadocdt) THEN NEXT FIELD sfaadocdt END IF
                IF cl_null(l_sfaa.sfaadocdt) THEN 
                   NEXT FIELD sfaadocdt
                END IF
                LET g_sfaadocdt = l_sfaa.sfaadocdt  

             AFTER INPUT
                IF cl_null(l_sfaa.sfaadocno) THEN NEXT FIELD sfaadocno END IF
                IF cl_null(l_sfaa.sfaadocdt) THEN NEXT FIELD sfaadocdt END IF
  
             ON ACTION controlp
                CASE
                   WHEN INFIELD(sfaadocno)
                        INITIALIZE g_qryparam.* TO NULL
                        LET g_qryparam.state = 'i'
                        LET g_qryparam.reqry = FALSE
                        LET g_qryparam.default1 = l_sfaa.sfaadocno                        
                        #給予arg
                        LET g_qryparam.arg1 = l_ooef004 #參照表編號
                        #LET g_qryparam.arg2 = 'asft300'   #161026-00021#1  
                        #CALL q_ooba002_1()                #161026-00021#1  
                        LET g_qryparam.arg2 = " ('asft300','asft304') "
                        CALL q_ooba002_13()                #161026-00021#1           
                        LET l_sfaa.sfaadocno = g_qryparam.return1         
                        DISPLAY BY NAME l_sfaa.sfaadocno 
                        NEXT FIELD sfaadocno       
                END CASE
         END INPUT 

         CONSTRUCT BY NAME g_wc ON xmdadocno,xmdadocdt,xmdd011,xmda004,imaa009,imae011,imae012,xmdc027  #160909-00062#1 add xmdc027

            BEFORE CONSTRUCT  
               IF cl_null(l_sfaa.sfaadocno) THEN NEXT FIELD sfaadocno END IF            

            AFTER FIELD xmdadocno
               LET g_xmdadocno_t = GET_FLDBUF(xmdadocno)

            AFTER FIELD xmdadocdt
               LET g_xmdadocdt_t = GET_FLDBUF(xmdadocdt)

            AFTER FIELD xmdd011
               LET g_xmdd011_t = GET_FLDBUF(xmdd011)

            AFTER FIELD xmda004
               LET g_xmda004_t = GET_FLDBUF(xmda004)
               
            AFTER FIELD imaa009
               LET g_imaa009_t = GET_FLDBUF(imaa009)
               
            AFTER FIELD imae011
               LET g_imae011_t = GET_FLDBUF(imae011)
               
            AFTER FIELD imae012
               LET g_imae012_t = GET_FLDBUF(imae012)
               
            #160909-00062#1-(S)-add
            AFTER FIELD xmdc027     
               LET g_xmdc027_t = GET_FLDBUF(xmdc027)
            #160909-00062#1-(E)-add
            
            ON ACTION controlp
               CASE
                  WHEN INFIELD(xmdadocno)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     #161128-00036#1-s-mod
#                     LET g_qryparam.where = " xmdastus = 'Y'"
                     LET g_qryparam.where = " xmdastus IN ('Y','H') "
                     #161128-00036#1-e-mod
                     CALL q_xmdadocno()
                     DISPLAY g_qryparam.return1 TO xmdadocno  #顯示到畫面上
                     NEXT FIELD CURRENT

                  WHEN INFIELD(xmda004)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.where = " pmaastus = 'Y'"
                     CALL q_pmaa001_6()
                     DISPLAY g_qryparam.return1 TO xmda004  #顯示到畫面上
                     NEXT FIELD CURRENT
                     
                  WHEN INFIELD(imaa009)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_rtax001()
                     DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
                     NEXT FIELD CURRENT                     
                     
                  WHEN INFIELD(imae011)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_imcf011()
                     DISPLAY g_qryparam.return1 TO imae011  #顯示到畫面上
                     NEXT FIELD CURRENT
                     
                  WHEN INFIELD(imae012)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.where = " ooagstus ='Y' "
                     CALL q_ooag001_2()                      
                     DISPLAY g_qryparam.return1 TO imae012  #顯示到畫面上
                     NEXT FIELD CURRENT
                  
                  #160909-00062#1-(S)-add
                  WHEN INFIELD(xmdc027)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE                     
                     CALL q_pmao004_1()                      
                     DISPLAY g_qryparam.return1 TO xmdc027  #顯示到畫面上
                     NEXT FIELD CURRENT
                  #160909-00062#1-(E)-add   
               END CASE
               
         END CONSTRUCT

         SUBDIALOG asf_asfp301_01.asfp301_01_input

         BEFORE DIALOG
            #不明原因導致 l_sfaa.*的資料被清空,在此將資料還原　讓資料一直維持相同的狀態
            LET l_sfaa.sfaadocno = g_sfaadocno_t
            CALL s_aooi200_get_slip_desc(l_sfaa.sfaadocno) RETURNING l_sfaa.sfaadocno_desc
            DISPLAY BY NAME l_sfaa.sfaadocno_desc
            
#            IF NOT cl_null(g_sfaadocdt_t) THEN
#               LET l_sfaa.sfaadocdt  = g_sfaadocdt_t
#            ELSE
               LET l_sfaa.sfaadocdt = cl_get_today()
#            END IF   
#            
#            DISPLAY g_xmdadocno_t  TO xmdadocno            
#            DISPLAY g_xmdadocdt_t  TO xmdadocdt
#            DISPLAY g_xmdd011_t    TO xmdd011            
#            DISPLAY g_xmda004_t    TO xmda004
#            DISPLAY g_imaa009_t    TO imaa009
#            DISPLAY g_imae011_t    TO imae011
#            DISPLAY g_imae012_t    TO imae012 

        ON ACTION search_data
           CALL cl_set_act_visible("next_step",TRUE)
           CALL s_transaction_begin()        #160706-00037#8 add
           CALL asfp301_01_b_fill()
           CALL s_transaction_end('Y','0')   #160706-00037#8 add

        ON ACTION selall
           CALL asfp301_01_sel_all("Y")
      
        ON ACTION selnone
           CALL asfp301_01_sel_all("N")

         ON ACTION back_step
            
         ON ACTION next_step
            CALL asfp301_01_save_data()
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM asfp301_01_temp
            IF l_cnt > 0 THEN
               LET g_action_choice = "next_step"
               EXIT DIALOG
            ELSE
               #无待转的订单资料，请先选择处理的订单资料！
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00352'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            
            
         ON ACTION step01
               
         ON ACTION step02
         
         ON ACTION step03

         ON ACTION step04
         
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
      
      LET g_sfaadocno_t = l_sfaa.sfaadocno
      LET g_sfaadocdt_t = l_sfaa.sfaadocdt
      
      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE

#160706-00037#8-s mark
#   #160120-00002#7 s983961--add(s)   
#   CALL s_transaction_end('Y','0')
#   #160120-00002#7 s983961--add(e) 
#160706-00037#8-e mark

   CASE g_action_choice
      WHEN "next_step"
         LET g_action_choice = ''
         LET g_sfaadocno = l_sfaa.sfaadocno
         LET g_sfaadocdt = l_sfaa.sfaadocdt
         RETURN 2
      OTHERWISE
         RETURN 0
   END CASE
   
END FUNCTION

PRIVATE FUNCTION asfp301_ui_dialog_step2()
   #160120-00002#1 s983961--add(s)   
   DEFINE l_sql       STRING
   DEFINE l_where     STRING
   DEFINE l_xmdddocno LIKE xmdd_t.xmdddocno
   DEFINE l_xmddseq   LIKE xmdd_t.xmddseq
   DEFINE l_xmddseq1  LIKE xmdd_t.xmddseq1 
   DEFINE l_xmddseq2  LIKE xmdd_t.xmddseq2

   #160120-00002#1 s983961--add(e) 
   #若参数设定为:下次不再进此画面,则STEP 2可以跳过
   CALL asfp301_02_get_settings()
   IF g_setting.choice6 = 'Y' THEN
      RETURN 3 
   END IF
   
   #設定左方的流程圖  
   CALL gfrm_curr.setElementImage("step01","32/step01.png")    #有on的是顏色不同的圖  
   CALL gfrm_curr.setElementImage("step02","32/step02on.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png")
   CALL gfrm_curr.setElementImage("step04","32/step04.png")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",FALSE)       #將第一步的畫面顯示  
   CALL cl_set_comp_visible("main_vbox02",TRUE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)
   CALL cl_set_comp_visible("main_vbox04",FALSE)

   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("back_step",TRUE)         #回上一步     (第一步,第四步不使用)
   CALL cl_set_comp_visible("next_step",TRUE)         #下一步       (第四步不使用) 
   
   CALL cl_set_comp_visible("condition_vbox",FALSE)
   CALL cl_set_comp_visible("main_grid_2,main_grid_9,cmt_main_grid_11",FALSE)
   CALL cl_set_comp_visible("main_grid_7",TRUE)

   CALL cl_set_comp_visible('done',FALSE)
   CALL cl_set_comp_visible('continue',FALSE)  #add 160615-00018#1

#160706-00037#8-s mark
#進到第三步的資料才要做LOCK,這邊先mark掉
#   #160120-00002#7 s983961--add(s)   
#   #開啟transaction 
#   CALL s_transaction_begin()
#   
#   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ",
#               "  FROM asfp301_tmp01 ",  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 p301_01_lock_b_t ——> asfp301_tmp01
#               " ORDER BY xmdddocno,xmddseq,xmddseq1,xmddseq2  "
#   PREPARE asfp301_02_lock_prep FROM l_sql
#   DECLARE asfp301_02_lock_curs CURSOR FOR asfp301_02_lock_prep
#
#   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2  ",
#               "  FROM xmdd_t ",
#               " WHERE "
#   LET l_where = ''
#   FOREACH asfp301_02_lock_curs INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2
#      IF cl_null(l_where) THEN
#         LET l_where = "(xmdddocno = '",l_xmdddocno,"' AND xmddseq = '",l_xmddseq,"' AND xmddseq1 = '",l_xmddseq1,"'  AND xmddseq2 = '",l_xmddseq2,"')"
#      ELSE
#         LET l_where = l_where," OR ","(xmdddocno = '",l_xmdddocno,"' AND xmddseq = '",l_xmddseq,"' AND xmddseq1 = '",l_xmddseq1,"'  AND xmddseq2 = '",l_xmddseq2,"')"
#      END IF
#   END FOREACH
#   LET l_sql = l_sql,l_where," FOR UPDATE " 
#   PREPARE asfp301_02_lock_body_prep FROM l_sql
#   DECLARE asfp301_02_lock_body_curs CURSOR FOR asfp301_02_lock_body_prep
#   OPEN asfp301_02_lock_body_curs
#   #160120-00002#7 s983961--add(e) 
#160706-00037#8-e mark

   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         SUBDIALOG asf_asfp301_02.asfp301_02_input

         BEFORE DIALOG

         ON ACTION back_step
            LET g_action_choice = "back_step"
            EXIT DIALOG
            
         ON ACTION next_step
            IF g_setting.choice7 = 'Y' AND cl_null(g_setting.choice8) THEN
               #勾选"转入PBI"的选项时,PBI单别一定要录入!
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00469'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE DIALOG
            END IF
         
            #是否确定依当前页设置产生下一步资料？
            IF cl_ask_confirm('asf-00353') THEN
               LET g_action_choice = "next_step"
               EXIT DIALOG
            END IF 
            
         ON ACTION step01
            
         ON ACTION step02
         
         ON ACTION step03

         ON ACTION step04
         
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

#160706-00037#8-s mark
#   #160120-00002#7 s983961--add(s)   
#   CALL s_transaction_end('Y','0')
#   #160120-00002#7 s983961--add(e) 
#160706-00037#8-e mark

   CASE g_action_choice
      WHEN "next_step"
         RETURN 3
      WHEN "back_step"
         CALL asfp301_01_b_fill()      
         RETURN 1
      OTHERWISE
         RETURN 0
   END CASE
   
   
END FUNCTION

PRIVATE FUNCTION asfp301_ui_dialog_step3()
   DEFINE l_success      LIKE type_t.num5
   #160120-00002#1 s983961--add(s)   
   DEFINE l_sql       STRING
   DEFINE l_where     STRING
   DEFINE l_xmdddocno LIKE xmdd_t.xmdddocno
   DEFINE l_xmddseq   LIKE xmdd_t.xmddseq
   DEFINE l_xmddseq1  LIKE xmdd_t.xmddseq1 
   DEFINE l_xmddseq2  LIKE xmdd_t.xmddseq2
   #160120-00002#1 s983961--add(e) 
#160706-00037#8-s add
   DEFINE l_docno     LIKE xmdd_t.xmdddocno
   DEFINE l_seq       LIKE xmdd_t.xmddseq
   DEFINE l_seq1      LIKE xmdd_t.xmddseq1
   DEFINE l_seq2      LIKE xmdd_t.xmddseq2
   DEFINE l_str       STRING
   DEFINE l_str1      STRING
   DEFINE l_str2      STRING
   DEFINE l_str_seq   STRING
#160706-00037#8-e add   
   
   #設定左方的流程圖  
   CALL gfrm_curr.setElementImage("step01","32/step01.png")  
   CALL gfrm_curr.setElementImage("step02","32/step02.png")
   CALL gfrm_curr.setElementImage("step03","32/step03on.png")
   CALL gfrm_curr.setElementImage("step04","32/step04.png")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",TRUE)
   CALL cl_set_comp_visible("main_vbox04",FALSE)

   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("back_step",TRUE)        #回上一步  
   CALL cl_set_comp_visible("next_step",TRUE)        #下一步    
   
   CALL cl_set_comp_visible("condition_vbox",FALSE)
   CALL cl_set_comp_visible("main_grid_2,main_grid_7",FALSE)
   CALL cl_set_comp_visible("main_grid_9,cmt_main_grid_11",TRUE)

   CALL cl_set_comp_visible('done',FALSE)
   CALL cl_set_comp_visible('continue',FALSE)  #add 160615-00018#1
   
#160706-00037#8-s add
   #勾選完要拋轉的資料，進行到第二步時，針對勾選的資料中若有被別人處理中的單據提示"單據編號OOO+項次X-Y-Z被其他使用者處理中"
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2",
               "  FROM asfp301_tmp01 ",
               " ORDER BY xmdddocno,xmddseq,xmddseq1,xmddseq2"
   PREPARE asfp301_03_chk_lock_prep FROM l_sql
   DECLARE asfp301_03_chk_lock_curs CURSOR WITH HOLD FOR asfp301_03_chk_lock_prep

   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ",
               "  FROM xmdd_t ",
               " WHERE xmddent   = ",g_enterprise,
               "   AND xmdddocno = ? ",
               "   AND xmddseq  = ? ",
               "   AND xmddseq1 = ? ",
               "   AND xmddseq2 = ? ",
               "   FOR UPDATE SKIP LOCKED"
   PREPARE asfp301_03_test_lock_prep FROM l_sql

   FOREACH asfp301_03_chk_lock_curs INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2
      #add--160706-00037#13-s
      LET l_docno = ''
      LET l_seq   = ''
      LET l_seq1  = ''
      LET l_seq2  = ''
      #add--160706-00037#13-e
      EXECUTE asfp301_03_test_lock_prep USING l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2
                                         INTO l_docno,l_seq,l_seq1,l_seq2
      IF cl_null(l_docno) OR cl_null(l_seq) OR cl_null(l_seq1) OR cl_null(l_seq2) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01117'
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = l_xmdddocno
         #訂單項次、項序、分批序，需用'-'串成一個字串，例如：1-1-1
         LET l_str  = l_xmddseq
         LET l_str1 = l_xmddseq1
         LET l_str2 = l_xmddseq2
         LET l_str_seq = l_str CLIPPED,"-",l_str1 CLIPPED,"-",l_str2 CLIPPED         
         LET g_errparam.replace[2] = l_str_seq
         CALL cl_err()

         DELETE FROM asfp301_01_temp
          WHERE xmdddocno = l_xmdddocno
            AND xmddseq  = l_xmddseq
            AND xmddseq1 = l_xmddseq1
            AND xmddseq2 = l_xmddseq2
         DELETE FROM asfp301_tmp01
          WHERE xmdddocno = l_xmdddocno
            AND xmddseq  = l_xmddseq
            AND xmddseq1 = l_xmddseq1
            AND xmddseq2 = l_xmddseq2
      END IF
   END FOREACH
   
   CALL cl_err_collect_show()
   CALL s_transaction_end('Y','0')
#160706-00037#8-e add
   
   #160120-00002#7 s983961--add(s)   
   #開啟transaction 
   CALL s_transaction_begin()
   
   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ",
               "  FROM asfp301_tmp01 ",  #160727-00019#17 2016/08/10  By 08734    临时表长度超过15码的减少到15码以下 p301_01_lock_b_t ——> asfp301_tmp01
               " ORDER BY xmdddocno,xmddseq,xmddseq1,xmddseq2 "
   PREPARE asfp301_03_lock_prep FROM l_sql
   DECLARE asfp301_03_lock_curs CURSOR FOR asfp301_03_lock_prep

   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ",
               "  FROM xmdd_t ",
#160706-00037#8-s mod
#              " WHERE "
               " WHERE xmddent = ",g_enterprise," AND ("
#160706-00037#8-e mod
   LET l_where = ''
   FOREACH asfp301_03_lock_curs INTO l_xmdddocno,l_xmddseq,l_xmddseq1,l_xmddseq2
      IF cl_null(l_where) THEN
         LET l_where = "(xmdddocno = '",l_xmdddocno,"' AND xmddseq = '",l_xmddseq,"' AND xmddseq1 = '",l_xmddseq1,"'  AND xmddseq2 = '",l_xmddseq2,"')"
      ELSE
         LET l_where = l_where," OR ","(xmdddocno = '",l_xmdddocno,"' AND xmddseq = '",l_xmddseq,"' AND xmddseq1 = '",l_xmddseq1,"'  AND xmddseq2 = '",l_xmddseq2,"')"
      END IF
   END FOREACH
#160706-00037#8-s add
   IF cl_null(l_where) THEN
      LET l_where  = " 1=2 "   #160706-00037#13 mod 1=1改成1=2
   END IF
   LET l_where = l_where," )"
#160706-00037#8-s add
   LET l_sql = l_sql,l_where," FOR UPDATE " 
   PREPARE asfp301_03_lock_body_prep FROM l_sql
   DECLARE asfp301_03_lock_body_curs CURSOR FOR asfp301_03_lock_body_prep
   OPEN asfp301_03_lock_body_curs
   #160120-00002#7 s983961--add(e) 
   
   CALL asfp301_03_gen_data()
        RETURNING l_success
   IF NOT l_success THEN
      RETURN 0
   END IF
   CALL asfp301_03_b_fill()
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         SUBDIALOG asf_asfp301_03.asfp301_03_display 
         SUBDIALOG asf_asfp301_03.asfp301_03_display2

         BEFORE DIALOG 

         ON ACTION back_step
            #此页设置的相关数据将会依上一页数据重新产生,是否确定回到上一步？
            IF cl_ask_confirm('asf-00354') THEN
               LET g_action_choice = "back_step"
               CALL asfp301_03_delete_temp_table()
               CLOSE asfp301_03_lock_body_curs   #160706-00037#8 add
               EXIT DIALOG
            END IF
            
         ON ACTION next_step
            #是否确定依当前页设置产生下一步资料？
            IF cl_ask_confirm('asf-00353') THEN
               LET g_action_choice = "next_step"
               EXIT DIALOG
            END IF
            
         ON ACTION step01
            
         ON ACTION step02
            #此页设置的相关数据将会依上一页数据重新产生,是否确定回到上一步？
            IF cl_ask_confirm('asf-00354') THEN
               UPDATE gzxn_t SET gzxn007 = 'N' 
                WHERE gzxnent = g_enterprise
                  AND gzxn001 = 1
                  AND gzxn002 = 'asfp301_02'
                  AND gzxn003 = g_user
                  AND gzxn004 = 6    
               CALL asfp301_02_get_settings()
               LET g_action_choice = "back_step"
               CALL asfp301_03_delete_temp_table()
               EXIT DIALOG
            END IF                   
         
         ON ACTION step03

         ON ACTION step04
         
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
   
   #160120-00002#7 s983961--add(s)   
   CALL s_transaction_end('Y','0')
   #160120-00002#7 s983961--add(e) 
   
   CASE g_action_choice
      WHEN "next_step"
         RETURN 4
      WHEN "back_step"
         IF g_setting.choice6 = 'Y' THEN
            RETURN 1
         ELSE
            RETURN 2
         END IF
      OTHERWISE
         RETURN 0
   END CASE
      
END FUNCTION

PRIVATE FUNCTION asfp301_ui_dialog_step4()
   DEFINE l_success      LIKE type_t.num5


   #設定左方的流程圖  
   CALL gfrm_curr.setElementImage("step01","32/step01.png")    #有on的是顏色不同的圖  
   CALL gfrm_curr.setElementImage("step02","32/step02.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png")
   CALL gfrm_curr.setElementImage("step04","32/step04on.png")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",FALSE)       #將第一步的畫面顯示  
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)
   CALL cl_set_comp_visible("main_vbox04",TRUE)


   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("back_step",TRUE)         #回上一步     
   CALL cl_set_comp_visible("next_step",FALSE)        #下一步     
   
   CALL cl_set_comp_visible("condition_vbox",FALSE)
   CALL cl_set_comp_visible("main_grid_2,main_grid_7,main_grid_9",FALSE)
   CALL cl_set_comp_visible("cmt_main_grid_11",FALSE)
   CALL cl_set_comp_visible("main_vbox04",TRUE)   
   CALL cl_set_comp_visible('done',TRUE)
   CALL cl_set_comp_visible('continue',TRUE)  #add 160615-00018#1
      
   CALL asfp301_04_gen_data()
        RETURNING l_success
   IF NOT l_success THEN
      RETURN 0
   END IF
   
   CALL asfp301_04_b_fill()
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         SUBDIALOG asf_asfp301_04.asfp301_04_display2
         
         #151118-00029#8   160331 earl mod s
         SUBDIALOG asf_asfp301_04.asfp301_04_display
         #SUBDIALOG asf_asfp301_04.asfp301_04_input
         #151118-00029#8   160331 earl mod e
         
         BEFORE DIALOG
         
         #151118-00029#8   160331 earl add s
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               #LET g_aw = g_curr_diag.getCurrentItem()
               CALL asfp301_04_modify_input()
               
               IF INT_FLAG THEN
                  EXIT DIALOG
               ELSE
                  CONTINUE DIALOG
               END IF
            END IF
         #151118-00029#8   160331 earl add e


         ON ACTION back_step
            #此页设置的相关数据将会依上一页数据重新产生,是否确定回到上一步？
            IF cl_ask_confirm('asf-00354') THEN
               LET g_action_choice = "back_step"
               EXIT DIALOG
            END IF
            
#         ON ACTION next_step
#            #是否确定依当前页设置产生下一步资料？
#            IF cl_ask_confirm('asf-00353') THEN
#               LET g_action_choice = "next_step"
#               EXIT DIALOG
#            END IF 

         ON ACTION done
            CALL asfp301_04_done() RETURNING l_success
            IF l_success THEN
               CALL asfp301_delete_temp()
               CALL asfp301_04_b_fill()
            ELSE
               CONTINUE DIALOG
            END IF
            
         #add 160615-00018#1--s
         ON ACTION continue
            LET g_action_choice = "continue"
            EXIT DIALOG
         #add 160615-00018#1--e
         
         ON ACTION step01
            
         ON ACTION step02
         
         ON ACTION step03
         
         ON ACTION step04

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
#      WHEN "next_step"
#         RETURN 3

      #add 160615-00018#1--s
      WHEN "continue"
         LET g_wc = " 1=1"
         CALL asfp301_01_b_fill()   
         RETURN 1
      #add 160615-00018#1--e
      
      WHEN "back_step"
         RETURN 3
      OTHERWISE
         RETURN 0
   END CASE
END FUNCTION
#將 所有temp table 的資料刪除
PRIVATE FUNCTION asfp301_delete_temp()
   CALL asfp301_01_delete_temp_table()
   CALL asfp301_03_delete_temp_table()
   CALL asfp301_04_delete_temp_table()
END FUNCTION

################################################################################
# Descriptions...: 工单单别检查
# Memo...........:
# Usage..........: CALL asfp301_chk_sfaadocno(p_sfaadocno)
#                  RETURNING 回传参数
# Input parameter: p_sfaadocno    工单单别
# Return code....: r_success      成功否标识
# Date & Author..: 2014-07-07 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp301_chk_sfaadocno(p_sfaadocno)
   DEFINE p_sfaadocno        LIKE sfaa_t.sfaadocno
   DEFINE r_success          LIKE type_t.num5
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_flag             LIKE type_t.num5
   DEFINE l_oobx004          LIKE oobx_t.oobx004  #161026-00021#1
   
   LET r_success = FALSE
   #檢查單別
   #161026-00021#1---s
   #IF NOT s_aooi200_chk_slip(g_site,'',p_sfaadocno,'asft300') THEN   
   LET l_oobx004 = ''
   SELECT oobx004 INTO l_oobx004 FROM oobx_t
       WHERE oobxent = g_enterprise AND oobx001 = p_sfaadocno
   IF l_oobx004 = 'asft304' THEN     
      IF (NOT s_aooi200_chk_slip(g_site,'',p_sfaadocno,'asft304')) THEN
         RETURN r_success
      END IF
   ELSE
      IF (NOT s_aooi200_chk_slip(g_site,'',p_sfaadocno,'asft300')) THEN   
         RETURN r_success
      END IF
   END IF
   #161026-00021#1---e
   
   #檢核輸入的單據別是否可以被key人員對應的控制組使用,'2' 為銷售控制組類型
   CALL s_control_chk_doc('1',p_sfaadocno,'6',g_user,g_dept,'','') 
        RETURNING l_success,l_flag
   IF l_success THEN
      IF NOT l_flag THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00015'
         LET g_errparam.extend = p_sfaadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
   ELSE
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

#end add-point
 
{</section>}
 
