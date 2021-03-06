#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp610.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-06-28 16:47:56), PR版次:0004(2017-02-20 10:39:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: apmp610
#+ Description: 訂單轉請購批次作業
#+ Creator....: 01534(2015-04-08 16:34:45)
#+ Modifier...: 06814 -SD/PR- 01996
 
{</section>}
 
{<section id="apmp610.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161124-00048#8  2016/12/16 By zhujing  .*整批调整
#160711-00040#24 2017/02/20 By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
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
     sel                LIKE type_t.chr1,
     xmdcdocno          LIKE xmdc_t.xmdcdocno,
     xmdcseq            LIKE xmdc_t.xmdcseq,
     xmddseq1           LIKE xmdd_t.xmddseq1,
     xmddseq2           LIKE xmdd_t.xmddseq2,
     xmda004            LIKE xmda_t.xmda004,
     xmda004_desc       LIKE type_t.chr80,
     xmda002            LIKE xmda_t.xmda002,
     xmda002_desc       LIKE type_t.chr80,  
     xmdd011            LIKE xmdd_t.xmdd011,
     xmdc001            LIKE xmdc_t.xmdc001,   
     xmdc001_desc       LIKE type_t.chr80,
     xmdc001_desc_desc  LIKE type_t.chr80,
     xmdc002            LIKE xmdc_t.xmdc002,
     xmdc002_desc       LIKE type_t.chr80, 
     xmdc006            LIKE xmdc_t.xmdc006,
     xmdc006_desc       LIKE type_t.chr80, 
     xmdc007            LIKE xmdc_t.xmdc007,
     num                LIKE xmdc_t.xmdc007,
     pmdb006            LIKE pmdb_t.pmdb006     
                     END RECORD
 
DEFINE  g_pmdadocno        LIKE pmda_t.pmdadocno
DEFINE  g_s_pmdadocno      LIKE pmda_t.pmdadocno
DEFINE  g_pmda011          LIKE pmda_t.pmda011
DEFINE  g_pmdadocno_t      LIKE pmda_t.pmdadocno
DEFINE  g_pmdadocno_desc   LIKE type_t.chr80
DEFINE  g_type             LIKE type_t.chr10
DEFINE  l_ooef004          LIKE ooef_t.ooef004
DEFINE  p_detail_d         type_g_detail_d
DEFINE  g_detail_d_t       type_g_detail_d
DEFINE  g_rec_b            LIKE type_t.num10
DEFINE  g_status           LIKE type_t.num5
DEFINE  g_flag             LIKE type_t.chr1
DEFINE  g_flag1            LIKE type_t.chr1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
                    
#end add-point
 
{</section>}
 
{<section id="apmp610.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp610 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmp610_init()   
 
      #進入選單 Menu (="N")
      CALL apmp610_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp610
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp610.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmp610_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
 
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
   CALL cl_set_combo_scc('l_type','4057') 
   LET g_type = '1' 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp610.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp610_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_success             LIKE type_t.num5 
   DEFINE  l_flag                LIKE type_t.num5 
   DEFINE  r_success             LIKE type_t.num5 
   DEFINE  l_where               STRING
   DEFINE  l_sql1                STRING     #160711-00040#24 add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET l_allow_insert = FALSE
   LET l_allow_delete = FALSE
   LET g_qryparam.state = 'i'   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmp610_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         INPUT g_pmdadocno,g_type FROM pmdadocno,l_type
            BEFORE INPUT
            
               AFTER FIELD pmdadocno
                  IF NOT cl_null(g_pmdadocno) THEN
                     #檢核輸入的單據別是否可以被key人員對應的控制組使用,'3' 為銷售控制組類型
                     CALL s_control_chk_doc('1',g_pmdadocno,'3',g_user,g_dept,'','') RETURNING l_success,l_flag
                     IF l_success THEN
                        IF NOT l_flag THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apm-00254'
                           LET g_errparam.extend = g_pmdadocno
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_pmdadocno = g_pmdadocno_t
                           #CALL apmp610_xmdadocno_ref()
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        LET g_pmdadocno = g_pmdadocno_t
                        #CALL apmp610_xmdadocno_ref()
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT s_aooi200_chk_slip(g_site,'',g_pmdadocno,'apmt400') THEN
                        LET g_pmdadocno = g_pmdadocno_t
                        #CALL apmp610_xmdadocno_ref()
                        NEXT FIELD CURRENT   
                     END IF                                            
                  END IF
                  LET g_pmdadocno_t =  g_pmdadocno
                  
               ON ACTION controlp INFIELD pmdadocno
		         	INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
		         	LET g_qryparam.reqry = FALSE
            
                  LET g_qryparam.default1 = g_pmdadocno             #給予default值
            
                  #給予arg
                  LET g_qryparam.arg1 = l_ooef004 #
                  LET g_qryparam.arg2 = 'apmt400'
                  #160711-00040#24 add(s)
                  CALL s_control_get_docno_sql(g_user,g_dept)
                      RETURNING l_success,l_sql1
                  IF NOT cl_null(l_sql1) THEN
                     LET g_qryparam.where = l_sql1
                  END IF
                  #160711-00040#24 add(e)
                  CALL q_ooba002_1()                                #呼叫開窗
            
                  LET g_pmdadocno = g_qryparam.return1              #將開窗取得的值回傳到變數
            
                  DISPLAY g_pmdadocno TO pmdadocno              #顯示到畫面上
                  CALL s_aooi200_get_slip_desc(g_pmdadocno) RETURNING g_pmdadocno_desc
                  #DISPLAY BY NAME g_pmdadocno_desc
            
                  NEXT FIELD pmdadocno                          #返回原欄位 
            
            AFTER INPUT            
         END INPUT
         
         CONSTRUCT BY NAME g_wc ON xmdcdocno,xmdadocdt,xmdd011,xmda004,xmda002,xmda003,xmda023,xmdc001,imaf111
            BEFORE CONSTRUCT
                                                      
            ON ACTION controlp INFIELD xmdcdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #組合過濾前後置單據資料SQL
               CALL s_aooi210_get_check_sql(g_site,'',g_pmdadocno,'2','axmt500','xmdadocno') RETURNING l_success,l_where
               LET g_qryparam.where = l_where 
               CALL q_xmdadocno_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdcdocno  #顯示到畫面上
               NEXT FIELD xmdcdocno                     #返回原欄位
               
            ON ACTION controlp INFIELD xmda004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda004  #顯示到畫面上
               NEXT FIELD xmda004      

            ON ACTION controlp INFIELD xmda002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda002  #顯示到畫面上
               NEXT FIELD xmda002      
               
            ON ACTION controlp INFIELD xmda003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda003  #顯示到畫面上
               NEXT FIELD xmda003   
    
            ON ACTION controlp INFIELD xmda023
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160621-00003#3 20160627 modify by beckxie---S
			      #LET g_qryparam.arg1 = "275"
               #CALL q_oocq002()                           #呼叫開窗
               LET g_qryparam.arg1 = '1'
               CALL q_oojd001_1()
               #160621-00003#3 20160627 modify by beckxie---E
               DISPLAY g_qryparam.return1 TO xmda023  #顯示到畫面上
               NEXT FIELD xmda023  
               
            ON ACTION controlp INFIELD xmdc001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001_15()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdc001  #顯示到畫面上
               NEXT FIELD xmdc001 

            ON ACTION controlp INFIELD imaf111
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imcd111()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaf111  #顯示到畫面上
               NEXT FIELD imaf111 

         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                     INSERT ROW = l_allow_insert, 
                     DELETE ROW = l_allow_delete,
                     APPEND ROW = l_allow_insert)
            
            BEFORE INPUT
                                             
            BEFORE ROW
               LET l_ac = ARR_CURR()
               LET g_detail_d_t.* = g_detail_d[l_ac].*          
               
            AFTER FIELD b_pmdb006
               IF NOT cl_ap_chk_range(g_detail_d[l_ac].pmdb006,"0","0","","","azz-00079",1) THEN
                  NEXT FIELD b_pmdb006
               END IF             
               IF NOT cl_null(g_detail_d[l_ac].pmdb006) THEN
                  IF g_detail_d[l_ac].pmdb006 > g_detail_d[l_ac].num THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00878'
                     LET g_errparam.extend = g_detail_d[l_ac].pmdb006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()  
                     LET g_detail_d[l_ac].pmdb006 = g_detail_d_t.pmdb006
                     NEXT FIELD b_pmdb006                     
                  END IF                  
               END IF 
               LET g_detail_d_t.pmdb006 = g_detail_d[l_ac].pmdb006              
         END INPUT             
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
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
            IF cl_null(g_type) THEN
               LET g_type = '1' 
            END IF   
            DISPLAY g_type TO l_type
            LET g_qryparam.state = 'i'            
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
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmp610_filter()
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
            CALL apmp610_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apmp610_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL apmp610_gene_pmda_pmdb()
            CALL apmp610_b_fill()   #add by lixh 20150528
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
 
{<section id="apmp610.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmp610_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_pmdadocno) THEN
      RETURN
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL apmp610_b_fill()
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
 
{<section id="apmp610.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmp610_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_flag          LIKE type_t.num5
   DEFINE l_oobn003       LIKE oobn_t.oobn003
   DEFINE l_pmdb006       LIKE pmdb_t.pmdb006
   DEFINE r_pmdb006       LIKE pmdb_t.pmdb006
   DEFINE s_pmdb006       LIKE pmdb_t.pmdb006
   DEFINE l_pmdb007       LIKE pmdb_t.pmdb007
   DEFINE l_sql           STRING   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_pmdadocno) THEN
      RETURN
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1 =1"
   END IF
   LET g_sql = " SELECT DISTINCT 'N',xmdcdocno,xmdcseq,xmddseq1,xmddseq2,xmda004,'',xmda002,'',xmdd011,xmdc001,'','',xmdc002,'',xmdc006,'',xmdd006,0,0 FROM xmda_t,xmdd_t,xmdc_t ",
               "   LEFT OUTER JOIN imaf_t ON xmdcent = imafent AND xmdcsite = imafsite AND xmdc001 = imaf001 ",
               "  WHERE xmdcent = ? ",
               "    AND xmdcsite = '",g_site,"'",
               "    AND xmdcent = xmddent ",
               "    AND xmdcsite = xmddsite",
               "    AND xmdcdocno = xmdddocno ",
               "    AND xmdcseq = xmddseq",
               "    AND xmdaent = xmdcent",
               "    AND xmdasite = xmdcsite ",
               "    AND xmdadocno = xmdcdocno ",
               "    AND xmdastus = 'Y' ",
               "    AND ",g_wc
               
   IF g_type = '1' THEN  #依訂單匯總
      LET g_sql = g_sql," ORDER BY xmdcdocno,xmdcseq,xmddseq1,xmddseq2,xmda004,xmdc001,xmdd011"
   END IF   
   IF g_type = '2' THEN  #依客戶匯總
      LET g_sql = g_sql," ORDER BY xmda004,xmdcdocno,xmdcseq,xmddseq1,xmddseq2,xmdc001,xmdd011"
   END IF
   IF g_type = '3' THEN
      LET g_sql = g_sql," ORDER BY xmdcdocno,xmdcseq,xmddseq1,xmddseq2,xmdc001,xmdd011"
   END IF
   #end add-point
 
   PREPARE apmp610_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmp610_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"

   LET l_sql = " SELECT pmdb006,pmdb007 FROM pmdb_t,pmda_t ",
               "  WHERE pmdaent = pmdbent ",
               "    AND pmdasite = pmdbsite ",
               "    AND pmdadocno = pmdbdocno ",
               "    AND pmdaent = '",g_enterprise,"' ",
               "    AND pmdasite = '",g_site,"'",
               "    AND pmdastus <> 'X' ",
               "    AND pmdb001 = ? ",
               "    AND pmdb002 = ? ",
               "    AND pmdb003 = ? ",
               "    AND pmdb052 = ? "               
   PREPARE apmp610_sel_01 FROM l_sql
   DECLARE b_fill_curs_01 CURSOR FOR apmp610_sel_01  
   CALL cl_err_collect_init()    #add by lixh 20151029  
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
           g_detail_d[l_ac].sel,g_detail_d[l_ac].xmdcdocno,g_detail_d[l_ac].xmdcseq,g_detail_d[l_ac].xmddseq1,g_detail_d[l_ac].xmddseq2,g_detail_d[l_ac].xmda004,g_detail_d[l_ac].xmda004_desc,g_detail_d[l_ac].xmda002,
           g_detail_d[l_ac].xmda002_desc,g_detail_d[l_ac].xmdd011,g_detail_d[l_ac].xmdc001,g_detail_d[l_ac].xmdc001_desc,g_detail_d[l_ac].xmdc001_desc_desc,
           g_detail_d[l_ac].xmdc002,g_detail_d[l_ac].xmdc002_desc,g_detail_d[l_ac].xmdc006,g_detail_d[l_ac].xmdc006_desc,g_detail_d[l_ac].xmdc007,g_detail_d[l_ac].num,
           g_detail_d[l_ac].pmdb006
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

      #訂單須為確認狀態且銷售量未全數請購單的數量
      #單位轉換
      LET s_pmdb006 = 0
      LET l_pmdb006 = ''
      LET l_pmdb007 = ''
      FOREACH b_fill_curs_01 USING g_detail_d[l_ac].xmdcdocno,g_detail_d[l_ac].xmdcseq,g_detail_d[l_ac].xmddseq1,g_detail_d[l_ac].xmddseq2 
                              INTO l_pmdb006,l_pmdb007
      
         CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdc001,l_pmdb007,
                                    g_detail_d[l_ac].xmdc006,l_pmdb006)
              RETURNING r_success,r_pmdb006    
         IF cl_null(r_pmdb006) THEN
            LET r_pmdb006 = 0
         END IF         
         LET s_pmdb006 = s_pmdb006 + r_pmdb006 
         
      END FOREACH
      
      LET g_detail_d[l_ac].num = g_detail_d[l_ac].xmdc007 - s_pmdb006     
      LET g_detail_d[l_ac].pmdb006 = g_detail_d[l_ac].num    
      IF g_detail_d[l_ac].num = 0 THEN
         CONTINUE FOREACH
      END IF      
      #客戶生命週期檢核
      CALL s_control_chk_doc('3',g_pmdadocno,g_detail_d[l_ac].xmda004,'','','','')  RETURNING r_success,r_flag
      IF r_success THEN
         IF NOT r_flag THEN
            CONTINUE FOREACH
         END IF
      ELSE
         CONTINUE FOREACH
      END IF
      #產品生命週期檢核
      CALL s_control_chk_doc('4',g_pmdadocno,g_detail_d[l_ac].xmdc001,'','','','')  RETURNING r_success,r_flag
      IF r_success THEN
         IF NOT r_flag THEN
            CONTINUE FOREACH
         END IF
      ELSE
         CONTINUE FOREACH
      END IF     
      #根據訂單單別，獲取請購單別
#      CALL s_aooi210_get_doc(g_site,'','3',g_detail_d[l_ac].xmdcdocno,'apmt400','') RETURNING r_success,l_oobn003
#      #檢核前後置單別的合理性
#      IF NOT s_aooi210_check_doc(g_site,'',g_detail_d[l_ac].xmdcdocno,g_pmdadocno,'1','apmt400') THEN
#         LET r_success = FALSE
#      END IF
      #add by lixh 20150528
      #檢核前後置單別的合理性
      IF NOT s_aooi210_check_doc(g_site,'',g_detail_d[l_ac].xmdcdocno,g_pmdadocno,'2','axmt500') THEN
         LET r_success = FALSE
      END IF
      #add by lixh 20150528  
      IF NOT r_success THEN
         CONTINUE FOREACH
      END IF
      CALL s_desc_get_item_desc(g_detail_d[l_ac].xmdc001) RETURNING g_detail_d[l_ac].xmdc001_desc,g_detail_d[l_ac].xmdc001_desc_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmda004) RETURNING g_detail_d[l_ac].xmda004_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmda002) RETURNING g_detail_d[l_ac].xmda002_desc
      CALL s_desc_get_unit_desc(g_detail_d[l_ac].xmdc006) RETURNING g_detail_d[l_ac].xmdc006_desc
      CALL s_feature_description(g_detail_d[l_ac].xmdc001,g_detail_d[l_ac].xmdc002)
           RETURNING r_success,g_detail_d[l_ac].xmdc002_desc  
      #end add-point
      
      CALL apmp610_detail_show()      
 
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
   CALL cl_err_collect_show()   #add by lixh 20151029
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apmp610_sel
   
   LET l_ac = 1
   CALL apmp610_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp610.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmp610_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apmp610.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmp610_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp610.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmp610_filter()
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
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apmp610_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apmp610.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmp610_filter_parser(ps_field)
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
 
