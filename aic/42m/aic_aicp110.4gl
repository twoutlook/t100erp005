#該程式未解開Section, 採用最新樣板產出!
{<section id="aicp110.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-05-08 16:55:23), PR版次:0009(2017-02-15 16:50:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: aicp110
#+ Description: 多角貿易訂單拋轉還原作業
#+ Creator....: 03079(2014-10-31 09:53:29)
#+ Modifier...: 04543 -SD/PR- 08171
 
{</section>}
 
{<section id="aicp110.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#161024-00057#13 2016/10/26 By Whitney  刪除sfad_t和sfae_t相關程式
#170106-00005#1  2017/01/12 BY charles4m 判斷要改為 銷售逆拋 判斷最終站、銷售正拋 判斷 來源站 是否有 非作廢的出通單、出貨單
#170111-00026#2  2017/01/23 By 08993    修改拋轉還原，未排除過廢單據
#161231-00013#1  2016/01/24 By 08992   增加azzi850 部門權限控管
#170206-00010#1  2017/02/08 By charles4m 不同 ent 有相同的訂單單號，程式少判斷到 ent 當SQL 條件，沒撈到資料
#170213-00043#1  2017/02/15 By 08171   若拋轉成功後已無符合的資料則不提示[指定的資料無法查詢到，....]  
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
                        sel            LIKE type_t.chr1,      #選取項目 
                        xmda005        LIKE xmda_t.xmda005,   #訂單性質 
                        xmdadocno      LIKE xmda_t.xmdadocno, #訂單單號 
                        xmdadocdt      LIKE xmda_t.xmdadocdt, #訂單日期 
                        xmda004        LIKE xmda_t.xmda004,   #客戶編號 
                        xmda004_desc   LIKE type_t.chr80,     #交易對象簡稱 
                        xmda002        LIKE xmda_t.xmda002,   #業務人員 
                        xmda002_desc   LIKE type_t.chr80,     #全名 
                        xmda003        LIKE xmda_t.xmda003,   #業務部門 
                        xmda003_desc   LIKE type_t.chr80,     #說明 
                        xmda033        LIKE xmda_t.xmda033,   #客戶訂購單號 
                        xmdaownid      LIKE xmda_t.xmdaownid, #資料所有者 
                        xmdaownid_desc LIKE type_t.chr80,     #員工名  
                        xmdacrtid      LIKE xmda_t.xmdacrtid, #資料建立者 
                        xmdacrtid_desc LIKE type_t.chr80,     #員工名   
                        xmda050        LIKE xmda_t.xmda050,   #多角流程代碼 
                        xmda050_desc   LIKE type_t.chr80,     #說明 
                        xmda031        LIKE xmda_t.xmda031    #多角來源單號 
                     END RECORD
TYPE type_g_detail2_d RECORD
                         xmdcseq        LIKE xmdc_t.xmdcseq,   #訂單項次 
                         xmdc027        LIKE xmdc_t.xmdc027,   #客戶料號 
                         xmdc001        LIKE xmdc_t.xmdc001,   #料件編號 
                         xmdc001_desc   LIKE type_t.chr80,     #品名  
                         xmdc001_desc_1 LIKE type_t.chr80,     #規格 
                         xmdc012        LIKE xmdc_t.xmdc012,   #約定交貨日 
                         xmdcunit       LIKE xmdc_t.xmdcunit,  #出貨據點 
                         xmdcunit_desc  LIKE type_t.chr80      #說明 
                      END RECORD
TYPE type_g_detail3_d RECORD
                         xmdadocno1     LIKE xmda_t.xmdadocno, #訂單單號  
                         xmdadocdt1     LIKE xmda_t.xmdadocdt, #訂單日期 
                         xmda0041       LIKE xmda_t.xmda004,   #客戶編號 
                         xmda0041_desc  LIKE type_t.chr80,     #交易對象簡稱 
                         xmda0021       LIKE xmda_t.xmda002,   #業務人員 
                         xmda0021_desc  LIKE type_t.chr80,     #全名 
                         xmda0031       LIKE xmda_t.xmda003,   #業務部門 
                         xmda0031_desc  LIKE type_t.chr80,     #簡稱 
                         xmda0501       LIKE xmda_t.xmda050    #多角流程代碼 
                      END RECORD
TYPE type_g_detail4_d RECORD
                         xmdadocno2     LIKE xmda_t.xmdadocno, #訂單單號 
                         xmdadocdt2     LIKE xmda_t.xmdadocdt, #訂單日期 
                         xmda0042       LIKE xmda_t.xmda004,   #客戶編號 
                         xmda0042_desc  LIKE type_t.chr80,     #交易對象簡稱 
                         xmda0022       LIKE xmda_t.xmda002,   #業務人員  
                         xmda0022_desc  LIKE type_t.chr80,     #全名 
                         xmda0032       LIKE xmda_t.xmda003,   #業務部門 
                         xmda0032_desc  LIKE type_t.chr80,     #簡稱 
                         xmda0312       LIKE xmda_t.xmda031,   #多角流程代碼 
                         xmdasite2      LIKE xmda_t.xmdasite,  #營運據點
                         xmdasite2_desc LIKE type_t.chr80,     #營運據點名稱
                         reason         LIKE type_t.chr1000    #失敗原因 
                      END RECORD
DEFINE g_detail_d_t   type_g_detail_d
DEFINE g_detail2_d    DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_d_t  type_g_detail2_d
DEFINE g_detail2_cnt  LIKE type_t.num5
DEFINE g_detail3_d    DYNAMIC ARRAY OF type_g_detail3_d 
DEFINE g_detail3_cnt  LIKE type_t.num5
DEFINE g_detail4_d    DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail4_cnt  LIKE type_t.num5

DEFINE g_rec_b        LIKE type_t.num5 
DEFINE g_success_cnt  LIKE type_t.num5
DEFINE g_fail_cnt     LIKE type_t.num5
DEFINE g_aicp110_sel     STRING
#170106-00005#1 ---add (s)---
TYPE type_g_xmda_d  RECORD
                         icaa004      LIKE icaa_t.icaa004,
                         icaa011      LIKE icaa_t.icaa011,
                         icab002      LIKE icab_t.icab002,
                         xmdadocno    LIKE xmda_t.xmdadocno,
                         xmdadocdt    LIKE xmda_t.xmdadocdt,
                         xmda004      LIKE xmda_t.xmda004,
                         xmda002      LIKE xmda_t.xmda002,
                         xmda003      LIKE xmda_t.xmda003,
                         xmda033      LIKE xmda_t.xmda033,
                         xmdaownid    LIKE xmda_t.xmdaownid,
                         xmdacrtid    LIKE xmda_t.xmdacrtid,
                         xmda050      LIKE xmda_t.xmda050,
                         xmda031      LIKE xmda_t.xmda031,
                         xmdaent      LIKE xmda_t.xmdaent
                      END RECORD
DEFINE g_xmda_d   DYNAMIC ARRAY OF type_g_xmda_d
DEFINE g_xmda_d_t type_g_xmda_d
#170106-00005#1 ---add (e)---
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aicp110.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aic","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL aicp110_create_temp_table()

   CALL aicp110_sel()

   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " xmdadocno = '",g_argv[1],"' "
         CALL aicp110_query()
         
         UPDATE aicp110_tmp SET sel = 'Y'

         CALL aicp110_process()
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp110 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp110_init()   
 
      #進入選單 Menu (="N")
      CALL aicp110_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp110
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aicp110_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp110.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp110_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("xmda005",'2063')
   CALL cl_set_combo_scc("b_xmda005",'2063')
   
   LET g_errshow = 1
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp110.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp110_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_cnt    LIKE type_t.num5
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_wc = " 1=1"
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aicp110_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON xmda005,xmdadocno,xmdadocdt,xmda004,
                                   xmda002,xmda003,xmda033,xmdaownid,
                                   xmdacrtid,xmda050,xmda031
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD xmdadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE 
               LET g_qryparam.where = g_aicp110_sel
               
               CALL q_xmdadocno()                         #呼叫開窗  
               DISPLAY g_qryparam.return1 TO xmdadocno    #顯示到畫面上  
               NEXT FIELD xmdadocno                       #返回原欄位  

            ON ACTION controlp INFIELD xmda004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()                         #呼叫開窗  
               DISPLAY g_qryparam.return1 TO xmda004      #顯示到畫面上  
               NEXT FIELD xmda004                         #返回原欄位  

            ON ACTION controlp INFIELD xmda002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE

               CALL q_ooag001()                           #呼叫開窗  
               DISPLAY g_qryparam.return1 TO xmda002      #顯示到畫面上  
               NEXT FIELD xmda002                         #返回原欄位  

            ON ACTION controlp INFIELD xmda003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE

               CALL q_ooeg001()                           #呼叫開窗 
               DISPLAY g_qryparam.return1 TO xmda003      #顯示到畫面上  
               NEXT FIELD xmda003                         #返回原欄位  

            ON ACTION controlp INFIELD xmdaownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE

               CALL q_ooag001()                           #呼叫開窗 
               DISPLAY g_qryparam.return1 TO xmdaownid    #顯示到畫面上  
               NEXT FIELD xmdaownid                       #返回原欄位  

            ON ACTION controlp INFIELD xmdacrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE

               CALL q_ooag001()                           #呼叫開窗 
               DISPLAY g_qryparam.return1 TO xmdacrtid    #顯示到畫面上   
               NEXT FIELD xmdacrtid                       #返回原欄位  

            ON ACTION controlp INFIELD xmda050
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '1'

               CALL q_icaa001_1()                         #呼叫開窗  
               DISPLAY g_qryparam.return1 TO xmda050      #顯示到畫面上  
               NEXT FIELD xmda050                         #返回原欄位  

            ON ACTION controlp INFIELD xmda031
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE

               CALL q_xmda031()                           #呼叫開窗  
               DISPLAY g_qryparam.return1 TO xmda031      #顯示到畫面上  
               NEXT FIELD xmda031                         #返回原欄位  
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
               ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                         INSERT ROW = FALSE,
                         DELETE ROW = FALSE,
                         APPEND ROW = FALSE)
            BEFORE INPUT
               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
                  CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1)
                  LET g_insert = 'N'
               END IF

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL aicp110_fetch()

            ON ROW CHANGE
               UPDATE aicp110_tmp SET sel = g_detail_d[l_ac].sel
                WHERE xmdadocno = g_detail_d[l_ac].xmdadocno

         END INPUT 
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail2_cnt)
            BEFORE DISPLAY

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               DISPLAY l_ac TO FORMONLY.idx

         END DISPLAY

         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail3_cnt)
            BEFORE DISPLAY

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               DISPLAY l_ac TO FORMONLY.idx

         END DISPLAY

         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail4_cnt)
            BEFORE DISPLAY

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               DISPLAY l_ac TO FORMONLY.idx

         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL gfrm_curr.setFieldHidden("formonly.sel",FALSE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic",FALSE) 
            
            CALL aicp110_sel()
            
            IF g_detail_d.getLength() = 0 THEN
               NEXT FIELD xmda005
            END IF
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            UPDATE aicp110_tmp SET sel = 'Y'
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            UPDATE aicp110_tmp SET sel = 'N'
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1",li_idx) THEN
                  UPDATE aicp110_tmp SET sel = 'Y'
                   WHERE xmdadocno = g_detail_d[li_idx].xmdadocno
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1",li_idx) THEN
                  UPDATE aicp110_tmp SET sel = 'N'
                   WHERE xmdadocno = g_detail_d[li_idx].xmdadocno
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp110_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL aicp110_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aicp110_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute 
            IF l_ac > 0 THEN 
               UPDATE aicp110_tmp SET sel = g_detail_d[l_ac].sel
                WHERE xmdadocno = g_detail_d[l_ac].xmdadocno
            END IF 

            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM aicp110_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = '-400'
               LET g_errparam.popup  = TRUE
               CALL cl_err()

            ELSE
               CALL aicp110_process() 
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp110_query() 
               LET INT_FLAG = FALSE    #170213-00043#1 17/02/15 By 08171 add
            END IF 
            ACCEPT DIALOG
            
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp110.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp110_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   DELETE FROM aicp110_tmp;
   
  #170106-00005#1 ---mark (s)---  
  #LET g_sql = "SELECT DISTINCT 'N',xmda005,xmdadocno,xmdadocdt,xmda004, ",
  #            "                xmda002,xmda003,xmda033,xmdaownid, ",
  #            "                xmdacrtid,xmda050,xmda031,xmdaent ", 
  #            "  FROM xmda_t ",
  #            " WHERE ",g_aicp110_sel,
  #            "   AND ",g_wc
  #170106-00005#1 ---mark (e)---

  #170106-00005#1 ---add (s)---  
  LET l_ac = 1
  LET g_sql = " SELECT icaa004,icaa011,icab002,xmdadocno,xmdadocdt,xmda004, ",
               "       xmda002,xmda003,xmda033,xmdaownid, ",
               "       xmdacrtid,xmda050,xmda031,xmdaent ", 
               "  FROM xmda_t,icab_t,icaa_t ",
               " WHERE ",g_aicp110_sel,
              #"   AND icabent=xmdaent AND icab003=xmdasite AND icaaent=xmdaent AND icaasite=xmdasite ", #170206-00010#1 mark
               "   AND icabent=xmdaent AND icab003=xmdasite AND icaaent=xmdaent ", #170206-00010#1 add
               "   AND icaa001=xmda050 AND icab001=xmda050 ",
               "   AND ",g_wc
               
  PREPARE aicp110_xmda_1_pre FROM g_sql
  DECLARE aicp110_xmda_1_cur CURSOR FOR aicp110_xmda_1_pre
  FOREACH aicp110_xmda_1_cur INTO g_xmda_d[l_ac].*
      
     LET g_sql = "    SELECT DISTINCT 'N',xmda005,xmdadocno,xmdadocdt,xmda004, ",
                 "                xmda002,xmda003,xmda033,xmdaownid, ",
                 "                xmdacrtid,xmda050,xmda031,xmdaent ",   
                 "      FROM xmda_t a, icab_t c ", 
                 "     WHERE c.icabent = a.xmdaent AND c.icab001 = '",g_xmda_d[l_ac].xmda050,"'", 
                 "       AND a.xmdadocno = '",g_xmda_d[l_ac].xmdadocno,"'",
                 "       AND c.icab002 = '0' "
              
     IF g_xmda_d[l_ac].icaa004 = '1' THEN 
        LET g_sql = g_sql , "   AND (c.icab002 = '0' ", #銷售正拋，來源站不可存在非作廢的出貨單  
                            "   AND NOT EXISTS(SELECT * FROM xmdk_t,xmdl_t",
                            "                   WHERE xmdkent = xmdlent ",
                            "                     AND xmdkdocno = xmdldocno",
                            "                     AND xmdkent = a.xmdaent", #170206-00010#1 add
                            "                     AND xmdl003 = a.xmdadocno ",
                            "                     AND xmdkstus <> 'X')"
     ELSE
        LET g_sql = g_sql , "   AND (NOT EXISTS (SELECT 1 FROM xmda_t b, icab_t d, xmdl_t, xmdk_t",  #銷售逆拋、最終站不可存在非作廢的出貨單
                            "                            WHERE b.xmda031 = a.xmda031 AND d.icab001 = c.icab001 ",
                            "                              AND b.xmdaent = d.icabent AND b.xmda050 = d.icab001 ",
                            "                              AND b.xmdasite = d.icab003 ",
                            "                              AND xmdkent = a.xmdaent", #170206-00010#1 add
                            "                              AND xmdl003 = b.xmdadocno AND xmdkent = xmdlent ",
                            "                              AND xmdkdocno = xmdldocno AND xmdkstus <> 'X' ",
                            "                              AND d.icab002 = (SELECT MAX (e.icab002) ",
                            "                                                 FROM icab_t e ",
                            "                                                WHERE e.icabent = d.icabent AND e.icab001 = d.icab001)) "
     END IF 

     IF g_xmda_d[l_ac].icaa011 = '1' THEN
        LET g_sql = g_sql , "   AND c.icab002 = '0' ", #銷售正拋，來源站不可存在非作廢的出通單  
                            "   AND NOT EXISTS(SELECT * FROM xmdg_t,xmdh_t",
                            "                   WHERE xmdgent = xmdhent ",
                            "                     AND xmdgdocno = xmdhdocno",
                            "                     AND xmdgent = a.xmdaent", #170206-00010#1 add
                            "                     AND xmdh001 = a.xmdadocno",
                            "                     AND xmdgstus <> 'X'))"
     ELSE
        LET g_sql = g_sql , "   AND NOT EXISTS(SELECT 1 FROM xmda_t f, icab_t g, xmdg_t,xmdh_t ", #銷售逆拋、最終站不可存在非作廢的出通單
                            "                            WHERE f.xmda031 = a.xmda031 AND g.icab001 = c.icab001 ",
                            "                              AND f.xmdaent = g.icabent AND f.xmda050 = g.icab001 ",
                            "                              AND f.xmdasite = g.icab003 ",
                            "                              AND xmdgent = a.xmdaent", #170206-00010#1 add
                            "                              AND xmdh001 = f.xmdadocno AND xmdgent = xmdhent ",
                            "                              AND xmdgdocno = xmdhdocno AND xmdgstus <> 'X' ",
                            "                              AND g.icab002 = (SELECT MAX (h.icab002) ",
                            "                                                 FROM icab_t h ",
                            "                                                WHERE h.icabent = g.icabent AND h.icab001 = g.icab001))) "
     END IF  

  #170106-00005#1 ---add (e)---

      LET g_sql = "INSERT INTO aicp110_tmp ",
                  "   (sel,xmda005,xmdadocno,xmdadocdt,xmda004, xmda002, ",
                  "    xmda003,xmda033,xmdaownid,xmdacrtid,xmda050,xmda031,xmdaent) ",g_sql
      PREPARE tmp_ins_pre FROM g_sql
      EXECUTE tmp_ins_pre
      
      LET l_ac = l_ac + 1 #170106-00005#1 add
      
   END FOREACH #170106-00005#1 add

   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp110_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp110.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp110_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT 'N',xmda005,xmdadocno,xmdadocdt,xmda004,'', ",
               "                xmda002,'',xmda003,'',xmda033,xmdaownid,'', ",
               "                xmdacrtid,'',xmda050,'',xmda031 ",
               "  FROM aicp110_tmp ",
               " WHERE xmdaent = ? ",
               "   AND ",g_wc_filter,
               " ORDER BY xmdadocno "
   #end add-point
 
   PREPARE aicp110_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp110_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail2_d.clear()
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].xmda005,g_detail_d[l_ac].xmdadocno,
      g_detail_d[l_ac].xmdadocdt,g_detail_d[l_ac].xmda004,g_detail_d[l_ac].xmda004_desc,
      g_detail_d[l_ac].xmda002,g_detail_d[l_ac].xmda002_desc,g_detail_d[l_ac].xmda003,
      g_detail_d[l_ac].xmda003_desc,g_detail_d[l_ac].xmda033,g_detail_d[l_ac].xmdaownid,
      g_detail_d[l_ac].xmdaownid_desc,g_detail_d[l_ac].xmdacrtid,g_detail_d[l_ac].xmdacrtid_desc,
      g_detail_d[l_ac].xmda050,g_detail_d[l_ac].xmda050_desc,g_detail_d[l_ac].xmda031
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
      #客戶編號的說明 
      LET g_detail_d[l_ac].xmda004_desc = ''
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmda004)
           RETURNING g_detail_d[l_ac].xmda004_desc

      #業務人員的說明 
      LET g_detail_d[l_ac].xmda002_desc = ''
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmda002)
           RETURNING g_detail_d[l_ac].xmda002_desc

      #業務部門的說明 
      LET g_detail_d[l_ac].xmda003_desc = ''
      CALL s_desc_get_department_desc(g_detail_d[l_ac].xmda003)
           RETURNING g_detail_d[l_ac].xmda003_desc

      #資料所有者的說明 
      LET g_detail_d[l_ac].xmdaownid_desc = ''
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdaownid)
           RETURNING g_detail_d[l_ac].xmdaownid_desc

      #資料建立者的說明 
      LET g_detail_d[l_ac].xmdacrtid_desc = ''
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdacrtid)
           RETURNING g_detail_d[l_ac].xmdacrtid_desc

      #多角流程代碼的說明 
      LET g_detail_d[l_ac].xmda050_desc = ''
      CALL aicp110_get_icaal003(g_detail_d[l_ac].xmda050)
           RETURNING g_detail_d[l_ac].xmda050_desc
      #end add-point
      
      CALL aicp110_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   
   IF g_detail_d.getLength() > 0 THEN
      LET g_master_idx = 1
   ELSE
      LET g_master_idx = 0
   END IF
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aicp110_sel
   
   LET l_ac = 1
   CALL aicp110_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp110.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp110_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()

   IF cl_null(g_master_idx) OR g_master_idx <=0 THEN
      RETURN
   END IF

   LET l_ac = 1
   LET g_sql = "SELECT xmdcseq,xmdc027,xmdc001,'','',xmdc012,xmdcunit,'' ",
               "  FROM xmdc_t ",
               " WHERE xmdcent = '",g_enterprise,"' ",
               "   AND xmdcdocno = '",g_detail_d[g_master_idx].xmdadocno,"' ",
               " ORDER BY xmdcseq "
   PREPARE xmdc_fill_pre FROM g_sql
   DECLARE xmdc_fill_cur CURSOR FOR xmdc_fill_pre

   FOREACH xmdc_fill_cur INTO g_detail2_d[l_ac].xmdcseq,g_detail2_d[l_ac].xmdc027,
                              g_detail2_d[l_ac].xmdc001,g_detail2_d[l_ac].xmdc001_desc,
                              g_detail2_d[l_ac].xmdc001_desc_1,g_detail2_d[l_ac].xmdc012,
                              g_detail2_d[l_ac].xmdcunit,g_detail2_d[l_ac].xmdcunit_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()

         EXIT FOREACH
      END IF 
      
      #取得品名、規格 
      CALL s_desc_get_item_desc(g_detail2_d[l_ac].xmdc001)
           RETURNING g_detail2_d[l_ac].xmdc001_desc,
                     g_detail2_d[l_ac].xmdc001_desc_1

      #取得出貨據點說明 
      CALL aicp110_get_ooefl003(g_detail2_d[l_ac].xmdcunit)
           RETURNING g_detail2_d[l_ac].xmdcunit_desc

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = 9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()

         END IF

         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   LET g_detail_cnt = l_ac - 1

   DISPLAY g_detail_cnt TO FORMONLY.cnt
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aicp110.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp110_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp110.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp110_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   CLEAR FORM
   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()

   CONSTRUCT g_wc_filter ON xmda005,xmdadocno,xmdadocdt,xmda004,
                            xmda002,xmda003,xmda033,xmdaownid,
                            xmdacrtid,xmda050,xmda031
        FROM s_detail1[1].b_xmda005,s_detail1[1].b_xmdadocno,s_detail1[1].b_xmdadocdt,
             s_detail1[1].b_xmda004,s_detail1[1].b_xmda002,s_detail1[1].b_xmda003,
             s_detail1[1].b_xmda033,s_detail1[1].b_xmdaownid,s_detail1[1].b_xmdacrtid,
             s_detail1[1].b_xmda050,s_detail1[1].b_xmda031
      BEFORE CONSTRUCT

      ON ACTION controlp INFIELD b_xmdadocno
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = g_aicp110_sel
         
         CALL q_xmdadocno()
         DISPLAY g_qryparam.return1 TO b_xmdadocno   #顯示到畫面上  
         NEXT FIELD b_xmdadocno                      #返回原欄位   
         
      ON ACTION controlp INFIELD b_xmda004
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = g_site
         CALL q_pmaa001_6()                         #呼叫開窗  
         DISPLAY g_qryparam.return1 TO b_xmda004    #顯示到畫面上  
         NEXT FIELD b_xmda004                       #返回原欄位  

      ON ACTION controlp INFIELD b_xmda002
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE

         CALL q_ooag001()                           #呼叫開窗 
         DISPLAY g_qryparam.return1 TO b_xmda002    #顯示到畫面上  
         NEXT FIELD b_xmda002                       #返回原欄位 

      ON ACTION controlp INFIELD b_xmda003
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE

         CALL q_ooeg001()                           #呼叫開窗 
         DISPLAY g_qryparam.return1 TO b_xmda003    #顯示到畫面上 
         NEXT FIELD b_xmda003                       #返回原欄位 

      ON ACTION controlp INFIELD b_xmdaownid
         INITIALIZE g_qryparam.* TO NULL 
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE

         CALL q_ooag001()                           #呼叫開窗  
         DISPLAY g_qryparam.return1 TO b_xmdaownid  #顯示到畫面上  
         NEXT FIELD b_xmdaownid                     #返回原欄位  

      ON ACTION controlp INFIELD b_xmdacrtid
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE

         CALL q_ooag001()                           #呼叫開窗  
         DISPLAY g_qryparam.return1 TO b_xmdacrtid  #顯示到畫面上  
         NEXT FIELD b_xmdacrtid                     #返回原欄位  

      ON ACTION controlp INFIELD b_xmda050
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = '1'

         CALL q_icaa001_1()                         #呼叫開窗 
         DISPLAY g_qryparam.return1 TO b_xmda050    #顯示到畫面上 
         NEXT FIELD b_xmda050                       #返回原欄位 

      ON ACTION controlp INFIELD b_xmda031
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c' 
         LET g_qryparam.reqry = FALSE

         CALL q_xmda031()                           #呼叫開窗 
         DISPLAY g_qryparam.return1 TO b_xmda031    #顯示到畫面上 
         NEXT FIELD b_xmda031                       #返回原欄位  
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp110_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp110.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp110_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
   #end add-point    
   
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="aicp110.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp110_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aicp110_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp110.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp110_process()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/10 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp110_process()
   DEFINE l_xmda002       LIKE xmda_t.xmda002          #業務人員  
   DEFINE l_xmda003       LIKE xmda_t.xmda003          #業務部門  
   DEFINE l_xmda004       LIKE xmda_t.xmda004          #客戶編號  
   DEFINE l_xmda005       LIKE xmda_t.xmda005          #訂單性質    
   DEFINE l_xmda031       LIKE xmda_t.xmda031          #多角流程序號 
   DEFINE l_xmda050       LIKE xmda_t.xmda050          #多角流程代碼  
   DEFINE l_xmdadocno     LIKE xmda_t.xmdadocno        #訂單單號  
   DEFINE l_xmdadocdt     LIKE xmda_t.xmdadocdt        #訂單日期  

   DEFINE l_icab002_now   LIKE icab_t.icab002          #站別(當站)  
   DEFINE l_icab003_now   LIKE icab_t.icab003          #營運據點(當站)  
   DEFINE l_icab004_now   LIKE icab_t.icab004          #是否為委外工單開立點(當站)  

   DEFINE l_xmdadocno_now LIKE xmda_t.xmdadocno        #訂單單號(當站) 
   DEFINE l_xmdadocdt_now LIKE xmda_t.xmdadocdt 
   DEFINE l_xmda006_now   LIKE xmda_t.xmda006          #多角性質(當站) 

   DEFINE l_success       LIKE type_t.num5
   
   #有選擇的訂單 
   LET g_sql = "SELECT xmda005,xmda004,xmdadocno,xmdadocdt,xmda002,xmda003, ",
               "       xmda031,xmda050 ",
               "  FROM aicp110_tmp ",
               " WHERE sel = 'Y' ",
               " ORDER BY xmdadocno "
   PREPARE aicp110_process_pre FROM g_sql
   DECLARE aicp110_process_cur CURSOR WITH HOLD FOR aicp110_process_pre

   #當站多角貿易營運據點(反向)   
   LET g_sql = "SELECT icab002,icab003,icab004 ",
               "  FROM icab_t ",
               " WHERE icabent = '",g_enterprise,"' ",
               "   AND icab001 = ? ",
               " ORDER BY icab002 DESC "
   PREPARE aicp110_process_icab_pre FROM g_sql
   DECLARE aicp110_process_icab_cur CURSOR FOR aicp110_process_icab_pre

   LET l_success = TRUE
   LET g_success_cnt = 1
   LET g_fail_cnt    = 0
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()

   CALL cl_err_collect_init()       #匯總訊息-初始化 
   
   FOREACH aicp110_process_cur INTO l_xmda005,l_xmda004,l_xmdadocno,l_xmdadocdt,
                                    l_xmda002,l_xmda003,l_xmda031,l_xmda050
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "process_cur"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL s_transaction_begin()
      LET g_fail_cnt = g_errcollect.getLength()   #先取得錯誤訊息的筆數，如果超過這個數字，代表為本次處理資料的錯誤 
      LET l_success  = TRUE
      
      #跑站(當站) 
      OPEN aicp110_process_icab_cur USING l_xmda050
      FOREACH aicp110_process_icab_cur INTO l_icab002_now,l_icab003_now,l_icab004_now
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET l_success = FALSE
            EXIT FOREACH
         END IF

         #採購單處理  
         CALL aicp110_pmdl(l_icab003_now,l_xmda031) RETURNING l_success
         IF NOT l_success THEN
            EXIT FOREACH
         END IF
       
         #委外工單開立點 
         IF l_icab004_now = 'Y' THEN
            #如果本站有為委外工單開立點的話 要多處理工單 
            CALL aicp110_sfaa(l_icab003_now,l_xmda031) RETURNING l_success
            IF NOT l_success THEN
               EXIT FOREACH
            END IF
         END IF

         #利用多角流序號找出該站的訂單 
         #以及多角性質 如果是第一站的話，會是2.銷售多角 中間站為5.中間交易 
         LET l_xmdadocno_now = ''
         LET l_xmdadocdt_now = '' 
         LET l_xmda006_now   = '' 
         SELECT xmdadocno,xmdadocdt,xmda006 
           INTO l_xmdadocno_now,l_xmdadocdt_now,l_xmda006_now 
           FROM xmda_t
          WHERE xmdaent  = g_enterprise
            AND xmdasite = l_icab003_now
            AND xmda031  = l_xmda031 
            AND xmdastus <> 'X'           #排除作廢 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xmdadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()

            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
         #如果多角性質為5.中間交易 的話，就代表是中間站 
         IF l_xmda006_now = '5' THEN  
            #取消確認前需清空多角序號 
            UPDATE xmda_t SET xmda030 = 'N',
                              xmda031 = ''
             WHERE xmdaent   = g_enterprise 
               AND xmdadocno = l_xmdadocno_now  
            IF SQLCA.sqlcode THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_xmdadocno_now 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err() 
               
               LET l_success = FALSE 
               EXIT FOREACH 
            END IF 
         
            #訂單取消確認
            CALL aicp110_xmda_unconf(l_xmdadocno_now,l_icab003_now) RETURNING l_success
            IF NOT l_success THEN
               EXIT FOREACH
            END IF
            
            IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
               #多角單據流水號保持一致='N'時，做作廢處理 
               CALL s_axmt500_invalid_chk(l_xmdadocno_now) RETURNING l_success
               IF NOT l_success THEN
                  EXIT FOREACH
               END IF

               CALL s_axmt500_invalid_upd(l_xmdadocno_now) RETURNING l_success
               IF NOT l_success THEN
                  EXIT FOREACH
               END IF
            ELSE
               #如果不是第0站的話，訂單應該被刪除 
               CALL aicp110_xmda_del(l_xmdadocno_now,l_xmdadocdt_now) RETURNING l_success
               IF NOT l_success THEN
                  EXIT FOREACH
               END IF
            END IF 
         ELSE
            #如果是第0站的話，應該更新訂單資料 
            UPDATE xmda_t SET xmda030 = 'N',
                              xmda031 = ''
             WHERE xmdaent   = g_enterprise
               AND xmdadocno = l_xmdadocno_now
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'upd xmda'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err() 
               
               LET l_success = FALSE
               EXIT FOREACH
            END IF
         END IF
      END FOREACH

      #150311---earl---add---s
      IF l_success THEN
         CALL s_aic_carry_deletetrino(l_xmda031,'1') RETURNING l_success
      END IF
      #150311---earl---add---e

      IF g_bgjob = 'N' THEN
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            #成功記錄 
            CALL aicp110_success(l_xmdadocno,l_xmdadocdt,l_xmda004,l_xmda002,l_xmda003,l_xmda050)
         ELSE
            CALL s_transaction_end('N',0)
            #失敗記錄 
            CALL aicp110_fail(l_xmdadocno,l_xmdadocdt,l_xmda004,l_xmda002,l_xmda003,l_xmda031,l_icab003_now)
         END IF
      ELSE
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            CALL cl_ask_pressanykey("aic-00178")    #多角流程拋轉還原成功！
         ELSE
            CALL s_transaction_end('N',0)
            CALL cl_ask_pressanykey("aic-00179")    #多角流程拋轉還原失敗！
         END IF
      END IF
      
   END FOREACH 
   
   #清空錯誤訊息的array，並且之後的錯誤不再以array的方式記錄 
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()

   IF g_bgjob = 'N' THEN
      CALL cl_ask_pressanykey('std-00012')
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp110_create_temp_table()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/10 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp110_create_temp_table()
   DROP TABLE aicp110_tmp;

   CREATE TEMP TABLE aicp110_tmp(
      sel             VARCHAR(1),                  #選擇 
      xmda005         VARCHAR(10),               #訂單性質 
      xmdadocno       VARCHAR(20),             #訂單單號 
      xmdadocdt       DATE,             #訂單日期 
      xmda004         VARCHAR(10),               #客戶編號 
      xmda002         VARCHAR(20),               #業務人員  
      xmda003         VARCHAR(10),               #業務部門 
      xmda033         VARCHAR(20),               #客戶訂購單號 
      xmdaownid       VARCHAR(20),             #資料所有者 
      xmdacrtid       VARCHAR(20),             #資料建立者 
      xmda050         VARCHAR(10),               #多角流程代碼  
      xmda031         VARCHAR(20),               #多角來源單號  
      xmdaent         SMALLINT     # 
   );
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp110_success(p_xmdadocno,p_xmdadocdt,p_xmda004,p_xmda002,p_xmda003,p_xmda050)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/12 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp110_success(p_xmdadocno,p_xmdadocdt,p_xmda004,p_xmda002,p_xmda003,p_xmda050)
   DEFINE p_xmdadocno     LIKE xmda_t.xmdadocno     #訂單單號  
   DEFINE p_xmdadocdt     LIKE xmda_t.xmdadocdt     #訂單日期  
   DEFINE p_xmda004       LIKE xmda_t.xmda004       #客戶編號  
   DEFINE p_xmda002       LIKE xmda_t.xmda002       #業務人員  
   DEFINE p_xmda003       LIKE xmda_t.xmda003       #業務部門  
   DEFINE p_xmda050       LIKE xmda_t.xmda050       #多角流程代碼 

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF

   LET g_detail3_d[g_success_cnt].xmdadocno1 = p_xmdadocno
   LET g_detail3_d[g_success_cnt].xmdadocdt1 = p_xmdadocdt
   LET g_detail3_d[g_success_cnt].xmda0041   = p_xmda004
   LET g_detail3_d[g_success_cnt].xmda0021   = p_xmda002
   LET g_detail3_d[g_success_cnt].xmda0031   = p_xmda003
   LET g_detail3_d[g_success_cnt].xmda0501   = p_xmda050

   #說明  
   #客戶編號的說明 
   LET g_detail3_d[g_success_cnt].xmda0041_desc = ''
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xmda0041)
        RETURNING g_detail3_d[g_success_cnt].xmda0041_desc

   #業務人員的說明 
   LET g_detail3_d[g_success_cnt].xmda0021_desc = ''
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].xmda0021)
        RETURNING g_detail3_d[g_success_cnt].xmda0021_desc

   #業務部門的說明 
   LET g_detail3_d[g_success_cnt].xmda0031_desc = ''
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].xmda0031)
        RETURNING g_detail3_d[g_success_cnt].xmda0031_desc

   LET g_success_cnt = g_success_cnt + 1 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp110_fail(p_xmdadocno,p_xmdadocdt,p_xmda004,p_xmda002,p_xmda003,p_xmda031,p_xmdasite)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/12 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp110_fail(p_xmdadocno,p_xmdadocdt,p_xmda004,p_xmda002,p_xmda003,p_xmda031,p_xmdasite)
   DEFINE p_xmdadocno     LIKE xmda_t.xmdadocno     #訂單單號  
   DEFINE p_xmdadocdt     LIKE xmda_t.xmdadocdt     #訂單日期  
   DEFINE p_xmda004       LIKE xmda_t.xmda004       #客戶編號  
   DEFINE p_xmda002       LIKE xmda_t.xmda002       #業務人員  
   DEFINE p_xmda003       LIKE xmda_t.xmda003       #業務部門  
   DEFINE p_xmda031       LIKE xmda_t.xmda031       #多角流程序號  
   DEFINE p_xmdasite      LIKE xmda_t.xmdasite      #營運據點

   DEFINE l_errcode       LIKE gzze_t.gzze001       #錯誤訊息編號  
   DEFINE l_i             LIKE type_t.num5

   IF g_bgjob = 'N' THEN
      IF cl_null(g_fail_cnt) THEN
         LET g_fail_cnt = 0
      END IF
      
      FOR l_i = g_fail_cnt + 1 TO g_errcollect.getLength()
         LET g_detail4_d[l_i].xmdadocno2 = p_xmdadocno
         LET g_detail4_d[l_i].xmdadocdt2 = p_xmdadocdt
         LET g_detail4_d[l_i].xmda0042   = p_xmda004
         LET g_detail4_d[l_i].xmda0022   = p_xmda002
         LET g_detail4_d[l_i].xmda0032   = p_xmda003 
         LET g_detail4_d[l_i].xmda0312   = p_xmda031
         LET g_detail4_d[l_i].xmdasite2  = p_xmdasite
      
         #錯誤訊息
         LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
      
         #說明
         CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].xmda0042)
              RETURNING g_detail4_d[l_i].xmda0042_desc
              
         CALL s_desc_get_person_desc(g_detail4_d[l_i].xmda0022)
              RETURNING g_detail4_d[l_i].xmda0022_desc
      
         CALL s_desc_get_department_desc(g_detail4_d[l_i].xmda0032)
              RETURNING g_detail4_d[l_i].xmda0032_desc
                            
         CALL s_desc_get_department_desc(g_detail4_d[l_i].xmdasite2)
              RETURNING g_detail4_d[l_i].xmdasite2_desc
      
      END FOR
      
      LET g_fail_cnt = g_errcollect.getLength()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 採購單處理
