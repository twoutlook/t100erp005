#該程式已解開Section, 不再透過樣板產出!
{<section id="apmp570.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2016-10-26 10:18:57), PR版次:0016(2017-02-20 09:51:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000062
#+ Filename...: apmp570
#+ Description: 引導式入庫處理作業
#+ Creator....: ()
#+ Modifier...: 05384 -SD/PR- 08734
 
{</section>}
 
{<section id="apmp570.global" >}
#應用 t01 樣板自動產生(Version:56)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:   No.160318-00025#31   2016/04/11  By pengxin   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#             :      160606-00011#1    2016/06/13  By dorislai  多加一個action-入庫維護，開啟apmt570、apmt571、apmt573
#             :      160616-00002#2    2016/07/04  By Polly     增加QBE收貨單號條件 
#             :      160727-00019#12   2016/08/03  By 08734     临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01,p570_01_lock_b_t ——> p570_lock_t
#             :      160805-00012#1    2016/08/15  By dorislai  把"入庫資料寫入"按鈕隱藏，避免查看底稿時，一直重複寫入資料
#             :      160706-00037#3    2016/10/21  By shiun     引導式作業調整的作法:進行到第二步時，針對勾選的資料中若有被別人處理中的單據提示"單據編號OOO+項次XX被其他使用者處理中"
#                    160706-00037#3    2016/11/14  By 08993     整批加上
#                                                               1.檢查第一步勾選的資料有沒有被別人處理中，測試資料有沒有被別人LOCK的EXECUTE前要先把變數清空
#                                                               2.若排除掉被別人處理中的資料後，本次沒有需要處理的資料，l_where應補上1=2條件而非1=1
#                    161124-00024#1    2016/11/28  By charles4m 1. ON ACTION search_data 參考 AFTER FIELD pmds011 要有相同處理邏輯；
#                                                               2. 另外宣告一個 g_master_wc 變數儲存本次查詢條件使用，避免舊職殘留。
#                    170213-00038#2    2017/02/20  By 08734     修改库存标签栏位开窗
#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
IMPORT util
IMPORT FGL apm_apmp570_01
IMPORT FGL apm_apmp570_02
IMPORT FGL apm_apmp570_03  
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
 
#add-point:free_style模組變數(Module Variable)
 
#end add-point
 
#add-point:自定義模組變數(Module Variable)
DEFINE gwin_curr            ui.Window
DEFINE gfrm_curr            ui.Form
TYPE type_master            RECORD
         pmds011            LIKE pmds_t.pmds011,   #採購性質
         pmdsdocno          LIKE pmds_t.pmdsdocno, #入庫單別
         pmds002            LIKE pmds_t.pmds002,   #入庫人員
         wc                 STRING
                            END RECORD
DEFINE g_master             type_master
DEFINE g_master_t           type_master
DEFINE g_master_wc          STRING #161124-00024#1 add 

DEFINE g_pmdt016_t          LIKE pmdt_t.pmdt016
DEFINE g_inac003_t          LIKE inac_t.inac003
DEFINE g_pmds007_t          LIKE pmds_t.pmds007
DEFINE g_pmdt006_t          LIKE pmdt_t.pmdt006
DEFINE g_imaf141_t          LIKE imaf_t.imaf141
DEFINE g_pmds006_t          LIKE pmds_t.pmds006   #160616-00002#2 add
#end add-point
 
{</section>}
 
{<section id="apmp570.main" >}
#+ 作業開始
MAIN
   #add-point:main段define
   DEFINE li_step       LIKE type_t.num5   #引導式的步驟
   DEFINE l_success     LIKE type_t.num5
   #end add-point    
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化
 
   #end add-point
 
   #add-point:SQL_define

   #end add-point
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp570 WITH FORM cl_ap_formpath("apm",g_code)
   
      #程式初始化
      CALL apmp570_init()
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
      
      LET l_success = TRUE
      #建立各程式的temp table 
      CALL apmp570_create_temp_table() RETURNING l_success
      IF NOT l_success THEN
         CALL cl_ap_exitprogram("0")
      END IF
      CALL apmp570_01_create_temp_table() RETURNING l_success
      IF NOT l_success THEN
         CALL cl_ap_exitprogram("0")
      END IF
      CALL apmp570_02_create_temp_table() RETURNING l_success
      IF NOT l_success THEN
         CALL cl_ap_exitprogram("0")
      END IF
      LET li_step = 1
      IF l_success THEN
         WHILE TRUE
            CASE li_step
               WHEN 1
                  CALL apmp570_ui_dialog_step1() RETURNING li_step
               WHEN 2
                  CALL apmp570_ui_dialog_step2() RETURNING li_step
               WHEN 3
                  CALL apmp570_ui_dialog_step3() RETURNING li_step
                  CALL apmp570_delete_temp()
               WHEN 0
                  EXIT WHILE
               OTHERWISE
                  EXIT WHILE
            END CASE
         END WHILE
      END IF
      
      CALL apmp570_drop_temp_table() RETURNING l_success
      CALL apmp570_01_drop_temp_table() RETURNING l_success
      CALL apmp570_02_drop_temp_table() RETURNING l_success
   
      #畫面關閉
      CLOSE WINDOW w_apmp570
   END IF
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="apmp570.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apmp570_init()
   #add-point:init段define

   #end add-point

   LET g_errshow = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   
   #畫面嵌入 
   CALL cl_ui_replace_sub_window(cl_ap_formpath("apm", "apmp570_01"), "main_grid01", "Group", "master")
   
   CALL cl_ui_replace_sub_window(cl_ap_formpath("apm", "apmp570_02"), "main_grid02", "VBox", "master")
   CALL apmp570_02_init()        #apmp570_02的畫面預設   
    
   CALL cl_ui_replace_sub_window(cl_ap_formpath("apm", "apmp570_03"), "main_grid03", "VBox", "master")
   CALL apmp570_03_init()        #apmp570_03的畫面預設   


   #先將嵌入的畫面都隱藏  
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)

   #add-point:畫面資料初始化
   CALL cl_set_combo_scc_part('pmds011','2061','1,2,10') 

   #end add-point

