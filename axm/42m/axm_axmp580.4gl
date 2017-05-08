#該程式已解開Section, 不再透過樣板產出!
{<section id="axmp580.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-10-26 10:33:18), PR版次:0008(2017-02-22 14:58:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: axmp580
#+ Description: 引導式簽收處理作業
#+ Creator....: ()
#+ Modifier...: 05384 -SD/PR- 08171
 
{</section>}
 
{<section id="axmp580.global" >}
#應用 q04 樣板自動產生(Version:28)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:   No.160318-00025#35   2016/04/15 BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160809-00031#1   2016/08/15 By 02097     加"簽收日期"欄位，預設TODAY,產生簽收單的簽收日期以此欄位為準
#160727-00019#24  2016/08/15 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	
#                                         Mod  axmp580_lock_b_t --> axmp580_tmp01
#160706-00037#6   2016/10/26 By shiun     引導式作業調整的作法:進行到第二步時，針對勾選的資料中若有被別人處理中的單據提示"單據編號OOO+項次XX被其他使用者處理中"
#160706-00037#6   2016/11/14 By 08993     整批加上
#                                         1.檢查第一步勾選的資料有沒有被別人處理中，測試資料有沒有被別人LOCK的EXECUTE前要先把變數清空
#                                         2.若排除掉被別人處理中的資料後，本次沒有需要處理的資料，l_where應補上1=2條件而非1=1
#160706-00037#6   2017/01/13 By shiun     調整axmp580_tmp01為axmp580_tmp_a
#160526-00012#6   2017/02/15 By 08171     底稿檢視時，也可按下一步
#170217-00028#4   2017/02/22 By 08171     當在底稿的情況下下一步，再重新退回第一頁時，右方按鈕顯示調整
#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
IMPORT util
IMPORT FGL axm_axmp580_01
IMPORT FGL axm_axmp580_02
IMPORT FGL axm_axmp580_03
#end add-point
 
SCHEMA ds
 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable)

GLOBALS
   DEFINE g_axmp580_01_input_type   LIKE type_t.chr1
   DEFINE g_xmdk001                 LIKE xmdk_t.xmdk001    #160809-00031#1   
END GLOBALS


#end add-point
 
#add-point:自定義模組變數(Module Variable)
DEFINE li_step              LIKE type_t.num5
DEFINE gwin_curr            ui.Window
DEFINE gfrm_curr            ui.Form
DEFINE g_forupd_sql         STRING

DEFINE g_wc                 STRING

DEFINE g_xmdkdocno          LIKE xmdk_t.xmdkdocno
DEFINE g_xmdk003            LIKE xmdk_t.xmdk003
DEFINE g_xmdkdocno_t        LIKE xmdk_t.xmdkdocno
DEFINE g_xmdk003_t          LIKE xmdk_t.xmdk003

DEFINE g_xmdk007_t          LIKE xmdk_t.xmdk007
DEFINE g_xmdl008_t          LIKE xmdl_t.xmdl008
DEFINE g_imaf141_t          LIKE imaf_t.imaf141
DEFINE g_xmdldocno_t       LIKE xmdk_t.xmdkdocno
DEFINE g_xmdkdocdt_t        LIKE xmdk_t.xmdkdocdt
DEFINE g_xmdadocno_t        LIKE xmda_t.xmdadocno
DEFINE g_xmdc013_t          LIKE xmdc_t.xmdc013
DEFINE g_xmda002_t         LIKE xmdk_t.xmdk003

DEFINE g_input   RECORD
            xmdkdocno       LIKE xmdk_t.xmdkdocno,
            xmdkdocno_desc  LIKE oodbl_t.oodbl003,
            xmdk003         LIKE xmdk_t.xmdk003,
            xmdk003_desc    LIKE ooag_t.ooag011,
            xmdk001         LIKE xmdk_t.xmdk001          #160809-00031#1
                 END RECORD

#end add-point
 
{</section>}
 
{<section id="axmp580.main" >}
#+ 作業開始
MAIN
   #add-point:main段define
   DEFINE l_success     LIKE type_t.num5
   #end add-point    
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axm","")
 
   #add-point:作業初始化
   CALL s_tax_recount_tmp()
   CALL axmp540_03_create_temp_table() RETURNING l_success
   #end add-point
 
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE axmp580_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp580 WITH FORM cl_ap_formpath("axm",g_code)
   
      #程式初始化
      CALL axmp580_init()
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
      
      #建立各程式的temp table 
      CALL axmp580_01_create_temp_table() RETURNING l_success
      IF NOT l_success THEN
         #dorislai-20150914-modify----(S)
