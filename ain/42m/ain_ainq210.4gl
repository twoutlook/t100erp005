#該程式已解開Section, 不再透過樣板產出!
{<section id="ainq210.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000015
#+ 
#+ Filename...: ainq210
#+ Description: 料件BIN卡查詢作業
#+ Creator....: 02295(2014-11-20 18:06:02)
#+ Modifier...: 02295(2014-11-21 11:17:33) -SD/PR- 00000
 
{</section>}
 
{<section id="ainq210.global" >}
#應用 q01 樣板自動產生(Version:1)
#160510-00019#9  2016/05/31 By 02295 效能优化
#160512-00004#2  2016/06/20 By 07024 1.QBE增加製造日期欄位  2.修正輸入有效日期(inad011)搜尋，查無資料的問題
#160608-00027#1  2016/10/25 By lixh  換算後異動數量依設定進行取位的動作 
#161129-00023#1  2016/11/29 By wuxja 料号开窗改成同ainq100的开窗q_imaf001_15,不需要开库存档
#161215-00001#1  2016/12/15 By wuxja 针对用户手动隐藏的栏位重新查询后又会出现的问题调整
#170216-00031#1  2016/02/21 By wuxja b_fill查询sql关联inat时漏了单位条件，导致多库存单位时数量不对
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_inag_d RECORD
       
       sel LIKE type_t.chr1, 
   inag001 LIKE inag_t.inag001, 
   inag001_desc LIKE type_t.chr500,
   inag001_desc_1 LIKE type_t.chr500,    
   inag002 LIKE inag_t.inag002, 
   inag002_desc LIKE type_t.chr500, 
   inag003 LIKE inag_t.inag003, 
   inag004 LIKE inag_t.inag004, 
   inag004_desc LIKE type_t.chr500, 
   inag005 LIKE inag_t.inag005, 
   inag005_desc LIKE type_t.chr500, 
   inag006 LIKE inag_t.inag006, 
   inag007 LIKE inag_t.inag007,
   inag007_desc LIKE type_t.chr500, 
   inag032 LIKE inag_t.inag032, 
   inag032_desc LIKE type_t.chr500, 
   qty1 LIKE inag_t.inag033, 
   inag033 LIKE inag_t.inag033, 
   inag024 LIKE inag_t.inag024, 
   inag024_desc LIKE type_t.chr500, 
   qty2 LIKE inag_t.inag025, 
   inag025 LIKE inag_t.inag025
       END RECORD
PRIVATE TYPE type_g_inag2_d RECORD 
   inaj006 LIKE inaj_t.inaj006,
   inaj006_desc LIKE type_t.chr500,   
   inaj007 LIKE inaj_t.inaj007, 
   inaj008 LIKE inaj_t.inaj008, 
   inaj008_desc LIKE inayl_t.inayl003, 
   inaj009 LIKE inaj_t.inaj009, 
   inaj009_desc LIKE inab_t.inab003, 
   inaj010 LIKE inaj_t.inaj010, 
   inaj022 LIKE inaj_t.inaj022,
   inaj023 LIKE inaj_t.inaj023,
   inaj024 LIKE inaj_t.inaj024,
   inaj015 LIKE inaj_t.inaj015, 
   inaj001 LIKE inaj_t.inaj001, 
   inaj002 LIKE inaj_t.inaj002,
   inaj003 LIKE inaj_t.inaj003,   
   inaj044 LIKE inaj_t.inaj044,
   inaj045 LIKE inaj_t.inaj045,
   inaj045_desc LIKE oocal_t.oocal003,
   inaj012 LIKE inaj_t.inaj012, 
   inaj012_desc LIKE oocal_t.oocal003, 
   inaj011 LIKE inaj_t.inaj011, 
   qty3 LIKE inaj_t.inaj011, 
   qty4 LIKE inaj_t.inaj011, 
   inaj026 LIKE inaj_t.inaj026, 
   inaj026_desc LIKE oocal_t.oocal003,
   inaj027 LIKE inaj_t.inaj027, 
   qty5 LIKE inaj_t.inaj027, 
   qty6 LIKE inaj_t.inaj027
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_inag_d            DYNAMIC ARRAY OF type_g_inag_d
DEFINE g_inag_d_t          type_g_inag_d
DEFINE g_inag2_d     DYNAMIC ARRAY OF type_g_inag2_d
DEFINE g_inag2_d_t   type_g_inag2_d
 
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num5              #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num5
DEFINE g_detail_cnt          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num5
DEFINE g_detail_idx          LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num5
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
 
 
#add-point:自定義模組變數(Module Variable)
 TYPE type_master RECORD
       yy LIKE type_t.num5,
       stage LIKE type_t.num5,       
       a LIKE type_t.chr1,
       l_inag002 LIKE type_t.chr1,
       l_inag003 LIKE type_t.chr1,
       l_inag004 LIKE type_t.chr1,
       l_inag005 LIKE type_t.chr1,
       l_inag006 LIKE type_t.chr1,
       l_inag007 LIKE type_t.chr1,
       inag001 LIKE inag_t.inag001,
       inag002 LIKE inag_t.inag002,
       inag003 LIKE inag_t.inag003,
       inag004 LIKE inag_t.inag004,
       inag005 LIKE inag_t.inag005,
       inag006 LIKE inag_t.inag006,
       inad014 LIKE inad_t.inad014, #160512-00004#2-add
       inad011 LIKE inad_t.inad011       
       END RECORD

DEFINE g_master type_master
DEFINE g_master_t    type_master      #161215-00001#1 add
DEFINE g_master_flag LIKE type_t.chr1 #161215-00001#1 add
DEFINE g_glaa003   LIKE glaa_t.glaa003
DEFINE g_bdate     LIKE type_t.dat
DEFINE g_edate     LIKE type_t.dat
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="ainq210.main" >}
#應用 a26 樣板自動產生(Version:1)
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化
   DROP TABLE ainq210_tmp; 
   CREATE TEMP TABLE ainq210_tmp(
     inag001  VARCHAR(40), 
     inag002  VARCHAR(256), 
     inag003  VARCHAR(30), 
     inag004  VARCHAR(10), 
     inag005  VARCHAR(10), 
     inag006  VARCHAR(30),
     inag007  VARCHAR(10),                    #库存单位
     inag008  DECIMAL(20,6),                    #库存数量
     inat015  DECIMAL(20,6),                    #期初库存数量
     inag032  VARCHAR(10),                    #基础单位
     inag033  DECIMAL(20,6),                    #基础数量
     inag024  VARCHAR(10),                    #参考单位
     inag025  DECIMAL(20,6),                    #参考数量
     inat021  DECIMAL(20,6)     #期初参考数量
   );
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ainq210_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE ainq210_master_referesh FROM g_sql
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ainq210_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainq210 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainq210_init()   
 
      #進入選單 Menu (="N")
      CALL ainq210_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ainq210
      
   END IF 
   
   CLOSE ainq210_cl
   
   
 
   #add-point:作業離開前
   DROP TABLE ainq210_tmp; 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="ainq210.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ainq210_init()
 
   #add-point:init段define
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
#  LET g_selcolor    = "#D0E7FD"
   
     
 
   #add-point:畫面資料初始化
   LET g_master.inad014 = '' #160512-00004#2-add
   LET g_master.inad011 = ''
   LET g_master.yy = ''
   LET g_master.stage = ''
   LET g_master.a = 'N'
   LET g_master.l_inag002 = 'N' 
   LET g_master.l_inag003 = 'N' 
   LET g_master.l_inag004 = 'N' 
   LET g_master.l_inag005 = 'N' 
   LET g_master.l_inag006 = 'N'
   LET g_master.l_inag007 = 'N'
   CALL cl_set_combo_scc("inaj015",'24')
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN 
      CALL cl_set_comp_visible("b_inag024,b_inag024_desc,b_qty2,b_inag025",FALSE)
      CALL cl_set_comp_visible("inaj026,inaj026_desc,inaj027,qty5,qty6",FALSE)   
   END IF
   SELECT DISTINCT glaa003 INTO g_glaa003
     FROM glaa_t,ooef_t
    WHERE glaacomp = ooef017
      AND glaaent = ooefent
      AND ooefent = g_enterprise
      AND ooef001 = g_site
      AND glaa014 = 'Y'   
   
   #161215-00001#1 add   --begin--
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("b_inag002,b_inag002_desc",FALSE)
      CALL cl_set_comp_visible("inaj006,inaj006_desc",FALSE)
      CALL cl_set_comp_visible("inag002,l_inag002",FALSE)
   END IF   
   LET g_master_t.* = g_master.*   
   #161215-00001#1 add  --end--
   #end add-point
 
   CALL ainq210_default_search()