END FUNCTION

PRIVATE FUNCTION apmp570_process(ls_js)
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
#  DECLARE apmp570_process_cs CURSOR FROM ls_sql
#  FOREACH apmp570_process_cs INTO
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

PRIVATE FUNCTION apmp570_transfer_argv(ls_js)
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

PRIVATE FUNCTION apmp570_ui_dialog_step1()
DEFINE l_ooef004         LIKE ooef_t.ooef004
DEFINE l_prog            LIKE type_t.chr20
DEFINE l_pmdsdocno_desc  LIKE oobxl_t.oobxl003
DEFINE l_pmds002_desc    LIKE ooag_t.ooag011
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_continue        LIKE type_t.num5
                   
   #設定左方的流程圖  
   CALL gfrm_curr.setElementImage("step01","32/step01on.png")   #有on的是顏色不同的圖  
   CALL gfrm_curr.setElementImage("step02","32/step02.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png")
   
   #設定左方的文字顏色 
   CALL gfrm_curr.setElementStyle("step01","menuitemfocus")
   CALL gfrm_curr.setElementStyle("step02","menuitem")
   CALL gfrm_curr.setElementStyle("step03","menuitem")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",TRUE)                 #將第一步的畫面顯示  
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)

   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("save",TRUE)                        #入庫資料寫入底稿      (使用於第一步)  
   CALL cl_set_comp_visible("back_step",FALSE)                  #上一步               (第一步,第三步不使用)
   CALL cl_set_comp_visible("next_step",TRUE)                   #下一步               (第三步不使用) 
   CALL cl_set_comp_visible("continue",FALSE)                   #繼續作業，處理其他資料(使用於第三步) 
   CALL cl_set_comp_visible("open_apmt570",FALSE)               #入庫單維護(使用於第三步)  #160606-00011#1-add
     
   #左下角的框架
   CALL cl_set_comp_visible("condition_vbox",TRUE)              #條件輸入和QBE顯示
   CALL cl_set_comp_visible("main_grid_7,main_grid_9",FALSE)
   
   #設定右方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("view_data,selall,selall_pmdsdocno,unselall",TRUE) 
   CALL cl_set_comp_visible("delete_data,return_step01",FALSE) 
   
   #mark--160706-00037#3 By shiun--(S)