#         EXIT PROGRAM
         CALL cl_ap_exitprogram("1")
         #dorislai-20150914-modify----(E)
      END IF
      
      CALL axmp580_02_create_temp_table() RETURNING l_success
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
                  CALL axmp580_ui_dialog_step1() RETURNING li_step
               WHEN 2
                  CALL axmp580_ui_dialog_step2() RETURNING li_step
               WHEN 3
                  CALL axmp580_ui_dialog_step3() RETURNING li_step
                  CALL axmp580_delete_temp()
               WHEN 0
                  EXIT WHILE
               OTHERWISE
                  EXIT WHILE
            END CASE
         END WHILE
      END IF
      
      CALL axmp580_01_drop_temp_table() RETURNING l_success
      CALL axmp580_02_drop_temp_table() RETURNING l_success
   
      #畫面關閉
      CLOSE WINDOW w_axmp580
   END IF
 
   #add-point:作業離開前
   CALL axmp540_03_drop_temp_table() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="axmp580.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION axmp580_init()
   LET g_errshow = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   
   #畫面嵌入 
   CALL cl_ui_replace_sub_window(cl_ap_formpath("axm", "axmp580_01"), "main_grid01", "Group", "master")
   CALL axmp580_01_init()        #axmp580_01的畫面預設   
   
   CALL cl_ui_replace_sub_window(cl_ap_formpath("axm", "axmp580_02"), "main_grid02", "VBox", "master")
   CALL axmp580_02_init()        #axmp580_02的畫面預設   

   CALL cl_ui_replace_sub_window(cl_ap_formpath("axm", "axmp580_03"), "main_grid03", "VBox", "master")
   CALL axmp580_03_init()        #axmp580_03的畫面預設   

   #先將嵌入的畫面都隱藏  
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)
     
   LET g_axmp580_01_input_type = '1'    #輸入模式
   #end add-point

END FUNCTION

PRIVATE FUNCTION axmp580_process(ls_js)
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
#  DECLARE axmp580_process_cs CURSOR FROM ls_sql
#  FOREACH axmp580_process_cs INTO
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

PRIVATE FUNCTION axmp580_transfer_argv(ls_js)
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

PRIVATE FUNCTION axmp580_ui_dialog_step1()
   DEFINE l_ooef004    LIKE ooef_t.ooef004
   DEFINE l_flag             LIKE type_t.num5
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_where            STRING
   DEFINE l_cnt              LIKE type_t.num5
   DEFINE l_smfg0031         LIKE type_t.dat          #160809-00031#1
   
   #設定左方的流程圖  
   CALL gfrm_curr.setElementImage("step01","32/step01on.png")    #有on的是顏色不同的圖  
   CALL gfrm_curr.setElementImage("step02","32/step02.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png") 
   
   #設定左方的文字顏色 
   CALL gfrm_curr.setElementStyle("step01","menuitemfocus")
   CALL gfrm_curr.setElementStyle("step02","menuitem")
   CALL gfrm_curr.setElementStyle("step03","menuitem")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",TRUE)       #將第一步的畫面顯示  
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)

   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("save",TRUE)              #收貨資料寫入 (使用於第一步)  
   CALL cl_set_comp_visible("back_step",FALSE)        #回上一步     (第一步,第三步不使用)
   CALL cl_set_comp_visible("next_step",TRUE)         #下一步       (第三步不使用) 
   CALL cl_set_comp_visible("continue",FALSE)         #處理其他資料 (使用於第三步) 
   CALL cl_set_comp_visible("open_axmt580",FALSE)     #簽收單維護

   CALL cl_set_comp_visible("delete_data,return_step01",FALSE) 
   
   CALL cl_set_comp_visible("condition_vbox",TRUE)
#   CALL cl_set_comp_visible("main_grid_7,main_grid_9",FALSE)
   
   #mark--160706-00037#6 By shiun--(S)
