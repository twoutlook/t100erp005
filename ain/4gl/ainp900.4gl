#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp900.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-09-07 10:52:19), PR版次:0006(2016-06-22 17:13:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000149
#+ Filename...: ainp900
#+ Description: 盤點批次確認作業
#+ Creator....: 01534(2014-06-02 22:31:06)
#+ Modifier...: 01534 -SD/PR- 04543
 
{</section>}
 
{<section id="ainp900.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160517-00029#10 2016/06/22  By earl      abci200狀態調整到與aint830一致
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
              b_inpdsite         LIKE inpd_t.inpdsite,              
              b_inpddocno        LIKE inpd_t.inpddocno,
              b_inpdseq          LIKE inpd_t.inpdseq,
              b_inpd001          LIKE inpd_t.inpd001,
              b_inpd001_desc     LIKE type_t.chr500,
              b_inpd001_desc_desc   LIKE type_t.chr500,
              b_inpf001          LIKE inpf_t.inpf001,
              b_inpd002          LIKE inpd_t.inpd002,
              b_inpd003          LIKE inpd_t.inpd003,  
              b_inpd005          LIKE inpd_t.inpd005,
              b_inpd005_desc     LIKE type_t.chr500,
              b_inpd006          LIKE inpd_t.inpd006,
              b_inpd006_desc     LIKE type_t.chr500,   
              b_inpd007          LIKE inpd_t.inpd007  
                    END RECORD
DEFINE g_invent   LIKE type_t.chr1
DEFINE g_work     LIKE type_t.chr1
DEFINE g_check    LIKE type_t.chr1
DEFINE g_conf     LIKE type_t.chr1
DEFINE g_type     LIKE type_t.chr1
#TYPE type_g_qbe      RECORD
#         inpd008       LIKE inpd_t.inpd008,
#         inpddocno     LIKE inpd_t.inpddocno,
#         inpd034       LIKE inpd_t.inpd034,
#         inpd032       LIKE inpd_t.inpd032,
#         inpd033       LIKE inpd_t.inpd033,
#         inpd005       LIKE inpd_t.inpd005,
#         inpd006       LIKE inpd_t.inpd006
#                     END RECORD 
#DEFINE g_qbe         type_g_qbe   
DEFINE g_inpd033     LIKE inpd_t.inpd033
DEFINE l_invent      LIKE inpd_t.inpd009
DEFINE l_work        LIKE inpd_t.inpd009
DEFINE l_check       LIKE inpd_t.inpd009
DEFINE l_conf        LIKE inpd_t.inpd009
DEFINE g_wc_inpd034  STRING
DEFINE g_wc_inpd032  STRING
DEFINE g_wc_inpd005  STRING
DEFINE g_wc_inpd008  STRING
DEFINE g_wc_inpd033  STRING
DEFINE g_wc1         STRING
DEFINE g_sql1        STRING
DEFINE g_sql2        STRING
DEFINE l_wc          STRING
DEFINE l_wc1         STRING
DEFINE l_wc2         STRING
DEFINE l_wc3         STRING
DEFINE l_wc4         STRING
DEFINE l_wc5         STRING
DEFINE l_wc6         STRING
DEFINE g_inpd008     LIKE inpd_t.inpd008
DEFINE g_inpa009     LIKE inpa_t.inpa009
DEFINE g_inpa010     LIKE inpa_t.inpa010
DEFINE g_inpa011     LIKE inpa_t.inpa011
DEFINE g_inpa012     LIKE inpa_t.inpa012
DEFINE g_inpa013     LIKE inpa_t.inpa013
DEFINE g_inpa014     LIKE inpa_t.inpa014
DEFINE g_inpa015     LIKE inpa_t.inpa015
DEFINE g_inpa016     LIKE inpa_t.inpa016
DEFINE g_inpd034     LIKE inpd_t.inpd034
DEFINE g_inpd040     LIKE inpd_t.inpd034
DEFINE g_inpd054     LIKE inpd_t.inpd034
DEFINE g_inpd060     LIKE inpd_t.inpd034 
DEFINE p_inpd008     LIKE inpd_t.inpd008
DEFINE p_inpddocno   LIKE inpd_t.inpddocno
DEFINE p_inpd034     LIKE inpd_t.inpd034
DEFINE p_inpd032     LIKE inpd_t.inpd032
DEFINE p_inpd033     LIKE inpd_t.inpd033
DEFINE p_inpd005     LIKE inpd_t.inpd005
DEFINE p_inpd006     LIKE inpd_t.inpd006
DEFINE g_inpf004     LIKE inpf_t.inpf004
DEFINE g_inpg031     LIKE inpd_t.inpd034
DEFINE g_inpg034     LIKE inpd_t.inpd034
DEFINE g_inpg051     LIKE inpd_t.inpd034
DEFINE g_inpg054     LIKE inpd_t.inpd034 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
       
#end add-point
 
{</section>}
 
{<section id="ainp900.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   IF NOT cl_null(g_argv[01]) THEN
      LET p_inpd008 = g_argv[01]
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_type = g_argv[02]
      IF g_type MATCHES '[12]' THEN
         LET l_invent = 'Y'
         LET l_work = 'N'
         LET l_check = '1'       
      END IF
      IF g_type MATCHES '[34]' THEN
         LET l_invent = 'Y'
         LET l_work = 'N'
         LET l_check = '2'       
      END IF 
      IF g_type MATCHES '[56]' THEN
         LET l_invent = 'N'
         LET l_work = 'Y'
         LET l_check = '1'       
      END IF    
      IF g_type MATCHES '[78]' THEN
         LET l_invent = 'N'
         LET l_work = 'Y'
         LET l_check = '2'       
      END IF        
      IF NOT cl_null(g_type) THEN
#         CALL cl_set_comp_entry("l_invent,l_work,l_check,l_conf",FALSE)
         #CALL cl_set_comp_entry("l_invent,l_work,l_check",FALSE)   #mark by lixh 201509907 背景執行不能對畫面做處理
      END IF   
   END IF 
   IF NOT cl_null(g_argv[03]) THEN
      LET l_conf = g_argv[03]
#      IF l_conf <> 'N' THEN  #mark by lixh 1017
#         LET l_conf = 'N'
#      ELSE
#         LET l_conf = 'Y'
#      END IF  
   END IF  
   #add by lixh 20150104
   IF cl_null(l_conf) THEN 
      LET l_conf =  'Y'
   END IF   
   
   IF NOT cl_null(g_argv[06]) THEN 
      LET g_bgjob = g_argv[06]
      IF g_bgjob = 'Y' THEN
         LET g_detail_cnt = 1
      END IF   
   END IF    
   IF NOT cl_null(g_argv[04]) AND g_bgjob = 'Y' THEN  
      LET g_detail_d[1].b_inpddocno = g_argv[04]
   END IF
   IF NOT cl_null(g_argv[05]) AND g_bgjob = 'Y' THEN   
      LET g_detail_d[1].b_inpdseq = g_argv[05]
   END IF   
  
#   IF NOT cl_null(g_argv[03]) THEN
#      LET g_type = g_argv[03]
#      IF g_type = '1' THEN
#         LET l_invent = 'Y'
#         LET l_work = 'N'
#         LET l_check = '1' 
#         CALL cl_set_comp_entry("l_invent,l_work,l_check,l_conf",FALSE)
#      END IF
#   END IF  
#   IF NOT cl_null(g_argv[04]) THEN
#      LET l_conf = g_argv[04]
#      IF l_conf <> 'N' THEN
#         LET l_conf = 'N'
#      ELSE
#         LET l_conf = 'Y'
#      END IF        
#   END IF   
#   IF NOT cl_null(g_argv[05]) THEN
#      LET l_invent = g_argv[05]
#   END IF  
#   IF NOT cl_null(g_argv[06]) THEN
#      LET l_work = g_argv[06]
#   END IF
#   IF NOT cl_null(g_argv[07]) THEN
#      LET p_inpd008 = g_argv[07]
#   END IF
#   IF NOT cl_null(g_argv[08]) THEN
#      LET p_inpddocno = g_argv[08]
#      LET p_inpddocno = ''
#   END IF 
#   IF NOT cl_null(g_argv[09]) THEN
#      LET p_inpd034 = g_argv[09]
#      LET p_inpd034 = ''
#   END IF   
#   IF NOT cl_null(g_argv[10]) THEN
#      LET p_inpd032 = g_argv[10]
#      LET p_inpd032 = ''
#   END IF  
#   IF NOT cl_null(g_argv[11]) THEN
#      LET g_inpd033 = g_argv[11]
#      LET g_inpd033 = ''
#   END IF  
#   IF NOT cl_null(g_argv[12]) THEN
#      LET p_inpd005 = g_argv[12]
#      LET p_inpd005 = ''
#   END IF  
#   IF NOT cl_null(g_argv[13]) THEN
#      LET p_inpd006 = g_argv[13]
#      LET p_inpd006 = ''
#   END IF
   LET g_inpd033 = ''
   IF g_bgjob = 'N' THEN
      LET g_detail_cnt = 0  
   END IF      
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      CALL ainp900_batch_conf()
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp900 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainp900_init()   
 
      #進入選單 Menu (="N")
      CALL ainp900_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainp900
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainp900.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION ainp900_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp900.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainp900_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   IF NOT cl_null(g_argv[03]) THEN
      LET l_conf = g_argv[03]
#      IF l_conf <> 'N' THEN
#         LET l_conf = 'N'
#      ELSE
#         LET l_conf = 'Y'
#      END IF        
   END IF 
   #add by lixh 20150104
   IF cl_null(l_conf) THEN 
      LET l_conf =  'Y'
   END IF      
   IF g_type = '2' THEN
      LET l_invent = 'Y'
      LET l_work = 'N'
      LET l_check = '1'       
   END IF  
   IF g_type MATCHES '[34]' THEN
      LET l_invent = 'Y'
      LET l_work = 'N'
      LET l_check = '2'       
   END IF    
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ainp900_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON inpd008,inpddocno
	   
            BEFORE CONSTRUCT
                                                      
            ON ACTION controlp INFIELD inpd008 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inpadocno()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpd008  #顯示到畫面上
               NEXT FIELD inpd008                     #返回原欄位

            ON ACTION controlp INFIELD inpddocno      #产品分类
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inpddocno()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpddocno   #顯示到畫面上
               NEXT FIELD inpddocno                      #返回原欄位
               
#            ON ACTION accept
#               #ACCEPT DIALOG
#               CALL ainp900_b_fill()

         END CONSTRUCT
         
         CONSTRUCT BY NAME g_wc_inpd034 ON inpd034
	   
            BEFORE CONSTRUCT    

            ON ACTION controlp INFIELD inpd034 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpd034  #顯示到畫面上
               NEXT FIELD inpd034  

#            ON ACTION accept
#               #ACCEPT DIALOG
#               CALL ainp900_b_fill()
               
         END CONSTRUCT      
         
         CONSTRUCT BY NAME g_wc_inpd032 ON inpd032
            BEFORE CONSTRUCT    

            ON ACTION controlp INFIELD inpd032 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpd032  #顯示到畫面上
               NEXT FIELD inpd032  

#            ON ACTION accept
#               #ACCEPT DIALOG
#               CALL ainp900_b_fill()
         END CONSTRUCT      

         CONSTRUCT BY NAME g_wc_inpd033 ON inpd033
            BEFORE CONSTRUCT    
               LET g_inpd033 = GET_FLDBUF(inpd033)
            AFTER FIELD inpd033
               LET g_inpd033 = GET_FLDBUF(inpd033)

#            ON ACTION accept
#               #ACCEPT DIALOG
#               CALL ainp900_b_fill()
            AFTER CONSTRUCT
               LET g_inpd033 = GET_FLDBUF(inpd033)
         END CONSTRUCT    

         CONSTRUCT BY NAME g_wc_inpd005 ON inpd005,inpd006
            BEFORE CONSTRUCT    
            
            ON ACTION controlp INFIELD inpd005 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inaa001_12()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpd005  #顯示到畫面上
               NEXT FIELD inpd005      

            ON ACTION controlp INFIELD inpd006 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inab002_1()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO inpd006  #顯示到畫面上
               NEXT FIELD inpd006 
               
#            ON ACTION accept
#               #ACCEPT DIALOG
#               CALL ainp900_b_fill()
         END CONSTRUCT             
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME l_invent,l_work,l_check,l_conf
            BEFORE INPUT
               IF cl_null(g_argv[01]) THEN
                  IF cl_null(l_invent) THEN LET l_invent = 'Y' END IF
                  IF cl_null(l_work) THEN LET l_work = 'N' END IF
                  IF cl_null(l_check) THEN LET l_check = '1' END IF
                  IF cl_null(l_conf) THEN LET l_conf = 'Y' END IF 
                  DISPLAY l_invent TO l_invent
               ELSE
#                  CALL cl_set_comp_entry("l_invent,l_work,l_check,l_conf",FALSE)    
                  CALL cl_set_comp_entry("l_invent,l_work,l_check",FALSE)    
               END IF                  
         END INPUT
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
            BEFORE INPUT
               CALL ainp900_b_fill()
               LET g_detail_cnt = g_detail_d.getLength()
               IF g_detail_d.getLength() > 0 THEN
                  CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
                  CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
               ELSE
                  CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
                  CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
               END IF   
               CALL cl_set_comp_visible("sel",TRUE)               
            BEFORE ROW

               LET l_ac = ARR_CURR()
            
               LET g_detail_cnt = g_detail_d.getLength()

         
            AFTER FIELD sel
               IF l_ac <> 0 THEN
                  IF NOT cl_null(g_detail_d[l_ac].sel) THEN
                     IF g_detail_d[l_ac].sel NOT MATCHES '[YN]' THEN
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET INT_FLAG = 0
                  NEXT FIELD sel
               END IF
                  
            AFTER ROW
                  
            AFTER INPUT
    
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
            IF cl_null(g_argv[02]) THEN
               IF cl_null(l_invent) THEN LET l_invent = 'Y' END IF
               IF cl_null(l_work) THEN LET l_work = 'N' END IF
               IF cl_null(l_check) THEN LET l_check = '1' END IF
               IF cl_null(l_conf) THEN LET l_conf = 'Y' END IF 
               DISPLAY l_invent TO l_invent
               LET g_inpd033 = NULL
            ELSE   
               IF NOT cl_null(g_argv[02]) THEN
                  LET g_type = g_argv[02] 
                  IF g_type MATCHES '[12]' THEN
                     LET l_invent = 'Y'
                     LET l_work = 'N'
                     LET l_check = '1'       
                  END IF
                  IF g_type MATCHES '[34]' THEN
                     LET l_invent = 'Y'
                     LET l_work = 'N'
                     LET l_check = '2'       
                  END IF  
                  IF g_type MATCHES '[56]' THEN
                     LET l_invent = 'N'
                     LET l_work = 'Y'
                     LET l_check = '1'       
                  END IF    
                  IF g_type MATCHES '[78]' THEN
                     LET l_invent = 'N'
                     LET l_work = 'Y'
                     LET l_check = '2'       
                  END IF                    
                  IF NOT cl_null(g_type) THEN
#                     CALL cl_set_comp_entry("l_invent,l_work,l_check,l_conf",FALSE)   
                     CALL cl_set_comp_entry("l_invent,l_work,l_check",FALSE) 
                  END IF                  
               END IF   
               IF NOT cl_null(g_argv[03]) THEN
                  LET l_conf = g_argv[03]
#                  IF l_conf <> 'N' THEN
#                     LET l_conf = 'N'
#                  ELSE
#                     LET l_conf = 'Y'
#                  END IF        
               END IF   
               IF cl_null(l_conf) THEN
                  LET l_conf = 'Y'
               END IF               
               DISPLAY l_invent TO l_invent
               DISPLAY l_work TO l_work
               DISPLAY l_check TO l_check
               DISPLAY l_conf TO l_conf
               DISPLAY p_inpd008 TO inpd008
#               DISPLAY p_inpddocno TO inpddocno 
#               DISPLAY p_inpd034 TO inpd034  
#               DISPLAY p_inpd032 TO inpd032
               DISPLAY g_inpd033 TO inpd033
#               DISPLAY p_inpd005 TO inpd005 
#               DISPLAY p_inpd006 TO inpd006
            END IF   
            CALL cl_set_comp_visible("sel",TRUE) 
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
            IF cl_null(l_invent) THEN LET l_invent = 'Y' END IF
            IF cl_null(l_work) THEN LET l_work = 'N' END IF
            IF cl_null(l_check) THEN LET l_check = '1' END IF
            IF cl_null(l_conf) THEN LET l_conf = 'Y' END IF 
            DISPLAY l_invent TO l_invent
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
            CALL ainp900_filter()
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
            CALL ainp900_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL ainp900_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL ainp900_batch_conf()
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
 
{<section id="ainp900.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION ainp900_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL ainp900_b_fill()
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
 
{<section id="ainp900.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainp900_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql1 = " SELECT DISTINCT 'N',inpdsite,inpddocno,inpdseq,inpd001,'','','',inpd002,inpd003,inpd005,'',inpd006,'',inpd007 FROM inpd_t,inpa_t ",
#   LET g_sql1 = " SELECT DISTINCT 'N',inpdsite,inpddocno,inpdseq,inpd001,'','','','','','','','','','' FROM inpd_t,inpa_t ",
                "  WHERE inpdent = inpaent AND inpdsite = inpasite AND inpd008 = inpadocno ",
                "    AND inpdent = ? ",
                "    AND inpdsite = '",g_site,"'",
                "    AND ",g_wc              
               
   LET g_sql2 = " SELECT DISTINCT 'N',inpfsite,inpfdocno,inpfseq,inpf003,'','',inpf001,'','','','','','','' FROM inpf_t,inpg_t,inpa_t ",   
#   LET g_sql2 = " SELECT DISTINCT 'N',inpfsite,inpfdocno,inpfseq,inpf003,'','','','','','','','','','' FROM inpf_t,inpg_t,inpa_t ",   
                "  WHERE inpfent = inpaent AND inpfsite = inpasite AND inpf004 = inpadocno ",
                "    AND inpfent = inpgent AND inpfsite = inpgsite AND inpfdocno = inpgdocno AND inpfseq = inpgseq ",
                "    AND inpfent = '",g_enterprise,"'",
                "    AND inpfsite = '",g_site,"'"               
    
   IF NOT cl_null(g_wc_inpd005) THEN
      LET g_sql1 = g_sql1," AND ",g_wc_inpd005
   END IF      

   IF NOT cl_null(g_wc) THEN
      LET g_wc_inpd008 = cl_replace_str(g_wc,'inpd008','inpf004')
      LET g_wc_inpd008 = cl_replace_str(g_wc_inpd008,'inpddocno','inpfdocno') 
   END IF   
   IF NOT cl_null(g_wc_inpd008) THEN
      LET g_sql2 = g_sql2," AND ",g_wc_inpd008
   END IF 
   #現有庫存
   IF l_invent = 'Y' THEN   
      IF l_check = '1' THEN  #初盤
         IF NOT cl_null(g_wc_inpd034) THEN
            LET l_wc = cl_replace_str(g_wc_inpd034,'inpd034','inpd040')
            LET g_sql1 = g_sql1, " AND (",g_wc_inpd034," OR ",l_wc,")"
         END IF
         IF NOT cl_null(g_wc_inpd032) THEN
            LET l_wc = cl_replace_str(g_wc_inpd032,'inpd032','inpd038')
            LET g_sql1 = g_sql1, " AND (",g_wc_inpd032," OR ",l_wc,")"
         END IF  
         IF NOT cl_null(g_wc_inpd033) THEN 
             LET g_wc1 = cl_replace_str(g_wc_inpd033,'inpd033','inpd039')
             LET g_sql1 = g_sql1," AND (",g_wc_inpd033, " OR ",g_wc1,")"
         END IF  
#         LET g_sql1 = g_sql1, " AND (( inpa010 = 'Y' AND inpd040 IS NOT NULL) OR (inpa010 = 'N' AND inpd034 IS NOT NULL))"   #mark
         LET g_sql1 = g_sql1, " AND (inpa010 = 'Y' OR inpa009 = 'Y' )"   #add by lixh 20150325
      END IF 
      IF l_check = '2' THEN  #復盤
         IF NOT cl_null(g_wc_inpd034) THEN
            LET l_wc = cl_replace_str(g_wc_inpd034,'inpd034','inpd054')
            LET l_wc1 = cl_replace_str(g_wc_inpd034,'inpd034','inpd060')            
            LET g_sql1 = g_sql1, " AND (",l_wc," OR ",l_wc1,")"
         END IF
         IF NOT cl_null(g_wc_inpd032) THEN
            LET l_wc2 = cl_replace_str(g_wc_inpd032,'inpd032','inpd052')
            LET l_wc3 = cl_replace_str(g_wc_inpd032,'inpd032','inpd058')
            LET g_sql1 = g_sql1, " AND (",l_wc2," OR ",l_wc3,")"
         END IF 
         IF NOT cl_null(g_wc_inpd033) THEN             
            LET g_wc1 = cl_replace_str(g_wc_inpd033,'inpd033','inpd053')
            LET g_wc2 = cl_replace_str(g_wc_inpd033,'inpd033','inpd059')
            LET g_sql1 = g_sql1," AND (",g_wc1, " OR ",g_wc2,")"
         END IF      
         #LET g_sql1 = g_sql1, " AND (( inpa012 = 'Y' AND inpd060 IS NOT NULL) OR (inpa012 = 'N' AND inpd054 IS NOT NULL))"  
         LET g_sql1 = g_sql1, " AND ( inpa012 = 'Y' OR inpa011 = 'Y')"     #add by lixh 20150325      
      END IF 
      IF l_conf = 'Y' THEN
         IF l_check = '1' THEN  #初盤確認
            LET g_sql1 = g_sql1, " AND inpdstus = 'N' "
         ELSE
            LET g_sql1 = g_sql1, " AND (inpdstus = 'N' OR inpdstus = '5') "         
         END IF   
      END IF
      IF l_conf = 'N' THEN
         IF l_check = '1' THEN  #初盤
            LET g_sql1 = g_sql1, " AND inpdstus ='5' "
         ELSE  
            #復盤
            LET g_sql1 = g_sql1, " AND inpdstus ='6' "
         END IF         
      END IF      
   END IF   
   IF l_work = 'Y' THEN
      IF l_check = '1' THEN #初盤
         IF NOT cl_null(g_wc_inpd032) THEN
            LET l_wc3 = cl_replace_str(g_wc_inpd032,'inpd032','inpf020')
            LET l_wc4 = cl_replace_str(g_wc_inpd032,'inpd032','inpf022')            
            LET g_sql2 = g_sql2," AND (",l_wc3," OR ",l_wc4,")"
         END IF
         
         IF NOT cl_null(g_wc_inpd033) THEN 
            LET g_wc1 = cl_replace_str(g_wc_inpd033,'inpd033','inpf021')
            LET g_wc2 = cl_replace_str(g_wc_inpd033,'inpd033','inpf023')
            LET g_sql2 = g_sql2," AND (",g_wc1," OR ",g_wc2,")"
         END IF     
         
         IF NOT cl_null(g_wc_inpd034) THEN    
            LET l_wc5 = cl_replace_str(g_wc_inpd034,'inpd034','inpg031')
            LET l_wc6 = cl_replace_str(g_wc_inpd034,'inpd034','inpg034')
            LET g_sql2 = g_sql2," AND (",l_wc5," OR ",l_wc6,")"
         END IF  
         #LET g_sql2 = g_sql2, " AND (( inpa014 = 'Y' AND inpg034 IS NOT NULL) OR (inpa014 = 'N' AND inpg031 IS NOT NULL))" #mark by lixh 20150325 
         LET g_sql2 = g_sql2, " AND (inpa014 = 'Y' OR inpa013 = 'Y')"   #add by lixh 20150325        
      END IF   

      IF l_check = '2' THEN  #復盤
         IF NOT cl_null(g_wc_inpd032) THEN
            LET l_wc3 = cl_replace_str(g_wc_inpd032,'inpd032','inpf024')
            LET l_wc4 = cl_replace_str(g_wc_inpd032,'inpd032','inpf026')
            LET g_sql2 = g_sql2," AND (",l_wc3," OR ",l_wc4,")"
         END IF
         
         IF NOT cl_null(g_wc_inpd033) THEN 
            LET g_wc1 = cl_replace_str(g_wc_inpd033,'inpd033','inpf025')
            LET g_wc2 = cl_replace_str(g_wc_inpd033,'inpd033','inpf027')
            LET g_sql2 = g_sql2," AND (",g_wc1," OR ",g_wc2,")"
         END IF 
         
         IF NOT cl_null(g_wc_inpd034) THEN    
            LET l_wc5 = cl_replace_str(g_wc_inpd034,'inpd034','inpg051')
            LET l_wc6 = cl_replace_str(g_wc_inpd034,'inpd034','inpg054')
            LET g_sql2 = g_sql2," AND (",l_wc5," OR ",l_wc6,")"
         END IF   
         #LET g_sql2 = g_sql2, " AND (( inpa016 = 'Y' AND inpg054 IS NOT NULL) OR (inpa016 = 'N' AND inpg051 IS NOT NULL))" #mark by lixh 20150325
         LET g_sql2 = g_sql2, " AND (inpa016 = 'Y' OR inpa015 = 'Y')"      #add by lixh 20150325   
      END IF   
      
      IF l_conf = 'Y' THEN
         IF l_check = '1' THEN
            LET g_sql2 = g_sql2, " AND inpfstus = 'N' "
         ELSE
            LET g_sql2 = g_sql2, " AND (inpfstus = 'N' OR inpfstus = '5')"         
         END IF   
      END IF
      IF l_conf = 'N' THEN
         IF l_check = '1' THEN
            LET g_sql2= g_sql2, " AND inpfstus = '5' "
         ELSE
            LET g_sql2= g_sql2, " AND inpfstus = '6' "   
         END IF         
      END IF  
   END IF
   IF l_invent = 'Y' AND l_work = 'N' THEN
      LET g_sql = g_sql1
   END IF
   IF l_invent = 'N' AND l_work = 'Y' THEN
      LET g_sql = g_sql2
   END IF
   IF l_invent = 'Y' AND l_work = 'Y' THEN
      LET g_sql = g_sql1," UNION ",g_sql2
   END IF   
   IF l_invent = 'Y' THEN
      LET g_sql = g_sql," ORDER BY inpddocno,inpdseq "
   ELSE
      LET g_sql = g_sql," AND inpfent = ?  ORDER BY inpfdocno,inpfseq "
   END IF   
   #end add-point
 
   PREPARE ainp900_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainp900_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"

      g_detail_d[l_ac].sel,g_detail_d[l_ac].b_inpdsite,g_detail_d[l_ac].b_inpddocno,g_detail_d[l_ac].b_inpdseq,
      g_detail_d[l_ac].b_inpd001,g_detail_d[l_ac].b_inpd001_desc,g_detail_d[l_ac].b_inpd001_desc_desc,g_detail_d[l_ac].b_inpf001,
      g_detail_d[l_ac].b_inpd002,g_detail_d[l_ac].b_inpd003,g_detail_d[l_ac].b_inpd005,g_detail_d[l_ac].b_inpd005_desc,
      g_detail_d[l_ac].b_inpd006,g_detail_d[l_ac].b_inpd006_desc,g_detail_d[l_ac].b_inpd007
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
      
      #end add-point
      
      CALL ainp900_detail_show()      
 
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
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE ainp900_sel
   
   LET l_ac = 1
   CALL ainp900_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainp900.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainp900_fetch()
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
 
{<section id="ainp900.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainp900_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   CALL s_desc_get_item_desc(g_detail_d[l_ac].b_inpd001) RETURNING g_detail_d[l_ac].b_inpd001_desc,g_detail_d[l_ac].b_inpd001_desc_desc
   CALL s_desc_get_stock_desc(g_detail_d[l_ac].b_inpdsite,g_detail_d[l_ac].b_inpd005)
        RETURNING g_detail_d[l_ac].b_inpd005_desc
   CALL s_desc_get_locator_desc(g_detail_d[l_ac].b_inpdsite,g_detail_d[l_ac].b_inpd005,g_detail_d[l_ac].b_inpd006)
        RETURNING g_detail_d[l_ac].b_inpd006_desc        
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainp900.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION ainp900_filter()
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
   
   CALL ainp900_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="ainp900.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION ainp900_filter_parser(ps_field)
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
 
{<section id="ainp900.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION ainp900_filter_show(ps_field,ps_object)
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
   LET ls_condition = ainp900_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ainp900.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 整批確認/取消确认
# Memo...........:
# Usage..........: CALL ainp900_batch_conf()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp900_batch_conf()
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_count    LIKE type_t.num5   #执行笔数
   DEFINE l_pd_user  LIKE inpd_t.inpd034   
   DEFINE l_cnt1     LIKE type_t.num5
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_speed    LIKE inpb_t.inpb003 
   DEFINE l_time     DATETIME YEAR TO SECOND  
   DEFINE l_inpdstus LIKE inpd_t.inpdstus  
   DEFINE l_flag     LIKE type_t.chr1   
   
   IF g_detail_cnt = 0 AND g_bgjob = 'N' THEN
      #请先选取资料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'abm-00098'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   IF l_conf = 'Y' AND g_bgjob = 'N' THEN
      IF NOT cl_ask_confirm('ain-00266') THEN
         RETURN
      END IF
   END IF
   IF l_conf = 'N' AND g_bgjob = 'N' THEN
      IF NOT cl_ask_confirm('ain-00267') THEN
         RETURN
      END IF      
   END IF
   #CALL s_transaction_begin()     #mark by lixh 20150906 
   LET g_detail_cnt = g_detail_d.getLength()
   LET l_count = 0
   LET l_time = cl_get_current()   
   LET r_success = TRUE
   LET l_flag = 'N'
   CALL cl_err_collect_init()
   FOR l_ac = 1 TO g_detail_cnt
      IF g_detail_d[l_ac].sel = 'N' THEN
         CONTINUE FOR
      END IF
      IF l_invent = 'Y' THEN   #現有庫存
         
         SELECT DISTINCT inpd008,inpd034,inpd040,inpd054,inpd060 INTO g_inpd008,g_inpd034,g_inpd040,g_inpd054,g_inpd060 FROM inpd_t
          WHERE inpdent = g_enterprise
            AND inpdsite = g_site
            AND inpddocno = g_detail_d[l_ac].b_inpddocno
            AND inpdseq = g_detail_d[l_ac].b_inpdseq
            
         SELECT DISTINCT inpa009,inpa010,inpa011,inpa012,inpd034,inpd040,inpd054,inpd060 INTO g_inpa009,g_inpa010,g_inpa011,g_inpa012,g_inpd034,g_inpd040,g_inpd054,g_inpd060 
           FROM inpa_t,inpd_t      
          WHERE inpaent = inpdent
            AND inpasite = inpdsite
            AND inpadocno = inpd008
            AND inpaent = g_enterprise
            AND inpadocno = g_inpd008
            AND inpddocno = g_detail_d[l_ac].b_inpddocno
            AND inpdseq = g_detail_d[l_ac].b_inpdseq
      END IF
      
      IF l_work = 'Y' THEN   #在製工單
         SELECT DISTINCT inpf004,inpg031,inpg034,inpg051,inpg054 INTO g_inpd008,g_inpg031,g_inpg034,g_inpg051,g_inpg054 FROM inpf_t,inpg_t
          WHERE inpfent = inpgent
            AND inpfsite = inpgsite
            AND inpfdocno = inpgdocno
            AND inpfseq = inpgseq
            AND inpfent = g_enterprise
            AND inpfsite = g_site
            AND inpfdocno = g_detail_d[l_ac].b_inpddocno
            AND inpfseq = g_detail_d[l_ac].b_inpdseq
            
         SELECT DISTINCT inpa013,inpa014,inpa015,inpa016 INTO g_inpa013,g_inpa014,g_inpa015,g_inpa016
           FROM inpa_t,inpf_t      
          WHERE inpaent = inpfent
            AND inpasite = inpfsite
            AND inpadocno = inpf004
            AND inpaent = g_enterprise
            AND inpadocno = g_inpd008
            AND inpfdocno = g_detail_d[l_ac].b_inpddocno
            AND inpfseq = g_detail_d[l_ac].b_inpdseq
      END IF
      
      #確認邏輯
      IF l_invent = 'Y' AND l_conf = 'Y' THEN   #現有庫存初盤(確認)
         IF NOT cl_null(g_type) THEN
            IF g_type = '1' AND g_inpa010 = 'Y' THEN           
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00251'
               LET g_errparam.extend = g_detail_d[l_ac].b_inpddocno
               LET g_errparam.popup = TRUE
               CALL cl_err()   
               CONTINUE FOR            
            END IF  
            #mark by lixh 20150325(S)
#            IF (g_type = '2' AND g_inpa010 = 'Y' AND cl_null(g_inpd040)) OR (g_type = '1' AND g_inpa010 = 'N' AND cl_null(g_inpd034)) THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'ain-00396'
#               LET g_errparam.extend = g_detail_d[l_ac].b_inpddocno
#               LET g_errparam.popup = TRUE
#               CALL cl_err()              
#            END IF
            #mark by lixh 20150325(E)
            #IF (g_type = '2' AND g_inpa010 = 'Y' AND NOT cl_null(g_inpd040)) OR (g_type = '1' AND g_inpa010 = 'N' AND NOT cl_null(g_inpd034)) THEN   #初盤確認
            IF (g_type = '2' AND g_inpa010 = 'Y' ) OR (g_type = '1' AND g_inpa010 = 'N' ) THEN  #add by lixh 20150325
               CALL s_transaction_begin()     #add by lixh 20150906
               UPDATE inpd_t SET inpdstus = '5', 
                                 inpdcnfid = g_user,
                                 inpdcnfdt = l_time
                WHERE inpdent = g_enterprise
                  AND inpdsite = g_site
                  AND inpddocno = g_detail_d[l_ac].b_inpddocno
                  AND inpdseq = g_detail_d[l_ac].b_inpdseq    
               IF SQLCA.sqlerrd[3] = 0 THEN
                  LET r_success = FALSE 
                  CALL s_transaction_end('N','0')  #add by lixh 20150906
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'std-00009'
                  LET g_errparam.extend = "upd inpd_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
               END IF
               
               #160517-00029#10 2016/06/22  By earl add s
               UPDATE bcah_t
                  SET bcahstus = '5'
                WHERE bcahent = g_enterprise
                  AND bcahsite = g_site
                  AND bcahdocno = g_detail_d[l_ac].b_inpddocno
                  AND bcahseq = g_detail_d[l_ac].b_inpdseq
                  
               IF SQLCA.sqlcode THEN
                  LET r_success = FALSE 
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "upd bcah_t"
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF   
               #160517-00029#10 2016/06/22  By earl add e
               
               SELECT COUNT(*) INTO l_cnt FROM inpa_t,inpb_t,inpd_t 
                WHERE inpaent = inpbent  
                  AND inpadocno = inpbdocno 
                  AND inpasite = inpbsite     
                  AND inpdent = inpaent
                  AND inpasite = inpdsite
                  AND inpd008 = inpadocno
                  AND inpaent = g_enterprise 
                  AND inpasite = g_site
                  AND inpastus = 'Y' 
                  AND inpdstus = '5'
                  AND inpa001 = '1'
                  AND (inpa009 = 'Y' OR inpa010 = 'Y')
                  AND inpb001 = '6' 
                  AND inpd008 = g_inpd008
            
            
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            
            
               SELECT COUNT(*) INTO l_cnt1 FROM inpd_t,inpa_t
                WHERE inpaent = inpdent 
                  AND inpasite = inpdsite
                  AND inpadocno = inpd008
                  AND inpdent = g_enterprise
                  AND inpdsite = g_site
                  AND inpd008 = g_inpd008
            
               IF cl_null(l_cnt1) THEN LET l_cnt1 = 0 END IF  
            
               LET l_speed = l_cnt/l_cnt1 * 100
            
               UPDATE inpb_t SET inpb002 = 'Y',
                                 inpb003 = l_speed   
                WHERE inpbent = g_enterprise
                  AND inpbsite = g_site
                  AND inpbdocno = g_inpd008
                  AND inpb001 = '6'
               #mark by lixh 20150325(S)
#               IF SQLCA.sqlerrd[3] = 0 THEN
#                  LET r_success = FALSE 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'std-00009'
#                  LET g_errparam.extend = "upd inpb_t"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#            
#               END IF
               #mark by lixh 20150325(S)
               IF l_cnt = l_cnt1 THEN
                  IF g_type = '1' THEN
                     LET l_pd_user = g_inpd034
                  END IF
                  IF g_type = '2' THEN
                     LET l_pd_user = g_inpd040
                  END IF     
                  IF cl_null(l_pd_user) THEN  #add by lixh 20150325
                     LET l_pd_user = g_user
                  END IF                  
                  UPDATE inpb_t SET inpb002 = 'Y',  
                                    inpb003 = 100,
                                    inpb006 = l_pd_user,
                                    inpb007 = g_today
                   WHERE inpbent = g_enterprise
                     AND inpbsite = g_site
                     AND inpbdocno = g_inpd008
                     AND inpb001 = '6'                        
               END IF         
               UPDATE inpd_t SET inpdstus = '5',   #add by lixh 20141017
                                 inpdcnfid = g_user,
                                 inpdcnfdt = l_time
                WHERE inpdent = g_enterprise
                  AND inpdsite = g_site
                  AND inpddocno = g_detail_d[l_ac].b_inpddocno
                  AND inpdseq = g_detail_d[l_ac].b_inpdseq    
               IF SQLCA.sqlerrd[3] = 0 THEN
                  LET r_success = FALSE 
                  CALL s_transaction_end('N','0')  #add by lixh 20150906
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'std-00009'
                  LET g_errparam.extend = "upd inpd_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
               END IF               
               CALL s_transaction_end('Y','0')  #add by lixh 20150906               
            END IF
            #IF g_type = '3' AND g_inpa012 = 'Y' THEN   #復盤二確認    #add by lixh 20150910
            IF g_type = '3' AND g_inpa012 = 'N' AND g_inpa011 = 'N'  THEN   #復盤二確認   #add by lixh 20150910
               LET r_success = FALSE 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00277'
               LET g_errparam.extend = g_detail_d[l_ac].b_inpddocno
               LET g_errparam.popup = TRUE
               CALL cl_err()         
            END IF 
            
#            IF (g_type = '3' AND g_inpa012 = 'N' AND cl_null(g_inpd054)) OR (g_type = '4' AND g_inpa012 = 'Y' AND cl_null(g_inpd060))  THEN  #mark by lixh 20150325           
#               LET r_success = FALSE 
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = "ain-00396"
#               LET g_errparam.extend = g_detail_d[l_ac].b_inpddocno
#               LET g_errparam.popup = TRUE
#               CALL cl_err()               
#            END IF
            #IF (g_type = '3' AND g_inpa012 = 'N' AND NOT cl_null(g_inpd054)) OR (g_type = '4' AND g_inpa012 = 'Y' AND NOT cl_null(g_inpd060))  THEN   #復盤二確認  #mark by lixh 20150325
            IF (g_type = '3' AND g_inpa012 = 'N') OR (g_type = '4' AND g_inpa012 = 'Y')  THEN   #復盤二確認  #add by lixh 20150325
               IF g_inpa011 = 'Y' OR g_inpa012 = 'Y' THEN
                  SELECT inpdstus INTO l_inpdstus FROM inpd_t
                   WHERE inpdent = g_enterprise
                     AND inpdsite = g_site
                     AND inpddocno = g_detail_d[l_ac].b_inpddocno
                     AND inpdseq = g_detail_d[l_ac].b_inpdseq
                  IF l_inpdstus <> '5' THEN
                     LET r_success = FALSE 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00329'
                     LET g_errparam.extend = g_detail_d[l_ac].b_inpddocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                     
                  END IF
               END IF
               CALL s_transaction_begin()     #add by lixh 20150906
               UPDATE inpd_t SET inpdstus = '6', 
                                 inpdcnfid = g_user,
                                 inpdcnfdt = l_time
                WHERE inpdent = g_enterprise
                  AND inpdsite = g_site
                  AND inpddocno = g_detail_d[l_ac].b_inpddocno
                  AND inpdseq = g_detail_d[l_ac].b_inpdseq    
               IF SQLCA.sqlerrd[3] = 0 THEN
                  LET r_success = FALSE
                  CALL s_transaction_end('N','0')  #add by lixh 20150906                  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'std-00009'
                  LET g_errparam.extend = "upd inpd_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
               END IF              
               
               #160517-00029#10 2016/06/22  By earl add s
               UPDATE bcah_t
                  SET bcahstus = '6'
                WHERE bcahent = g_enterprise
                  AND bcahsite = g_site
                  AND bcahdocno = g_detail_d[l_ac].b_inpddocno
                  AND bcahseq = g_detail_d[l_ac].b_inpdseq
                  
               IF SQLCA.sqlcode THEN
                  LET r_success = FALSE 
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "upd bcah_t"
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF   
               #160517-00029#10 2016/06/22  By earl add e
               
               SELECT COUNT(*) INTO l_cnt FROM inpa_t,inpb_t,inpd_t 
                WHERE inpaent = inpbent  
                  AND inpadocno = inpbdocno 
                  AND inpasite = inpbsite     
                  AND inpdent = inpaent
                  AND inpasite = inpdsite
                  AND inpd008 = inpadocno
                  AND inpaent = g_enterprise 
                  AND inpasite = g_site
                  AND inpastus = 'Y' 
                  AND inpdstus = '6'
                  AND inpa001 = '1'
                  AND (inpa011 = 'Y' OR inpa012 = 'Y')
                  AND inpb001 = '10' 
                  AND inpd008 = g_inpd008
            
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            
               SELECT COUNT(*) INTO l_cnt1 FROM inpd_t,inpa_t
                WHERE inpaent = inpdent 
                  AND inpasite = inpdsite
                  AND inpadocno = inpd008
                  AND inpdent = g_enterprise
                  AND inpdsite = g_site
                  AND inpd008 = g_inpd008
            
               IF cl_null(l_cnt1) THEN LET l_cnt1 = 0 END IF  
            
               LET l_speed = l_cnt/l_cnt1 * 100
            
               UPDATE inpb_t SET inpb002 = 'Y',
                                 inpb003 = l_speed   
                WHERE inpbent = g_enterprise
                  AND inpbsite = g_site
                  AND inpbdocno = g_inpd008
                  AND inpb001 = '10'
              #mark by lixh 20150325
#               IF SQLCA.sqlerrd[3] = 0 THEN
#                  LET r_success = FALSE 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'std-00009'
#                  LET g_errparam.extend = "upd inpb_t"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()           
#               END IF  
              #mark by lixh 20150325
               IF l_cnt = l_cnt1 THEN
                  IF g_type = '3' THEN
                     LET l_pd_user = g_inpd054
                  END IF
                  IF g_type = '4' THEN
                     LET l_pd_user = g_inpd060
                  END IF 
                  IF cl_null(l_pd_user) THEN  #add by lixh 20150325
                     LET l_pd_user = g_user
                  END IF
                  UPDATE inpb_t SET inpb002 = 'Y',  
                                    inpb003 = 100,
                                    inpb006 = l_pd_user,
                                    inpb007 = g_today
                   WHERE inpbent = g_enterprise
                     AND inpbsite = g_site
                     AND inpbdocno = g_inpd008
                     AND inpb001 = '10'                        
               END IF         
#               UPDATE inpd_t SET inpdstus = '6', 
#                                 inpdcnfid = g_user,
#                                 inpdcnfdt = l_time
#                WHERE inpdent = g_enterprise
#                  AND inpdsite = g_site
#                  AND inpddocno = g_detail_d[l_ac].b_inpddocno
#                  AND inpdseq = g_detail_d[l_ac].b_inpdseq    
#               IF SQLCA.sqlerrd[3] = 0 THEN
#                  LET r_success = FALSE 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "upd inpd_t"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err() 
#               END IF
               CALL s_transaction_end('Y','0')  #add by lixh 20150906
            END IF
         ELSE
            #單獨開啟畫面
            #mark by lixh 20150325(s)
#            IF ((g_inpa009 = 'Y' AND g_inpa010 = 'N' AND cl_null(g_inpd034)) OR
#               (g_inpa010 = 'Y' AND cl_null(g_inpd040))) AND l_check = '1' THEN  
#                  LET r_success = FALSE 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'ain-00396'
#                  LET g_errparam.extend = g_detail_d[l_ac].b_inpddocno
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err() 
#            END IF
            
#            IF ((g_inpa009 = 'Y' AND g_inpa010 = 'N' AND NOT cl_null(g_inpd034)) OR
#               (g_inpa010 = 'Y' AND NOT cl_null(g_inpd040))) AND l_check = '1' THEN                    #初盤确认
           #mark by lixh 20150325(e)
            IF ((g_inpa009 = 'Y' AND g_inpa010 = 'N') OR
               g_inpa010 = 'Y') AND l_check = '1' THEN                    #初盤确认    #add by lixh 20150325   
               CALL s_transaction_begin()    #add by lixh 20150906                
               UPDATE inpd_t SET inpdstus = '5', 
                                 inpdcnfid = g_user,
                                 inpdcnfdt = l_time
                WHERE inpdent = g_enterprise
                  AND inpdsite = g_site
                  AND inpddocno = g_detail_d[l_ac].b_inpddocno
                  AND inpdseq = g_detail_d[l_ac].b_inpdseq    
               IF SQLCA.sqlerrd[3] = 0 THEN
                  LET r_success = FALSE 
                  CALL s_transaction_end('N','0')  #add by lixh 20150906
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'std-00009'
                  LET g_errparam.extend = "upd inpd_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
               END IF                 
               
               #160517-00029#10 2016/06/22  By earl add s
               UPDATE bcah_t
                  SET bcahstus = '5'
                WHERE bcahent = g_enterprise
                  AND bcahsite = g_site
                  AND bcahdocno = g_detail_d[l_ac].b_inpddocno
                  AND bcahseq = g_detail_d[l_ac].b_inpdseq
                  
               IF SQLCA.sqlcode THEN
                  LET r_success = FALSE 
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "upd bcah_t"
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF   
               #160517-00029#10 2016/06/22  By earl add e
               
               SELECT COUNT(*) INTO l_cnt FROM inpa_t,inpb_t,inpd_t 
                WHERE inpaent = inpbent  
                  AND inpadocno = inpbdocno 
                  AND inpasite = inpbsite     
                  AND inpdent = inpaent
                  AND inpasite = inpdsite
                  AND inpd008 = inpadocno
                  AND inpaent = g_enterprise 
                  AND inpasite = g_site
                  AND inpastus = 'Y' 
                  AND inpdstus = '5'
                  AND inpa001 = '1'
                  AND (inpa009 = 'Y' OR inpa010 = 'Y')
                  AND inpb001 = '6' 
                  AND inpd008 = g_inpd008
            
            
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            
            
               SELECT COUNT(*) INTO l_cnt1 FROM inpd_t,inpa_t
                WHERE inpaent = inpdent 
                  AND inpasite = inpdsite
                  AND inpadocno = inpd008
                  AND inpdent = g_enterprise
                  AND inpdsite = g_site
                  AND inpd008 = g_inpd008
            
               IF cl_null(l_cnt1) THEN LET l_cnt1 = 0 END IF  
            
               LET l_speed = l_cnt/l_cnt1 * 100
            
               UPDATE inpb_t SET inpb002 = 'Y',
                                 inpb003 = l_speed   
                WHERE inpbent = g_enterprise
                  AND inpbsite = g_site
                  AND inpbdocno = g_inpd008
                  AND inpb001 = '6'
              #mark by lixh 20150325
#               IF SQLCA.sqlerrd[3] = 0 THEN
#                  LET r_success = FALSE 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'std-00009'
#                  LET g_errparam.extend = "upd inpb_t"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#            
#               END IF 
              #mark by lixh 20150325
               IF l_cnt = l_cnt1 THEN
                  IF g_inpa009 = 'Y' AND g_inpa010 = 'N' THEN
                     LET l_pd_user = g_inpd034
                  END IF
                  IF g_inpa010 = 'Y' THEN
                     LET l_pd_user = g_inpd040
                  END IF
                  #add by lixh 20150325
                  IF cl_null(l_pd_user) THEN
                     LET l_pd_user = g_user
                  END IF 
                  #add by lixh 20150325                  
                                                                       
                  UPDATE inpb_t SET inpb002 = 'Y',  
                                    inpb003 = 100,
                                    inpb006 = l_pd_user,
                                    inpb007 = g_today
                   WHERE inpbent = g_enterprise
                     AND inpbsite = g_site
                     AND inpbdocno = g_inpd008
                     AND inpb001 = '6'                        
               END IF         
#               UPDATE inpd_t SET inpdstus = '5', 
#                                 inpdcnfid = g_user,
#                                 inpdcnfdt = l_time
#                WHERE inpdent = g_enterprise
#                  AND inpdsite = g_site
#                  AND inpddocno = g_detail_d[l_ac].b_inpddocno
#                  AND inpdseq = g_detail_d[l_ac].b_inpdseq    
#               IF SQLCA.sqlerrd[3] = 0 THEN
#                  LET r_success = FALSE 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "upd inpd_t"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err() 
#               END IF 
               CALL s_transaction_end('Y','0')  #add by lixh 20150906
            END IF     
            #mark by lixh 20150325
#            IF ((g_inpa011 = 'Y' AND g_inpa012 = 'N' AND cl_null(g_inpd054)) OR 
#               (g_inpa012 = 'Y' AND cl_null(g_inpd060))) AND l_check = '2' THEN  #復盤确认
#               LET r_success = FALSE 
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'ain-00396'
#               LET g_errparam.extend = g_detail_d[l_ac].b_inpddocno
#               LET g_errparam.popup = TRUE
#               CALL cl_err()   
#            END IF

#            IF ((g_inpa011 = 'Y' AND g_inpa012 = 'N' AND NOT cl_null(g_inpd054)) OR 
#               (g_inpa012 = 'Y' AND NOT cl_null(g_inpd060))) AND l_check = '2' THEN  #復盤确认
            #mark by lixh 20150325  
            IF ((g_inpa011 = 'Y' AND g_inpa012 = 'N' ) OR g_inpa012 = 'Y' ) AND l_check = '2' THEN  #復盤确认  #add by lixh 20150325
                           
               IF g_inpa011 = 'Y' OR g_inpa012 = 'Y' THEN
                  LET l_inpdstus = ''
                  SELECT inpdstus INTO l_inpdstus FROM inpd_t
                   WHERE inpdent = g_enterprise
                     AND inpdsite = g_site
                     AND inpddocno = g_detail_d[l_ac].b_inpddocno
                     AND inpdseq = g_detail_d[l_ac].b_inpdseq
                  IF l_inpdstus <> '5' THEN
                     LET r_success = FALSE 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ain-00329"
                     LET g_errparam.extend = g_detail_d[l_ac].b_inpddocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                     
                  END IF
               END IF
               CALL s_transaction_begin()    #add by lixh 20150906
               UPDATE inpd_t SET inpdstus = '6', 
                                 inpdcnfid = g_user,
                                 inpdcnfdt = l_time
                WHERE inpdent = g_enterprise
                  AND inpdsite = g_site
                  AND inpddocno = g_detail_d[l_ac].b_inpddocno
                  AND inpdseq = g_detail_d[l_ac].b_inpdseq    
               IF SQLCA.sqlerrd[3] = 0 THEN
                  LET r_success = FALSE 
                  CALL s_transaction_end('N','0')  #add by lixh 20150906
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'std-00009'
                  LET g_errparam.extend = "upd inpd_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
               END IF               
               
               #160517-00029#10 2016/06/22  By earl add s
               UPDATE bcah_t
                  SET bcahstus = '6'
                WHERE bcahent = g_enterprise
                  AND bcahsite = g_site
                  AND bcahdocno = g_detail_d[l_ac].b_inpddocno
                  AND bcahseq = g_detail_d[l_ac].b_inpdseq
                  
               IF SQLCA.sqlcode THEN
                  LET r_success = FALSE 
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "upd bcah_t"
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF   
               #160517-00029#10 2016/06/22  By earl add e
               
               SELECT COUNT(*) INTO l_cnt FROM inpa_t,inpb_t,inpd_t 
                WHERE inpaent = inpbent  
                  AND inpadocno = inpbdocno 
                  AND inpasite = inpbsite     
                  AND inpdent = inpaent
                  AND inpasite = inpdsite
                  AND inpd008 = inpadocno
                  AND inpaent = g_enterprise 
                  AND inpasite = g_site
                  AND inpastus = 'Y' 
                  AND inpdstus = '6'
                  AND inpa001 = '1'
                  AND (inpa011 = 'Y' OR inpa012 = 'Y')
                  AND inpb001 = '10' 
                  AND inpd008 = g_inpd008
            
            
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            
            
               SELECT COUNT(*) INTO l_cnt1 FROM inpd_t,inpa_t
                WHERE inpaent = inpdent 
                  AND inpasite = inpdsite
                  AND inpadocno = inpd008
                  AND inpdent = g_enterprise
                  AND inpdsite = g_site
                  AND inpd008 = g_inpd008
            
               IF cl_null(l_cnt1) THEN LET l_cnt1 = 0 END IF  
            
               LET l_speed = l_cnt/l_cnt1 * 100
            
               UPDATE inpb_t SET inpb002 = 'Y',
                                 inpb003 = l_speed   
                WHERE inpbent = g_enterprise
                  AND inpbsite = g_site
                  AND inpbdocno = g_inpd008
                  AND inpb001 = '10'
               #mark by lixh 20150325
#               IF SQLCA.sqlerrd[3] = 0 THEN
#                  LET r_success = FALSE 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'std-00009'
#                  LET g_errparam.extend = "upd inpb_t"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#            
#               END IF  
               #mark by lixh 20150325
               IF l_cnt = l_cnt1 THEN
                  IF g_inpa011 = 'Y' AND g_inpa012 = 'N' THEN
                     LET l_pd_user = g_inpd054
                  END IF
                  IF g_inpa012 = 'Y'  THEN
                     LET l_pd_user = g_inpd060
                  END IF 
                  IF cl_null(l_pd_user) THEN  #add by lixh 20150325
                     LET l_pd_user = g_user
                  END IF                  
                  UPDATE inpb_t SET inpb002 = 'Y',  
                                    inpb003 = 100,
                                    inpb006 = l_pd_user,
                                    inpb007 = g_today
                   WHERE inpbent = g_enterprise
                     AND inpbsite = g_site
                     AND inpbdocno = g_inpd008
                     AND inpb001 = '10'                        
               END IF         
#               UPDATE inpd_t SET inpdstus = '6', 
#                                 inpdcnfid = g_user,
#                                 inpdcnfdt = l_time
#                WHERE inpdent = g_enterprise
#                  AND inpdsite = g_site
#                  AND inpddocno = g_detail_d[l_ac].b_inpddocno
#                  AND inpdseq = g_detail_d[l_ac].b_inpdseq    
#               IF SQLCA.sqlerrd[3] = 0 THEN
#                  LET r_success = FALSE 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "upd inpd_t"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err() 
#               END IF 
               CALL s_transaction_end('Y','0')  #add by lixh 20150906
            END IF
                    
         END IF 
         IF r_success THEN
            LET l_flag = 'Y'
         END IF         
      END IF  #現有庫存初盤確認
      
      IF l_work = 'Y' AND l_conf = 'Y'  THEN   #在製工單盤點
         IF l_check = '1' AND ((g_inpa013 = 'Y' AND g_inpa014 = 'N') OR (g_inpa014 = 'Y'))  THEN
            CALL ainp900_inpf_conf_upd() RETURNING r_success    #在制工单初盤确认
            IF r_success THEN
               LET l_flag = 'Y'
            END IF              
         END IF    

         IF l_check = '2' AND ((g_inpa015 = 'Y' AND g_inpa016 = 'N') OR (g_inpa016 = 'Y'))  THEN
            CALL ainp900_inpf_conf_upd_01() RETURNING r_success    #在制工单復盤确认
            IF r_success THEN
               LET l_flag = 'Y'
            END IF                 
         END IF
         
      END IF     
      
      #取消邏輯       
      IF l_invent = 'Y' AND l_conf = 'N' THEN   #現有庫存初盤(取消確認)
         #初盤
#         IF g_type = '1' OR g_type = '2' THEN
#            CALL ainp900_unconf_upd() RETURNING r_success
#            IF r_success THEN
#               LET l_flag = 'Y'
#            END IF                 
#         END IF
         IF l_check = '1' AND ((g_inpa009 = 'Y' AND g_inpa010 = 'N') OR (g_inpa010 = 'Y'))  THEN
            CALL ainp900_unconf_upd() RETURNING r_success
            IF r_success THEN
               LET l_flag = 'Y'
            END IF                 
         END IF  
         #復盤         
#         IF g_type = '3' OR g_type = '4' THEN
#            CALL ainp900_unconf_upd_01() RETURNING r_success
#            IF r_success THEN
#               LET l_flag = 'Y'
#            END IF                 
#         END IF
         IF l_check = '2' AND ((g_inpa011 = 'Y' AND g_inpa012 = 'N') OR (g_inpa012 = 'Y'))  THEN
            CALL ainp900_unconf_upd_01() RETURNING r_success
            IF r_success THEN
               LET l_flag = 'Y'
            END IF                 
         END IF               
      END IF
      #在制工单取消确认
      IF l_work = 'Y' AND l_conf = 'N' THEN   #在制工单(取消確認)
         IF l_check = '1' AND ((g_inpa013 = 'Y' AND g_inpa014 = 'N') OR (g_inpa014 = 'Y'))  THEN   #在制工单初盤(取消確認)
            CALL ainp900_inpf_unconf_upd() RETURNING r_success
             IF r_success THEN
               LET l_flag = 'Y'
            END IF                
         END IF
      
         IF l_check = '2' AND ((g_inpa015 = 'Y' AND g_inpa016 = 'N') OR (g_inpa016 = 'Y'))  THEN   #在制工单初盤(取消確認)
            CALL ainp900_inpf_unconf_upd_01() RETURNING r_success    #在制工单復盤取消确认
            IF r_success THEN
               LET l_flag = 'Y'
            END IF                 
         END IF             
      END IF
      
      IF r_success AND l_flag = 'Y' THEN
         LET l_count = l_count + 1
      END IF          
      
   END FOR
   CALL cl_err_collect_show()
#  CALL s_transaction_end('Y','0')
   #执行成功
   #CALL cl_err('','adz-00217',1)
   #资料拋转成功！（拋转笔数：%1笔）
   IF l_count > 0 THEN
      CALL s_transaction_end('Y','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00394'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_count
      CALL cl_err()
   ELSE
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00395'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
#      LET g_errparam.replace[1] = l_count
      CALL cl_err()        
   END IF   
   CALL ainp900_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 初盤取消确认
# Memo...........:
# Usage..........: CALL ainp900_unconf_upd()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp900_unconf_upd()
DEFINE r_success   LIKE type_t.num5
DEFINE l_speed     LIKE inpb_t.inpb003
DEFINE l_inpb002   LIKE inpb_t.inpb002
DEFINE l_pd_user   LIKE inpd_t.inpd034
DEFINE l_cnt1      LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_stus      LIKE type_t.chr1

   
   LET r_success = TRUE
   SELECT COUNT(*) INTO l_cnt FROM inpa_t,inpb_t,inpd_t 
    WHERE inpaent = inpbent  
      AND inpadocno = inpbdocno 
      AND inpasite = inpbsite     
      AND inpdent = inpaent
      AND inpasite = inpdsite
      AND inpd008 = inpadocno
      AND inpaent = g_enterprise 
      AND inpasite = g_site
      AND inpastus = 'Y' 
      AND inpdstus = '5'
      AND inpa001 = '1'
      AND (inpa009 = 'Y' OR inpa010 = 'Y')
      AND inpb001 = '6' 
      AND inpd008 = g_inpd008
      
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
    
   SELECT COUNT(*) INTO l_cnt1 FROM inpd_t,inpa_t
    WHERE inpaent = inpdent 
      AND inpasite = inpdsite
      AND inpadocno = inpd008
      AND inpdent = g_enterprise
      AND inpdsite = g_site
      AND inpd008 = g_inpd008
   
   IF cl_null(l_cnt1) THEN LET l_cnt1 = 0 END IF  
   
   LET l_speed = l_cnt/l_cnt1 * 100
   
   IF l_speed = 0 THEN
      LET l_inpb002 = 'N'
   ELSE
      LET l_inpb002 = 'Y'
   END IF
   
   CALL s_transaction_begin()    #add by lixh 20150906  
   UPDATE inpb_t SET inpb002 = l_inpb002,
                     inpb003 = l_speed   
    WHERE inpbent = g_enterprise
      AND inpbsite = g_site
      AND inpbdocno = g_inpd008
      AND inpb001 = '6'
   
#   IF SQLCA.sqlerrd[3] = 0 THEN
#      LET r_success = FALSE 
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'std-00009'
#      LET g_errparam.extend = "upd inpb_t"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      
#   END IF  
   IF l_cnt = l_cnt1 THEN
      IF g_inpa009 = 'Y' AND g_inpa010 = 'N' THEN
         LET l_pd_user = g_inpd034
      END IF
      IF g_inpa010 = 'Y' THEN
         LET l_pd_user = g_inpd040
      END IF    
      IF cl_null(l_pd_user) THEN   #add by lixh 20150325
         LET l_pd_user = g_user
      END IF      
      UPDATE inpb_t SET inpb002 = 'Y',  
                        inpb003 = 100,
                        inpb006 = l_pd_user,
                        inpb007 = g_today
       WHERE inpbent = g_enterprise
         AND inpbsite = g_site
         AND inpbdocno = g_inpd008
         AND inpb001 = '6'                        
   END IF  
   
   SELECT inpdstus INTO l_stus FROM inpd_t
    WHERE inpdent = g_enterprise
      AND inpdsite = g_site
      AND inpddocno = g_detail_d[l_ac].b_inpddocno
      AND inpdseq = g_detail_d[l_ac].b_inpdseq
      
#   IF l_check = '1' THEN   #初盤 
      IF l_stus <> '5' THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00330'
         LET g_errparam.extend = g_detail_d[l_ac].b_inpddocno
         LET g_errparam.popup = TRUE
         CALL cl_err()       
      END IF
#   END IF
   UPDATE inpd_t SET inpdstus = 'N', 
                     inpdcnfid = '',
                     inpdcnfdt = ''
    WHERE inpdent = g_enterprise
      AND inpdsite = g_site
      AND inpddocno = g_detail_d[l_ac].b_inpddocno
      AND inpdseq = g_detail_d[l_ac].b_inpdseq    
   IF SQLCA.sqlerrd[3] = 0 THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'std-00009'
      LET g_errparam.extend = "upd inpd_t"
      LET g_errparam.popup = TRUE
      CALL cl_err() 
   END IF
   
   #160517-00029#10 2016/06/22  By earl add s
   UPDATE bcah_t
      SET bcahstus = 'N'
    WHERE bcahent = g_enterprise
      AND bcahsite = g_site
      AND bcahdocno = g_detail_d[l_ac].b_inpddocno
      AND bcahseq = g_detail_d[l_ac].b_inpdseq
      
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "upd bcah_t"
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   
   #160517-00029#10 2016/06/22  By earl add e
   
   #add by lixh 20150906
   IF r_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0') 
   END IF
   #add by lixh 20150906   
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 復盤取消確認
# Memo...........:
# Usage..........: CALL ainp900_unconf_upd_01()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp900_unconf_upd_01()
DEFINE l_pd_user   LIKE inpd_t.inpd034
DEFINE l_cnt1      LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
DEFINE l_speed     LIKE inpb_t.inpb003
DEFINE l_inpb002   LIKE inpb_t.inpb002
DEFINE l_stus      LIKE inpd_t.inpdstus

   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_cnt FROM inpa_t,inpb_t,inpd_t 
    WHERE inpaent = inpbent  
      AND inpadocno = inpbdocno 
      AND inpasite = inpbsite     
      AND inpdent = inpaent
      AND inpasite = inpdsite
      AND inpd008 = inpadocno
      AND inpaent = g_enterprise 
      AND inpasite = g_site
      AND inpastus = 'Y' 
      AND inpdstus = '6'
      AND inpa001 = '1'
      AND (inpa011 = 'Y' OR inpa012 = 'Y')
      AND inpb001 = '10' 
      AND inpd008 = g_inpd008
      
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
    
   SELECT COUNT(*) INTO l_cnt1 FROM inpd_t,inpa_t
    WHERE inpaent = inpdent 
      AND inpasite = inpdsite
      AND inpadocno = inpd008
      AND inpdent = g_enterprise
      AND inpdsite = g_site
      AND inpd008 = g_inpd008
   
   IF cl_null(l_cnt1) THEN LET l_cnt1 = 0 END IF  
   
   LET l_speed = l_cnt/l_cnt1 * 100
   
   IF l_speed = 0 THEN
      LET l_inpb002 = 'N'
   ELSE
      LET l_inpb002 = 'Y'
   END IF
   
   CALL s_transaction_begin()    #add by lixh 20150906
   UPDATE inpb_t SET inpb002 = l_inpb002,
                     inpb003 = l_speed   
    WHERE inpbent = g_enterprise
      AND inpbsite = g_site
      AND inpbdocno = g_inpd008
      AND inpb001 = '10'
   
#   IF SQLCA.sqlerrd[3] = 0 THEN
#      LET r_success = FALSE 
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'std-00009'
#      LET g_errparam.extend = "upd inpb_t"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#   
#   END IF  
   IF l_cnt = l_cnt1 THEN
      IF g_inpa011 = 'Y' AND g_inpa012 = 'N' THEN
         LET l_pd_user = g_inpd054
      END IF
      IF g_inpa012 = 'Y' THEN
         LET l_pd_user = g_inpd060
      END IF  
      IF cl_null(l_pd_user) THEN   #add by lixh 20150325
         LET l_pd_user = g_user
      END IF      
      UPDATE inpb_t SET inpb002 = 'Y',  
                        inpb003 = 100,
                        inpb006 = l_pd_user,
                        inpb007 = g_today
       WHERE inpbent = g_enterprise
         AND inpbsite = g_site
         AND inpbdocno = g_inpd008
         AND inpb001 = '10'                        
   END IF   
#   IF NOT cl_null(g_inpa009) OR NOT cl_null(g_inpa010)  THEN
   IF g_inpa011 = 'Y' OR g_inpa012 = 'Y' THEN
      LET l_stus = '5'
   ELSE
      LET l_stus = 'N'
   END IF      
   UPDATE inpd_t SET inpdstus = l_stus, 
                     inpdcnfid = '',
                     inpdcnfdt = ''
    WHERE inpdent = g_enterprise
      AND inpdsite = g_site
      AND inpddocno = g_detail_d[l_ac].b_inpddocno
      AND inpdseq = g_detail_d[l_ac].b_inpdseq    
   IF SQLCA.sqlerrd[3] = 0 THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'std-00009'
      LET g_errparam.extend = "upd inpd_t"
      LET g_errparam.popup = TRUE
      CALL cl_err() 
   END IF   
   
   #160517-00029#10 2016/06/22  By earl add s
   UPDATE bcah_t
      SET bcahstus = l_stus
    WHERE bcahent = g_enterprise
      AND bcahsite = g_site
      AND bcahdocno = g_detail_d[l_ac].b_inpddocno
      AND bcahseq = g_detail_d[l_ac].b_inpdseq
      
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "upd bcah_t"
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   
   #160517-00029#10 2016/06/22  By earl add e
   
   #add by lixh 20150906
   IF r_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0') 
   END IF
   #add by lixh 20150906    
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 在製工單初盤確認
# Memo...........:
# Usage..........: CALL ainp900_inpf_conf_upd()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp900_inpf_conf_upd()
DEFINE l_inpfstus      LIKE inpf_t.inpfstus 
DEFINE l_inpg031       LIKE inpg_t.inpg031
DEFINE l_inpg034       LIKE inpg_t.inpg034
DEFINE l_inpg051       LIKE inpg_t.inpg051
DEFINE l_inpg054       LIKE inpg_t.inpg054
DEFINE l_pd_user       LIKE inpd_t.inpd034   
DEFINE l_cnt1          LIKE type_t.num5
DEFINE l_cnt           LIKE type_t.num5
DEFINE r_success       LIKE type_t.num5
DEFINE l_speed         LIKE inpb_t.inpb003 
DEFINE l_time          DATETIME YEAR TO SECOND   
DEFINE l_sql           STRING
   
   LET l_time = cl_get_current()  
   SELECT inpfstus INTO l_inpfstus FROM inpf_t
    WHERE inpfent = g_enterprise
      AND inpfsite = g_site
      AND inpfdocno = g_detail_d[l_ac].b_inpddocno
      AND inpfseq = g_detail_d[l_ac].b_inpdseq
      
   LET  l_sql = " SELECT DISTINCT inpg031,inpg034,inpg051,inpg054 FROM inpg_t " ,
                "  WHERE inpgent = '",g_enterprise,"'",
                "    AND inpgsite = '",g_site,"'",
                "    AND inpgdocno = '",g_detail_d[l_ac].b_inpddocno,"'",
                "    AND inpgseq = '",g_detail_d[l_ac].b_inpdseq,"'"
   PREPARE ainp900_inpg_pb FROM l_sql
   DECLARE b_inpg_fill_cs CURSOR FOR ainp900_inpg_pb               
   IF l_inpfstus <> 'N' THEN
      RETURN FALSE
   END IF
   LET r_success = TRUE
#   IF g_inpa013 = 'Y' AND g_inpa014 = 'N' THEN   #初盤一确认
#      FOREACH b_inpg_fill_cs INTO l_inpg031,l_inpg034,l_inpg051,l_inpg054
#         IF cl_null(l_inpg031) THEN
#            LET r_success = FALSE
#            EXIT FOREACH
#         END IF
#      END FOREACH
#      IF NOT r_success THEN
#         RETURN FALSE
#      END IF
#   END IF 
   
#   IF g_inpa010 = 'Y'  THEN   #初盤二确认
#      FOREACH b_inpg_fill_cs INTO l_inpg031,l_inpg034,l_inpg051,l_inpg054
#         IF cl_null(l_inpg034) THEN
#            LET r_success = FALSE
#            EXIT FOREACH
#         END IF
#      END FOREACH
#      IF NOT r_success THEN
#         RETURN FALSE
#      END IF   
#   END IF  
      CALL s_transaction_begin()    
      UPDATE inpf_t SET inpfstus = '5', 
                        inpfcnfid = g_user,
                        inpfcnfdt = l_time
       WHERE inpfent = g_enterprise
         AND inpfsite = g_site
         AND inpfdocno = g_detail_d[l_ac].b_inpddocno
         AND inpfseq = g_detail_d[l_ac].b_inpdseq    
      IF SQLCA.sqlerrd[3] = 0 THEN
         LET r_success = FALSE 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'std-00009'
         LET g_errparam.extend = "upd inpf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         CALL s_transaction_end('N','0')
         RETURN r_success
      END IF                 
      SELECT COUNT(*) INTO l_cnt FROM inpa_t,inpb_t,inpf_t 
       WHERE inpaent = inpbent  
         AND inpadocno = inpbdocno 
         AND inpasite = inpbsite     
         AND inpfent = inpaent
         AND inpasite = inpfsite
         AND inpf004 = inpadocno
         AND inpaent = g_enterprise 
         AND inpasite = g_site
         AND inpastus = 'Y' 
         AND inpfstus = '5'
         AND inpa001 = '1'
         AND (inpa009 = 'Y' OR inpa010 = 'Y')
         AND inpb001 = '7' 
         AND inpf004 = g_inpd008
   
   
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   
      SELECT COUNT(*) INTO l_cnt1 FROM inpf_t,inpa_t
       WHERE inpaent = inpfent 
         AND inpasite = inpfsite
         AND inpadocno = inpf004
         AND inpfent = g_enterprise
         AND inpfsite = g_site
         AND inpf004 = g_inpd008   #add by lixh 20150906
   
      IF cl_null(l_cnt1) THEN LET l_cnt1 = 0 END IF  
   
      LET l_speed = l_cnt/l_cnt1 * 100
   
      UPDATE inpb_t SET inpb002 = 'Y',
                        inpb003 = l_speed   
       WHERE inpbent = g_enterprise
         AND inpbsite = g_site
         AND inpbdocno = g_inpd008
         AND inpb001 = '7'
   
#      IF SQLCA.sqlerrd[3] = 0 THEN
#         LET r_success = FALSE 
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'std-00009'
#         LET g_errparam.extend = "upd inpb_t"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         CALL s_transaction_end('N','0')
#         RETURN r_success 
#      END IF  
      IF l_cnt = l_cnt1 THEN
         IF g_type = '5' THEN
            LET l_pd_user = g_user
         END IF
         IF g_type = '6' THEN
            LET l_pd_user = g_user
         END IF   
         IF cl_null(g_type) THEN    #add by 1030
            LET l_pd_user = g_user 
         END IF         
         UPDATE inpb_t SET inpb002 = 'Y',  
                           inpb003 = 100,
                           inpb006 = l_pd_user,
                           inpb007 = g_today
          WHERE inpbent = g_enterprise
            AND inpbsite = g_site
            AND inpbdocno = g_inpd008
            AND inpb001 = '7' 
            
#         IF SQLCA.sqlerrd[3] = 0 THEN
#            LET r_success = FALSE 
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'std-00009'
#            LET g_errparam.extend = "upd inpb_t"
#            LET g_errparam.popup = TRUE
#            CALL cl_err() 
#            CALL s_transaction_end('N','0')
#            RETURN r_success       
#         END IF 
      
      END IF         
      UPDATE inpf_t SET inpfstus = '5',   #add by lixh 1017
                        inpfcnfid = g_user,
                        inpfcnfdt = l_time
       WHERE inpfent = g_enterprise
         AND inpfsite = g_site
         AND inpfdocno = g_detail_d[l_ac].b_inpddocno
         AND inpfseq = g_detail_d[l_ac].b_inpdseq    
      IF SQLCA.sqlerrd[3] = 0 THEN
         LET r_success = FALSE 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'std-00009'
         LET g_errparam.extend = "upd inpf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         CALL s_transaction_end('N','0') 
         RETURN r_success        
      END IF                
#   END IF   
    CALL s_transaction_end('Y','0')
    RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 初盤取消确认
# Memo...........:
# Usage..........: CALL ainp900_inpf_unconf_upd()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp900_inpf_unconf_upd()
DEFINE l_inpfstus  LIKE inpf_t.inpfstus 
DEFINE r_success   LIKE type_t.num5
DEFINE l_speed     LIKE inpb_t.inpb003
DEFINE l_inpb002   LIKE inpb_t.inpb002
DEFINE l_pd_user   LIKE inpd_t.inpd034
DEFINE l_cnt1      LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5

   LET r_success = TRUE
   SELECT inpfstus INTO l_inpfstus FROM inpf_t
    WHERE inpfent = g_enterprise
      AND inpfsite = g_site
      AND inpfdocno = g_detail_d[l_ac].b_inpddocno
      AND inpfseq = g_detail_d[l_ac].b_inpdseq
   IF l_inpfstus <> '5' THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00330'
      LET g_errparam.extend = g_detail_d[l_ac].b_inpddocno
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      RETURN r_success
   END IF   
   SELECT COUNT(*) INTO l_cnt FROM inpa_t,inpb_t,inpf_t 
    WHERE inpaent = inpbent  
      AND inpadocno = inpbdocno 
      AND inpasite = inpbsite     
      AND inpfent = inpaent
      AND inpasite = inpfsite
      AND inpf004 = inpadocno
      AND inpaent = g_enterprise 
      AND inpasite = g_site
      AND inpastus = 'Y' 
      AND inpdstus = '5'
      AND inpa001 = '1'
      AND (inpa009 = 'Y' OR inpa010 = 'Y')
      AND inpb001 = '7' 
      AND inpadocno = g_inpd008     #add by lixh 20150906 
      
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
    
   SELECT COUNT(*) INTO l_cnt1 FROM inpf_t,inpa_t
    WHERE inpaent = inpfent 
      AND inpasite = inpfsite
      AND inpadocno = inpf004
      AND inpfent = g_enterprise
      AND inpfsite = g_site
      AND inpf004 = g_inpd008
   
   IF cl_null(l_cnt1) THEN LET l_cnt1 = 0 END IF  
   
   LET l_speed = l_cnt/l_cnt1 * 100
   
   IF l_speed = 0 THEN
      LET l_inpb002 = 'N'
   ELSE
      LET l_inpb002 = 'Y'
   END IF
   CALL s_transaction_begin()
   UPDATE inpb_t SET inpb002 = l_inpb002,
                     inpb003 = l_speed   
    WHERE inpbent = g_enterprise
      AND inpbsite = g_site
      AND inpbdocno = g_inpd008
      AND inpb001 = '7'
   
#   IF SQLCA.sqlerrd[3] = 0 THEN
#      LET r_success = FALSE 
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'std-00009'
#      LET g_errparam.extend = "upd inpb_t"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      CALL s_transaction_end('N','0')
#      RETURN r_success
#   END IF  
   IF l_cnt = l_cnt1 THEN
      IF g_inpa013 = 'Y' AND g_inpa014 = 'N' THEN
         LET l_pd_user = g_user
      END IF
      IF g_inpa010 = 'Y' THEN
         LET l_pd_user = g_user
      END IF               
      UPDATE inpb_t SET inpb002 = 'Y',  
                        inpb003 = 100,
                        inpb006 = l_pd_user,
                        inpb007 = g_today
       WHERE inpbent = g_enterprise
         AND inpbsite = g_site
         AND inpbdocno = g_inpd008
         AND inpb001 = '7'    
#      IF SQLCA.sqlerrd[3] = 0 THEN
#         LET r_success = FALSE 
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'std-00009'
#         LET g_errparam.extend = "upd inpb_t"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         CALL s_transaction_end('N','0')
#         RETURN r_success
#      END IF           
   END IF  
   
   UPDATE inpf_t SET inpfstus = 'N', 
                     inpfcnfid = '',
                     inpfcnfdt = ''
    WHERE inpfent = g_enterprise
      AND inpfsite = g_site
      AND inpfdocno = g_detail_d[l_ac].b_inpddocno
      AND inpfseq = g_detail_d[l_ac].b_inpdseq 
      
   IF SQLCA.sqlerrd[3] = 0 THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'std-00009'
      LET g_errparam.extend = "upd inpf_t"
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      CALL s_transaction_end('N','0')
      RETURN r_success     
   END IF   
   CALL s_transaction_end('Y','0')
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 在制工單復盤確認
# Memo...........:
# Usage..........: CALL ainp900_inpf_conf_upd_01()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp900_inpf_conf_upd_01()
DEFINE l_inpfstus      LIKE inpf_t.inpfstus 
DEFINE l_inpg031       LIKE inpg_t.inpg031
DEFINE l_inpg034       LIKE inpg_t.inpg034
DEFINE l_inpg051       LIKE inpg_t.inpg051
DEFINE l_inpg054       LIKE inpg_t.inpg054
DEFINE l_pd_user       LIKE inpd_t.inpd034   
DEFINE l_cnt1          LIKE type_t.num5
DEFINE l_cnt           LIKE type_t.num5
DEFINE r_success       LIKE type_t.num5
DEFINE l_speed         LIKE inpb_t.inpb003 
DEFINE l_time          DATETIME YEAR TO SECOND   
DEFINE l_sql           STRING

   LET l_time = cl_get_current()  
   SELECT inpfstus INTO l_inpfstus FROM inpf_t
    WHERE inpfent = g_enterprise
      AND inpfsite = g_site
      AND inpfdocno = g_detail_d[l_ac].b_inpddocno
      AND inpfseq = g_detail_d[l_ac].b_inpdseq
      
   LET  l_sql = " SELECT DISTINCT inpg031,inpg034,inpg051,inpg054 FROM inpg_t " ,
                "  WHERE inpgent = '",g_enterprise,"'",
                "    AND inpgsite = '",g_site,"'",
                "    AND inpgdocno = '",g_detail_d[l_ac].b_inpddocno,"'",
                "    AND inpgseq = '",g_detail_d[l_ac].b_inpdseq,"'"
   PREPARE ainp900_inpg_pb_01 FROM l_sql
   DECLARE b_inpg_fill_cs_01 CURSOR FOR ainp900_inpg_pb_01               

   IF l_inpfstus = '6' OR l_inpfstus = 'S' THEN
      RETURN FALSE
   END IF
   LET r_success = TRUE
   IF g_inpa015 = 'Y' AND g_inpa016 = 'N' THEN   #復盤一确认
#      FOREACH b_inpg_fill_cs_01 INTO l_inpg031,l_inpg034,l_inpg051,l_inpg054
#         IF cl_null(l_inpg051) THEN
#            LET r_success = FALSE
#            EXIT FOREACH
#         END IF
#      END FOREACH
#      IF NOT r_success THEN
#         RETURN r_success
#      END IF
   END IF 
   
   IF g_inpa016 = 'Y'  THEN   #復盤二确认
#      FOREACH b_inpg_fill_cs_01 INTO l_inpg031,l_inpg034,l_inpg051,l_inpg054
#         IF cl_null(l_inpg054) THEN
#            LET r_success = FALSE
#            EXIT FOREACH
#         END IF
#      END FOREACH
#      IF NOT r_success THEN
#         RETURN r_success
#      END IF   
   END IF  
   CALL s_transaction_begin()  
    IF g_inpa015 = 'Y' OR g_inpa016 = 'Y' THEN
       SELECT inpfstus INTO l_inpfstus FROM inpf_t
        WHERE inpfent = g_enterprise
          AND inpfsite = g_site
          AND inpfdocno = g_detail_d[l_ac].b_inpddocno
          AND inpfseq = g_detail_d[l_ac].b_inpdseq
       IF l_inpfstus <> '5' THEN
          LET r_success = FALSE 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = "ain-00329"
          LET g_errparam.extend = g_detail_d[l_ac].b_inpddocno
          LET g_errparam.popup = TRUE
          CALL cl_err()  
          RETURN r_success                  
       END IF
    END IF
    UPDATE inpf_t SET inpfstus = '6', 
                      inpfcnfid = g_user,
                      inpfcnfdt = l_time
     WHERE inpfent = g_enterprise
       AND inpfsite = g_site
       AND inpfdocno = g_detail_d[l_ac].b_inpddocno
       AND inpfseq = g_detail_d[l_ac].b_inpdseq    
    IF SQLCA.sqlerrd[3] = 0 THEN
       LET r_success = FALSE 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'std-00009'
       LET g_errparam.extend = "upd inpf_t"
       LET g_errparam.popup = TRUE
       CALL cl_err() 
       CALL s_transaction_end('N','0')
       RETURN r_success
    END IF              
    SELECT COUNT(*) INTO l_cnt FROM inpa_t,inpb_t,inpf_t 
     WHERE inpaent = inpbent  
       AND inpadocno = inpbdocno 
       AND inpasite = inpbsite     
       AND inpfent = inpaent
       AND inpasite = inpfsite
       AND inpf004 = inpadocno
       AND inpaent = g_enterprise 
       AND inpasite = g_site
       AND inpastus = 'Y' 
       AND inpfstus = '6'
       AND inpa001 = '1'
       AND (inpa011 = 'Y' OR inpa012 = 'Y')
       AND inpb001 = '11' 
       AND inpadocno = g_inpd008    #add by lixh 20150906
   
    IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
    SELECT COUNT(*) INTO l_cnt1 FROM inpf_t,inpa_t
     WHERE inpaent = inpfent 
       AND inpasite = inpfsite
       AND inpadocno = inpf004
       AND inpfent = g_enterprise
       AND inpfsite = g_site
       AND inpf004 = g_inpd008
   
    IF cl_null(l_cnt1) THEN LET l_cnt1 = 0 END IF  
   
    LET l_speed = l_cnt/l_cnt1 * 100
   
    UPDATE inpb_t SET inpb002 = 'Y',
                      inpb003 = l_speed   
     WHERE inpbent = g_enterprise
       AND inpbsite = g_site
       AND inpbdocno = g_inpd008
       AND inpb001 = '11'
   
#    IF SQLCA.sqlerrd[3] = 0 THEN
#       LET r_success = FALSE 
#       INITIALIZE g_errparam TO NULL
#       LET g_errparam.code = 'std-00009'
#       LET g_errparam.extend = "upd inpb_t"
#       LET g_errparam.popup = TRUE
#       CALL cl_err()
#       CALL s_transaction_end('N','0')
#       RETURN r_success          
#    END IF  
    IF l_cnt = l_cnt1 THEN
       IF g_type = '7' THEN
          LET l_pd_user = g_user
       END IF
       IF g_type = '8' THEN
          LET l_pd_user = g_user
       END IF 
       UPDATE inpb_t SET inpb002 = 'Y',  
                         inpb003 = 100,
                         inpb006 = g_user,
                         inpb007 = g_today
        WHERE inpbent = g_enterprise
          AND inpbsite = g_site
          AND inpbdocno = g_inpd008
          AND inpb001 = '11'                        
     
#      IF SQLCA.sqlerrd[3] = 0 THEN
#         LET r_success = FALSE 
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'std-00009'
#         LET g_errparam.extend = "upd inpb_t"
#         LET g_errparam.popup = TRUE
#         CALL cl_err() 
#         CALL s_transaction_end('N','0')
#         RETURN r_success                      
#      END IF  
   END IF   
   CALL s_transaction_end('Y','0')
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 在制工单复盘取消确认
# Memo...........:
# Usage..........: CALL ainp900_inpf_unconf_upd_01()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp900_inpf_unconf_upd_01()
DEFINE l_pd_user   LIKE inpd_t.inpd034
DEFINE l_cnt1      LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
DEFINE l_speed     LIKE inpb_t.inpb003
DEFINE l_inpb002   LIKE inpb_t.inpb002
DEFINE l_stus      LIKE inpf_t.inpfstus
DEFINE l_inpfstus  LIKE inpf_t.inpfstus

   LET r_success = TRUE
   SELECT inpfstus INTO l_inpfstus FROM inpf_t
    WHERE inpfent = g_enterprise
      AND inpfsite = g_site
      AND inpfdocno = g_detail_d[l_ac].b_inpddocno
      AND inpfseq = g_detail_d[l_ac].b_inpdseq  
   IF l_inpfstus <> '6' THEN
      RETURN FALSE
   END IF   
   SELECT COUNT(*) INTO l_cnt FROM inpa_t,inpb_t,inpf_t 
    WHERE inpaent = inpbent  
      AND inpadocno = inpbdocno 
      AND inpasite = inpbsite     
      AND inpfent = inpaent
      AND inpasite = inpfsite
      AND inpf004 = inpadocno
      AND inpaent = g_enterprise 
      AND inpasite = g_site
      AND inpastus = 'Y' 
      AND inpdstus = '6'
      AND inpa001 = '1'
      AND (inpa011 = 'Y' OR inpa012 = 'Y')
      AND inpb001 = '11' 
      AND inpadocno = g_inpd008    #add by lixh 20150906
      
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
    
   SELECT COUNT(*) INTO l_cnt1 FROM inpf_t,inpa_t
    WHERE inpaent = inpfent 
      AND inpasite = inpfsite
      AND inpadocno = inpf004
      AND inpfent = g_enterprise
      AND inpfsite = g_site
      AND inpf004 = g_inpd008
   
   IF cl_null(l_cnt1) THEN LET l_cnt1 = 0 END IF  
   
   LET l_speed = l_cnt/l_cnt1 * 100
   
   IF l_speed = 0 THEN
      LET l_inpb002 = 'N'
   ELSE
      LET l_inpb002 = 'Y'
   END IF
   CALL s_transaction_begin()
   UPDATE inpb_t SET inpb002 = l_inpb002,
                     inpb003 = l_speed   
    WHERE inpbent = g_enterprise
      AND inpbsite = g_site
      AND inpbdocno = g_inpd008
      AND inpb001 = '11'
   
#   IF SQLCA.sqlerrd[3] = 0 THEN
#      LET r_success = FALSE 
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'std-00009'
#      LET g_errparam.extend = "upd inpb_t"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      CALL s_transaction_end('N','0')
#      RETURN r_success
#   END IF  
   IF l_cnt = l_cnt1 THEN
      IF g_inpa015 = 'Y' AND g_inpa016 = 'N' THEN
         LET l_pd_user = g_user
      END IF
      IF g_inpa016 = 'Y' THEN
         LET l_pd_user = g_user
      END IF               
      UPDATE inpb_t SET inpb002 = 'Y',  
                        inpb003 = 100,
                        inpb006 = g__user,
                        inpb007 = g_today
       WHERE inpbent = g_enterprise
         AND inpbsite = g_site
         AND inpbdocno = g_inpd008
         AND inpb001 = '11'                        
   END IF   

   IF g_inpa015 = 'Y' OR g_inpa016 = 'Y' THEN
      LET l_stus = '5'
   ELSE
      LET l_stus = 'N'
   END IF      
   UPDATE inpf_t SET inpfstus = l_stus, 
                     inpfcnfid = '',
                     inpfcnfdt = ''
    WHERE inpfent = g_enterprise
      AND inpfsite = g_site
      AND inpfdocno = g_detail_d[l_ac].b_inpddocno
      AND inpfseq = g_detail_d[l_ac].b_inpdseq    
   IF SQLCA.sqlerrd[3] = 0 THEN
      LET r_success = FALSE 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'std-00009'
      LET g_errparam.extend = "upd inpd_t"
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      CALL s_transaction_end('N','0')
      RETURN r_success     
   END IF  
   CALL s_transaction_end('Y','0')
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
