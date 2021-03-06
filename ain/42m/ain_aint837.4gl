#該程式未解開Section, 採用最新樣板產出!
{<section id="aint837.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-05-09 10:20:43), PR版次:0010(2016-07-15 14:53:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000100
#+ Filename...: aint837
#+ Description: 現有庫存初盤調整維護作業
#+ Creator....: 01534(2014-07-18 16:12:58)
#+ Modifier...: 01534 -SD/PR- 02159
 
{</section>}
 
{<section id="aint837.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#16   2016/04/08  BY 07900      重复错误讯息的修改
#160504-00019#1    2016/05/09  By lixh       參考單位盤點量不同者，也要顯示
#160705-00042#7    2016/07/15  By 02159      把gzcb002=固定寫死的作業代號改成g_prog,然後gzcb_t要多JOIN gzzz_t
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"  
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_inpd_m RECORD
       inpddocno LIKE inpd_t.inpddocno, 
   inpd008 LIKE inpd_t.inpd008, 
   inpddocno_desc LIKE type_t.chr80, 
   inpd009 LIKE inpd_t.inpd009, 
   inpdseq LIKE inpd_t.inpdseq, 
   inpdsite LIKE inpd_t.inpdsite, 
   inpdstus LIKE inpd_t.inpdstus, 
   inpd001 LIKE inpd_t.inpd001, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   inpd005 LIKE inpd_t.inpd005, 
   inpd005_desc LIKE type_t.chr80, 
   inpd006 LIKE inpd_t.inpd006, 
   inpd006_desc LIKE type_t.chr80, 
   inpd007 LIKE inpd_t.inpd007, 
   inpd002 LIKE inpd_t.inpd002, 
   inpd002_desc LIKE type_t.chr80, 
   inpd003 LIKE inpd_t.inpd003, 
   inpd004 LIKE inpd_t.inpd004, 
   inpd004_desc LIKE type_t.chr80, 
   inpd010 LIKE inpd_t.inpd010, 
   inpd010_desc LIKE type_t.chr80, 
   inpd012 LIKE inpd_t.inpd012, 
   inpd012_desc LIKE type_t.chr80, 
   inpd030 LIKE inpd_t.inpd030, 
   inpd031 LIKE inpd_t.inpd031, 
   inpd036 LIKE inpd_t.inpd036, 
   inpd037 LIKE inpd_t.inpd037, 
   adjust LIKE type_t.num20_6, 
   adjust_ref LIKE type_t.num20_6, 
   inpd014 LIKE inpd_t.inpd014, 
   inpd014_desc LIKE type_t.chr80, 
   inpd015 LIKE inpd_t.inpd015, 
   inpdownid LIKE inpd_t.inpdownid, 
   inpdownid_desc LIKE type_t.chr80, 
   inpdowndp LIKE inpd_t.inpdowndp, 
   inpdowndp_desc LIKE type_t.chr80, 
   inpdcrtid LIKE inpd_t.inpdcrtid, 
   inpdcrtid_desc LIKE type_t.chr80, 
   inpdcrtdp LIKE inpd_t.inpdcrtdp, 
   inpdcrtdp_desc LIKE type_t.chr80, 
   inpdcrtdt LIKE inpd_t.inpdcrtdt, 
   inpdmodid LIKE inpd_t.inpdmodid, 
   inpdmodid_desc LIKE type_t.chr80, 
   inpdmoddt LIKE inpd_t.inpdmoddt, 
   inpdcnfid LIKE inpd_t.inpdcnfid, 
   inpdcnfid_desc LIKE type_t.chr80, 
   inpdcnfdt LIKE inpd_t.inpdcnfdt, 
   inpdpstid LIKE inpd_t.inpdpstid, 
   inpdpstid_desc LIKE type_t.chr80, 
   inpdpstdt LIKE inpd_t.inpdpstdt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_inpddocno LIKE inpd_t.inpddocno,
      b_inpdseq LIKE inpd_t.inpdseq,
      b_inpdsite LIKE inpd_t.inpdsite,
      b_inpd009 LIKE inpd_t.inpd009,
      b_inpd008 LIKE inpd_t.inpd008,
      b_inpd001 LIKE inpd_t.inpd001,
   b_inpd001_desc LIKE type_t.chr80,
   b_inpd001_desc_desc LIKE type_t.chr80
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_acc                 LIKE gzcb_t.gzcb004
DEFINE g_flag                LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_inpd_m        type_g_inpd_m  #單頭變數宣告
DEFINE g_inpd_m_t      type_g_inpd_m  #單頭舊值宣告(系統還原用)
DEFINE g_inpd_m_o      type_g_inpd_m  #單頭舊值宣告(其他用途)
DEFINE g_inpd_m_mask_o type_g_inpd_m  #轉換遮罩前資料
DEFINE g_inpd_m_mask_n type_g_inpd_m  #轉換遮罩後資料
 
   DEFINE g_inpddocno_t LIKE inpd_t.inpddocno
DEFINE g_inpdseq_t LIKE inpd_t.inpdseq
DEFINE g_inpdsite_t LIKE inpd_t.inpdsite
 
   
 
   
 
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數                         
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization" 

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aint837.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT inpddocno,inpd008,'',inpd009,inpdseq,inpdsite,inpdstus,inpd001,'','', 
       inpd005,'',inpd006,'',inpd007,inpd002,'',inpd003,inpd004,'',inpd010,'',inpd012,'',inpd030,inpd031, 
       inpd036,inpd037,'','',inpd014,'',inpd015,inpdownid,'',inpdowndp,'',inpdcrtid,'',inpdcrtdp,'', 
       inpdcrtdt,inpdmodid,'',inpdmoddt,inpdcnfid,'',inpdcnfdt,inpdpstid,'',inpdpstdt", 
                      " FROM inpd_t",
                      " WHERE inpdent= ? AND inpdsite=? AND inpddocno=? AND inpdseq=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint837_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.inpddocno,t0.inpd008,t0.inpd009,t0.inpdseq,t0.inpdsite,t0.inpdstus, 
       t0.inpd001,t0.inpd005,t0.inpd006,t0.inpd007,t0.inpd002,t0.inpd003,t0.inpd004,t0.inpd010,t0.inpd012, 
       t0.inpd030,t0.inpd031,t0.inpd036,t0.inpd037,t0.inpd014,t0.inpd015,t0.inpdownid,t0.inpdowndp,t0.inpdcrtid, 
       t0.inpdcrtdp,t0.inpdcrtdt,t0.inpdmodid,t0.inpdmoddt,t0.inpdcnfid,t0.inpdcnfdt,t0.inpdpstid,t0.inpdpstdt, 
       t1.inayl003 ,t2.inab003 ,t3.imaal003 ,t4.oocal003 ,t5.oocal003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 , 
       t9.ooefl003 ,t10.ooag011 ,t11.ooag011 ,t12.ooag011",
               " FROM inpd_t t0",
                              " LEFT JOIN inayl_t t1 ON t1.inaylent="||g_enterprise||" AND t1.inayl001=t0.inpd005 AND t1.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t2 ON t2.inabent="||g_enterprise||" AND t2.inabsite=t0.inpdsite AND t2.inab001=t0.inpd005 AND t2.inab002=t0.inpd006  ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=t0.inpd004 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=t0.inpd010 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=t0.inpd012 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.inpdownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.inpdowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.inpdcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.inpdcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.inpdmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.inpdcnfid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.inpdpstid  ",
 
               " WHERE t0.inpdent = " ||g_enterprise|| " AND t0.inpdsite = ? AND t0.inpddocno = ? AND t0.inpdseq = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   LET g_sql = " SELECT UNIQUE t0.inpddocno,t0.inpd008,t0.inpd009,t0.inpdseq,t0.inpdsite,t0.inpdstus, 
       t0.inpd001,t0.inpd005,t0.inpd006,t0.inpd007,t0.inpd002,t0.inpd003,t0.inpd004,t0.inpd010,t0.inpd012, 
       t0.inpd030,t0.inpd031,t0.inpd036,t0.inpd037,t0.inpd014,t0.inpd015,t0.inpdownid,t0.inpdowndp,t0.inpdcrtid, 
       t0.inpdcrtdp,t0.inpdcrtdt,t0.inpdmodid,t0.inpdmoddt,t0.inpdcnfid,t0.inpdcnfdt,t0.inpdpstid,t0.inpdpstdt, 
       t1.inayl003 ,t2.inab003 ,t3.imaal003 ,t4.oocal003 ,t5.oocal003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 , 
       t9.ooefl003 ,t10.ooag011 ,t11.ooag011 ,t12.ooag011",
               " FROM inpd_t t0",
                              " LEFT JOIN inayl_t t1 ON t1.inaylent='"||g_enterprise||"' AND t1.inayl001=t0.inpd005 AND t1.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t2 ON t2.inabent='"||g_enterprise||"' AND t2.inabsite=t0.inpdsite AND t2.inab001=t0.inpd005 AND t2.inab002=t0.inpd006  ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=t0.inpd004 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent='"||g_enterprise||"' AND t4.oocal001=t0.inpd010 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=t0.inpd012 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=t0.inpdownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001=t0.inpdowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=t0.inpdcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent='"||g_enterprise||"' AND t9.ooefl001=t0.inpdcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent='"||g_enterprise||"' AND t10.ooag001=t0.inpdmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent='"||g_enterprise||"' AND t11.ooag001=t0.inpdcnfid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent='"||g_enterprise||"' AND t12.ooag001=t0.inpdpstid, ","inpa_t",
 
               " WHERE t0.inpdent = inpaent AND t0.inpdsite = inpasite AND t0.inpd008 = inpadocno AND (inpa009 = 'Y' OR inpa010 = 'Y') AND t0.inpdent = '" ||g_enterprise|| "' AND t0.inpdsite = ? AND t0.inpddocno = ? AND t0.inpdseq = ?"
   LET g_sql = cl_sql_add_mask(g_sql)
   #end add-point
   PREPARE aint837_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aint837 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aint837_init()   
 
      #進入選單 Menu (="N")
      CALL aint837_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aint837
      
   END IF 
   
   CLOSE aint837_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aint837.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aint837_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
  
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('inpdstus','13','N,Y,T,5,6,S,A,D,R,W,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_flag = 'N'
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint837'                            #160705-00042#7 160715 by sakura mark
   SELECT gzcb004 INTO g_acc FROM gzcb_t,gzzz_t WHERE gzcb001 = '24' AND gzcb002 = gzzz006 AND gzzz001 = g_prog   #160705-00042#7 160715 by sakura add  
   IF cl_ask_confirm('ain-00315') THEN
      LET g_flag = 'Y'
   END IF
   #add by lixh 20151105   
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN  
      CALL cl_set_comp_visible("inpd002,inpd002_desc",FALSE) 
   END IF  
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN     #參考單位
      CALL cl_set_comp_visible("inpd012,inpd012_desc,inpd031,inpd037",FALSE) 
   END IF   
   #add by lixh 20151105
   LET g_errshow = 1
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aint837_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aint837.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aint837_ui_dialog() 
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num10       #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10       #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_imaf071       LIKE imaf_t.imaf071
   DEFINE l_imaf081       LIKE imaf_t.imaf081
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0
 
   #若有外部參數查詢, 則直接顯示資料(隱藏查詢方案)
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL aint837_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL cl_set_act_visible("insert,delete,reproduce", FALSE)
   LET g_errshow = 1
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_inpd_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aint837_init()
      END IF
      
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL aint837_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aint837_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aint837_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aint837_set_act_visible()
               CALL aint837_set_act_no_visible()
               IF NOT (g_inpd_m.inpdsite IS NULL
                 OR g_inpd_m.inpddocno IS NULL
                 OR g_inpd_m.inpdseq IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " inpdent = " ||g_enterprise|| " AND",
                                     " inpdsite = '", g_inpd_m.inpdsite, "' "
                                     ," AND inpddocno = '", g_inpd_m.inpddocno, "' "
                                     ," AND inpdseq = '", g_inpd_m.inpdseq, "' "
 
                  #填到對應位置
                  CALL aint837_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL aint837_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aint837_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aint837_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aint837_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aint837_fetch("L")  
               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
            #主頁摺疊
            ON ACTION mainhidden   
               LET g_action_choice = "mainhidden"            
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               EXIT MENU
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               EXIT MENU
            
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            ON ACTION controls   
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden     
               END IF
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL aint837_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aint837_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint837_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aint837_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint837_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint837_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               &include "erp/ain/aint837_rep.4gl"
               #add-point:ON ACTION output.after name="menu2.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               &include "erp/ain/aint837_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu2.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aint837_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint837_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION batch_number
            LET g_action_choice="batch_number"
            IF cl_auth_chk_act("batch_number") THEN
               
               #add-point:ON ACTION batch_number name="menu2.batch_number"
               SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t
                WHERE imafent = g_enterprise
                  AND imaf001 = g_inpd_m.inpd001
                  AND imafsite = g_site   
               IF l_imaf071 <> '2' OR l_imaf081 <> '2' THEN                  
                  CALL aint830_01(g_site,g_inpd_m.inpddocno,g_inpd_m.inpdseq,'5',g_inpd_m.adjust)
                  LET INT_FLAG = 0
               END IF   
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_inpddocno
            LET g_action_choice="prog_inpddocno"
            IF cl_auth_chk_act("prog_inpddocno") THEN
               
               #add-point:ON ACTION prog_inpddocno name="menu2.prog_inpddocno"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint830'
               LET la_param.param[1] = g_inpd_m.inpddocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_inpd008
            LET g_action_choice="prog_inpd008"
            IF cl_auth_chk_act("prog_inpd008") THEN
               
               #add-point:ON ACTION prog_inpd008 name="menu2.prog_inpd008"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint820'
               LET la_param.param[1] = g_inpd_m.inpd008

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
            
            #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu2.bpm_status"
            
            #END add-point
 
 
 
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint837_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint837_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint837_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
            #主選單用ACTION
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL aint837_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
            #查詢方案用
            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL aint837_browser_fill(g_wc,"")
               END IF
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF 
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aint837_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               CALL aint837_browser_fill(g_wc,"")
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aint837_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aint837_set_act_visible()
               CALL aint837_set_act_no_visible()
               IF NOT (g_inpd_m.inpdsite IS NULL
                 OR g_inpd_m.inpddocno IS NULL
                 OR g_inpd_m.inpdseq IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " inpdent = " ||g_enterprise|| " AND",
                                     " inpdsite = '", g_inpd_m.inpdsite, "' "
                                     ," AND inpddocno = '", g_inpd_m.inpddocno, "' "
                                     ," AND inpdseq = '", g_inpd_m.inpdseq, "' "
 
                  #填到對應位置
                  CALL aint837_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aint837_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL aint837_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aint837_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aint837_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aint837_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aint837_fetch("L")  
               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
    
            #主頁摺疊
            ON ACTION mainhidden 
               LET g_action_choice = "mainhidden"                
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               #EXIT DIALOG
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               #EXIT DIALOG
         
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  #browser
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               END IF
         
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            ON ACTION controls   
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden     
               END IF
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL aint837_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aint837_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint837_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aint837_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint837_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint837_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ain/aint837_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ain/aint837_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aint837_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint837_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION batch_number
            LET g_action_choice="batch_number"
            IF cl_auth_chk_act("batch_number") THEN
               
               #add-point:ON ACTION batch_number name="menu.batch_number"
               SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t
                WHERE imafent = g_enterprise
                  AND imaf001 = g_inpd_m.inpd001
                  AND imafsite = g_site   
               IF l_imaf071 <> '2' OR l_imaf081 <> '2' THEN                  
                  CALL aint830_01(g_site,g_inpd_m.inpddocno,g_inpd_m.inpdseq,'5',g_inpd_m.adjust)
                  LET INT_FLAG = 0
               END IF   
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_inpddocno
            LET g_action_choice="prog_inpddocno"
            IF cl_auth_chk_act("prog_inpddocno") THEN
               
               #add-point:ON ACTION prog_inpddocno name="menu.prog_inpddocno"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint830'
               LET la_param.param[1] = g_site
               LET la_param.param[2] = g_inpd_m.inpddocno
               LET la_param.param[3] = g_inpd_m.inpdseq
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_inpd008
            LET g_action_choice="prog_inpd008"
            IF cl_auth_chk_act("prog_inpd008") THEN
               
               #add-point:ON ACTION prog_inpd008 name="menu.prog_inpd008"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint820'
               LET la_param.param[1] = g_inpd_m.inpd008

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
            
            #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint837_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint837_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint837_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
 
            #主選單用ACTION
            &include "main_menu_exit_dialog.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      
      #(ver:50) ---start---
      IF li_exit THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      #(ver:50) --- end ---
 
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aint837.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aint837_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "inpdsite,inpddocno,inpdseq"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM inpd_t ",
               "  ",
               "  ",
               " WHERE inpdent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("inpd_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   IF g_flag = 'Y' THEN     #差異量
      LET g_sql = " SELECT COUNT(*) FROM inpd_t LEFT OUTER JOIN inpa_t ON inpaent =inpdent AND inpasite = inpdsite  AND inpd008 = inpadocno",
                  "  ",
                  "  ",
#                  " WHERE inpdent = '" ||g_enterprise|| "' AND ((inpd030 <> inpd036) OR (NOT cl_null(inpd030) OR inpd036 IS NULL ) OR (NOT cl_null(inpd036) OR inpd030 IS NULL))  ", 
#                  " WHERE (inpa009 = 'Y' OR inpa010 = 'Y') AND inpdent = '" ||g_enterprise|| "' AND  inpd030 <> inpd036 ",
                  " WHERE (inpa009 = 'Y' OR inpa010 = 'Y') AND inpdent = '" ||g_enterprise|| "' AND ((inpd030 <> inpd036) OR (inpd030 IS NOT NULL AND inpd036 IS NULL ) OR (inpd036 IS NOT NULL AND inpd030 IS NULL)) ", #add by lixh 20150324
                  "   AND inpdsite = '",g_site,"'",
                  "   AND ",p_wc CLIPPED, cl_sql_add_filter("inpd_t")   
   ELSE
      LET g_sql = " SELECT COUNT(*) FROM inpd_t LEFT OUTER JOIN inpa_t ON inpaent =inpdent AND inpasite = inpdsite  AND inpd008 = inpadocno",
                  "  ",
                  "  ", 
                  " WHERE (inpa009 = 'Y' OR inpa010 = 'Y') AND inpdent = '" ||g_enterprise|| "' ",
                  "   AND inpdsite = '",g_site,"'",
                  "   AND ",p_wc CLIPPED, cl_sql_add_filter("inpd_t")     
   END IF
   #end add-point
                
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt
      FREE header_cnt_pre 
   END IF
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   LET g_error_show = 0
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_inpd_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.inpdstus,t0.inpddocno,t0.inpdseq,t0.inpdsite,t0.inpd009,t0.inpd008,t0.inpd001, 
       t1.imaal003 ,t2.imaal004",
               " FROM inpd_t t0 ",
               "  ",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.inpd001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.inpd001 AND t2.imaal002='"||g_dlang||"' ",
 
               " WHERE t0.inpdent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("inpd_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   LET g_sql = " SELECT t0.inpdstus,t0.inpddocno,t0.inpdseq,t0.inpdsite,t0.inpd009,t0.inpd008,t0.inpd001, 
       t1.imaal003 ,t2.imaal004",
               " FROM inpd_t t0 ",
               "  ",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=t0.inpd001 AND t1.imaal002='"||g_lang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=t0.inpd001 AND t2.imaal002='"||g_lang||"' ",",inpa_t",
 
               " WHERE t0.inpdent = inpaent AND t0.inpdsite = inpasite AND t0.inpd008 = inpadocno AND (inpa009 = 'Y' OR inpa010 = 'Y') AND t0.inpdent = '" ||g_enterprise|| "' AND  t0.inpdsite = '",g_site,"' AND ", ls_wc, cl_sql_add_filter("inpd_t")
               
   IF g_flag = 'Y' THEN
   #   LET g_sql = g_sql," AND inpd030 <> inpd036 "
   #   LET g_sql = g_sql," AND ((inpd030 <> inpd036) OR (inpd030 IS NOT NULL AND inpd036 IS NULL ) OR (inpd036 IS NOT NULL AND inpd030 IS NULL)) "  #add by lixh 20150324
      LET g_sql = g_sql," AND (((inpd030 <> inpd036) OR (inpd030 IS NOT NULL AND inpd036 IS NULL ) OR (inpd036 IS NOT NULL AND inpd030 IS NULL)) ",
                        "  OR ((inpd031 <> inpd037) OR (inpd031 IS NOT NULL AND inpd037 IS NULL ) OR (inpd037 IS NOT NULL AND inpd031 IS NULL))) "     #160504-00019#1  
   END IF
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"inpd_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_inpddocno,g_browser[g_cnt].b_inpdseq, 
          g_browser[g_cnt].b_inpdsite,g_browser[g_cnt].b_inpd009,g_browser[g_cnt].b_inpd008,g_browser[g_cnt].b_inpd001, 
          g_browser[g_cnt].b_inpd001_desc,g_browser[g_cnt].b_inpd001_desc_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
         
         #遮罩相關處理
         CALL aint837_browser_mask()
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "T"
            LET g_browser[g_cnt].b_statepic = "stus/16/org_approved.png"
         WHEN "5"
            LET g_browser[g_cnt].b_statepic = "stus/16/fconfirmed.png"
         WHEN "6"
            LET g_browser[g_cnt].b_statepic = "stus/16/dconfirmed.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_rec THEN
            EXIT FOREACH
         END IF
      END FOREACH
 
      FREE browse_pre
 
   END IF
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_inpdsite) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   CALL cl_set_act_visible("insert,delete,reproduce", FALSE)
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint837.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint837_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_inpd_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON inpddocno,inpd008,inpdseq,inpdsite,inpdstus,inpd001,inpd005,inpd006, 
          inpd007,inpd002,inpd003,inpd004,inpd010,inpd012,inpd030,inpd031,inpd036,inpd037,adjust,adjust_ref, 
          inpd014,inpd015,inpdownid,inpdowndp,inpdcrtid,inpdcrtdp,inpdcrtdt,inpdmodid,inpdmoddt,inpdcnfid, 
          inpdcnfdt,inpdpstid,inpdpstdt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<inpdcrtdt>>----
         AFTER FIELD inpdcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<inpdmoddt>>----
         AFTER FIELD inpdmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inpdcnfdt>>----
         AFTER FIELD inpdcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inpdpstdt>>----
         AFTER FIELD inpdpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.inpddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpddocno
            #add-point:ON ACTION controlp INFIELD inpddocno name="construct.c.inpddocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inpddocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpddocno  #顯示到畫面上
            NEXT FIELD inpddocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpddocno
            #add-point:BEFORE FIELD inpddocno name="construct.b.inpddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpddocno
            
            #add-point:AFTER FIELD inpddocno name="construct.a.inpddocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd008
            #add-point:ON ACTION controlp INFIELD inpd008 name="construct.c.inpd008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inpadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpd008  #顯示到畫面上
            NEXT FIELD inpd008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd008
            #add-point:BEFORE FIELD inpd008 name="construct.b.inpd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd008
            
            #add-point:AFTER FIELD inpd008 name="construct.a.inpd008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdseq
            #add-point:BEFORE FIELD inpdseq name="construct.b.inpdseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdseq
            
            #add-point:AFTER FIELD inpdseq name="construct.a.inpdseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdseq
            #add-point:ON ACTION controlp INFIELD inpdseq name="construct.c.inpdseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdsite
            #add-point:BEFORE FIELD inpdsite name="construct.b.inpdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdsite
            
            #add-point:AFTER FIELD inpdsite name="construct.a.inpdsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdsite
            #add-point:ON ACTION controlp INFIELD inpdsite name="construct.c.inpdsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdstus
            #add-point:BEFORE FIELD inpdstus name="construct.b.inpdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdstus
            
            #add-point:AFTER FIELD inpdstus name="construct.a.inpdstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdstus
            #add-point:ON ACTION controlp INFIELD inpdstus name="construct.c.inpdstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inpd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd001
            #add-point:ON ACTION controlp INFIELD inpd001 name="construct.c.inpd001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpd001  #顯示到畫面上
            NEXT FIELD inpd001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd001
            #add-point:BEFORE FIELD inpd001 name="construct.b.inpd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd001
            
            #add-point:AFTER FIELD inpd001 name="construct.a.inpd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd005
            #add-point:ON ACTION controlp INFIELD inpd005 name="construct.c.inpd005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpd005  #顯示到畫面上
            NEXT FIELD inpd005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd005
            #add-point:BEFORE FIELD inpd005 name="construct.b.inpd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd005
            
            #add-point:AFTER FIELD inpd005 name="construct.a.inpd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd006
            #add-point:ON ACTION controlp INFIELD inpd006 name="construct.c.inpd006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpd006  #顯示到畫面上
            NEXT FIELD inpd006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd006
            #add-point:BEFORE FIELD inpd006 name="construct.b.inpd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd006
            
            #add-point:AFTER FIELD inpd006 name="construct.a.inpd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd007
            #add-point:ON ACTION controlp INFIELD inpd007 name="construct.c.inpd007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpd007  #顯示到畫面上
            NEXT FIELD inpd007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd007
            #add-point:BEFORE FIELD inpd007 name="construct.b.inpd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd007
            
            #add-point:AFTER FIELD inpd007 name="construct.a.inpd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd002
            #add-point:ON ACTION controlp INFIELD inpd002 name="construct.c.inpd002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inpd002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpd002  #顯示到畫面上
            NEXT FIELD inpd002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd002
            #add-point:BEFORE FIELD inpd002 name="construct.b.inpd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd002
            
            #add-point:AFTER FIELD inpd002 name="construct.a.inpd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd003
            #add-point:ON ACTION controlp INFIELD inpd003 name="construct.c.inpd003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inpd003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpd003  #顯示到畫面上
            NEXT FIELD inpd003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd003
            #add-point:BEFORE FIELD inpd003 name="construct.b.inpd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd003
            
            #add-point:AFTER FIELD inpd003 name="construct.a.inpd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd004
            #add-point:ON ACTION controlp INFIELD inpd004 name="construct.c.inpd004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpd004  #顯示到畫面上
            NEXT FIELD inpd004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd004
            #add-point:BEFORE FIELD inpd004 name="construct.b.inpd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd004
            
            #add-point:AFTER FIELD inpd004 name="construct.a.inpd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd010
            #add-point:ON ACTION controlp INFIELD inpd010 name="construct.c.inpd010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpd010  #顯示到畫面上
            NEXT FIELD inpd010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd010
            #add-point:BEFORE FIELD inpd010 name="construct.b.inpd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd010
            
            #add-point:AFTER FIELD inpd010 name="construct.a.inpd010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd012
            #add-point:ON ACTION controlp INFIELD inpd012 name="construct.c.inpd012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpd012  #顯示到畫面上
            NEXT FIELD inpd012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd012
            #add-point:BEFORE FIELD inpd012 name="construct.b.inpd012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd012
            
            #add-point:AFTER FIELD inpd012 name="construct.a.inpd012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd030
            #add-point:BEFORE FIELD inpd030 name="construct.b.inpd030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd030
            
            #add-point:AFTER FIELD inpd030 name="construct.a.inpd030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd030
            #add-point:ON ACTION controlp INFIELD inpd030 name="construct.c.inpd030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd031
            #add-point:BEFORE FIELD inpd031 name="construct.b.inpd031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd031
            
            #add-point:AFTER FIELD inpd031 name="construct.a.inpd031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd031
            #add-point:ON ACTION controlp INFIELD inpd031 name="construct.c.inpd031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd036
            #add-point:BEFORE FIELD inpd036 name="construct.b.inpd036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd036
            
            #add-point:AFTER FIELD inpd036 name="construct.a.inpd036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd036
            #add-point:ON ACTION controlp INFIELD inpd036 name="construct.c.inpd036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd037
            #add-point:BEFORE FIELD inpd037 name="construct.b.inpd037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd037
            
            #add-point:AFTER FIELD inpd037 name="construct.a.inpd037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd037
            #add-point:ON ACTION controlp INFIELD inpd037 name="construct.c.inpd037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD adjust
            #add-point:BEFORE FIELD adjust name="construct.b.adjust"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD adjust
            
            #add-point:AFTER FIELD adjust name="construct.a.adjust"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.adjust
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD adjust
            #add-point:ON ACTION controlp INFIELD adjust name="construct.c.adjust"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD adjust_ref
            #add-point:BEFORE FIELD adjust_ref name="construct.b.adjust_ref"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD adjust_ref
            
            #add-point:AFTER FIELD adjust_ref name="construct.a.adjust_ref"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.adjust_ref
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD adjust_ref
            #add-point:ON ACTION controlp INFIELD adjust_ref name="construct.c.adjust_ref"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inpd014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd014
            #add-point:ON ACTION controlp INFIELD inpd014 name="construct.c.inpd014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpd014  #顯示到畫面上
            NEXT FIELD inpd014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd014
            #add-point:BEFORE FIELD inpd014 name="construct.b.inpd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd014
            
            #add-point:AFTER FIELD inpd014 name="construct.a.inpd014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd015
            #add-point:BEFORE FIELD inpd015 name="construct.b.inpd015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd015
            
            #add-point:AFTER FIELD inpd015 name="construct.a.inpd015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpd015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd015
            #add-point:ON ACTION controlp INFIELD inpd015 name="construct.c.inpd015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inpdownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdownid
            #add-point:ON ACTION controlp INFIELD inpdownid name="construct.c.inpdownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpdownid  #顯示到畫面上
            NEXT FIELD inpdownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdownid
            #add-point:BEFORE FIELD inpdownid name="construct.b.inpdownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdownid
            
            #add-point:AFTER FIELD inpdownid name="construct.a.inpdownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpdowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdowndp
            #add-point:ON ACTION controlp INFIELD inpdowndp name="construct.c.inpdowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpdowndp  #顯示到畫面上
            NEXT FIELD inpdowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdowndp
            #add-point:BEFORE FIELD inpdowndp name="construct.b.inpdowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdowndp
            
            #add-point:AFTER FIELD inpdowndp name="construct.a.inpdowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpdcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdcrtid
            #add-point:ON ACTION controlp INFIELD inpdcrtid name="construct.c.inpdcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpdcrtid  #顯示到畫面上
            NEXT FIELD inpdcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdcrtid
            #add-point:BEFORE FIELD inpdcrtid name="construct.b.inpdcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdcrtid
            
            #add-point:AFTER FIELD inpdcrtid name="construct.a.inpdcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inpdcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdcrtdp
            #add-point:ON ACTION controlp INFIELD inpdcrtdp name="construct.c.inpdcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpdcrtdp  #顯示到畫面上
            NEXT FIELD inpdcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdcrtdp
            #add-point:BEFORE FIELD inpdcrtdp name="construct.b.inpdcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdcrtdp
            
            #add-point:AFTER FIELD inpdcrtdp name="construct.a.inpdcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdcrtdt
            #add-point:BEFORE FIELD inpdcrtdt name="construct.b.inpdcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inpdmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdmodid
            #add-point:ON ACTION controlp INFIELD inpdmodid name="construct.c.inpdmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpdmodid  #顯示到畫面上
            NEXT FIELD inpdmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdmodid
            #add-point:BEFORE FIELD inpdmodid name="construct.b.inpdmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdmodid
            
            #add-point:AFTER FIELD inpdmodid name="construct.a.inpdmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdmoddt
            #add-point:BEFORE FIELD inpdmoddt name="construct.b.inpdmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inpdcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdcnfid
            #add-point:ON ACTION controlp INFIELD inpdcnfid name="construct.c.inpdcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpdcnfid  #顯示到畫面上
            NEXT FIELD inpdcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdcnfid
            #add-point:BEFORE FIELD inpdcnfid name="construct.b.inpdcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdcnfid
            
            #add-point:AFTER FIELD inpdcnfid name="construct.a.inpdcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdcnfdt
            #add-point:BEFORE FIELD inpdcnfdt name="construct.b.inpdcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inpdpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdpstid
            #add-point:ON ACTION controlp INFIELD inpdpstid name="construct.c.inpdpstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpdpstid  #顯示到畫面上
            NEXT FIELD inpdpstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdpstid
            #add-point:BEFORE FIELD inpdpstid name="construct.b.inpdpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdpstid
            
            #add-point:AFTER FIELD inpdpstid name="construct.a.inpdpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdpstdt
            #add-point:BEFORE FIELD inpdpstdt name="construct.b.inpdpstdt"
            
            #END add-point
 
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="aint837.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aint837_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON inpddocno,inpdseq,inpdsite,inpd009,inpd008,inpd001
                          FROM s_browse[1].b_inpddocno,s_browse[1].b_inpdseq,s_browse[1].b_inpdsite, 
                              s_browse[1].b_inpd009,s_browse[1].b_inpd008,s_browse[1].b_inpd001
 
         BEFORE CONSTRUCT
               DISPLAY aint837_filter_parser('inpddocno') TO s_browse[1].b_inpddocno
            DISPLAY aint837_filter_parser('inpdseq') TO s_browse[1].b_inpdseq
            DISPLAY aint837_filter_parser('inpdsite') TO s_browse[1].b_inpdsite
            DISPLAY aint837_filter_parser('inpd009') TO s_browse[1].b_inpd009
            DISPLAY aint837_filter_parser('inpd008') TO s_browse[1].b_inpd008
            DISPLAY aint837_filter_parser('inpd001') TO s_browse[1].b_inpd001
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
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
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL aint837_filter_show('inpddocno')
   CALL aint837_filter_show('inpdseq')
   CALL aint837_filter_show('inpdsite')
   CALL aint837_filter_show('inpd009')
   CALL aint837_filter_show('inpd008')
   CALL aint837_filter_show('inpd001')
 
END FUNCTION
 
{</section>}
 
{<section id="aint837.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aint837_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="aint837.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aint837_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aint837_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aint837.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aint837_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_inpd_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aint837_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aint837_browser_fill(g_wc,"F")
      CALL aint837_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aint837_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL aint837_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aint837.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aint837_fetch(p_fl)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   CALL cl_set_act_visible("insert,delete,reproduce", FALSE)
   #end add-point  
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
 
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF
   
   
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength() 
   END IF
   
   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_inpd_m.inpdsite = g_browser[g_current_idx].b_inpdsite
   LET g_inpd_m.inpddocno = g_browser[g_current_idx].b_inpddocno
   LET g_inpd_m.inpdseq = g_browser[g_current_idx].b_inpdseq
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aint837_master_referesh USING g_inpd_m.inpdsite,g_inpd_m.inpddocno,g_inpd_m.inpdseq INTO g_inpd_m.inpddocno, 
       g_inpd_m.inpd008,g_inpd_m.inpd009,g_inpd_m.inpdseq,g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001, 
       g_inpd_m.inpd005,g_inpd_m.inpd006,g_inpd_m.inpd007,g_inpd_m.inpd002,g_inpd_m.inpd003,g_inpd_m.inpd004, 
       g_inpd_m.inpd010,g_inpd_m.inpd012,g_inpd_m.inpd030,g_inpd_m.inpd031,g_inpd_m.inpd036,g_inpd_m.inpd037, 
       g_inpd_m.inpd014,g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdowndp,g_inpd_m.inpdcrtid,g_inpd_m.inpdcrtdp, 
       g_inpd_m.inpdcrtdt,g_inpd_m.inpdmodid,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid,g_inpd_m.inpdcnfdt, 
       g_inpd_m.inpdpstid,g_inpd_m.inpdpstdt,g_inpd_m.inpd005_desc,g_inpd_m.inpd006_desc,g_inpd_m.inpd004_desc, 
       g_inpd_m.inpd010_desc,g_inpd_m.inpd012_desc,g_inpd_m.inpdownid_desc,g_inpd_m.inpdowndp_desc,g_inpd_m.inpdcrtid_desc, 
       g_inpd_m.inpdcrtdp_desc,g_inpd_m.inpdmodid_desc,g_inpd_m.inpdcnfid_desc,g_inpd_m.inpdpstid_desc 
 
   
   #遮罩相關處理
   LET g_inpd_m_mask_o.* =  g_inpd_m.*
   CALL aint837_inpd_t_mask()
   LET g_inpd_m_mask_n.* =  g_inpd_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aint837_set_act_visible()
   CALL aint837_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("insert,delete,reproduce", FALSE)
   IF g_inpddocno_t <> g_inpd_m.inpddocno OR g_inpdseq_t <> g_inpd_m.inpdseq THEN
      LET g_inpd_m.adjust = ''
      LET g_inpd_m.adjust_ref = ''
   END IF
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_inpd_m_t.* = g_inpd_m.*
   LET g_inpd_m_o.* = g_inpd_m.*
   
   LET g_data_owner = g_inpd_m.inpdownid      
   LET g_data_dept  = g_inpd_m.inpdowndp
   
   #重新顯示
   CALL aint837_show()
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint837.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint837_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_inpd_m.* TO NULL             #DEFAULT 設定
   LET g_inpdsite_t = NULL
   LET g_inpddocno_t = NULL
   LET g_inpdseq_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inpd_m.inpdownid = g_user
      LET g_inpd_m.inpdowndp = g_dept
      LET g_inpd_m.inpdcrtid = g_user
      LET g_inpd_m.inpdcrtdp = g_dept 
      LET g_inpd_m.inpdcrtdt = cl_get_current()
      LET g_inpd_m.inpdmodid = g_user
      LET g_inpd_m.inpdmoddt = cl_get_current()
      LET g_inpd_m.inpdstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_inpd_m.inpd009 = "Y"
 
 
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inpd_m.inpdstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "T"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/org_approved.png")
         WHEN "5"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/fconfirmed.png")
         WHEN "6"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/dconfirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL aint837_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_inpd_m.* TO NULL
         CALL aint837_show()
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aint837_set_act_visible()
   CALL aint837_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_inpdsite_t = g_inpd_m.inpdsite
   LET g_inpddocno_t = g_inpd_m.inpddocno
   LET g_inpdseq_t = g_inpd_m.inpdseq
 
   
   #組合新增資料的條件
   LET g_add_browse = " inpdent = " ||g_enterprise|| " AND",
                      " inpdsite = '", g_inpd_m.inpdsite, "' "
                      ," AND inpddocno = '", g_inpd_m.inpddocno, "' "
                      ," AND inpdseq = '", g_inpd_m.inpdseq, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint837_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aint837_master_referesh USING g_inpd_m.inpdsite,g_inpd_m.inpddocno,g_inpd_m.inpdseq INTO g_inpd_m.inpddocno, 
       g_inpd_m.inpd008,g_inpd_m.inpd009,g_inpd_m.inpdseq,g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001, 
       g_inpd_m.inpd005,g_inpd_m.inpd006,g_inpd_m.inpd007,g_inpd_m.inpd002,g_inpd_m.inpd003,g_inpd_m.inpd004, 
       g_inpd_m.inpd010,g_inpd_m.inpd012,g_inpd_m.inpd030,g_inpd_m.inpd031,g_inpd_m.inpd036,g_inpd_m.inpd037, 
       g_inpd_m.inpd014,g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdowndp,g_inpd_m.inpdcrtid,g_inpd_m.inpdcrtdp, 
       g_inpd_m.inpdcrtdt,g_inpd_m.inpdmodid,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid,g_inpd_m.inpdcnfdt, 
       g_inpd_m.inpdpstid,g_inpd_m.inpdpstdt,g_inpd_m.inpd005_desc,g_inpd_m.inpd006_desc,g_inpd_m.inpd004_desc, 
       g_inpd_m.inpd010_desc,g_inpd_m.inpd012_desc,g_inpd_m.inpdownid_desc,g_inpd_m.inpdowndp_desc,g_inpd_m.inpdcrtid_desc, 
       g_inpd_m.inpdcrtdp_desc,g_inpd_m.inpdmodid_desc,g_inpd_m.inpdcnfid_desc,g_inpd_m.inpdpstid_desc 
 
   
   
   #遮罩相關處理
   LET g_inpd_m_mask_o.* =  g_inpd_m.*
   CALL aint837_inpd_t_mask()
   LET g_inpd_m_mask_n.* =  g_inpd_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inpd_m.inpddocno,g_inpd_m.inpd008,g_inpd_m.inpddocno_desc,g_inpd_m.inpd009,g_inpd_m.inpdseq, 
       g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001,g_inpd_m.imaal003,g_inpd_m.imaal004,g_inpd_m.inpd005, 
       g_inpd_m.inpd005_desc,g_inpd_m.inpd006,g_inpd_m.inpd006_desc,g_inpd_m.inpd007,g_inpd_m.inpd002, 
       g_inpd_m.inpd002_desc,g_inpd_m.inpd003,g_inpd_m.inpd004,g_inpd_m.inpd004_desc,g_inpd_m.inpd010, 
       g_inpd_m.inpd010_desc,g_inpd_m.inpd012,g_inpd_m.inpd012_desc,g_inpd_m.inpd030,g_inpd_m.inpd031, 
       g_inpd_m.inpd036,g_inpd_m.inpd037,g_inpd_m.adjust,g_inpd_m.adjust_ref,g_inpd_m.inpd014,g_inpd_m.inpd014_desc, 
       g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdownid_desc,g_inpd_m.inpdowndp,g_inpd_m.inpdowndp_desc, 
       g_inpd_m.inpdcrtid,g_inpd_m.inpdcrtid_desc,g_inpd_m.inpdcrtdp,g_inpd_m.inpdcrtdp_desc,g_inpd_m.inpdcrtdt, 
       g_inpd_m.inpdmodid,g_inpd_m.inpdmodid_desc,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid,g_inpd_m.inpdcnfid_desc, 
       g_inpd_m.inpdcnfdt,g_inpd_m.inpdpstid,g_inpd_m.inpdpstid_desc,g_inpd_m.inpdpstdt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_inpd_m.inpdownid      
   LET g_data_dept  = g_inpd_m.inpdowndp
 
   #功能已完成,通報訊息中心
   CALL aint837_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aint837.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint837_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE  l_inpdstus    LIKE inpd_t.inpdstus
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_inpd_m.inpdsite IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_inpdsite_t = g_inpd_m.inpdsite
   LET g_inpddocno_t = g_inpd_m.inpddocno
   LET g_inpdseq_t = g_inpd_m.inpdseq
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aint837_cl USING g_enterprise,g_inpd_m.inpdsite,g_inpd_m.inpddocno,g_inpd_m.inpdseq
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint837_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aint837_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint837_master_referesh USING g_inpd_m.inpdsite,g_inpd_m.inpddocno,g_inpd_m.inpdseq INTO g_inpd_m.inpddocno, 
       g_inpd_m.inpd008,g_inpd_m.inpd009,g_inpd_m.inpdseq,g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001, 
       g_inpd_m.inpd005,g_inpd_m.inpd006,g_inpd_m.inpd007,g_inpd_m.inpd002,g_inpd_m.inpd003,g_inpd_m.inpd004, 
       g_inpd_m.inpd010,g_inpd_m.inpd012,g_inpd_m.inpd030,g_inpd_m.inpd031,g_inpd_m.inpd036,g_inpd_m.inpd037, 
       g_inpd_m.inpd014,g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdowndp,g_inpd_m.inpdcrtid,g_inpd_m.inpdcrtdp, 
       g_inpd_m.inpdcrtdt,g_inpd_m.inpdmodid,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid,g_inpd_m.inpdcnfdt, 
       g_inpd_m.inpdpstid,g_inpd_m.inpdpstdt,g_inpd_m.inpd005_desc,g_inpd_m.inpd006_desc,g_inpd_m.inpd004_desc, 
       g_inpd_m.inpd010_desc,g_inpd_m.inpd012_desc,g_inpd_m.inpdownid_desc,g_inpd_m.inpdowndp_desc,g_inpd_m.inpdcrtid_desc, 
       g_inpd_m.inpdcrtdp_desc,g_inpd_m.inpdmodid_desc,g_inpd_m.inpdcnfid_desc,g_inpd_m.inpdpstid_desc 
 
 
   #檢查是否允許此動作
   IF NOT aint837_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_inpd_m_mask_o.* =  g_inpd_m.*
   CALL aint837_inpd_t_mask()
   LET g_inpd_m_mask_n.* =  g_inpd_m.*
   
   
 
   #顯示資料
   CALL aint837_show()
   
   WHILE TRUE
      LET g_inpd_m.inpdsite = g_inpdsite_t
      LET g_inpd_m.inpddocno = g_inpddocno_t
      LET g_inpd_m.inpdseq = g_inpdseq_t
 
      
      #寫入修改者/修改日期資訊
      LET g_inpd_m.inpdmodid = g_user 
LET g_inpd_m.inpdmoddt = cl_get_current()
LET g_inpd_m.inpdmodid_desc = cl_get_username(g_inpd_m.inpdmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      SELECT inpdstus INTO l_inpdstus FROM inpd_t
       WHERE inpdent = g_enterprise
         AND inpdsite = g_inpd_m.inpdsite
         AND inpddocno = g_inpd_m.inpddocno
         AND inpdseq = g_inpd_m.inpdseq
      IF l_inpdstus <> 'N' THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_inpd_m.inpddocno
         LET g_errparam.code   = 'ain-00385' 
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         CLOSE aint837_cl     
         CALL s_transaction_end('N','0')
         RETURN
      END IF         
      #end add-point
 
      #資料輸入
      CALL aint837_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_inpd_m.* = g_inpd_m_t.*
         CALL aint837_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE inpd_t SET (inpdmodid,inpdmoddt) = (g_inpd_m.inpdmodid,g_inpd_m.inpdmoddt)
       WHERE inpdent = g_enterprise AND inpdsite = g_inpdsite_t
         AND inpddocno = g_inpddocno_t
         AND inpdseq = g_inpdseq_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aint837_set_act_visible()
   CALL aint837_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " inpdent = " ||g_enterprise|| " AND",
                      " inpdsite = '", g_inpd_m.inpdsite, "' "
                      ," AND inpddocno = '", g_inpd_m.inpddocno, "' "
                      ," AND inpdseq = '", g_inpd_m.inpdseq, "' "
 
   #填到對應位置
   CALL aint837_browser_fill(g_wc,"")
 
   CLOSE aint837_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint837_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aint837.input" >}
#+ 資料輸入
PRIVATE FUNCTION aint837_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_flag1         LIKE type_t.num5
   DEFINE l_inpa009       LIKE inpa_t.inpa009
   DEFINE l_inpa010       LIKE inpa_t.inpa010
   DEFINE l_ooac002       LIKE ooac_t.ooac002
   DEFINE l_ooac004       LIKE ooac_t.ooac004 
   DEFINE l_imaf071       LIKE imaf_t.imaf071
   DEFINE l_imaf081       LIKE imaf_t.imaf081    
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_inpd_m.inpddocno,g_inpd_m.inpd008,g_inpd_m.inpddocno_desc,g_inpd_m.inpd009,g_inpd_m.inpdseq, 
       g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001,g_inpd_m.imaal003,g_inpd_m.imaal004,g_inpd_m.inpd005, 
       g_inpd_m.inpd005_desc,g_inpd_m.inpd006,g_inpd_m.inpd006_desc,g_inpd_m.inpd007,g_inpd_m.inpd002, 
       g_inpd_m.inpd002_desc,g_inpd_m.inpd003,g_inpd_m.inpd004,g_inpd_m.inpd004_desc,g_inpd_m.inpd010, 
       g_inpd_m.inpd010_desc,g_inpd_m.inpd012,g_inpd_m.inpd012_desc,g_inpd_m.inpd030,g_inpd_m.inpd031, 
       g_inpd_m.inpd036,g_inpd_m.inpd037,g_inpd_m.adjust,g_inpd_m.adjust_ref,g_inpd_m.inpd014,g_inpd_m.inpd014_desc, 
       g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdownid_desc,g_inpd_m.inpdowndp,g_inpd_m.inpdowndp_desc, 
       g_inpd_m.inpdcrtid,g_inpd_m.inpdcrtid_desc,g_inpd_m.inpdcrtdp,g_inpd_m.inpdcrtdp_desc,g_inpd_m.inpdcrtdt, 
       g_inpd_m.inpdmodid,g_inpd_m.inpdmodid_desc,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid,g_inpd_m.inpdcnfid_desc, 
       g_inpd_m.inpdcnfdt,g_inpd_m.inpdpstid,g_inpd_m.inpdpstid_desc,g_inpd_m.inpdpstdt
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL aint837_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aint837_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_inpd_m.inpddocno,g_inpd_m.inpd008,g_inpd_m.inpdseq,g_inpd_m.inpdsite,g_inpd_m.inpdstus, 
          g_inpd_m.inpd001,g_inpd_m.inpd005,g_inpd_m.inpd006,g_inpd_m.inpd007,g_inpd_m.inpd002,g_inpd_m.inpd003, 
          g_inpd_m.inpd004,g_inpd_m.inpd010,g_inpd_m.inpd012,g_inpd_m.inpd030,g_inpd_m.inpd031,g_inpd_m.inpd036, 
          g_inpd_m.inpd037,g_inpd_m.adjust,g_inpd_m.adjust_ref,g_inpd_m.inpd014,g_inpd_m.inpd015 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpddocno
            
            #add-point:AFTER FIELD inpddocno name="input.a.inpddocno"

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_inpd_m.inpdsite) AND NOT cl_null(g_inpd_m.inpddocno) AND NOT cl_null(g_inpd_m.inpdseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inpd_m.inpdsite != g_inpdsite_t  OR g_inpd_m.inpddocno != g_inpddocno_t  OR g_inpd_m.inpdseq != g_inpdseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inpd_t WHERE "||"inpdent = '" ||g_enterprise|| "' AND "||"inpdsite = '"||g_inpd_m.inpdsite ||"' AND "|| "inpddocno = '"||g_inpd_m.inpddocno ||"' AND "|| "inpdseq = '"||g_inpd_m.inpdseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpddocno
            #add-point:BEFORE FIELD inpddocno name="input.b.inpddocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpddocno
            #add-point:ON CHANGE inpddocno name="input.g.inpddocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd008
            #add-point:BEFORE FIELD inpd008 name="input.b.inpd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd008
            
            #add-point:AFTER FIELD inpd008 name="input.a.inpd008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd008
            #add-point:ON CHANGE inpd008 name="input.g.inpd008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdseq
            #add-point:BEFORE FIELD inpdseq name="input.b.inpdseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdseq
            
            #add-point:AFTER FIELD inpdseq name="input.a.inpdseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_inpd_m.inpdsite) AND NOT cl_null(g_inpd_m.inpddocno) AND NOT cl_null(g_inpd_m.inpdseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inpd_m.inpdsite != g_inpdsite_t  OR g_inpd_m.inpddocno != g_inpddocno_t  OR g_inpd_m.inpdseq != g_inpdseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inpd_t WHERE "||"inpdent = '" ||g_enterprise|| "' AND "||"inpdsite = '"||g_inpd_m.inpdsite ||"' AND "|| "inpddocno = '"||g_inpd_m.inpddocno ||"' AND "|| "inpdseq = '"||g_inpd_m.inpdseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpdseq
            #add-point:ON CHANGE inpdseq name="input.g.inpdseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdsite
            #add-point:BEFORE FIELD inpdsite name="input.b.inpdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdsite
            
            #add-point:AFTER FIELD inpdsite name="input.a.inpdsite"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_inpd_m.inpdsite) AND NOT cl_null(g_inpd_m.inpddocno) AND NOT cl_null(g_inpd_m.inpdseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inpd_m.inpdsite != g_inpdsite_t  OR g_inpd_m.inpddocno != g_inpddocno_t  OR g_inpd_m.inpdseq != g_inpdseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inpd_t WHERE "||"inpdent = '" ||g_enterprise|| "' AND "||"inpdsite = '"||g_inpd_m.inpdsite ||"' AND "|| "inpddocno = '"||g_inpd_m.inpddocno ||"' AND "|| "inpdseq = '"||g_inpd_m.inpdseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpdsite
            #add-point:ON CHANGE inpdsite name="input.g.inpdsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpdstus
            #add-point:BEFORE FIELD inpdstus name="input.b.inpdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpdstus
            
            #add-point:AFTER FIELD inpdstus name="input.a.inpdstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpdstus
            #add-point:ON CHANGE inpdstus name="input.g.inpdstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd001
            
            #add-point:AFTER FIELD inpd001 name="input.a.inpd001"
            IF NOT cl_null(g_inpd_m.inpd001) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

                #160318-00025#16  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               LET g_chkparam.err_str[2] ="aim-00121:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#16  by 07900 --add-end 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_imaf001_7") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd001
            #add-point:BEFORE FIELD inpd001 name="input.b.inpd001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd001
            #add-point:ON CHANGE inpd001 name="input.g.inpd001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd005
            
            #add-point:AFTER FIELD inpd005 name="input.a.inpd005"
            IF NOT cl_null(g_inpd_m.inpd005) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
#               LET g_chkparam.arg2 = '參數2'
                 #160318-00025#16  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#16  by 07900 --add-end 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_inaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpd_m.inpdsite
            LET g_ref_fields[2] = g_inpd_m.inpd005
            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? ","") RETURNING g_rtn_fields
            LET g_inpd_m.inpd005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpd_m.inpd005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd005
            #add-point:BEFORE FIELD inpd005 name="input.b.inpd005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd005
            #add-point:ON CHANGE inpd005 name="input.g.inpd005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd006
            
            #add-point:AFTER FIELD inpd006 name="input.a.inpd006"
            IF NOT cl_null(g_inpd_m.inpd006) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
#               LET g_chkparam.arg2 = '參數2'
#               LET g_chkparam.arg3 = 
               #160318-00025#16  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
               #160318-00025#16  by 07900 --add-end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_inab002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpd_m.inpdsite
            LET g_ref_fields[2] = g_inpd_m.inpd005 
            LET g_ref_fields[3] = g_inpd_m.inpd006
            CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite=? AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
            LET g_inpd_m.inpd006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpd_m.inpd006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd006
            #add-point:BEFORE FIELD inpd006 name="input.b.inpd006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd006
            #add-point:ON CHANGE inpd006 name="input.g.inpd006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd007
            
            #add-point:AFTER FIELD inpd007 name="input.a.inpd007"
            IF NOT cl_null(g_inpd_m.inpd007) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_inad001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd007
            #add-point:BEFORE FIELD inpd007 name="input.b.inpd007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd007
            #add-point:ON CHANGE inpd007 name="input.g.inpd007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd002
            
            #add-point:AFTER FIELD inpd002 name="input.a.inpd002"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd002
            #add-point:BEFORE FIELD inpd002 name="input.b.inpd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd002
            #add-point:ON CHANGE inpd002 name="input.g.inpd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd003
            #add-point:BEFORE FIELD inpd003 name="input.b.inpd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd003
            
            #add-point:AFTER FIELD inpd003 name="input.a.inpd003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd003
            #add-point:ON CHANGE inpd003 name="input.g.inpd003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd004
            
            #add-point:AFTER FIELD inpd004 name="input.a.inpd004"
            IF NOT cl_null(g_inpd_m.inpd004) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

                #160318-00025#16  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#16  by 07900 --add-end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_imaf001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpd_m.inpd004
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inpd_m.inpd004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpd_m.inpd004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd004
            #add-point:BEFORE FIELD inpd004 name="input.b.inpd004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd004
            #add-point:ON CHANGE inpd004 name="input.g.inpd004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd010
            
            #add-point:AFTER FIELD inpd010 name="input.a.inpd010"
            IF NOT cl_null(g_inpd_m.inpd010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

               #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#16 by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpd_m.inpd010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inpd_m.inpd010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpd_m.inpd010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd010
            #add-point:BEFORE FIELD inpd010 name="input.b.inpd010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd010
            #add-point:ON CHANGE inpd010 name="input.g.inpd010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd012
            
            #add-point:AFTER FIELD inpd012 name="input.a.inpd012"
            IF NOT cl_null(g_inpd_m.inpd012) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

                #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#16 by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpd_m.inpd012
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inpd_m.inpd012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpd_m.inpd012_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd012
            #add-point:BEFORE FIELD inpd012 name="input.b.inpd012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd012
            #add-point:ON CHANGE inpd012 name="input.g.inpd012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd030
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inpd_m.inpd030,"0","1","","","azz-00079",1) THEN
               NEXT FIELD inpd030
            END IF 
 
 
 
            #add-point:AFTER FIELD inpd030 name="input.a.inpd030"
            IF NOT cl_null(g_inpd_m.inpd030) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd030
            #add-point:BEFORE FIELD inpd030 name="input.b.inpd030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd030
            #add-point:ON CHANGE inpd030 name="input.g.inpd030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inpd_m.inpd031,"0","1","","","azz-00079",1) THEN
               NEXT FIELD inpd031
            END IF 
 
 
 
            #add-point:AFTER FIELD inpd031 name="input.a.inpd031"
            IF NOT cl_null(g_inpd_m.inpd031) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd031
            #add-point:BEFORE FIELD inpd031 name="input.b.inpd031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd031
            #add-point:ON CHANGE inpd031 name="input.g.inpd031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd036
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inpd_m.inpd036,"0","1","","","azz-00079",1) THEN
               NEXT FIELD inpd036
            END IF 
 
 
 
            #add-point:AFTER FIELD inpd036 name="input.a.inpd036"
            IF NOT cl_null(g_inpd_m.inpd036) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd036
            #add-point:BEFORE FIELD inpd036 name="input.b.inpd036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd036
            #add-point:ON CHANGE inpd036 name="input.g.inpd036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd037
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inpd_m.inpd037,"0","1","","","azz-00079",1) THEN
               NEXT FIELD inpd037
            END IF 
 
 
 
            #add-point:AFTER FIELD inpd037 name="input.a.inpd037"
            IF NOT cl_null(g_inpd_m.inpd037) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd037
            #add-point:BEFORE FIELD inpd037 name="input.b.inpd037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd037
            #add-point:ON CHANGE inpd037 name="input.g.inpd037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD adjust
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inpd_m.adjust,"0","1","","","azz-00079",1) THEN
               NEXT FIELD adjust
            END IF 
 
 
 
            #add-point:AFTER FIELD adjust name="input.a.adjust"
           
#            IF g_inpd_m.adjust = 0 THEN               
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'ain-00278'
#               LET g_errparam.extend = g_inpd_m.adjust
#               LET g_errparam.popup = TRUE
#               CALL cl_err()  
#               LET g_inpd_m.adjust = g_inpd_m_t.adjust               
#               NEXT FIELD adjust
#            END IF
            IF NOT cl_null(g_inpd_m.adjust) THEN 
               CALL s_aooi200_get_slip(g_inpd_m.inpddocno) RETURNING l_flag1,l_ooac002
               CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-BAS-0058') RETURNING l_ooac004 
               IF l_ooac004 = 'N' AND g_inpd_m.adjust < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00279'
                  LET g_errparam.extend = g_inpd_m.adjust
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_inpd_m.adjust = g_inpd_m_t.adjust
                  NEXT FIELD adjust    
               END IF      
               SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t
                WHERE imafent = g_enterprise
                  AND imaf001 = g_inpd_m.inpd001
                  AND imafsite = g_site   
               IF l_imaf071 = '1' OR l_imaf081 = '1' THEN                  
                  CALL aint830_01(g_site,g_inpd_m.inpddocno,g_inpd_m.inpdseq,'5',g_inpd_m.adjust)
                  LET INT_FLAG = 0
               END IF                 
            END IF             
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD adjust
            #add-point:BEFORE FIELD adjust name="input.b.adjust"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE adjust
            #add-point:ON CHANGE adjust name="input.g.adjust"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD adjust_ref
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inpd_m.adjust_ref,"0","1","","","azz-00079",1) THEN
               NEXT FIELD adjust_ref
            END IF 
 
 
 
            #add-point:AFTER FIELD adjust_ref name="input.a.adjust_ref"
#            IF g_inpd_m.adjust_ref = 0 THEN
#               
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'ain-00278'
#               LET g_errparam.extend = g_inpd_m.adjust_ref
#               LET g_errparam.popup = TRUE
#               CALL cl_err()      
#               LET g_inpd_m.adjust_ref = g_inpd_m_t.adjust_ref               
#               NEXT FIELD adjust_ref
#            END IF
            IF NOT cl_null(g_inpd_m.adjust_ref) THEN 
               CALL s_aooi200_get_slip(g_inpd_m.inpddocno) RETURNING l_flag1,l_ooac002
               CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-BAS-0058') RETURNING l_ooac004 
               IF l_ooac004 = 'N' AND g_inpd_m.adjust_ref < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00279'
                  LET g_errparam.extend = g_inpd_m.adjust_ref
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_inpd_m.adjust_ref = g_inpd_m_t.adjust_ref
                  NEXT FIELD adjust_ref    
               END IF               
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD adjust_ref
            #add-point:BEFORE FIELD adjust_ref name="input.b.adjust_ref"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE adjust_ref
            #add-point:ON CHANGE adjust_ref name="input.g.adjust_ref"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd014
            
            #add-point:AFTER FIELD inpd014 name="input.a.inpd014"
               CALL aint837_inpd014_ref()
               IF NOT cl_null(g_inpd_m.inpd014) THEN   
                  IF NOT s_azzi650_chk_exist(g_acc,g_inpd_m.inpd014) THEN
                     LET g_inpd_m.inpd014 = g_inpd_m_t.inpd014
                     CALL aint837_inpd014_ref()
                     NEXT FIELD CURRENT
                  END IF   
                  CALL s_control_chk_doc('8',g_inpd_m.inpddocno,g_inpd_m.inpd014,'','','','') RETURNING r_success,l_flag     
                  IF r_success THEN
                     IF NOT l_flag THEN
                        LET g_inpd_m.inpd014 = g_inpd_m_t.inpd014
                        CALL aint837_inpd014_ref()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     LET g_inpd_m.inpd014 = g_inpd_m_t.inpd014
                     CALL aint837_inpd014_ref()
                     NEXT FIELD CURRENT
                  END IF 
               END IF               
               CALL aint837_inpd014_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd014
            #add-point:BEFORE FIELD inpd014 name="input.b.inpd014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd014
            #add-point:ON CHANGE inpd014 name="input.g.inpd014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpd015
            #add-point:BEFORE FIELD inpd015 name="input.b.inpd015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpd015
            
            #add-point:AFTER FIELD inpd015 name="input.a.inpd015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpd015
            #add-point:ON CHANGE inpd015 name="input.g.inpd015"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.inpddocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpddocno
            #add-point:ON ACTION controlp INFIELD inpddocno name="input.c.inpddocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd008
            #add-point:ON ACTION controlp INFIELD inpd008 name="input.c.inpd008"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdseq
            #add-point:ON ACTION controlp INFIELD inpdseq name="input.c.inpdseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdsite
            #add-point:ON ACTION controlp INFIELD inpdsite name="input.c.inpdsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpdstus
            #add-point:ON ACTION controlp INFIELD inpdstus name="input.c.inpdstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd001
            #add-point:ON ACTION controlp INFIELD inpd001 name="input.c.inpd001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inpd_m.inpd001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaf001()                                #呼叫開窗

            LET g_inpd_m.inpd001 = g_qryparam.return1              

            DISPLAY g_inpd_m.inpd001 TO inpd001              #

            NEXT FIELD inpd001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inpd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd005
            #add-point:ON ACTION controlp INFIELD inpd005 name="input.c.inpd005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inpd_m.inpd005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inaa001_12()                                #呼叫開窗

            LET g_inpd_m.inpd005 = g_qryparam.return1              

            DISPLAY g_inpd_m.inpd005 TO inpd005              #

            NEXT FIELD inpd005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inpd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd006
            #add-point:ON ACTION controlp INFIELD inpd006 name="input.c.inpd006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inpd_m.inpd006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inab002_3()                                #呼叫開窗

            LET g_inpd_m.inpd006 = g_qryparam.return1              

            DISPLAY g_inpd_m.inpd006 TO inpd006              #

            NEXT FIELD inpd006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inpd007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd007
            #add-point:ON ACTION controlp INFIELD inpd007 name="input.c.inpd007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inpd_m.inpd007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inad001()                                #呼叫開窗

            LET g_inpd_m.inpd007 = g_qryparam.return1              

            DISPLAY g_inpd_m.inpd007 TO inpd007              #

            NEXT FIELD inpd007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inpd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd002
            #add-point:ON ACTION controlp INFIELD inpd002 name="input.c.inpd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd003
            #add-point:ON ACTION controlp INFIELD inpd003 name="input.c.inpd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd004
            #add-point:ON ACTION controlp INFIELD inpd004 name="input.c.inpd004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inpd_m.inpd004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaf001_12()                                #呼叫開窗

            LET g_inpd_m.inpd004 = g_qryparam.return1              

            DISPLAY g_inpd_m.inpd004 TO inpd004              #

            NEXT FIELD inpd004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inpd010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd010
            #add-point:ON ACTION controlp INFIELD inpd010 name="input.c.inpd010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inpd_m.inpd010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_inpd_m.inpd010 = g_qryparam.return1              

            DISPLAY g_inpd_m.inpd010 TO inpd010              #

            NEXT FIELD inpd010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inpd012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd012
            #add-point:ON ACTION controlp INFIELD inpd012 name="input.c.inpd012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inpd_m.inpd012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_inpd_m.inpd012 = g_qryparam.return1              

            DISPLAY g_inpd_m.inpd012 TO inpd012              #

            NEXT FIELD inpd012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inpd030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd030
            #add-point:ON ACTION controlp INFIELD inpd030 name="input.c.inpd030"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpd031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd031
            #add-point:ON ACTION controlp INFIELD inpd031 name="input.c.inpd031"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpd036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd036
            #add-point:ON ACTION controlp INFIELD inpd036 name="input.c.inpd036"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpd037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd037
            #add-point:ON ACTION controlp INFIELD inpd037 name="input.c.inpd037"
            
            #END add-point
 
 
         #Ctrlp:input.c.adjust
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD adjust
            #add-point:ON ACTION controlp INFIELD adjust name="input.c.adjust"
            
            #END add-point
 
 
         #Ctrlp:input.c.adjust_ref
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD adjust_ref
            #add-point:ON ACTION controlp INFIELD adjust_ref name="input.c.adjust_ref"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpd014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd014
            #add-point:ON ACTION controlp INFIELD inpd014 name="input.c.inpd014"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inpd_m.inpd014             #給予default值
            LET g_qryparam.default2 = "" #g_inpd_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = g_acc

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_inpd_m.inpd014 = g_qryparam.return1              
            #LET g_inpd_m.oocq002 = g_qryparam.return2 
            DISPLAY g_inpd_m.inpd014 TO inpd014              #
            #DISPLAY g_inpd_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD inpd014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inpd015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpd015
            #add-point:ON ACTION controlp INFIELD inpd015 name="input.c.inpd015"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(1) INTO l_count FROM inpd_t
                WHERE inpdent = g_enterprise AND inpdsite = g_inpd_m.inpdsite
                  AND inpddocno = g_inpd_m.inpddocno
                  AND inpdseq = g_inpd_m.inpdseq
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO inpd_t (inpdent,inpddocno,inpd008,inpd009,inpdseq,inpdsite,inpdstus,inpd001, 
                      inpd005,inpd006,inpd007,inpd002,inpd003,inpd004,inpd010,inpd012,inpd030,inpd031, 
                      inpd036,inpd037,inpd014,inpd015,inpdownid,inpdowndp,inpdcrtid,inpdcrtdp,inpdcrtdt, 
                      inpdmodid,inpdmoddt,inpdcnfid,inpdcnfdt,inpdpstid,inpdpstdt)
                  VALUES (g_enterprise,g_inpd_m.inpddocno,g_inpd_m.inpd008,g_inpd_m.inpd009,g_inpd_m.inpdseq, 
                      g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001,g_inpd_m.inpd005,g_inpd_m.inpd006, 
                      g_inpd_m.inpd007,g_inpd_m.inpd002,g_inpd_m.inpd003,g_inpd_m.inpd004,g_inpd_m.inpd010, 
                      g_inpd_m.inpd012,g_inpd_m.inpd030,g_inpd_m.inpd031,g_inpd_m.inpd036,g_inpd_m.inpd037, 
                      g_inpd_m.inpd014,g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdowndp,g_inpd_m.inpdcrtid, 
                      g_inpd_m.inpdcrtdp,g_inpd_m.inpdcrtdt,g_inpd_m.inpdmodid,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid, 
                      g_inpd_m.inpdcnfdt,g_inpd_m.inpdpstid,g_inpd_m.inpdpstdt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inpd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_inpd_m.inpdsite
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aint837_inpd_t_mask_restore('restore_mask_o')
               
               UPDATE inpd_t SET (inpddocno,inpd008,inpd009,inpdseq,inpdsite,inpdstus,inpd001,inpd005, 
                   inpd006,inpd007,inpd002,inpd003,inpd004,inpd010,inpd012,inpd030,inpd031,inpd036,inpd037, 
                   inpd014,inpd015,inpdownid,inpdowndp,inpdcrtid,inpdcrtdp,inpdcrtdt,inpdmodid,inpdmoddt, 
                   inpdcnfid,inpdcnfdt,inpdpstid,inpdpstdt) = (g_inpd_m.inpddocno,g_inpd_m.inpd008,g_inpd_m.inpd009, 
                   g_inpd_m.inpdseq,g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001,g_inpd_m.inpd005, 
                   g_inpd_m.inpd006,g_inpd_m.inpd007,g_inpd_m.inpd002,g_inpd_m.inpd003,g_inpd_m.inpd004, 
                   g_inpd_m.inpd010,g_inpd_m.inpd012,g_inpd_m.inpd030,g_inpd_m.inpd031,g_inpd_m.inpd036, 
                   g_inpd_m.inpd037,g_inpd_m.inpd014,g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdowndp, 
                   g_inpd_m.inpdcrtid,g_inpd_m.inpdcrtdp,g_inpd_m.inpdcrtdt,g_inpd_m.inpdmodid,g_inpd_m.inpdmoddt, 
                   g_inpd_m.inpdcnfid,g_inpd_m.inpdcnfdt,g_inpd_m.inpdpstid,g_inpd_m.inpdpstdt)
                WHERE inpdent = g_enterprise AND inpdsite = g_inpdsite_t #
                  AND inpddocno = g_inpddocno_t
                  AND inpdseq = g_inpdseq_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               SELECT inpa009,inpa010 INTO l_inpa009,l_inpa010 FROM inpa_t,inpd_t
                WHERE inpaent = inpdent
                  AND inpasite = inpdsite
                  AND inpadocno = inpd008
                  AND inpaent = g_enterprise
                  AND inpasite = g_inpdsite_t
                  AND inpddocno = g_inpddocno_t
               IF l_inpa009 = 'Y' AND l_inpa010 = 'N' THEN    
                  UPDATE inpd_t SET (inpd030,inpd031) = (g_inpd_m.adjust,g_inpd_m.adjust_ref)
                   WHERE inpdent = g_enterprise AND inpdsite = g_inpdsite_t #
                     AND inpddocno = g_inpddocno_t
                     AND inpdseq = g_inpdseq_t  
               END IF
               IF l_inpa010 = 'Y' THEN               
                  UPDATE inpd_t SET (inpd036,inpd037) = (g_inpd_m.adjust,g_inpd_m.adjust_ref)
                   WHERE inpdent = g_enterprise AND inpdsite = g_inpdsite_t #
                     AND inpddocno = g_inpddocno_t
                     AND inpdseq = g_inpdseq_t
               END IF   
               
               #update 盤點計劃檔
               
               UPDATE inpb_t SET inpb002 = 'Y',
                                 inpb003 = 100,
                                 inpb006 = g_user,
                                 inpb007 = g_today
                WHERE inpbent = g_enterprise
                  AND inpbdocno = g_inpd_m.inpd008
                  AND inpb001 = '8'
                  
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inpd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inpd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL aint837_inpd_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_inpd_m_t)
                     LET g_log2 = util.JSON.stringify(g_inpd_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
               
            END IF
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog  name="input.before_dialog"
         
         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         ACCEPT DIALOG
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aint837.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aint837_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE inpd_t.inpdsite 
   DEFINE l_oldno     LIKE inpd_t.inpdsite 
   DEFINE l_newno02     LIKE inpd_t.inpddocno 
   DEFINE l_oldno02     LIKE inpd_t.inpddocno 
   DEFINE l_newno03     LIKE inpd_t.inpdseq 
   DEFINE l_oldno03     LIKE inpd_t.inpdseq 
 
   DEFINE l_master    RECORD LIKE inpd_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #先確定key值無遺漏
   IF g_inpd_m.inpdsite IS NULL
      OR g_inpd_m.inpddocno IS NULL
      OR g_inpd_m.inpdseq IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_inpdsite_t = g_inpd_m.inpdsite
   LET g_inpddocno_t = g_inpd_m.inpddocno
   LET g_inpdseq_t = g_inpd_m.inpdseq
 
   
   #清空key值
   LET g_inpd_m.inpdsite = ""
   LET g_inpd_m.inpddocno = ""
   LET g_inpd_m.inpdseq = ""
 
    
   CALL aint837_set_entry("a")
   CALL aint837_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inpd_m.inpdownid = g_user
      LET g_inpd_m.inpdowndp = g_dept
      LET g_inpd_m.inpdcrtid = g_user
      LET g_inpd_m.inpdcrtdp = g_dept 
      LET g_inpd_m.inpdcrtdt = cl_get_current()
      LET g_inpd_m.inpdmodid = g_user
      LET g_inpd_m.inpdmoddt = cl_get_current()
      LET g_inpd_m.inpdstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inpd_m.inpdstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "T"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/org_approved.png")
         WHEN "5"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/fconfirmed.png")
         WHEN "6"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/dconfirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_inpd_m.inpddocno_desc = ''
   DISPLAY BY NAME g_inpd_m.inpddocno_desc
 
   
   #資料輸入
   CALL aint837_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_inpd_m.* TO NULL
      CALL aint837_show()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前 name="reproduce.head.b_insert"
   
   #end add-point
   
   #add-point:單頭複製中 name="reproduce.head.m_insert"
   
   #end add-point
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "inpd_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aint837_set_act_visible()
   CALL aint837_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_inpdsite_t = g_inpd_m.inpdsite
   LET g_inpddocno_t = g_inpd_m.inpddocno
   LET g_inpdseq_t = g_inpd_m.inpdseq
 
   
   #組合新增資料的條件
   LET g_add_browse = " inpdent = " ||g_enterprise|| " AND",
                      " inpdsite = '", g_inpd_m.inpdsite, "' "
                      ," AND inpddocno = '", g_inpd_m.inpddocno, "' "
                      ," AND inpdseq = '", g_inpd_m.inpdseq, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint837_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_inpd_m.inpdownid      
   LET g_data_dept  = g_inpd_m.inpdowndp
              
   #功能已完成,通報訊息中心
   CALL aint837_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aint837.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aint837_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE  r_success    LIKE type_t.num5
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aint837_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_desc_get_item_desc(g_inpd_m.inpd001) RETURNING g_inpd_m.imaal003,g_inpd_m.imaal004
   CALL s_feature_description(g_inpd_m.inpd001,g_inpd_m.inpd002) RETURNING r_success,g_inpd_m.inpd002_desc
   DISPLAY BY NAME g_inpd_m.inpd002_desc
   CALL aint837_inpd014_ref()   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_inpd_m.inpddocno,g_inpd_m.inpd008,g_inpd_m.inpddocno_desc,g_inpd_m.inpd009,g_inpd_m.inpdseq, 
       g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001,g_inpd_m.imaal003,g_inpd_m.imaal004,g_inpd_m.inpd005, 
       g_inpd_m.inpd005_desc,g_inpd_m.inpd006,g_inpd_m.inpd006_desc,g_inpd_m.inpd007,g_inpd_m.inpd002, 
       g_inpd_m.inpd002_desc,g_inpd_m.inpd003,g_inpd_m.inpd004,g_inpd_m.inpd004_desc,g_inpd_m.inpd010, 
       g_inpd_m.inpd010_desc,g_inpd_m.inpd012,g_inpd_m.inpd012_desc,g_inpd_m.inpd030,g_inpd_m.inpd031, 
       g_inpd_m.inpd036,g_inpd_m.inpd037,g_inpd_m.adjust,g_inpd_m.adjust_ref,g_inpd_m.inpd014,g_inpd_m.inpd014_desc, 
       g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdownid_desc,g_inpd_m.inpdowndp,g_inpd_m.inpdowndp_desc, 
       g_inpd_m.inpdcrtid,g_inpd_m.inpdcrtid_desc,g_inpd_m.inpdcrtdp,g_inpd_m.inpdcrtdp_desc,g_inpd_m.inpdcrtdt, 
       g_inpd_m.inpdmodid,g_inpd_m.inpdmodid_desc,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid,g_inpd_m.inpdcnfid_desc, 
       g_inpd_m.inpdcnfdt,g_inpd_m.inpdpstid,g_inpd_m.inpdpstid_desc,g_inpd_m.inpdpstdt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aint837_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inpd_m.inpdstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "T"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/org_approved.png")
         WHEN "5"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/fconfirmed.png")
         WHEN "6"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/dconfirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aint837.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aint837_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_inpd_m.inpdsite IS NULL
   OR g_inpd_m.inpddocno IS NULL
   OR g_inpd_m.inpdseq IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_inpdsite_t = g_inpd_m.inpdsite
   LET g_inpddocno_t = g_inpd_m.inpddocno
   LET g_inpdseq_t = g_inpd_m.inpdseq
 
   
   
 
   OPEN aint837_cl USING g_enterprise,g_inpd_m.inpdsite,g_inpd_m.inpddocno,g_inpd_m.inpdseq
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint837_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aint837_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint837_master_referesh USING g_inpd_m.inpdsite,g_inpd_m.inpddocno,g_inpd_m.inpdseq INTO g_inpd_m.inpddocno, 
       g_inpd_m.inpd008,g_inpd_m.inpd009,g_inpd_m.inpdseq,g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001, 
       g_inpd_m.inpd005,g_inpd_m.inpd006,g_inpd_m.inpd007,g_inpd_m.inpd002,g_inpd_m.inpd003,g_inpd_m.inpd004, 
       g_inpd_m.inpd010,g_inpd_m.inpd012,g_inpd_m.inpd030,g_inpd_m.inpd031,g_inpd_m.inpd036,g_inpd_m.inpd037, 
       g_inpd_m.inpd014,g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdowndp,g_inpd_m.inpdcrtid,g_inpd_m.inpdcrtdp, 
       g_inpd_m.inpdcrtdt,g_inpd_m.inpdmodid,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid,g_inpd_m.inpdcnfdt, 
       g_inpd_m.inpdpstid,g_inpd_m.inpdpstdt,g_inpd_m.inpd005_desc,g_inpd_m.inpd006_desc,g_inpd_m.inpd004_desc, 
       g_inpd_m.inpd010_desc,g_inpd_m.inpd012_desc,g_inpd_m.inpdownid_desc,g_inpd_m.inpdowndp_desc,g_inpd_m.inpdcrtid_desc, 
       g_inpd_m.inpdcrtdp_desc,g_inpd_m.inpdmodid_desc,g_inpd_m.inpdcnfid_desc,g_inpd_m.inpdpstid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aint837_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inpd_m_mask_o.* =  g_inpd_m.*
   CALL aint837_inpd_t_mask()
   LET g_inpd_m_mask_n.* =  g_inpd_m.*
   
   #將最新資料顯示到畫面上
   CALL aint837_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint837_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM inpd_t 
       WHERE inpdent = g_enterprise AND inpdsite = g_inpd_m.inpdsite 
         AND inpddocno = g_inpd_m.inpddocno 
         AND inpdseq = g_inpd_m.inpdseq 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inpd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_inpd_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aint837_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aint837_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aint837_browser_fill(g_wc,"")
         CALL aint837_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aint837_cl
 
   #功能已完成,通報訊息中心
   CALL aint837_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aint837.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aint837_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_inpdsite = g_inpd_m.inpdsite
         AND g_browser[l_i].b_inpddocno = g_inpd_m.inpddocno
         AND g_browser[l_i].b_inpdseq = g_inpd_m.inpdseq
 
         THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count
  
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="aint837.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aint837_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("inpdsite,inpddocno,inpdseq",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint837.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aint837_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("inpdsite,inpddocno,inpdseq",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint837.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aint837_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint837.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aint837_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
 
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint837.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint837_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization" 
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " inpdsite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " inpddocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " inpdseq = '", g_argv[03], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   IF NOT cl_null(ls_wc) THEN    #add by lixh20141203
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   RETURN 
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint837.mask_functions" >}
&include "erp/ain/aint837_mask.4gl"
 
{</section>}
 
{<section id="aint837.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aint837_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_inpd_m.inpdsite IS NULL
      OR g_inpd_m.inpddocno IS NULL      OR g_inpd_m.inpdseq IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aint837_cl USING g_enterprise,g_inpd_m.inpdsite,g_inpd_m.inpddocno,g_inpd_m.inpdseq
   IF STATUS THEN
      CLOSE aint837_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint837_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aint837_master_referesh USING g_inpd_m.inpdsite,g_inpd_m.inpddocno,g_inpd_m.inpdseq INTO g_inpd_m.inpddocno, 
       g_inpd_m.inpd008,g_inpd_m.inpd009,g_inpd_m.inpdseq,g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001, 
       g_inpd_m.inpd005,g_inpd_m.inpd006,g_inpd_m.inpd007,g_inpd_m.inpd002,g_inpd_m.inpd003,g_inpd_m.inpd004, 
       g_inpd_m.inpd010,g_inpd_m.inpd012,g_inpd_m.inpd030,g_inpd_m.inpd031,g_inpd_m.inpd036,g_inpd_m.inpd037, 
       g_inpd_m.inpd014,g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdowndp,g_inpd_m.inpdcrtid,g_inpd_m.inpdcrtdp, 
       g_inpd_m.inpdcrtdt,g_inpd_m.inpdmodid,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid,g_inpd_m.inpdcnfdt, 
       g_inpd_m.inpdpstid,g_inpd_m.inpdpstdt,g_inpd_m.inpd005_desc,g_inpd_m.inpd006_desc,g_inpd_m.inpd004_desc, 
       g_inpd_m.inpd010_desc,g_inpd_m.inpd012_desc,g_inpd_m.inpdownid_desc,g_inpd_m.inpdowndp_desc,g_inpd_m.inpdcrtid_desc, 
       g_inpd_m.inpdcrtdp_desc,g_inpd_m.inpdmodid_desc,g_inpd_m.inpdcnfid_desc,g_inpd_m.inpdpstid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aint837_action_chk() THEN
      CLOSE aint837_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inpd_m.inpddocno,g_inpd_m.inpd008,g_inpd_m.inpddocno_desc,g_inpd_m.inpd009,g_inpd_m.inpdseq, 
       g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001,g_inpd_m.imaal003,g_inpd_m.imaal004,g_inpd_m.inpd005, 
       g_inpd_m.inpd005_desc,g_inpd_m.inpd006,g_inpd_m.inpd006_desc,g_inpd_m.inpd007,g_inpd_m.inpd002, 
       g_inpd_m.inpd002_desc,g_inpd_m.inpd003,g_inpd_m.inpd004,g_inpd_m.inpd004_desc,g_inpd_m.inpd010, 
       g_inpd_m.inpd010_desc,g_inpd_m.inpd012,g_inpd_m.inpd012_desc,g_inpd_m.inpd030,g_inpd_m.inpd031, 
       g_inpd_m.inpd036,g_inpd_m.inpd037,g_inpd_m.adjust,g_inpd_m.adjust_ref,g_inpd_m.inpd014,g_inpd_m.inpd014_desc, 
       g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdownid_desc,g_inpd_m.inpdowndp,g_inpd_m.inpdowndp_desc, 
       g_inpd_m.inpdcrtid,g_inpd_m.inpdcrtid_desc,g_inpd_m.inpdcrtdp,g_inpd_m.inpdcrtdp_desc,g_inpd_m.inpdcrtdt, 
       g_inpd_m.inpdmodid,g_inpd_m.inpdmodid_desc,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid,g_inpd_m.inpdcnfid_desc, 
       g_inpd_m.inpdcnfdt,g_inpd_m.inpdpstid,g_inpd_m.inpdpstid_desc,g_inpd_m.inpdpstdt
 
   CASE g_inpd_m.inpdstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "T"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/org_approved.png")
      WHEN "5"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/fconfirmed.png")
      WHEN "6"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/dconfirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_inpd_m.inpdstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "T"
               HIDE OPTION "org_approved"
            WHEN "5"
               HIDE OPTION "fconfirmed"
            WHEN "6"
               HIDE OPTION "dconfirmed"
            WHEN "S"
               HIDE OPTION "posted"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aint837_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint837_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aint837_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint837_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION org_approved
         IF cl_auth_chk_act("org_approved") THEN
            LET lc_state = "T"
            #add-point:action控制 name="statechange.org_approved"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION fconfirmed
         IF cl_auth_chk_act("fconfirmed") THEN
            LET lc_state = "5"
            #add-point:action控制 name="statechange.fconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION dconfirmed
         IF cl_auth_chk_act("dconfirmed") THEN
            LET lc_state = "6"
            #add-point:action控制 name="statechange.dconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "T"
      AND lc_state <> "5"
      AND lc_state <> "6"
      AND lc_state <> "S"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_inpd_m.inpdstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aint837_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
 
   #end add-point
   
   LET g_inpd_m.inpdmodid = g_user
   LET g_inpd_m.inpdmoddt = cl_get_current()
   LET g_inpd_m.inpdstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE inpd_t 
      SET (inpdstus,inpdmodid,inpdmoddt) 
        = (g_inpd_m.inpdstus,g_inpd_m.inpdmodid,g_inpd_m.inpdmoddt)     
    WHERE inpdent = g_enterprise AND inpdsite = g_inpd_m.inpdsite
      AND inpddocno = g_inpd_m.inpddocno      AND inpdseq = g_inpd_m.inpdseq
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "T"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/org_approved.png")
         WHEN "5"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/fconfirmed.png")
         WHEN "6"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/dconfirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aint837_master_referesh USING g_inpd_m.inpdsite,g_inpd_m.inpddocno,g_inpd_m.inpdseq INTO g_inpd_m.inpddocno, 
          g_inpd_m.inpd008,g_inpd_m.inpd009,g_inpd_m.inpdseq,g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001, 
          g_inpd_m.inpd005,g_inpd_m.inpd006,g_inpd_m.inpd007,g_inpd_m.inpd002,g_inpd_m.inpd003,g_inpd_m.inpd004, 
          g_inpd_m.inpd010,g_inpd_m.inpd012,g_inpd_m.inpd030,g_inpd_m.inpd031,g_inpd_m.inpd036,g_inpd_m.inpd037, 
          g_inpd_m.inpd014,g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdowndp,g_inpd_m.inpdcrtid, 
          g_inpd_m.inpdcrtdp,g_inpd_m.inpdcrtdt,g_inpd_m.inpdmodid,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid, 
          g_inpd_m.inpdcnfdt,g_inpd_m.inpdpstid,g_inpd_m.inpdpstdt,g_inpd_m.inpd005_desc,g_inpd_m.inpd006_desc, 
          g_inpd_m.inpd004_desc,g_inpd_m.inpd010_desc,g_inpd_m.inpd012_desc,g_inpd_m.inpdownid_desc, 
          g_inpd_m.inpdowndp_desc,g_inpd_m.inpdcrtid_desc,g_inpd_m.inpdcrtdp_desc,g_inpd_m.inpdmodid_desc, 
          g_inpd_m.inpdcnfid_desc,g_inpd_m.inpdpstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_inpd_m.inpddocno,g_inpd_m.inpd008,g_inpd_m.inpddocno_desc,g_inpd_m.inpd009,g_inpd_m.inpdseq, 
          g_inpd_m.inpdsite,g_inpd_m.inpdstus,g_inpd_m.inpd001,g_inpd_m.imaal003,g_inpd_m.imaal004,g_inpd_m.inpd005, 
          g_inpd_m.inpd005_desc,g_inpd_m.inpd006,g_inpd_m.inpd006_desc,g_inpd_m.inpd007,g_inpd_m.inpd002, 
          g_inpd_m.inpd002_desc,g_inpd_m.inpd003,g_inpd_m.inpd004,g_inpd_m.inpd004_desc,g_inpd_m.inpd010, 
          g_inpd_m.inpd010_desc,g_inpd_m.inpd012,g_inpd_m.inpd012_desc,g_inpd_m.inpd030,g_inpd_m.inpd031, 
          g_inpd_m.inpd036,g_inpd_m.inpd037,g_inpd_m.adjust,g_inpd_m.adjust_ref,g_inpd_m.inpd014,g_inpd_m.inpd014_desc, 
          g_inpd_m.inpd015,g_inpd_m.inpdownid,g_inpd_m.inpdownid_desc,g_inpd_m.inpdowndp,g_inpd_m.inpdowndp_desc, 
          g_inpd_m.inpdcrtid,g_inpd_m.inpdcrtid_desc,g_inpd_m.inpdcrtdp,g_inpd_m.inpdcrtdp_desc,g_inpd_m.inpdcrtdt, 
          g_inpd_m.inpdmodid,g_inpd_m.inpdmodid_desc,g_inpd_m.inpdmoddt,g_inpd_m.inpdcnfid,g_inpd_m.inpdcnfid_desc, 
          g_inpd_m.inpdcnfdt,g_inpd_m.inpdpstid,g_inpd_m.inpdpstid_desc,g_inpd_m.inpdpstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aint837_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint837_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint837.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aint837_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
 
 
   CALL aint837_show()
   CALL aint837_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_inpd_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL aint837_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aint837_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aint837.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint837_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_inpd_m.inpdsite
   LET g_pk_array[1].column = 'inpdsite'
   LET g_pk_array[2].values = g_inpd_m.inpddocno
   LET g_pk_array[2].column = 'inpddocno'
   LET g_pk_array[3].values = g_inpd_m.inpdseq
   LET g_pk_array[3].column = 'inpdseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint837.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aint837.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aint837_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL aint837_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_inpd_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint837.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aint837_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint837.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint837_inpd014_ref()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint837_inpd014_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_acc        
            LET g_ref_fields[2] = g_inpd_m.inpd014
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = ? AND oocql002=? ","") RETURNING g_rtn_fields
            LET g_inpd_m.inpd014_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpd_m.inpd014_desc
END FUNCTION

 
{</section>}
 