#   #160120-00002#4 20160216 by s983961--add(s)   
#   #開啟transaction 
#   CALL s_transaction_begin()
#   #160120-00002#4 20160216 by s983961--add(e) 
   #mark--160706-00037#6 By shiun--(E)
   #170217-00028#4 17/02/22 By 08171 --s add
   CASE g_axmp580_01_input_type
      WHEN '1'
         CALL cl_set_comp_visible("view_data,selall_xmdk007,selall_xmdkdocno,unselall",TRUE) 
         CALL cl_set_comp_visible("delete_data,return_step01",FALSE)
         CALL cl_set_act_visible("save",TRUE)                  
      WHEN '2'
         CALL cl_set_comp_visible("view_data",FALSE) 
         CALL cl_set_comp_visible("delete_data,return_step01",TRUE)
         CALL cl_set_act_visible("save",FALSE)
   END CASE
   #170217-00028#4 17/02/22 By 08171
   
   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site AND ooefstus = 'Y'
   
   WHILE TRUE
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         INPUT g_input.xmdkdocno,g_input.xmdk003,g_input.xmdk001       #160809-00031#1 add xmdk001
          FROM xmdkdocno,xmdk003,xmdk001                               #160809-00031#1 add xmkd001
         
             BEFORE INPUT
                CLEAR FORM
                LET g_input.xmdk003 = g_user
                DISPLAY BY NAME g_input.xmdk003
                CALL s_desc_get_person_desc(g_input.xmdk003) RETURNING g_input.xmdk003_desc
                DISPLAY BY NAME g_input.xmdk003_desc
                LET g_input.xmdk001 = g_today         #160809-00031#1
                LET g_xmdk001 = g_today               #160809-00031#1
                
                CALL axmp580_set_entry()
                CALL axmp580_set_no_entry()
                

             AFTER FIELD docno
                CALL s_aooi200_get_slip_desc(g_input.xmdkdocno) RETURNING g_input.xmdkdocno_desc
                DISPLAY BY NAME g_input.xmdkdocno_desc
                                
                IF NOT cl_null(g_input.xmdkdocno) THEN

                   #檢查單別
                   IF NOT s_aooi200_chk_slip(g_site,'',g_input.xmdkdocno,'axmt580') THEN
                      LET g_input.xmdkdocno = ''

                      CALL s_aooi200_get_slip_desc(g_input.xmdkdocno) RETURNING g_input.xmdkdocno_desc
                      DISPLAY BY NAME g_input.xmdkdocno_desc

                      NEXT FIELD CURRENT
                   END IF
                   
                   #檢核輸入的單據別是否可以被key人員對應的控制組使用,'2' 為銷售控制組類型
                   CALL s_control_chk_doc('1',g_input.xmdkdocno,'2',g_user,g_dept,'','') RETURNING l_success,l_flag
                   IF NOT l_success OR NOT l_flag THEN
                      LET g_input.xmdkdocno = ''
                      CALL s_aooi200_get_slip_desc(g_input.xmdkdocno) RETURNING g_input.xmdkdocno_desc
                      DISPLAY BY NAME g_input.xmdkdocno_desc

                      NEXT FIELD CURRENT
                   END IF                     
                   
                END IF
                
                CALL axmp580_set_entry()
                CALL axmp580_set_no_entry()
             
             AFTER FIELD xmdk003
                CALL s_desc_get_person_desc(g_input.xmdk003) RETURNING g_input.xmdk003_desc
                DISPLAY BY NAME g_input.xmdk003_desc
                
                IF NOT cl_null(g_input.xmdk003) THEN
                
                   INITIALIZE g_chkparam.* TO NULL
                   LET g_chkparam.arg1 = g_input.xmdk003
                   #160318-00025#35  2016/05/15  by pengxin  add(S)
                   LET g_errshow = TRUE #是否開窗 
                   LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                   #160318-00025#35  2016/05/15  by pengxin  add(E)
                   IF NOT cl_chk_exist("v_ooag001") THEN
                      LET g_input.xmdk003_desc = ''
                      CALL s_desc_get_person_desc(g_input.xmdk003) RETURNING g_input.xmdk003_desc
                      DISPLAY BY NAME g_input.xmdk003_desc

                      NEXT FIELD CURRENT
                   END IF
                END IF
                
                CALL axmp580_set_entry()
                CALL axmp580_set_no_entry()
             
             #160809-00031#1--(S)
             AFTER FIELD xmdk001
               IF NOT cl_null(g_input.xmdk001) THEN                
                  CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_smfg0031
                  IF g_input.xmdk001 <= l_smfg0031 THEN
                     INITIALIZE g_errparam TO NULL                    
                     LET g_errparam.code = 'axm-00249'   #簽收日期小於關帳日期，請重新輸入！                     
                     LET g_errparam.extend = g_input.xmdk001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                END IF
                LET g_xmdk001 = g_input.xmdk001
             #160809-00031#1--(E)
             ON ACTION controlp
                CASE
                   WHEN INFIELD(xmdkdocno)
                      INITIALIZE g_qryparam.* TO NULL
                      LET g_qryparam.state = 'i'
                      LET g_qryparam.reqry = FALSE
                      LET g_qryparam.arg1 = l_ooef004 
                      LET g_qryparam.arg2 = 'axmt580'
                      LET g_qryparam.default1 = g_input.xmdkdocno
                      
                      CALL q_ooba002_1()                              #呼叫開窗                     
                      LET g_input.xmdkdocno = g_qryparam.return1       #將開窗取得的值回傳到變數
                      DISPLAY g_input.xmdkdocno TO xmdkdocno           #顯示到畫面上
                      
                      CALL s_aooi200_get_slip_desc(g_input.xmdkdocno) RETURNING g_input.xmdkdocno_desc
                      DISPLAY BY NAME g_input.xmdkdocno_desc
                      
                      NEXT FIELD xmdkdocno
                      
                   WHEN INFIELD(xmdk003)
                      INITIALIZE g_qryparam.* TO NULL
                      LET g_qryparam.state = 'i'
                      LET g_qryparam.reqry = FALSE
                      LET g_qryparam.default1 = g_input.xmdk003
                      
                      CALL q_ooag001()                              #呼叫開窗
                      
                      LET g_input.xmdk003 = g_qryparam.return1       #將開窗取得的值回傳到變數
                      DISPLAY g_input.xmdk003 TO xmdk003             #顯示到畫面上
                      
                      CALL s_desc_get_person_desc(g_input.xmdk003) RETURNING g_input.xmdk003_desc
                      DISPLAY BY NAME g_input.xmdk003_desc
                      
                      NEXT FIELD xmdk003
                      
                END CASE
         END INPUT 

         CONSTRUCT BY NAME g_wc ON xmdk007,xmdl008,imaf141,xmdldocno,xmdkdocdt,xmdadocno,xmdc013,xmda002

            AFTER FIELD xmdk007
               LET g_xmdk007_t = GET_FLDBUF(xmdk007)
               
            AFTER FIELD xmdl008
               LET g_xmdl008_t = GET_FLDBUF(xmdl008)
            
            AFTER FIELD imaf141
               LET g_imaf141_t = GET_FLDBUF(imaf141)    
            
            AFTER FIELD xmdldocno
               LET g_xmdldocno_t = GET_FLDBUF(xmdldocno)    
            
            AFTER FIELD xmdkdocdt
               LET g_xmdkdocdt_t = GET_FLDBUF(xmdkdocdt)    
            
            AFTER FIELD xmdadocno
               LET g_xmdadocno_t = GET_FLDBUF(xmdadocno)    
            
            AFTER FIELD xmdc013
               LET g_xmdc013_t = GET_FLDBUF(xmdc013)    
            
            AFTER FIELD xmda002
               LET g_xmda002_t = GET_FLDBUF(xmda002)    
               
            ON ACTION controlp
               CASE
                  WHEN INFIELD(xmdk007)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.arg1 = g_site
                     CALL q_pmaa001_6()
                     DISPLAY g_qryparam.return1 TO xmdk007  #顯示到畫面上
                     NEXT FIELD CURRENT

                  WHEN INFIELD(xmdl008)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_imaf001_15()
                     DISPLAY g_qryparam.return1 TO xmdl008  #顯示到畫面上
                     NEXT FIELD CURRENT

                  WHEN INFIELD(imaf141)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_imce141()
                     DISPLAY g_qryparam.return1 TO imaf141  #顯示到畫面上
                     NEXT FIELD CURRENT

                  WHEN INFIELD(xmdldocno)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.where = " xmdk002 = '3'"
                     CALL q_xmdkdocno_3()
                     DISPLAY g_qryparam.return1 TO xmdldocno  #顯示到畫面上
                     NEXT FIELD CURRENT

                  WHEN INFIELD(xmdadocno)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_xmdadocno()
                     DISPLAY g_qryparam.return1 TO xmdadocno  #顯示到畫面上
                     NEXT FIELD CURRENT

                  WHEN INFIELD(xmda002)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_ooag001()
                     DISPLAY g_qryparam.return1 TO xmda002  #顯示到畫面上
                     NEXT FIELD CURRENT
                     
               END CASE
               
            ON ACTION search_data
               CALL cl_set_comp_visible("view_data,selall_xmdk007,selall_xmdkdocno,unselall",TRUE) 
               CALL cl_set_comp_visible("delete_data,return_step01",FALSE) 
               CALL cl_set_act_visible("save,next_step",TRUE)
               
               #組合過濾前後置單據資料SQL
               CALL s_aooi210_get_check_sql(g_site,'',g_input.xmdkdocno,'2','axmt540','xmdkdocno') RETURNING l_success,l_where
               IF l_success AND l_where <> '1=1' THEN
                  LET g_wc = g_wc," AND ",l_where
               END IF
               CALL s_transaction_begin()   #add--160706-00037#6 By shiun
               CALL axmp580_01_b_fill(g_wc)
               CALL s_transaction_end('Y','0')   #add--160706-00037#6 By shiun
               
            AFTER CONSTRUCT
               CALL s_chr_replace(g_wc,'xmda002','xmdk003',0) RETURNING g_wc
         END CONSTRUCT

         SUBDIALOG axm_axmp580_01.axmp580_01_input
         SUBDIALOG axm_axmp580_01.axmp580_01_input2
         
         BEFORE DIALOG             
            #不明原因導致 g_input.*的資料被清空,在此將資料還原　讓資料一直維持相同的狀態
            LET g_input.xmdkdocno = g_xmdkdocno_t
            CALL s_aooi200_get_slip_desc(g_input.xmdkdocno) RETURNING g_input.xmdkdocno_desc
            DISPLAY BY NAME g_input.xmdkdocno_desc
            
            IF NOT cl_null(g_xmdk003_t) THEN
               LET g_input.xmdk003  = g_xmdk003_t
            ELSE
               LET g_input.xmdk003 = g_user
            END IF
            CALL s_desc_get_person_desc(g_input.xmdk003) RETURNING g_input.xmdk003_desc
            DISPLAY BY NAME g_input.xmdk003_desc    

            DISPLAY g_xmdk007_t TO xmdk007               
            DISPLAY g_xmdl008_t TO xmdl008            
            DISPLAY g_imaf141_t TO imaf141
            DISPLAY g_xmdldocno_t TO xmdkdocno
            DISPLAY g_xmdkdocdt_t TO xmdkdocdt
            DISPLAY g_xmdadocno_t TO xmdadocno
            DISPLAY g_xmdc013_t TO xmdc013
            DISPLAY g_xmda002_t TO xmdk003

            NEXT FIELD xmdkdocno

         ON ACTION save
            CALL axmp580_01_save_data()
            CALL s_transaction_begin()   #add--160706-00037#6 By shiun
            CALL axmp580_01_b_fill(g_wc)  
            CALL s_transaction_end('Y','0')   #add--160706-00037#6 By shiun
            
         ON ACTION continue

         ON ACTION back_step

         ON ACTION next_step
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM axmp580_01_temp
            IF l_cnt > 0 THEN
               LET g_action_choice = "next_step"
               EXIT DIALOG
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00489'   #簽收底稿中不存在任何資料
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
            
         ON ACTION view_data
           #CALL cl_set_comp_visible("view_data,selall_xmdk007,selall_xmdkdocno,unselall",FALSE) #160526-00012#6 17/02/15 By 08171 mark
            CALL cl_set_comp_visible("view_data",FALSE) #160526-00012#6 17/02/15 By 08171 add 
            CALL cl_set_comp_visible("delete_data,return_step01",TRUE)
           #CALL cl_set_act_visible("save,next_step",FALSE) #160526-00012#6 17/02/15 By 08171 mark
            CALL cl_set_act_visible("save",FALSE) #160526-00012#6 17/02/15 By 08171 add
            CALL axmp580_01_b_fill2()
            LET g_axmp580_01_input_type = '2'
            CALL axmp580_01_set_entry_b()
            CALL axmp580_01_set_no_entry_b()
            #NEXT FIELD CURRENT           #當array為空時,如果沒有寫會出現異常的bug
            NEXT FIELD sel_d1_01          #因第二頁籤隱藏，重新導到第一頁籤
         
         ON ACTION return_step01
            CALL cl_set_comp_visible("view_data,selall_xmdk007,selall_xmdkdocno,unselall",TRUE) 
            CALL cl_set_comp_visible("delete_data,return_step01",FALSE) 
           #CALL cl_set_act_visible("save,next_step",TRUE) #160526-00012#6 17/02/15 By 08171 mark
            CALL cl_set_act_visible("save",TRUE) #160526-00012#6 17/02/15 By 08171 add
            
            CALL axmp580_01_b_fill(g_wc) 
            LET g_axmp580_01_input_type = '1' 
            CALL axmp580_01_set_entry_b()
            CALL axmp580_01_set_no_entry_b()              
            NEXT FIELD CURRENT           #當array為空時,如果沒有寫會出現異常的bug 
            
         ON ACTION step01
               
         ON ACTION step02
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM axmp580_01_temp
            IF l_cnt > 0 THEN
               LET g_action_choice = "next_step"
               EXIT DIALOG
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00489'   #簽收底稿中不存在任何資料
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF

         #ON ACTION step03

         ON ACTION CLOSE
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG

         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"

      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF 
      
      LET g_xmdkdocno_t = g_input.xmdkdocno
      LET g_xmdk003_t   = g_input.xmdk003
      
      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
   
   #mark--160706-00037#6 By shiun--(S)