{<section id="apmp610.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmp610_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmp610_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmp610.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 產生請購單
# Memo...........:
# Usage..........: CALL apmp610_gene_pmda_pmdb()
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp610_gene_pmda_pmdb()
DEFINE   l_xmdadocno_t           LIKE xmda_t.xmdadocno
DEFINE   l_xmda004_t             LIKE xmda_t.xmda004
DEFINE   l_xmdcseq_t             LIKE xmdc_t.xmdcseq
DEFINE   i                       LIKE type_t.num10
DEFINE   r_success               LIKE type_t.num5
DEFINE   ls_sql                  STRING                   #add by lixh 20150529
DEFINE   p_pmdadocno             LIKE pmda_t.pmdadocno    #add by lixh 20150529 
DEFINE   l_xmddseq1_t            LIKE xmdd_t.xmddseq1     #add by lixh 20150529  
DEFINE   l_xmddseq2_t            LIKE xmdd_t.xmddseq2     #add by lixh 20150529 
DEFINE   la_param   RECORD
         prog       STRING,
         actionid   STRING,
         background LIKE type_t.chr1,
         param      DYNAMIC ARRAY OF STRING
         END RECORD
DEFINE   ls_js      STRING
   
 LET l_xmdadocno_t = ''
 LET l_xmdcseq_t = ''
 LET l_xmda004_t = ''
 LET l_xmddseq1_t = ''  #add by lixh 20150529
 LET l_xmddseq2_t = ''  #add by lixh 20150529
 CALL cl_err_collect_init()
 LET g_flag = 'N'
 LET g_flag1 = 'N'
 
 LET ls_sql = ''
 FOR i = 1 TO g_detail_d.getLength()
    IF g_detail_d[i].sel = 'N' THEN
       CONTINUE FOR
    END IF
    CALL s_transaction_begin()
    IF g_type = '1' THEN  #依據訂單匯總
       IF g_detail_d[i].xmdcdocno <> l_xmdadocno_t OR l_xmdadocno_t IS NULL THEN  #單號改變
          LET l_xmdadocno_t = g_detail_d[i].xmdcdocno 
          CALL apmp610_ins_pmda() RETURNING r_success,g_s_pmdadocno,g_pmda011  #新增請購單單頭
          IF cl_null(ls_sql) THEN
             LET p_pmdadocno = g_s_pmdadocno
             LET ls_sql = " pmdadocno IN ('",g_s_pmdadocno,"'"
          ELSE
             LET ls_sql = ls_sql,",","'",g_s_pmdadocno,"'"        
          END IF          
          IF NOT r_success THEN
             CALL s_transaction_end('N','0')
             CONTINUE FOR
          END IF
       END IF
    END IF
    IF g_type = '2' THEN  #依據客戶匯總
       IF g_detail_d[i].xmda004 <> l_xmda004_t OR l_xmda004_t IS NULL THEN  #單號改變
          LET l_xmda004_t = g_detail_d[i].xmda004
          CALL apmp610_ins_pmda() RETURNING r_success,g_s_pmdadocno,g_pmda011  #新增請購單單頭
          IF cl_null(ls_sql) THEN
             LET p_pmdadocno = g_s_pmdadocno
             LET ls_sql = " pmdadocno IN ('",g_s_pmdadocno,"'"
          ELSE
             LET ls_sql = ls_sql,",","'",g_s_pmdadocno,"'"        
          END IF         
          IF NOT r_success THEN
             CALL s_transaction_end('N','0')
             CONTINUE FOR
          END IF
       END IF       
    END IF
    IF g_type = '3' THEN  #不匯總
       IF (g_detail_d[i].xmdcdocno <> l_xmdadocno_t OR l_xmdadocno_t IS NULL) OR 
          (g_detail_d[i].xmdcseq <> l_xmdcseq_t OR l_xmdcseq_t IS NULL) OR 
          (g_detail_d[i].xmddseq1 <> l_xmddseq1_t OR l_xmddseq1_t IS NULL) OR
          (g_detail_d[i].xmddseq2 <> l_xmddseq2_t OR l_xmddseq2_t IS NULL) THEN
          LET l_xmdadocno_t = g_detail_d[i].xmdcdocno 
          LET l_xmdcseq_t = g_detail_d[i].xmdcseq
          LET l_xmddseq1_t = g_detail_d[i].xmddseq1   #add by lixh 20150529
          LET l_xmddseq2_t = g_detail_d[i].xmddseq2   #add by lixh 20150529
          CALL apmp610_ins_pmda() RETURNING r_success,g_s_pmdadocno,g_pmda011  #新增請購單單頭
          IF cl_null(ls_sql) THEN
             LET p_pmdadocno = g_s_pmdadocno
             LET ls_sql = " pmdadocno IN ('",g_s_pmdadocno,"'"
          ELSE
             LET ls_sql = ls_sql,",","'",g_s_pmdadocno,"'"         
          END IF          
          IF NOT r_success THEN
             CALL s_transaction_end('N','0')
             CONTINUE FOR
          END IF          
       END IF    
    END IF
    #產生請購單單身
    LET p_detail_d.* = g_detail_d[i].*
    CALL apmp610_ins_pmdb() RETURNING r_success
    IF NOT r_success THEN
       CALL s_transaction_end('N','0')
       CONTINUE FOR
    END IF
    IF r_success THEN
       CALL s_transaction_end('Y','0')
       LET g_flag = 'Y'
    ELSE
       CALL s_transaction_end('N','0')
    END IF   
    LET g_flag1 = 'Y'    
 END FOR 
 IF NOT cl_null(ls_sql) THEN
    LET ls_sql = ls_sql,")"
 END IF
 LET g_status = 100 
 DISPLAY g_status TO stagecomplete
 CALL cl_err_collect_show()  
 IF g_flag = 'Y' AND g_flag1 = 'Y' THEN
    #执行成功    
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code = 'adz-00217'
    LET g_errparam.extend = ''
    LET g_errparam.popup = TRUE
    CALL cl_err()
    INITIALIZE la_param.* TO NULL
    LET la_param.prog     = 'apmt400'
    LET la_param.param[1] =  ''
    LET la_param.param[2] = ls_sql
    LET ls_js = util.JSON.stringify(la_param)
    CALL cl_cmdrun(ls_js)    
 END IF 
END FUNCTION

################################################################################
# Descriptions...: 產生請購單單頭
# Memo...........:
# Usage..........: CALL apmp610_ins_pmda()
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp610_ins_pmda()
#161124-00048#8 mod-S
#DEFINE   l_pmda                  RECORD LIKE pmda_t.*
DEFINE l_pmda RECORD  #請購單單頭頭檔
       pmdaent LIKE pmda_t.pmdaent, #企业编号
       pmdaownid LIKE pmda_t.pmdaownid, #资料所有者
       pmdaowndp LIKE pmda_t.pmdaowndp, #资料所有部门
       pmdacrtid LIKE pmda_t.pmdacrtid, #资料录入者
       pmdacrtdp LIKE pmda_t.pmdacrtdp, #资料录入部门
       pmdacrtdt LIKE pmda_t.pmdacrtdt, #资料创建日
       pmdamodid LIKE pmda_t.pmdamodid, #资料更改者
       pmdamoddt LIKE pmda_t.pmdamoddt, #最近更改日
       pmdacnfid LIKE pmda_t.pmdacnfid, #资料审核者
       pmdacnfdt LIKE pmda_t.pmdacnfdt, #数据审核日
       pmdapstid LIKE pmda_t.pmdapstid, #资料过账者
       pmdapstdt LIKE pmda_t.pmdapstdt, #资料过账日
       pmdastus LIKE pmda_t.pmdastus, #状态码
       pmdasite LIKE pmda_t.pmdasite, #营运据点
       pmdadocno LIKE pmda_t.pmdadocno, #请购单号
       pmdadocdt LIKE pmda_t.pmdadocdt, #请购日期
       pmda001 LIKE pmda_t.pmda001, #版次
       pmda002 LIKE pmda_t.pmda002, #请购人员
       pmda003 LIKE pmda_t.pmda003, #请购部门
       pmda004 LIKE pmda_t.pmda004, #单价为必要录入
       pmda005 LIKE pmda_t.pmda005, #币种
       pmda006 LIKE pmda_t.pmda006, #No Use
       pmda007 LIKE pmda_t.pmda007, #费用部门
       pmda008 LIKE pmda_t.pmda008, #请购总税前金额
       pmda009 LIKE pmda_t.pmda009, #请购总含税金额
       pmda010 LIKE pmda_t.pmda010, #税种
       pmda011 LIKE pmda_t.pmda011, #税率
       pmda012 LIKE pmda_t.pmda012, #单价含税否
       pmda020 LIKE pmda_t.pmda020, #纳入APS计算
       pmda021 LIKE pmda_t.pmda021, #运送方式
       pmda022 LIKE pmda_t.pmda022, #备注
       pmda200 LIKE pmda_t.pmda200, #来源类型
       pmda201 LIKE pmda_t.pmda201, #采购方式
       pmda202 LIKE pmda_t.pmda202, #所属品类
       pmda203 LIKE pmda_t.pmda203, #需求组织
       pmda204 LIKE pmda_t.pmda204, #采购中心
       pmda205 LIKE pmda_t.pmda205, #配送中心
       pmda206 LIKE pmda_t.pmda206, #配送仓
       pmda207 LIKE pmda_t.pmda207, #到货日期
       pmda208 LIKE pmda_t.pmda208, #包装总数量
       pmda900 LIKE pmda_t.pmda900, #保留字段str
       pmda999 LIKE pmda_t.pmda999, #保留字段end
       pmda023 LIKE pmda_t.pmda023, #留置原因
       pmda024 LIKE pmda_t.pmda024, #送货地址
       pmda025 LIKE pmda_t.pmda025, #账款地址
       pmda209 LIKE pmda_t.pmda209, #包装总金额
       pmda210 LIKE pmda_t.pmda210, #品种数
       pmda211 LIKE pmda_t.pmda211, #需求时间
       pmda027 LIKE pmda_t.pmda027, #前端单号
       pmda028 LIKE pmda_t.pmda028  #前端类型
END RECORD
#161124-00048#8 mod-E
DEFINE   l_success               LIKE type_t.num5
DEFINE   r_success               LIKE type_t.num5
DEFINE   l_oodb011               LIKE oodb_t.oodb011   
DEFINE   l_pmda010_desc          LIKE type_t.chr80

   INITIALIZE l_pmda.* TO NULL
   LET r_success = TRUE
   CALL s_aooi200_gen_docno(g_site,g_pmdadocno,g_today,'apmt400') RETURNING l_success,l_pmda.pmdadocno
   IF NOT l_success THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = l_pmda.pmdadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()        
   END IF   
      
   #依據輸入的單別抓取單別的[C:預算控管]參數值，預設給pmda006(預算控管)
   CALL cl_get_doc_para(g_enterprise,g_site,l_pmda.pmdadocno,'D-COM-0002') RETURNING l_pmda.pmda006
   IF cl_null(l_pmda.pmda006) THEN
      LET l_pmda.pmda006 = 'N'
   END IF
   LET l_pmda.pmdaent = g_enterprise
   LET l_pmda.pmdasite = g_site
   LET l_pmda.pmdadocdt = g_today
   LET l_pmda.pmda001 = 0
   LET l_pmda.pmda002 = g_user
   LET l_pmda.pmda003 = g_dept
   LET l_pmda.pmda004 = 'N'
   LET l_pmda.pmda007 = g_dept
   LET l_pmda.pmda008 = 0
   LET l_pmda.pmda009 = 0
   LET l_pmda.pmda020 = 'Y'
   LET l_pmda.pmda200 = '2'
   LET l_pmda.pmdastus = 'N'
   
   #取得單據別設定的欄位預設值
   LET l_pmda.pmdadocdt = s_aooi200_get_doc_default(g_site,'1',l_pmda.pmdadocno,'pmdadocdt',l_pmda.pmdadocdt)
   LET l_pmda.pmda002 = s_aooi200_get_doc_default(g_site,'1',l_pmda.pmdadocno,'pmda002',l_pmda.pmda002)
   LET l_pmda.pmda003 = s_aooi200_get_doc_default(g_site,'1',l_pmda.pmdadocno,'pmda003',l_pmda.pmda003)
   LET l_pmda.pmda004 = s_aooi200_get_doc_default(g_site,'1',l_pmda.pmdadocno,'pmda004',l_pmda.pmda004)
   LET l_pmda.pmda010 = s_aooi200_get_doc_default(g_site,'1',l_pmda.pmdadocno,'pmda010',l_pmda.pmda010)
   LET l_pmda.pmda005 = s_aooi200_get_doc_default(g_site,'1',l_pmda.pmdadocno,'pmda005',l_pmda.pmda005)
   LET l_pmda.pmda007 = s_aooi200_get_doc_default(g_site,'1',l_pmda.pmdadocno,'pmda007',l_pmda.pmda007)
   LET l_pmda.pmda021 = s_aooi200_get_doc_default(g_site,'1',l_pmda.pmdadocno,'pmda021',l_pmda.pmda021)
   LET l_pmda.pmda020 = s_aooi200_get_doc_default(g_site,'1',l_pmda.pmdadocno,'pmda020',l_pmda.pmda020)
   LET l_pmda.pmda022 = s_aooi200_get_doc_default(g_site,'1',l_pmda.pmdadocno,'pmda022',l_pmda.pmda022)
   
   #根據稅別帶出稅率、含稅否等
   IF NOT cl_null(l_pmda.pmda010) THEN
      CALL s_tax_chk(g_site,l_pmda.pmda010)
          RETURNING l_success,l_pmda010_desc,l_pmda.pmda012,l_pmda.pmda011,l_oodb011
   END IF  
   LET l_pmda.pmdaownid = g_user
   LET l_pmda.pmdaowndp = g_dept
   LET l_pmda.pmdacrtid = g_user
   LET l_pmda.pmdacrtdp = g_dept 
   LET l_pmda.pmdacrtdt = g_today 
   LET l_pmda.pmdamodid = g_user
   LET l_pmda.pmdamoddt = g_today
   INSERT INTO pmda_t (pmdaent,pmdasite,pmdadocno,pmdadocdt,pmda001,pmda002,pmda003,pmda004,pmda005,pmda006,pmda007,
                       pmda008,pmda009,pmda010,pmda011,pmda012,pmda020,pmda021,pmda022,pmda200,pmdastus,                       
                       pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,pmdacrtdt,pmdamodid,pmdamoddt)
                VALUES(l_pmda.pmdaent,l_pmda.pmdasite,l_pmda.pmdadocno,l_pmda.pmdadocdt,l_pmda.pmda001,l_pmda.pmda002,
                       l_pmda.pmda003,l_pmda.pmda004,l_pmda.pmda005,l_pmda.pmda006,l_pmda.pmda007,l_pmda.pmda008,l_pmda.pmda009,
                       l_pmda.pmda010,l_pmda.pmda011,l_pmda.pmda012,l_pmda.pmda020,l_pmda.pmda021,l_pmda.pmda022,l_pmda.pmda200,l_pmda.pmdastus,                       
                       l_pmda.pmdaownid,l_pmda.pmdaowndp,l_pmda.pmdacrtid,l_pmda.pmdacrtdp,l_pmda.pmdacrtdt,l_pmda.pmdamodid,l_pmda.pmdamoddt)  
    IF SQLCA.sqlcode THEN
       LET r_success = FALSE 
    END IF
    RETURN r_success,l_pmda.pmdadocno,l_pmda.pmda011
END FUNCTION

################################################################################
# Descriptions...:  insert 請購單單身
# Memo...........:
# Usage..........: CALL apmp610_ins_pmdb()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp610_ins_pmdb()
#161124-00048#8 mod-S
#DEFINE   l_pmdb       RECORD LIKE pmdb_t.*
DEFINE l_pmdb RECORD  #請購單明細檔
       pmdbent LIKE pmdb_t.pmdbent, #企业编号
       pmdbsite LIKE pmdb_t.pmdbsite, #营运据点
       pmdbdocno LIKE pmdb_t.pmdbdocno, #请购单号
       pmdbseq LIKE pmdb_t.pmdbseq, #项次
       pmdb001 LIKE pmdb_t.pmdb001, #来源单号
       pmdb002 LIKE pmdb_t.pmdb002, #来源项次
       pmdb003 LIKE pmdb_t.pmdb003, #来源项序
       pmdb004 LIKE pmdb_t.pmdb004, #料件编号
       pmdb005 LIKE pmdb_t.pmdb005, #产品特征
       pmdb006 LIKE pmdb_t.pmdb006, #需求数量
       pmdb007 LIKE pmdb_t.pmdb007, #单位
       pmdb008 LIKE pmdb_t.pmdb008, #参考数量
       pmdb009 LIKE pmdb_t.pmdb009, #参考单位
       pmdb010 LIKE pmdb_t.pmdb010, #计价数量
       pmdb011 LIKE pmdb_t.pmdb011, #计价单位
       pmdb012 LIKE pmdb_t.pmdb012, #包装容器
       pmdb014 LIKE pmdb_t.pmdb014, #供应商选择
       pmdb015 LIKE pmdb_t.pmdb015, #供应商编号
       pmdb016 LIKE pmdb_t.pmdb016, #付款条件
       pmdb017 LIKE pmdb_t.pmdb017, #交易条件
       pmdb018 LIKE pmdb_t.pmdb018, #税率
       pmdb019 LIKE pmdb_t.pmdb019, #参考单价
       pmdb020 LIKE pmdb_t.pmdb020, #参考税前金额
       pmdb021 LIKE pmdb_t.pmdb021, #参考含税金额
       pmdb030 LIKE pmdb_t.pmdb030, #需求日期
       pmdb031 LIKE pmdb_t.pmdb031, #理由码
       pmdb032 LIKE pmdb_t.pmdb032, #行状态
       pmdb033 LIKE pmdb_t.pmdb033, #紧急度
       pmdb034 LIKE pmdb_t.pmdb034, #项目编号
       pmdb035 LIKE pmdb_t.pmdb035, #WBS
       pmdb036 LIKE pmdb_t.pmdb036, #活动编号
       pmdb037 LIKE pmdb_t.pmdb037, #收货据点
       pmdb038 LIKE pmdb_t.pmdb038, #收货库位
       pmdb039 LIKE pmdb_t.pmdb039, #收货储位
       pmdb040 LIKE pmdb_t.pmdb040, #no use
       pmdb041 LIKE pmdb_t.pmdb041, #允许部份交货
       pmdb042 LIKE pmdb_t.pmdb042, #允许提前交货
       pmdb043 LIKE pmdb_t.pmdb043, #保税
       pmdb044 LIKE pmdb_t.pmdb044, #纳入APS
       pmdb045 LIKE pmdb_t.pmdb045, #交期冻结否
       pmdb046 LIKE pmdb_t.pmdb046, #费用部门
       pmdb048 LIKE pmdb_t.pmdb048, #收货时段
       pmdb049 LIKE pmdb_t.pmdb049, #已转采购量
       pmdb050 LIKE pmdb_t.pmdb050, #备注
       pmdb051 LIKE pmdb_t.pmdb051, #结案/留置理由码
       pmdb200 LIKE pmdb_t.pmdb200, #商品条码
       pmdb201 LIKE pmdb_t.pmdb201, #包装单位
       pmdb202 LIKE pmdb_t.pmdb202, #件装数
       pmdb203 LIKE pmdb_t.pmdb203, #配送中心
       pmdb204 LIKE pmdb_t.pmdb204, #配送仓库
       pmdb205 LIKE pmdb_t.pmdb205, #采购中心
       pmdb206 LIKE pmdb_t.pmdb206, #采购员
       pmdb207 LIKE pmdb_t.pmdb207, #采购方式
       pmdb208 LIKE pmdb_t.pmdb208, #经营方式
       pmdb209 LIKE pmdb_t.pmdb209, #结算方式
       pmdb210 LIKE pmdb_t.pmdb210, #促销开始日
       pmdb211 LIKE pmdb_t.pmdb211, #促销结束日
       pmdb212 LIKE pmdb_t.pmdb212, #要货件数
       pmdb250 LIKE pmdb_t.pmdb250, #合理库存
       pmdb251 LIKE pmdb_t.pmdb251, #最高库存
       pmdb252 LIKE pmdb_t.pmdb252, #现有库存
       pmdb253 LIKE pmdb_t.pmdb253, #入库在途量
       pmdb254 LIKE pmdb_t.pmdb254, #前一周销量
       pmdb255 LIKE pmdb_t.pmdb255, #前二周销量
       pmdb256 LIKE pmdb_t.pmdb256, #前三周销量
       pmdb257 LIKE pmdb_t.pmdb257, #前四周销量
       pmdb258 LIKE pmdb_t.pmdb258, #要货在途量
       pmdb259 LIKE pmdb_t.pmdb259, #周平均销量
       pmdb900 LIKE pmdb_t.pmdb900, #保留字段str
       pmdb999 LIKE pmdb_t.pmdb999, #保留字段end
       pmdb260 LIKE pmdb_t.pmdb260, #收货部门
       pmdb052 LIKE pmdb_t.pmdb052, #来源分批序
       pmdb227 LIKE pmdb_t.pmdb227, #补货规格说明
       pmdb053 LIKE pmdb_t.pmdb053, #预算细项
       pmdb213 LIKE pmdb_t.pmdb213, #参考进价
       pmdb054 LIKE pmdb_t.pmdb054, #库存管理特征
       pmdb214 LIKE pmdb_t.pmdb214  #需求时间
END RECORD
#161124-00048#8 mod-E
DEFINE   r_success    LIKE type_t.num5

   LET r_success = TRUE
   
   LET l_pmdb.pmdbent = g_enterprise
   LET l_pmdb.pmdbsite = g_site
   LET l_pmdb.pmdbdocno = g_s_pmdadocno
   SELECT MAX(pmdbseq)+1 INTO l_pmdb.pmdbseq FROM pmdb_t
    WHERE pmdbent = g_enterprise
      AND pmdbsite = g_site
     # AND pmdbdocno = g_pmdadocno
      AND pmdbdocno = g_s_pmdadocno
   IF cl_null(l_pmdb.pmdbseq) THEN
      LET l_pmdb.pmdbseq = 1
   END IF   
   LET l_pmdb.pmdb001 = p_detail_d.xmdcdocno
   LET l_pmdb.pmdb002 = p_detail_d.xmdcseq
   LET l_pmdb.pmdb003 = p_detail_d.xmddseq1
   LET l_pmdb.pmdb052 = p_detail_d.xmddseq2    #add by lixh 20150528
   LET l_pmdb.pmdb030 = p_detail_d.xmdd011
   LET l_pmdb.pmdb014 = '1'
   LET l_pmdb.pmdb032 = '1'
   LET l_pmdb.pmdb033 = '1'
   LET l_pmdb.pmdb041 = 'N'
   LET l_pmdb.pmdb042 = 'N'
   LET l_pmdb.pmdb043 = 'N'
   LET l_pmdb.pmdb045 = 'N'
   LET l_pmdb.pmdb046 = g_dept
   LET l_pmdb.pmdb044 = 'Y'
   LET l_pmdb.pmdb048 = '1'
   LET l_pmdb.pmdb049 = 0
   LET l_pmdb.pmdb018 = g_pmda011
   LET l_pmdb.pmdb019 = 0
   LET l_pmdb.pmdb020 = 0
   LET l_pmdb.pmdb021 = 0
   
   LET l_pmdb.pmdb004 = p_detail_d.xmdc001
   LET l_pmdb.pmdb005 = p_detail_d.xmdc002
   SELECT imaf143,imaf015 INTO l_pmdb.pmdb007,l_pmdb.pmdb009 FROM imaf_t   
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = p_detail_d.xmdc001
      
   CALL s_aooi250_convert_qty(l_pmdb.pmdb004,p_detail_d.xmdc006,l_pmdb.pmdb007,p_detail_d.pmdb006) 
        RETURNING r_success,l_pmdb.pmdb006
         
   CALL s_aooi250_convert_qty(l_pmdb.pmdb004,p_detail_d.xmdc006,l_pmdb.pmdb009,p_detail_d.pmdb006) 
        RETURNING r_success,l_pmdb.pmdb008     
   
   LET l_pmdb.pmdb011 = l_pmdb.pmdb007   #計價單位   
   LET l_pmdb.pmdb010 = l_pmdb.pmdb006   #計價數量
   
#   INSERT INTO pmdb_t (pmdbent,pmdbsite,pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb004,pmdb005,pmdb006,pmdb07,pmdb008,pmdb009,
#                       pmdb010,pmdb011,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020,pmdb021,pmdb030,pmdb031,pmdb032,pmdb033,
#                       pmdb034,pmdb035,pmdb036,pmdb037,pmdb038,pmdb039,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,pmdb046,pmdb048,
#                       pmdb049,pmdb050,pmdb051)
#               VALUES (g_enterprise,g_site,l_pmdb.pmdbdocno,l_pmdb.pmdbseq,l_pmdb.pmdb001,l_pmdb.pmdb002,l_pmdb.pmdb003,l_pmdb.pmdb004,l_pmdb.pmdb005,
#                       l_pmdb.pmdb006,l_pmdb.pmdb007,l_pmdb.pmdb008,l_pmdb.pmdb009,l_pmdb.pmdb010,l_pmdb.pmdb011,l_pmdb.pmdb012,l_pmdb.pmdb014,l_pmdb.pmdb015,
#                       l_pmdb.pmdb016,l_pmdb.pmdb017,l_pmdb.pmdb018,l_pmdb.pmdb019,l_pmdb.pmdb020,l_pmdb.pmdb021,l_pmdb.pmdb030,l_pmdb.pmdb031,l_pmdb.pmdb032,
#                       l_pmdb.pmdb033,l_pmdb.pmdb034,l_pmdb.pmdb035,l_pmdb.pmdb036,l_pmdb.pmdb037,l_pmdb.pmdb038,l_pmdb.pmdb039,l_pmdb.pmdb041,
#                       l_pmdb.pmdb042,l_pmdb.pmdb043,l_pmdb.pmdb044,l_pmdb.pmdb045,l_pmdb.pmdb046,l_pmdb.pmdb048,l_pmdb.pmdb049,l_pmdb.pmdb050,
#                       l_pmdb.pmdb051)

   INSERT INTO pmdb_t (pmdbent,pmdbsite,pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb004,pmdb005,pmdb006,pmdb007,pmdb008,pmdb009,
                       pmdb010,pmdb011,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020,pmdb021,pmdb030,pmdb031,pmdb032,pmdb033,
                       pmdb034,pmdb035,pmdb036,pmdb037,pmdb038,pmdb039,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,pmdb046,pmdb048,
                       pmdb049,pmdb050,pmdb051,pmdb052)
               VALUES (g_enterprise,g_site,l_pmdb.pmdbdocno,l_pmdb.pmdbseq,l_pmdb.pmdb001,l_pmdb.pmdb002,l_pmdb.pmdb003,l_pmdb.pmdb004,l_pmdb.pmdb005,
                       l_pmdb.pmdb006,l_pmdb.pmdb007,l_pmdb.pmdb008,l_pmdb.pmdb009,l_pmdb.pmdb010,l_pmdb.pmdb011,l_pmdb.pmdb012,l_pmdb.pmdb014,l_pmdb.pmdb015,
                       l_pmdb.pmdb016,l_pmdb.pmdb017,l_pmdb.pmdb018,l_pmdb.pmdb019,l_pmdb.pmdb020,l_pmdb.pmdb021,l_pmdb.pmdb030,l_pmdb.pmdb031,l_pmdb.pmdb032,
                       l_pmdb.pmdb033,l_pmdb.pmdb034,l_pmdb.pmdb035,l_pmdb.pmdb036,l_pmdb.pmdb037,l_pmdb.pmdb038,l_pmdb.pmdb039,l_pmdb.pmdb041,l_pmdb.pmdb042,
                       l_pmdb.pmdb043,l_pmdb.pmdb044,l_pmdb.pmdb045,l_pmdb.pmdb046,l_pmdb.pmdb048,
                       l_pmdb.pmdb049,l_pmdb.pmdb050,
                       l_pmdb.pmdb051,l_pmdb.pmdb052)
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE 
   END IF               
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