#   #160120-00002#2 s983961--add(s)   
#   #開啟transaction 
#   CALL s_transaction_begin()
#   #160120-00002#2 s983961--add(e) 
   #mark--160706-00037#3 By shiun--(E)
  
   #抓取該營運據點的單據別參照表號
   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004 
     FROM ooef_t 
    WHERE ooefent = g_enterprise 
      AND ooef001 = g_site
   
   LET l_continue = FALSE
   
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT BY NAME g_master.pmds011,g_master.pmdsdocno,g_master.pmds002
         
            AFTER FIELD pmds011
               IF cl_null(g_master_t.pmds011) OR g_master_t.pmds011 <> g_master.pmds011 THEN
                  CASE g_master.pmds011
                     WHEN '1'   #一般入庫單
                          LET l_prog = 'apmt570'
                     WHEN '2'          
                          LET l_prog = 'apmt571'
                     WHEN '10'
                          LET l_prog = 'apmt573'
                     OTHERWISE
                          LET l_prog = ''
                  END CASE
                  
                  LET g_master.pmdsdocno = ''
                  DISPLAY g_master.pmdsdocno TO pmdsdocno
                  DISPLAY '' TO pmdsdocno_desc
               END IF
               LET g_master_t.pmds011 = g_master.pmds011
                
            AFTER FIELD pmdsdocno
               DISPLAY '' TO pmdsdocno_desc
              
               IF NOT cl_null(g_master.pmdsdocno) THEN
                  IF NOT s_aooi200_chk_slip(g_site,'',g_master.pmdsdocno,l_prog) THEN
                     LET g_master.pmdsdocno = ''
                     DISPLAY g_master.pmdsdocno TO pmdsdocno
                     DISPLAY '' TO pmdsdocno_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_aooi200_get_slip_desc(g_master.pmdsdocno) RETURNING l_pmdsdocno_desc
               DISPLAY l_pmdsdocno_desc TO pmdsdocno_desc
             
            AFTER FIELD pmds002
               DISPLAY '' TO pmds002_desc
               
               IF NOT cl_null(g_master.pmds002) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#31  add
                  LET g_chkparam.arg1 = g_master.pmds002
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#31  add
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_master.pmds002 = ''
                     DISPLAY BY NAME g_master.pmds002
                     DISPLAY '' TO pmds002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_desc_get_person_desc(g_master.pmds002) RETURNING l_pmds002_desc
               DISPLAY l_pmds002_desc TO pmds002_desc
                
            ON ACTION controlp
               CASE
                  WHEN INFIELD(pmdsdocno)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'i'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.arg1 = l_ooef004 
                     LET g_qryparam.arg2 = l_prog
                     LET g_qryparam.default1 = g_master.pmdsdocno
                     CALL q_ooba002_1()                              #呼叫開窗                     
                     LET g_master.pmdsdocno = g_qryparam.return1     #將開窗取得的值回傳到變數
                     DISPLAY g_master.pmdsdocno TO pmdsdocno         #顯示到畫面上
                     CALL s_aooi200_get_slip_desc(g_master.pmdsdocno) RETURNING l_pmdsdocno_desc
                     DISPLAY l_pmdsdocno_desc TO pmdsdocno_desc                  
                     NEXT FIELD pmdsdocno    
                  WHEN INFIELD(pmds002)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'i'
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.default1 = g_master.pmds002
                     CALL q_ooag001()                              #呼叫開窗                     
                     LET g_master.pmds002 = g_qryparam.return1     #將開窗取得的值回傳到變數
                     DISPLAY g_master.pmds002 TO pmds002           #顯示到畫面上
                     CALL s_desc_get_person_desc(g_master.pmds002) RETURNING l_pmds002_desc                      DISPLAY l_pmds002_desc TO pmds002_desc
                     NEXT FIELD pmds002   
               END CASE
         END INPUT 
         
         CONSTRUCT BY NAME g_master.wc ON pmdt016,inac003,pmds007,pmdt006,imaf141,pmds006     #160616-00002#2 add pmds006
         

            #存放目前欄位的資料，目的是重進此DIALOG後，資料不被清空
            AFTER FIELD pmdt016
               LET g_pmdt016_t = GET_FLDBUF(pmdt016)
               
            AFTER FIELD inac003
               LET g_inac003_t = GET_FLDBUF(inac003)
               
            AFTER FIELD pmds007
               LET g_pmds007_t = GET_FLDBUF(pmds007)
               
            AFTER FIELD pmdt006
               LET g_pmdt006_t = GET_FLDBUF(pmdt006)
               
            AFTER FIELD imaf141
               LET g_imaf141_t = GET_FLDBUF(imaf141)
           
           #160616-00002#2-s-add
            AFTER FIELD pmds006
               LET g_pmds006_t = GET_FLDBUF(pmds006)           
           #160616-00002#2-e-add
               
            ON ACTION controlp
               CASE
                  WHEN INFIELD(pmdt016)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_inaa001_2()
                     DISPLAY g_qryparam.return1 TO pmdt016  #顯示到畫面上
                     NEXT FIELD CURRENT
                  WHEN INFIELD(inac003)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     #LET g_qryparam.arg1 = '220'  #170213-00038#2   mark
                     #CALL q_oocq002_1()  #170213-00038#2   mark
                     CALL q_oocq002_220() #170213-00038#2   add
                     DISPLAY g_qryparam.return1 TO inac003  #顯示到畫面上
                     NEXT FIELD CURRENT
                  WHEN INFIELD(pmds007)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_pmaa001_3()
                     DISPLAY g_qryparam.return1 TO pmds007  #顯示到畫面上
                     NEXT FIELD CURRENT
                  WHEN INFIELD(pmdt006)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_imaf001_15()
                     DISPLAY g_qryparam.return1 TO pmdt006
                     NEXT FIELD CURRENT
                  WHEN INFIELD(imaf141)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     CALL q_imce141()
                     DISPLAY g_qryparam.return1 TO imaf141  #顯示到畫面上
                     NEXT FIELD CURRENT
                 #160616-00002#2-s-add 
                  WHEN INFIELD(pmds006)
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'c'
                     LET g_qryparam.reqry = FALSE
                     IF g_master.pmds011 = '1' THEN
                        LET g_qryparam.where = " pmds000 IN ('1','2') AND pmdsstus = 'Y' "
                     ELSE
                        LET g_qryparam.where = " pmds000 ='8' AND pmdsstus = 'Y' "
                     END IF                     
                     CALL q_pmdsdocno_1()
                     DISPLAY g_qryparam.return1 TO pmds006  #顯示到畫面上
                     NEXT FIELD CURRENT                     
                  #160616-00002#2-e-add   
               END CASE              
               
         END CONSTRUCT
         
         SUBDIALOG apm_apmp570_01.apmp570_01_input
         SUBDIALOG apm_apmp570_01.apmp570_01_display2
         
         BEFORE DIALOG
            #離開dialog後，條件選項及QBE會被清空，為了維持之前輸入的資料，在此給值
            #採購性質
            LET g_master.pmds011 = g_master_t.pmds011
            IF cl_null(g_master.pmds011) THEN
               LET g_master.pmds011 = '1'
               LET l_prog = 'apmt570'
            END IF
            
            #入庫單別
            LET g_master.pmdsdocno = g_master_t.pmdsdocno
            CALL s_aooi200_get_slip_desc(g_master.pmdsdocno) RETURNING l_pmdsdocno_desc
            DISPLAY l_pmdsdocno_desc TO pmdsdocno_desc
            
            #入庫人員
            LET g_master.pmds002 = g_master_t.pmds002
            IF cl_null(g_master.pmds002) THEN
               LET g_master.pmds002 = g_user
            END IF
            CALL s_desc_get_person_desc(g_master.pmds002) RETURNING l_pmds002_desc
            DISPLAY l_pmds002_desc TO pmds002_desc

            #QBE條件
            DISPLAY g_pmdt016_t TO pmdt016
            DISPLAY g_inac003_t TO inac003
            DISPLAY g_pmds007_t TO pmds007
            DISPLAY g_pmdt006_t TO pmdt006
            DISPLAY g_imaf141_t TO imaf141
            DISPLAY g_pmds006_t TO pmds006    #160616-00002#2 add
            
            IF l_continue = TRUE THEN
               LET l_continue = FALSE
               NEXT FIELD sel_d1_01
            END IF
            
         ON ACTION search_data
            #161124-00024#1 add start -----
            IF cl_null(g_master_t.pmds011) OR g_master_t.pmds011 <> g_master.pmds011 THEN
               CASE g_master.pmds011
                  WHEN '1'   #一般入庫單
                       LET l_prog = 'apmt570'
                  WHEN '2'          
                       LET l_prog = 'apmt571'
                  WHEN '10'
                       LET l_prog = 'apmt573'
                  OTHERWISE
                       LET l_prog = ''
               END CASE
               
               LET g_master.pmdsdocno = ''
               DISPLAY g_master.pmdsdocno TO pmdsdocno
               DISPLAY '' TO pmdsdocno_desc
            END IF
            LET g_master_t.pmds011 = g_master.pmds011
            IF cl_null(g_master.pmdsdocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00603'
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD pmdsdocno
            END IF
            #161124-00024#1 add end   -----
            IF NOT apmp570_master_insert() THEN
               NEXT FIELD pmds011
            END IF
            IF cl_null(g_master.wc) THEN
               LET g_master.wc = " 1=1"
            END IF
            
            CASE g_master.pmds011 
               WHEN '1'
                   #LET g_master.wc = g_master.wc CLIPPED," AND pmds011 NOT IN ('2','10') " #161124-00024#1 mark
                    LET g_master_wc = g_master.wc CLIPPED," AND pmds011 NOT IN ('2','10') " #161124-00024#1 add 
               WHEN '2'
                   #LET g_master.wc = g_master.wc CLIPPED," AND pmds011 = '2' " #161124-00024#1 mark
                    LET g_master_wc = g_master.wc CLIPPED," AND pmds011 = '2' " #161124-00024#1 add
               WHEN '10'
                   #LET g_master.wc = g_master.wc CLIPPED," AND pmds011 = '10' " #161124-00024#1 mark
                    LET g_master_wc = g_master.wc CLIPPED," AND pmds011 = '10' " #161124-00024#1 add
            END CASE
           #LET g_master.wc = cl_replace_str(g_master.wc,'pmds006','pmdsdocno')   #160616-00002#2 add #161124-00024#1 mark
            LET g_master_wc = cl_replace_str(g_master_wc,'pmds006','pmdsdocno')                       #161124-00024#1 add
            CALL s_transaction_begin()        #add--160706-00037#3 By shiun
           #CALL apmp570_01_b_fill(g_master.wc) #161124-00024#1 mark
            CALL apmp570_01_b_fill(g_master_wc) #161124-00024#1 add
            CALL s_transaction_end('Y','0')   #add--160706-00037#3 By shiun
             
         ON ACTION save
            CALL apmp570_01_save_data()
           #LET g_master.wc = cl_replace_str(g_master.wc,'pmds006','pmdsdocno')   #160616-00002#2 add #161124-00024#1 mark
            LET g_master_wc = cl_replace_str(g_master_wc,'pmds006','pmdsdocno')                       #161124-00024#1 add
            CALL s_transaction_begin()        #add--160706-00037#3 By shiun
           #CALL apmp570_01_b_fill(g_master.wc)  #161124-00024#1 mark
            CALL apmp570_01_b_fill(g_master_wc)  #161124-00024#1 add
            CALL s_transaction_end('Y','0')   #add--160706-00037#3 By shiun
            
         ON ACTION continue
         
         ON ACTION back_step
            
         ON ACTION next_step
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM apmp570_01_temp
            IF l_cnt > 0 THEN
               LET g_action_choice = "next_step"
               EXIT DIALOG
            ELSE
               #收貨底稿中不存在任何資料,請先選擇要處理的資料寫入底稿!
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00540'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
            
         ON ACTION view_data
            CALL cl_set_comp_visible("view_data,selall_pmdsdocno",FALSE) 
            CALL cl_set_comp_visible("delete_data,return_step01",TRUE) 
            CALL cl_set_act_visible("save,next_step",FALSE)
            CALL cl_set_comp_visible("save",FALSE)  #160805-00012#1-add
            CALL apmp570_01_b_fill2()   
            LET l_continue = TRUE
            EXIT DIALOG
#            NEXT FIELD CURRENT           #當array為空時,如果沒有寫會出現異常的bug
         
         ON ACTION return_step01
            CALL cl_set_comp_visible("view_data,selall_pmdsdocno",TRUE) 
            CALL cl_set_comp_visible("delete_data,return_step01",FALSE) 
            CALL cl_set_act_visible("save,next_step",TRUE)
            CALL cl_set_comp_visible("save",TRUE)  #160805-00012#1-add
            
            CASE g_master.pmds011 
               WHEN '1'
                   #LET g_master.wc = g_master.wc CLIPPED," AND pmds011 NOT IN ('2','10') " #161124-00024#1 mark
                    LET g_master_wc = g_master.wc CLIPPED," AND pmds011 NOT IN ('2','10') " #161124-00024#1 add 
               WHEN '2'
                   #LET g_master.wc = g_master.wc CLIPPED," AND pmds011 = '2' " #161124-00024#1 mark
                    LET g_master_wc = g_master.wc CLIPPED," AND pmds011 = '2' " #161124-00024#1 add
               WHEN '10'
                   #LET g_master.wc = g_master.wc CLIPPED," AND pmds011 = '10' " #161124-00024#1 mark
                    LET g_master_wc = g_master.wc CLIPPED," AND pmds011 = '10' " #161124-00024#1 add
                    
            END CASE
           #LET g_master.wc = cl_replace_str(g_master.wc,'pmds006','pmdsdocno')   #160616-00002#2 add #161124-00024#1 mark
            LET g_master_wc = cl_replace_str(g_master_wc,'pmds006','pmdsdocno')                       #161124-00024#1 add
           #CALL apmp570_01_b_fill(g_master.wc) #161124-00024#1 mark
            CALL apmp570_01_b_fill(g_master_wc) #161124-00024#1 add 
            LET l_continue = TRUE
            EXIT DIALOG
#            NEXT FIELD CURRENT           #當array為空時,如果沒有寫會出現異常的bug 
            
         ON ACTION step01
               
         ON ACTION step02
         
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
         CONTINUE DIALOG
         
      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF 
      
      LET g_master_t.* = g_master.*
      
      IF l_continue = TRUE THEN
         CONTINUE WHILE
      END IF
      
      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
   
   #mark--160706-00037#3 By shiun--(S)
#   #160120-00002#2 s983961--add(s)   
#   CALL s_transaction_end('Y','0')
#   #160120-00002#2 s983961--add(e) 
   #mark--160706-00037#3 By shiun--(E)
   
   CASE g_action_choice
      WHEN "next_step"
         LET g_action_choice = ''
         RETURN 2
      OTHERWISE
         RETURN 0
   END CASE
   
END FUNCTION

PRIVATE FUNCTION apmp570_ui_dialog_step2()
DEFINE l_success         LIKE type_t.num5
#160120-00002#1 s983961--add(s)   
DEFINE l_sql       STRING
DEFINE l_where     STRING
DEFINE l_pmdtdocno LIKE pmdt_t.pmdtdocno
DEFINE l_pmdtseq   LIKE pmdt_t.pmdtseq
#160120-00002#1 s983961--add(e) 
#add--160706-00037#3 By shiun--(S) 
DEFINE l_docno     LIKE pmdt_t.pmdtdocno
DEFINE l_seq       LIKE pmdt_t.pmdtseq
#add--160706-00037#3 By shiun--(E)

   #設定左方的流程圖  
   CALL gfrm_curr.setElementImage("step01","32/step01.png")    #有on的是顏色不同的圖  
   CALL gfrm_curr.setElementImage("step02","32/step02on.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png") 
   
   #設定左方的文字顏色 
   CALL gfrm_curr.setElementStyle("step01","menuitem")
   CALL gfrm_curr.setElementStyle("step02","menuitemfocus")
   CALL gfrm_curr.setElementStyle("step03","menuitem")
   
   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",TRUE)        #將第二步的畫面顯示  
   CALL cl_set_comp_visible("main_vbox03",FALSE)

   #設定下方的button的 顯示 與 隱藏  
   CALL cl_set_comp_visible("save",FALSE)                       #入庫資料寫入底稿      (使用於第一步)  
   CALL cl_set_comp_visible("back_step",TRUE)                   #上一步               (第一步,第三步不使用)
   CALL cl_set_comp_visible("next_step",TRUE)                   #下一步               (第三步不使用) 
   CALL cl_set_comp_visible("continue",FALSE)                   #繼續作業，處理其他資料(使用於第三步)
   CALL cl_set_comp_visible("open_apmt570",FALSE)               #入庫單維護(使用於第三步)  #160606-00011#1-add
   
   #左下角的框架
   CALL cl_set_comp_visible("condition_vbox",FALSE)
   CALL cl_set_comp_visible("main_grid_7,main_grid_9",TRUE)
   
   #判斷採購性質是"一般"，則將作業編號及作業序隱藏
   CALL cl_set_comp_visible("pmdt009_d2_02,pmdt009_d2_02_desc,pmdt010_d2_02",TRUE)
   CALL cl_set_comp_visible("pmdu003_d3_02,pmdu003_d3_02_desc,pmdu004_d3_02",TRUE)
   CALL cl_set_comp_visible("pmdv003_d5_02,pmdv003_d5_02_desc,pmdv004_d5_02",TRUE)
   IF g_master.pmds011 = '1' THEN
      CALL cl_set_comp_visible("pmdt009_d2_02,pmdt009_d2_02_desc,pmdt010_d2_02",FALSE)
      CALL cl_set_comp_visible("pmdu003_d3_02,pmdu003_d3_02_desc,pmdu004_d3_02",FALSE)
      CALL cl_set_comp_visible("pmdv003_d5_02,pmdv003_d5_02_desc,pmdv004_d5_02",FALSE)
   END IF
   
   #add--160706-00037#3 By shiun--(S)
   CALL s_transaction_begin()

   CALL cl_err_collect_init()

   LET l_sql = "SELECT pmdtdocno,pmdtseq ",
               "  FROM p570_lock_t ",
               " ORDER BY pmdtdocno,pmdtseq "
   PREPARE p570_chk_lock_prep FROM l_sql
   DECLARE p570_chk_lock_curs CURSOR WITH HOLD FOR p570_chk_lock_prep

   LET l_sql = "SELECT pmdtdocno,pmdtseq ",
               "  FROM pmdt_t ",
               " WHERE pmdtent = '",g_enterprise,"' ",
               "   AND pmdtdocno = ? ",
               "   AND pmdtseq   = ? ",
               "   FOR UPDATE SKIP LOCKED "
   PREPARE p570_test_lock_prep FROM l_sql

   LET l_pmdtdocno = ''   
   LET l_pmdtseq   = ''
   FOREACH p570_chk_lock_curs INTO l_pmdtdocno,l_pmdtseq
      LET l_docno = ''   
      LET l_seq   = ''
      EXECUTE p570_test_lock_prep USING l_pmdtdocno,l_pmdtseq
                                   INTO l_docno,l_seq
      IF cl_null(l_docno) OR cl_null(l_seq) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01117'
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = l_pmdtdocno
         LET g_errparam.replace[2] = l_pmdtseq
         CALL cl_err()


         DELETE FROM apmp570_01_temp
          WHERE pmdsdocno = l_pmdtdocno
            AND pmdtseq   = l_pmdtseq

         DELETE FROM p570_lock_t
          WHERE pmdtdocno = l_pmdtdocno
            AND pmdtseq   = l_pmdtseq

      END IF

      LET l_pmdtdocno = ''   
      LET l_pmdtseq   = ''
   END FOREACH

   CALL cl_err_collect_show()

   CALL s_transaction_end('Y','0')
   #add--160706-00037#3 By shiun--(E)
   
   #160120-00002#2 s983961--add(s)   
   #開啟transaction 
   CALL s_transaction_begin()
   #160120-00002#2 s983961--add(e) 
   
   #160120-00002#2 s983961--add(s)
   LET l_sql = "SELECT pmdtdocno,pmdtseq ",
               "  FROM p570_lock_t ",   #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p570_01_lock_b_t ——> p570_lock_t
               " ORDER BY pmdtdocno,pmdtseq "
   PREPARE apmp570_02_lock_prep FROM l_sql
   DECLARE apmp570_02_lock_curs CURSOR FOR apmp570_02_lock_prep

   LET l_sql = "SELECT pmdtdocno,pmdtseq ",
               "  FROM pmdt_t ",
               #160706-00037#3-mod-s
#               " WHERE "
               " WHERE pmdtent = ",g_enterprise," AND ("
               #160706-00037#3-mod-e

   LET l_where = ''
   FOREACH apmp570_02_lock_curs INTO l_pmdtdocno,l_pmdtseq
      IF cl_null(l_where) THEN
         LET l_where = "(pmdtdocno = '",l_pmdtdocno,"' AND pmdtseq = '",l_pmdtseq,"')"
      ELSE
         LET l_where = l_where," OR ","(pmdtdocno = '",l_pmdtdocno,"' AND pmdtseq = '",l_pmdtseq,"')"
      END IF
   END FOREACH
   #add--160706-00037#3 By 08993--(S)
   IF cl_null(l_where) THEN
      LET l_where  = " 1=2 "
   END IF
   LET l_where = l_where," )"
   #add--160706-00037#3 By 08993--(E)
   LET l_sql = l_sql,l_where," FOR UPDATE " 
   PREPARE apmp570_02_lock_body_prep FROM l_sql
   DECLARE apmp570_02_lock_body_curs CURSOR FOR apmp570_02_lock_body_prep
   OPEN apmp570_02_lock_body_curs
   #160120-00002#2 s983961--add(e)
   
   CALL apmp570_02_gen_data()
   CALL apmp570_02_b_fill()
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         SUBDIALOG apm_apmp570_02.apmp570_02_display 
         #SUBDIALOG apm_apmp570_02.apmp570_02_input2   #151118-00029#3 Mark By Ken 160225
         SUBDIALOG apm_apmp570_02.apmp570_02_display2  #151118-00029#3 Add By Ken 160225
         SUBDIALOG apm_apmp570_02.apmp570_02_display3
         SUBDIALOG apm_apmp570_02.apmp570_02_display5
         BEFORE DIALOG

         ON ACTION save
         
         ON ACTION continue
         
         #151118-00029#2 Add By Ken 160225(S)
         ON ACTION apmp570_02_modify_detail
            CALL apmp570_02_b()
         #151118-00029#2 Add By Ken 160225(E)         
         
         ON ACTION back_step
            IF cl_ask_confirm('apm-00541') THEN
               LET g_action_choice = "back_step"
               EXIT DIALOG
            END IF
            
         ON ACTION next_step
            LET g_action_choice = "next_step"
            CALL apmp570_02_upd_data()
            EXIT DIALOG
            
         ON ACTION step01
            
         ON ACTION step02
         
         ON ACTION step03

         ON ACTION CLOSE
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG

      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF 
      
      IF cl_null(g_action_choice) THEN
         CONTINUE WHILE
      END IF
      
      IF g_action_choice = "next_step" THEN
         #檢查應該要輸入的欄位是否都有值了
         CALL apmp570_02_field_check() RETURNING l_success
         IF NOT l_success THEN
            CONTINUE WHILE
         END IF
               
         IF cl_ask_confirm('apm-00631') THEN
            EXIT WHILE
         END IF 
         CONTINUE WHILE
      END IF
     
      EXIT WHILE
   END WHILE
   
   #160120-00002#2 s983961--add(s)   
   CALL s_transaction_end('Y','0')
   #160120-00002#2 s983961--add(e) 
   
   CASE g_action_choice
      WHEN "next_step"
         RETURN 3
      WHEN "back_step"
         RETURN 1
      OTHERWISE
         RETURN 0
   END CASE
END FUNCTION

PRIVATE FUNCTION apmp570_ui_dialog_step3()
   
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
   CALL cl_set_comp_visible("main_vbox03",TRUE)       #將第二步的畫面顯示

   #設定下方的button的 顯示 與 隱藏 
   CALL cl_set_comp_visible("save",FALSE)             #入庫資料寫入底稿      (使用於第一步)
   CALL cl_set_comp_visible("back_step",FALSE)        #上一步               (第一步,第三步不使用)
   CALL cl_set_comp_visible("next_step",FALSE)        #下一步               (第三步不使用) 
   CALL cl_set_comp_visible("continue",TRUE)          #繼續作業，處理其他資料(使用於第三步)
   CALL cl_set_comp_visible("open_apmt570",TRUE)      #入庫單維護(使用於第三步)  #160606-00011#1-add
   
   #左下角的框架
   CALL cl_set_comp_visible("condition_vbox",FALSE)
   CALL cl_set_comp_visible("main_grid_7,main_grid_9",TRUE)
   
   #判斷採購性質是"一般"，則將作業編號及作業序隱藏
   CALL cl_set_comp_visible("pmdt009_d2_03,pmdt009_d2_03_desc,pmdt010_d2_03",TRUE)
   CALL cl_set_comp_visible("pmdu003_d3_03,pmdu003_d3_03_desc,pmdu004_d3_03",TRUE)
   CALL cl_set_comp_visible("pmdv003_d5_03,pmdv003_d5_03_desc,pmdv004_d5_03",TRUE)
   IF g_master.pmds011 = '1' THEN
      CALL cl_set_comp_visible("pmdt009_d2_03,pmdt009_d2_03_desc,pmdt010_d2_03",FALSE)
      CALL cl_set_comp_visible("pmdu003_d3_03,pmdu003_d3_03_desc,pmdu004_d3_03",FALSE)
      CALL cl_set_comp_visible("pmdv003_d5_03,pmdv003_d5_03_desc,pmdv004_d5_03",FALSE)
   END IF
   
   #160120-00002#2 s983961--add(s)   
   #開啟transaction 
   CALL s_transaction_begin()
   #160120-00002#2 s983961--add(e) 
   
   CALL apmp570_03_gen_data()
   CALL apmp570_03_b_fill()
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         SUBDIALOG apm_apmp570_03.apmp570_03_display 
         SUBDIALOG apm_apmp570_03.apmp570_03_display2
         SUBDIALOG apm_apmp570_03.apmp570_03_display3
         SUBDIALOG apm_apmp570_03.apmp570_03_display5

         BEFORE DIALOG

         ON ACTION save
         
         ON ACTION continue
        #   IF cl_ask_confirm('apm-00542') THEN
               LET g_action_choice = "continue"
               EXIT DIALOG
        #   END IF 
            
         ON ACTION step01
            
         ON ACTION step02
         
         ON ACTION step03
         
         #160606-00011#1-add-(S)
         ON ACTION open_apmt570     #入庫單維護   
            CALL apmp570_03_open_apmt570()
         #160606-00011#1-add-(E)
         
         ON ACTION CLOSE
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG

      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF 
      
      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE
   
   #160120-00002#2 s983961--add(s)   
   CALL s_transaction_end('Y','0')
   #160120-00002#2 s983961--add(e) 
   
   CASE g_action_choice
      WHEN "continue"
         RETURN 1
      OTHERWISE
         RETURN 0
   END CASE
END FUNCTION
#將 所有temp table 的資料刪除
PRIVATE FUNCTION apmp570_delete_temp()
   CALL apmp570_01_delete_temp_table()
   CALL apmp570_02_delete_temp_table()
END FUNCTION

################################################################################
# Descriptions...: Create Temp Table
# Memo...........:
# Usage..........: CALL apmp570_create_temp_table()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/10/06 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp570_create_temp_table()
DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT apmp570_drop_temp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE apmp570_tmp01(   #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01
      pmdsdocno       VARCHAR(20),
      pmds002         VARCHAR(20),
      pmds011         VARCHAR(10)
     )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apmp570_tmp01'  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: Drop Temp Table
# Memo...........:
# Usage..........: CALL apmp570_drop_temp_table()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/10/06 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp570_drop_temp_table()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE apmp570_tmp01  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop apmp570_tmp01'  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
  
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 將輸入條件暫存到temp table
# Memo...........:
# Usage..........: CALL apmp570_master_insert()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/10/06 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp570_master_insert()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DELETE FROM apmp570_tmp01  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del apmp570_tmp01'  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   INSERT INTO apmp570_tmp01(pmdsdocno,pmds002,pmds011)  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01
      VALUES (g_master.pmdsdocno,g_master.pmds002,g_master.pmds011)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins apmp570_tmp01'  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