#   #160120-00002#5 s983961--add(s)   
#   CALL s_transaction_end('Y','0')
#   #160120-00002#5 s983961--add(e) 
   #mark--160706-00037#6 By shiun--(E)
   
   CASE g_action_choice
      WHEN "next_step"
         LET g_action_choice = ''
         LET g_xmdkdocno = g_input.xmdkdocno
         LET g_xmdk003   = g_input.xmdk003
         RETURN 2
      OTHERWISE
         RETURN 0
   END CASE
   
   #170217-00028#4 17/02/22 By 08171 --s add
   CASE g_axmp580_01_input_type
      WHEN '1'
         CALL cl_set_comp_visible("view_data,selall_xmdk007,selall_xmdkdocno,unselall",TRUE) 
         CALL cl_set_comp_visible("delete_data,return_step01",FALSE)
         CALL cl_set_act_visible("save",TRUE) 
         LET g_axmp580_01_input_type = '1'  
         CALL axmp580_01_set_entry_b()
         CALL axmp580_01_set_no_entry_b()          
      WHEN '2'
         CALL cl_set_comp_visible("view_data",FALSE) 
         CALL cl_set_comp_visible("delete_data,return_step01",TRUE)
         CALL cl_set_act_visible("save",FALSE)
         CALL cl_set_comp_entry("save",FALSE)
         CALL cl_set_comp_entry("xmdl018_d1_01,xmdl081_d1_01,xmdl084_d1_01,xmdl020_d1_01,xmdl082_d1_01",FALSE)
         CALL cl_set_comp_entry("xmdl018_d2_01,xmdl081_d2_01,xmdl084_d2_01,xmdl020_d2_01,xmdl082_d2_01",FALSE)      
   END CASE
   
   #170217-00028#4 17/02/22 By 08171
   