END FUNCTION
 
{</section>}
 
{<section id="ainq210.default_search" >}
PRIVATE FUNCTION ainq210_default_search()
   #add-point:default_search段define

   #end add-point
 
 
   #add-point:default_search段開始前

   #end add-point
 
   #應用 qs27 樣板自動產生(Version:1)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " inag001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " inag002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " inag003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " inag004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " inag005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " inag006 = '", g_argv[06], "' AND "
   END IF
#   IF NOT cl_null(g_argv[07]) THEN
#      LET g_wc = g_wc, " inag007 = '", g_argv[07], "' AND "
#   END IF
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
 
   #add-point:default_search段結束前
   # add by lixh 20150728
   LET g_master.yy = g_argv[07]
   LET g_master.stage = g_argv[08]
   # add by lixh 20150728
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainq210.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainq210_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   #add-point:ui_dialog段define

   #end add-point
   
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET g_main_hidden = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog 

   #end add-point
 
   
   CALL ainq210_b_fill()
  
   WHILE li_exit = FALSE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         INPUT BY NAME g_master.yy,g_master.stage,g_master.a,g_master.l_inag002,g_master.l_inag003,
                       g_master.l_inag004,g_master.l_inag005,g_master.l_inag006,g_master.l_inag007
                       ATTRIBUTE(WITHOUT DEFAULTS)    
            BEFORE INPUT
               LET g_master_t.* = g_master.*    #161215-00001#1 add
           
            AFTER INPUT
 
         END INPUT
         #end add-point
 
         #add-point:construct段落
         #160512-00004#2-add-'inad014'
         CONSTRUCT BY NAME g_wc ON inag001,inag002,inag003,inag004,inag005,inag006,inad014,inad011
         
            BEFORE CONSTRUCT
               DISPLAY BY NAME g_master.inag001,g_master.inag002,g_master.inag003,
                               g_master.inag004,g_master.inag005,g_master.inag006,
                               g_master.inad014, #160512-00004#2-add
                               g_master.inad011
               
            AFTER FIELD inag001
               LET g_master.inag001 = GET_FLDBUF(inag001)
            
            AFTER FIELD inag002
               LET g_master.inag002 = GET_FLDBUF(inag002)
               
            AFTER FIELD inag003
               LET g_master.inag003 = GET_FLDBUF(inag003)
    
            AFTER FIELD inag004
               LET g_master.inag004 = GET_FLDBUF(inag004)

            AFTER FIELD inag005
               LET g_master.inag005 = GET_FLDBUF(inag005)
            
            AFTER FIELD inag006
               LET g_master.inag006 = GET_FLDBUF(inag006)
               
            AFTER FIELD inad011
               LET g_master.inad011 = GET_FLDBUF(inad011)

    
            ON ACTION controlp INFIELD inag001          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
              #CALL q_inag001()                           #呼叫開窗   #161129-00023#1 mark
               CALL q_imaf001_15()                                   #161129-00023#1 add
               DISPLAY g_qryparam.return1 TO inag001      #顯示到畫面上
               NEXT FIELD inag001                         #返回原欄位
               
            ON ACTION controlp INFIELD inag002          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inag002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO inag002      #顯示到畫面上
               NEXT FIELD inag002                         #返回原欄位
               
            ON ACTION controlp INFIELD inag003          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inag003()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO inag003      #顯示到畫面上
               NEXT FIELD inag003                         #返回原欄位
               
            ON ACTION controlp INFIELD inag004          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inag004_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO inag004      #顯示到畫面上
               NEXT FIELD inag004                         #返回原欄位
               
            ON ACTION controlp INFIELD inag005          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inag005_5()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO inag005      #顯示到畫面上
               NEXT FIELD inag005                         #返回原欄位
               
            ON ACTION controlp INFIELD inag006          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inag006()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO inag006      #顯示到畫面上
               NEXT FIELD inag006                         #返回原欄位
         
         END CONSTRUCT  
         #end add-point
     
         DISPLAY ARRAY g_inag_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_inag_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL ainq210_b_fill2()
 
               #add-point:input段before row

               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         END DISPLAY
 
         DISPLAY ARRAY g_inag2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row

               #end add-point
            #自訂ACTION(detail_show,page_2)
            
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array

         #end add-point
 
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
      
         BEFORE DIALOG
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #add-point:ui_dialog段before dialog

            #end add-point
            NEXT FIELD inag001
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            IF cl_null(g_master.yy) OR cl_null(g_master.stage) THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend =  "" 
               LET g_errparam.code   = 'ain-00345' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()               
               NEXT FIELD yy
            END IF
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
 
         
            LET g_wc2 = " 1=1"
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
 
            #儲存WC資訊
            CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
            
            #161215-00001#1 add  --begin--
            IF g_master.l_inag002 != g_master_t.l_inag002 OR g_master.l_inag003 != g_master_t.l_inag003 OR g_master.l_inag004 != g_master_t.l_inag004 OR
               g_master.l_inag005 != g_master_t.l_inag005 OR g_master.l_inag006 != g_master_t.l_inag006 OR g_master.l_inag007 != g_master_t.l_inag007 THEN
               LET g_master_flag = 'Y'
               LET g_master_t.* = g_master.*
            END IF
            #161215-00001#1 add  --end--
            
            CALL ainq210_b_fill()
      
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #end add-point
            CALL cl_user_overview()
 
 
         ON ACTION datarefresh   # 重新整理
            CALL ainq210_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         #應用 qs19 樣板自動產生(Version:1)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_inag_d.getLength()
               LET g_inag_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_inag_d.getLength()
               LET g_inag_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_inag_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_inag_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_inag_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_inag_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               LET g_main_hidden = 0
               LET g_export_node[1] = base.typeInfo.create(g_inag_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_inag2_d)
               LET g_export_id[2]   = "s_detail2"

               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
               LET g_main_hidden = 1
            END IF
            #end add-point
 
 
 
         #應用 qs16 樣板自動產生(Version:1)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL ainq210_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
 
         
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert

               #END add-point
               
               EXIT DIALOG
            END IF
 
 
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               
               EXIT DIALOG
            END IF
 
 
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query

               #END add-point
               
               
            END IF
 
 
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo

               #END add-point
               
               EXIT DIALOG
            END IF
 
 
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
 
         #add-point:查詢方案相關ACTION設定前
 
         #end add-point
 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL ainq210_b_fill()
            END IF
 
         ON ACTION qbe_select
            LET ls_wc = ""
            CALL cl_qbe_list("c") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL ainq210_b_fill()
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
 
         #add-point:查詢方案相關ACTION設定後

         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="ainq210.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainq210_b_fill()
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   #add-point:b_fill段define
   DEFINE l_rate  LIKE inaj_t.inaj014
   DEFINE l_inat015 LIKE inat_t.inat015
   DEFINE l_inag033 LIKE inag_t.inag033
   DEFINE l_inag RECORD  
             inag001 LIKE inag_t.inag001, 
             inag002 LIKE inag_t.inag002, 
             inag003 LIKE inag_t.inag003, 
             inag004 LIKE inag_t.inag004, 
             inag005 LIKE inag_t.inag005, 
             inag006 LIKE inag_t.inag006,
             inag007 LIKE inag_t.inag007,               #库存单位
             inag008 LIKE inag_t.inag008,               #库存数量
             inat015 LIKE inat_t.inat015,               #期初库存数量
             inag032 LIKE inag_t.inag032,               #基础单位
             inag033 LIKE inag_t.inag033,               #基础数量
             inag024 LIKE inag_t.inag024,               #参考单位
             inag025 LIKE inag_t.inag025,               #参考数量
             inat021 LIKE inat_t.inat021                #期初参考数量
     END RECORD
   DEFINE l_group  STRING
   #160608-00027#1-S
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_ooca002   LIKE ooca_t.ooca002      #小数位数
   DEFINE l_ooca004   LIKE ooca_t.ooca004      #舍入类型  
   #160608-00027#1-E      
   #end add-point
 
   #add-point:b_fill段sql_before
   IF NOT cl_null(g_master.yy) AND NOT cl_null(g_master.stage) THEN   
      CALL s_fin_date_get_period_range(g_glaa003,g_master.yy,g_master.stage) RETURNING g_bdate,g_edate
   END IF
   CALL ainq210_set_comp_visible()
   #end add-point
 
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
 
   CALL g_inag_d.clear()
 
   #add-point:陣列清空
   DELETE FROM ainq210_tmp;
   LET g_sql = " INSERT INTO ainq210_tmp ",
               " SELECT DISTINCT inag001,inag002,inag003,inag004,inag005,inag006,inag007,inag008,",
               "        NVL(inat015,0),imaa006,inag033,inag024,inag025,inat021 ",
               "   FROM imaa_t,inag_t",
               "   LEFT OUTER JOIN inat_t ON inagent = inatent AND inagsite = inatsite AND inag001 = inat001 ",
               "                        AND inag002 = inat002 AND inag003 = inat003 AND inag004 = inat004 ",
               "                        AND inag005 = inat005 AND inag006 = inat006 ",
               "                        AND inag007 = inat007 ",  #170216-00031#1 add
               "                        AND (inat008*12+inat009) = ",g_master.yy*12+g_master.stage-1,
               #160512-00004#2-add-(S)
               "   LEFT OUTER JOIN inad_t ON inadent = inagent AND inadsite = inagsite AND inad001 = inag001",
               "                         AND inad002 = inag002 AND inad003 = inag006 ",
               #160512-00004#2-add-(E)
               "  WHERE imaaent = inagent AND imaa001 = inag001 ",
               "    AND inagent = '",g_enterprise,"' AND inagsite = '",g_site,"' AND ",ls_wc
   IF g_master.a = 'Y' THEN 
      LET g_sql = g_sql," AND EXISTS (SELECT * FROM inaj_t WHERE inajent = inagent AND inajsite = inagsite ",
                  " AND inaj005=inag001 AND inaj006=inag002 AND inaj007=inag003 AND inaj008=inag004 ",
                  " AND inaj009=inag005 AND inaj010=inag006 AND inaj022 >= '",g_bdate,"')"
   END IF
   PREPARE ainq210_ins_tmp FROM g_sql
   EXECUTE ainq210_ins_tmp
   #160510-00019#9---mod---s 
   LET g_sql = "  UPDATE ainq210_tmp ",
               "     SET inat015 = ? ,",
               "         inag033 = ? ",
               "   WHERE inag001 = ?",
               "     AND inag002 = ?",
               "     AND inag003 = ?",
               "     AND inag004 = ?",
               "     AND inag005 = ?",
               "     AND inag006 = ?",
               "     AND inag007 = ?"
   PREPARE upd_tmp FROM g_sql            
   #160510-00019#9---mod---e
   LET g_sql = " SELECT DISTINCT * FROM ainq210_tmp "
   PREPARE ainq210_upd_pre FROM g_sql
   DECLARE ainq210_upd_cur CURSOR FOR ainq210_upd_pre
   FOREACH ainq210_upd_cur INTO l_inag.* 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF     
      IF NOT cl_null(l_inag.inag007) AND NOT cl_null(l_inag.inag032) THEN  
         CALL s_aimi190_get_convert(l_inag.inag001,l_inag.inag007,l_inag.inag032) RETURNING g_success,l_rate
         IF g_success THEN 
            LET l_inat015 = l_inag.inat015 * l_rate 
            LET l_inag033 = l_inag.inag008 * l_rate 
            #160608-00027#1-S
            IF NOT cl_null(l_inag.inag032) THEN
               CALL s_aooi250_get_msg(l_inag.inag032) RETURNING l_success,l_ooca002,l_ooca004
               IF l_success THEN
                  IF NOT cl_null(l_inat015) THEN
                     CALL s_num_round(l_ooca004,l_inat015,l_ooca002) RETURNING l_inat015
                  END IF
                  IF NOT cl_null(l_inag033) THEN
                     CALL s_num_round(l_ooca004,l_inag033,l_ooca002) RETURNING l_inag033
                  END IF                  
               END IF
            END IF               
            #160608-00027#1-E
         END IF
      ELSE
         LET l_inat015 = l_inag.inat015 
         LET l_inag033 = l_inag.inag008       
      END IF
      #160510-00019#9---mod---s
      EXECUTE upd_tmp USING l_inat015,l_inag033,
                            l_inag.inag001,l_inag.inag002,l_inag.inag003,l_inag.inag004,
                            l_inag.inag005,l_inag.inag006,l_inag.inag007                            
      #UPDATE ainq210_tmp
      #   SET inat015 = l_inat015,
      #       inag033 = l_inag033
      # WHERE inag001 = l_inag.inag001
      #   AND inag002 = l_inag.inag002
      #   AND inag003 = l_inag.inag003
      #   AND inag004 = l_inag.inag004
      #   AND inag005 = l_inag.inag005
      #   AND inag006 = l_inag.inag006
      #   AND inag007 = l_inag.inag007
      #160510-00019#9---mod---e   
   END FOREACH
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:1)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   
   #add-point:b_fill段sql_after
   #160510-00019#9---mod---s
   #LET g_sql = " SELECT DISTINCT '',inag001,imaal003,imaal004,"
   #LET l_group = " GROUP BY inag001,imaal003,imaal004"
   LET g_sql = " SELECT DISTINCT '',inag001,",
               "  (SELECT imaal003 FROM imaal_t WHERE imaalent=",g_enterprise," AND inag001 = imaal001 AND imaal002 = '",g_dlang,"') imaal003,",
               "  (SELECT imaal004 FROM imaal_t WHERE imaalent=",g_enterprise," AND inag001 = imaal001 AND imaal002 = '",g_dlang,"') imaal004,"
   LET l_group = " GROUP BY inag001"   
   #160510-00019#9---mod---e
   
   IF g_master.l_inag002 = 'Y' THEN 
      #160510-00019#9---mod---s
      #LET g_sql = g_sql,"inag002,'',"   
      #LET l_group = l_group,",inag002"
      LET g_sql = g_sql,"inag002,(SELECT inaml004 FROM inaml_t WHERE inamlent = ",g_enterprise," AND inaml001 = inag001 AND inaml002 = inag002 AND inaml003 = '",g_dlang,"') inag002_desc,"  
      LET l_group = l_group,",inag002"
      #160510-00019#9---mod---e
   ELSE
      LET g_sql = g_sql,"'','',"
   END IF
   IF g_master.l_inag003 = 'Y' THEN 
      LET g_sql = g_sql,"inag003,"
      LET l_group = l_group,",inag003"
   ELSE
      LET g_sql = g_sql,"'',"
   END IF 
   IF g_master.l_inag004 = 'Y' THEN
      #160510-00019#9---mod---s   
      #LET g_sql = g_sql,"inag004,inayl003,"
      #LET l_group = l_group,",inag004,inayl003"
      LET g_sql = g_sql,"inag004,(SELECT inayl003 FROM inayl_t WHERE inaylent = ",g_enterprise," AND inayl001 = inag004 AND inayl002 = '",g_dlang,"') inayl003,"
      LET l_group = l_group,",inag004"      
      #160510-00019#9---mod---e
   ELSE
      LET g_sql = g_sql,"'','',"
   END IF 
   IF g_master.l_inag005 = 'Y' THEN 
      #160510-00019#9---mod---s
      #LET g_sql = g_sql,"inag005,inab003,"
      #LET l_group = l_group,",inag005,inab003"
      LET g_sql = g_sql,"inag005,(SELECT inab003 FROM inab_t WHERE inabent=",g_enterprise," AND inabsite = '",g_site,"' AND inag004 = inab001 AND inag005 = inab002) inab003,"
      LET l_group = l_group,",inag005"      
      #160510-00019#9---mod---e
   ELSE
      LET g_sql = g_sql,"'','',"
   END IF 
   IF g_master.l_inag006 = 'Y' THEN 
      LET g_sql = g_sql,"inag006,"
      LET l_group = l_group,",inag006"
   ELSE
      LET g_sql = g_sql,"'',"
   END IF
   IF g_master.l_inag007 = 'Y' THEN
      #160510-00019#9---mod---s   
      #LET g_sql = g_sql,"inag007,c.oocal003,"
      #LET l_group = l_group,",inag007,c.oocal003"
      LET g_sql = g_sql,"inag007,(SELECT oocal003 FROM oocal_t WHERE oocalent = ",g_enterprise," AND inag007 = oocal001 AND oocal002 = '",g_dlang,"') inag007_desc,"
      LET l_group = l_group,",inag007"
      #160510-00019#9---mod---s
   ELSE
      LET g_sql = g_sql,"'','',"
   END IF   
   #160510-00019#9---mod---s 
   #LET l_group = l_group,",inag032,a.oocal003,inag024,b.oocal003"
   #LET g_sql = g_sql,"inag032,a.oocal003,SUM(inat015),SUM(inag033),inag024,b.oocal003,SUM(inat021),SUM(inag025) ",
   #            " FROM ainq210_tmp ",
   #            " SELECT  FROM imaal_t WHERE imaalent='",g_enterprise,"' AND inag001 = imaal001 AND imaal002 = '",g_dlang,"'",
   #            " SELECT  FROM inayl_t WHERE inaylent='",g_enterprise,"' AND inayl001 = inag004 AND inayl002 = '",g_dlang,"' ",
   #            " SELECT  FROM inab_t WHERE inabent='",g_enterprise,"' AND inabsite = '",g_site,"' AND inag004 = inab001 AND inag005 = inab002 ",
   #            " SELECT  FROM oocal_t WHERE oocalent = '",g_enterprise,"' AND inag032 = oocal001 AND oocal002 = '",g_dlang,"'",
   #            " SELECT  FROM oocal_t WHERE oocalent = '",g_enterprise,"' AND inag024 = oocal001 AND oocal002 = '",g_dlang,"'",
   #            " SELECT  FROM oocal_t WHERE oocalent = '",g_enterprise,"' AND inag007 = oocal001 AND oocal002 = '",g_dlang,"'",               
   #            "",l_group," ORDER BY inag001"   
   LET l_group = l_group,",inag032,inag024"
   LET g_sql = g_sql,"inag032,",
               "      (SELECT oocal003 FROM oocal_t WHERE oocalent = ",g_enterprise," AND inag032 = oocal001 AND oocal002 = '",g_dlang,"') inag032_desc,",
               "      SUM(inat015),SUM(inag033),inag024,",
               "      (SELECT oocal003 FROM oocal_t WHERE oocalent = ",g_enterprise," AND inag024 = oocal001 AND oocal002 = '",g_dlang,"') inag024_desc,",
               "      SUM(inat021),SUM(inag025) ",
               " FROM ainq210_tmp ",              
               "",l_group," ORDER BY inag001"                
   #160510-00019#9---mod---e               
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE ainq210_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainq210_pb
 
   #OPEN b_fill_curs USING g_enterprise, g_site
 
   FOREACH b_fill_curs INTO g_inag_d[l_ac].sel,g_inag_d[l_ac].inag001,g_inag_d[l_ac].inag001_desc,g_inag_d[l_ac].inag001_desc_1,
       g_inag_d[l_ac].inag002,g_inag_d[l_ac].inag002_desc, 
       g_inag_d[l_ac].inag003,g_inag_d[l_ac].inag004,g_inag_d[l_ac].inag004_desc,g_inag_d[l_ac].inag005, 
       g_inag_d[l_ac].inag005_desc,g_inag_d[l_ac].inag006,g_inag_d[l_ac].inag007,g_inag_d[l_ac].inag007_desc, 
       g_inag_d[l_ac].inag032,g_inag_d[l_ac].inag032_desc, 
       g_inag_d[l_ac].qty1,g_inag_d[l_ac].inag033,g_inag_d[l_ac].inag024,g_inag_d[l_ac].inag024_desc, 
       g_inag_d[l_ac].qty2,g_inag_d[l_ac].inag025
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充

      #end add-point
 
      CALL ainq210_detail_show("'1'")
 
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
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
   CALL g_inag_d.deleteElement(g_inag_d.getLength())
 
   #add-point:陣列長度調整

   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_inag_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_detail_idx = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:1)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE ainq210_pb
 
 
 
 
   LET l_ac = 1
   CALL ainq210_b_fill2()
 
      CALL ainq210_filter_show('inag001','b_inag001')
   CALL ainq210_filter_show('inag002','b_inag002')
   CALL ainq210_filter_show('inag003','b_inag003')
   CALL ainq210_filter_show('inag004','b_inag004')
   CALL ainq210_filter_show('inag005','b_inag005')
   CALL ainq210_filter_show('inag006','b_inag006')
   CALL ainq210_filter_show('inag007','b_inag007') 
   CALL ainq210_filter_show('inag032','b_inag032')
   CALL ainq210_filter_show('inag033','b_inag033')
   CALL ainq210_filter_show('inag024','b_inag024')
   CALL ainq210_filter_show('inag025','b_inag025')
 
 