# Memo...........:
# Usage..........: CALL aicp110_pmdl(p_site,p_pmdl031)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/12 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp110_pmdl(p_site,p_pmdl031)
   DEFINE p_site        LIKE xmda_t.xmdasite
   DEFINE p_pmdl031     LIKE pmdl_t.pmdl031      #多角流程序號  
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_pmdldocno   LIKE pmdl_t.pmdldocno    #採購單號 
   DEFINE l_pmdldocdt   LIKE pmdl_t.pmdldocdt    #採購日期 
   DEFINE l_prog        LIKE gzzz_t.gzzz001
   DEFINE l_pmdl005     LIKE pmdl_t.pmdl005      #採購性質

   LET r_success = TRUE

   #用多角流程序號找出該站採購單資料 
   LET l_pmdldocno = ''
   LET l_pmdldocdt = ''
   LET l_pmdl005 = ''
   SELECT pmdldocno,pmdldocdt,pmdl005
     INTO l_pmdldocno,l_pmdldocdt,l_pmdl005
     FROM pmdl_t
    WHERE pmdlent  = g_enterprise
      AND pmdlsite = p_site
      AND pmdl031  = p_pmdl031     #多角流程序號  
      AND pmdlstus <> 'X'          #排除作廢 

   #因為終站不會產生採購單 所以有可能會有找不到的情況 
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE 
      RETURN r_success
   END IF

   #因為是終站 所以不會有採購單 故直接回傳true即可 
   IF cl_null(l_pmdldocno) THEN
      RETURN r_success
   END IF

   #150311---earl---add---s
   #先將多角序號清空，否則不可取消確認
   UPDATE pmdl_t
      SET pmdl030 = 'N',
          pmdl031 = ''
    WHERE pmdlent = g_enterprise
      AND pmdldocno = l_pmdldocno
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = l_pmdldocno
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   #150311---earl---add---e

   #取消確認 
   CALL s_apmt500_unconf_chk(l_pmdldocno) RETURNING r_success
   IF NOT r_success THEN     #如果有錯就回傳false  
      RETURN r_success
   END IF
   CALL s_apmt500_unconf_upd(l_pmdldocno) RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success       #如果有錯就回傳false 
   END IF

   IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
      #多角單據流水號保持一致='N'時，做作廢處理 
      CALL s_apmt500_invalid_chk(l_pmdldocno) RETURNING r_success
      IF NOT r_success THEN
         RETURN r_success
      END IF

      CALL s_apmt500_invalid_upd(l_pmdldocno) RETURNING r_success
      IF NOT r_success THEN
         RETURN r_success
      END IF

   ELSE
      #準備刪除所有採購單資料 
      #採購單頭 
      DELETE FROM pmdl_t WHERE pmdlent   = g_enterprise
                           AND pmdldocno = l_pmdldocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE 
         RETURN r_success
      END IF

      #採購多帳期預付款檔
      DELETE FROM pmdm_t WHERE pmdment   = g_enterprise
                           AND pmdmdocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #採購單身明細  
      DELETE FROM pmdn_t WHERE pmdnent  = g_enterprise
                           AND pmdndocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #採購交期明細檔  
      DELETE FROM pmdo_t WHERE pmdoent   = g_enterprise
                           AND pmdodocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF 
      
      #關聯單據明細檔 
      DELETE FROM pmdp_t WHERE pmdpent   = g_enterprise
                           AND pmdpdocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #採購多交期匯總檔
      DELETE FROM pmdq_t WHERE pmdqent   = g_enterprise
                           AND pmdqdocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF 

      #刪除交易稅明細檔
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise
         AND xrcddocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #單號處理 
      LET l_prog = g_prog

      IF l_pmdl005 = '2' THEN  #委外採購
         LET g_prog = "apmt501"
      ELSE
         LET g_prog = "apmt500"
      END IF
      
      IF NOT s_aooi200_del_docno(l_pmdldocno,l_pmdldocdt) THEN
         LET g_prog = l_prog
         LET r_success = FALSE
         RETURN r_success
      END IF

      #刪除備註 
      CALL s_aooi360_del('6',g_prog,l_pmdldocno,'','','','','','','','','4') RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         RETURN r_success
      END IF 
      
      #相關文件 
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = l_pmdldocno
      LET g_pk_array[1].column = 'pmdldocno'
      CALL cl_doc_remove() 
      
      LET g_prog = l_prog
   END IF

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: #訂單取消確認
# Memo...........:
# Usage..........: CALL aicp110_xmda_unconf(p_xmdadocno,p_xmdasite)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/12 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp110_xmda_unconf(p_xmdadocno,p_xmdasite)
   DEFINE p_xmdadocno     LIKE xmda_t.xmdadocno
   DEFINE p_xmdasite      LIKE xmda_t.xmdasite
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_site          LIKE xmda_t.xmdasite        #備份目前的g_site   

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   LET l_site = g_site       #備份g_site 
   LET g_site = p_xmdasite   #將g_site替換成當站營運據點 

   #取消確認前檢查 
   CALL s_axmt500_unconf_chk(p_xmdadocno) RETURNING r_success
   IF NOT r_success THEN
      LET g_site = l_site    #將g_site還原後就return  
      RETURN r_success
   END IF

   #取消確認 
   CALL s_axmt500_unconf_upd(p_xmdadocno) RETURNING r_success

   LET g_site = l_site

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp110_xmda_del(p_xmdadocno,p_xmdadocdt)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/12 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp110_xmda_del(p_xmdadocno,p_xmdadocdt)
   DEFINE p_xmdadocno     LIKE xmda_t.xmdadocno
   DEFINE p_xmdadocdt     LIKE xmda_t.xmdadocdt
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_prog          LIKE gzzz_t.gzzz001

   LET r_success = TRUE

   #訂單單頭 
   DELETE FROM xmda_t WHERE xmdaent   = g_enterprise
                        AND xmdadocno = p_xmdadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #訂單多帳期預收款檔
   DELETE FROM xmdb_t WHERE xmdbent = g_enterprise
                        AND xmdbdocno = p_xmdadocno
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #訂單單身  
   DELETE FROM xmdc_t WHERE xmdcent   = g_enterprise
                        AND xmdcdocno = p_xmdadocno
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #訂單交期明細檔  
   DELETE FROM xmdd_t WHERE xmddent   = g_enterprise
                        AND xmdddocno = p_xmdadocno
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #訂單多交期匯總檔
   DELETE FROM xmdf_t WHERE xmdfent = g_enterprise
                        AND xmdfdocno = p_xmdadocno
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #訂單附屬零件明細檔
   DELETE FROM xmdq_t WHERE xmdqent = g_enterprise
                        AND xmdqdocno = p_xmdadocno
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #訂單備置明細檔
   DELETE FROM xmdr_t WHERE xmdrent = g_enterprise
                        AND xmdrdocno = p_xmdadocno
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #訂單費用資料檔
   DELETE FROM xmds_t WHERE xmdsent = g_enterprise
                        AND xmdsdocno = p_xmdadocno
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #刪除交易稅明細檔
   DELETE FROM xrcd_t
    WHERE xrcdent = g_enterprise
      AND xrcddocno = p_xmdadocno
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = p_xmdadocno
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #單號處理 
   LET l_prog = g_prog
   LET g_prog = 'axmt500'
   IF NOT s_aooi200_del_docno(p_xmdadocno,p_xmdadocdt) THEN
      LET g_prog = l_prog
      LET r_success = FALSE 
      RETURN r_success
   END IF

   #刪除備註 
   CALL s_aooi360_del('6',g_prog,p_xmdadocno,'','','','','','','','','4') RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      RETURN r_success
   END IF

   #相關文件 
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = p_xmdadocno
   LET g_pk_array[1].column = 'xmdadocno'
   CALL cl_doc_remove()

   LET g_prog = l_prog

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp110_get_icaal003(p_icaal001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp110_get_icaal003(p_icaal001)
   DEFINE p_icaal001     LIKE icaal_t.icaal001
   DEFINE r_icaal003     LIKE icaal_t.icaal003

   LET r_icaal003 = ''

   SELECT icaal003 INTO r_icaal003
     FROM icaal_t
    WHERE icaalent = g_enterprise
      AND icaal001 = p_icaal001
      AND icaal002 = g_dlang

   RETURN r_icaal003
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp110_get_ooefl003(p_ooefl001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp110_get_ooefl003(p_ooefl001)
   DEFINE p_ooefl001     LIKE ooefl_t.ooefl001
   DEFINE r_ooefl003     LIKE ooefl_t.ooefl003

   LET r_ooefl003 = ''
   SELECT ooefl003 INTO r_ooefl003
     FROM ooefl_t
    WHERE ooeflent = g_enterprise
      AND ooefl001 = p_ooefl001
      AND ooefl002 = g_dlang

   RETURN r_ooefl003
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp110_sfaa(p_site,p_sfaa067)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/26 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp110_sfaa(p_site,p_sfaa067)
   DEFINE p_site      LIKE sfaa_t.sfaasite
   DEFINE p_sfaa067   LIKE sfaa_t.sfaa067      #多角流程序號 
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_sfaadocno LIKE sfaa_t.sfaadocno    #工單單號  
   DEFINE l_sfaadocdt LIKE sfaa_t.sfaadocdt
   DEFINE l_sfaastus  LIKE sfaa_t.sfaastus
   
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_prog      LIKE gzzz_t.gzzz001
   DEFINE l_sql       STRING

   LET r_success = TRUE

   #利用多角流程序號找出工單資料(可能有多筆)
   LET l_sql = "SELECT sfaadocno,sfaadocdt,sfaastus ",
               "  FROM sfaa_t ",
               " WHERE sfaaent  = ",g_enterprise,
               "   AND sfaasite = '",p_site,"'",
               "   AND sfaa067  = '",p_sfaa067,"'",
               "   AND sfaastus <> 'X'"          #排除作廢
   PREPARE aicp110_sfaa_pre FROM l_sql
   DECLARE aicp110_sfaa_cs CURSOR FOR aicp110_sfaa_pre

   FOREACH aicp110_sfaa_cs INTO l_sfaadocno,l_sfaadocdt,l_sfaastus
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'aicp110_sfaa_cs'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
     
         LET r_success = FALSE 
         EXIT FOREACH
      END IF

      IF l_sfaastus = 'F' THEN
         #檢查是否有 報工、發料、入庫 的資料 如果有的話就不能取消發放 
         #發料單 
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM sfda_t,sfdc_t
          WHERE sfdaent   = sfdcent
            AND sfdadocno = sfdcdocno
            AND sfdc001   = l_sfaadocno
            AND sfdastus != 'X'
         IF cl_null(l_cnt) THEN
            LET l_cnt = 0
         END IF 
         IF l_cnt = 0 THEN
            SELECT COUNT(*) INTO l_cnt
              FROM sfda_t,sfdb_t
             WHERE sfdaent   = sfdbent
               AND sfdadocno = sfdbdocno
               AND sfdb001   = l_sfaadocno
               AND sfdastus != 'X'
            IF cl_null(l_cnt) THEN
               LET l_cnt = 0
            END IF
         END IF
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = 'asf-00318'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
     
         #入庫單 
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM sfea_t,sfec_t
          WHERE sfeaent   = sfecent
            AND sfeadocno = sfecdocno
            AND sfec001   = l_sfaadocno 
            AND sfeastus != 'X'
         IF cl_null(l_cnt) THEN
            LET l_cnt = 0
         END IF
         IF l_cnt = 0 THEN
            SELECT COUNT(*) INTO l_cnt
              FROM sfea_t,sfeb_t
             WHERE sfeaent   = sfebent
               AND sfeadocno = sfebdocno
               AND sfeb001   = l_sfaadocno
               AND sfeastus != 'X'
            IF cl_null(l_cnt) THEN
               LET l_cnt = 0
            END IF
         END IF
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = 'asf-00319'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
     
         #報工單 
         LET l_cnt = 0 
         SELECT COUNT(*) INTO l_cnt
           FROM sffb_t
          WHERE sffbent   = g_enterprise
            AND sffb005   = l_sfaadocno
            AND sffbstus != 'X'
         IF cl_null(l_cnt) THEN
            LET l_cnt = 0
         END IF
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = 'asf-00320'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
     
         #委外採購單 
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM pmdl_t
          WHERE pmdlent = g_enterprise
            AND pmdl008 = l_sfaadocno
            AND pmdlstus != 'X'
         IF cl_null(l_cnt) THEN
            LET l_cnt = 0
         END IF 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = 'asf-00454'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         #清除備置資料
         DELETE FROM sfbb_t
          WHERE sfbbent = g_enterprise
            AND sfbbdocno =  l_sfaadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ""
            LET g_errparam.popup = FALSE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         UPDATE sfba_t SET sfba031 = 0,sfba032 = ''
          WHERE sfbaent = g_enterprise
            AND sfbadocno = l_sfaadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ""
            LET g_errparam.popup = FALSE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         #更新狀態為Y 
         UPDATE sfaa_t SET sfaastus = 'Y'
          WHERE sfaaent   = g_enterprise
            AND sfaadocno = l_sfaadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF

      #看asft300的取消確認，似乎不用做任何的檢查  
      UPDATE sfaa_t SET sfaastus = 'N',
                        sfaacnfid = '',
                        sfaacnfdt = '',
                        sfaa067  = ''        #清空多角序號 
       WHERE sfaaent   = g_enterprise
         AND sfaadocno = l_sfaadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_sfaadocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
     
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
         #多角單據流水號保持一致='N'時，做作廢處理 
         UPDATE sfaa_t SET sfaastus = 'X'
          WHERE sfaaent   = g_enterprise
            AND sfaadocno = l_sfaadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      ELSE
         #刪除工單前檢查
         #已存在子工單資料不可刪除 
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM sfaa_t
          WHERE sfaaent  = g_enterprise
            AND sfaasits = p_site
            AND sfaa021  = l_sfaadocno
         IF cl_null(l_cnt) THEN
            LET l_cnt = 0
         END IF 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = 'asf-00439'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
     
         CALL g_pk_array.clear()
         LET g_pk_array[1].values = l_sfaadocno
         LET g_pk_array[1].column = 'sfaadocno'
         INITIALIZE g_doc.* TO NULL
         LET g_doc.column1 = "sfaadocno"
         LET g_doc.value1  = l_sfaadocno
         CALL cl_doc_remove()
     
         #刪除工單單頭 
         DELETE FROM sfaa_t WHERE sfaaent   = g_enterprise
                              AND sfaasite  = p_site
                              AND sfaadocno = l_sfaadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
     
         #單號處理 
         LET l_prog = g_prog
         LET g_prog = 'asft300'
         IF NOT s_aooi200_del_docno(l_sfaadocno,l_sfaadocdt) THEN
            LET g_prog = l_prog
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         LET g_prog = l_prog
     
         #刪除工單單身 
         DELETE FROM sfab_t WHERE sfabent   = g_enterprise
                              AND sfabsite  = p_site
                              AND sfabdocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF 
         
         #刪除工單聯產品檔 
         DELETE FROM sfac_t WHERE sfacent   = g_enterprise
                              AND sfacsite  = p_site
                              AND sfacdocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         #刪除工單產品序號檔 
         DELETE FROM sfaf_t WHERE sfafent   = g_enterprise
                              AND sfafsite  = p_site
                              AND sfafdocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF 
         
         #刪除工單製程單頭檔 
         DELETE FROM sfca_t WHERE sfcaent   = g_enterprise
                              AND sfcasite  = p_site
                              AND sfcadocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
     
         #刪除工單製程單身檔 
         DELETE FROM sfcb_t WHERE sfcbent   = g_enterprise
                              AND sfcbsite  = p_site
                              AND sfcbdocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF 
         
         #刪除工單製程上站作業資料 
         DELETE FROM sfcc_t WHERE sfccent   = g_enterprise
                              AND sfccsite  = p_site
                              AND sfccdocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
     
         #刪除工單製程check in/out項目資料 
         DELETE FROM sfcd_t WHERE sfcdent   = g_enterprise
                              AND sfcdsite  = p_site
                              AND sfcddocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         #刪除工單備料單身檔 
         DELETE FROM sfba_t WHERE sfbaent   = g_enterprise
                              AND sfbasite  = p_site
                              AND sfbadocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
     
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF

   END FOREACH

   RETURN r_success
END FUNCTION

#單號過濾條件
PRIVATE FUNCTION aicp110_sel()
   #LET g_aicp110_sel = " xmdaent   = '",g_enterprise,"' ", #161231-00013#1 mark
   LET g_aicp110_sel = " xmdaent = '",g_enterprise,"' ",cl_sql_add_filter("xmda_t"),     #161231-00013#1 add
                       " AND xmdasite  = '",g_site,"' ",  
                       " AND xmdastus  = 'Y' ", 
                       " AND xmda031 IS NOT NULL ",                     #多角流程序號不為空就是已經被拋過的資料 
                       " AND xmda030   = 'Y' ",                         #多角貿易已拋轉  
                       " AND xmda006 = '2' " ,                           #多角性質=2.銷售多角 #170106-00005#1 reduce ,
                      #170106-00005#1 ---mark (s)--- 
                      #" AND (SELECT COUNT(*) FROM xmdh_t ",            #不可存在出通單  
                      #"       WHERE xmdh001 = xmda_t.xmdadocno) <= 0 ", 
                      #" AND (SELECT COUNT(*) FROM xmdl_t ",            #不可存在出貨單  
                      #"       WHERE xmdl003 = xmda_t.xmdadocno) <= 0 "      
                      #170106-00005#1 ---mark (e)---
                      #170111-00026#2-s add
                      " AND (SELECT COUNT(1) FROM xmdg_t,xmdh_t ",            #不可存在出通單  
                      "       WHERE xmdgent = xmda_t.xmdaent ",
                      "         AND xmdgent = xmdhent AND xmdgdocno = xmdhdocno ",
                      "         AND xmdgstus <> 'X' ",
                      "         AND xmdh001 = xmda_t.xmdadocno) <= 0 ",
                      " AND (SELECT COUNT(1) FROM xmdk_t,xmdl_t ",            #不可存在出貨單  
                      "       WHERE xmdkent = xmda_t.xmdaent ",
                      "         AND xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
                      "         AND xmdkstus <> 'X' ",
                      "         AND xmdl003 = xmda_t.xmdadocno) <= 0 "
                     #170111-00026#2-e add
END FUNCTION

#end add-point
 
{</section>}
 