END FUNCTION

PRIVATE FUNCTION axmp580_ui_dialog_step2()
   #160120-00002#1 s983961--add(s)   
   DEFINE l_sql       STRING
   DEFINE l_where     STRING
   DEFINE l_xmdldocno LIKE xmdl_t.xmdldocno
   DEFINE l_xmdlseq   LIKE xmdl_t.xmdlseq
   #160120-00002#1 s983961--add(e) 
   #add--160706-00037#6 By shiun--(S) 
   DEFINE l_docno     LIKE xmdl_t.xmdldocno
   DEFINE l_seq       LIKE xmdl_t.xmdlseq
   #add--160706-00037#6 By shiun--(E) 
   
   #設定左方的流程圖  
   CALL gfrm_curr.setElementImage("step01","32/step01.png")    #有on的是顏色不同的圖  
   CALL gfrm_curr.setElementImage("step02","32/step02on.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png") 
   
   #設定左方的文字顏色 
   CALL gfrm_curr.setElementStyle("step01","menuitem")
   CALL gfrm_curr.setElementStyle("step02","menuitemfocus")
   CALL gfrm_curr.setElementStyle("step03","menuitem")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",FALSE)       #將第一步的畫面顯示  
   CALL cl_set_comp_visible("main_vbox02",TRUE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)
   
   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("save",FALSE)             #收貨資料寫入 (使用於第一步)  
   CALL cl_set_comp_visible("back_step",TRUE)         #回上一步     (第一步,第三步不使用)
   CALL cl_set_comp_visible("next_step",TRUE)         #下一步       (第三步不使用) 
   CALL cl_set_comp_visible("continue",FALSE)         #處理其他資料 (使用於第三步) 
   CALL cl_set_comp_visible("open_axmt580",FALSE)     #簽收單維護
   
   CALL cl_set_comp_visible("condition_vbox",FALSE)
