#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt035.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-09-30 18:25:52), PR版次:0007(2017-01-06 14:17:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: afmt035
#+ Description: 融資合同維護
#+ Creator....: 02291(2015-11-13 09:30:02)
#+ Modifier...: 08732 -SD/PR- 08729
 
{</section>}
 
{<section id="afmt035.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Modify.........: No.151125-00001#2  15/11/27 By catmoon 作廢前詢問「是否執行作廢？」
#Modify.........: No.160122-00001#1  16/01/27 By yangtt  添加交易帳戶編號用戶權限空管
#Modify.........: No.160318-00005#12 16/03/25 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#Modify.........: No.160324-00034#1  16/01/27 By 07673   审核时判断,若count fmcl002=2<1 则报错  
#Modify.........: No.160318-00025#6  16/04/19 By 07675   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#Modify.........: No.160818-00017#13 16/08/24 By 07900   删除修改未重新判断状态码
#Modify.........: No.160829-00036#1  16/09/01 By 07900   1.查询时,若【融资清单】中的【贷款账户】在anmi120中没有维护权限,则还给查询出来资料,但是以*显示 新增修改时依原逻辑不变,只能选有权限的交易账户
#                                                        2.除【融资清单】页签，其他页签中，有涉及到账户权限处理的逻辑全部拿掉（增删改查开窗等),即不控交易账户权限
#Modify.........: No.160912-00014#4  16/10/03 By 08732   列印串接afmr035
#Modify.........: No.161006-00005#42 16/10/28 By 08732   組織類型與職能開窗調整
#Modify.........: No.161104-00046#15 17/01/03 By 08729   處理單別預設值
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
PRIVATE type type_g_fmcj_m        RECORD
       fmcjsite LIKE fmcj_t.fmcjsite, 
   fmcjsite_desc LIKE type_t.chr80, 
   fmcjcomp LIKE fmcj_t.fmcjcomp, 
   fmcjcomp_desc LIKE type_t.chr80, 
   fmcj001 LIKE fmcj_t.fmcj001, 
   fmcj001_desc LIKE type_t.chr80, 
   fmcj006 LIKE fmcj_t.fmcj006, 
   fmcj007 LIKE fmcj_t.fmcj007, 
   fmcjdocno LIKE fmcj_t.fmcjdocno, 
   fmcjdocdt LIKE fmcj_t.fmcjdocdt, 
   fmcj002 LIKE fmcj_t.fmcj002, 
   fmcj002_desc LIKE type_t.chr80, 
   fmcj008 LIKE fmcj_t.fmcj008, 
   fmcj003 LIKE fmcj_t.fmcj003, 
   fmcj004 LIKE fmcj_t.fmcj004, 
   fmcj005 LIKE fmcj_t.fmcj005, 
   fmcj009 LIKE fmcj_t.fmcj009, 
   fmcjstus LIKE fmcj_t.fmcjstus, 
   fmcjownid LIKE fmcj_t.fmcjownid, 
   fmcjownid_desc LIKE type_t.chr80, 
   fmcjowndp LIKE fmcj_t.fmcjowndp, 
   fmcjowndp_desc LIKE type_t.chr80, 
   fmcjcrtid LIKE fmcj_t.fmcjcrtid, 
   fmcjcrtid_desc LIKE type_t.chr80, 
   fmcjcrtdp LIKE fmcj_t.fmcjcrtdp, 
   fmcjcrtdp_desc LIKE type_t.chr80, 
   fmcjcrtdt LIKE fmcj_t.fmcjcrtdt, 
   fmcjmodid LIKE fmcj_t.fmcjmodid, 
   fmcjmodid_desc LIKE type_t.chr80, 
   fmcjmoddt LIKE fmcj_t.fmcjmoddt, 
   fmcjcnfid LIKE fmcj_t.fmcjcnfid, 
   fmcjcnfid_desc LIKE type_t.chr80, 
   fmcjcnfdt LIKE fmcj_t.fmcjcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fmck_d        RECORD
       fmckseq LIKE fmck_t.fmckseq, 
   fmck002 LIKE fmck_t.fmck002, 
   fmck002_desc LIKE type_t.chr500, 
   fmck003 LIKE fmck_t.fmck003, 
   fmck004 LIKE fmck_t.fmck004, 
   fmck005 LIKE fmck_t.fmck005, 
   fmck006 LIKE fmck_t.fmck006, 
   fmck007 LIKE fmck_t.fmck007, 
   fmck008 LIKE fmck_t.fmck008, 
   fmck009 LIKE fmck_t.fmck009, 
   fmck010 LIKE fmck_t.fmck010, 
   fmck011 LIKE fmck_t.fmck011, 
   fmck012 LIKE fmck_t.fmck012
       END RECORD
PRIVATE TYPE type_g_fmck2_d RECORD
       fmclseq LIKE fmcl_t.fmclseq, 
   fmclseq2 LIKE fmcl_t.fmclseq2, 
   fmcl001 LIKE fmcl_t.fmcl001, 
   fmcl002 LIKE fmcl_t.fmcl002, 
   fmcl003 LIKE fmcl_t.fmcl003, 
   fmcl004 LIKE fmcl_t.fmcl004, 
   fmcl005 LIKE fmcl_t.fmcl005, 
   fmcl006 LIKE fmcl_t.fmcl006
       END RECORD
PRIVATE TYPE type_g_fmck3_d RECORD
       fmcmseq LIKE fmcm_t.fmcmseq, 
   fmcmseq2 LIKE fmcm_t.fmcmseq2, 
   fmcm001 LIKE fmcm_t.fmcm001, 
   fmcm001_desc LIKE type_t.chr500, 
   fmcm002 LIKE fmcm_t.fmcm002, 
   fmcm003 LIKE fmcm_t.fmcm003, 
   fmcm004 LIKE fmcm_t.fmcm004
       END RECORD
PRIVATE TYPE type_g_fmck4_d RECORD
       fmcnseq LIKE fmcn_t.fmcnseq, 
   fmcnseq2 LIKE fmcn_t.fmcnseq2, 
   fmcn001 LIKE fmcn_t.fmcn001, 
   fmcn001_desc LIKE type_t.chr500, 
   fmcn002 LIKE fmcn_t.fmcn002, 
   fmcn003 LIKE fmcn_t.fmcn003, 
   fmcn004 LIKE fmcn_t.fmcn004, 
   fmcn005 LIKE fmcn_t.fmcn005, 
   fmcn006 LIKE fmcn_t.fmcn006, 
   fmcn007 LIKE fmcn_t.fmcn007
       END RECORD
PRIVATE TYPE type_g_fmck5_d RECORD
       fmcoseq LIKE fmco_t.fmcoseq, 
   fmcoseq2 LIKE fmco_t.fmcoseq2, 
   fmco001 LIKE fmco_t.fmco001, 
   fmco002 LIKE fmco_t.fmco002, 
   fmco002_desc LIKE type_t.chr500, 
   fmco003 LIKE fmco_t.fmco003, 
   fmco004 LIKE fmco_t.fmco004, 
   fmco005 LIKE fmco_t.fmco005
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fmcjdocno LIKE fmcj_t.fmcjdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaald          LIKE glaa_t.glaald
DEFINE g_glaa003         LIKE glaa_t.glaa003
DEFINE g_glaa024         LIKE glaa_t.glaa024
DEFINE g_glaa025         LIKE glaa_t.glaa025
DEFINE g_glaa026         LIKE glaa_t.glaa026
DEFINE g_sql_bank        STRING              #160122-00001#1 add by07675
DEFINE g_user_dept_wc    STRING              #161104-00046#15
DEFINE g_user_dept_wc_q  STRING              #161104-00046#15
DEFINE g_user_slip_wc    STRING              #161104-00046#15
#end add-point
       
#模組變數(Module Variables)
DEFINE g_fmcj_m          type_g_fmcj_m
DEFINE g_fmcj_m_t        type_g_fmcj_m
DEFINE g_fmcj_m_o        type_g_fmcj_m
DEFINE g_fmcj_m_mask_o   type_g_fmcj_m #轉換遮罩前資料
DEFINE g_fmcj_m_mask_n   type_g_fmcj_m #轉換遮罩後資料
 
   DEFINE g_fmcjdocno_t LIKE fmcj_t.fmcjdocno
 
 
DEFINE g_fmck_d          DYNAMIC ARRAY OF type_g_fmck_d
DEFINE g_fmck_d_t        type_g_fmck_d
DEFINE g_fmck_d_o        type_g_fmck_d
DEFINE g_fmck_d_mask_o   DYNAMIC ARRAY OF type_g_fmck_d #轉換遮罩前資料
DEFINE g_fmck_d_mask_n   DYNAMIC ARRAY OF type_g_fmck_d #轉換遮罩後資料
DEFINE g_fmck2_d          DYNAMIC ARRAY OF type_g_fmck2_d
DEFINE g_fmck2_d_t        type_g_fmck2_d
DEFINE g_fmck2_d_o        type_g_fmck2_d
DEFINE g_fmck2_d_mask_o   DYNAMIC ARRAY OF type_g_fmck2_d #轉換遮罩前資料
DEFINE g_fmck2_d_mask_n   DYNAMIC ARRAY OF type_g_fmck2_d #轉換遮罩後資料
DEFINE g_fmck3_d          DYNAMIC ARRAY OF type_g_fmck3_d
DEFINE g_fmck3_d_t        type_g_fmck3_d
DEFINE g_fmck3_d_o        type_g_fmck3_d
DEFINE g_fmck3_d_mask_o   DYNAMIC ARRAY OF type_g_fmck3_d #轉換遮罩前資料
DEFINE g_fmck3_d_mask_n   DYNAMIC ARRAY OF type_g_fmck3_d #轉換遮罩後資料
DEFINE g_fmck4_d          DYNAMIC ARRAY OF type_g_fmck4_d
DEFINE g_fmck4_d_t        type_g_fmck4_d
DEFINE g_fmck4_d_o        type_g_fmck4_d
DEFINE g_fmck4_d_mask_o   DYNAMIC ARRAY OF type_g_fmck4_d #轉換遮罩前資料
DEFINE g_fmck4_d_mask_n   DYNAMIC ARRAY OF type_g_fmck4_d #轉換遮罩後資料
DEFINE g_fmck5_d          DYNAMIC ARRAY OF type_g_fmck5_d
DEFINE g_fmck5_d_t        type_g_fmck5_d
DEFINE g_fmck5_d_o        type_g_fmck5_d
DEFINE g_fmck5_d_mask_o   DYNAMIC ARRAY OF type_g_fmck5_d #轉換遮罩前資料
DEFINE g_fmck5_d_mask_n   DYNAMIC ARRAY OF type_g_fmck5_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
DEFINE g_wc2_table5   STRING
 
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmt035.main" >}
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
   CALL cl_ap_init("afm","")
 
   #add-point:作業初始化 name="main.init"
   #161104-00046#15-----s
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_fmcj_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('fmcjcomp','','fmcjent','fmcjdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#15-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmcjsite,'',fmcjcomp,'',fmcj001,'',fmcj006,fmcj007,fmcjdocno,fmcjdocdt, 
       fmcj002,'',fmcj008,fmcj003,fmcj004,fmcj005,fmcj009,fmcjstus,fmcjownid,'',fmcjowndp,'',fmcjcrtid, 
       '',fmcjcrtdp,'',fmcjcrtdt,fmcjmodid,'',fmcjmoddt,fmcjcnfid,'',fmcjcnfdt", 
                      " FROM fmcj_t",
                      " WHERE fmcjent= ? AND fmcjdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt035_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmcjsite,t0.fmcjcomp,t0.fmcj001,t0.fmcj006,t0.fmcj007,t0.fmcjdocno, 
       t0.fmcjdocdt,t0.fmcj002,t0.fmcj008,t0.fmcj003,t0.fmcj004,t0.fmcj005,t0.fmcj009,t0.fmcjstus,t0.fmcjownid, 
       t0.fmcjowndp,t0.fmcjcrtid,t0.fmcjcrtdp,t0.fmcjcrtdt,t0.fmcjmodid,t0.fmcjmoddt,t0.fmcjcnfid,t0.fmcjcnfdt, 
       t1.ooefl003 ,t2.ooefl003 ,t3.fmaal003 ,t4.nmabl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 , 
       t9.ooag011 ,t10.ooag011",
               " FROM fmcj_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fmcjsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.fmcjcomp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN fmaal_t t3 ON t3.fmaalent="||g_enterprise||" AND t3.fmaal001=t0.fmcj001 AND t3.fmaal002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t4 ON t4.nmablent="||g_enterprise||" AND t4.nmabl001=t0.fmcj002 AND t4.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.fmcjownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.fmcjowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.fmcjcrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.fmcjcrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.fmcjmodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.fmcjcnfid  ",
 
               " WHERE t0.fmcjent = " ||g_enterprise|| " AND t0.fmcjdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmt035_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmt035 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmt035_init()   
 
      #進入選單 Menu (="N")
      CALL afmt035_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmt035
      
   END IF 
   
   CLOSE afmt035_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmt035.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt035_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('fmcjstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
   CALL g_idx_group.addAttribute("'5',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('fmcj005','8856')
   CALL cl_set_combo_scc('fmck005','8854')
   CALL cl_set_combo_scc('fmck006','8855')
   CALL cl_set_combo_scc('fmcl001','8859')
   CALL cl_set_combo_scc('fmcl002','8860')
   CALL cl_set_combo_scc('fmcn003','8854')
   CALL cl_set_combo_scc('fmcn005','8855')
   CALL cl_set_combo_scc('fmco001','8858')
   #160122-00001#1--add--str--by 07675
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#1--add--end
   #end add-point
   
   #初始化搜尋條件
   CALL afmt035_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afmt035.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afmt035_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL afmt035_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_fmcj_m.* TO NULL
         CALL g_fmck_d.clear()
         CALL g_fmck2_d.clear()
         CALL g_fmck3_d.clear()
         CALL g_fmck4_d.clear()
         CALL g_fmck5_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmt035_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_fmck_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt035_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL afmt035_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_fmck2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt035_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL afmt035_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fmck3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt035_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL afmt035_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fmck4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt035_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL afmt035_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fmck5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt035_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[5] = l_ac
               CALL g_idx_group.addAttribute("'5',",l_ac)
               
               #add-point:page5, before row動作 name="ui_dialog.body5.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
               #顯示單身筆數
               CALL afmt035_idx_chk()
               #add-point:page5自定義行為 name="ui_dialog.body5.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_5)
            
         
            #add-point:page5自定義行為 name="ui_dialog.body5.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL afmt035_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL afmt035_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afmt035_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afmt035_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afmt035_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afmt035_set_act_visible()   
            CALL afmt035_set_act_no_visible()
            IF NOT (g_fmcj_m.fmcjdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fmcjent = " ||g_enterprise|| " AND",
                                  " fmcjdocno = '", g_fmcj_m.fmcjdocno, "' "
 
               #填到對應位置
               CALL afmt035_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
               INITIALIZE g_wc2_table5 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "fmcj_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmck_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmcl_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "fmcm_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "fmcn_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "fmco_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL afmt035_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
               INITIALIZE g_wc2_table5 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "fmcj_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmck_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmcl_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "fmcm_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "fmcn_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "fmco_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afmt035_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt035_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afmt035_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt035_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afmt035_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt035_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afmt035_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt035_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afmt035_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt035_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afmt035_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt035_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_fmck_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fmck2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_fmck3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_fmck4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_fmck5_d)
                  LET g_export_id[5]   = "s_detail5"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
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
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afmt035_modify()
               #add-point:ON ACTION modify name="menu.modify"
               IF g_fmcj_m.fmcj005 = '5' THEN
                  CALL cl_set_act_visible("open_afmt035_01",FALSE)
               ELSE
                  CALL cl_set_act_visible("open_afmt035_01", TRUE)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afmt035_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt035_01
            LET g_action_choice="open_afmt035_01"
            IF cl_auth_chk_act("open_afmt035_01") THEN
               
               #add-point:ON ACTION open_afmt035_01 name="menu.open_afmt035_01"
               CALL afmt035_01(g_fmcj_m.fmcjdocno)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmt035_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt035_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #160912-00014#4---add---s
               LET g_rep_wc = "     fmcjent = '",g_enterprise,"' ",
                              " AND fmcjdocno = '",g_fmcj_m.fmcjdocno,"' ",
                              " AND fmcjent = fmckent AND fmcjdocno = fmckdocno "      #取得列印條件
               #160912-00014#4---add---e
               #END add-point
               &include "erp/afm/afmt035_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #160912-00014#4---add---s
               LET g_rep_wc = "     fmcjent = '",g_enterprise,"' ",
                              " AND fmcjdocno = '",g_fmcj_m.fmcjdocno,"' ",
                              " AND fmcjent = fmckent AND fmcjdocno = fmckdocno "      #取得列印條件
               #160912-00014#4---add---e
               #END add-point
               &include "erp/afm/afmt035_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afmt035_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt035_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt035_02
            LET g_action_choice="open_afmt035_02"
            IF cl_auth_chk_act("open_afmt035_02") THEN
               
               #add-point:ON ACTION open_afmt035_02 name="menu.open_afmt035_02"
               CALL afmt035_02(g_fmcj_m.fmcjdocno)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt035_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt035_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt035_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmcj_m.fmcjdocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="afmt035.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afmt035_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_n               LIKE type_t.num5     #160126-00010#1
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT fmcjdocno ",
                      " FROM fmcj_t ",
                      " ",
                      " LEFT JOIN fmck_t ON fmckent = fmcjent AND fmcjdocno = fmckdocno ", "  ",
                      #add-point:browser_fill段sql(fmck_t1) name="browser_fill.cnt.join.}"
 
                      #end add-point
                      " LEFT JOIN fmcl_t ON fmclent = fmcjent AND fmcjdocno = fmcldocno", "  ",
                      #add-point:browser_fill段sql(fmcl_t1) name="browser_fill.cnt.join.fmcl_t1"
                      
                      #end add-point
 
                      " LEFT JOIN fmcm_t ON fmcment = fmcjent AND fmcjdocno = fmcmdocno", "  ",
                      #add-point:browser_fill段sql(fmcm_t1) name="browser_fill.cnt.join.fmcm_t1"
                      
                      #end add-point
 
                      " LEFT JOIN fmcn_t ON fmcnent = fmcjent AND fmcjdocno = fmcndocno", "  ",
                      #add-point:browser_fill段sql(fmcn_t1) name="browser_fill.cnt.join.fmcn_t1"
                      
                      #end add-point
 
                      " LEFT JOIN fmco_t ON fmcoent = fmcjent AND fmcjdocno = fmcodocno", "  ",
                      #add-point:browser_fill段sql(fmco_t1) name="browser_fill.cnt.join.fmco_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE fmcjent = " ||g_enterprise|| " AND fmckent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fmcj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fmcjdocno ",
                      " FROM fmcj_t ", 
                      "  ",
                      "  ",
                      " WHERE fmcjent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fmcj_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #160122-00001#1----add--str
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE fmcjdocno ",
                      " FROM fmcj_t ",
                      " LEFT JOIN fmcl_t ON fmclent = fmcjent AND fmcjdocno = fmcldocno", "  ",
                      " LEFT JOIN fmcm_t ON fmcment = fmcjent AND fmcjdocno = fmcmdocno", "  ",
                      " LEFT JOIN fmcn_t ON fmcnent = fmcjent AND fmcjdocno = fmcndocno", "  ",
                      " LEFT JOIN fmco_t ON fmcoent = fmcjent AND fmcjdocno = fmcodocno", "  ",
                      " ,fmck_t", 
                      " ", 
                      " WHERE fmckent = fmcjent AND fmcjdocno = fmckdocno ", 
#                      "   AND fmck003 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                 #     "   AND fmck003 IN(",g_sql_bank,")",     #160122-00001#1 mod by 07675  #160829-00036#1 mark
                      "   AND fmcjent = '" ||g_enterprise|| "' AND fmckent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fmcj_t"),
                      " UNION ",
                      " SELECT UNIQUE fmcjdocno ",
                      " FROM fmcj_t ", 
                      " LEFT JOIN fmck_t ON fmckent = fmcjent AND fmcjdocno = fmckdocno ",
                      " LEFT JOIN fmcl_t ON fmclent = fmcjent AND fmcjdocno = fmcldocno", "  ",
                      " LEFT JOIN fmcm_t ON fmcment = fmcjent AND fmcjdocno = fmcmdocno", "  ",
                      " LEFT JOIN fmcn_t ON fmcnent = fmcjent AND fmcjdocno = fmcndocno", "  ",
                      " LEFT JOIN fmco_t ON fmcoent = fmcjent AND fmcjdocno = fmcodocno", "  ",
                      " WHERE fmcjent = '" ||g_enterprise||"' AND TRIM(fmck003) IS NULL ",
                      " AND ",l_wc CLIPPED, cl_sql_add_filter("fmcj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE fmcjdocno ",
                      " FROM fmcj_t,fmck_t WHERE fmckent = fmcjent AND fmcjdocno = fmckdocno ",
#                      " AND fmck003 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                  #    " AND fmck003 IN(",g_sql_bank,")",     #160122-00001#1 mod by 07675  #160829-00036#1  mark
                      " AND fmcjent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("fmcj_t"),
                      " UNION ",
                      " SELECT UNIQUE fmcjdocno ",
                      " FROM fmcj_t ", 
                      " LEFT JOIN fmck_t ON fmckent = fmcjent AND fmcjdocno = fmckdocno ",
                      " WHERE fmcjent = '" ||g_enterprise||"' AND TRIM(fmck003) IS NULL ",
                      "   AND ",l_wc CLIPPED, cl_sql_add_filter("fmcj_t")
   END IF
   #160122-00001#1----add--end
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_fmcj_m.* TO NULL
      CALL g_fmck_d.clear()        
      CALL g_fmck2_d.clear() 
      CALL g_fmck3_d.clear() 
      CALL g_fmck4_d.clear() 
      CALL g_fmck5_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fmcjdocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmcjstus,t0.fmcjdocno ",
                  " FROM fmcj_t t0",
                  "  ",
                  "  LEFT JOIN fmck_t ON fmckent = fmcjent AND fmcjdocno = fmckdocno ", "  ", 
                  #add-point:browser_fill段sql(fmck_t1) name="browser_fill.join.fmck_t1"
                  
                  #end add-point
                  "  LEFT JOIN fmcl_t ON fmclent = fmcjent AND fmcjdocno = fmcldocno", "  ", 
                  #add-point:browser_fill段sql(fmcl_t1) name="browser_fill.join.fmcl_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN fmcm_t ON fmcment = fmcjent AND fmcjdocno = fmcmdocno", "  ", 
                  #add-point:browser_fill段sql(fmcm_t1) name="browser_fill.join.fmcm_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN fmcn_t ON fmcnent = fmcjent AND fmcjdocno = fmcndocno", "  ", 
                  #add-point:browser_fill段sql(fmcn_t1) name="browser_fill.join.fmcn_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN fmco_t ON fmcoent = fmcjent AND fmcjdocno = fmcodocno", "  ", 
                  #add-point:browser_fill段sql(fmco_t1) name="browser_fill.join.fmco_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                  
                  " WHERE t0.fmcjent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("fmcj_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmcjstus,t0.fmcjdocno ",
                  " FROM fmcj_t t0",
                  "  ",
                  
                  " WHERE t0.fmcjent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("fmcj_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #160122-00001#1----add--str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmcjstus,t0.fmcjdocno ",
                  " FROM fmcj_t t0",
                  "  LEFT JOIN fmcl_t ON fmclent = fmcjent AND fmcjdocno = fmcldocno", "  ", 
                  "  LEFT JOIN fmcm_t ON fmcment = fmcjent AND fmcjdocno = fmcmdocno", "  ", 
                  "  LEFT JOIN fmcn_t ON fmcnent = fmcjent AND fmcjdocno = fmcndocno", "  ", 
                  "  LEFT JOIN fmco_t ON fmcoent = fmcjent AND fmcjdocno = fmcodocno", "  ", 
                  " ,fmck_t",
                  "  WHERE fmckent = fmcjent AND fmcjdocno = fmckdocno ", "  ", 
#                  "    AND fmck003 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
               #   "    AND fmck003 IN(",g_sql_bank,")",     #160122-00001#1 mod by 07675  #160829-00036#1  mark
                  "    AND t0.fmcjent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("fmcj_t"),
                  " UNION ",
                  " SELECT UNIQUE t1.fmcjstus,t1.fmcjdocno",
                  " FROM fmcj_t t1", 
                  " LEFT JOIN fmck_t ON fmckent = fmcjent AND fmcjdocno = fmckdocno ",
                  " LEFT JOIN fmcl_t ON fmclent = fmcjent AND fmcjdocno = fmcldocno", "  ",
                  " LEFT JOIN fmcm_t ON fmcment = fmcjent AND fmcjdocno = fmcmdocno", "  ",
                  " LEFT JOIN fmcn_t ON fmcnent = fmcjent AND fmcjdocno = fmcndocno", "  ",
                  " LEFT JOIN fmco_t ON fmcoent = fmcjent AND fmcjdocno = fmcodocno", "  ",
                  " WHERE t1.fmcjent = '" ||g_enterprise||"' AND TRIM(fmck003) IS NULL ",
                  "   AND ",l_wc CLIPPED, cl_sql_add_filter("fmcj_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmcjstus,t0.fmcjdocno ",
                  "  FROM fmcj_t t0,fmck_t ",
                  "  WHERE fmckent = fmcjent AND fmcjdocno = fmckdocno",
#                  "    AND fmck003 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                #  "    AND fmck003 IN(",g_sql_bank,")",     #160122-00001#1 mod by 07675  #160829-00036#1  mark
                  "    AND t0.fmcjent = '" ||g_enterprise|| "' AND ",l_wc, cl_sql_add_filter("fmcj_t"),
                  " UNION ",
                  " SELECT t1.fmcjstus,t1.fmcjdocno ",
                  " FROM fmcj_t t1", 
                  " LEFT JOIN fmck_t ON fmckent = fmcjent AND fmcjdocno = fmckdocno ",
                  " WHERE t1.fmcjent = '" ||g_enterprise||"' AND TRIM(fmck003) IS NULL ",
                  "   AND ",l_wc CLIPPED, cl_sql_add_filter("fmcj_t")
   END IF
   #160122-00001#1----add--end
   #end add-point
   LET g_sql = g_sql, " ORDER BY fmcjdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmcj_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmcjdocno
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
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
         IF g_cnt > g_max_browse THEN
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
   
   IF cl_null(g_browser[g_cnt].b_fmcjdocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afmt035_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fmcj_m.fmcjdocno = g_browser[g_current_idx].b_fmcjdocno   
 
   EXECUTE afmt035_master_referesh USING g_fmcj_m.fmcjdocno INTO g_fmcj_m.fmcjsite,g_fmcj_m.fmcjcomp, 
       g_fmcj_m.fmcj001,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj002, 
       g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005,g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus, 
       g_fmcj_m.fmcjownid,g_fmcj_m.fmcjowndp,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdt, 
       g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid,g_fmcj_m.fmcjcnfdt,g_fmcj_m.fmcjsite_desc, 
       g_fmcj_m.fmcjcomp_desc,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcjownid_desc,g_fmcj_m.fmcjowndp_desc, 
       g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp_desc,g_fmcj_m.fmcjmodid_desc,g_fmcj_m.fmcjcnfid_desc 
 
   
   CALL afmt035_fmcj_t_mask()
   CALL afmt035_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afmt035.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afmt035_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt035_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_fmcjdocno = g_fmcj_m.fmcjdocno 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt035_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_fmcj_m.* TO NULL
   CALL g_fmck_d.clear()        
   CALL g_fmck2_d.clear() 
   CALL g_fmck3_d.clear() 
   CALL g_fmck4_d.clear() 
   CALL g_fmck5_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
   INITIALIZE g_wc2_table5 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON fmcjsite,fmcjcomp,fmcj001,fmcj006,fmcj007,fmcjdocno,fmcjdocdt,fmcj002, 
          fmcj008,fmcj003,fmcj004,fmcj005,fmcj009,fmcjstus,fmcjownid,fmcjowndp,fmcjcrtid,fmcjcrtdp,fmcjcrtdt, 
          fmcjmodid,fmcjmoddt,fmcjcnfid,fmcjcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmcjcrtdt>>----
         AFTER FIELD fmcjcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmcjmoddt>>----
         AFTER FIELD fmcjmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmcjcnfdt>>----
         AFTER FIELD fmcjcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmcjpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.fmcjsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjsite
            #add-point:ON ACTION controlp INFIELD fmcjsite name="construct.c.fmcjsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                       #161006-00005#42   mark
            CALL q_ooef001_33()                     #161006-00005#42   add             #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcjsite  #顯示到畫面上
            NEXT FIELD fmcjsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjsite
            #add-point:BEFORE FIELD fmcjsite name="construct.b.fmcjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjsite
            
            #add-point:AFTER FIELD fmcjsite name="construct.a.fmcjsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjcomp
            #add-point:BEFORE FIELD fmcjcomp name="construct.b.fmcjcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjcomp
            
            #add-point:AFTER FIELD fmcjcomp name="construct.a.fmcjcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcjcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjcomp
            #add-point:ON ACTION controlp INFIELD fmcjcomp name="construct.c.fmcjcomp"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmcj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj001
            #add-point:ON ACTION controlp INFIELD fmcj001 name="construct.c.fmcj001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcj001  #顯示到畫面上
            NEXT FIELD fmcj001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj001
            #add-point:BEFORE FIELD fmcj001 name="construct.b.fmcj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj001
            
            #add-point:AFTER FIELD fmcj001 name="construct.a.fmcj001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj006
            #add-point:BEFORE FIELD fmcj006 name="construct.b.fmcj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj006
            
            #add-point:AFTER FIELD fmcj006 name="construct.a.fmcj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj006
            #add-point:ON ACTION controlp INFIELD fmcj006 name="construct.c.fmcj006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj007
            #add-point:BEFORE FIELD fmcj007 name="construct.b.fmcj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj007
            
            #add-point:AFTER FIELD fmcj007 name="construct.a.fmcj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj007
            #add-point:ON ACTION controlp INFIELD fmcj007 name="construct.c.fmcj007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjdocno
            #add-point:BEFORE FIELD fmcjdocno name="construct.b.fmcjdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjdocno
            
            #add-point:AFTER FIELD fmcjdocno name="construct.a.fmcjdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjdocno
            #add-point:ON ACTION controlp INFIELD fmcjdocno name="construct.c.fmcjdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161104-00046#15-----s
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_user_dept_wc_q
            END IF
            #161104-00046#15-----e
            CALL q_fmcjdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcjdocno  #顯示到畫面上
            NEXT FIELD fmcjdocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjdocdt
            #add-point:BEFORE FIELD fmcjdocdt name="construct.b.fmcjdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjdocdt
            
            #add-point:AFTER FIELD fmcjdocdt name="construct.a.fmcjdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcjdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjdocdt
            #add-point:ON ACTION controlp INFIELD fmcjdocdt name="construct.c.fmcjdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmcj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj002
            #add-point:ON ACTION controlp INFIELD fmcj002 name="construct.c.fmcj002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcj002  #顯示到畫面上
            NEXT FIELD fmcj002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj002
            #add-point:BEFORE FIELD fmcj002 name="construct.b.fmcj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj002
            
            #add-point:AFTER FIELD fmcj002 name="construct.a.fmcj002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj008
            #add-point:BEFORE FIELD fmcj008 name="construct.b.fmcj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj008
            
            #add-point:AFTER FIELD fmcj008 name="construct.a.fmcj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj008
            #add-point:ON ACTION controlp INFIELD fmcj008 name="construct.c.fmcj008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj003
            #add-point:BEFORE FIELD fmcj003 name="construct.b.fmcj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj003
            
            #add-point:AFTER FIELD fmcj003 name="construct.a.fmcj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj003
            #add-point:ON ACTION controlp INFIELD fmcj003 name="construct.c.fmcj003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcj003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcj003  #顯示到畫面上
            NEXT FIELD fmcj003                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.fmcj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj004
            #add-point:ON ACTION controlp INFIELD fmcj004 name="construct.c.fmcj004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcj004  #顯示到畫面上
            NEXT FIELD fmcj004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj004
            #add-point:BEFORE FIELD fmcj004 name="construct.b.fmcj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj004
            
            #add-point:AFTER FIELD fmcj004 name="construct.a.fmcj004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj005
            #add-point:BEFORE FIELD fmcj005 name="construct.b.fmcj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj005
            
            #add-point:AFTER FIELD fmcj005 name="construct.a.fmcj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj005
            #add-point:ON ACTION controlp INFIELD fmcj005 name="construct.c.fmcj005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj009
            #add-point:BEFORE FIELD fmcj009 name="construct.b.fmcj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj009
            
            #add-point:AFTER FIELD fmcj009 name="construct.a.fmcj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj009
            #add-point:ON ACTION controlp INFIELD fmcj009 name="construct.c.fmcj009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjstus
            #add-point:BEFORE FIELD fmcjstus name="construct.b.fmcjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjstus
            
            #add-point:AFTER FIELD fmcjstus name="construct.a.fmcjstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjstus
            #add-point:ON ACTION controlp INFIELD fmcjstus name="construct.c.fmcjstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmcjownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjownid
            #add-point:ON ACTION controlp INFIELD fmcjownid name="construct.c.fmcjownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcjownid  #顯示到畫面上
            NEXT FIELD fmcjownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjownid
            #add-point:BEFORE FIELD fmcjownid name="construct.b.fmcjownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjownid
            
            #add-point:AFTER FIELD fmcjownid name="construct.a.fmcjownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcjowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjowndp
            #add-point:ON ACTION controlp INFIELD fmcjowndp name="construct.c.fmcjowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcjowndp  #顯示到畫面上
            NEXT FIELD fmcjowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjowndp
            #add-point:BEFORE FIELD fmcjowndp name="construct.b.fmcjowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjowndp
            
            #add-point:AFTER FIELD fmcjowndp name="construct.a.fmcjowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcjcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjcrtid
            #add-point:ON ACTION controlp INFIELD fmcjcrtid name="construct.c.fmcjcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcjcrtid  #顯示到畫面上
            NEXT FIELD fmcjcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjcrtid
            #add-point:BEFORE FIELD fmcjcrtid name="construct.b.fmcjcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjcrtid
            
            #add-point:AFTER FIELD fmcjcrtid name="construct.a.fmcjcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcjcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjcrtdp
            #add-point:ON ACTION controlp INFIELD fmcjcrtdp name="construct.c.fmcjcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcjcrtdp  #顯示到畫面上
            NEXT FIELD fmcjcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjcrtdp
            #add-point:BEFORE FIELD fmcjcrtdp name="construct.b.fmcjcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjcrtdp
            
            #add-point:AFTER FIELD fmcjcrtdp name="construct.a.fmcjcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjcrtdt
            #add-point:BEFORE FIELD fmcjcrtdt name="construct.b.fmcjcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmcjmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjmodid
            #add-point:ON ACTION controlp INFIELD fmcjmodid name="construct.c.fmcjmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcjmodid  #顯示到畫面上
            NEXT FIELD fmcjmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjmodid
            #add-point:BEFORE FIELD fmcjmodid name="construct.b.fmcjmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjmodid
            
            #add-point:AFTER FIELD fmcjmodid name="construct.a.fmcjmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjmoddt
            #add-point:BEFORE FIELD fmcjmoddt name="construct.b.fmcjmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmcjcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjcnfid
            #add-point:ON ACTION controlp INFIELD fmcjcnfid name="construct.c.fmcjcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcjcnfid  #顯示到畫面上
            NEXT FIELD fmcjcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjcnfid
            #add-point:BEFORE FIELD fmcjcnfid name="construct.b.fmcjcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjcnfid
            
            #add-point:AFTER FIELD fmcjcnfid name="construct.a.fmcjcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjcnfdt
            #add-point:BEFORE FIELD fmcjcnfdt name="construct.b.fmcjcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON fmckseq,fmck002,fmck003,fmck004,fmck005,fmck006,fmck007,fmck008,fmck009, 
          fmck010,fmck011,fmck012
           FROM s_detail1[1].fmckseq,s_detail1[1].fmck002,s_detail1[1].fmck003,s_detail1[1].fmck004, 
               s_detail1[1].fmck005,s_detail1[1].fmck006,s_detail1[1].fmck007,s_detail1[1].fmck008,s_detail1[1].fmck009, 
               s_detail1[1].fmck010,s_detail1[1].fmck011,s_detail1[1].fmck012
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmckseq
            #add-point:BEFORE FIELD fmckseq name="construct.b.page1.fmckseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmckseq
            
            #add-point:AFTER FIELD fmckseq name="construct.a.page1.fmckseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmckseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmckseq
            #add-point:ON ACTION controlp INFIELD fmckseq name="construct.c.page1.fmckseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmck002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck002
            #add-point:ON ACTION controlp INFIELD fmck002 name="construct.c.page1.fmck002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmck002  #顯示到畫面上
            NEXT FIELD fmck002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck002
            #add-point:BEFORE FIELD fmck002 name="construct.b.page1.fmck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck002
            
            #add-point:AFTER FIELD fmck002 name="construct.a.page1.fmck002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck003
            #add-point:BEFORE FIELD fmck003 name="construct.b.page1.fmck003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck003
            
            #add-point:AFTER FIELD fmck003 name="construct.a.page1.fmck003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck003
            #add-point:ON ACTION controlp INFIELD fmck003 name="construct.c.page1.fmck003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160122-00001#1--add---str
#            LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
             LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"      #160122-00001#1 mod by 07675
            #160122-00001#1--add---end
            CALL q_nmas002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmck003  #顯示到畫面上
            LET g_qryparam.where = " "             #160122-00001#1
            NEXT FIELD fmck003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck004
            #add-point:BEFORE FIELD fmck004 name="construct.b.page1.fmck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck004
            
            #add-point:AFTER FIELD fmck004 name="construct.a.page1.fmck004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmck004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck004
            #add-point:ON ACTION controlp INFIELD fmck004 name="construct.c.page1.fmck004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck005
            #add-point:BEFORE FIELD fmck005 name="construct.b.page1.fmck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck005
            
            #add-point:AFTER FIELD fmck005 name="construct.a.page1.fmck005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmck005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck005
            #add-point:ON ACTION controlp INFIELD fmck005 name="construct.c.page1.fmck005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck006
            #add-point:BEFORE FIELD fmck006 name="construct.b.page1.fmck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck006
            
            #add-point:AFTER FIELD fmck006 name="construct.a.page1.fmck006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck006
            #add-point:ON ACTION controlp INFIELD fmck006 name="construct.c.page1.fmck006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck007
            #add-point:BEFORE FIELD fmck007 name="construct.b.page1.fmck007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck007
            
            #add-point:AFTER FIELD fmck007 name="construct.a.page1.fmck007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck007
            #add-point:ON ACTION controlp INFIELD fmck007 name="construct.c.page1.fmck007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck008
            #add-point:BEFORE FIELD fmck008 name="construct.b.page1.fmck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck008
            
            #add-point:AFTER FIELD fmck008 name="construct.a.page1.fmck008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck008
            #add-point:ON ACTION controlp INFIELD fmck008 name="construct.c.page1.fmck008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck009
            #add-point:BEFORE FIELD fmck009 name="construct.b.page1.fmck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck009
            
            #add-point:AFTER FIELD fmck009 name="construct.a.page1.fmck009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck009
            #add-point:ON ACTION controlp INFIELD fmck009 name="construct.c.page1.fmck009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck010
            #add-point:BEFORE FIELD fmck010 name="construct.b.page1.fmck010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck010
            
            #add-point:AFTER FIELD fmck010 name="construct.a.page1.fmck010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmck010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck010
            #add-point:ON ACTION controlp INFIELD fmck010 name="construct.c.page1.fmck010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmck011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck011
            #add-point:ON ACTION controlp INFIELD fmck011 name="construct.c.page1.fmck011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmagdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmck011  #顯示到畫面上
            NEXT FIELD fmck011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck011
            #add-point:BEFORE FIELD fmck011 name="construct.b.page1.fmck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck011
            
            #add-point:AFTER FIELD fmck011 name="construct.a.page1.fmck011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck012
            #add-point:BEFORE FIELD fmck012 name="construct.b.page1.fmck012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck012
            
            #add-point:AFTER FIELD fmck012 name="construct.a.page1.fmck012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmck012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck012
            #add-point:ON ACTION controlp INFIELD fmck012 name="construct.c.page1.fmck012"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON fmclseq,fmclseq2,fmcl001,fmcl002,fmcl003,fmcl004,fmcl005,fmcl006
           FROM s_detail2[1].fmclseq,s_detail2[1].fmclseq2,s_detail2[1].fmcl001,s_detail2[1].fmcl002, 
               s_detail2[1].fmcl003,s_detail2[1].fmcl004,s_detail2[1].fmcl005,s_detail2[1].fmcl006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmclseq
            #add-point:BEFORE FIELD fmclseq name="construct.b.page2.fmclseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmclseq
            
            #add-point:AFTER FIELD fmclseq name="construct.a.page2.fmclseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmclseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmclseq
            #add-point:ON ACTION controlp INFIELD fmclseq name="construct.c.page2.fmclseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmclseq2
            #add-point:BEFORE FIELD fmclseq2 name="construct.b.page2.fmclseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmclseq2
            
            #add-point:AFTER FIELD fmclseq2 name="construct.a.page2.fmclseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmclseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmclseq2
            #add-point:ON ACTION controlp INFIELD fmclseq2 name="construct.c.page2.fmclseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl001
            #add-point:BEFORE FIELD fmcl001 name="construct.b.page2.fmcl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl001
            
            #add-point:AFTER FIELD fmcl001 name="construct.a.page2.fmcl001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmcl001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl001
            #add-point:ON ACTION controlp INFIELD fmcl001 name="construct.c.page2.fmcl001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl002
            #add-point:BEFORE FIELD fmcl002 name="construct.b.page2.fmcl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl002
            
            #add-point:AFTER FIELD fmcl002 name="construct.a.page2.fmcl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmcl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl002
            #add-point:ON ACTION controlp INFIELD fmcl002 name="construct.c.page2.fmcl002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl003
            #add-point:BEFORE FIELD fmcl003 name="construct.b.page2.fmcl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl003
            
            #add-point:AFTER FIELD fmcl003 name="construct.a.page2.fmcl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmcl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl003
            #add-point:ON ACTION controlp INFIELD fmcl003 name="construct.c.page2.fmcl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl004
            #add-point:BEFORE FIELD fmcl004 name="construct.b.page2.fmcl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl004
            
            #add-point:AFTER FIELD fmcl004 name="construct.a.page2.fmcl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmcl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl004
            #add-point:ON ACTION controlp INFIELD fmcl004 name="construct.c.page2.fmcl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl005
            #add-point:BEFORE FIELD fmcl005 name="construct.b.page2.fmcl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl005
            
            #add-point:AFTER FIELD fmcl005 name="construct.a.page2.fmcl005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmcl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl005
            #add-point:ON ACTION controlp INFIELD fmcl005 name="construct.c.page2.fmcl005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl006
            #add-point:BEFORE FIELD fmcl006 name="construct.b.page2.fmcl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl006
            
            #add-point:AFTER FIELD fmcl006 name="construct.a.page2.fmcl006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmcl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl006
            #add-point:ON ACTION controlp INFIELD fmcl006 name="construct.c.page2.fmcl006"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON fmcmseq,fmcmseq2,fmcm001,fmcm002,fmcm003,fmcm004
           FROM s_detail3[1].fmcmseq,s_detail3[1].fmcmseq2,s_detail3[1].fmcm001,s_detail3[1].fmcm002, 
               s_detail3[1].fmcm003,s_detail3[1].fmcm004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcmseq
            #add-point:BEFORE FIELD fmcmseq name="construct.b.page3.fmcmseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcmseq
            
            #add-point:AFTER FIELD fmcmseq name="construct.a.page3.fmcmseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmcmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcmseq
            #add-point:ON ACTION controlp INFIELD fmcmseq name="construct.c.page3.fmcmseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcmseq2
            #add-point:BEFORE FIELD fmcmseq2 name="construct.b.page3.fmcmseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcmseq2
            
            #add-point:AFTER FIELD fmcmseq2 name="construct.a.page3.fmcmseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmcmseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcmseq2
            #add-point:ON ACTION controlp INFIELD fmcmseq2 name="construct.c.page3.fmcmseq2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.fmcm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcm001
            #add-point:ON ACTION controlp INFIELD fmcm001 name="construct.c.page3.fmcm001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcm001  #顯示到畫面上
            NEXT FIELD fmcm001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcm001
            #add-point:BEFORE FIELD fmcm001 name="construct.b.page3.fmcm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcm001
            
            #add-point:AFTER FIELD fmcm001 name="construct.a.page3.fmcm001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcm002
            #add-point:BEFORE FIELD fmcm002 name="construct.b.page3.fmcm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcm002
            
            #add-point:AFTER FIELD fmcm002 name="construct.a.page3.fmcm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmcm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcm002
            #add-point:ON ACTION controlp INFIELD fmcm002 name="construct.c.page3.fmcm002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcm003
            #add-point:BEFORE FIELD fmcm003 name="construct.b.page3.fmcm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcm003
            
            #add-point:AFTER FIELD fmcm003 name="construct.a.page3.fmcm003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmcm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcm003
            #add-point:ON ACTION controlp INFIELD fmcm003 name="construct.c.page3.fmcm003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmas002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcm003  #顯示到畫面上
            NEXT FIELD fmcm003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcm004
            #add-point:BEFORE FIELD fmcm004 name="construct.b.page3.fmcm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcm004
            
            #add-point:AFTER FIELD fmcm004 name="construct.a.page3.fmcm004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmcm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcm004
            #add-point:ON ACTION controlp INFIELD fmcm004 name="construct.c.page3.fmcm004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON fmcnseq,fmcnseq2,fmcn001,fmcn002,fmcn003,fmcn004,fmcn005,fmcn006,fmcn007 
 
           FROM s_detail4[1].fmcnseq,s_detail4[1].fmcnseq2,s_detail4[1].fmcn001,s_detail4[1].fmcn002, 
               s_detail4[1].fmcn003,s_detail4[1].fmcn004,s_detail4[1].fmcn005,s_detail4[1].fmcn006,s_detail4[1].fmcn007 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcnseq
            #add-point:BEFORE FIELD fmcnseq name="construct.b.page4.fmcnseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcnseq
            
            #add-point:AFTER FIELD fmcnseq name="construct.a.page4.fmcnseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmcnseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcnseq
            #add-point:ON ACTION controlp INFIELD fmcnseq name="construct.c.page4.fmcnseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcnseq2
            #add-point:BEFORE FIELD fmcnseq2 name="construct.b.page4.fmcnseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcnseq2
            
            #add-point:AFTER FIELD fmcnseq2 name="construct.a.page4.fmcnseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmcnseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcnseq2
            #add-point:ON ACTION controlp INFIELD fmcnseq2 name="construct.c.page4.fmcnseq2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmcn001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn001
            #add-point:ON ACTION controlp INFIELD fmcn001 name="construct.c.page4.fmcn001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcn001  #顯示到畫面上
            NEXT FIELD fmcn001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn001
            #add-point:BEFORE FIELD fmcn001 name="construct.b.page4.fmcn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn001
            
            #add-point:AFTER FIELD fmcn001 name="construct.a.page4.fmcn001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn002
            #add-point:BEFORE FIELD fmcn002 name="construct.b.page4.fmcn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn002
            
            #add-point:AFTER FIELD fmcn002 name="construct.a.page4.fmcn002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmcn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn002
            #add-point:ON ACTION controlp INFIELD fmcn002 name="construct.c.page4.fmcn002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn003
            #add-point:BEFORE FIELD fmcn003 name="construct.b.page4.fmcn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn003
            
            #add-point:AFTER FIELD fmcn003 name="construct.a.page4.fmcn003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmcn003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn003
            #add-point:ON ACTION controlp INFIELD fmcn003 name="construct.c.page4.fmcn003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn004
            #add-point:BEFORE FIELD fmcn004 name="construct.b.page4.fmcn004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn004
            
            #add-point:AFTER FIELD fmcn004 name="construct.a.page4.fmcn004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmcn004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn004
            #add-point:ON ACTION controlp INFIELD fmcn004 name="construct.c.page4.fmcn004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn005
            #add-point:BEFORE FIELD fmcn005 name="construct.b.page4.fmcn005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn005
            
            #add-point:AFTER FIELD fmcn005 name="construct.a.page4.fmcn005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmcn005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn005
            #add-point:ON ACTION controlp INFIELD fmcn005 name="construct.c.page4.fmcn005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn006
            #add-point:BEFORE FIELD fmcn006 name="construct.b.page4.fmcn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn006
            
            #add-point:AFTER FIELD fmcn006 name="construct.a.page4.fmcn006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmcn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn006
            #add-point:ON ACTION controlp INFIELD fmcn006 name="construct.c.page4.fmcn006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn007
            #add-point:BEFORE FIELD fmcn007 name="construct.b.page4.fmcn007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn007
            
            #add-point:AFTER FIELD fmcn007 name="construct.a.page4.fmcn007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmcn007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn007
            #add-point:ON ACTION controlp INFIELD fmcn007 name="construct.c.page4.fmcn007"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table5 ON fmcoseq,fmcoseq2,fmco001,fmco002,fmco003,fmco004,fmco005
           FROM s_detail5[1].fmcoseq,s_detail5[1].fmcoseq2,s_detail5[1].fmco001,s_detail5[1].fmco002, 
               s_detail5[1].fmco003,s_detail5[1].fmco004,s_detail5[1].fmco005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body5.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 5)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcoseq
            #add-point:BEFORE FIELD fmcoseq name="construct.b.page5.fmcoseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcoseq
            
            #add-point:AFTER FIELD fmcoseq name="construct.a.page5.fmcoseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.fmcoseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcoseq
            #add-point:ON ACTION controlp INFIELD fmcoseq name="construct.c.page5.fmcoseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcoseq2
            #add-point:BEFORE FIELD fmcoseq2 name="construct.b.page5.fmcoseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcoseq2
            
            #add-point:AFTER FIELD fmcoseq2 name="construct.a.page5.fmcoseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.fmcoseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcoseq2
            #add-point:ON ACTION controlp INFIELD fmcoseq2 name="construct.c.page5.fmcoseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmco001
            #add-point:BEFORE FIELD fmco001 name="construct.b.page5.fmco001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmco001
            
            #add-point:AFTER FIELD fmco001 name="construct.a.page5.fmco001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.fmco001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmco001
            #add-point:ON ACTION controlp INFIELD fmco001 name="construct.c.page5.fmco001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.fmco002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmco002
            #add-point:ON ACTION controlp INFIELD fmco002 name="construct.c.page5.fmco002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmco002  #顯示到畫面上
            NEXT FIELD fmco002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmco002
            #add-point:BEFORE FIELD fmco002 name="construct.b.page5.fmco002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmco002
            
            #add-point:AFTER FIELD fmco002 name="construct.a.page5.fmco002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmco003
            #add-point:BEFORE FIELD fmco003 name="construct.b.page5.fmco003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmco003
            
            #add-point:AFTER FIELD fmco003 name="construct.a.page5.fmco003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.fmco003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmco003
            #add-point:ON ACTION controlp INFIELD fmco003 name="construct.c.page5.fmco003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmco004
            #add-point:BEFORE FIELD fmco004 name="construct.b.page5.fmco004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmco004
            
            #add-point:AFTER FIELD fmco004 name="construct.a.page5.fmco004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.fmco004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmco004
            #add-point:ON ACTION controlp INFIELD fmco004 name="construct.c.page5.fmco004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmco005
            #add-point:BEFORE FIELD fmco005 name="construct.b.page5.fmco005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmco005
            
            #add-point:AFTER FIELD fmco005 name="construct.a.page5.fmco005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.fmco005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmco005
            #add-point:ON ACTION controlp INFIELD fmco005 name="construct.c.page5.fmco005"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
            INITIALIZE g_wc2_table4 TO NULL
 
            INITIALIZE g_wc2_table5 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "fmcj_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fmck_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fmcl_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "fmcm_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "fmcn_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "fmco_t" 
                     LET g_wc2_table5 = la_wc[li_idx].wc
 
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
 
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   #161104-00046#15-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#15-----e
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt035_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_fmck_d.clear()
   CALL g_fmck2_d.clear()
   CALL g_fmck3_d.clear()
   CALL g_fmck4_d.clear()
   CALL g_fmck5_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afmt035_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt035_browser_fill("")
      CALL afmt035_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL afmt035_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afmt035_fetch("F") 
      #顯示單身筆數
      CALL afmt035_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt035_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_fmcj_m.fmcjdocno = g_browser[g_current_idx].b_fmcjdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afmt035_master_referesh USING g_fmcj_m.fmcjdocno INTO g_fmcj_m.fmcjsite,g_fmcj_m.fmcjcomp, 
       g_fmcj_m.fmcj001,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj002, 
       g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005,g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus, 
       g_fmcj_m.fmcjownid,g_fmcj_m.fmcjowndp,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdt, 
       g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid,g_fmcj_m.fmcjcnfdt,g_fmcj_m.fmcjsite_desc, 
       g_fmcj_m.fmcjcomp_desc,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcjownid_desc,g_fmcj_m.fmcjowndp_desc, 
       g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp_desc,g_fmcj_m.fmcjmodid_desc,g_fmcj_m.fmcjcnfid_desc 
 
   
   #遮罩相關處理
   LET g_fmcj_m_mask_o.* =  g_fmcj_m.*
   CALL afmt035_fmcj_t_mask()
   LET g_fmcj_m_mask_n.* =  g_fmcj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt035_set_act_visible()   
   CALL afmt035_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_fmcj_m.fmcj005 = '5' THEN
      CALL cl_set_act_visible("open_afmt035_01",FALSE)
   ELSE
      CALL cl_set_act_visible("open_afmt035_01", TRUE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   CALL afmt035_fmcjsite_ref()
   #end add-point
   
   #保存單頭舊值
   LET g_fmcj_m_t.* = g_fmcj_m.*
   LET g_fmcj_m_o.* = g_fmcj_m.*
   
   LET g_data_owner = g_fmcj_m.fmcjownid      
   LET g_data_dept  = g_fmcj_m.fmcjowndp
   
   #重新顯示   
   CALL afmt035_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt035_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fmck_d.clear()   
   CALL g_fmck2_d.clear()  
   CALL g_fmck3_d.clear()  
   CALL g_fmck4_d.clear()  
   CALL g_fmck5_d.clear()  
 
 
   INITIALIZE g_fmcj_m.* TO NULL             #DEFAULT 設定
   
   LET g_fmcjdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmcj_m.fmcjownid = g_user
      LET g_fmcj_m.fmcjowndp = g_dept
      LET g_fmcj_m.fmcjcrtid = g_user
      LET g_fmcj_m.fmcjcrtdp = g_dept 
      LET g_fmcj_m.fmcjcrtdt = cl_get_current()
      LET g_fmcj_m.fmcjmodid = g_user
      LET g_fmcj_m.fmcjmoddt = cl_get_current()
      LET g_fmcj_m.fmcjstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_fmcj_m.fmcj008 = "N"
      LET g_fmcj_m.fmcj005 = "5"
      LET g_fmcj_m.fmcj009 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_fmcj_m.fmcj005 = "5"
      LET g_fmcj_m.fmcj009 = "360"
      LET g_fmcj_m.fmcjsite = g_site
      LET g_fmcj_m.fmcjsite_desc = s_desc_get_department_desc(g_fmcj_m.fmcjsite)
      DISPLAY BY NAME g_fmcj_m.fmcjsite_desc
      CALL afmt035_ooef017(g_fmcj_m.fmcjsite) RETURNING g_fmcj_m.fmcjcomp,g_fmcj_m.fmcjcomp_desc
      DISPLAY BY NAME g_fmcj_m.fmcjcomp,g_fmcj_m.fmcjcomp_desc
      CALL afmt035_fmcjsite_ref()
      LET g_fmcj_m.fmcjdocdt = g_today
      DISPLAY BY NAME g_fmcj_m.fmcjdocdt
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_fmcj_m_t.* = g_fmcj_m.*
      LET g_fmcj_m_o.* = g_fmcj_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmcj_m.fmcjstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
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
 
 
 
    
      CALL afmt035_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_fmcj_m.* TO NULL
         INITIALIZE g_fmck_d TO NULL
         INITIALIZE g_fmck2_d TO NULL
         INITIALIZE g_fmck3_d TO NULL
         INITIALIZE g_fmck4_d TO NULL
         INITIALIZE g_fmck5_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afmt035_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fmck_d.clear()
      #CALL g_fmck2_d.clear()
      #CALL g_fmck3_d.clear()
      #CALL g_fmck4_d.clear()
      #CALL g_fmck5_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt035_set_act_visible()   
   CALL afmt035_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmcjdocno_t = g_fmcj_m.fmcjdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmcjent = " ||g_enterprise|| " AND",
                      " fmcjdocno = '", g_fmcj_m.fmcjdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt035_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afmt035_cl
   
   CALL afmt035_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt035_master_referesh USING g_fmcj_m.fmcjdocno INTO g_fmcj_m.fmcjsite,g_fmcj_m.fmcjcomp, 
       g_fmcj_m.fmcj001,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj002, 
       g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005,g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus, 
       g_fmcj_m.fmcjownid,g_fmcj_m.fmcjowndp,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdt, 
       g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid,g_fmcj_m.fmcjcnfdt,g_fmcj_m.fmcjsite_desc, 
       g_fmcj_m.fmcjcomp_desc,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcjownid_desc,g_fmcj_m.fmcjowndp_desc, 
       g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp_desc,g_fmcj_m.fmcjmodid_desc,g_fmcj_m.fmcjcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_fmcj_m_mask_o.* =  g_fmcj_m.*
   CALL afmt035_fmcj_t_mask()
   LET g_fmcj_m_mask_n.* =  g_fmcj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmcj_m.fmcjsite,g_fmcj_m.fmcjsite_desc,g_fmcj_m.fmcjcomp,g_fmcj_m.fmcjcomp_desc, 
       g_fmcj_m.fmcj001,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt, 
       g_fmcj_m.fmcj002,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005, 
       g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus,g_fmcj_m.fmcjownid,g_fmcj_m.fmcjownid_desc,g_fmcj_m.fmcjowndp, 
       g_fmcj_m.fmcjowndp_desc,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdp_desc, 
       g_fmcj_m.fmcjcrtdt,g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmodid_desc,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid, 
       g_fmcj_m.fmcjcnfid_desc,g_fmcj_m.fmcjcnfdt
   
   #add-point:新增結束後 name="insert.after"
   IF g_fmcj_m.fmcj005 = '5' THEN
      CALL cl_set_act_visible("open_afmt035_01",FALSE)
   ELSE
      CALL cl_set_act_visible("open_afmt035_01", TRUE)
   END IF
   #end add-point 
   
   LET g_data_owner = g_fmcj_m.fmcjownid      
   LET g_data_dept  = g_fmcj_m.fmcjowndp
   
   #功能已完成,通報訊息中心
   CALL afmt035_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt035_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
   DEFINE l_wc2_table5   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fmcj_m_t.* = g_fmcj_m.*
   LET g_fmcj_m_o.* = g_fmcj_m.*
   
   IF g_fmcj_m.fmcjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_fmcjdocno_t = g_fmcj_m.fmcjdocno
 
   CALL s_transaction_begin()
   
   OPEN afmt035_cl USING g_enterprise,g_fmcj_m.fmcjdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt035_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt035_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt035_master_referesh USING g_fmcj_m.fmcjdocno INTO g_fmcj_m.fmcjsite,g_fmcj_m.fmcjcomp, 
       g_fmcj_m.fmcj001,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj002, 
       g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005,g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus, 
       g_fmcj_m.fmcjownid,g_fmcj_m.fmcjowndp,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdt, 
       g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid,g_fmcj_m.fmcjcnfdt,g_fmcj_m.fmcjsite_desc, 
       g_fmcj_m.fmcjcomp_desc,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcjownid_desc,g_fmcj_m.fmcjowndp_desc, 
       g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp_desc,g_fmcj_m.fmcjmodid_desc,g_fmcj_m.fmcjcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT afmt035_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmcj_m_mask_o.* =  g_fmcj_m.*
   CALL afmt035_fmcj_t_mask()
   LET g_fmcj_m_mask_n.* =  g_fmcj_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
   #LET l_wc2_table5 = g_wc2_table5
   #LET l_wc2_table5 = " 1=1"
 
 
 
   
   CALL afmt035_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
   #LET  g_wc2_table5 = l_wc2_table5 
 
 
 
    
   WHILE TRUE
      LET g_fmcjdocno_t = g_fmcj_m.fmcjdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_fmcj_m.fmcjmodid = g_user 
LET g_fmcj_m.fmcjmoddt = cl_get_current()
LET g_fmcj_m.fmcjmodid_desc = cl_get_username(g_fmcj_m.fmcjmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afmt035_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE fmcj_t SET (fmcjmodid,fmcjmoddt) = (g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmoddt)
          WHERE fmcjent = g_enterprise AND fmcjdocno = g_fmcjdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_fmcj_m.* = g_fmcj_m_t.*
            CALL afmt035_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_fmcj_m.fmcjdocno != g_fmcj_m_t.fmcjdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE fmck_t SET fmckdocno = g_fmcj_m.fmcjdocno
 
          WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m_t.fmcjdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmck_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmck_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE fmcl_t
            SET fmcldocno = g_fmcj_m.fmcjdocno
 
          WHERE fmclent = g_enterprise AND
                fmcldocno = g_fmcjdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmcl_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmcl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE fmcm_t
            SET fmcmdocno = g_fmcj_m.fmcjdocno
 
          WHERE fmcment = g_enterprise AND
                fmcmdocno = g_fmcjdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmcm_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmcm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update4"
         
         #end add-point
         
         UPDATE fmcn_t
            SET fmcndocno = g_fmcj_m.fmcjdocno
 
          WHERE fmcnent = g_enterprise AND
                fmcndocno = g_fmcjdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmcn_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmcn_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update5"
         
         #end add-point
         
         UPDATE fmco_t
            SET fmcodocno = g_fmcj_m.fmcjdocno
 
          WHERE fmcoent = g_enterprise AND
                fmcodocno = g_fmcjdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update5"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmco_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmco_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update5"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt035_set_act_visible()   
   CALL afmt035_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmcjent = " ||g_enterprise|| " AND",
                      " fmcjdocno = '", g_fmcj_m.fmcjdocno, "' "
 
   #填到對應位置
   CALL afmt035_browser_fill("")
 
   CLOSE afmt035_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt035_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afmt035.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt035_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_sql                 STRING
   DEFINE  l_nmaastus            LIKE nmaa_t.nmaastus
   DEFINE  l_fmagstus            LIKE fmag_t.fmagstus
   DEFINE  l_fmcl006             LIKE fmcl_t.fmcl006
   DEFINE  l_fmck004             LIKE fmck_t.fmck004
   DEFINE  l_fmcm004             LIKE fmcm_t.fmcm004
   DEFINE  l_fmck002             LIKE fmck_t.fmck002
   DEFINE  l_fmck003             LIKE fmck_t.fmck003
   DEFINE  l_fmck007             LIKE fmck_t.fmck007
   DEFINE  l_rate                LIKE type_t.num20_6
   DEFINE  l_flag                LIKE type_t.num5      #161104-00046#15
   DEFINE  l_slip                LIKE ooba_t.ooba002   #161104-00046#15
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmcj_m.fmcjsite,g_fmcj_m.fmcjsite_desc,g_fmcj_m.fmcjcomp,g_fmcj_m.fmcjcomp_desc, 
       g_fmcj_m.fmcj001,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt, 
       g_fmcj_m.fmcj002,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005, 
       g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus,g_fmcj_m.fmcjownid,g_fmcj_m.fmcjownid_desc,g_fmcj_m.fmcjowndp, 
       g_fmcj_m.fmcjowndp_desc,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdp_desc, 
       g_fmcj_m.fmcjcrtdt,g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmodid_desc,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid, 
       g_fmcj_m.fmcjcnfid_desc,g_fmcj_m.fmcjcnfdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT fmckseq,fmck002,fmck003,fmck004,fmck005,fmck006,fmck007,fmck008,fmck009, 
       fmck010,fmck011,fmck012 FROM fmck_t WHERE fmckent=? AND fmckdocno=? AND fmckseq=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt035_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT fmclseq,fmclseq2,fmcl001,fmcl002,fmcl003,fmcl004,fmcl005,fmcl006 FROM  
       fmcl_t WHERE fmclent=? AND fmcldocno=? AND fmclseq=? AND fmclseq2=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt035_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT fmcmseq,fmcmseq2,fmcm001,fmcm002,fmcm003,fmcm004 FROM fmcm_t WHERE fmcment=?  
       AND fmcmdocno=? AND fmcmseq=? AND fmcmseq2=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt035_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT fmcnseq,fmcnseq2,fmcn001,fmcn002,fmcn003,fmcn004,fmcn005,fmcn006,fmcn007  
       FROM fmcn_t WHERE fmcnent=? AND fmcndocno=? AND fmcnseq=? AND fmcnseq2=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt035_bcl4 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql5"
   
   #end add-point    
   LET g_forupd_sql = "SELECT fmcoseq,fmcoseq2,fmco001,fmco002,fmco003,fmco004,fmco005 FROM fmco_t WHERE  
       fmcoent=? AND fmcodocno=? AND fmcoseq=? AND fmcoseq2=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql5"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt035_bcl5 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afmt035_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt035_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fmcj_m.fmcjsite,g_fmcj_m.fmcjcomp,g_fmcj_m.fmcj001,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007, 
       g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj002,g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004, 
       g_fmcj_m.fmcj005,g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afmt035.input.head" >}
      #單頭段
      INPUT BY NAME g_fmcj_m.fmcjsite,g_fmcj_m.fmcjcomp,g_fmcj_m.fmcj001,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007, 
          g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj002,g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004, 
          g_fmcj_m.fmcj005,g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afmt035_cl USING g_enterprise,g_fmcj_m.fmcjdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt035_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt035_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afmt035_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL afmt035_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjsite
            
            #add-point:AFTER FIELD fmcjsite name="input.a.fmcjsite"
            IF NOT cl_null(g_fmcj_m.fmcjsite) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmcj_m.fmcjsite

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_42") THEN
                  #檢查成功時後續處理
                  CALL afmt035_ooef017(g_fmcj_m.fmcjsite) RETURNING g_fmcj_m.fmcjcomp,g_fmcj_m.fmcjcomp_desc
                  DISPLAY BY NAME g_fmcj_m.fmcjcomp,g_fmcj_m.fmcjcomp_desc
                  CALL afmt035_fmcjsite_ref()
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcj_m.fmcjsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcj_m.fmcjsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcj_m.fmcjsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjsite
            #add-point:BEFORE FIELD fmcjsite name="input.b.fmcjsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcjsite
            #add-point:ON CHANGE fmcjsite name="input.g.fmcjsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjcomp
            
            #add-point:AFTER FIELD fmcjcomp name="input.a.fmcjcomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcj_m.fmcjcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcj_m.fmcjcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcj_m.fmcjcomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjcomp
            #add-point:BEFORE FIELD fmcjcomp name="input.b.fmcjcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcjcomp
            #add-point:ON CHANGE fmcjcomp name="input.g.fmcjcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj001
            
            #add-point:AFTER FIELD fmcj001 name="input.a.fmcj001"
            IF NOT cl_null(g_fmcj_m.fmcj001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmcj_m.fmcj001
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afm-00140:sub-01302|afmi010|",cl_get_progname("afmi010",g_lang,"2"),"|:EXEPROGafmi010"
               #160318-00025#6--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_fmaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcj_m.fmcj001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcj_m.fmcj001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcj_m.fmcj001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj001
            #add-point:BEFORE FIELD fmcj001 name="input.b.fmcj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj001
            #add-point:ON CHANGE fmcj001 name="input.g.fmcj001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj006
            #add-point:BEFORE FIELD fmcj006 name="input.b.fmcj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj006
            
            #add-point:AFTER FIELD fmcj006 name="input.a.fmcj006"
            CALL afmt035_fmcj006_chk()
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fmcj_m.fmcj006||g_fmcj_m.fmcj007
               LET g_errparam.code   = g_errno 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj006
            #add-point:ON CHANGE fmcj006 name="input.g.fmcj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj007
            #add-point:BEFORE FIELD fmcj007 name="input.b.fmcj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj007
            
            #add-point:AFTER FIELD fmcj007 name="input.a.fmcj007"
            CALL afmt035_fmcj006_chk()
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fmcj_m.fmcj006||g_fmcj_m.fmcj007
               LET g_errparam.code   = g_errno 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj007
            #add-point:ON CHANGE fmcj007 name="input.g.fmcj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjdocno
            #add-point:BEFORE FIELD fmcjdocno name="input.b.fmcjdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjdocno
            
            #add-point:AFTER FIELD fmcjdocno name="input.a.fmcjdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_fmcj_m.fmcjdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmcj_m.fmcjdocno != g_fmcjdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcj_t WHERE "||"fmcjent = '" ||g_enterprise|| "' AND "||"fmcjdocno = '"||g_fmcj_m.fmcjdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_fmcj_m.fmcjdocno) THEN
                  CALL s_aooi200_fin_chk_slip(g_glaald,g_glaa024,g_fmcj_m.fmcjdocno,'afmt035') RETURNING l_success
                  IF l_success = FALSE THEN
                     LET g_fmcj_m.fmcjdocno = g_fmcj_m_t.fmcjdocno
                     NEXT FIELD fmcjdocno                       
                  END IF
                  #161104-00046#15-----s
                  CALL s_control_chk_doc('1',g_fmcj_m.fmcjdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
                  IF g_sub_success AND l_flag THEN             
                  ELSE
                     LET g_fmcj_m.fmcjdocno = g_fmcj_m_o.fmcjdocno 
                     NEXT FIELD CURRENT                  
                  END IF
                  CALL s_aooi200_fin_get_slip(g_fmcj_m.fmcjdocno) RETURNING g_sub_success,l_slip
                  #刪除單別預設temptable
                  DELETE FROM s_aooi200def1
                  #以目前畫面資訊新增temp資料   #請勿調整.*
                  INSERT INTO s_aooi200def1 VALUES(g_fmcj_m.*)
                  #依單別預設取用資訊
                  CALL s_aooi200def_get('','',g_fmcj_m.fmcjsite,'2',l_slip,'','',g_glaald)
                  #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
                  SELECT * INTO g_fmcj_m.* FROM s_aooi200def1
                  #161104-00046#15-----e  
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcjdocno
            #add-point:ON CHANGE fmcjdocno name="input.g.fmcjdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjdocdt
            #add-point:BEFORE FIELD fmcjdocdt name="input.b.fmcjdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjdocdt
            
            #add-point:AFTER FIELD fmcjdocdt name="input.a.fmcjdocdt"
            CALL s_anm_date_chk(g_fmcj_m.fmcjsite,g_fmcj_m.fmcjdocdt) RETURNING l_success
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "afm-00206"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcjdocdt
            #add-point:ON CHANGE fmcjdocdt name="input.g.fmcjdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj002
            
            #add-point:AFTER FIELD fmcj002 name="input.a.fmcj002"
            IF NOT cl_null(g_fmcj_m.fmcj002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmcj_m.fmcj002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_fmac003") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcj_m.fmcj002
            CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcj_m.fmcj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcj_m.fmcj002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj002
            #add-point:BEFORE FIELD fmcj002 name="input.b.fmcj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj002
            #add-point:ON CHANGE fmcj002 name="input.g.fmcj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj008
            #add-point:BEFORE FIELD fmcj008 name="input.b.fmcj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj008
            
            #add-point:AFTER FIELD fmcj008 name="input.a.fmcj008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj008
            #add-point:ON CHANGE fmcj008 name="input.g.fmcj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj003
            #add-point:BEFORE FIELD fmcj003 name="input.b.fmcj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj003
            
            #add-point:AFTER FIELD fmcj003 name="input.a.fmcj003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj003
            #add-point:ON CHANGE fmcj003 name="input.g.fmcj003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj004
            
            #add-point:AFTER FIELD fmcj004 name="input.a.fmcj004"
            IF NOT cl_null(g_fmcj_m.fmcj004) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmcj_m.fmcj004
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "abm-00079:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#6--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_fmac001") THEN
                  #檢查成功時後續處理
                  SELECT COUNT(*) INTO l_n FROM fmac_t
                   WHERE fmacent = g_enterprise AND fmac001 = g_fmcj_m.fmcj004 
                     AND fmac003 = g_fmcj_m.fmcj002
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmcj_m.fmcj004
                     LET g_errparam.code   = 'afm-00158'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj004
            #add-point:BEFORE FIELD fmcj004 name="input.b.fmcj004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj004
            #add-point:ON CHANGE fmcj004 name="input.g.fmcj004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj005
            #add-point:BEFORE FIELD fmcj005 name="input.b.fmcj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj005
            
            #add-point:AFTER FIELD fmcj005 name="input.a.fmcj005"
            IF g_fmcj_m.fmcj005 = '5' THEN
               CALL cl_set_act_visible("open_afmt035_01",FALSE)
            ELSE
               CALL cl_set_act_visible("open_afmt035_01", TRUE)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj005
            #add-point:ON CHANGE fmcj005 name="input.g.fmcj005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcj009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmcj_m.fmcj009,"1","1","365","1","azz-00087",1) THEN
               NEXT FIELD fmcj009
            END IF 
 
 
 
            #add-point:AFTER FIELD fmcj009 name="input.a.fmcj009"
            IF NOT cl_null(g_fmcj_m.fmcj009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcj009
            #add-point:BEFORE FIELD fmcj009 name="input.b.fmcj009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcj009
            #add-point:ON CHANGE fmcj009 name="input.g.fmcj009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcjstus
            #add-point:BEFORE FIELD fmcjstus name="input.b.fmcjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcjstus
            
            #add-point:AFTER FIELD fmcjstus name="input.a.fmcjstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcjstus
            #add-point:ON CHANGE fmcjstus name="input.g.fmcjstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmcjsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjsite
            #add-point:ON ACTION controlp INFIELD fmcjsite name="input.c.fmcjsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcj_m.fmcjsite             #給予default值
            LET g_qryparam.default2 = "" #g_fmcj_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #


            #CALL q_ooef001()                       #161006-00005#42   mark
            CALL q_ooef001_33()                     #161006-00005#42   add                                #呼叫開窗

            LET g_fmcj_m.fmcjsite = g_qryparam.return1              
            #LET g_fmcj_m.ooef001 = g_qryparam.return2 
            DISPLAY g_fmcj_m.fmcjsite TO fmcjsite              #
            CALL afmt035_ooef017(g_fmcj_m.fmcjsite) RETURNING g_fmcj_m.fmcjcomp,g_fmcj_m.fmcjcomp_desc
            DISPLAY BY NAME g_fmcj_m.fmcjcomp,g_fmcj_m.fmcjcomp_desc
            CALL afmt035_fmcjsite_ref()
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcj_m.fmcjsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcj_m.fmcjsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcj_m.fmcjsite_desc
            #DISPLAY g_fmcj_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD fmcjsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmcjcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjcomp
            #add-point:ON ACTION controlp INFIELD fmcjcomp name="input.c.fmcjcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj001
            #add-point:ON ACTION controlp INFIELD fmcj001 name="input.c.fmcj001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcj_m.fmcj001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_fmaa001_1()                                #呼叫開窗

            LET g_fmcj_m.fmcj001 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcj_m.fmcj001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcj_m.fmcj001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcj_m.fmcj001_desc

            DISPLAY g_fmcj_m.fmcj001 TO fmcj001              #

            NEXT FIELD fmcj001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmcj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj006
            #add-point:ON ACTION controlp INFIELD fmcj006 name="input.c.fmcj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj007
            #add-point:ON ACTION controlp INFIELD fmcj007 name="input.c.fmcj007"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjdocno
            #add-point:ON ACTION controlp INFIELD fmcjdocno name="input.c.fmcjdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcj_m.fmcjdocno             #給予default值
            LET g_qryparam.where = "ooba001 = '",g_glaa024,"' AND oobx003 = 'afmt035'"
            #給予arg
            LET g_qryparam.arg1 = "" #
            #161104-00046#15-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#15-----e

            CALL q_ooba002_4()                                #呼叫開窗

            LET g_fmcj_m.fmcjdocno = g_qryparam.return1       
            LET g_qryparam.where = ""            

            DISPLAY g_fmcj_m.fmcjdocno TO fmcjdocno              #

            NEXT FIELD fmcjdocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.fmcjdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjdocdt
            #add-point:ON ACTION controlp INFIELD fmcjdocdt name="input.c.fmcjdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj002
            #add-point:ON ACTION controlp INFIELD fmcj002 name="input.c.fmcj002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcj_m.fmcj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_nmab001()                                #呼叫開窗

            LET g_fmcj_m.fmcj002 = g_qryparam.return1              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcj_m.fmcj002
            CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcj_m.fmcj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcj_m.fmcj002_desc

            DISPLAY g_fmcj_m.fmcj002 TO fmcj002              #

            NEXT FIELD fmcj002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmcj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj008
            #add-point:ON ACTION controlp INFIELD fmcj008 name="input.c.fmcj008"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj003
            #add-point:ON ACTION controlp INFIELD fmcj003 name="input.c.fmcj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj004
            #add-point:ON ACTION controlp INFIELD fmcj004 name="input.c.fmcj004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcj_m.fmcj004             #給予default值
            
            IF NOT cl_null(g_fmcj_m.fmcj002) THEN
               LET g_qryparam.where = " fmac003 = '",g_fmcj_m.fmcj002,"'"
            END IF

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_fmac001()                                #呼叫開窗

            LET g_fmcj_m.fmcj004 = g_qryparam.return1              

            DISPLAY g_fmcj_m.fmcj004 TO fmcj004              #
            LET g_qryparam.where = ""

            NEXT FIELD fmcj004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmcj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj005
            #add-point:ON ACTION controlp INFIELD fmcj005 name="input.c.fmcj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcj009
            #add-point:ON ACTION controlp INFIELD fmcj009 name="input.c.fmcj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcjstus
            #add-point:ON ACTION controlp INFIELD fmcjstus name="input.c.fmcjstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_fmcj_m.fmcjdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_prog)
                     RETURNING l_success,g_fmcj_m.fmcjdocno
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_fmcj_m.fmcjdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD fmcjdocno
               END IF
               DISPLAY BY NAME g_fmcj_m.fmcjdocno
               #end add-point
               
               INSERT INTO fmcj_t (fmcjent,fmcjsite,fmcjcomp,fmcj001,fmcj006,fmcj007,fmcjdocno,fmcjdocdt, 
                   fmcj002,fmcj008,fmcj003,fmcj004,fmcj005,fmcj009,fmcjstus,fmcjownid,fmcjowndp,fmcjcrtid, 
                   fmcjcrtdp,fmcjcrtdt,fmcjmodid,fmcjmoddt,fmcjcnfid,fmcjcnfdt)
               VALUES (g_enterprise,g_fmcj_m.fmcjsite,g_fmcj_m.fmcjcomp,g_fmcj_m.fmcj001,g_fmcj_m.fmcj006, 
                   g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj002,g_fmcj_m.fmcj008, 
                   g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005,g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus, 
                   g_fmcj_m.fmcjownid,g_fmcj_m.fmcjowndp,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdt, 
                   g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid,g_fmcj_m.fmcjcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_fmcj_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL afmt035_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afmt035_b_fill()
                  CALL afmt035_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afmt035_fmcj_t_mask_restore('restore_mask_o')
               
               UPDATE fmcj_t SET (fmcjsite,fmcjcomp,fmcj001,fmcj006,fmcj007,fmcjdocno,fmcjdocdt,fmcj002, 
                   fmcj008,fmcj003,fmcj004,fmcj005,fmcj009,fmcjstus,fmcjownid,fmcjowndp,fmcjcrtid,fmcjcrtdp, 
                   fmcjcrtdt,fmcjmodid,fmcjmoddt,fmcjcnfid,fmcjcnfdt) = (g_fmcj_m.fmcjsite,g_fmcj_m.fmcjcomp, 
                   g_fmcj_m.fmcj001,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt, 
                   g_fmcj_m.fmcj002,g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005, 
                   g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus,g_fmcj_m.fmcjownid,g_fmcj_m.fmcjowndp,g_fmcj_m.fmcjcrtid, 
                   g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdt,g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid, 
                   g_fmcj_m.fmcjcnfdt)
                WHERE fmcjent = g_enterprise AND fmcjdocno = g_fmcjdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fmcj_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               IF g_fmcj_m.fmcj005 <> g_fmcj_m_t.fmcj005 THEN
                  CALL afmt035_fmcp_upd()
               END IF
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afmt035_fmcj_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_fmcj_m_t)
               LET g_log2 = util.JSON.stringify(g_fmcj_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_fmcjdocno_t = g_fmcj_m.fmcjdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afmt035.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fmck_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmck_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt035_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fmck_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afmt035_cl USING g_enterprise,g_fmcj_m.fmcjdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt035_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt035_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmck_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmck_d[l_ac].fmckseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fmck_d_t.* = g_fmck_d[l_ac].*  #BACKUP
               LET g_fmck_d_o.* = g_fmck_d[l_ac].*  #BACKUP
               CALL afmt035_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afmt035_set_no_entry_b(l_cmd)
               IF NOT afmt035_lock_b("fmck_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt035_bcl INTO g_fmck_d[l_ac].fmckseq,g_fmck_d[l_ac].fmck002,g_fmck_d[l_ac].fmck003, 
                      g_fmck_d[l_ac].fmck004,g_fmck_d[l_ac].fmck005,g_fmck_d[l_ac].fmck006,g_fmck_d[l_ac].fmck007, 
                      g_fmck_d[l_ac].fmck008,g_fmck_d[l_ac].fmck009,g_fmck_d[l_ac].fmck010,g_fmck_d[l_ac].fmck011, 
                      g_fmck_d[l_ac].fmck012
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmck_d_t.fmckseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmck_d_mask_o[l_ac].* =  g_fmck_d[l_ac].*
                  CALL afmt035_fmck_t_mask()
                  LET g_fmck_d_mask_n[l_ac].* =  g_fmck_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt035_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmck_d[l_ac].* TO NULL 
            INITIALIZE g_fmck_d_t.* TO NULL 
            INITIALIZE g_fmck_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_fmck_d[l_ac].fmckseq = "0"
      LET g_fmck_d[l_ac].fmck004 = "0"
      LET g_fmck_d[l_ac].fmck007 = "0"
      LET g_fmck_d[l_ac].fmck008 = "0"
      LET g_fmck_d[l_ac].fmck009 = "0"
      LET g_fmck_d[l_ac].fmck010 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_fmck_d[l_ac].fmck012 = ""
            IF l_cmd = 'a' THEN
               IF cl_null(g_fmck_d[l_ac].fmckseq) OR g_fmck_d[l_ac].fmckseq = 0 THEN
                  SELECT MAX(fmckseq) INTO g_fmck_d[l_ac].fmckseq
                    FROM fmck_t
                   WHERE fmckent = g_enterprise
                     AND fmckdocno = g_fmcj_m.fmcjdocno
               
                  IF cl_null(g_fmck_d[l_ac].fmckseq) THEN
                     LET g_fmck_d[l_ac].fmckseq = 1
                  ELSE
                     LET g_fmck_d[l_ac].fmckseq = g_fmck_d[l_ac].fmckseq + 1
                  END IF
               END IF
            END IF
            #end add-point
            LET g_fmck_d_t.* = g_fmck_d[l_ac].*     #新輸入資料
            LET g_fmck_d_o.* = g_fmck_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt035_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
         
            #end add-point
            CALL afmt035_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmck_d[li_reproduce_target].* = g_fmck_d[li_reproduce].*
 
               LET g_fmck_d[li_reproduce_target].fmckseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fmck_t 
             WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
 
               AND fmckseq = g_fmck_d[l_ac].fmckseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcj_m.fmcjdocno
               LET gs_keys[2] = g_fmck_d[g_detail_idx].fmckseq
               CALL afmt035_insert_b('fmck_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_fmck_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmck_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt035_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fmcj_m.fmcjdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_fmck_d_t.fmckseq
 
            
               #刪除同層單身
               IF NOT afmt035_delete_b('fmck_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt035_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt035_key_delete_b(gs_keys,'fmck_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt035_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt035_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
              
               #end add-point
               LET l_count = g_fmck_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmck_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmckseq
            #add-point:BEFORE FIELD fmckseq name="input.b.page1.fmckseq"
            IF cl_null(g_fmck_d[l_ac].fmckseq) OR g_fmck_d[l_ac].fmckseq = 0 THEN
               SELECT MAX(fmckseq) INTO g_fmck_d[l_ac].fmckseq
                 FROM fmck_t
                WHERE fmckent = g_enterprise
                  AND fmckdocno = g_fmcj_m.fmcjdocno
            
               IF cl_null(g_fmck_d[l_ac].fmckseq) THEN
                  LET g_fmck_d[l_ac].fmckseq = 1
               ELSE
                  LET g_fmck_d[l_ac].fmckseq = g_fmck_d[l_ac].fmckseq + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmckseq
            
            #add-point:AFTER FIELD fmckseq name="input.a.page1.fmckseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcj_m.fmcjdocno IS NOT NULL AND g_fmck_d[g_detail_idx].fmckseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcj_m.fmcjdocno != g_fmcjdocno_t OR g_fmck_d[g_detail_idx].fmckseq != g_fmck_d_t.fmckseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmck_t WHERE "||"fmckent = '" ||g_enterprise|| "' AND "||"fmckdocno = '"||g_fmcj_m.fmcjdocno ||"' AND "|| "fmckseq = '"||g_fmck_d[g_detail_idx].fmckseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmckseq
            #add-point:ON CHANGE fmckseq name="input.g.page1.fmckseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck002
            
            #add-point:AFTER FIELD fmck002 name="input.a.page1.fmck002"
            IF NOT cl_null(g_fmck_d[l_ac].fmck002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa026
               LET g_chkparam.arg2 = g_fmck_d[l_ac].fmck002
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#6--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002_1") THEN
                  #檢查成功時後續處理
                  LET l_sql = " SELECT nmas002 FROM nmaa_t,nmas_t ",
                              "  WHERE nmasent = nmaaent AND nmas001 = nma001 ",
                              "    AND nmaaent = ",g_enterprise," AND nmaa002 = '",g_fmcj_m.fmcjsite,
                              "    AND nmaa004 = '",g_fmcj_m.fmcj002,"' AND nmas003 = '",g_fmck_d[l_ac].fmck002,"'",
                              "    AND nmaastus = 'Y'"
                  PREPARE nmas002_prep FROM l_sql
                  DECLARE nmas002_curs SCROLL CURSOR WITH HOLD FOR nmas002_prep
                  OPEN nmas002_curs
                  FETCH FIRST nmas002_curs INTO g_fmck_d[l_ac].fmck003
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmck_d[l_ac].fmck002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmck_d[l_ac].fmck002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmck_d[l_ac].fmck002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck002
            #add-point:BEFORE FIELD fmck002 name="input.b.page1.fmck002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmck002
            #add-point:ON CHANGE fmck002 name="input.g.page1.fmck002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck003
            #add-point:BEFORE FIELD fmck003 name="input.b.page1.fmck003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck003
            
            #add-point:AFTER FIELD fmck003 name="input.a.page1.fmck003"
            IF NOT cl_null(g_fmck_d[l_ac].fmck003) THEN
               LET l_n = 0
               SELECT nmaastus INTO l_nmaastus FROM nmaa_t,nmas_t 
                WHERE nmasent = nmaaent AND nmas001 = nmaa001 
                  AND nmaaent = g_enterprise AND nmaa002 = g_fmcj_m.fmcjsite
                  AND nmaa004 = g_fmcj_m.fmcj002 AND nmas003 = g_fmck_d[l_ac].fmck002
                  AND nmas002 = g_fmck_d[l_ac].fmck003
               IF SQLCA.SQLCODE = 100 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck_d[l_ac].fmck003
                  LET g_errparam.code   = 'afm-00159' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_fmck_d[l_ac].fmck003 = g_fmck_d_t.fmck003
                  NEXT FIELD CURRENT
               END IF
               IF l_nmaastus = 'N' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck_d[l_ac].fmck003
                  LET g_errparam.code   = 'afm-00160' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_fmck_d[l_ac].fmck003 = g_fmck_d_t.fmck003
                  NEXT FIELD CURRENT
               END IF
               #160122-00001#1--add---str
               IF NOT s_anmi120_nmll002_chk(g_fmck_d[l_ac].fmck003,g_user) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck_d[l_ac].fmck003
                  LET g_errparam.code   = 'anm-00574' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_fmck_d[l_ac].fmck003 = g_fmck_d_t.fmck003
                  NEXT FIELD CURRENT
               END IF
               #160122-00001#1--add---end
               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmck003
            #add-point:ON CHANGE fmck003 name="input.g.page1.fmck003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmck_d[l_ac].fmck004,"0","0","","","azz-00079",1) THEN
               NEXT FIELD fmck004
            END IF 
 
 
 
            #add-point:AFTER FIELD fmck004 name="input.a.page1.fmck004"
            IF NOT cl_null(g_fmck_d[l_ac].fmck004) THEN 
               IF NOT cl_null(g_fmck3_d[l_ac].fmcm004) THEN
                  LET l_fmcm004 = 0 
                  LET l_fmck004 = 0
                  SELECT SUM(fmcm004) INTO l_fmcm004 FROM fmcm_t
                   WHERE fmcment = g_enterprise AND fmcmdocno = g_fmcj_m.fmcjdocno
                     AND fmcmseq = g_fmck_d[l_ac].fmckseq
                  
                  SELECT fmck004 INTO l_fmck004 FROM fmck_t
                   WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
                     AND fmckseq = g_fmck_d[l_ac].fmckseq
                  
                  IF cl_null(l_fmcm004) THEN LET l_fmcm004 = 0 END IF
                  IF cl_null(l_fmck004) THEN LET l_fmck004 = 0 END IF
                  
                  IF (l_cmd = 'a' AND l_fmck004 + g_fmck_d[l_ac].fmck004 < l_fmcm004) 
                  OR (l_cmd = 'u' AND l_fmck004 + g_fmck_d[l_ac].fmck004 - g_fmck_d_t.fmck004< l_fmcm004) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmck_d[l_ac].fmck004
                     LET g_errparam.code   = 'afm-00168'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck004
            #add-point:BEFORE FIELD fmck004 name="input.b.page1.fmck004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmck004
            #add-point:ON CHANGE fmck004 name="input.g.page1.fmck004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck005
            #add-point:BEFORE FIELD fmck005 name="input.b.page1.fmck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck005
            
            #add-point:AFTER FIELD fmck005 name="input.a.page1.fmck005"
            CALL afmt035_fmck005_ref()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmck005
            #add-point:ON CHANGE fmck005 name="input.g.page1.fmck005"
            CALL afmt035_fmck005_ref()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck006
            #add-point:BEFORE FIELD fmck006 name="input.b.page1.fmck006"
            CALL afmt035_fmck005_ref()
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck006
            
            #add-point:AFTER FIELD fmck006 name="input.a.page1.fmck006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmck006
            #add-point:ON CHANGE fmck006 name="input.g.page1.fmck006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmck_d[l_ac].fmck007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmck007
            END IF 
 
 
 
            #add-point:AFTER FIELD fmck007 name="input.a.page1.fmck007"
            IF NOT cl_null(g_fmck_d[l_ac].fmck007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck007
            #add-point:BEFORE FIELD fmck007 name="input.b.page1.fmck007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmck007
            #add-point:ON CHANGE fmck007 name="input.g.page1.fmck007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmck_d[l_ac].fmck008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmck008
            END IF 
 
 
 
            #add-point:AFTER FIELD fmck008 name="input.a.page1.fmck008"
            IF NOT cl_null(g_fmck_d[l_ac].fmck008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck008
            #add-point:BEFORE FIELD fmck008 name="input.b.page1.fmck008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmck008
            #add-point:ON CHANGE fmck008 name="input.g.page1.fmck008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmck_d[l_ac].fmck009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmck009
            END IF 
 
 
 
            #add-point:AFTER FIELD fmck009 name="input.a.page1.fmck009"
            IF NOT cl_null(g_fmck_d[l_ac].fmck009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck009
            #add-point:BEFORE FIELD fmck009 name="input.b.page1.fmck009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmck009
            #add-point:ON CHANGE fmck009 name="input.g.page1.fmck009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck010
            #add-point:BEFORE FIELD fmck010 name="input.b.page1.fmck010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck010
            
            #add-point:AFTER FIELD fmck010 name="input.a.page1.fmck010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmck010
            #add-point:ON CHANGE fmck010 name="input.g.page1.fmck010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck011
            #add-point:BEFORE FIELD fmck011 name="input.b.page1.fmck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck011
            
            #add-point:AFTER FIELD fmck011 name="input.a.page1.fmck011"
            IF NOT cl_null(g_fmck_d[l_ac].fmck011) THEN
               LET l_fmagstus = ''
               LET g_errno = ''               
               SELECT fmagstus INTO l_fmagstus FROM fmag_t,fmah_t
                WHERE fmagent = fmahent AND fmagdocno = fmahdocno
                  AND fmagent = g_enterprise AND fmagdocno = g_fmck_d[l_ac].fmck011
               CASE 
                WHEN SQLCA.SQLCODE = 100 LET g_errno = 'afm-00161'
                WHEN l_fmagstus <> 'Y' LET g_errno = 'sub-01313' #'afm-00162' #160318-00005#12 mod
               END CASE
               IF NOT cl_null(g_fmck_d[l_ac].fmck011) THEN 
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM fmah_t
                   WHERE fmahent = g_enterprise AND fmahdocno = g_fmck_d[l_ac].fmck011
                     AND fmahseq = g_fmck_d[l_ac].fmck012
                  IF l_n = 0 THEN
                     LET g_errno = 'afm-00163'
                  END IF
               END IF 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck_d[l_ac].fmck011||g_fmck_d[l_ac].fmck012
                  LET g_errparam.code   = g_errno
                  #160318-00005#12   --add--str
                  LET g_errparam.replace[1] ='afmt025'
                  LET g_errparam.replace[2] = cl_get_progname('afmt025',g_lang,"2")
                  LET g_errparam.exeprog    ='afmt025'
                  #160318-00005#12  --add--end
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmck011
            #add-point:ON CHANGE fmck011 name="input.g.page1.fmck011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmck012
            #add-point:BEFORE FIELD fmck012 name="input.b.page1.fmck012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmck012
            
            #add-point:AFTER FIELD fmck012 name="input.a.page1.fmck012"
            IF NOT cl_null(g_fmck_d[l_ac].fmck010) AND NOT cl_null(g_fmck_d[l_ac].fmck011) THEN
               LET l_fmagstus = ''
               LET g_errno = ''               
               SELECT fmagstus INTO l_fmagstus FROM fmag_t,fmah_t
                WHERE fmagent = fmahent AND fmagdocno = fmahdocno
                  AND fmagent = g_enterprise AND fmagdocno = g_fmck_d[l_ac].fmck011
               CASE 
                WHEN SQLCA.SQLCODE = 100 LET g_errno = 'afm-00161'
                WHEN l_fmagstus <> 'Y' LET g_errno = 'sub-01313'  #'afm-00162' #160318-00005#12 mod 
               END CASE
               
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM fmah_t
                WHERE fmahent = g_enterprise AND fmahdocno = g_fmck_d[l_ac].fmck011
                  AND fmahseq = g_fmck_d[l_ac].fmck012
               IF l_n = 0 THEN
                  LET g_errno = 'afm-00163'
               END IF
               
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck_d[l_ac].fmck011||g_fmck_d[l_ac].fmck012
                  LET g_errparam.code   = g_errno 
                  #160318-00005#12   --add--str
                  LET g_errparam.replace[1] ='afmt025'
                  LET g_errparam.replace[2] = cl_get_progname('afmt025',g_lang,"2")
                  LET g_errparam.exeprog    ='afmt025'
                  #160318-00005#12  --add--end
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmck012
            #add-point:ON CHANGE fmck012 name="input.g.page1.fmck012"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fmckseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmckseq
            #add-point:ON ACTION controlp INFIELD fmckseq name="input.c.page1.fmckseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmck002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck002
            #add-point:ON ACTION controlp INFIELD fmck002 name="input.c.page1.fmck002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmck_d[l_ac].fmck002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooaj001='",g_glaa026,"' "


            CALL q_ooaj002()                                #呼叫開窗

            LET g_fmck_d[l_ac].fmck002 = g_qryparam.return1              

            DISPLAY g_fmck_d[l_ac].fmck002 TO fmck002              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmck_d[l_ac].fmck002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmck_d[l_ac].fmck002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmck_d[l_ac].fmck002_desc
            LET g_qryparam.where = " "

            NEXT FIELD fmck002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck003
            #add-point:ON ACTION controlp INFIELD fmck003 name="input.c.page1.fmck003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmck_d[l_ac].fmck003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_fmcj_m.fmcjsite #
            LET g_qryparam.arg2 = g_fmcj_m.fmcj002
            IF NOT cl_null(g_fmck_d[l_ac].fmck002) THEN
               LET g_qryparam.where = " nmas003 = '",g_fmck_d[l_ac].fmck002,"'"
            END IF
            
            #160122-00001#1--add---str
#            IF cl_null(g_qryparam.where) THEN
#               LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                      " AND nmll002 = '",g_user,"')"
#            ELSE
#               LET g_qryparam.where = g_qryparam.where CLIPPED," AND nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                      " AND nmll002 = '",g_user,"')"
#            END IF
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND nmas002 IN (",g_sql_bank,")"
            END IF     #160122-00001#1 mod by 07675
            #160122-00001#1--add---end

            CALL q_nmas002_1()                                #呼叫開窗

            LET g_fmck_d[l_ac].fmck003 = g_qryparam.return1              

            DISPLAY g_fmck_d[l_ac].fmck003 TO fmck003              #
            LET g_qryparam.where = " "

            NEXT FIELD fmck003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmck004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck004
            #add-point:ON ACTION controlp INFIELD fmck004 name="input.c.page1.fmck004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmck005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck005
            #add-point:ON ACTION controlp INFIELD fmck005 name="input.c.page1.fmck005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck006
            #add-point:ON ACTION controlp INFIELD fmck006 name="input.c.page1.fmck006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck007
            #add-point:ON ACTION controlp INFIELD fmck007 name="input.c.page1.fmck007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck008
            #add-point:ON ACTION controlp INFIELD fmck008 name="input.c.page1.fmck008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck009
            #add-point:ON ACTION controlp INFIELD fmck009 name="input.c.page1.fmck009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmck010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck010
            #add-point:ON ACTION controlp INFIELD fmck010 name="input.c.page1.fmck010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmck011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck011
            #add-point:ON ACTION controlp INFIELD fmck011 name="input.c.page1.fmck011"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmck_d[l_ac].fmck011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " fmagstus = 'Y' "
            IF NOT cl_null(g_fmcj_m.fmcjsite) THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND fmah002 = '",g_fmcj_m.fmcjsite,"'"
            END IF


            CALL q_fmahdocno()                                #呼叫開窗

            LET g_fmck_d[l_ac].fmck011 = g_qryparam.return1 
            LET g_fmck_d[l_ac].fmck012 = g_qryparam.return2            

            DISPLAY g_fmck_d[l_ac].fmck011 TO fmck011              #
            LET g_qryparam.where = " "

            NEXT FIELD fmck011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmck012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmck012
            #add-point:ON ACTION controlp INFIELD fmck012 name="input.c.page1.fmck012"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmck_d[l_ac].* = g_fmck_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt035_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fmck_d[l_ac].fmckseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fmck_d[l_ac].* = g_fmck_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afmt035_fmck_t_mask_restore('restore_mask_o')
      
               UPDATE fmck_t SET (fmckdocno,fmckseq,fmck002,fmck003,fmck004,fmck005,fmck006,fmck007, 
                   fmck008,fmck009,fmck010,fmck011,fmck012) = (g_fmcj_m.fmcjdocno,g_fmck_d[l_ac].fmckseq, 
                   g_fmck_d[l_ac].fmck002,g_fmck_d[l_ac].fmck003,g_fmck_d[l_ac].fmck004,g_fmck_d[l_ac].fmck005, 
                   g_fmck_d[l_ac].fmck006,g_fmck_d[l_ac].fmck007,g_fmck_d[l_ac].fmck008,g_fmck_d[l_ac].fmck009, 
                   g_fmck_d[l_ac].fmck010,g_fmck_d[l_ac].fmck011,g_fmck_d[l_ac].fmck012)
                WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno 
 
                  AND fmckseq = g_fmck_d_t.fmckseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmck_d[l_ac].* = g_fmck_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmck_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmck_d[l_ac].* = g_fmck_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmck_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcj_m.fmcjdocno
               LET gs_keys_bak[1] = g_fmcjdocno_t
               LET gs_keys[2] = g_fmck_d[g_detail_idx].fmckseq
               LET gs_keys_bak[2] = g_fmck_d_t.fmckseq
               CALL afmt035_update_b('fmck_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afmt035_fmck_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fmck_d[g_detail_idx].fmckseq = g_fmck_d_t.fmckseq 
 
                  ) THEN
                  LET gs_keys[01] = g_fmcj_m.fmcjdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fmck_d_t.fmckseq
 
                  CALL afmt035_key_update_b(gs_keys,'fmck_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmcj_m),util.JSON.stringify(g_fmck_d_t)
               LET g_log2 = util.JSON.stringify(g_fmcj_m),util.JSON.stringify(g_fmck_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #若币别或者贷款账户发生变化，则删除fmcm_t,fmcn_t资料，重新新增一笔资料
            IF g_fmck_d[l_ac].fmck002 <> g_fmck_d_t.fmck002 OR g_fmck_d[l_ac].fmck003 <> g_fmck_d_t.fmck003 THEN
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM fmck_t
                WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
                  AND fmckseq = g_fmck_d[l_ac].fmckseq
               IF l_n > 0 THEN
                  DELETE FROM fmcm_t WHERE fmcment = g_enterprise 
                   AND fmcmdocno = g_fmcj_m.fmcjdocno AND fmcmseq = g_fmck_d[l_ac].fmckseq
                   
                  DELETE FROM fmcn_t WHERE fmcnent = g_enterprise 
                   AND fmcndocno = g_fmcj_m.fmcjdocno AND fmcnseq = g_fmck_d[l_ac].fmckseq
                  
                  CALL afmt035_ins_fmcm()
                  CALL afmt035_ins_fmcn()
               END IF
            ELSE
               #若利率方式或者浮动方式发生变化，则删除fmcn_t资料，重新新增一笔资料
               IF g_fmck_d[l_ac].fmck005 <> g_fmck_d_t.fmck005 OR g_fmck_d[l_ac].fmck006 <> g_fmck_d_t.fmck006 THEN
                  LET l_n = 0 
                  SELECT COUNT(*) INTO l_n FROM fmck_t
                   WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
                     AND fmckseq = g_fmck_d[l_ac].fmckseq
                  IF l_n > 0 THEN
                     DELETE FROM fmcn_t WHERE fmcnent = g_enterprise 
                      AND fmcndocno = g_fmcj_m.fmcjdocno AND fmcnseq = g_fmck_d[l_ac].fmckseq
                     
                     CALL afmt035_ins_fmcn()
                  END IF
               END IF
            END IF
            #end add-point
            CALL afmt035_unlock_b("fmck_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
             
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmck_d[li_reproduce_target].* = g_fmck_d[li_reproduce].*
 
               LET g_fmck_d[li_reproduce_target].fmckseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmck_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmck_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_fmck2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmck2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt035_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmck2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmck2_d[l_ac].* TO NULL 
            INITIALIZE g_fmck2_d_t.* TO NULL 
            INITIALIZE g_fmck2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_fmck2_d[l_ac].fmclseq = "0"
      LET g_fmck2_d[l_ac].fmclseq2 = "0"
      LET g_fmck2_d[l_ac].fmcl003 = "0"
      LET g_fmck2_d[l_ac].fmcl004 = "0"
      LET g_fmck2_d[l_ac].fmcl006 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            CALL afmt035_fmckseq_ref() RETURNING g_fmck2_d[l_ac].fmclseq
            LET g_fmck2_d[l_ac].fmclseq2 = " "
            IF l_cmd = 'a' THEN
               IF cl_null(g_fmck2_d[l_ac].fmclseq2) THEN
                  SELECT MAX(fmclseq2) INTO g_fmck2_d[l_ac].fmclseq2
                    FROM fmcl_t
                   WHERE fmclent = g_enterprise
                     AND fmcldocno = g_fmcj_m.fmcjdocno
                     AND fmclseq = g_fmck2_d[l_ac].fmclseq
               
                  IF cl_null(g_fmck2_d[l_ac].fmclseq2) THEN
                     LET g_fmck2_d[l_ac].fmclseq2 = 1
                  ELSE
                     LET g_fmck2_d[l_ac].fmclseq2 = g_fmck2_d[l_ac].fmclseq2 + 1
                  END IF
               END IF
            END IF
            #end add-point
            LET g_fmck2_d_t.* = g_fmck2_d[l_ac].*     #新輸入資料
            LET g_fmck2_d_o.* = g_fmck2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt035_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt035_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmck2_d[li_reproduce_target].* = g_fmck2_d[li_reproduce].*
 
               LET g_fmck2_d[li_reproduce_target].fmclseq = NULL
               LET g_fmck2_d[li_reproduce_target].fmclseq2 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afmt035_cl USING g_enterprise,g_fmcj_m.fmcjdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt035_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt035_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmck2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmck2_d[l_ac].fmclseq IS NOT NULL
               AND g_fmck2_d[l_ac].fmclseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmck2_d_t.* = g_fmck2_d[l_ac].*  #BACKUP
               LET g_fmck2_d_o.* = g_fmck2_d[l_ac].*  #BACKUP
               CALL afmt035_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL afmt035_set_no_entry_b(l_cmd)
               IF NOT afmt035_lock_b("fmcl_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt035_bcl2 INTO g_fmck2_d[l_ac].fmclseq,g_fmck2_d[l_ac].fmclseq2,g_fmck2_d[l_ac].fmcl001, 
                      g_fmck2_d[l_ac].fmcl002,g_fmck2_d[l_ac].fmcl003,g_fmck2_d[l_ac].fmcl004,g_fmck2_d[l_ac].fmcl005, 
                      g_fmck2_d[l_ac].fmcl006
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmck2_d_mask_o[l_ac].* =  g_fmck2_d[l_ac].*
                  CALL afmt035_fmcl_t_mask()
                  LET g_fmck2_d_mask_n[l_ac].* =  g_fmck2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt035_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            CALL afmt035_fmcl001_entry()
            CALL afmt035_fmcl002_entry()
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fmcj_m.fmcjdocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmck2_d_t.fmclseq
               LET gs_keys[gs_keys.getLength()+1] = g_fmck2_d_t.fmclseq2
            
               #刪除同層單身
               IF NOT afmt035_delete_b('fmcl_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt035_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt035_key_delete_b(gs_keys,'fmcl_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt035_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt035_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_fmck_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmck2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fmcl_t 
             WHERE fmclent = g_enterprise AND fmcldocno = g_fmcj_m.fmcjdocno
               AND fmclseq = g_fmck2_d[l_ac].fmclseq
               AND fmclseq2 = g_fmck2_d[l_ac].fmclseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcj_m.fmcjdocno
               LET gs_keys[2] = g_fmck2_d[g_detail_idx].fmclseq
               LET gs_keys[3] = g_fmck2_d[g_detail_idx].fmclseq2
               CALL afmt035_insert_b('fmcl_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmck_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmcl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt035_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmck2_d[l_ac].* = g_fmck2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt035_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fmck2_d[l_ac].* = g_fmck2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL afmt035_fmcl_t_mask_restore('restore_mask_o')
                              
               UPDATE fmcl_t SET (fmcldocno,fmclseq,fmclseq2,fmcl001,fmcl002,fmcl003,fmcl004,fmcl005, 
                   fmcl006) = (g_fmcj_m.fmcjdocno,g_fmck2_d[l_ac].fmclseq,g_fmck2_d[l_ac].fmclseq2,g_fmck2_d[l_ac].fmcl001, 
                   g_fmck2_d[l_ac].fmcl002,g_fmck2_d[l_ac].fmcl003,g_fmck2_d[l_ac].fmcl004,g_fmck2_d[l_ac].fmcl005, 
                   g_fmck2_d[l_ac].fmcl006) #自訂欄位頁簽
                WHERE fmclent = g_enterprise AND fmcldocno = g_fmcj_m.fmcjdocno
                  AND fmclseq = g_fmck2_d_t.fmclseq #項次 
                  AND fmclseq2 = g_fmck2_d_t.fmclseq2
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmck2_d[l_ac].* = g_fmck2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmcl_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmck2_d[l_ac].* = g_fmck2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmcl_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcj_m.fmcjdocno
               LET gs_keys_bak[1] = g_fmcjdocno_t
               LET gs_keys[2] = g_fmck2_d[g_detail_idx].fmclseq
               LET gs_keys_bak[2] = g_fmck2_d_t.fmclseq
               LET gs_keys[3] = g_fmck2_d[g_detail_idx].fmclseq2
               LET gs_keys_bak[3] = g_fmck2_d_t.fmclseq2
               CALL afmt035_update_b('fmcl_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt035_fmcl_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmck2_d[g_detail_idx].fmclseq = g_fmck2_d_t.fmclseq 
                  AND g_fmck2_d[g_detail_idx].fmclseq2 = g_fmck2_d_t.fmclseq2 
                  ) THEN
                  LET gs_keys[01] = g_fmcj_m.fmcjdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmck2_d_t.fmclseq
                  LET gs_keys[gs_keys.getLength()+1] = g_fmck2_d_t.fmclseq2
                  CALL afmt035_key_update_b(gs_keys,'fmcl_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmcj_m),util.JSON.stringify(g_fmck2_d_t)
               LET g_log2 = util.JSON.stringify(g_fmcj_m),util.JSON.stringify(g_fmck2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmclseq
            #add-point:BEFORE FIELD fmclseq name="input.b.page2.fmclseq"
   
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmclseq
            
            #add-point:AFTER FIELD fmclseq name="input.a.page2.fmclseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcj_m.fmcjdocno IS NOT NULL AND g_fmck2_d[g_detail_idx].fmclseq IS NOT NULL AND g_fmck2_d[g_detail_idx].fmclseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcj_m.fmcjdocno != g_fmcjdocno_t OR g_fmck2_d[g_detail_idx].fmclseq != g_fmck2_d_t.fmclseq OR g_fmck2_d[g_detail_idx].fmclseq2 != g_fmck2_d_t.fmclseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcl_t WHERE "||"fmclent = '" ||g_enterprise|| "' AND "||"fmcldocno = '"||g_fmcj_m.fmcjdocno ||"' AND "|| "fmclseq = '"||g_fmck2_d[g_detail_idx].fmclseq ||"' AND "|| "fmclseq2 = '"||g_fmck2_d[g_detail_idx].fmclseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               CALL afmt035_fmackseq_chk(g_fmck2_d[l_ac].fmclseq) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck2_d[l_ac].fmclseq
                  LET g_errparam.code   = 'afm-00164'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmclseq
            #add-point:ON CHANGE fmclseq name="input.g.page2.fmclseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmclseq2
            #add-point:BEFORE FIELD fmclseq2 name="input.b.page2.fmclseq2"
            IF cl_null(g_fmck2_d[l_ac].fmclseq2) THEN
               SELECT MAX(fmclseq2) INTO g_fmck2_d[l_ac].fmclseq2
                 FROM fmcl_t
                WHERE fmclent = g_enterprise
                  AND fmcldocno = g_fmcj_m.fmcjdocno
                  AND fmclseq = g_fmck2_d[l_ac].fmclseq
            
               IF cl_null(g_fmck2_d[l_ac].fmclseq2) THEN
                  LET g_fmck2_d[l_ac].fmclseq2 = 1
               ELSE
                  LET g_fmck2_d[l_ac].fmclseq2 = g_fmck2_d[l_ac].fmclseq2 + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmclseq2
            
            #add-point:AFTER FIELD fmclseq2 name="input.a.page2.fmclseq2"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcj_m.fmcjdocno IS NOT NULL AND g_fmck2_d[g_detail_idx].fmclseq IS NOT NULL AND g_fmck2_d[g_detail_idx].fmclseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcj_m.fmcjdocno != g_fmcjdocno_t OR g_fmck2_d[g_detail_idx].fmclseq != g_fmck2_d_t.fmclseq OR g_fmck2_d[g_detail_idx].fmclseq2 != g_fmck2_d_t.fmclseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcl_t WHERE "||"fmclent = '" ||g_enterprise|| "' AND "||"fmcldocno = '"||g_fmcj_m.fmcjdocno ||"' AND "|| "fmclseq = '"||g_fmck2_d[g_detail_idx].fmclseq ||"' AND "|| "fmclseq2 = '"||g_fmck2_d[g_detail_idx].fmclseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmclseq2
            #add-point:ON CHANGE fmclseq2 name="input.g.page2.fmclseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl001
            #add-point:BEFORE FIELD fmcl001 name="input.b.page2.fmcl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl001
            
            #add-point:AFTER FIELD fmcl001 name="input.a.page2.fmcl001"
            IF NOT cl_null(g_fmck2_d[l_ac].fmcl001) THEN
               CALL afmt035_fmcl001_entry()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcl001
            #add-point:ON CHANGE fmcl001 name="input.g.page2.fmcl001"
            IF NOT cl_null(g_fmck2_d[l_ac].fmcl001) THEN
               CALL afmt035_fmcl001_entry()
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl002
            #add-point:BEFORE FIELD fmcl002 name="input.b.page2.fmcl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl002
            
            #add-point:AFTER FIELD fmcl002 name="input.a.page2.fmcl002"
            IF NOT cl_null(g_fmck2_d[l_ac].fmcl002) THEN
               CALL afmt035_fmcl002_entry()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcl002
            #add-point:ON CHANGE fmcl002 name="input.g.page2.fmcl002"
            IF NOT cl_null(g_fmck2_d[l_ac].fmcl002) THEN
               CALL afmt035_fmcl002_entry()
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl003
            #add-point:BEFORE FIELD fmcl003 name="input.b.page2.fmcl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl003
            
            #add-point:AFTER FIELD fmcl003 name="input.a.page2.fmcl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcl003
            #add-point:ON CHANGE fmcl003 name="input.g.page2.fmcl003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmck2_d[l_ac].fmcl004,"1","1","31","1","azz-00087",1) THEN
               NEXT FIELD fmcl004
            END IF 
 
 
 
            #add-point:AFTER FIELD fmcl004 name="input.a.page2.fmcl004"
            IF NOT cl_null(g_fmck2_d[l_ac].fmcl004) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl004
            #add-point:BEFORE FIELD fmcl004 name="input.b.page2.fmcl004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcl004
            #add-point:ON CHANGE fmcl004 name="input.g.page2.fmcl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl005
            #add-point:BEFORE FIELD fmcl005 name="input.b.page2.fmcl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl005
            
            #add-point:AFTER FIELD fmcl005 name="input.a.page2.fmcl005"
            IF NOT cl_null(g_fmck2_d[l_ac].fmcl005) THEN
               IF g_fmck2_d[l_ac].fmcl005 < g_fmcj_m.fmcj006 OR g_fmck2_d[l_ac].fmcl005 > g_fmcj_m.fmcj007 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck2_d[l_ac].fmcl005
                  LET g_errparam.code   = 'afm-00165'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcl005
            #add-point:ON CHANGE fmcl005 name="input.g.page2.fmcl005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcl006
            #add-point:BEFORE FIELD fmcl006 name="input.b.page2.fmcl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcl006
            
            #add-point:AFTER FIELD fmcl006 name="input.a.page2.fmcl006"
            IF NOT cl_null(g_fmck2_d[l_ac].fmcl006) THEN
               LET l_fmcl006 = 0 
               LET l_fmck004 = 0
               SELECT SUM(fmcl006) INTO l_fmcl006 FROM fmcl_t
                WHERE fmclent = g_enterprise AND fmcldocno = g_fmcj_m.fmcjdocno
                  AND fmclseq = g_fmck2_d[l_ac].fmclseq
               SELECT fmck004 INTO l_fmck004 FROM fmck_t
                WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
                  AND fmckseq = g_fmck2_d[l_ac].fmclseq
               IF cl_null(l_fmcl006) THEN LET l_fmcl006 = 0 END IF
               IF cl_null(l_fmck004) THEN LET l_fmck004 = 0 END IF
                IF cl_null(g_fmck2_d_t.fmcl006) THEN LET g_fmck2_d_t.fmcl006 = 0 END IF
               
               IF (l_cmd = 'a' AND l_fmcl006 + g_fmck2_d[l_ac].fmcl006 > l_fmck004) 
               OR (l_cmd = 'u' AND l_fmcl006 +　g_fmck2_d[l_ac].fmcl006 - g_fmck2_d_t.fmcl006 > l_fmck004) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck2_d[l_ac].fmcl006
                  LET g_errparam.code   = 'afm-00166'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcl006
            #add-point:ON CHANGE fmcl006 name="input.g.page2.fmcl006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.fmclseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmclseq
            #add-point:ON ACTION controlp INFIELD fmclseq name="input.c.page2.fmclseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmclseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmclseq2
            #add-point:ON ACTION controlp INFIELD fmclseq2 name="input.c.page2.fmclseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmcl001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl001
            #add-point:ON ACTION controlp INFIELD fmcl001 name="input.c.page2.fmcl001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmcl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl002
            #add-point:ON ACTION controlp INFIELD fmcl002 name="input.c.page2.fmcl002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmcl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl003
            #add-point:ON ACTION controlp INFIELD fmcl003 name="input.c.page2.fmcl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmcl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl004
            #add-point:ON ACTION controlp INFIELD fmcl004 name="input.c.page2.fmcl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmcl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl005
            #add-point:ON ACTION controlp INFIELD fmcl005 name="input.c.page2.fmcl005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmcl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcl006
            #add-point:ON ACTION controlp INFIELD fmcl006 name="input.c.page2.fmcl006"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmck2_d[l_ac].* = g_fmck2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt035_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt035_unlock_b("fmcl_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmck2_d[li_reproduce_target].* = g_fmck2_d[li_reproduce].*
 
               LET g_fmck2_d[li_reproduce_target].fmclseq = NULL
               LET g_fmck2_d[li_reproduce_target].fmclseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmck2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmck2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_fmck3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
           #CALL afmt035_fmcm_entry()
            IF g_fmcj_m.fmcj008 = 'N' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'afm-00247' 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmck3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt035_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmck3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmck3_d[l_ac].* TO NULL 
            INITIALIZE g_fmck3_d_t.* TO NULL 
            INITIALIZE g_fmck3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_fmck3_d[l_ac].fmcmseq = "0"
      LET g_fmck3_d[l_ac].fmcmseq2 = "0"
      LET g_fmck3_d[l_ac].fmcm004 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            CALL afmt035_fmckseq_ref() RETURNING g_fmck3_d[l_ac].fmcmseq 
            LET g_fmck3_d[l_ac].fmcmseq2 = ""
            SELECT fmck002,fmck003 INTO g_fmck3_d[g_detail_idx].fmcm001,g_fmck3_d[g_detail_idx].fmcm003 FROM fmck_t
             WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
               AND fmckseq = g_fmck3_d[g_detail_idx].fmcmseq
            IF l_cmd = 'a' THEN
               IF cl_null(g_fmck3_d[l_ac].fmcmseq2) THEN
                  SELECT MAX(fmcmseq2) INTO g_fmck3_d[l_ac].fmcmseq2
                    FROM fmcm_t
                   WHERE fmcment = g_enterprise
                     AND fmcmdocno = g_fmcj_m.fmcjdocno
                     AND fmcmseq = g_fmck3_d[l_ac].fmcmseq
               
                  IF cl_null(g_fmck3_d[l_ac].fmcmseq2) THEN
                     LET g_fmck3_d[l_ac].fmcmseq2 = 1
                  ELSE
                     LET g_fmck3_d[l_ac].fmcmseq2 = g_fmck3_d[l_ac].fmcmseq2 + 1
                  END IF
               END IF
            END IF
            #end add-point
            LET g_fmck3_d_t.* = g_fmck3_d[l_ac].*     #新輸入資料
            LET g_fmck3_d_o.* = g_fmck3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt035_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt035_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmck3_d[li_reproduce_target].* = g_fmck3_d[li_reproduce].*
 
               LET g_fmck3_d[li_reproduce_target].fmcmseq = NULL
               LET g_fmck3_d[li_reproduce_target].fmcmseq2 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afmt035_cl USING g_enterprise,g_fmcj_m.fmcjdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt035_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt035_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmck3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmck3_d[l_ac].fmcmseq IS NOT NULL
               AND g_fmck3_d[l_ac].fmcmseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmck3_d_t.* = g_fmck3_d[l_ac].*  #BACKUP
               LET g_fmck3_d_o.* = g_fmck3_d[l_ac].*  #BACKUP
               CALL afmt035_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL afmt035_set_no_entry_b(l_cmd)
               IF NOT afmt035_lock_b("fmcm_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt035_bcl3 INTO g_fmck3_d[l_ac].fmcmseq,g_fmck3_d[l_ac].fmcmseq2,g_fmck3_d[l_ac].fmcm001, 
                      g_fmck3_d[l_ac].fmcm002,g_fmck3_d[l_ac].fmcm003,g_fmck3_d[l_ac].fmcm004
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmck3_d_mask_o[l_ac].* =  g_fmck3_d[l_ac].*
                  CALL afmt035_fmcm_t_mask()
                  LET g_fmck3_d_mask_n[l_ac].* =  g_fmck3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt035_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fmcj_m.fmcjdocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmck3_d_t.fmcmseq
               LET gs_keys[gs_keys.getLength()+1] = g_fmck3_d_t.fmcmseq2
            
               #刪除同層單身
               IF NOT afmt035_delete_b('fmcm_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt035_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt035_key_delete_b(gs_keys,'fmcm_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt035_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt035_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_fmck_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmck3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fmcm_t 
             WHERE fmcment = g_enterprise AND fmcmdocno = g_fmcj_m.fmcjdocno
               AND fmcmseq = g_fmck3_d[l_ac].fmcmseq
               AND fmcmseq2 = g_fmck3_d[l_ac].fmcmseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcj_m.fmcjdocno
               LET gs_keys[2] = g_fmck3_d[g_detail_idx].fmcmseq
               LET gs_keys[3] = g_fmck3_d[g_detail_idx].fmcmseq2
               CALL afmt035_insert_b('fmcm_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmck_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmcm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt035_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmck3_d[l_ac].* = g_fmck3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt035_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fmck3_d[l_ac].* = g_fmck3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL afmt035_fmcm_t_mask_restore('restore_mask_o')
                              
               UPDATE fmcm_t SET (fmcmdocno,fmcmseq,fmcmseq2,fmcm001,fmcm002,fmcm003,fmcm004) = (g_fmcj_m.fmcjdocno, 
                   g_fmck3_d[l_ac].fmcmseq,g_fmck3_d[l_ac].fmcmseq2,g_fmck3_d[l_ac].fmcm001,g_fmck3_d[l_ac].fmcm002, 
                   g_fmck3_d[l_ac].fmcm003,g_fmck3_d[l_ac].fmcm004) #自訂欄位頁簽
                WHERE fmcment = g_enterprise AND fmcmdocno = g_fmcj_m.fmcjdocno
                  AND fmcmseq = g_fmck3_d_t.fmcmseq #項次 
                  AND fmcmseq2 = g_fmck3_d_t.fmcmseq2
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmck3_d[l_ac].* = g_fmck3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmcm_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmck3_d[l_ac].* = g_fmck3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmcm_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcj_m.fmcjdocno
               LET gs_keys_bak[1] = g_fmcjdocno_t
               LET gs_keys[2] = g_fmck3_d[g_detail_idx].fmcmseq
               LET gs_keys_bak[2] = g_fmck3_d_t.fmcmseq
               LET gs_keys[3] = g_fmck3_d[g_detail_idx].fmcmseq2
               LET gs_keys_bak[3] = g_fmck3_d_t.fmcmseq2
               CALL afmt035_update_b('fmcm_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt035_fmcm_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmck3_d[g_detail_idx].fmcmseq = g_fmck3_d_t.fmcmseq 
                  AND g_fmck3_d[g_detail_idx].fmcmseq2 = g_fmck3_d_t.fmcmseq2 
                  ) THEN
                  LET gs_keys[01] = g_fmcj_m.fmcjdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmck3_d_t.fmcmseq
                  LET gs_keys[gs_keys.getLength()+1] = g_fmck3_d_t.fmcmseq2
                  CALL afmt035_key_update_b(gs_keys,'fmcm_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmcj_m),util.JSON.stringify(g_fmck3_d_t)
               LET g_log2 = util.JSON.stringify(g_fmcj_m),util.JSON.stringify(g_fmck3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcmseq
            #add-point:BEFORE FIELD fmcmseq name="input.b.page3.fmcmseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcmseq
            
            #add-point:AFTER FIELD fmcmseq name="input.a.page3.fmcmseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcj_m.fmcjdocno IS NOT NULL AND g_fmck3_d[g_detail_idx].fmcmseq IS NOT NULL AND g_fmck3_d[g_detail_idx].fmcmseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcj_m.fmcjdocno != g_fmcjdocno_t OR g_fmck3_d[g_detail_idx].fmcmseq != g_fmck3_d_t.fmcmseq OR g_fmck3_d[g_detail_idx].fmcmseq2 != g_fmck3_d_t.fmcmseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcm_t WHERE "||"fmcment = '" ||g_enterprise|| "' AND "||"fmcmdocno = '"||g_fmcj_m.fmcjdocno ||"' AND "|| "fmcmseq = '"||g_fmck3_d[g_detail_idx].fmcmseq ||"' AND "|| "fmcmseq2 = '"||g_fmck3_d[g_detail_idx].fmcmseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               CALL afmt035_fmackseq_chk(g_fmck3_d[l_ac].fmcmseq) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck3_d[l_ac].fmcmseq
                  LET g_errparam.code   = 'afm-00164'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               SELECT fmck003 INTO g_fmck3_d[g_detail_idx].fmcm003 FROM fmck_t
                WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
                  AND fmckseq = g_fmck3_d[g_detail_idx].fmcmseq
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcmseq
            #add-point:ON CHANGE fmcmseq name="input.g.page3.fmcmseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcmseq2
            #add-point:BEFORE FIELD fmcmseq2 name="input.b.page3.fmcmseq2"
            IF cl_null(g_fmck3_d[l_ac].fmcmseq2) THEN
               SELECT MAX(fmcmseq2) INTO g_fmck3_d[l_ac].fmcmseq2
                 FROM fmcm_t
                WHERE fmcment = g_enterprise
                  AND fmcmdocno = g_fmcj_m.fmcjdocno
                  AND fmcmseq = g_fmck3_d[l_ac].fmcmseq
            
               IF cl_null(g_fmck3_d[l_ac].fmcmseq2) THEN
                  LET g_fmck3_d[l_ac].fmcmseq2 = 1
               ELSE
                  LET g_fmck3_d[l_ac].fmcmseq2 = g_fmck3_d[l_ac].fmcmseq2 + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcmseq2
            
            #add-point:AFTER FIELD fmcmseq2 name="input.a.page3.fmcmseq2"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcj_m.fmcjdocno IS NOT NULL AND g_fmck3_d[g_detail_idx].fmcmseq IS NOT NULL AND g_fmck3_d[g_detail_idx].fmcmseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcj_m.fmcjdocno != g_fmcjdocno_t OR g_fmck3_d[g_detail_idx].fmcmseq != g_fmck3_d_t.fmcmseq OR g_fmck3_d[g_detail_idx].fmcmseq2 != g_fmck3_d_t.fmcmseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcm_t WHERE "||"fmcment = '" ||g_enterprise|| "' AND "||"fmcmdocno = '"||g_fmcj_m.fmcjdocno ||"' AND "|| "fmcmseq = '"||g_fmck3_d[g_detail_idx].fmcmseq ||"' AND "|| "fmcmseq2 = '"||g_fmck3_d[g_detail_idx].fmcmseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcmseq2
            #add-point:ON CHANGE fmcmseq2 name="input.g.page3.fmcmseq2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcm001
            
            #add-point:AFTER FIELD fmcm001 name="input.a.page3.fmcm001"
            IF NOT cl_null(g_fmck3_d[l_ac].fmcm001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa026
               LET g_chkparam.arg2 = g_fmck3_d[l_ac].fmcm001
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#6--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmck3_d[l_ac].fmcm001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmck3_d[l_ac].fmcm001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmck3_d[l_ac].fmcm001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcm001
            #add-point:BEFORE FIELD fmcm001 name="input.b.page3.fmcm001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcm001
            #add-point:ON CHANGE fmcm001 name="input.g.page3.fmcm001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcm002
            #add-point:BEFORE FIELD fmcm002 name="input.b.page3.fmcm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcm002
            
            #add-point:AFTER FIELD fmcm002 name="input.a.page3.fmcm002"
            IF NOT cl_null(g_fmck3_d[l_ac].fmcm002) THEN
               IF g_fmck3_d[l_ac].fmcm002 < g_fmcj_m.fmcj006 OR g_fmck3_d[l_ac].fmcm002 > g_fmcj_m.fmcj007 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck3_d[l_ac].fmcm002
                  LET g_errparam.code   = 'afm-00167'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcm002
            #add-point:ON CHANGE fmcm002 name="input.g.page3.fmcm002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcm003
            #add-point:BEFORE FIELD fmcm003 name="input.b.page3.fmcm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcm003
            
            #add-point:AFTER FIELD fmcm003 name="input.a.page3.fmcm003"
            IF NOT cl_null(g_fmck3_d[l_ac].fmcm003) THEN
               LET l_n = 0
               SELECT nmaastus INTO l_nmaastus FROM nmaa_t,nmas_t 
                WHERE nmasent = nmaaent AND nmas001 = nmaa001 
                  AND nmaaent = g_enterprise AND nmaa002 = g_fmcj_m.fmcjsite
                  AND nmaa004 = g_fmcj_m.fmcj002 AND nmas003 = g_fmck3_d[l_ac].fmcm001
                  AND nmas002 = g_fmck3_d[l_ac].fmcm003 AND nmaastus = 'Y'
               IF SQLCA.SQLCODE = 100 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck3_d[l_ac].fmcm003
                  LET g_errparam.code   = 'afm-00159' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               IF l_nmaastus = 'N' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck3_d[l_ac].fmcm003
                  LET g_errparam.code   = 'afm-00160' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcm003
            #add-point:ON CHANGE fmcm003 name="input.g.page3.fmcm003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcm004
            #add-point:BEFORE FIELD fmcm004 name="input.b.page3.fmcm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcm004
            
            #add-point:AFTER FIELD fmcm004 name="input.a.page3.fmcm004"
            IF NOT cl_null(g_fmck3_d[l_ac].fmcm004) THEN
               LET l_fmcm004 = 0 
               LET l_fmck004 = 0
               SELECT SUM(fmcm004) INTO l_fmcm004 FROM fmcm_t
                WHERE fmcment = g_enterprise AND fmcmdocno = g_fmcj_m.fmcjdocno
                  AND fmcmseq = g_fmck3_d[l_ac].fmcmseq
               SELECT fmck004 INTO l_fmck004 FROM fmck_t
                WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
                  AND fmckseq = g_fmck3_d[l_ac].fmcmseq
               IF cl_null(l_fmcm004) THEN LET l_fmcm004 = 0 END IF
               IF cl_null(l_fmck004) THEN LET l_fmck004 = 0 END IF
               
               IF (l_cmd = 'a' AND l_fmcm004 + g_fmck3_d[l_ac].fmcm004 > l_fmck004) 
               OR (l_cmd = 'u' AND l_fmcm004 +　g_fmck3_d[l_ac].fmcm004 - g_fmck3_d_t.fmcm004 > l_fmck004) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck3_d[l_ac].fmcm004
                  LET g_errparam.code   = 'afm-00168'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcm004
            #add-point:ON CHANGE fmcm004 name="input.g.page3.fmcm004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.fmcmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcmseq
            #add-point:ON ACTION controlp INFIELD fmcmseq name="input.c.page3.fmcmseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmcmseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcmseq2
            #add-point:ON ACTION controlp INFIELD fmcmseq2 name="input.c.page3.fmcmseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmcm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcm001
            #add-point:ON ACTION controlp INFIELD fmcm001 name="input.c.page3.fmcm001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmck3_d[l_ac].fmcm001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooaj001='",g_glaa026,"' "


            CALL q_ooaj002()                                #呼叫開窗

            LET g_fmck3_d[l_ac].fmcm001 = g_qryparam.return1              

            DISPLAY g_fmck3_d[l_ac].fmcm001 TO fmcm001              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmck3_d[l_ac].fmcm001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmck3_d[l_ac].fmcm001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmck3_d[l_ac].fmcm001_desc
            LET g_qryparam.where = ""

            NEXT FIELD fmcm001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.fmcm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcm002
            #add-point:ON ACTION controlp INFIELD fmcm002 name="input.c.page3.fmcm002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmcm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcm003
            #add-point:ON ACTION controlp INFIELD fmcm003 name="input.c.page3.fmcm003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmcm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcm004
            #add-point:ON ACTION controlp INFIELD fmcm004 name="input.c.page3.fmcm004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmck3_d[l_ac].* = g_fmck3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt035_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt035_unlock_b("fmcm_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmck3_d[li_reproduce_target].* = g_fmck3_d[li_reproduce].*
 
               LET g_fmck3_d[li_reproduce_target].fmcmseq = NULL
               LET g_fmck3_d[li_reproduce_target].fmcmseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmck3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmck3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_fmck4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmck4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt035_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmck4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmck4_d[l_ac].* TO NULL 
            INITIALIZE g_fmck4_d_t.* TO NULL 
            INITIALIZE g_fmck4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
                  LET g_fmck4_d[l_ac].fmcnseq = "0"
      LET g_fmck4_d[l_ac].fmcnseq2 = "0"
      LET g_fmck4_d[l_ac].fmcn004 = "0"
      LET g_fmck4_d[l_ac].fmcn006 = "0"
      LET g_fmck4_d[l_ac].fmcn007 = "0"
 
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            CALL afmt035_fmckseq_ref() RETURNING g_fmck4_d[l_ac].fmcnseq
            LET g_fmck4_d[l_ac].fmcnseq2 = ""
            SELECT fmck002,fmck005,fmck006
              INTO g_fmck4_d[g_detail_idx].fmcn001,g_fmck4_d[g_detail_idx].fmcn003,g_fmck4_d[g_detail_idx].fmcn005
              FROM fmck_t
             WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
               AND fmckseq = g_fmck4_d[g_detail_idx].fmcnseq
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmck4_d[l_ac].fmcn001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmck4_d[l_ac].fmcn001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmck4_d[l_ac].fmcn001_desc
            IF l_cmd = 'a' THEN
               IF cl_null(g_fmck4_d[l_ac].fmcnseq2) THEN
                  SELECT MAX(fmcnseq2) INTO g_fmck4_d[l_ac].fmcnseq2
                    FROM fmcn_t
                   WHERE fmcnent = g_enterprise
                     AND fmcndocno = g_fmcj_m.fmcjdocno
                     AND fmcnseq = g_fmck4_d[l_ac].fmcnseq
               
                  IF cl_null(g_fmck4_d[l_ac].fmcnseq2) THEN
                     LET g_fmck4_d[l_ac].fmcnseq2 = 1
                  ELSE
                     LET g_fmck4_d[l_ac].fmcnseq2 = g_fmck4_d[l_ac].fmcnseq2 + 1
                  END IF
               END IF
               CALL afmt035_fmcn003_ref()
            END IF
            #end add-point
            LET g_fmck4_d_t.* = g_fmck4_d[l_ac].*     #新輸入資料
            LET g_fmck4_d_o.* = g_fmck4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt035_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt035_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmck4_d[li_reproduce_target].* = g_fmck4_d[li_reproduce].*
 
               LET g_fmck4_d[li_reproduce_target].fmcnseq = NULL
               LET g_fmck4_d[li_reproduce_target].fmcnseq2 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[4] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 4
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afmt035_cl USING g_enterprise,g_fmcj_m.fmcjdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt035_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt035_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmck4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmck4_d[l_ac].fmcnseq IS NOT NULL
               AND g_fmck4_d[l_ac].fmcnseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmck4_d_t.* = g_fmck4_d[l_ac].*  #BACKUP
               LET g_fmck4_d_o.* = g_fmck4_d[l_ac].*  #BACKUP
               CALL afmt035_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL afmt035_set_no_entry_b(l_cmd)
               IF NOT afmt035_lock_b("fmcn_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt035_bcl4 INTO g_fmck4_d[l_ac].fmcnseq,g_fmck4_d[l_ac].fmcnseq2,g_fmck4_d[l_ac].fmcn001, 
                      g_fmck4_d[l_ac].fmcn002,g_fmck4_d[l_ac].fmcn003,g_fmck4_d[l_ac].fmcn004,g_fmck4_d[l_ac].fmcn005, 
                      g_fmck4_d[l_ac].fmcn006,g_fmck4_d[l_ac].fmcn007
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmck4_d_mask_o[l_ac].* =  g_fmck4_d[l_ac].*
                  CALL afmt035_fmcn_t_mask()
                  LET g_fmck4_d_mask_n[l_ac].* =  g_fmck4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt035_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身4刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fmcj_m.fmcjdocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmck4_d_t.fmcnseq
               LET gs_keys[gs_keys.getLength()+1] = g_fmck4_d_t.fmcnseq2
            
               #刪除同層單身
               IF NOT afmt035_delete_b('fmcn_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt035_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt035_key_delete_b(gs_keys,'fmcn_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt035_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt035_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_fmck_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmck4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身4新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fmcn_t 
             WHERE fmcnent = g_enterprise AND fmcndocno = g_fmcj_m.fmcjdocno
               AND fmcnseq = g_fmck4_d[l_ac].fmcnseq
               AND fmcnseq2 = g_fmck4_d[l_ac].fmcnseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcj_m.fmcjdocno
               LET gs_keys[2] = g_fmck4_d[g_detail_idx].fmcnseq
               LET gs_keys[3] = g_fmck4_d[g_detail_idx].fmcnseq2
               CALL afmt035_insert_b('fmcn_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmck_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmcn_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt035_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmck4_d[l_ac].* = g_fmck4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt035_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fmck4_d[l_ac].* = g_fmck4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL afmt035_fmcn_t_mask_restore('restore_mask_o')
                              
               UPDATE fmcn_t SET (fmcndocno,fmcnseq,fmcnseq2,fmcn001,fmcn002,fmcn003,fmcn004,fmcn005, 
                   fmcn006,fmcn007) = (g_fmcj_m.fmcjdocno,g_fmck4_d[l_ac].fmcnseq,g_fmck4_d[l_ac].fmcnseq2, 
                   g_fmck4_d[l_ac].fmcn001,g_fmck4_d[l_ac].fmcn002,g_fmck4_d[l_ac].fmcn003,g_fmck4_d[l_ac].fmcn004, 
                   g_fmck4_d[l_ac].fmcn005,g_fmck4_d[l_ac].fmcn006,g_fmck4_d[l_ac].fmcn007) #自訂欄位頁簽 
 
                WHERE fmcnent = g_enterprise AND fmcndocno = g_fmcj_m.fmcjdocno
                  AND fmcnseq = g_fmck4_d_t.fmcnseq #項次 
                  AND fmcnseq2 = g_fmck4_d_t.fmcnseq2
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmck4_d[l_ac].* = g_fmck4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmcn_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmck4_d[l_ac].* = g_fmck4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmcn_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcj_m.fmcjdocno
               LET gs_keys_bak[1] = g_fmcjdocno_t
               LET gs_keys[2] = g_fmck4_d[g_detail_idx].fmcnseq
               LET gs_keys_bak[2] = g_fmck4_d_t.fmcnseq
               LET gs_keys[3] = g_fmck4_d[g_detail_idx].fmcnseq2
               LET gs_keys_bak[3] = g_fmck4_d_t.fmcnseq2
               CALL afmt035_update_b('fmcn_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt035_fmcn_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmck4_d[g_detail_idx].fmcnseq = g_fmck4_d_t.fmcnseq 
                  AND g_fmck4_d[g_detail_idx].fmcnseq2 = g_fmck4_d_t.fmcnseq2 
                  ) THEN
                  LET gs_keys[01] = g_fmcj_m.fmcjdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmck4_d_t.fmcnseq
                  LET gs_keys[gs_keys.getLength()+1] = g_fmck4_d_t.fmcnseq2
                  CALL afmt035_key_update_b(gs_keys,'fmcn_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmcj_m),util.JSON.stringify(g_fmck4_d_t)
               LET g_log2 = util.JSON.stringify(g_fmcj_m),util.JSON.stringify(g_fmck4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcnseq
            #add-point:BEFORE FIELD fmcnseq name="input.b.page4.fmcnseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcnseq
            
            #add-point:AFTER FIELD fmcnseq name="input.a.page4.fmcnseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcj_m.fmcjdocno IS NOT NULL AND g_fmck4_d[g_detail_idx].fmcnseq IS NOT NULL AND g_fmck4_d[g_detail_idx].fmcnseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcj_m.fmcjdocno != g_fmcjdocno_t OR g_fmck4_d[g_detail_idx].fmcnseq != g_fmck4_d_t.fmcnseq OR g_fmck4_d[g_detail_idx].fmcnseq2 != g_fmck4_d_t.fmcnseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcn_t WHERE "||"fmcnent = '" ||g_enterprise|| "' AND "||"fmcndocno = '"||g_fmcj_m.fmcjdocno ||"' AND "|| "fmcnseq = '"||g_fmck4_d[g_detail_idx].fmcnseq ||"' AND "|| "fmcnseq2 = '"||g_fmck4_d[g_detail_idx].fmcnseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  CALL afmt035_fmackseq_chk(g_fmck4_d[l_ac].fmcnseq) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmck4_d[l_ac].fmcnseq
                     LET g_errparam.code   = 'afm-00164'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  CALL afmt035_fmcn003_ref()
               END IF
               
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcnseq
            #add-point:ON CHANGE fmcnseq name="input.g.page4.fmcnseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcnseq2
            #add-point:BEFORE FIELD fmcnseq2 name="input.b.page4.fmcnseq2"
            IF cl_null(g_fmck4_d[l_ac].fmcnseq2) THEN
               SELECT MAX(fmcnseq2) INTO g_fmck4_d[l_ac].fmcnseq2
                 FROM fmcn_t
                WHERE fmcnent = g_enterprise
                  AND fmcndocno = g_fmcj_m.fmcjdocno
                  AND fmcnseq = g_fmck4_d[l_ac].fmcnseq
            
               IF cl_null(g_fmck4_d[l_ac].fmcnseq2) THEN
                  LET g_fmck4_d[l_ac].fmcnseq2 = 1
               ELSE
                  LET g_fmck4_d[l_ac].fmcnseq2 = g_fmck4_d[l_ac].fmcnseq2 + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcnseq2
            
            #add-point:AFTER FIELD fmcnseq2 name="input.a.page4.fmcnseq2"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcj_m.fmcjdocno IS NOT NULL AND g_fmck4_d[g_detail_idx].fmcnseq IS NOT NULL AND g_fmck4_d[g_detail_idx].fmcnseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcj_m.fmcjdocno != g_fmcjdocno_t OR g_fmck4_d[g_detail_idx].fmcnseq != g_fmck4_d_t.fmcnseq OR g_fmck4_d[g_detail_idx].fmcnseq2 != g_fmck4_d_t.fmcnseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcn_t WHERE "||"fmcnent = '" ||g_enterprise|| "' AND "||"fmcndocno = '"||g_fmcj_m.fmcjdocno ||"' AND "|| "fmcnseq = '"||g_fmck4_d[g_detail_idx].fmcnseq ||"' AND "|| "fmcnseq2 = '"||g_fmck4_d[g_detail_idx].fmcnseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcnseq2
            #add-point:ON CHANGE fmcnseq2 name="input.g.page4.fmcnseq2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn001
            
            #add-point:AFTER FIELD fmcn001 name="input.a.page4.fmcn001"
            IF NOT cl_null(g_fmck4_d[l_ac].fmcn001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa026
               LET g_chkparam.arg2 = g_fmck4_d[l_ac].fmcn001
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#6--add--end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmck4_d[l_ac].fmcn001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmck4_d[l_ac].fmcn001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmck4_d[l_ac].fmcn001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn001
            #add-point:BEFORE FIELD fmcn001 name="input.b.page4.fmcn001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcn001
            #add-point:ON CHANGE fmcn001 name="input.g.page4.fmcn001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn002
            #add-point:BEFORE FIELD fmcn002 name="input.b.page4.fmcn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn002
            
            #add-point:AFTER FIELD fmcn002 name="input.a.page4.fmcn002"
            IF NOT cl_null(g_fmck4_d[l_ac].fmcn002) THEN
               IF g_fmck4_d[l_ac].fmcn002 < g_fmcj_m.fmcj006 OR g_fmck4_d[l_ac].fmcn002 > g_fmcj_m.fmcj007 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck4_d[l_ac].fmcn002
                  LET g_errparam.code   = 'afm-00169'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcn002
            #add-point:ON CHANGE fmcn002 name="input.g.page4.fmcn002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn003
            #add-point:BEFORE FIELD fmcn003 name="input.b.page4.fmcn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn003
            
            #add-point:AFTER FIELD fmcn003 name="input.a.page4.fmcn003"
            CALL afmt035_fmcn003_ref()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcn003
            #add-point:ON CHANGE fmcn003 name="input.g.page4.fmcn003"
            CALL afmt035_fmcn003_ref()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn004
            #add-point:BEFORE FIELD fmcn004 name="input.b.page4.fmcn004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn004
            
            #add-point:AFTER FIELD fmcn004 name="input.a.page4.fmcn004"
            IF NOT cl_null(g_fmck4_d[l_ac].fmcn004) AND g_fmck4_d[l_ac].fmcn004 <> g_fmck4_d_t.fmcn004 THEN
               CALL afmt035_fmcn003_ref()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcn004
            #add-point:ON CHANGE fmcn004 name="input.g.page4.fmcn004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn005
            #add-point:BEFORE FIELD fmcn005 name="input.b.page4.fmcn005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn005
            
            #add-point:AFTER FIELD fmcn005 name="input.a.page4.fmcn005"
            CALL afmt035_fmcn003_ref()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcn005
            #add-point:ON CHANGE fmcn005 name="input.g.page4.fmcn005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn006
            #add-point:BEFORE FIELD fmcn006 name="input.b.page4.fmcn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn006
            
            #add-point:AFTER FIELD fmcn006 name="input.a.page4.fmcn006"
            IF NOT cl_null(g_fmck4_d[l_ac].fmcn006) AND g_fmck4_d[l_ac].fmcn006 <> g_fmck4_d_t.fmcn006 THEN
               SELECT fmck005,fmck006,fmck007 INTO g_fmck4_d[l_ac].fmcn003,g_fmck4_d[l_ac].fmcn005,l_fmck007
                 FROM fmck_t
                WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
                  AND fmckseq = g_fmck4_d[l_ac].fmcnseq
                  
               IF cl_null(g_fmck4_d[l_ac].fmcn003) THEN LET g_fmck4_d[l_ac].fmcn003 = 0 END IF
               IF cl_null(g_fmck4_d[l_ac].fmcn005) THEN LET g_fmck4_d[l_ac].fmcn005 = 0 END IF
               IF cl_null(l_fmck007) THEN LET l_fmck007 = 0 END IF
               IF g_fmck4_d[l_ac].fmcn003 = '1' THEN   #固定利率
                  LET g_fmck4_d[l_ac].fmcn007 = l_fmck007
               ELSE #浮动利率
                  IF g_fmck4_d[ l_ac].fmcn005 = '1' THEN  #比例时
                     LET g_fmck4_d[l_ac].fmcn007 = g_fmck4_d[l_ac].fmcn004 * (1 + g_fmck4_d[l_ac].fmcn006/100)
                  ELSE  #固定值
                     LET g_fmck4_d[l_ac].fmcn007 = g_fmck4_d[l_ac].fmcn004 + g_fmck4_d[l_ac].fmcn006/100
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcn006
            #add-point:ON CHANGE fmcn006 name="input.g.page4.fmcn006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcn007
            #add-point:BEFORE FIELD fmcn007 name="input.b.page4.fmcn007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcn007
            
            #add-point:AFTER FIELD fmcn007 name="input.a.page4.fmcn007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcn007
            #add-point:ON CHANGE fmcn007 name="input.g.page4.fmcn007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.fmcnseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcnseq
            #add-point:ON ACTION controlp INFIELD fmcnseq name="input.c.page4.fmcnseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmcnseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcnseq2
            #add-point:ON ACTION controlp INFIELD fmcnseq2 name="input.c.page4.fmcnseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmcn001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn001
            #add-point:ON ACTION controlp INFIELD fmcn001 name="input.c.page4.fmcn001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmck4_d[l_ac].fmcn001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooaj001='",g_glaa026,"' "


            CALL q_ooaj002()                                #呼叫開窗

            LET g_fmck4_d[l_ac].fmcn001 = g_qryparam.return1              

            DISPLAY g_fmck4_d[l_ac].fmcn001 TO fmcn001              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmck4_d[l_ac].fmcn001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmck4_d[l_ac].fmcn001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmck4_d[l_ac].fmcn001_desc
            LET g_qryparam.where = ""

            NEXT FIELD fmcn001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.fmcn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn002
            #add-point:ON ACTION controlp INFIELD fmcn002 name="input.c.page4.fmcn002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmcn003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn003
            #add-point:ON ACTION controlp INFIELD fmcn003 name="input.c.page4.fmcn003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmcn004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn004
            #add-point:ON ACTION controlp INFIELD fmcn004 name="input.c.page4.fmcn004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmcn005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn005
            #add-point:ON ACTION controlp INFIELD fmcn005 name="input.c.page4.fmcn005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmcn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn006
            #add-point:ON ACTION controlp INFIELD fmcn006 name="input.c.page4.fmcn006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmcn007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcn007
            #add-point:ON ACTION controlp INFIELD fmcn007 name="input.c.page4.fmcn007"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmck4_d[l_ac].* = g_fmck4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt035_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt035_unlock_b("fmcn_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmck4_d[li_reproduce_target].* = g_fmck4_d[li_reproduce].*
 
               LET g_fmck4_d[li_reproduce_target].fmcnseq = NULL
               LET g_fmck4_d[li_reproduce_target].fmcnseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmck4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmck4_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_fmck5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_5)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body5.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmck5_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt035_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmck5_d.getLength()
            #add-point:資料輸入前 name="input.body5.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmck5_d[l_ac].* TO NULL 
            INITIALIZE g_fmck5_d_t.* TO NULL 
            INITIALIZE g_fmck5_d_o.* TO NULL 
            #公用欄位給值(單身5)
            
            #自定義預設值(單身5)
                  LET g_fmck5_d[l_ac].fmcoseq = "0"
      LET g_fmck5_d[l_ac].fmcoseq2 = "0"
      LET g_fmck5_d[l_ac].fmco003 = "0"
      LET g_fmck5_d[l_ac].fmco004 = "0"
 
            #add-point:modify段before備份 name="input.body5.insert.before_bak"
            CALL afmt035_fmckseq_ref() RETURNING g_fmck5_d[l_ac].fmcoseq
            LET g_fmck5_d[l_ac].fmcoseq2 = ""
            IF l_cmd = 'a' THEN
               IF cl_null(g_fmck5_d[l_ac].fmcoseq2) THEN
                  SELECT MAX(fmcoseq2) INTO g_fmck5_d[l_ac].fmcoseq2
                    FROM fmco_t
                   WHERE fmcoent = g_enterprise
                     AND fmcodocno = g_fmcj_m.fmcjdocno
                     AND fmcoseq = g_fmck5_d[l_ac].fmcoseq
               
                  IF cl_null(g_fmck5_d[l_ac].fmcoseq2) THEN
                     LET g_fmck5_d[l_ac].fmcoseq2 = 1
                  ELSE
                     LET g_fmck5_d[l_ac].fmcoseq2 = g_fmck5_d[l_ac].fmcoseq2 + 1
                  END IF
               END IF
            END IF
            #end add-point
            LET g_fmck5_d_t.* = g_fmck5_d[l_ac].*     #新輸入資料
            LET g_fmck5_d_o.* = g_fmck5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt035_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body5.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt035_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmck5_d[li_reproduce_target].* = g_fmck5_d[li_reproduce].*
 
               LET g_fmck5_d[li_reproduce_target].fmcoseq = NULL
               LET g_fmck5_d[li_reproduce_target].fmcoseq2 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body5.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body5.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[5] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 5
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afmt035_cl USING g_enterprise,g_fmcj_m.fmcjdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt035_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt035_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmck5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmck5_d[l_ac].fmcoseq IS NOT NULL
               AND g_fmck5_d[l_ac].fmcoseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmck5_d_t.* = g_fmck5_d[l_ac].*  #BACKUP
               LET g_fmck5_d_o.* = g_fmck5_d[l_ac].*  #BACKUP
               CALL afmt035_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body5.after_set_entry_b"
               
               #end add-point  
               CALL afmt035_set_no_entry_b(l_cmd)
               IF NOT afmt035_lock_b("fmco_t","'5'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt035_bcl5 INTO g_fmck5_d[l_ac].fmcoseq,g_fmck5_d[l_ac].fmcoseq2,g_fmck5_d[l_ac].fmco001, 
                      g_fmck5_d[l_ac].fmco002,g_fmck5_d[l_ac].fmco003,g_fmck5_d[l_ac].fmco004,g_fmck5_d[l_ac].fmco005 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmck5_d_mask_o[l_ac].* =  g_fmck5_d[l_ac].*
                  CALL afmt035_fmco_t_mask()
                  LET g_fmck5_d_mask_n[l_ac].* =  g_fmck5_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt035_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body5.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body5.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body5.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身5刪除前 name="input.body5.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fmcj_m.fmcjdocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmck5_d_t.fmcoseq
               LET gs_keys[gs_keys.getLength()+1] = g_fmck5_d_t.fmcoseq2
            
               #刪除同層單身
               IF NOT afmt035_delete_b('fmco_t',gs_keys,"'5'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt035_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt035_key_delete_b(gs_keys,'fmco_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt035_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身5刪除中 name="input.body5.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt035_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身5刪除後 name="input.body5.a_delete"
               
               #end add-point
               LET l_count = g_fmck_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body5.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmck5_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身5新增前 name="input.body5.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fmco_t 
             WHERE fmcoent = g_enterprise AND fmcodocno = g_fmcj_m.fmcjdocno
               AND fmcoseq = g_fmck5_d[l_ac].fmcoseq
               AND fmcoseq2 = g_fmck5_d[l_ac].fmcoseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身5新增前 name="input.body5.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcj_m.fmcjdocno
               LET gs_keys[2] = g_fmck5_d[g_detail_idx].fmcoseq
               LET gs_keys[3] = g_fmck5_d[g_detail_idx].fmcoseq2
               CALL afmt035_insert_b('fmco_t',gs_keys,"'5'")
                           
               #add-point:單身新增後5 name="input.body5.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmck_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmco_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt035_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body5.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmck5_d[l_ac].* = g_fmck5_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt035_bcl5
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fmck5_d[l_ac].* = g_fmck5_d_t.*
            ELSE
               #add-point:單身page5修改前 name="input.body5.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身5)
               
               
               #將遮罩欄位還原
               CALL afmt035_fmco_t_mask_restore('restore_mask_o')
                              
               UPDATE fmco_t SET (fmcodocno,fmcoseq,fmcoseq2,fmco001,fmco002,fmco003,fmco004,fmco005) = (g_fmcj_m.fmcjdocno, 
                   g_fmck5_d[l_ac].fmcoseq,g_fmck5_d[l_ac].fmcoseq2,g_fmck5_d[l_ac].fmco001,g_fmck5_d[l_ac].fmco002, 
                   g_fmck5_d[l_ac].fmco003,g_fmck5_d[l_ac].fmco004,g_fmck5_d[l_ac].fmco005) #自訂欄位頁簽 
 
                WHERE fmcoent = g_enterprise AND fmcodocno = g_fmcj_m.fmcjdocno
                  AND fmcoseq = g_fmck5_d_t.fmcoseq #項次 
                  AND fmcoseq2 = g_fmck5_d_t.fmcoseq2
                  
               #add-point:單身page5修改中 name="input.body5.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmck5_d[l_ac].* = g_fmck5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmco_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmck5_d[l_ac].* = g_fmck5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmco_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcj_m.fmcjdocno
               LET gs_keys_bak[1] = g_fmcjdocno_t
               LET gs_keys[2] = g_fmck5_d[g_detail_idx].fmcoseq
               LET gs_keys_bak[2] = g_fmck5_d_t.fmcoseq
               LET gs_keys[3] = g_fmck5_d[g_detail_idx].fmcoseq2
               LET gs_keys_bak[3] = g_fmck5_d_t.fmcoseq2
               CALL afmt035_update_b('fmco_t',gs_keys,gs_keys_bak,"'5'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt035_fmco_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmck5_d[g_detail_idx].fmcoseq = g_fmck5_d_t.fmcoseq 
                  AND g_fmck5_d[g_detail_idx].fmcoseq2 = g_fmck5_d_t.fmcoseq2 
                  ) THEN
                  LET gs_keys[01] = g_fmcj_m.fmcjdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmck5_d_t.fmcoseq
                  LET gs_keys[gs_keys.getLength()+1] = g_fmck5_d_t.fmcoseq2
                  CALL afmt035_key_update_b(gs_keys,'fmco_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmcj_m),util.JSON.stringify(g_fmck5_d_t)
               LET g_log2 = util.JSON.stringify(g_fmcj_m),util.JSON.stringify(g_fmck5_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page5修改後 name="input.body5.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcoseq
            #add-point:BEFORE FIELD fmcoseq name="input.b.page5.fmcoseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcoseq
            
            #add-point:AFTER FIELD fmcoseq name="input.a.page5.fmcoseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcj_m.fmcjdocno IS NOT NULL AND g_fmck5_d[g_detail_idx].fmcoseq IS NOT NULL AND g_fmck5_d[g_detail_idx].fmcoseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcj_m.fmcjdocno != g_fmcjdocno_t OR g_fmck5_d[g_detail_idx].fmcoseq != g_fmck5_d_t.fmcoseq OR g_fmck5_d[g_detail_idx].fmcoseq2 != g_fmck5_d_t.fmcoseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmco_t WHERE "||"fmcoent = '" ||g_enterprise|| "' AND "||"fmcodocno = '"||g_fmcj_m.fmcjdocno ||"' AND "|| "fmcoseq = '"||g_fmck5_d[g_detail_idx].fmcoseq ||"' AND "|| "fmcoseq2 = '"||g_fmck5_d[g_detail_idx].fmcoseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               CALL afmt035_fmackseq_chk(g_fmck5_d[l_ac].fmcoseq) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmck5_d[l_ac].fmcoseq
                  LET g_errparam.code   = 'afm-00164'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcoseq
            #add-point:ON CHANGE fmcoseq name="input.g.page5.fmcoseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcoseq2
            #add-point:BEFORE FIELD fmcoseq2 name="input.b.page5.fmcoseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcoseq2
            
            #add-point:AFTER FIELD fmcoseq2 name="input.a.page5.fmcoseq2"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcj_m.fmcjdocno IS NOT NULL AND g_fmck5_d[g_detail_idx].fmcoseq IS NOT NULL AND g_fmck5_d[g_detail_idx].fmcoseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcj_m.fmcjdocno != g_fmcjdocno_t OR g_fmck5_d[g_detail_idx].fmcoseq != g_fmck5_d_t.fmcoseq OR g_fmck5_d[g_detail_idx].fmcoseq2 != g_fmck5_d_t.fmcoseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmco_t WHERE "||"fmcoent = '" ||g_enterprise|| "' AND "||"fmcodocno = '"||g_fmcj_m.fmcjdocno ||"' AND "|| "fmcoseq = '"||g_fmck5_d[g_detail_idx].fmcoseq ||"' AND "|| "fmcoseq2 = '"||g_fmck5_d[g_detail_idx].fmcoseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_fmck5_d[l_ac].fmcoseq2) THEN
                     SELECT MAX(fmcoseq2) INTO g_fmck5_d[l_ac].fmcoseq2
                       FROM fmco_t
                      WHERE fmcoent = g_enterprise
                        AND fmcodocno = g_fmcj_m.fmcjdocno
                        AND fmcoseq = g_fmck5_d[l_ac].fmcoseq
                  
                     IF cl_null(g_fmck5_d[l_ac].fmcoseq2) THEN
                        LET g_fmck5_d[l_ac].fmcoseq2 = 1
                     ELSE
                        LET g_fmck5_d[l_ac].fmcoseq2 = g_fmck5_d[l_ac].fmcoseq2 + 1
                     END IF
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcoseq2
            #add-point:ON CHANGE fmcoseq2 name="input.g.page5.fmcoseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmco001
            #add-point:BEFORE FIELD fmco001 name="input.b.page5.fmco001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmco001
            
            #add-point:AFTER FIELD fmco001 name="input.a.page5.fmco001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmck5_d[l_ac].fmco002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmck5_d[l_ac].fmco002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmck5_d[l_ac].fmco002_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmco001
            #add-point:ON CHANGE fmco001 name="input.g.page5.fmco001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmco002
            
            #add-point:AFTER FIELD fmco002 name="input.a.page5.fmco002"
            IF NOT cl_null(g_fmck5_d[l_ac].fmco002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa026
               LET g_chkparam.arg2 = g_fmck5_d[l_ac].fmco002
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#6--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002_1") THEN
                  #檢查成功時後續處理
                  IF NOT cl_null(g_fmck5_d[l_ac].fmco003) AND (g_fmck5_d[l_ac].fmco004 = 0 OR g_fmck5_d[l_ac].fmco002 <> g_fmck5_d_t.fmco002) THEN 
                     SELECT fmck002,fmck004 INTO l_fmck002,l_fmck004 FROM fmck_t
                      WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
                        AND fmckseq = g_fmck5_d[l_ac].fmcoseq
                     IF l_fmck002 <> g_fmck5_d[l_ac].fmco002 THEN
                                                 #匯率參照表;帳套;           日期;         來源幣別
                        CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_fmck002,
                                                  #目的幣別;          交易金額; 匯類類型
                                                  g_fmck5_d[l_ac].fmco002,0,g_glaa025)
                        RETURNING l_rate
                     END IF
                     IF cl_null(l_rate) THEN LET l_rate = 1 END IF
                     LET g_fmck5_d[l_ac].fmco004 = l_fmck004 * g_fmck5_d[l_ac].fmco003 * l_rate
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_fmck5_d[l_ac].fmco002
               CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_fmck5_d[l_ac].fmco002_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_fmck5_d[l_ac].fmco002_desc

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmco002
            #add-point:BEFORE FIELD fmco002 name="input.b.page5.fmco002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmco002
            #add-point:ON CHANGE fmco002 name="input.g.page5.fmco002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmco003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmck5_d[l_ac].fmco003,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmco003
            END IF 
 
 
 
            #add-point:AFTER FIELD fmco003 name="input.a.page5.fmco003"
            IF NOT cl_null(g_fmck5_d[l_ac].fmco003) AND (g_fmck5_d[l_ac].fmco004 = 0 OR g_fmck5_d[l_ac].fmco003 <> g_fmck5_d_t.fmco003) THEN 
               SELECT fmck002,fmck004 INTO l_fmck002,l_fmck004 FROM fmck_t
                WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
                  AND fmckseq = g_fmck5_d[l_ac].fmcoseq
               IF l_fmck002 <> g_fmck5_d[l_ac].fmco002 THEN
                                           #匯率參照表;帳套;           日期;         來源幣別
                  CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_fmck002,
                                            #目的幣別;          交易金額; 匯類類型
                                            g_fmck5_d[l_ac].fmco002,0,g_glaa025)
                  RETURNING l_rate
               END IF
               IF cl_null(l_rate) THEN LET l_rate = 1 END IF
               LET g_fmck5_d[l_ac].fmco004 = l_fmck004 * g_fmck5_d[l_ac].fmco003 * l_rate
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmco003
            #add-point:BEFORE FIELD fmco003 name="input.b.page5.fmco003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmco003
            #add-point:ON CHANGE fmco003 name="input.g.page5.fmco003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmco004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmck5_d[l_ac].fmco004,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmco004
            END IF 
 
 
 
            #add-point:AFTER FIELD fmco004 name="input.a.page5.fmco004"
            IF NOT cl_null(g_fmck5_d[l_ac].fmco004) THEN 
               
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmco004
            #add-point:BEFORE FIELD fmco004 name="input.b.page5.fmco004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmco004
            #add-point:ON CHANGE fmco004 name="input.g.page5.fmco004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmco005
            #add-point:BEFORE FIELD fmco005 name="input.b.page5.fmco005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmco005
            
            #add-point:AFTER FIELD fmco005 name="input.a.page5.fmco005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmco005
            #add-point:ON CHANGE fmco005 name="input.g.page5.fmco005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page5.fmcoseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcoseq
            #add-point:ON ACTION controlp INFIELD fmcoseq name="input.c.page5.fmcoseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.fmcoseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcoseq2
            #add-point:ON ACTION controlp INFIELD fmcoseq2 name="input.c.page5.fmcoseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.fmco001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmco001
            #add-point:ON ACTION controlp INFIELD fmco001 name="input.c.page5.fmco001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.fmco002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmco002
            #add-point:ON ACTION controlp INFIELD fmco002 name="input.c.page5.fmco002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmck5_d[l_ac].fmco002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooaj001='",g_glaa026,"' "


            CALL q_ooaj002()                                #呼叫開窗

            LET g_fmck5_d[l_ac].fmco002 = g_qryparam.return1              

            DISPLAY g_fmck5_d[l_ac].fmco002 TO fmco002              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmck5_d[l_ac].fmco002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmck5_d[l_ac].fmco002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmck5_d[l_ac].fmco002_desc
            LET g_qryparam.where = ""

            NEXT FIELD fmco002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page5.fmco003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmco003
            #add-point:ON ACTION controlp INFIELD fmco003 name="input.c.page5.fmco003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.fmco004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmco004
            #add-point:ON ACTION controlp INFIELD fmco004 name="input.c.page5.fmco004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.fmco005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmco005
            #add-point:ON ACTION controlp INFIELD fmco005 name="input.c.page5.fmco005"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page5 after_row name="input.body5.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmck5_d[l_ac].* = g_fmck5_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt035_bcl5
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt035_unlock_b("fmco_t","'5'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page5 after_row2 name="input.body5.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body5.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmck5_d[li_reproduce_target].* = g_fmck5_d[li_reproduce].*
 
               LET g_fmck5_d[li_reproduce_target].fmcoseq = NULL
               LET g_fmck5_d[li_reproduce_target].fmcoseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmck5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmck5_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="afmt035.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'4',"))
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue("'5',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD fmcj001
            #end add-point  
            NEXT FIELD fmcjdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fmckseq
               WHEN "s_detail2"
                  NEXT FIELD fmclseq
               WHEN "s_detail3"
                  NEXT FIELD fmcmseq
               WHEN "s_detail4"
                  NEXT FIELD fmcnseq
               WHEN "s_detail5"
                  NEXT FIELD fmcoseq
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         CALL afmt035_b_fill()
         #end add-point    
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
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
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         LET l_n = 0 
         SELECT COUNT(*) INTO l_n FROM fmcn_t
          WHERE fmcnent = g_enterprise AND fmcndocno = g_fmcj_m.fmcjdocno
            AND fmcn003 = '2' AND fmcn004 = 0 
         IF l_n > 0 THEN
            IF cl_ask_confirm('afm-00248') THEN
               NEXT FIELD fmcn004
            END IF 
         END IF
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
         LET g_detail_idx_list[5] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
         LET g_detail_idx_list[5] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   IF g_fmcj_m.fmcj008 = 'N' THEN
      LET INT_FLAG = 0
   END IF
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afmt035_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afmt035_b_fill() #單身填充
      CALL afmt035_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt035_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_fmcj_m_mask_o.* =  g_fmcj_m.*
   CALL afmt035_fmcj_t_mask()
   LET g_fmcj_m_mask_n.* =  g_fmcj_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmcj_m.fmcjsite,g_fmcj_m.fmcjsite_desc,g_fmcj_m.fmcjcomp,g_fmcj_m.fmcjcomp_desc, 
       g_fmcj_m.fmcj001,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt, 
       g_fmcj_m.fmcj002,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005, 
       g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus,g_fmcj_m.fmcjownid,g_fmcj_m.fmcjownid_desc,g_fmcj_m.fmcjowndp, 
       g_fmcj_m.fmcjowndp_desc,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdp_desc, 
       g_fmcj_m.fmcjcrtdt,g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmodid_desc,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid, 
       g_fmcj_m.fmcjcnfid_desc,g_fmcj_m.fmcjcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmcj_m.fmcjstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
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
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_fmck_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_fmck2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fmck3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fmck4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fmck5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afmt035_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afmt035_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt035_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fmcj_t.fmcjdocno 
   DEFINE l_oldno     LIKE fmcj_t.fmcjdocno 
 
   DEFINE l_master    RECORD LIKE fmcj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fmck_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE fmcl_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE fmcm_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE fmcn_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE fmco_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_fmcj_m.fmcjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_fmcjdocno_t = g_fmcj_m.fmcjdocno
 
    
   LET g_fmcj_m.fmcjdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmcj_m.fmcjownid = g_user
      LET g_fmcj_m.fmcjowndp = g_dept
      LET g_fmcj_m.fmcjcrtid = g_user
      LET g_fmcj_m.fmcjcrtdp = g_dept 
      LET g_fmcj_m.fmcjcrtdt = cl_get_current()
      LET g_fmcj_m.fmcjmodid = g_user
      LET g_fmcj_m.fmcjmoddt = cl_get_current()
      LET g_fmcj_m.fmcjstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmcj_m.fmcjstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
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
   
   
   CALL afmt035_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fmcj_m.* TO NULL
      INITIALIZE g_fmck_d TO NULL
      INITIALIZE g_fmck2_d TO NULL
      INITIALIZE g_fmck3_d TO NULL
      INITIALIZE g_fmck4_d TO NULL
      INITIALIZE g_fmck5_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afmt035_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt035_set_act_visible()   
   CALL afmt035_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmcjdocno_t = g_fmcj_m.fmcjdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmcjent = " ||g_enterprise|| " AND",
                      " fmcjdocno = '", g_fmcj_m.fmcjdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt035_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afmt035_idx_chk()
   
   LET g_data_owner = g_fmcj_m.fmcjownid      
   LET g_data_dept  = g_fmcj_m.fmcjowndp
   
   #功能已完成,通報訊息中心
   CALL afmt035_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afmt035_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fmck_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE fmcl_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE fmcm_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE fmcn_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE fmco_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afmt035_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmck_t
    WHERE fmckent = g_enterprise AND fmckdocno = g_fmcjdocno_t
 
    INTO TEMP afmt035_detail
 
   #將key修正為調整後   
   UPDATE afmt035_detail 
      #更新key欄位
      SET fmckdocno = g_fmcj_m.fmcjdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fmck_t SELECT * FROM afmt035_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afmt035_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmcl_t 
    WHERE fmclent = g_enterprise AND fmcldocno = g_fmcjdocno_t
 
    INTO TEMP afmt035_detail
 
   #將key修正為調整後   
   UPDATE afmt035_detail SET fmcldocno = g_fmcj_m.fmcjdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO fmcl_t SELECT * FROM afmt035_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afmt035_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmcm_t 
    WHERE fmcment = g_enterprise AND fmcmdocno = g_fmcjdocno_t
 
    INTO TEMP afmt035_detail
 
   #將key修正為調整後   
   UPDATE afmt035_detail SET fmcmdocno = g_fmcj_m.fmcjdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO fmcm_t SELECT * FROM afmt035_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afmt035_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmcn_t 
    WHERE fmcnent = g_enterprise AND fmcndocno = g_fmcjdocno_t
 
    INTO TEMP afmt035_detail
 
   #將key修正為調整後   
   UPDATE afmt035_detail SET fmcndocno = g_fmcj_m.fmcjdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO fmcn_t SELECT * FROM afmt035_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afmt035_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table5.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmco_t 
    WHERE fmcoent = g_enterprise AND fmcodocno = g_fmcjdocno_t
 
    INTO TEMP afmt035_detail
 
   #將key修正為調整後   
   UPDATE afmt035_detail SET fmcodocno = g_fmcj_m.fmcjdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table5.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO fmco_t SELECT * FROM afmt035_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table5.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afmt035_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table5.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fmcjdocno_t = g_fmcj_m.fmcjdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afmt035_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_n             LIKE type_t.num5    #160122-00001#1
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_fmcj_m.fmcjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afmt035_cl USING g_enterprise,g_fmcj_m.fmcjdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt035_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt035_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt035_master_referesh USING g_fmcj_m.fmcjdocno INTO g_fmcj_m.fmcjsite,g_fmcj_m.fmcjcomp, 
       g_fmcj_m.fmcj001,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj002, 
       g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005,g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus, 
       g_fmcj_m.fmcjownid,g_fmcj_m.fmcjowndp,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdt, 
       g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid,g_fmcj_m.fmcjcnfdt,g_fmcj_m.fmcjsite_desc, 
       g_fmcj_m.fmcjcomp_desc,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcjownid_desc,g_fmcj_m.fmcjowndp_desc, 
       g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp_desc,g_fmcj_m.fmcjmodid_desc,g_fmcj_m.fmcjcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT afmt035_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmcj_m_mask_o.* =  g_fmcj_m.*
   CALL afmt035_fmcj_t_mask()
   LET g_fmcj_m_mask_n.* =  g_fmcj_m.*
   
   CALL afmt035_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt035_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      #160126-00010#1---add---str
      LET l_n = 0 
      #單身存在當前用戶沒有權限的交易帳戶編碼
      SELECT COUNT(*) INTO l_n FROM fmck_t
       WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
         AND fmck003 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus='Y')
         #160122-00001#1 add by07675
         AND fmck003 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus='Y')
         AND TRIM(fmck003) IS NOT NULL
      IF l_n > 0 THEN
         IF NOT cl_ask_confirm('anm-00395') THEN
            CLOSE afmt035_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #160122-00001#1 add by07675
      #IF l_n = 0 THEN
      #160126-00010#1---add---end
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_fmcjdocno_t = g_fmcj_m.fmcjdocno
 
 
      DELETE FROM fmcj_t
       WHERE fmcjent = g_enterprise AND fmcjdocno = g_fmcj_m.fmcjdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
         
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_fmcj_m.fmcjdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_glaald,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
     # END IF    #160126-00010#1
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM fmck_t
       WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
#      #160126-00010#1---add---str
#          AND (fmck003 IN ( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user)
#           OR fmck003 IS NULL)
#      #160126-00010#1---add---end
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmck_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM fmcl_t
       WHERE fmclent = g_enterprise AND
             fmcldocno = g_fmcj_m.fmcjdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      #160126-00010#1---add---str
          AND fmclseq2 NOT IN ( SELECT UNIQUE fmckseq FROM fmck_t WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno)
      #160126-00010#1---add---end
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM fmcm_t
       WHERE fmcment = g_enterprise AND
             fmcmdocno = g_fmcj_m.fmcjdocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      #160126-00010#1---add---str
          AND fmcmseq2 NOT IN ( SELECT UNIQUE fmckseq FROM fmck_t WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno)
      #160126-00010#1---add---end
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
      
      #end add-point
      DELETE FROM fmcn_t
       WHERE fmcnent = g_enterprise AND
             fmcndocno = g_fmcj_m.fmcjdocno
      #add-point:單身刪除中 name="delete.body.m_delete4"
      #160126-00010#1---add---str
          AND fmcnseq2 NOT IN ( SELECT UNIQUE fmckseq FROM fmck_t WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno)
      #160126-00010#1---add---end
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete5"
      
      #end add-point
      DELETE FROM fmco_t
       WHERE fmcoent = g_enterprise AND
             fmcodocno = g_fmcj_m.fmcjdocno
      #add-point:單身刪除中 name="delete.body.m_delete5"
      #160126-00010#1---add---str
          AND fmcoseq2 NOT IN ( SELECT UNIQUE fmckseq FROM fmck_t WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno)
      #160126-00010#1---add---end
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmco_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete5"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fmcj_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afmt035_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fmck_d.clear() 
      CALL g_fmck2_d.clear()       
      CALL g_fmck3_d.clear()       
      CALL g_fmck4_d.clear()       
      CALL g_fmck5_d.clear()       
 
     
      CALL afmt035_ui_browser_refresh()  
      #CALL afmt035_ui_headershow()  
      #CALL afmt035_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afmt035_browser_fill("")
         CALL afmt035_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afmt035_cl
 
   #功能已完成,通報訊息中心
   CALL afmt035_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afmt035.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmt035_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fmck_d.clear()
   CALL g_fmck2_d.clear()
   CALL g_fmck3_d.clear()
   CALL g_fmck4_d.clear()
   CALL g_fmck5_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF afmt035_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmckseq,fmck002,fmck003,fmck004,fmck005,fmck006,fmck007,fmck008, 
             fmck009,fmck010,fmck011,fmck012 ,t1.ooail003 FROM fmck_t",   
                     " INNER JOIN fmcj_t ON fmcjent = " ||g_enterprise|| " AND fmcjdocno = fmckdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooail_t t1 ON t1.ooailent="||g_enterprise||" AND t1.ooail001=fmck002 AND t1.ooail002='"||g_dlang||"' ",
 
                     " WHERE fmckent=? AND fmckdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
#         LET g_sql = g_sql CLIPPED," AND fmck003 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')"  #160122-00001#1
 #        LET g_sql = g_sql CLIPPED," AND fmck003 IN(",g_sql_bank,")"      #160122-00001#1 mod by 07675  #160829-00036#1  16/09/01 By 07900  mark
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  #160122-00001#1
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmck_t.fmckseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt035_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afmt035_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fmcj_m.fmcjdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fmcj_m.fmcjdocno INTO g_fmck_d[l_ac].fmckseq,g_fmck_d[l_ac].fmck002, 
          g_fmck_d[l_ac].fmck003,g_fmck_d[l_ac].fmck004,g_fmck_d[l_ac].fmck005,g_fmck_d[l_ac].fmck006, 
          g_fmck_d[l_ac].fmck007,g_fmck_d[l_ac].fmck008,g_fmck_d[l_ac].fmck009,g_fmck_d[l_ac].fmck010, 
          g_fmck_d[l_ac].fmck011,g_fmck_d[l_ac].fmck012,g_fmck_d[l_ac].fmck002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #160829-00036#1  16/09/01 By 07900 --add--s--
         #判断当前用户是否有权限查看该交易账户，如果没有权限不可看到交易账户编号，用“*”显示
         CALL afmt035_get_lc_fmck003(g_fmck_d[l_ac].fmck003) RETURNING g_fmck_d[l_ac].fmck003
         #160829-00036#1  16/09/01 By 07900 --add--e--
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF afmt035_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmclseq,fmclseq2,fmcl001,fmcl002,fmcl003,fmcl004,fmcl005,fmcl006  FROM fmcl_t", 
                
                     " INNER JOIN  fmcj_t ON fmcjent = " ||g_enterprise|| " AND fmcjdocno = fmcldocno ",
 
                     "",
                     
                     
                     " WHERE fmclent=? AND fmcldocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         #160829-00036#1 --mark--s--
         #160126-00010#1---add---str
#         LET g_sql = g_sql CLIPPED," AND fmclseq NOT IN (SELECT fmckseq FROM fmck_t WHERE fmckent = ",g_enterprise,
#                                   " AND fmckdocno = '",g_fmcj_m.fmcjdocno,"')"
#                                    #160829-00036#1--mark--s--
##                                   " AND fmck003 NOT IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
##                                   " AND nmll002 = '",g_user,"'))"
#                                    #160829-00036#1--mark--e--
#         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #160126-00010#1---add---end
         #160829-00036#1 --mark--e--
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmcl_t.fmclseq,fmcl_t.fmclseq2"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt035_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR afmt035_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_fmcj_m.fmcjdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_fmcj_m.fmcjdocno INTO g_fmck2_d[l_ac].fmclseq,g_fmck2_d[l_ac].fmclseq2, 
          g_fmck2_d[l_ac].fmcl001,g_fmck2_d[l_ac].fmcl002,g_fmck2_d[l_ac].fmcl003,g_fmck2_d[l_ac].fmcl004, 
          g_fmck2_d[l_ac].fmcl005,g_fmck2_d[l_ac].fmcl006   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF afmt035_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmcmseq,fmcmseq2,fmcm001,fmcm002,fmcm003,fmcm004 ,t2.ooail003 FROM fmcm_t", 
                
                     " INNER JOIN  fmcj_t ON fmcjent = " ||g_enterprise|| " AND fmcjdocno = fmcmdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooail_t t2 ON t2.ooailent="||g_enterprise||" AND t2.ooail001=fmcm001 AND t2.ooail002='"||g_dlang||"' ",
 
                     " WHERE fmcment=? AND fmcmdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         #160829-00036#1 --mark--e--
         #160126-00010#1---add---str
#         LET g_sql = g_sql CLIPPED," AND fmcmseq NOT IN (SELECT fmckseq FROM fmck_t WHERE fmckent = ",g_enterprise,
#                                   " AND fmckdocno = '",g_fmcj_m.fmcjdocno,"')"
#                                   #160829-00036#1--mark--s--
##                                   " AND fmck003 NOT IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
##                                   " AND nmll002 = '",g_user,"'))"
#                                   #160829-00036#1--mark--e--
#         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #160126-00010#1---add---end
         #160829-00036#1 --mark--e--
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmcm_t.fmcmseq,fmcm_t.fmcmseq2"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt035_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR afmt035_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_fmcj_m.fmcjdocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_fmcj_m.fmcjdocno INTO g_fmck3_d[l_ac].fmcmseq,g_fmck3_d[l_ac].fmcmseq2, 
          g_fmck3_d[l_ac].fmcm001,g_fmck3_d[l_ac].fmcm002,g_fmck3_d[l_ac].fmcm003,g_fmck3_d[l_ac].fmcm004, 
          g_fmck3_d[l_ac].fmcm001_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF afmt035_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmcnseq,fmcnseq2,fmcn001,fmcn002,fmcn003,fmcn004,fmcn005,fmcn006, 
             fmcn007 ,t3.ooail003 FROM fmcn_t",   
                     " INNER JOIN  fmcj_t ON fmcjent = " ||g_enterprise|| " AND fmcjdocno = fmcndocno ",
 
                     "",
                     
                                    " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=fmcn001 AND t3.ooail002='"||g_dlang||"' ",
 
                     " WHERE fmcnent=? AND fmcndocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
         #160829-00036#1 --mark--s--
         #160126-00010#1---add---str
#         LET g_sql = g_sql CLIPPED," AND fmcnseq NOT IN (SELECT fmckseq FROM fmck_t WHERE fmckent = ",g_enterprise,
#                                   " AND fmckdocno = '",g_fmcj_m.fmcjdocno,"')"
#                                   #160829-00036#1--mark--s--
##                                   " AND fmck003 NOT IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
##                                   " AND nmll002 = '",g_user,"'))"
#                                   #160829-00036#1--mark--e--
#         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #160126-00010#1---add---end
         #160829-00036#1 --mark--e--
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmcn_t.fmcnseq,fmcn_t.fmcnseq2"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt035_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR afmt035_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_fmcj_m.fmcjdocno   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_fmcj_m.fmcjdocno INTO g_fmck4_d[l_ac].fmcnseq,g_fmck4_d[l_ac].fmcnseq2, 
          g_fmck4_d[l_ac].fmcn001,g_fmck4_d[l_ac].fmcn002,g_fmck4_d[l_ac].fmcn003,g_fmck4_d[l_ac].fmcn004, 
          g_fmck4_d[l_ac].fmcn005,g_fmck4_d[l_ac].fmcn006,g_fmck4_d[l_ac].fmcn007,g_fmck4_d[l_ac].fmcn001_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF afmt035_fill_chk(5) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body5.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmcoseq,fmcoseq2,fmco001,fmco002,fmco003,fmco004,fmco005 ,t4.ooail003 FROM fmco_t", 
                
                     " INNER JOIN  fmcj_t ON fmcjent = " ||g_enterprise|| " AND fmcjdocno = fmcodocno ",
 
                     "",
                     
                                    " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=fmco002 AND t4.ooail002='"||g_dlang||"' ",
 
                     " WHERE fmcoent=? AND fmcodocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body5.fill_sql"
          #160829-00036#1 --mark--s--
         #160126-00010#1---add---str
#         LET g_sql = g_sql CLIPPED," AND fmcoseq NOT IN (SELECT fmckseq FROM fmck_t WHERE fmckent = ",g_enterprise,
#                                   " AND fmckdocno = '",g_fmcj_m.fmcjdocno,"')"
#                                   #160829-00036#1--mark--s--
##                                   " AND fmck003 NOT IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
##                                   " AND nmll002 = '",g_user,"'))"
#                                   #160829-00036#1--mark--e--
#         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #160126-00010#1---add---end
         #160829-00036#1 --mark--e--
         #end add-point
         IF NOT cl_null(g_wc2_table5) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmco_t.fmcoseq,fmco_t.fmcoseq2"
         
         #add-point:單身填充控制 name="b_fill.sql5"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt035_pb5 FROM g_sql
         DECLARE b_fill_cs5 CURSOR FOR afmt035_pb5
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs5 USING g_enterprise,g_fmcj_m.fmcjdocno   #(ver:78)
                                               
      FOREACH b_fill_cs5 USING g_enterprise,g_fmcj_m.fmcjdocno INTO g_fmck5_d[l_ac].fmcoseq,g_fmck5_d[l_ac].fmcoseq2, 
          g_fmck5_d[l_ac].fmco001,g_fmck5_d[l_ac].fmco002,g_fmck5_d[l_ac].fmco003,g_fmck5_d[l_ac].fmco004, 
          g_fmck5_d[l_ac].fmco005,g_fmck5_d[l_ac].fmco002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill5.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_fmck_d.deleteElement(g_fmck_d.getLength())
   CALL g_fmck2_d.deleteElement(g_fmck2_d.getLength())
   CALL g_fmck3_d.deleteElement(g_fmck3_d.getLength())
   CALL g_fmck4_d.deleteElement(g_fmck4_d.getLength())
   CALL g_fmck5_d.deleteElement(g_fmck5_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afmt035_pb
   FREE afmt035_pb2
 
   FREE afmt035_pb3
 
   FREE afmt035_pb4
 
   FREE afmt035_pb5
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fmck_d.getLength()
      LET g_fmck_d_mask_o[l_ac].* =  g_fmck_d[l_ac].*
      CALL afmt035_fmck_t_mask()
      LET g_fmck_d_mask_n[l_ac].* =  g_fmck_d[l_ac].*
   END FOR
   
   LET g_fmck2_d_mask_o.* =  g_fmck2_d.*
   FOR l_ac = 1 TO g_fmck2_d.getLength()
      LET g_fmck2_d_mask_o[l_ac].* =  g_fmck2_d[l_ac].*
      CALL afmt035_fmcl_t_mask()
      LET g_fmck2_d_mask_n[l_ac].* =  g_fmck2_d[l_ac].*
   END FOR
   LET g_fmck3_d_mask_o.* =  g_fmck3_d.*
   FOR l_ac = 1 TO g_fmck3_d.getLength()
      LET g_fmck3_d_mask_o[l_ac].* =  g_fmck3_d[l_ac].*
      CALL afmt035_fmcm_t_mask()
      LET g_fmck3_d_mask_n[l_ac].* =  g_fmck3_d[l_ac].*
   END FOR
   LET g_fmck4_d_mask_o.* =  g_fmck4_d.*
   FOR l_ac = 1 TO g_fmck4_d.getLength()
      LET g_fmck4_d_mask_o[l_ac].* =  g_fmck4_d[l_ac].*
      CALL afmt035_fmcn_t_mask()
      LET g_fmck4_d_mask_n[l_ac].* =  g_fmck4_d[l_ac].*
   END FOR
   LET g_fmck5_d_mask_o.* =  g_fmck5_d.*
   FOR l_ac = 1 TO g_fmck5_d.getLength()
      LET g_fmck5_d_mask_o[l_ac].* =  g_fmck5_d[l_ac].*
      CALL afmt035_fmco_t_mask()
      LET g_fmck5_d_mask_n[l_ac].* =  g_fmck5_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afmt035_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM fmck_t
       WHERE fmckent = g_enterprise AND
         fmckdocno = ps_keys_bak[1] AND fmckseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fmck_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM fmcl_t
       WHERE fmclent = g_enterprise AND
             fmcldocno = ps_keys_bak[1] AND fmclseq = ps_keys_bak[2] AND fmclseq2 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_fmck2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM fmcm_t
       WHERE fmcment = g_enterprise AND
             fmcmdocno = ps_keys_bak[1] AND fmcmseq = ps_keys_bak[2] AND fmcmseq2 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_fmck3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM fmcn_t
       WHERE fmcnent = g_enterprise AND
             fmcndocno = ps_keys_bak[1] AND fmcnseq = ps_keys_bak[2] AND fmcnseq2 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_fmck4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete5"
      
      #end add-point    
      DELETE FROM fmco_t
       WHERE fmcoent = g_enterprise AND
             fmcodocno = ps_keys_bak[1] AND fmcoseq = ps_keys_bak[2] AND fmcoseq2 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete5"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmco_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_fmck5_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete5"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afmt035_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO fmck_t
                  (fmckent,
                   fmckdocno,
                   fmckseq
                   ,fmck002,fmck003,fmck004,fmck005,fmck006,fmck007,fmck008,fmck009,fmck010,fmck011,fmck012) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_fmck_d[g_detail_idx].fmck002,g_fmck_d[g_detail_idx].fmck003,g_fmck_d[g_detail_idx].fmck004, 
                       g_fmck_d[g_detail_idx].fmck005,g_fmck_d[g_detail_idx].fmck006,g_fmck_d[g_detail_idx].fmck007, 
                       g_fmck_d[g_detail_idx].fmck008,g_fmck_d[g_detail_idx].fmck009,g_fmck_d[g_detail_idx].fmck010, 
                       g_fmck_d[g_detail_idx].fmck011,g_fmck_d[g_detail_idx].fmck012)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      CALL afmt035_ins_fmcm()
      CALL afmt035_ins_fmcn()
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmck_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fmck_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
     #CALL afmt035_b_fill()
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO fmcl_t
                  (fmclent,
                   fmcldocno,
                   fmclseq,fmclseq2
                   ,fmcl001,fmcl002,fmcl003,fmcl004,fmcl005,fmcl006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fmck2_d[g_detail_idx].fmcl001,g_fmck2_d[g_detail_idx].fmcl002,g_fmck2_d[g_detail_idx].fmcl003, 
                       g_fmck2_d[g_detail_idx].fmcl004,g_fmck2_d[g_detail_idx].fmcl005,g_fmck2_d[g_detail_idx].fmcl006) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_fmck2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO fmcm_t
                  (fmcment,
                   fmcmdocno,
                   fmcmseq,fmcmseq2
                   ,fmcm001,fmcm002,fmcm003,fmcm004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fmck3_d[g_detail_idx].fmcm001,g_fmck3_d[g_detail_idx].fmcm002,g_fmck3_d[g_detail_idx].fmcm003, 
                       g_fmck3_d[g_detail_idx].fmcm004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_fmck3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO fmcn_t
                  (fmcnent,
                   fmcndocno,
                   fmcnseq,fmcnseq2
                   ,fmcn001,fmcn002,fmcn003,fmcn004,fmcn005,fmcn006,fmcn007) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fmck4_d[g_detail_idx].fmcn001,g_fmck4_d[g_detail_idx].fmcn002,g_fmck4_d[g_detail_idx].fmcn003, 
                       g_fmck4_d[g_detail_idx].fmcn004,g_fmck4_d[g_detail_idx].fmcn005,g_fmck4_d[g_detail_idx].fmcn006, 
                       g_fmck4_d[g_detail_idx].fmcn007)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_fmck4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert5"
      
      #end add-point 
      INSERT INTO fmco_t
                  (fmcoent,
                   fmcodocno,
                   fmcoseq,fmcoseq2
                   ,fmco001,fmco002,fmco003,fmco004,fmco005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fmck5_d[g_detail_idx].fmco001,g_fmck5_d[g_detail_idx].fmco002,g_fmck5_d[g_detail_idx].fmco003, 
                       g_fmck5_d[g_detail_idx].fmco004,g_fmck5_d[g_detail_idx].fmco005)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmco_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_fmck5_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert5"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afmt035_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmck_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afmt035_fmck_t_mask_restore('restore_mask_o')
               
      UPDATE fmck_t 
         SET (fmckdocno,
              fmckseq
              ,fmck002,fmck003,fmck004,fmck005,fmck006,fmck007,fmck008,fmck009,fmck010,fmck011,fmck012) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_fmck_d[g_detail_idx].fmck002,g_fmck_d[g_detail_idx].fmck003,g_fmck_d[g_detail_idx].fmck004, 
                  g_fmck_d[g_detail_idx].fmck005,g_fmck_d[g_detail_idx].fmck006,g_fmck_d[g_detail_idx].fmck007, 
                  g_fmck_d[g_detail_idx].fmck008,g_fmck_d[g_detail_idx].fmck009,g_fmck_d[g_detail_idx].fmck010, 
                  g_fmck_d[g_detail_idx].fmck011,g_fmck_d[g_detail_idx].fmck012) 
         WHERE fmckent = g_enterprise AND fmckdocno = ps_keys_bak[1] AND fmckseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmck_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmck_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt035_fmck_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmcl_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL afmt035_fmcl_t_mask_restore('restore_mask_o')
               
      UPDATE fmcl_t 
         SET (fmcldocno,
              fmclseq,fmclseq2
              ,fmcl001,fmcl002,fmcl003,fmcl004,fmcl005,fmcl006) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fmck2_d[g_detail_idx].fmcl001,g_fmck2_d[g_detail_idx].fmcl002,g_fmck2_d[g_detail_idx].fmcl003, 
                  g_fmck2_d[g_detail_idx].fmcl004,g_fmck2_d[g_detail_idx].fmcl005,g_fmck2_d[g_detail_idx].fmcl006)  
 
         WHERE fmclent = g_enterprise AND fmcldocno = ps_keys_bak[1] AND fmclseq = ps_keys_bak[2] AND fmclseq2 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcl_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt035_fmcl_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmcm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL afmt035_fmcm_t_mask_restore('restore_mask_o')
               
      UPDATE fmcm_t 
         SET (fmcmdocno,
              fmcmseq,fmcmseq2
              ,fmcm001,fmcm002,fmcm003,fmcm004) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fmck3_d[g_detail_idx].fmcm001,g_fmck3_d[g_detail_idx].fmcm002,g_fmck3_d[g_detail_idx].fmcm003, 
                  g_fmck3_d[g_detail_idx].fmcm004) 
         WHERE fmcment = g_enterprise AND fmcmdocno = ps_keys_bak[1] AND fmcmseq = ps_keys_bak[2] AND fmcmseq2 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt035_fmcm_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmcn_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL afmt035_fmcn_t_mask_restore('restore_mask_o')
               
      UPDATE fmcn_t 
         SET (fmcndocno,
              fmcnseq,fmcnseq2
              ,fmcn001,fmcn002,fmcn003,fmcn004,fmcn005,fmcn006,fmcn007) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fmck4_d[g_detail_idx].fmcn001,g_fmck4_d[g_detail_idx].fmcn002,g_fmck4_d[g_detail_idx].fmcn003, 
                  g_fmck4_d[g_detail_idx].fmcn004,g_fmck4_d[g_detail_idx].fmcn005,g_fmck4_d[g_detail_idx].fmcn006, 
                  g_fmck4_d[g_detail_idx].fmcn007) 
         WHERE fmcnent = g_enterprise AND fmcndocno = ps_keys_bak[1] AND fmcnseq = ps_keys_bak[2] AND fmcnseq2 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcn_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcn_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt035_fmcn_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmco_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update5"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL afmt035_fmco_t_mask_restore('restore_mask_o')
               
      UPDATE fmco_t 
         SET (fmcodocno,
              fmcoseq,fmcoseq2
              ,fmco001,fmco002,fmco003,fmco004,fmco005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fmck5_d[g_detail_idx].fmco001,g_fmck5_d[g_detail_idx].fmco002,g_fmck5_d[g_detail_idx].fmco003, 
                  g_fmck5_d[g_detail_idx].fmco004,g_fmck5_d[g_detail_idx].fmco005) 
         WHERE fmcoent = g_enterprise AND fmcodocno = ps_keys_bak[1] AND fmcoseq = ps_keys_bak[2] AND fmcoseq2 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update5"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmco_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmco_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt035_fmco_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update5"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afmt035_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afmt035_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   DEFINE l_n         LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   IF ps_table = 'fmck_t' THEN
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM fmcl_t
       WHERE fmclent = g_enterprise AND fmcldocno = g_fmcj_m.fmcjdocno
         AND fmclseq = g_fmck_d[l_ac].fmckseq
      IF l_n > 0 THEN 
         DELETE FROM fmcl_t WHERE fmclent = g_enterprise AND fmcldocno = g_fmcj_m.fmcjdocno
            AND fmclseq = g_fmck_d[l_ac].fmckseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcl_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF   
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM fmcm_t
       WHERE fmcment = g_enterprise AND fmcmdocno = g_fmcj_m.fmcjdocno
         AND fmcmseq = g_fmck_d[l_ac].fmckseq
      IF l_n > 0 THEN 
         DELETE FROM fmcm_t WHERE fmcment = g_enterprise AND fmcmdocno = g_fmcj_m.fmcjdocno
            AND fmcmseq = g_fmck_d[l_ac].fmckseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcm_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
         
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM fmcn_t
       WHERE fmcnent = g_enterprise AND fmcndocno = g_fmcj_m.fmcjdocno
         AND fmcnseq = g_fmck_d[l_ac].fmckseq
      IF l_n > 0 THEN 
         DELETE FROM fmcn_t WHERE fmcnent = g_enterprise AND fmcndocno = g_fmcj_m.fmcjdocno
            AND fmcnseq = g_fmck_d[l_ac].fmckseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcn_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN FALSE
         END IF
      
      END IF
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM fmco_t
       WHERE fmcoent = g_enterprise AND fmcodocno = g_fmcj_m.fmcjdocno
         AND fmcoseq = g_fmck_d[l_ac].fmckseq
      IF l_n > 0 THEN 
         DELETE FROM fmco_t WHERE fmcoent = g_enterprise AND fmcodocno = g_fmcj_m.fmcjdocno
            AND fmcoseq = g_fmck_d[l_ac].fmckseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcn_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM fmcp_t
       WHERE fmcpent = g_enterprise AND fmcpdocno = g_fmcj_m.fmcjdocno
         AND fmcpseq = g_fmck_d[l_ac].fmckseq
      IF l_n > 0 THEN 
         DELETE FROM fmcp_t WHERE fmcpent = g_enterprise AND fmcpdocno = g_fmcj_m.fmcjdocno
            AND fmcpseq = g_fmck_d[l_ac].fmckseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcp_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM fmcq_t
       WHERE fmcqent = g_enterprise AND fmcqdocno = g_fmcj_m.fmcjdocno
         AND fmcqseq = g_fmck_d[l_ac].fmckseq
      IF l_n > 0 THEN 
         DELETE FROM fmcq_t WHERE fmcqent = g_enterprise AND fmcqdocno = g_fmcj_m.fmcjdocno
            AND fmcqseq = g_fmck_d[l_ac].fmckseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcq_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
   END IF
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afmt035_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL afmt035_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "fmck_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afmt035_bcl USING g_enterprise,
                                       g_fmcj_m.fmcjdocno,g_fmck_d[g_detail_idx].fmckseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt035_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "fmcl_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afmt035_bcl2 USING g_enterprise,
                                             g_fmcj_m.fmcjdocno,g_fmck2_d[g_detail_idx].fmclseq,g_fmck2_d[g_detail_idx].fmclseq2 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt035_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "fmcm_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afmt035_bcl3 USING g_enterprise,
                                             g_fmcj_m.fmcjdocno,g_fmck3_d[g_detail_idx].fmcmseq,g_fmck3_d[g_detail_idx].fmcmseq2 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt035_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "fmcn_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afmt035_bcl4 USING g_enterprise,
                                             g_fmcj_m.fmcjdocno,g_fmck4_d[g_detail_idx].fmcnseq,g_fmck4_d[g_detail_idx].fmcnseq2 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt035_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'5',"
   #僅鎖定自身table
   LET ls_group = "fmco_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afmt035_bcl5 USING g_enterprise,
                                             g_fmcj_m.fmcjdocno,g_fmck5_d[g_detail_idx].fmcoseq,g_fmck5_d[g_detail_idx].fmcoseq2 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt035_bcl5:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afmt035_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt035_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt035_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt035_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt035_bcl4
   END IF
 
   LET ls_group = "'5',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt035_bcl5
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt035_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("fmcjdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fmcjdocno",TRUE)
      CALL cl_set_comp_entry("fmcjdocdt",TRUE)
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
 
{<section id="afmt035.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt035_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_slip     LIKE type_t.chr10
   DEFINE l_dfin0033  LIKE type_t.chr80
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   CALL cl_set_comp_entry("fmcjdocdt",TRUE)
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmcjdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("fmcjdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("fmcjdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_fmcj_m.fmcjdocno) THEN
      #获取单别
      CALL s_aooi200_fin_get_slip(g_fmcj_m.fmcjdocno) RETURNING l_success,l_slip
      #是否可改日期
      CALL s_fin_get_doc_para(g_glaald,g_fmcj_m.fmcjcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "N"  THEN
         CALL cl_set_comp_entry("fmcjdocdt",FALSE)
      ELSE
         CALL cl_set_comp_entry("fmcjdocdt",TRUE)
      END IF
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afmt035_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="afmt035.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afmt035_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="afmt035.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt035_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt035_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_fmcj_m.fmcjstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afmt035_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afmt035_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt035_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " fmcjdocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
         INITIALIZE g_wc2_table4 TO NULL
 
         INITIALIZE g_wc2_table5 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "fmcj_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fmck_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fmcl_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "fmcm_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "fmcn_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "fmco_t" 
                  LET g_wc2_table5 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
            OR NOT cl_null(g_wc2_table5)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
            IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
            END IF
 
            IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
            END IF
 
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
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
 
{<section id="afmt035.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afmt035_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_sql        STRING
   DEFINE l_fmcp003    LIKE fmcp_t.fmcp003
   DEFINE l_fmcp004    LIKE fmcp_t.fmcp004
   DEFINE l_fmcp005    LIKE fmcp_t.fmcp005
   DEFINE l_fmcp007    LIKE fmcp_t.fmcp007
   DEFINE l_fmcp009    LIKE fmcp_t.fmcp009
   DEFINE l_today      DATETIME YEAR TO SECOND
   DEFINE l_fmaa003    LIKE fmaa_t.fmaa003
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_faah018    LIKE faah_t.faah018
   DEFINE l_faah037    LIKE faah_t.faah037
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fmcj_m.fmcjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afmt035_cl USING g_enterprise,g_fmcj_m.fmcjdocno
   IF STATUS THEN
      CLOSE afmt035_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt035_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afmt035_master_referesh USING g_fmcj_m.fmcjdocno INTO g_fmcj_m.fmcjsite,g_fmcj_m.fmcjcomp, 
       g_fmcj_m.fmcj001,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj002, 
       g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005,g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus, 
       g_fmcj_m.fmcjownid,g_fmcj_m.fmcjowndp,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdt, 
       g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid,g_fmcj_m.fmcjcnfdt,g_fmcj_m.fmcjsite_desc, 
       g_fmcj_m.fmcjcomp_desc,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcjownid_desc,g_fmcj_m.fmcjowndp_desc, 
       g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp_desc,g_fmcj_m.fmcjmodid_desc,g_fmcj_m.fmcjcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT afmt035_action_chk() THEN
      CLOSE afmt035_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmcj_m.fmcjsite,g_fmcj_m.fmcjsite_desc,g_fmcj_m.fmcjcomp,g_fmcj_m.fmcjcomp_desc, 
       g_fmcj_m.fmcj001,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt, 
       g_fmcj_m.fmcj002,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005, 
       g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus,g_fmcj_m.fmcjownid,g_fmcj_m.fmcjownid_desc,g_fmcj_m.fmcjowndp, 
       g_fmcj_m.fmcjowndp_desc,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdp_desc, 
       g_fmcj_m.fmcjcrtdt,g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmodid_desc,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid, 
       g_fmcj_m.fmcjcnfid_desc,g_fmcj_m.fmcjcnfdt
 
   CASE g_fmcj_m.fmcjstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
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
         CASE g_fmcj_m.fmcjstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
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
      HIDE OPTION "verify"
      HIDE OPTION "unverify"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_fmcj_m.fmcjstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "X"
            CALL s_transaction_end('N','0')
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT afmt035_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt035_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afmt035_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt035_cl
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
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_fmcj_m.fmcjstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afmt035_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151125-00001#2 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
   END IF
   #151125-00001#2 --- add end   ---
   #確認
   IF lc_state = 'Y' THEN

      CALL cl_err_collect_init()
      IF NOT s_afmt035_conf_chk(g_fmcj_m.fmcjdocno)  THEN
 
         CLOSE afmt035_cl
         CALL s_transaction_end('N','0')  
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CLOSE afmt035_cl
            CALL s_transaction_end('N','0') 
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_afmt035_conf_upd(g_fmcj_m.fmcjdocno) THEN
               CLOSE afmt035_cl
               CALL s_transaction_end('N','0')   #避免transaction被卡住,所以 rollback 後 再顯示錯誤訊息
               CALL cl_err_collect_show()
               RETURN
            ELSE

               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
               
            END IF
         END IF
      END IF
   END IF
   #取消確認
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      IF NOT s_afmt035_unconf_chk(g_fmcj_m.fmcjdocno)  THEN
         CLOSE afmt035_cl
         CALL s_transaction_end('N','0')  
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CLOSE afmt035_cl
            CALL s_transaction_end('N','0') 
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_afmt035_unconf_upd(g_fmcj_m.fmcjdocno) THEN
               CLOSE afmt035_cl
               CALL s_transaction_end('N','0')   #避免transaction被卡住,所以 rollback 後 再顯示錯誤訊息
               CALL cl_err_collect_show()
               RETURN
            ELSE

               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_fmcj_m.fmcjmodid = g_user
   LET g_fmcj_m.fmcjmoddt = cl_get_current()
   LET g_fmcj_m.fmcjstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fmcj_t 
      SET (fmcjstus,fmcjmodid,fmcjmoddt) 
        = (g_fmcj_m.fmcjstus,g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmoddt)     
    WHERE fmcjent = g_enterprise AND fmcjdocno = g_fmcj_m.fmcjdocno
 
    
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
      EXECUTE afmt035_master_referesh USING g_fmcj_m.fmcjdocno INTO g_fmcj_m.fmcjsite,g_fmcj_m.fmcjcomp, 
          g_fmcj_m.fmcj001,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno,g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj002, 
          g_fmcj_m.fmcj008,g_fmcj_m.fmcj003,g_fmcj_m.fmcj004,g_fmcj_m.fmcj005,g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus, 
          g_fmcj_m.fmcjownid,g_fmcj_m.fmcjowndp,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtdp,g_fmcj_m.fmcjcrtdt, 
          g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmoddt,g_fmcj_m.fmcjcnfid,g_fmcj_m.fmcjcnfdt,g_fmcj_m.fmcjsite_desc, 
          g_fmcj_m.fmcjcomp_desc,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcjownid_desc, 
          g_fmcj_m.fmcjowndp_desc,g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp_desc,g_fmcj_m.fmcjmodid_desc, 
          g_fmcj_m.fmcjcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fmcj_m.fmcjsite,g_fmcj_m.fmcjsite_desc,g_fmcj_m.fmcjcomp,g_fmcj_m.fmcjcomp_desc, 
          g_fmcj_m.fmcj001,g_fmcj_m.fmcj001_desc,g_fmcj_m.fmcj006,g_fmcj_m.fmcj007,g_fmcj_m.fmcjdocno, 
          g_fmcj_m.fmcjdocdt,g_fmcj_m.fmcj002,g_fmcj_m.fmcj002_desc,g_fmcj_m.fmcj008,g_fmcj_m.fmcj003, 
          g_fmcj_m.fmcj004,g_fmcj_m.fmcj005,g_fmcj_m.fmcj009,g_fmcj_m.fmcjstus,g_fmcj_m.fmcjownid,g_fmcj_m.fmcjownid_desc, 
          g_fmcj_m.fmcjowndp,g_fmcj_m.fmcjowndp_desc,g_fmcj_m.fmcjcrtid,g_fmcj_m.fmcjcrtid_desc,g_fmcj_m.fmcjcrtdp, 
          g_fmcj_m.fmcjcrtdp_desc,g_fmcj_m.fmcjcrtdt,g_fmcj_m.fmcjmodid,g_fmcj_m.fmcjmodid_desc,g_fmcj_m.fmcjmoddt, 
          g_fmcj_m.fmcjcnfid,g_fmcj_m.fmcjcnfid_desc,g_fmcj_m.fmcjcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afmt035_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt035_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt035.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afmt035_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fmck_d.getLength() THEN
         LET g_detail_idx = g_fmck_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmck_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmck_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_fmck2_d.getLength() THEN
         LET g_detail_idx = g_fmck2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmck2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmck2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_fmck3_d.getLength() THEN
         LET g_detail_idx = g_fmck3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmck3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmck3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_fmck4_d.getLength() THEN
         LET g_detail_idx = g_fmck4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmck4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmck4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_fmck5_d.getLength() THEN
         LET g_detail_idx = g_fmck5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmck5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmck5_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmt035_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL afmt035_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afmt035_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND 
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1')  AND 
      (cl_null(g_wc2_table5) OR g_wc2_table5.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035.status_show" >}
PRIVATE FUNCTION afmt035_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt035.mask_functions" >}
&include "erp/afm/afmt035_mask.4gl"
 
{</section>}
 
{<section id="afmt035.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afmt035_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
   LET g_wc2_table4 = " 1=1"
   LET g_wc2_table5 = " 1=1"
 
 
   CALL afmt035_show()
   CALL afmt035_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fmcj_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fmck_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_fmck2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_fmck3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_fmck4_d))
   CALL cl_bpm_set_detail_data("s_detail5", util.JSONArray.fromFGL(g_fmck5_d))
 
 
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
   #CALL afmt035_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afmt035_ui_headershow()
   CALL afmt035_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afmt035_draw_out()
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
   CALL afmt035_ui_headershow()  
   CALL afmt035_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afmt035.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt035_set_pk_array()
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
   LET g_pk_array[1].values = g_fmcj_m.fmcjdocno
   LET g_pk_array[1].column = 'fmcjdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt035.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afmt035.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt035_msgcentre_notify(lc_state)
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
   CALL afmt035_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmcj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt035.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmt035_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#13 16/08/24 By 07900  add--s--
   SELECT fmcjstus INTO g_fmcj_m.fmcjstus
     FROM fmcj_t
    WHERE fmcjent = g_enterprise
      AND fmcjdocno = g_fmcj_m.fmcjdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_fmcj_m.fmcjstus
       
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_fmcj_m.fmcjdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afmt035_set_act_visible()
        CALL afmt035_set_act_no_visible()
        CALL afmt035_show()
        RETURN FALSE
     END IF
   END IF
   
   #160818-00017#13 16/08/24 By 07900  add--e--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035.other_function" readonly="Y" >}
# Descriptions...: 归属法人及说明
# Memo...........:
# Usage..........: CALL afmt035_ooef017(p_site)
#                  RETURNING r_ooef017,r_ooef017_desc
# Input parameter: p_site         组织
# Return code....: r_ooef017      法人
#                : r_ooef017_desc 法人说明
# Date & Author..: 2015/11/13 By  yangtt
# Modify.........:
PRIVATE FUNCTION afmt035_ooef017(p_site)
DEFINE p_site           LIKE ooef_t.ooef001
DEFINE r_ooef017        LIKE ooef_t.ooef017
DEFINE r_ooef017_desc   LIKE type_t.chr500

   SELECT ooef017,ooefl003 INTO r_ooef017,r_ooef017_desc FROM ooef_t
     LEFT OUTER JOIN ooefl_t ON ooeflent = ooefent AND ooefl001 = ooef017 AND ooefl002 = g_dlang
    WHERE ooefent = g_enterprise AND ooef001 = p_site
   
   RETURN r_ooef017,r_ooef017_desc
END FUNCTION

################################################################################
# Descriptions...: 獲取法人主帳套資料
# Memo...........:
# Usage..........: CALL afmt035_fmagsite_ref()
# Date & Author..: 2015/11/13 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_fmcjsite_ref()
   SELECT glaald,glaa003,glaa024,glaa025,glaa026 INTO g_glaald,g_glaa003,g_glaa024,g_glaa025,g_glaa026 FROM glaa_t,ooef_t
    WHERE glaaent = ooefent AND glaacomp = ooef017 
      AND glaaent = g_enterprise AND ooef001 = g_fmcj_m.fmcjsite
      AND glaa014 = 'Y'
END FUNCTION

################################################################################
# Descriptions...: 贷款期限检查
# Memo...........:
# Usage..........: CALL afmt035_fmcj006_chk()
# Date & Author..: 2015/11/13 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_fmcj006_chk()

   LET g_errno = '' 
   IF NOT cl_null(g_fmcj_m.fmcj006) AND NOT cl_null(g_fmcj_m.fmcj006) THEN
      IF g_fmcj_m.fmcj006 > g_fmcj_m.fmcj007 THEN
         LET g_errno = 'afm-00157'
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 若利率方式=2.浮动方式,浮动方式栏位必录
# Memo...........:
# Usage..........: CALL afmi030_fmck005_ref()
# Date & Author..: 2015/11/13 By yangtt
# Modify.........:
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_fmck005_ref()
   CALL cl_set_comp_entry("fmck006",FALSE)
   CALL cl_set_comp_required("fmck006",FALSE)
   IF NOT cl_null(g_fmck_d[l_ac].fmck005) THEN
      IF g_fmck_d[l_ac].fmck005 = '2' THEN
         CALL cl_set_comp_required("fmck006",TRUE)
         LET g_fmck_d[l_ac].fmck006 = '1'
         CALL cl_set_comp_entry("fmck006",TRUE)
         DISPLAY BY NAME g_fmck_d[l_ac].fmck006
      ELSE
         LET g_fmck_d[l_ac].fmck006 = ''
         DISPLAY BY NAME g_fmck_d[l_ac].fmck006
         CALL cl_set_comp_entry("fmck006",FALSE)
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 检查融资清单项次是否存爱
# Memo...........:
# Usage..........: CALL afmt035_fmackseq_chk(p_fmckseq)
#                  RETURNING r_success
# Input parameter: p_fmckseq   融资清单项次
# Return code....: r_success   
# Date & Author..: 2015/11/13 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_fmackseq_chk(p_fmckseq)
DEFINE p_fmckseq        LIKE fmck_t.fmckseq
DEFINE r_success        LIKE type_t.num5
DEFINE l_n              LIKE type_t.num5

   LET r_success = TRUE
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM fmck_t
    WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
      AND fmckseq = p_fmckseq
   
   IF l_n = 0 THEN
      LET r_success = FALSE
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 空管栏位开启关闭
# Memo...........:
# Usage..........: CALL afmt035_fmcl001_entry()
# Date & Author..: 2015/11/13 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_fmcl001_entry()
   CALL cl_set_comp_entry('fmcl002,fmcl003,fmcl004',TRUE) 
   CALL cl_set_comp_entry('fmcl005,fmcl006',TRUE)
   CALL cl_set_comp_required("fmcl005,fmcl006",FALSE)
   CASE g_fmck2_d[l_ac].fmcl001
      WHEN '1' 
         LET g_fmck2_d[l_ac].fmcl002 = ''
         LET g_fmck2_d[l_ac].fmcl003 = ''
         LET g_fmck2_d[l_ac].fmcl004 = ''
         CALL cl_set_comp_entry('fmcl002,fmcl003,fmcl004',FALSE) 
         CALL cl_set_comp_required("fmcl005,fmcl006",TRUE)
      WHEN '2' 
         LET g_fmck2_d[l_ac].fmcl005 = ''
         LET g_fmck2_d[l_ac].fmcl006 = ''
         CALL cl_set_comp_entry('fmcl005,fmcl006',FALSE)
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 空管是否可录，必输
# Memo...........:
# Usage..........: CALL afmt035_fmcl002_entry()
# Date & Author..: 2015/11/13 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_fmcl002_entry()
   CALL cl_set_comp_required("fmcl003,fmcl004",FALSE)
   IF g_fmck2_d[l_ac].fmcl002 = '1' OR g_fmck2_d[l_ac].fmcl002 = '5' THEN
      CALL cl_set_comp_required("fmcl003,fmcl004",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...:當利率方式=固定利率时，  执行利率=基准利率
# Memo...........:
# Usage..........: CALL afmt035_fmcn003_ref()
# Date & Author..: 2015/11/13 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_fmcn003_ref()
DEFINE l_fmck007          LIKE fmck_t.fmck007

   SELECT fmck005,fmck006,fmck007 INTO g_fmck4_d[l_ac].fmcn003,g_fmck4_d[l_ac].fmcn005,l_fmck007
     FROM fmck_t
    WHERE fmckent = g_enterprise AND fmckdocno = g_fmcj_m.fmcjdocno
      AND fmckseq = g_fmck4_d[l_ac].fmcnseq
      
   IF cl_null(g_fmck4_d[l_ac].fmcn003) THEN LET g_fmck4_d[l_ac].fmcn003 = 0 END IF
   IF cl_null(g_fmck4_d[l_ac].fmcn005) THEN LET g_fmck4_d[l_ac].fmcn005 = 0 END IF
   IF cl_null(l_fmck007) THEN LET l_fmck007 = 0 END IF
   CALL cl_set_comp_required("fmcn005",FALSE)
   IF g_fmck4_d[l_ac].fmcn003 = '1' THEN   #固定利率
      LET g_fmck4_d[l_ac].fmcn006 = 0
      LET g_fmck4_d[l_ac].fmcn007 = l_fmck007
   ELSE #浮动利率
      CALL cl_set_comp_required("fmcn005",TRUE)
      IF cl_null(g_fmck4_d[l_ac].fmcn006) OR g_fmck4_d[l_ac].fmcn006 <> g_fmck4_d_t.fmcn006 THEN
         LET g_fmck4_d[l_ac].fmcn006 = l_fmck007
      END IF
      IF g_fmck4_d[ l_ac].fmcn005 = '1' THEN  #比例时
         LET g_fmck4_d[l_ac].fmcn007 = g_fmck4_d[l_ac].fmcn004 * (1 + g_fmck4_d[l_ac].fmcn006/100)
      ELSE  #固定值
         LET g_fmck4_d[l_ac].fmcn007 = g_fmck4_d[l_ac].fmcn004 + g_fmck4_d[l_ac].fmcn006/100
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 插入fmcm_t,fmcn_t,fmco_t
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/11/16 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_ins_fmcm()
DEFINE l_fmcmseq2            LIKE fmcm_t.fmcmseq2
DEFINE l_fmcm001             LIKE fmcm_t.fmcm001
DEFINE l_fmcm002             LIKE fmcm_t.fmcm002
DEFINE l_fmcm003             LIKE fmcm_t.fmcm003
DEFINE l_fmcm004             LIKE fmcm_t.fmcm004
DEFINE l_fmcnseq2            LIKE fmcn_t.fmcnseq2
DEFINE l_fmcn001             LIKE fmcn_t.fmcn001
DEFINE l_fmcn002             LIKE fmcn_t.fmcn002
DEFINE l_fmcn003             LIKE fmcn_t.fmcn003
DEFINE l_fmcn004             LIKE fmcn_t.fmcn004
DEFINE l_fmcn005             LIKE fmcn_t.fmcn005
DEFINE l_fmcn006             LIKE fmcn_t.fmcn006
DEFINE l_fmcn007             LIKE fmcn_t.fmcn007
DEFINE l_year                LIKE type_t.num5
DEFINE l_month1              LIKE type_t.num5
DEFINE l_day1                LIKE type_t.num5
DEFINE l_success             LIKE type_t.num5
DEFINE l_ooef006             LIKE ooef_t.ooef006
DEFINE l_fmbj003             LIKE fmbj_t.fmbj003


   #资料插入fmcm_t
   LET l_fmcm001 = g_fmck_d[l_ac].fmck002        #币别       =币别
   LET l_fmcm002 = g_fmcj_m.fmcj006              #日期       =单头的起始日期
   LET l_fmcm003 = g_fmck_d[l_ac].fmck003        #帐户       =帐户
   LET l_fmcm004 = g_fmck_d[l_ac].fmck004        #金额       =金额

   SELECT MAX(fmcmseq2) INTO l_fmcmseq2
     FROM fmcm_t
    WHERE fmcment = g_enterprise
      AND fmcmdocno = g_fmcj_m.fmcjdocno
   
   IF cl_null(l_fmcmseq2) THEN
      LET l_fmcmseq2 = 1
   ELSE
      LET l_fmcmseq2 = l_fmcmseq2 + 1
   END IF
   
   INSERT INTO fmcm_t
               (fmcment,
                fmcmdocno,
                fmcmseq,fmcmseq2
                ,fmcm001,fmcm002,fmcm003,fmcm004) 
         VALUES(g_enterprise,
                g_fmcj_m.fmcjdocno,g_fmck_d[l_ac].fmckseq,l_fmcmseq2
                ,l_fmcm001,l_fmcm002,l_fmcm003,l_fmcm004)
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "fmcm_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   END IF
   

END FUNCTION

################################################################################
# Descriptions...: 担保方式变更，同步更新fmcp_t
# Memo...........:
# Usage..........: CALL afmt035_fmcp_upd()
# Date & Author..: 2015/11/18 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_fmcp_upd()

   CASE 
      WHEN g_fmcj_m.fmcj005 = '1' OR g_fmcj_m.fmcj005 = '2' OR g_fmcj_m.fmcj005 = '3' 
         UPDATE fmcp_t SET (fmcp015,fmcp003,fmcp004,fmcp005,fmcp006,fmcp007,fmcp008,fmcp009,fmcp010,fmcp011,fmcp012,fmcp013,fmcp014,fmcp016,fmcp017,fmcp018,fmcp019,fmcp020) 
                         = (g_fmcj_m.fmcj005,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
          WHERE fmcpent = g_enterprise AND fmcpdocno = g_fmcj_m.fmcjdocno
      WHEN g_fmcj_m.fmcj005 = '5'
         DELETE FROM fmcp_t
          WHERE fmcpent = g_enterprise AND fmcpdocno = g_fmcj_m.fmcjdocno
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 预计贷款划付 页签设置
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
PRIVATE FUNCTION afmt035_fmcm_entry()
   CALL cl_set_comp_entry('fmcmseq,fmcmseq2,fmcm001,fmcm002,fmcm003,fmcm004',TRUE)
   IF g_fmcj_m.fmcj008 = 'Y' THEN
      CALL cl_set_comp_entry('fmcmseq,fmcmseq2,fmcm001,fmcm002,fmcm003,fmcm004',TRUE)
   ELSE
      CALL cl_set_comp_entry('fmcmseq,fmcmseq2,fmcm001,fmcm002,fmcm003,fmcm004',FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 删除fmcm_t,fmcn_t
# Memo...........:
# Usage..........: CALL afmt035_del_fmcm()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_del_fmcm()
   
   DELETE FROM fmcm_t WHERE fmcment = g_enterprise 
    AND fmcmdocno = g_fmcj_m.fmcjdocno AND fmcmseq = g_fmck_d[l_ac].fmckseq
    
   
END FUNCTION

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
PRIVATE FUNCTION afmt035_ins_fmcn()
DEFINE l_fmcmseq2            LIKE fmcm_t.fmcmseq2
DEFINE l_fmcm001             LIKE fmcm_t.fmcm001
DEFINE l_fmcm002             LIKE fmcm_t.fmcm002
DEFINE l_fmcm003             LIKE fmcm_t.fmcm003
DEFINE l_fmcm004             LIKE fmcm_t.fmcm004
DEFINE l_fmcnseq2            LIKE fmcn_t.fmcnseq2
DEFINE l_fmcn001             LIKE fmcn_t.fmcn001
DEFINE l_fmcn002             LIKE fmcn_t.fmcn002
DEFINE l_fmcn003             LIKE fmcn_t.fmcn003
DEFINE l_fmcn004             LIKE fmcn_t.fmcn004
DEFINE l_fmcn005             LIKE fmcn_t.fmcn005
DEFINE l_fmcn006             LIKE fmcn_t.fmcn006
DEFINE l_fmcn007             LIKE fmcn_t.fmcn007
DEFINE l_year                LIKE type_t.num5
DEFINE l_month1              LIKE type_t.num5
DEFINE l_day1                LIKE type_t.num5
DEFINE l_success             LIKE type_t.num5
DEFINE l_ooef006             LIKE ooef_t.ooef006
DEFINE l_fmbj003             LIKE fmbj_t.fmbj003

   #资料插入fmcn_t
   IF g_fmck_d[l_ac].fmck005 = '2' THEN
      LET l_fmcn001 = g_fmck_d[l_ac].fmck002        #币别       =币别
      LET l_fmcn002 = g_fmcj_m.fmcj006            #日期       =贷款银划付项次的日期fmam003
      LET l_fmcn003 = g_fmck_d[l_ac].fmck005        #利率方式   =利率方式
      #基准利率=0 开放录入(根据单头融资组织取的aooi100中所属国家地区(ooef006) + 币别+利率确定日(最近日) +类别=【（单头截止日-单头起始日）算出范围】->afmi045取基本利率），若取不出资料，给0
      SELECT ooef006 INTO l_ooef006 FROM ooef_t
       WHERE ooefent = g_enterprise AND ooef001 = g_fmcj_m.fmcjsite
      
      LET l_month1 = MONTH(g_fmcj_m.fmcj007) -MONTH(g_fmcj_m.fmcj006)
      LET l_year = YEAR(g_fmcj_m.fmcj007) - YEAR(g_fmcj_m.fmcj006)
      LET l_day1 = DAY(g_fmcj_m.fmcj007) - DAY(g_fmcj_m.fmcj006)
      #取类别
      CALL s_date_chk_lastday(g_fmcj_m.fmcj007) RETURNING l_success
      IF NOT l_success AND DAY(g_fmcj_m.fmcj006) = 1 THEN
         LET l_day1 = 0
         LET l_month1 = l_month1 + 1
      END IF
      IF l_year <> 0 THEN
         CASE 
            WHEN l_year >= 1 AND l_year < 3 
               IF l_year = 1 THEN
                  IF l_month1 <>0 OR l_day1 <> 0 THEN
                     LET l_fmbj003 = 3
                  ELSE
                     LET l_fmbj003 = 2
                  END IF
               ELSE
                  LET l_fmbj003 = 3
               END IF
            WHEN l_year >= 3 AND l_year < 5 
               IF l_year = 3 THEN
                  IF l_month1 <>0 OR l_day1 <> 0 THEN
                     LET l_fmbj003 = 4
                  ELSE
                     LET l_fmbj003 = 3
                  END IF
               ELSE
                  LET l_fmbj003 = 4
               END IF
            WHEN l_year >= 5 
               IF l_year = 5 THEN
                  IF l_month1 <>0 OR l_day1 <> 0 THEN
                     LET l_fmbj003 = 5
                  ELSE
                     LET l_fmbj003 = 4
                  END IF
               ELSE
                  LET l_fmbj003 = 5
               END IF
         END CASE
      ELSE
         IF l_month1 >= 6 THEN
            IF l_month1 = 6 AND l_day1 <> 0 THEN
               LET l_fmbj003 = 1
            ELSE
               LET l_fmbj003 = 2
            END IF
         ELSE
            LET l_fmbj003 = 1
         END IF
      END IF
      
      SELECT fmbj005 INTO l_fmcn004 FROM fmbj_t
       WHERE fmbjent = g_enterprise AND fmbj001 = l_ooef006
         AND fmbj002 = (SELECT MAX(fmbj002) FROM fmbj_t WHERE fmbjent = g_enterprise 
         AND fmbj002 <= g_today AND fmbj001 = l_ooef006
         AND fmbj003 = l_fmbj003)
         AND fmbj003 = l_fmbj003
         
      IF cl_null(l_fmcn004) THEN LET l_fmcn004 = 0 END IF
      
      LET l_fmcn005 = g_fmck_d[l_ac].fmck006        #浮动方式=该项次的fmak006
      LET l_fmcn006 = g_fmck_d[l_ac].fmck007        #浮动利率=该项次的fmak007
      #浮动方式=1(按比例),执行利率=基准利率*（1+浮动利率/100）
      IF l_fmcn005 = '1' THEN
         LET l_fmcn007 = l_fmcn004 *(1+l_fmcn006/100)      
      ELSE  #浮动方式=2(按固定值),执行利率=基准利率+浮动利率/100）
         LET l_fmcn007 = l_fmcn004 + l_fmcn006/100
      END IF
      
   ELSE
      LET l_fmcn001 = g_fmck_d[l_ac].fmck002        #币别       =币别
      LET l_fmcn002 = g_fmcj_m.fmcjdocdt            #日期       =单头的合同签订日
      LET l_fmcn003 = g_fmck_d[l_ac].fmck005        #利率方式   =利率方式
      LET l_fmcn004 = g_fmck_d[l_ac].fmck007        #基准利率=该项次的fmak007
      LET l_fmcn005 = ''
      LET l_fmcn006 = 0
      LET l_fmcn007 = g_fmck_d[l_ac].fmck007        #执行利率=基准利率，该项次的fmak007
   END IF
   
   SELECT MAX(fmcnseq2) INTO l_fmcnseq2
     FROM fmcn_t
    WHERE fmcnent = g_enterprise
      AND fmcndocno = g_fmcj_m.fmcjdocno
   
   IF cl_null(l_fmcnseq2) THEN
      LET l_fmcnseq2 = 1
   ELSE
      LET l_fmcnseq2 = l_fmcnseq2 + 1
   END IF
   
   INSERT INTO fmcn_t
               (fmcnent,
                fmcndocno,
                fmcnseq,fmcnseq2
                ,fmcn001,fmcn002,fmcn003,fmcn004,fmcn005,fmcn006,fmcn007) 
         VALUES(g_enterprise,
                g_fmcj_m.fmcjdocno,g_fmck_d[l_ac].fmckseq,l_fmcnseq2
                ,l_fmcn001,l_fmcn002,l_fmcn003, 
                 l_fmcn004,l_fmcn005,l_fmcn006,l_fmcn007)
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "fmcn_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 获取fmckseq第一笔资料
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
PRIVATE FUNCTION afmt035_fmckseq_ref()
DEFINE l_sql          STRING
DEFINE r_fmckseq      LIKE fmck_t.fmckseq

   LET l_sql = " SELECT fmckseq FROM fmck_t ",
               "  WHERE fmckent = ",g_enterprise," AND fmckdocno = '",g_fmcj_m.fmcjdocno,"'",
               "  ORDER BY fmckseq"
               
   PREPARE fmckseq_prep FROM l_sql
   DECLARE fmckseq_curs SCROLL CURSOR WITH HOLD FOR fmckseq_prep
   OPEN fmckseq_curs
   FETCH FIRST fmckseq_curs INTO r_fmckseq
   CLOSE fmckseq_curs
   
   RETURN r_fmckseq
END FUNCTION

################################################################################
# Descriptions...: 获取显示给用户看到的交易账户型态
# Memo...........: 160829-00036#1  
# Usage..........: CALL aapt450_get_lc_apde008(p_apde008)
#                  RETURNING lc_apde008
# Input parameter: p_fmck003      交易账户编号
# Return code....: lc_fmck003     返回现在在画面中的交易账户编号
# Date & Author..: 16/09/01  By 07900
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_get_lc_fmck003(p_fmck003)
   DEFINE p_fmck003        LIKE fmck_t.fmck003
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_cnt2           LIKE type_t.num5
   DEFINE lc_fmck003       LIKE fmck_t.fmck003  
   
   #判断当前用户是否有权限查看该交易账户，如果没有权限不可看到交易账户编号，用“*”显示
   LET lc_fmck003 = p_fmck003
   IF NOT cl_null(p_fmck003) THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM nmll_t 
       WHERE nmllent = g_enterprise AND nmll002 = g_user AND  nmllstus='Y'
         AND nmll001 = p_fmck003
      SELECT COUNT(*) INTO l_cnt2 FROM nmlm_t 
       WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus='Y'
         AND nmlm001 = p_fmck003
      IF l_cnt = 0 AND l_cnt2 = 0 THEN
         LET lc_fmck003 = "********"
      END IF
   END IF
   RETURN lc_fmck003
END FUNCTION

 
{</section>}
 