END FUNCTION
 
{</section>}
 
{<section id="ainq210.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainq210_b_fill2()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:b_fill2段define
   DEFINE l_amt1  LIKE inaj_t.inaj011
   DEFINE l_amt2  LIKE inaj_t.inaj011
   DEFINE l_rate  LIKE inaj_t.inaj014
   DEFINE l_wc    STRING
   #160608-00027#1-S
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_ooca002   LIKE ooca_t.ooca002      #小数位数
   DEFINE l_ooca004   LIKE ooca_t.ooca004      #舍入类型  
   #160608-00027#1-E   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:1)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_inag2_d.clear()
 
   #add-point:陣列清空
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF   
   LET l_wc = cl_replace_str(g_wc,'inag001','inaj005')
   LET l_wc = cl_replace_str(l_wc,'inag002','inaj006')
   LET l_wc = cl_replace_str(l_wc,'inag003','inaj007')
   LET l_wc = cl_replace_str(l_wc,'inag004','inaj008')
   LET l_wc = cl_replace_str(l_wc,'inag005','inaj009')
   LET l_wc = cl_replace_str(l_wc,'inag006','inaj010')
   #end add-point
 
#table2
   #160510-00019#9---mod---s
   #LET g_sql = "SELECT UNIQUE inaj006,'',inaj007,inaj008,inayl003,inaj009,inab003,inaj010,",
   #            "       inaj022,inaj023,inaj024,inaj015,inaj001,inaj002,inaj003,inaj044,inaj045,a.oocal003,inaj012,b.oocal003,inaj004*inaj011,",
   #            "       inaj004*inaj011*inaj014,'',inaj026,c.oocal003,inaj004*inaj027,'','' ",
   #            "  FROM inaj_t", 
   #            "  LEFT OUTER JOIN inayl_t ON inaylent = inajent AND inayl001 = inaj008 AND inayl002 = '",g_dlang,"' ",
   #            "  LEFT OUTER JOIN inab_t ON inabent = inajent AND inabsite = inajsite AND inaj008 = inab001 AND inaj009 = inab002 ",
   #            "  LEFT OUTER JOIN oocal_t a ON a.oocalent = inajent AND inaj045 = a.oocal001 AND a.oocal002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN oocal_t b ON b.oocalent = inajent AND inaj012 = b.oocal001 AND b.oocal002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN oocal_t c ON c.oocalent = inajent AND inaj026 = c.oocal001 AND c.oocal002 = '",g_dlang,"'",               
   #            " WHERE inajent = ? AND inajsite = ? ",
   #            "   AND inaj022 >= '",g_bdate,"'",
   #            " AND inaj005 = '",g_inag_d[g_detail_idx].inag001,"'"
   LET g_sql = "SELECT UNIQUE inaj006,",
               "       (SELECT inaml004 FROM inaml_t WHERE inamlent = inajent AND inaml001 = inaj005 AND inaml002 = inaj006 AND inaml003 = '",g_dlang,"') inaj006_desc,",
               "       inaj007,inaj008,",
               "       (SELECT inayl003 FROM inayl_t WHERE inaylent = inajent AND inayl001 = inaj008 AND inayl002 = '",g_dlang,"') inayl003,",
               "       inaj009,",
               "       (SELECT inab003 FROM inab_t WHERE inabent = inajent AND inabsite = inajsite AND inaj008 = inab001 AND inaj009 = inab002) inab003,",
               "       inaj010,",
               "       inaj022,inaj023,inaj024,inaj015,inaj001,inaj002,inaj003,inaj044,inaj045,",
               "       (SELECT oocal003 FROM oocal_t WHERE oocalent = inajent AND inaj045 = oocal001 AND oocal002 = '",g_dlang,"') oocal003a,",
               "       inaj012,",
               "       (SELECT oocal003 FROM oocal_t WHERE oocalent = inajent AND inaj012 = oocal001 AND oocal002 = '",g_dlang,"') oocal003b,",
               "       inaj004*inaj011,inaj004*inaj011*inaj014,'',inaj026,",
               "       (SELECT oocal003 FROM oocal_t WHERE oocalent = inajent AND inaj026 = oocal001 AND oocal002 = '",g_dlang,"') oocal003c,",
               "       inaj004*inaj027,'','' ",
               "  FROM inaj_t",              
               "  LEFT OUTER JOIN inad_t ON inadent = inajent AND inadsite = inajsite AND inad001 = inaj005 AND inad002 = inaj006 AND inad003 = inaj010 ", #160512-00004#2-add
               " WHERE inajent = ",g_enterprise," AND inajsite = '",g_site,"' ",
               "   AND inaj022 >= '",g_bdate,"'",
               " AND inaj005 = '",g_inag_d[g_detail_idx].inag001,"'"               
   #160510-00019#9---mod---e
   IF g_master.l_inag002 = 'Y' THEN 
      LET g_sql = g_sql," AND inaj006 = '",g_inag_d[g_detail_idx].inag002,"'"
   END IF
   IF g_master.l_inag003 = 'Y' THEN 
      LET g_sql = g_sql," AND inaj007 = '",g_inag_d[g_detail_idx].inag003,"'"
   END IF 
   IF g_master.l_inag004 = 'Y' THEN 
      LET g_sql = g_sql," AND inaj008 = '",g_inag_d[g_detail_idx].inag004,"'"
   END IF 
   IF g_master.l_inag005 = 'Y' THEN 
      LET g_sql = g_sql," AND inaj009 = '",g_inag_d[g_detail_idx].inag005,"'"
   END IF 
   IF g_master.l_inag006 = 'Y' THEN 
      LET g_sql = g_sql," AND inaj010 = '",g_inag_d[g_detail_idx].inag006,"'"
   END IF
   IF g_master.l_inag007 = 'Y' THEN 
      LET g_sql = g_sql," AND inaj045 = '",g_inag_d[g_detail_idx].inag007,"'"
   END IF   
   LET g_sql = g_sql," AND ",l_wc," ORDER BY inaj022,inaj023,inaj024"
 
   #add-point:單身填充前
   LET l_amt1 = g_inag_d[g_detail_idx].qty1
   LET l_amt2 = g_inag_d[g_detail_idx].qty2 
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE ainq210_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR ainq210_pb2
 
#   OPEN b_fill_curs2 USING g_enterprise, g_site   #160510-00019#9 mark
#                                  ,g_inag_d[g_detail_idx].inag001
#                                  ,g_inag_d[g_detail_idx].inag002
# 
#                                  ,g_inag_d[g_detail_idx].inag003
# 
#                                  ,g_inag_d[g_detail_idx].inag004
# 
#                                  ,g_inag_d[g_detail_idx].inag005
# 
#                                  ,g_inag_d[g_detail_idx].inag006
# 
#                                  ,g_inag_d[g_detail_idx].inag007
 
 
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_inag2_d[l_ac].inaj006,g_inag2_d[l_ac].inaj006_desc,g_inag2_d[l_ac].inaj007, 
       g_inag2_d[l_ac].inaj008,g_inag2_d[l_ac].inaj008_desc,g_inag2_d[l_ac].inaj009,g_inag2_d[l_ac].inaj009_desc,g_inag2_d[l_ac].inaj010,g_inag2_d[l_ac].inaj022, 
       g_inag2_d[l_ac].inaj023,g_inag2_d[l_ac].inaj024,g_inag2_d[l_ac].inaj015,g_inag2_d[l_ac].inaj001,
       g_inag2_d[l_ac].inaj002,g_inag2_d[l_ac].inaj003,g_inag2_d[l_ac].inaj044, 
       g_inag2_d[l_ac].inaj045,g_inag2_d[l_ac].inaj045_desc,g_inag2_d[l_ac].inaj012,g_inag2_d[l_ac].inaj012_desc,g_inag2_d[l_ac].inaj011,g_inag2_d[l_ac].qty3,
       g_inag2_d[l_ac].qty4,g_inag2_d[l_ac].inaj026,g_inag2_d[l_ac].inaj026_desc, 
       g_inag2_d[l_ac].inaj027,g_inag2_d[l_ac].qty5,g_inag2_d[l_ac].qty6
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充
      LET l_amt1 = l_amt1 + g_inag2_d[l_ac].qty3
      LET g_inag2_d[l_ac].qty4 = l_amt1
      
      IF NOT cl_null(g_inag2_d[l_ac].inaj026) AND not cl_null(g_inag_d[g_detail_idx].inag024) THEN 
#         CALL s_aimi190_get_convert(g_inag_d[g_detail_idx].inag001,g_inag2_d[l_ac].inaj026,g_inag_d[g_detail_idx].inag024) RETURNING g_success,l_rate #xj mod
         CALL s_aooi250_convert_qty(g_inag_d[g_detail_idx].inag001,g_inag2_d[l_ac].inaj026,g_inag_d[g_detail_idx].inag024,g_inag2_d[l_ac].inaj027)
              RETURNING g_success,g_inag2_d[l_ac].qty5     
#         IF g_success THEN    #xj mod
#            LET g_inag2_d[l_ac].qty5 = g_inag2_d[l_ac].inaj027 * l_rate
#         END IF

         #160608-00027#1-s
         IF NOT cl_null(g_inag_d[g_detail_idx].inag024) THEN
            CALL s_aooi250_get_msg(g_inag_d[g_detail_idx].inag024) RETURNING l_success,l_ooca002,l_ooca004
            IF l_success THEN
               IF NOT cl_null(g_inag2_d[l_ac].qty5) THEN
                  CALL s_num_round(l_ooca004,g_inag2_d[l_ac].qty5,l_ooca002) RETURNING g_inag2_d[l_ac].qty5
               END IF
            END IF
         END IF         
         #160608-00027#1-e
         LET l_amt2 = l_amt2 + g_inag2_d[l_ac].qty5
         LET g_inag2_d[l_ac].qty6 = l_amt2 
      ELSE
         LET g_inag2_d[l_ac].qty6 = ''      
      END IF      
      #end add-point
 
      CALL ainq210_detail_show("'2'")
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
#Page2
   CALL g_inag2_d.deleteElement(g_inag2_d.getLength())
 
   #add-point:陣列長度調整

   #end add-point
 
#Page2
   LET li_ac = g_inag2_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
   #add-point:單身填充後

   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="ainq210.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainq210_detail_show(ps_page)
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference
#      CALL s_feature_description(g_inag_d[l_ac].inag001,g_inag_d[l_ac].inag002) RETURNING g_success,g_inag_d[l_ac].inag002_desc  #160510-00019#9 mark
#      DISPLAY BY NAME g_inag_d[l_ac].inag002_desc          #160510-00019#9 mark
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
      #add-point:show段單身reference
#      CALL s_feature_description(g_inag_d[g_detail_idx].inag001,g_inag2_d[l_ac].inaj006) RETURNING g_success,g_inag2_d[l_ac].inaj006_desc #160510-00019#9 mark
#      DISPLAY BY NAME g_inag2_d[l_ac].inaj006_desc         #160510-00019#9 mark
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainq210.filter" >}
#應用 qs13 樣板自動產生(Version:1)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION ainq210_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define

   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:1)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON inag001,inag002,inag003,inag004,inag005,inag006,inag007,inag032,inag033,inag024, 
          inag025
                          FROM s_detail1[1].b_inag001,s_detail1[1].b_inag002,s_detail1[1].b_inag003, 
                              s_detail1[1].b_inag004,s_detail1[1].b_inag005,s_detail1[1].b_inag006,
                              s_detail1[1].b_inag007,s_detail1[1].b_inag032, 
                              s_detail1[1].b_inag033,s_detail1[1].b_inag024,s_detail1[1].b_inag025
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
                     DISPLAY ainq210_filter_parser('inag001') TO s_detail1[1].b_inag001
            DISPLAY ainq210_filter_parser('inag002') TO s_detail1[1].b_inag002
            DISPLAY ainq210_filter_parser('inag003') TO s_detail1[1].b_inag003
            DISPLAY ainq210_filter_parser('inag004') TO s_detail1[1].b_inag004
            DISPLAY ainq210_filter_parser('inag005') TO s_detail1[1].b_inag005
            DISPLAY ainq210_filter_parser('inag006') TO s_detail1[1].b_inag006
            DISPLAY ainq210_filter_parser('inag007') TO s_detail1[1].b_inag007
            DISPLAY ainq210_filter_parser('inag032') TO s_detail1[1].b_inag032
            DISPLAY ainq210_filter_parser('inag033') TO s_detail1[1].b_inag033
            DISPLAY ainq210_filter_parser('inag024') TO s_detail1[1].b_inag024
            DISPLAY ainq210_filter_parser('inag025') TO s_detail1[1].b_inag025
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

         #end add-point
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
 
   END DIALOG
 
 
 
   
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL ainq210_filter_show('inag001','b_inag001')
   CALL ainq210_filter_show('inag002','b_inag002')
   CALL ainq210_filter_show('inag003','b_inag003')
   CALL ainq210_filter_show('inag004','b_inag004')
   CALL ainq210_filter_show('inag005','b_inag005')
   CALL ainq210_filter_show('inag006','b_inag006')
   CALL ainq210_filter_show('inag007','b_inag007')
   CALL ainq210_filter_show('inag032','b_inag032')
   CALL ainq210_filter_show('inag033','b_inag033')
   CALL ainq210_filter_show('inag024','b_inag024')
   CALL ainq210_filter_show('inag025','b_inag025')
 
   CALL ainq210_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="ainq210.filter_parser" >}