#   CALL cl_set_comp_visible("main_grid_7,main_grid_9",TRUE)
   
   #add--160706-00037#6 By shiun--(S)
   CALL s_transaction_begin()

   CALL cl_err_collect_init()

   LET l_sql = "SELECT xmdldocno,xmdlseq ",
               #160706-00037#6-s-mod-20170113
#               "  FROM axmp580_tmp01 ",
               "  FROM axmp580_tmp_a ",
               #160706-00037#6-e-mod-20170113
               " ORDER BY xmdldocno,xmdlseq "
   PREPARE p580_chk_lock_prep FROM l_sql
   DECLARE p580_chk_lock_curs CURSOR WITH HOLD FOR p580_chk_lock_prep

   LET l_sql = "SELECT xmdldocno,xmdlseq ",
               "  FROM xmdl_t ",
               " WHERE xmdlent = '",g_enterprise,"' ",
               "   AND xmdldocno = ? ",
               "   AND xmdlseq   = ? ",
               "   FOR UPDATE SKIP LOCKED "
   PREPARE p580_test_lock_prep FROM l_sql

   LET l_xmdldocno = ''   LET l_xmdlseq   = ''
   FOREACH p580_chk_lock_curs INTO l_xmdldocno,l_xmdlseq
      LET l_docno = ''   LET l_seq   = ''
      EXECUTE p580_test_lock_prep USING l_xmdldocno,l_xmdlseq
                                   INTO l_docno,l_seq
      IF cl_null(l_docno) OR cl_null(l_seq) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01117' 
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = l_xmdldocno
         LET g_errparam.replace[2] = l_xmdlseq

         CALL cl_err()

         DELETE FROM axmp580_01_temp
          WHERE xmdkdocno = l_xmdldocno
            AND xmdlseq   = l_xmdlseq

         #160706-00037#6-s-mod-20170113
#         DELETE FROM axmp580_tmp01
         DELETE FROM axmp580_tmp_a
          WHERE xmdldocno = l_xmdldocno
            AND xmdlseq   = l_xmdlseq
         #160706-00037#6-e-mod-20170113

      END IF

      LET l_xmdldocno = ''   LET l_xmdlseq   = ''
   END FOREACH

   CALL cl_err_collect_show()

   CALL s_transaction_end('Y','0')
   #add--160706-00037#6 By shiun--(E)
   
   #160120-00002#4 20160216 by s983961--add(s)   
   #開啟transaction 
   CALL s_transaction_begin()
   #160120-00002#4 20160216 by s983961--add(e) 
   
   #160120-00002#1 s983961--add(s)
   LET l_sql = "SELECT xmdldocno,xmdlseq ",
               #160706-00037#6-s-mod-20170113
#               "  FROM axmp580_tmp01 ",             #160727-00019#24 Mod  axmp580_lock_b_t --> axmp580_tmp01
               "  FROM axmp580_tmp_a ",
               #160706-00037#6-e-mod-20170113
               " ORDER BY xmdldocno,xmdlseq "
   PREPARE axmp580_02_lock_prep FROM l_sql
   DECLARE axmp580_02_lock_curs CURSOR FOR axmp580_02_lock_prep

   LET l_sql = "SELECT xmdldocno,xmdlseq ",
               "  FROM xmdl_t ",
               #160706-00037#6-s-mod
#               " WHERE "
               " WHERE xmdlent = ",g_enterprise," AND ( "
               #160706-00037#6-e-mod

   LET l_where = ''
   FOREACH axmp580_02_lock_curs INTO l_xmdldocno,l_xmdlseq
      IF cl_null(l_where) THEN
         LET l_where = "(xmdldocno = '",l_xmdldocno,"' AND xmdlseq = '",l_xmdlseq,"')"
      ELSE
         LET l_where = l_where," OR ","(xmdldocno = '",l_xmdldocno,"' AND xmdlseq = '",l_xmdlseq,"')"
      END IF
   END FOREACH
   #add--160706-00037#6 By 08993--(S)
   IF cl_null(l_where) THEN
      LET l_where  = " 1=2 "
   END IF
   LET l_where = l_where," )"
   #add--160706-00037#6 By 08993--(E)
   LET l_sql = l_sql,l_where," FOR UPDATE " 
   PREPARE axmp580_02_lock_body_prep FROM l_sql
   DECLARE axmp580_02_lock_body_curs CURSOR FOR axmp580_02_lock_body_prep
   OPEN axmp580_02_lock_body_curs
   #160120-00002#1 s983961--add(e)
   
   CALL axmp580_02_gen_data()
   CALL axmp580_02_b_fill()
   
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         SUBDIALOG axm_axmp580_02.axmp580_02_input
         SUBDIALOG axm_axmp580_02.axmp580_02_display
#         SUBDIALOG axm_axmp580_02.axmp580_02_input2    #151118-00029#6-mod-(S)
         SUBDIALOG axm_axmp580_02.axmp580_02_display2   #151118-00029#6-mod-(E)
         SUBDIALOG axm_axmp580_02.axmp580_02_display3
         SUBDIALOG axm_axmp580_02.axmp580_02_display5
         
         BEFORE DIALOG

         ON ACTION save
         
         ON ACTION continue
         
         #151118-00029#6-add-(S)
         ON ACTION modify_detail
            CALL axmp580_02_b()
         #151118-00029#6-add-(E)
         
         ON ACTION back_step
            IF cl_ask_confirm('apm-00541') THEN   #此頁設定的相關資料將會依第一頁資料重新產生,是否確定回到上一步？
               LET g_action_choice = "back_step"
               EXIT DIALOG
            END IF
            
         ON ACTION next_step            
            #檢查多庫儲批的數量是否正確
            IF axmp580_02_num_chk() THEN            
               IF cl_ask_confirm('axm-00491') THEN   #是否確定依此頁目前設定產生簽收單？
                  LET g_action_choice = "next_step"
                  ACCEPT DIALOG
               END IF
            END IF
            
         ON ACTION step01
            IF cl_ask_confirm('apm-00541') THEN   #此頁設定的相關資料將會依第一頁資料重新產生,是否確定回到上一步？
               LET g_action_choice = "back_step"
               EXIT DIALOG
            END IF

         ON ACTION step02
         
         ON ACTION step03
            #檢查多庫儲批的數量是否正確
            IF axmp580_02_num_chk() THEN
               IF cl_ask_confirm('axm-00491') THEN   #是否確定依此頁目前設定產生簽收單？
                  LET g_action_choice = "next_step"
                  ACCEPT DIALOG
               END IF
            END IF

         ON ACTION action_xmdm
            CALL axmp580_02_xmdm_act()

         ON ACTION CLOSE
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
            
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
         
      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF       

      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE
   
   #160120-00002#5 s983961--add(s)   
   CALL s_transaction_end('Y','0')
   #160120-00002#5 s983961--add(e) 
   
   CASE g_action_choice
      WHEN "next_step"
         RETURN 3
      WHEN "back_step"
         RETURN 1
      OTHERWISE
         RETURN 0
   END CASE