#應用 qs14 樣板自動產生(Version:1)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION ainq210_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   
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
 
{<section id="ainq210.filter_show" >}
#應用 qs15 樣板自動產生(Version:1)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION ainq210_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = ainq210_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ainq210.other_function" readonly="Y" >}

PRIVATE FUNCTION ainq210_set_comp_visible()
   #161215-00001#1 add  --begin--
   IF g_master_flag = 'N' AND NOT cl_null(g_master_flag) THEN
      RETURN
   END IF
   #161215-00001#1 add  --end--
   
   CALL cl_set_comp_visible("b_inag002,b_inag002_desc,b_inag003,b_inag004,b_inag004_desc,b_inag005,b_inag005_desc,b_inag006,b_inag007,b_inag007_desc",TRUE)
   CALL cl_set_comp_visible("inaj006,inaj006_desc,inaj007,inaj008,inaj008_desc,inaj009,inaj009_desc,inaj010,inaj045,inaj045_desc",TRUE)

   IF g_master.l_inag002 = 'Y' THEN 
      CALL cl_set_comp_visible("inaj006,inaj006_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag002,b_inag002_desc",FALSE)      
   END IF
   IF g_master.l_inag003 = 'Y' THEN 
      CALL cl_set_comp_visible("inaj007",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag003",FALSE)      
   END IF 
   IF g_master.l_inag004 = 'Y' THEN 
      CALL cl_set_comp_visible("inaj008,inaj008_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag004,b_inag004_desc",FALSE)      
   END IF 
   IF g_master.l_inag005 = 'Y' THEN 
      CALL cl_set_comp_visible("inaj009,inaj009_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag005,b_inag005_desc",FALSE)      
   END IF 
   IF g_master.l_inag006 = 'Y' THEN 
      CALL cl_set_comp_visible("inaj010",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag006",FALSE)      
   END IF   
   IF g_master.l_inag007 = 'Y' THEN 
      CALL cl_set_comp_visible("inaj045,inaj045_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_inag007,b_inag007_desc",FALSE)      
   END IF    
   
   
   #161215-00001#1 add  --begin--
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("b_inag002,b_inag002_desc",FALSE)
      CALL cl_set_comp_visible("inaj006,inaj006_desc",FALSE)
   END IF     
   LET g_master_flag = 'N'     
   #161215-00001#1 add  --end--
END FUNCTION

 
{</section>}
 