END FUNCTION

PRIVATE FUNCTION axmp580_ui_dialog_step3()
   #設定左方的流程圖
   CALL gfrm_curr.setElementImage("step01","32/step01.png")  
   CALL gfrm_curr.setElementImage("step02","32/step02.png")
   CALL gfrm_curr.setElementImage("step03","32/step03on.png") 
   
   #設定左方的文字顏色 
   CALL gfrm_curr.setElementStyle("step01","menuitem")
   CALL gfrm_curr.setElementStyle("step02","menuitem")
   CALL gfrm_curr.setElementStyle("step03","menuitemfocus")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",TRUE)

   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("save",FALSE)             #收貨資料寫入 (使用於第一步)  
   CALL cl_set_comp_visible("back_step",FALSE)        #回上一步     (第一步,第三步不使用)
   CALL cl_set_comp_visible("next_step",FALSE)        #下一步       (第三步不使用) 
   CALL cl_set_comp_visible("continue",TRUE)          #處理其他資料 (使用於第三步) 
   CALL cl_set_comp_visible("open_axmt580",TRUE)      #簽收單維護
   
   CALL cl_set_comp_visible("condition_vbox",FALSE)
#   CALL cl_set_comp_visible("main_grid_7,main_grid_9",TRUE)

   #160120-00002#4 20160216 by s983961--add(s)   
   #開啟transaction 
   CALL s_transaction_begin()
   #160120-00002#4 20160216 by s983961--add(e) 

   LET g_errshow = 0
   CALL axmp580_03_gen_data(g_xmdkdocno,g_xmdk003)
   LET g_errshow = 1
   CALL axmp580_03_b_fill()
   
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         SUBDIALOG axm_axmp580_03.axmp580_03_display 
         SUBDIALOG axm_axmp580_03.axmp580_03_display2
         SUBDIALOG axm_axmp580_03.axmp580_03_display3
         SUBDIALOG axm_axmp580_03.axmp580_03_display5

         BEFORE DIALOG

         ON ACTION save
         
         ON ACTION continue
            LET g_action_choice = "continue"
            EXIT DIALOG

         #ON ACTION step01
            
         #ON ACTION step02
            
         ON ACTION open_axmt580
            CALL axmp580_03_open_axmt580()
#            EXIT DIALOG            
         
         ON ACTION step03

         ON ACTION CLOSE
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG

         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF 
      
      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE
   
   #160120-00002#5 s983961--add(s)   
   CALL s_transaction_end('Y','0')
   #160120-00002#5 s983961--add(e) 
   
   CASE g_action_choice
      WHEN "continue"
         CALL axmp580_01_b_fill(g_wc)  #清空
         RETURN 1
      OTHERWISE
         RETURN 0
   END CASE
   
END FUNCTION
#將 所有temp table 的資料刪除
PRIVATE FUNCTION axmp580_delete_temp()
   CALL axmp580_01_delete_temp_table()
   CALL axmp580_02_delete_temp_table()
END FUNCTION

PRIVATE FUNCTION axmp580_set_entry()

   CALL cl_set_act_visible("search_data",TRUE)
END FUNCTION

PRIVATE FUNCTION axmp580_set_no_entry()

   IF cl_null(g_input.xmdkdocno) OR cl_null(g_input.xmdk003) THEN
      CALL cl_set_act_visible("search_data",FALSE)
   END IF
   #170217-00028#4 17/02/22 By 08171 --s add
   IF g_axmp580_01_input_type = '2' THEN
      CALL cl_set_act_visible("save",FALSE)
   END IF
   #170217-00028#4 17/02/22 By 08171 --e add
END FUNCTION

#end add-point
 
{</section>}
 
