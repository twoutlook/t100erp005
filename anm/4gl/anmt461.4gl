#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt461.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2015-05-21 14:54:35), PR版次:0013(2017-01-13 09:07:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: anmt461
#+ Description: 應付匯款開立作業(流通)
#+ Creator....: 01727(2015-05-18 10:48:42)
#+ Modifier...: 01727 -SD/PR- 08729
 
{</section>}
 
{<section id="anmt461.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150818-00032#3  2015/08/23 By RayHuang nmbc_t新增兩個欄位
#151012-00014#6  2015/10/26 By RayHuang nmbc_t新增三個欄位(nmbc014~nmbc016)
#151013-00016#6  2015/10/29 By RayHuang glbc_t新增狀態碼
#151125-00006#3  2015/12/03 By 07166    新增[編輯完單據後立即審核]功能
#150916-00015#1  2015/11/30 By taozf    当有账套时，科目检查改为检查是否存在于glad_t中
#151130-00015#2  2015/12/21 BY Xiaozg   根据是否可以更改單據日期 設定開放單據日期修改
#150813-00015#8  2016/01/19 By 02599    增加日期控管，日期不可小于等于关账日期
#160122-00001#29 2016/02/19 By 02599    增加交易账户用户权限控管
#160122-00001#29 2016/03/17 By 07900    增加交易账户用户权限控管,增加部门权限
#160321-00016#40 2016/03/30 By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#13 2016/04/15 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息
#160322-00025#26 2016/04/22 By 01531    nmbcorga赋值
#160726-00020#13 2016/08/22 By 08729    複製時特定欄位清空
#160930-00013#1  2016/10/13 By 01531    ANM增加资金中心，帐套，法人,来源组织栏位权限
#161021-00050#9  2016/10/27 By Reanna   资金中心开窗需调整为q_ooef001_33 新增时where条件限定ooefstus= 'Y'查询时不限定此条件；
#                                       法人开窗调整为q_ooef001_2,要注意原本where条件中的权限设置要保留;
#                                       来源组织见excel"资金单身来源组织";
#                                       自动产生单身子作业账务中心开窗调整为q_ooef001_46 where条件限定ooefstus= 'Y'
#160822-00012#5  2016/11/03 By 08732    新舊值調整
#161128-00061#2  2016/11/30 by 02481    标准程式定义采用宣告模式,弃用.*写法
#161104-00046#13 2017/01/12 By 08729    單別預設值;資料依照單別user dept權限過濾單號
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
PRIVATE type type_g_nmck_m        RECORD
       nmcksite LIKE nmck_t.nmcksite, 
   nmcksite_desc LIKE type_t.chr80, 
   nmckcomp LIKE nmck_t.nmckcomp, 
   nmckcomp_desc LIKE type_t.chr80, 
   nmck003 LIKE nmck_t.nmck003, 
   nmck003_desc LIKE type_t.chr80, 
   nmckdocno LIKE nmck_t.nmckdocno, 
   nmck002 LIKE nmck_t.nmck002, 
   nmckdocdt LIKE nmck_t.nmckdocdt, 
   nmck004 LIKE nmck_t.nmck004, 
   nmck004_desc LIKE type_t.chr80, 
   nmas003 LIKE nmas_t.nmas003, 
   nmck019 LIKE nmck_t.nmck019, 
   nmckstus LIKE nmck_t.nmckstus, 
   nmck017 LIKE nmck_t.nmck017, 
   nmck018 LIKE nmck_t.nmck018, 
   nmck121 LIKE nmck_t.nmck121, 
   nmck005 LIKE nmck_t.nmck005, 
   nmck037 LIKE type_t.chr1, 
   nmck040 LIKE type_t.chr500, 
   nmck040_desc LIKE type_t.chr80, 
   nmck123 LIKE nmck_t.nmck123, 
   nmck013 LIKE nmck_t.nmck013, 
   nmck038 LIKE type_t.chr1, 
   nmck041 LIKE type_t.chr500, 
   nmck041_desc LIKE type_t.chr80, 
   nmck131 LIKE nmck_t.nmck131, 
   nmck014 LIKE nmck_t.nmck014, 
   nmck039 LIKE type_t.chr1, 
   nmck133 LIKE nmck_t.nmck133, 
   nmck015 LIKE nmck_t.nmck015, 
   nmck042 LIKE type_t.chr500, 
   nmck010 LIKE nmck_t.nmck010, 
   nmck010_desc LIKE type_t.chr80, 
   nmck016 LIKE nmck_t.nmck016, 
   nmck114 LIKE nmck_t.nmck114, 
   nmck006 LIKE nmck_t.nmck006, 
   nmck011 LIKE nmck_t.nmck011, 
   nmck124 LIKE nmck_t.nmck124, 
   nmck023 LIKE nmck_t.nmck023, 
   nmck134 LIKE nmck_t.nmck134, 
   nmck043 LIKE nmck_t.nmck043, 
   nmckownid LIKE nmck_t.nmckownid, 
   nmckownid_desc LIKE type_t.chr80, 
   nmckowndp LIKE nmck_t.nmckowndp, 
   nmckowndp_desc LIKE type_t.chr80, 
   nmckcrtid LIKE nmck_t.nmckcrtid, 
   nmckcrtid_desc LIKE type_t.chr80, 
   nmckcrtdp LIKE nmck_t.nmckcrtdp, 
   nmckcrtdp_desc LIKE type_t.chr80, 
   nmckcrtdt LIKE nmck_t.nmckcrtdt, 
   nmckmodid LIKE nmck_t.nmckmodid, 
   nmckmodid_desc LIKE type_t.chr80, 
   nmckmoddt LIKE nmck_t.nmckmoddt, 
   nmckcnfid LIKE nmck_t.nmckcnfid, 
   nmckcnfid_desc LIKE type_t.chr80, 
   nmckcnfdt LIKE nmck_t.nmckcnfdt, 
   nmck001 LIKE nmck_t.nmck001, 
   nmck100 LIKE nmck_t.nmck100, 
   nmck026 LIKE nmck_t.nmck026, 
   nmck008 LIKE nmck_t.nmck008, 
   nmck103 LIKE nmck_t.nmck103, 
   nmck012 LIKE nmck_t.nmck012, 
   nmck009 LIKE nmck_t.nmck009, 
   nmck009_desc LIKE type_t.chr80, 
   nmck101 LIKE nmck_t.nmck101, 
   nmck113 LIKE nmck_t.nmck113
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_nmed_d        RECORD
       nmedseq LIKE nmed_t.nmedseq, 
   nmed001 LIKE nmed_t.nmed001, 
   nmedorga LIKE nmed_t.nmedorga, 
   nmed003 LIKE nmed_t.nmed003, 
   nmed004 LIKE nmed_t.nmed004, 
   nmed005 LIKE nmed_t.nmed005, 
   nmed006 LIKE nmed_t.nmed006, 
   nmed006_desc LIKE type_t.chr500, 
   nmed011 LIKE nmed_t.nmed011, 
   nmed011_desc LIKE type_t.chr500, 
   nmed012 LIKE nmed_t.nmed012, 
   nmed013 LIKE nmed_t.nmed013, 
   nmed002 LIKE nmed_t.nmed002, 
   nmed007 LIKE nmed_t.nmed007, 
   nmed008 LIKE nmed_t.nmed008, 
   nmed009 LIKE nmed_t.nmed009, 
   nmed010 LIKE nmed_t.nmed010, 
   nmed100 LIKE nmed_t.nmed100, 
   nmed101 LIKE nmed_t.nmed101, 
   nmed110 LIKE nmed_t.nmed110, 
   nmed111 LIKE nmed_t.nmed111
       END RECORD
PRIVATE TYPE type_g_nmed2_d RECORD
       nmcmseq LIKE nmcm_t.nmcmseq, 
   nmcm001 LIKE nmcm_t.nmcm001, 
   nmcm001_desc LIKE type_t.chr200, 
   nmcm002 LIKE nmcm_t.nmcm002, 
   nmcm003 LIKE nmcm_t.nmcm003, 
   nmcm004 LIKE nmcm_t.nmcm004, 
   nmcm004_desc LIKE type_t.chr200, 
   nmcm005 LIKE nmcm_t.nmcm005, 
   nmcm005_desc LIKE type_t.chr200
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_nmckcomp LIKE nmck_t.nmckcomp,
      b_nmckdocno LIKE nmck_t.nmckdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_sel        RECORD
       apdasite       LIKE apda_t.apdasite, 
       apdasite_desc  LIKE ooefl_t.ooefl003, 
       radio          LIKE type_t.chr1,
       ls_wc          STRING,
       ls_wc2         STRING
                      END RECORD
DEFINE g_sql_bank     STRING      #160122-00001#29  By 07900 --add
DEFINE g_site_wc             STRING   #160930-00013#1 add              
DEFINE g_comp_wc             STRING   #160930-00013#1 add
DEFINE g_user_dept_wc        STRING   #161104-00046#13
DEFINE g_user_dept_wc_q      STRING   #161104-00046#13
DEFINE g_user_slip_wc        STRING   #161104-00046#13
#end add-point
       
#模組變數(Module Variables)
DEFINE g_nmck_m          type_g_nmck_m
DEFINE g_nmck_m_t        type_g_nmck_m
DEFINE g_nmck_m_o        type_g_nmck_m
DEFINE g_nmck_m_mask_o   type_g_nmck_m #轉換遮罩前資料
DEFINE g_nmck_m_mask_n   type_g_nmck_m #轉換遮罩後資料
 
   DEFINE g_nmckcomp_t LIKE nmck_t.nmckcomp
DEFINE g_nmckdocno_t LIKE nmck_t.nmckdocno
 
 
DEFINE g_nmed_d          DYNAMIC ARRAY OF type_g_nmed_d
DEFINE g_nmed_d_t        type_g_nmed_d
DEFINE g_nmed_d_o        type_g_nmed_d
DEFINE g_nmed_d_mask_o   DYNAMIC ARRAY OF type_g_nmed_d #轉換遮罩前資料
DEFINE g_nmed_d_mask_n   DYNAMIC ARRAY OF type_g_nmed_d #轉換遮罩後資料
DEFINE g_nmed2_d          DYNAMIC ARRAY OF type_g_nmed2_d
DEFINE g_nmed2_d_t        type_g_nmed2_d
DEFINE g_nmed2_d_o        type_g_nmed2_d
DEFINE g_nmed2_d_mask_o   DYNAMIC ARRAY OF type_g_nmed2_d #轉換遮罩前資料
DEFINE g_nmed2_d_mask_n   DYNAMIC ARRAY OF type_g_nmed2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
 
 
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
DEFINE g_glaald              LIKE glaa_t.glaald            #151125-00006#3
#end add-point
 
{</section>}
 
{<section id="anmt461.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:作業初始化 name="main.init"
   #161104-00046#13-----s
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_nmck_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('nmckcomp','','nmckent','nmckdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#13-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
 
   #end add-point
   LET g_forupd_sql = " SELECT nmcksite,'',nmckcomp,'',nmck003,'',nmckdocno,nmck002,nmckdocdt,nmck004, 
       '','',nmck019,nmckstus,nmck017,nmck018,nmck121,nmck005,'','','',nmck123,nmck013,'','','',nmck131, 
       nmck014,'',nmck133,nmck015,'',nmck010,'',nmck016,nmck114,nmck006,nmck011,nmck124,nmck023,nmck134, 
       nmck043,nmckownid,'',nmckowndp,'',nmckcrtid,'',nmckcrtdp,'',nmckcrtdt,nmckmodid,'',nmckmoddt, 
       nmckcnfid,'',nmckcnfdt,nmck001,nmck100,nmck026,nmck008,nmck103,nmck012,nmck009,'',nmck101,nmck113", 
        
                      " FROM nmck_t",
                      " WHERE nmckent= ? AND nmckcomp=? AND nmckdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt461_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmcksite,t0.nmckcomp,t0.nmck003,t0.nmckdocno,t0.nmck002,t0.nmckdocdt, 
       t0.nmck004,t0.nmck019,t0.nmckstus,t0.nmck017,t0.nmck018,t0.nmck121,t0.nmck005,t0.nmck037,t0.nmck040, 
       t0.nmck123,t0.nmck013,t0.nmck038,t0.nmck041,t0.nmck131,t0.nmck014,t0.nmck039,t0.nmck133,t0.nmck015, 
       t0.nmck042,t0.nmck010,t0.nmck016,t0.nmck114,t0.nmck006,t0.nmck011,t0.nmck124,t0.nmck023,t0.nmck134, 
       t0.nmck043,t0.nmckownid,t0.nmckowndp,t0.nmckcrtid,t0.nmckcrtdp,t0.nmckcrtdt,t0.nmckmodid,t0.nmckmoddt, 
       t0.nmckcnfid,t0.nmckcnfdt,t0.nmck001,t0.nmck100,t0.nmck026,t0.nmck008,t0.nmck103,t0.nmck012,t0.nmck009, 
       t0.nmck101,t0.nmck113,t1.ooefl003 ,t2.ooefl003 ,t3.ooag011 ,t4.nmaal003 ,t5.ooag011 ,t6.ooefl003 , 
       t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooag011 ,t11.nmajl003",
               " FROM nmck_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.nmcksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.nmckcomp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.nmck003  ",
               " LEFT JOIN nmaal_t t4 ON t4.nmaalent="||g_enterprise||" AND t4.nmaal001=t0.nmck004 AND t4.nmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.nmckownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.nmckowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.nmckcrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.nmckcrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.nmckmodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.nmckcnfid  ",
               " LEFT JOIN nmajl_t t11 ON t11.nmajlent="||g_enterprise||" AND t11.nmajl001=t0.nmck009 AND t11.nmajl002='"||g_dlang||"' ",
 
               " WHERE t0.nmckent = " ||g_enterprise|| " AND t0.nmckcomp = ? AND t0.nmckdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
  
   #end add-point
   PREPARE anmt461_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmt461 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmt461_init()   
 
      #進入選單 Menu (="N")
      CALL anmt461_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmt461
      
   END IF 
   
   CLOSE anmt461_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmt461.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmt461_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sql      STRING
   DEFINE l_str      STRING
   DEFINE l_gzcb002  LIKE gzcb_t.gzcb002 
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('nmckstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('nmck026','8711') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL anmt461_set_combo_scc('nmck002')
   CALL cl_set_combo_scc('nmck001','8726')
   CALL anmt461_set_label_scc('')
   CALL cl_set_combo_scc('nmck008','8713')
  #CALL cl_set_combo_scc('nmck037','8735')  #本行他行
  #CALL cl_set_combo_scc('nmck038','8736')  #本城他城
  #CALL cl_set_combo_scc('nmck039','8737')  #對公對私
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8711' AND gzcb006 = 'anmt461'"
   PREPARE anmt461_nmck026_prep FROM l_sql
   DECLARE anmt461_nmck026_curs CURSOR FOR anmt461_nmck026_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH anmt461_nmck026_curs INTO l_gzcb002
      IF cl_null(l_str) THEN 
         LET l_str = l_gzcb002 
         CONTINUE FOREACH 
      END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('nmck026','8711',l_str)
   CALL s_fin_create_account_center_tmp()
   #160122-00001#29 By 07900--add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#29 By 07900--add--end
   #end add-point
   
   #初始化搜尋條件
   CALL anmt461_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="anmt461.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION anmt461_ui_dialog()
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
   DEFINE l_year    LIKE type_t.num5
   DEFINE l_month   LIKE type_t.num5
   DEFINE l_glaald  LIKE glaa_t.glaald
   DEFINE l_cn      LIKE type_t.num10          #151125-00006#3
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
            CALL anmt461_insert()
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
         INITIALIZE g_nmck_m.* TO NULL
         CALL g_nmed_d.clear()
         CALL g_nmed2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL anmt461_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_nmed_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt461_idx_chk()
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
               CALL anmt461_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_nmed2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt461_idx_chk()
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
               CALL anmt461_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL anmt461_browser_fill("")
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
               CALL anmt461_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL anmt461_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL anmt461_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
 
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL anmt461_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL anmt461_set_act_visible()   
            CALL anmt461_set_act_no_visible()
            IF NOT (g_nmck_m.nmckcomp IS NULL
              OR g_nmck_m.nmckdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " nmckent = " ||g_enterprise|| " AND",
                                  " nmckcomp = '", g_nmck_m.nmckcomp, "' "
                                  ," AND nmckdocno = '", g_nmck_m.nmckdocno, "' "
 
               #填到對應位置
               CALL anmt461_browser_fill("")
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
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "nmck_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmed_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmcm_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL anmt461_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "nmck_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmed_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmcm_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL anmt461_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL anmt461_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL anmt461_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt461_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL anmt461_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt461_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL anmt461_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt461_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL anmt461_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt461_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL anmt461_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt461_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_nmed_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_nmed2_d)
                  LET g_export_id[2]   = "s_detail2"
 
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
               CALL anmt461_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#3--s
               #CALL anmt461_immediately_conf()
               SELECT COUNT(*) INTO l_cn FROM nmck_t
                WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno
                IF l_cn > 0 THEN CALL anmt461_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL anmt461_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#3--s
               #CALL anmt461_immediately_conf()
               SELECT COUNT(*) INTO l_cn FROM nmck_t
                WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno
                IF l_cn > 0 THEN CALL anmt461_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_s01
            LET g_action_choice="open_s01"
            IF cl_auth_chk_act("open_s01") THEN
               
               #add-point:ON ACTION open_s01 name="menu.open_s01"
               CALL anmt461_open_s01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmt461_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmt461_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#3--s
               #CALL anmt461_immediately_conf()
               SELECT COUNT(*) INTO l_cn FROM nmck_t
                WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno
                IF l_cn > 0 THEN CALL anmt461_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/anm/anmt461_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/anm/anmt461_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmt461_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION pay_date
            LET g_action_choice="pay_date"
            IF cl_auth_chk_act("pay_date") THEN
               
               #add-point:ON ACTION pay_date name="menu.pay_date"
                CALL anmt461_pay_date()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_cashflow
            LET g_action_choice="s_cashflow"
            IF cl_auth_chk_act("s_cashflow") THEN
               
               #add-point:ON ACTION s_cashflow name="menu.s_cashflow"
               IF NOT cl_null(g_nmck_m.nmckdocno) THEN
                  LET l_year = YEAR(g_nmck_m.nmckdocdt)
                  LET l_month = MONTH(g_nmck_m.nmckdocdt)
                  CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
                                #帳別            #匯款編號   #年度   #期別  #借貸別 #作業編號  #單身項次
                  CALL s_cashflow_nm(l_glaald,g_nmck_m.nmckdocno,l_year,l_month,'2',g_prog,'')
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_nmck003
            LET g_action_choice="prog_nmck003"
            IF cl_auth_chk_act("prog_nmck003") THEN
               
               #add-point:ON ACTION prog_nmck003 name="menu.prog_nmck003"
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_nmck_m.nmck003)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmt461_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt461_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt461_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_nmck_m.nmckdocdt)
 
 
 
         
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
 
{<section id="anmt461.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION anmt461_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_comp_str        STRING #160930-00013#1
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
   LET l_wc= l_wc," AND nmck001 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8726')"
   #160122-00001#29--add--str--
   LET l_wc=l_wc," AND nmck004 IN (",g_sql_bank,")"  #160122-00001#29 By 07900 --mod
   #160122-00001#29--add--end
   
   #160930-00013#1 add s---
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef017","nmckcomp")
   LET l_wc = l_wc," AND ",l_comp_str  
   #160930-00013#1 add e---      
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT nmckcomp,nmckdocno ",
                      " FROM nmck_t ",
                      " ",
                      " LEFT JOIN nmed_t ON nmedent = nmckent AND nmckcomp = nmedcomp AND nmckdocno = nmeddocno ", "  ",
                      #add-point:browser_fill段sql(nmed_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN nmcm_t ON nmcment = nmckent AND nmckcomp = nmcmcomp AND nmckdocno = nmcmdocno", "  ",
                      #add-point:browser_fill段sql(nmcm_t1) name="browser_fill.cnt.join.nmcm_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE nmckent = " ||g_enterprise|| " AND nmedent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmck_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT nmckcomp,nmckdocno ",
                      " FROM nmck_t ", 
                      "  ",
                      "  ",
                      " WHERE nmckent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("nmck_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE nmckcomp ",
                                    ",nmckdocno ",
                        " FROM nmck_t ",
                              " ",
                              " LEFT JOIN nmed_t ON nmedent = nmckent AND nmckcomp = nmedcomp AND nmckdocno = nmeddocno ",
                              " LEFT JOIN nmcm_t ON nmcment = nmckent AND nmckcomp = nmcmcomp AND nmckdocno = nmcmdocno",  
                       " WHERE nmckent = '" ||g_enterprise|| "' AND nmedent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmck_t")
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE nmckcomp ",
                                    ",nmckdocno ",
                        " FROM nmck_t ", 
                        "WHERE nmckent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("nmck_t")
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
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
      INITIALIZE g_nmck_m.* TO NULL
      CALL g_nmed_d.clear()        
      CALL g_nmed2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.nmckcomp,t0.nmckdocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmckstus,t0.nmckcomp,t0.nmckdocno ",
                  " FROM nmck_t t0",
                  "  ",
                  "  LEFT JOIN nmed_t ON nmedent = nmckent AND nmckcomp = nmedcomp AND nmckdocno = nmeddocno ", "  ", 
                  #add-point:browser_fill段sql(nmed_t1) name="browser_fill.join.nmed_t1"
                  
                  #end add-point
                  "  LEFT JOIN nmcm_t ON nmcment = nmckent AND nmckcomp = nmcmcomp AND nmckdocno = nmcmdocno", "  ", 
                  #add-point:browser_fill段sql(nmcm_t1) name="browser_fill.join.nmcm_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.nmckent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("nmck_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmckstus,t0.nmckcomp,t0.nmckdocno ",
                  " FROM nmck_t t0",
                  "  ",
                  
                  " WHERE t0.nmckent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("nmck_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY nmckcomp,nmckdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   IF NOT cl_null(g_add_browse) THEN
      LET l_wc = l_wc," AND ",g_add_browse
   END IF
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照nmckcomp,nmckdocno Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT nmckstus,nmckcomp,nmckdocno,DENSE_RANK() OVER(ORDER BY nmckcomp, 
          nmckdocno ",g_order,") AS RANK ",
                        " FROM nmck_t ",
                              " LEFT JOIN nmed_t ON nmedent = nmckent AND nmckcomp = nmedcomp AND nmckdocno = nmeddocno ",
                              " LEFT JOIN nmcm_t ON nmcment = nmckent AND nmckcomp = nmcmcomp AND nmckdocno = nmcmdocno",
                       " WHERE nmckent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("nmck_t")
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT nmckstus,nmckcomp,nmckdocno,DENSE_RANK() OVER(ORDER BY nmckcomp, 
          nmckdocno ",g_order,") AS RANK ",
                       " FROM nmck_t ",
                       " WHERE nmckent = '" ||g_enterprise|| "' AND ", l_wc, cl_sql_add_filter("nmck_t")
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT nmckstus,nmckcomp,nmckdocno FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse 
 #            " ORDER BY ",l_searchcol," ",g_order
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmck_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
 
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_nmckcomp,g_browser[g_cnt].b_nmckdocno 
 
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
   
   IF cl_null(g_browser[g_cnt].b_nmckcomp) THEN
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
 
{<section id="anmt461.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION anmt461_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_nmck_m.nmckcomp = g_browser[g_current_idx].b_nmckcomp   
   LET g_nmck_m.nmckdocno = g_browser[g_current_idx].b_nmckdocno   
 
   EXECUTE anmt461_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017,g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005, 
       g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041, 
       g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042, 
       g_nmck_m.nmck010,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124, 
       g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid, 
       g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid, 
       g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103, 
       g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc 
 
   
   CALL anmt461_nmck_t_mask()
   CALL anmt461_show()
      
END FUNCTION
 
{</section>}
 
{<section id="anmt461.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION anmt461_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION anmt461_ui_browser_refresh()
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
      IF g_browser[l_i].b_nmckcomp = g_nmck_m.nmckcomp 
         AND g_browser[l_i].b_nmckdocno = g_nmck_m.nmckdocno 
 
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
 
{<section id="anmt461.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt461_construct()
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
   DEFINE l_wc        STRING #160930-00013#1
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_nmck_m.* TO NULL
   CALL g_nmed_d.clear()        
   CALL g_nmed2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON nmcksite,nmckcomp,nmck003,nmckdocno,nmck002,nmckdocdt,nmck004,nmck019, 
          nmckstus,nmck017,nmck018,nmck121,nmck005,nmck037,nmck040,nmck040_desc,nmck123,nmck013,nmck038, 
          nmck041,nmck041_desc,nmck131,nmck014,nmck039,nmck133,nmck015,nmck042,nmck010,nmck010_desc, 
          nmck016,nmck114,nmck006,nmck011,nmck124,nmck023,nmck134,nmck043,nmckownid,nmckowndp,nmckcrtid, 
          nmckcrtdp,nmckcrtdt,nmckmodid,nmckmoddt,nmckcnfid,nmckcnfdt,nmck001,nmck100,nmck026,nmck008, 
          nmck103,nmck012,nmck009,nmck101,nmck113
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmckcrtdt>>----
         AFTER FIELD nmckcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmckmoddt>>----
         AFTER FIELD nmckmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmckcnfdt>>----
         AFTER FIELD nmckcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmckpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.nmcksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcksite
            #add-point:ON ACTION controlp INFIELD nmcksite name="construct.c.nmcksite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef206 = 'Y'"
            #CALL q_ooef001()    #161021-00050#9 mark
            CALL q_ooef001_33()  #161021-00050#9
            DISPLAY g_qryparam.return1 TO nmcksite
            NEXT FIELD nmcksite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcksite
            #add-point:BEFORE FIELD nmcksite name="construct.b.nmcksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcksite
            
            #add-point:AFTER FIELD nmcksite name="construct.a.nmcksite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcomp
            #add-point:ON ACTION controlp INFIELD nmckcomp name="construct.c.nmckcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' "
            #160930-00013#1 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED
            #160930-00013#1 Add  ---(E)--- 
            #CALL q_ooef001()  #161021-00050#9 mark
            CALL q_ooef001_2() #161021-00050#9
            DISPLAY g_qryparam.return1 TO nmckcomp
            NEXT FIELD nmckcomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcomp
            #add-point:BEFORE FIELD nmckcomp name="construct.b.nmckcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckcomp
            
            #add-point:AFTER FIELD nmckcomp name="construct.a.nmckcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck003
            #add-point:ON ACTION controlp INFIELD nmck003 name="construct.c.nmck003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck003  #顯示到畫面上
            NEXT FIELD nmck003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck003
            #add-point:BEFORE FIELD nmck003 name="construct.b.nmck003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck003
            
            #add-point:AFTER FIELD nmck003 name="construct.a.nmck003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckdocno
            #add-point:ON ACTION controlp INFIELD nmckdocno name="construct.c.nmckdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmck001 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8726')"
            #161104-00046#13-----s
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#13-----e
            CALL q_nmckdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckdocno  #顯示到畫面上
            NEXT FIELD nmckdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckdocno
            #add-point:BEFORE FIELD nmckdocno name="construct.b.nmckdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckdocno
            
            #add-point:AFTER FIELD nmckdocno name="construct.a.nmckdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck002
            #add-point:BEFORE FIELD nmck002 name="construct.b.nmck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck002
            
            #add-point:AFTER FIELD nmck002 name="construct.a.nmck002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck002
            #add-point:ON ACTION controlp INFIELD nmck002 name="construct.c.nmck002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckdocdt
            #add-point:BEFORE FIELD nmckdocdt name="construct.b.nmckdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckdocdt
            
            #add-point:AFTER FIELD nmckdocdt name="construct.a.nmckdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckdocdt
            #add-point:ON ACTION controlp INFIELD nmckdocdt name="construct.c.nmckdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck004
            #add-point:ON ACTION controlp INFIELD nmck004 name="construct.c.nmck004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#29--add---str--
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"  #160122-00001#29 By 07900 --mod
            #160122-00001#29--add---end
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck004  #顯示到畫面上
            NEXT FIELD nmck004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck004
            #add-point:BEFORE FIELD nmck004 name="construct.b.nmck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck004
            
            #add-point:AFTER FIELD nmck004 name="construct.a.nmck004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck019
            #add-point:ON ACTION controlp INFIELD nmck019 name="construct.c.nmck019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmck019()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck019  #顯示到畫面上
            NEXT FIELD nmck019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck019
            #add-point:BEFORE FIELD nmck019 name="construct.b.nmck019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck019
            
            #add-point:AFTER FIELD nmck019 name="construct.a.nmck019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckstus
            #add-point:BEFORE FIELD nmckstus name="construct.b.nmckstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckstus
            
            #add-point:AFTER FIELD nmckstus name="construct.a.nmckstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckstus
            #add-point:ON ACTION controlp INFIELD nmckstus name="construct.c.nmckstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck017
            #add-point:BEFORE FIELD nmck017 name="construct.b.nmck017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck017
            
            #add-point:AFTER FIELD nmck017 name="construct.a.nmck017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck017
            #add-point:ON ACTION controlp INFIELD nmck017 name="construct.c.nmck017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck018
            #add-point:BEFORE FIELD nmck018 name="construct.b.nmck018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck018
            
            #add-point:AFTER FIELD nmck018 name="construct.a.nmck018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck018
            #add-point:ON ACTION controlp INFIELD nmck018 name="construct.c.nmck018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck121
            #add-point:BEFORE FIELD nmck121 name="construct.b.nmck121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck121
            
            #add-point:AFTER FIELD nmck121 name="construct.a.nmck121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck121
            #add-point:ON ACTION controlp INFIELD nmck121 name="construct.c.nmck121"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck005
            #add-point:ON ACTION controlp INFIELD nmck005 name="construct.c.nmck005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck005  #顯示到畫面上
            NEXT FIELD nmck005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck005
            #add-point:BEFORE FIELD nmck005 name="construct.b.nmck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck005
            
            #add-point:AFTER FIELD nmck005 name="construct.a.nmck005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck037
            #add-point:BEFORE FIELD nmck037 name="construct.b.nmck037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck037
            
            #add-point:AFTER FIELD nmck037 name="construct.a.nmck037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck037
            #add-point:ON ACTION controlp INFIELD nmck037 name="construct.c.nmck037"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck040
            #add-point:ON ACTION controlp INFIELD nmck040 name="construct.c.nmck040"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooci002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck040  #顯示到畫面上
            NEXT FIELD nmck040                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck040
            #add-point:BEFORE FIELD nmck040 name="construct.b.nmck040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck040
            
            #add-point:AFTER FIELD nmck040 name="construct.a.nmck040"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck040_desc
            #add-point:BEFORE FIELD nmck040_desc name="construct.b.nmck040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck040_desc
            
            #add-point:AFTER FIELD nmck040_desc name="construct.a.nmck040_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck040_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck040_desc
            #add-point:ON ACTION controlp INFIELD nmck040_desc name="construct.c.nmck040_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck123
            #add-point:BEFORE FIELD nmck123 name="construct.b.nmck123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck123
            
            #add-point:AFTER FIELD nmck123 name="construct.a.nmck123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck123
            #add-point:ON ACTION controlp INFIELD nmck123 name="construct.c.nmck123"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck013
            #add-point:ON ACTION controlp INFIELD nmck013 name="construct.c.nmck013"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck013  #顯示到畫面上
            NEXT FIELD nmck013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck013
            #add-point:BEFORE FIELD nmck013 name="construct.b.nmck013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck013
            
            #add-point:AFTER FIELD nmck013 name="construct.a.nmck013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck038
            #add-point:BEFORE FIELD nmck038 name="construct.b.nmck038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck038
            
            #add-point:AFTER FIELD nmck038 name="construct.a.nmck038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck038
            #add-point:ON ACTION controlp INFIELD nmck038 name="construct.c.nmck038"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck041
            #add-point:ON ACTION controlp INFIELD nmck041 name="construct.c.nmck041"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oock004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck041  #顯示到畫面上
            NEXT FIELD nmck041                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck041
            #add-point:BEFORE FIELD nmck041 name="construct.b.nmck041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck041
            
            #add-point:AFTER FIELD nmck041 name="construct.a.nmck041"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck041_desc
            #add-point:BEFORE FIELD nmck041_desc name="construct.b.nmck041_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck041_desc
            
            #add-point:AFTER FIELD nmck041_desc name="construct.a.nmck041_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck041_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck041_desc
            #add-point:ON ACTION controlp INFIELD nmck041_desc name="construct.c.nmck041_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck131
            #add-point:BEFORE FIELD nmck131 name="construct.b.nmck131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck131
            
            #add-point:AFTER FIELD nmck131 name="construct.a.nmck131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck131
            #add-point:ON ACTION controlp INFIELD nmck131 name="construct.c.nmck131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck014
            #add-point:BEFORE FIELD nmck014 name="construct.b.nmck014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck014
            
            #add-point:AFTER FIELD nmck014 name="construct.a.nmck014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck014
            #add-point:ON ACTION controlp INFIELD nmck014 name="construct.c.nmck014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck039
            #add-point:BEFORE FIELD nmck039 name="construct.b.nmck039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck039
            
            #add-point:AFTER FIELD nmck039 name="construct.a.nmck039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck039
            #add-point:ON ACTION controlp INFIELD nmck039 name="construct.c.nmck039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck133
            #add-point:BEFORE FIELD nmck133 name="construct.b.nmck133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck133
            
            #add-point:AFTER FIELD nmck133 name="construct.a.nmck133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck133
            #add-point:ON ACTION controlp INFIELD nmck133 name="construct.c.nmck133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck015
            #add-point:BEFORE FIELD nmck015 name="construct.b.nmck015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck015
            
            #add-point:AFTER FIELD nmck015 name="construct.a.nmck015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck015
            #add-point:ON ACTION controlp INFIELD nmck015 name="construct.c.nmck015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck042
            #add-point:BEFORE FIELD nmck042 name="construct.b.nmck042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck042
            
            #add-point:AFTER FIELD nmck042 name="construct.a.nmck042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck042
            #add-point:ON ACTION controlp INFIELD nmck042 name="construct.c.nmck042"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck010
            #add-point:ON ACTION controlp INFIELD nmck010 name="construct.c.nmck010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck010  #顯示到畫面上
            NEXT FIELD nmck010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck010
            #add-point:BEFORE FIELD nmck010 name="construct.b.nmck010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck010
            
            #add-point:AFTER FIELD nmck010 name="construct.a.nmck010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck010_desc
            #add-point:BEFORE FIELD nmck010_desc name="construct.b.nmck010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck010_desc
            
            #add-point:AFTER FIELD nmck010_desc name="construct.a.nmck010_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck010_desc
            #add-point:ON ACTION controlp INFIELD nmck010_desc name="construct.c.nmck010_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck016
            #add-point:BEFORE FIELD nmck016 name="construct.b.nmck016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck016
            
            #add-point:AFTER FIELD nmck016 name="construct.a.nmck016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck016
            #add-point:ON ACTION controlp INFIELD nmck016 name="construct.c.nmck016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck114
            #add-point:BEFORE FIELD nmck114 name="construct.b.nmck114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck114
            
            #add-point:AFTER FIELD nmck114 name="construct.a.nmck114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck114
            #add-point:ON ACTION controlp INFIELD nmck114 name="construct.c.nmck114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck006
            #add-point:BEFORE FIELD nmck006 name="construct.b.nmck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck006
            
            #add-point:AFTER FIELD nmck006 name="construct.a.nmck006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck006
            #add-point:ON ACTION controlp INFIELD nmck006 name="construct.c.nmck006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck011
            #add-point:BEFORE FIELD nmck011 name="construct.b.nmck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck011
            
            #add-point:AFTER FIELD nmck011 name="construct.a.nmck011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck011
            #add-point:ON ACTION controlp INFIELD nmck011 name="construct.c.nmck011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck124
            #add-point:BEFORE FIELD nmck124 name="construct.b.nmck124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck124
            
            #add-point:AFTER FIELD nmck124 name="construct.a.nmck124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck124
            #add-point:ON ACTION controlp INFIELD nmck124 name="construct.c.nmck124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck023
            #add-point:BEFORE FIELD nmck023 name="construct.b.nmck023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck023
            
            #add-point:AFTER FIELD nmck023 name="construct.a.nmck023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck023
            #add-point:ON ACTION controlp INFIELD nmck023 name="construct.c.nmck023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck134
            #add-point:BEFORE FIELD nmck134 name="construct.b.nmck134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck134
            
            #add-point:AFTER FIELD nmck134 name="construct.a.nmck134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck134
            #add-point:ON ACTION controlp INFIELD nmck134 name="construct.c.nmck134"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck043
            #add-point:BEFORE FIELD nmck043 name="construct.b.nmck043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck043
            
            #add-point:AFTER FIELD nmck043 name="construct.a.nmck043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck043
            #add-point:ON ACTION controlp INFIELD nmck043 name="construct.c.nmck043"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmckownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckownid
            #add-point:ON ACTION controlp INFIELD nmckownid name="construct.c.nmckownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckownid  #顯示到畫面上
            NEXT FIELD nmckownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckownid
            #add-point:BEFORE FIELD nmckownid name="construct.b.nmckownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckownid
            
            #add-point:AFTER FIELD nmckownid name="construct.a.nmckownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckowndp
            #add-point:ON ACTION controlp INFIELD nmckowndp name="construct.c.nmckowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckowndp  #顯示到畫面上
            NEXT FIELD nmckowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckowndp
            #add-point:BEFORE FIELD nmckowndp name="construct.b.nmckowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckowndp
            
            #add-point:AFTER FIELD nmckowndp name="construct.a.nmckowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcrtid
            #add-point:ON ACTION controlp INFIELD nmckcrtid name="construct.c.nmckcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckcrtid  #顯示到畫面上
            NEXT FIELD nmckcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcrtid
            #add-point:BEFORE FIELD nmckcrtid name="construct.b.nmckcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckcrtid
            
            #add-point:AFTER FIELD nmckcrtid name="construct.a.nmckcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcrtdp
            #add-point:ON ACTION controlp INFIELD nmckcrtdp name="construct.c.nmckcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckcrtdp  #顯示到畫面上
            NEXT FIELD nmckcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcrtdp
            #add-point:BEFORE FIELD nmckcrtdp name="construct.b.nmckcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckcrtdp
            
            #add-point:AFTER FIELD nmckcrtdp name="construct.a.nmckcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcrtdt
            #add-point:BEFORE FIELD nmckcrtdt name="construct.b.nmckcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmckmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckmodid
            #add-point:ON ACTION controlp INFIELD nmckmodid name="construct.c.nmckmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckmodid  #顯示到畫面上
            NEXT FIELD nmckmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckmodid
            #add-point:BEFORE FIELD nmckmodid name="construct.b.nmckmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckmodid
            
            #add-point:AFTER FIELD nmckmodid name="construct.a.nmckmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckmoddt
            #add-point:BEFORE FIELD nmckmoddt name="construct.b.nmckmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmckcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcnfid
            #add-point:ON ACTION controlp INFIELD nmckcnfid name="construct.c.nmckcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckcnfid  #顯示到畫面上
            NEXT FIELD nmckcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcnfid
            #add-point:BEFORE FIELD nmckcnfid name="construct.b.nmckcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckcnfid
            
            #add-point:AFTER FIELD nmckcnfid name="construct.a.nmckcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcnfdt
            #add-point:BEFORE FIELD nmckcnfdt name="construct.b.nmckcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck001
            #add-point:BEFORE FIELD nmck001 name="construct.b.nmck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck001
            
            #add-point:AFTER FIELD nmck001 name="construct.a.nmck001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck001
            #add-point:ON ACTION controlp INFIELD nmck001 name="construct.c.nmck001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck100
            #add-point:ON ACTION controlp INFIELD nmck100 name="construct.c.nmck100"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck100  #顯示到畫面上
            NEXT FIELD nmck100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck100
            #add-point:BEFORE FIELD nmck100 name="construct.b.nmck100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck100
            
            #add-point:AFTER FIELD nmck100 name="construct.a.nmck100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck026
            #add-point:BEFORE FIELD nmck026 name="construct.b.nmck026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck026
            
            #add-point:AFTER FIELD nmck026 name="construct.a.nmck026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck026
            #add-point:ON ACTION controlp INFIELD nmck026 name="construct.c.nmck026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck008
            #add-point:BEFORE FIELD nmck008 name="construct.b.nmck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck008
            
            #add-point:AFTER FIELD nmck008 name="construct.a.nmck008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck008
            #add-point:ON ACTION controlp INFIELD nmck008 name="construct.c.nmck008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck103
            #add-point:BEFORE FIELD nmck103 name="construct.b.nmck103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck103
            
            #add-point:AFTER FIELD nmck103 name="construct.a.nmck103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck103
            #add-point:ON ACTION controlp INFIELD nmck103 name="construct.c.nmck103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck012
            #add-point:BEFORE FIELD nmck012 name="construct.b.nmck012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck012
            
            #add-point:AFTER FIELD nmck012 name="construct.a.nmck012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck012
            #add-point:ON ACTION controlp INFIELD nmck012 name="construct.c.nmck012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck009
            #add-point:ON ACTION controlp INFIELD nmck009 name="construct.c.nmck009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where  = " nmaj002 = '2'"
            CALL q_nmad002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck009  #顯示到畫面上
            NEXT FIELD nmck009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck009
            #add-point:BEFORE FIELD nmck009 name="construct.b.nmck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck009
            
            #add-point:AFTER FIELD nmck009 name="construct.a.nmck009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck101
            #add-point:BEFORE FIELD nmck101 name="construct.b.nmck101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck101
            
            #add-point:AFTER FIELD nmck101 name="construct.a.nmck101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck101
            #add-point:ON ACTION controlp INFIELD nmck101 name="construct.c.nmck101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck113
            #add-point:BEFORE FIELD nmck113 name="construct.b.nmck113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck113
            
            #add-point:AFTER FIELD nmck113 name="construct.a.nmck113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck113
            #add-point:ON ACTION controlp INFIELD nmck113 name="construct.c.nmck113"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON nmedseq,nmed001,nmedorga,nmed003,nmed004,nmed005,nmed006,nmed006_desc, 
          nmed011,nmed011_desc,nmed012,nmed013,nmed002,nmed007,nmed008,nmed009,nmed010,nmed100,nmed101, 
          nmed110,nmed111
           FROM s_detail1[1].nmedseq,s_detail1[1].nmed001,s_detail1[1].nmedorga,s_detail1[1].nmed003, 
               s_detail1[1].nmed004,s_detail1[1].nmed005,s_detail1[1].nmed006,s_detail1[1].nmed006_desc, 
               s_detail1[1].nmed011,s_detail1[1].nmed011_desc,s_detail1[1].nmed012,s_detail1[1].nmed013, 
               s_detail1[1].nmed002,s_detail1[1].nmed007,s_detail1[1].nmed008,s_detail1[1].nmed009,s_detail1[1].nmed010, 
               s_detail1[1].nmed100,s_detail1[1].nmed101,s_detail1[1].nmed110,s_detail1[1].nmed111
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmedseq
            #add-point:BEFORE FIELD nmedseq name="construct.b.page1.nmedseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmedseq
            
            #add-point:AFTER FIELD nmedseq name="construct.a.page1.nmedseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmedseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmedseq
            #add-point:ON ACTION controlp INFIELD nmedseq name="construct.c.page1.nmedseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed001
            #add-point:BEFORE FIELD nmed001 name="construct.b.page1.nmed001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed001
            
            #add-point:AFTER FIELD nmed001 name="construct.a.page1.nmed001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed001
            #add-point:ON ACTION controlp INFIELD nmed001 name="construct.c.page1.nmed001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmed001  #顯示到畫面上
            NEXT FIELD nmed001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmedorga
            #add-point:BEFORE FIELD nmedorga name="construct.b.page1.nmedorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmedorga
            
            #add-point:AFTER FIELD nmedorga name="construct.a.page1.nmedorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmedorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmedorga
            #add-point:ON ACTION controlp INFIELD nmedorga name="construct.c.page1.nmedorga"
            #來源組織
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y'"  #161021-00050#9
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO nmedorga
            NEXT FIELD nmedorga
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed003
            #add-point:BEFORE FIELD nmed003 name="construct.b.page1.nmed003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed003
            
            #add-point:AFTER FIELD nmed003 name="construct.a.page1.nmed003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed003
            #add-point:ON ACTION controlp INFIELD nmed003 name="construct.c.page1.nmed003"


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed004
            #add-point:BEFORE FIELD nmed004 name="construct.b.page1.nmed004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed004
            
            #add-point:AFTER FIELD nmed004 name="construct.a.page1.nmed004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed004
            #add-point:ON ACTION controlp INFIELD nmed004 name="construct.c.page1.nmed004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed005
            #add-point:BEFORE FIELD nmed005 name="construct.b.page1.nmed005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed005
            
            #add-point:AFTER FIELD nmed005 name="construct.a.page1.nmed005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed005
            #add-point:ON ACTION controlp INFIELD nmed005 name="construct.c.page1.nmed005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed006
            #add-point:BEFORE FIELD nmed006 name="construct.b.page1.nmed006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed006
            
            #add-point:AFTER FIELD nmed006 name="construct.a.page1.nmed006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed006
            #add-point:ON ACTION controlp INFIELD nmed006 name="construct.c.page1.nmed006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed006_desc
            #add-point:BEFORE FIELD nmed006_desc name="construct.b.page1.nmed006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed006_desc
            
            #add-point:AFTER FIELD nmed006_desc name="construct.a.page1.nmed006_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed006_desc
            #add-point:ON ACTION controlp INFIELD nmed006_desc name="construct.c.page1.nmed006_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed011
            #add-point:BEFORE FIELD nmed011 name="construct.b.page1.nmed011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed011
            
            #add-point:AFTER FIELD nmed011 name="construct.a.page1.nmed011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed011
            #add-point:ON ACTION controlp INFIELD nmed011 name="construct.c.page1.nmed011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed011_desc
            #add-point:BEFORE FIELD nmed011_desc name="construct.b.page1.nmed011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed011_desc
            
            #add-point:AFTER FIELD nmed011_desc name="construct.a.page1.nmed011_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed011_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed011_desc
            #add-point:ON ACTION controlp INFIELD nmed011_desc name="construct.c.page1.nmed011_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed012
            #add-point:BEFORE FIELD nmed012 name="construct.b.page1.nmed012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed012
            
            #add-point:AFTER FIELD nmed012 name="construct.a.page1.nmed012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed012
            #add-point:ON ACTION controlp INFIELD nmed012 name="construct.c.page1.nmed012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed013
            #add-point:BEFORE FIELD nmed013 name="construct.b.page1.nmed013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed013
            
            #add-point:AFTER FIELD nmed013 name="construct.a.page1.nmed013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed013
            #add-point:ON ACTION controlp INFIELD nmed013 name="construct.c.page1.nmed013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed002
            #add-point:BEFORE FIELD nmed002 name="construct.b.page1.nmed002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed002
            
            #add-point:AFTER FIELD nmed002 name="construct.a.page1.nmed002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed002
            #add-point:ON ACTION controlp INFIELD nmed002 name="construct.c.page1.nmed002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apceseq()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmed002  #顯示到畫面上
            NEXT FIELD nmed002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed007
            #add-point:BEFORE FIELD nmed007 name="construct.b.page1.nmed007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed007
            
            #add-point:AFTER FIELD nmed007 name="construct.a.page1.nmed007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed007
            #add-point:ON ACTION controlp INFIELD nmed007 name="construct.c.page1.nmed007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed008
            #add-point:BEFORE FIELD nmed008 name="construct.b.page1.nmed008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed008
            
            #add-point:AFTER FIELD nmed008 name="construct.a.page1.nmed008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed008
            #add-point:ON ACTION controlp INFIELD nmed008 name="construct.c.page1.nmed008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed009
            #add-point:BEFORE FIELD nmed009 name="construct.b.page1.nmed009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed009
            
            #add-point:AFTER FIELD nmed009 name="construct.a.page1.nmed009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed009
            #add-point:ON ACTION controlp INFIELD nmed009 name="construct.c.page1.nmed009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed010
            #add-point:BEFORE FIELD nmed010 name="construct.b.page1.nmed010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed010
            
            #add-point:AFTER FIELD nmed010 name="construct.a.page1.nmed010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed010
            #add-point:ON ACTION controlp INFIELD nmed010 name="construct.c.page1.nmed010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed100
            #add-point:BEFORE FIELD nmed100 name="construct.b.page1.nmed100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed100
            
            #add-point:AFTER FIELD nmed100 name="construct.a.page1.nmed100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed100
            #add-point:ON ACTION controlp INFIELD nmed100 name="construct.c.page1.nmed100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed101
            #add-point:BEFORE FIELD nmed101 name="construct.b.page1.nmed101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed101
            
            #add-point:AFTER FIELD nmed101 name="construct.a.page1.nmed101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed101
            #add-point:ON ACTION controlp INFIELD nmed101 name="construct.c.page1.nmed101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed110
            #add-point:BEFORE FIELD nmed110 name="construct.b.page1.nmed110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed110
            
            #add-point:AFTER FIELD nmed110 name="construct.a.page1.nmed110"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed110
            #add-point:ON ACTION controlp INFIELD nmed110 name="construct.c.page1.nmed110"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed111
            #add-point:BEFORE FIELD nmed111 name="construct.b.page1.nmed111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed111
            
            #add-point:AFTER FIELD nmed111 name="construct.a.page1.nmed111"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmed111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed111
            #add-point:ON ACTION controlp INFIELD nmed111 name="construct.c.page1.nmed111"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON nmcmseq,nmcm001,nmcm001_desc,nmcm002,nmcm003,nmcm004,nmcm004_desc,nmcm005, 
          nmcm005_desc
           FROM s_detail2[1].nmcmseq,s_detail2[1].nmcm001,s_detail2[1].nmcm001_desc,s_detail2[1].nmcm002, 
               s_detail2[1].nmcm003,s_detail2[1].nmcm004,s_detail2[1].nmcm004_desc,s_detail2[1].nmcm005, 
               s_detail2[1].nmcm005_desc
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcmseq
            #add-point:BEFORE FIELD nmcmseq name="construct.b.page2.nmcmseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcmseq
            
            #add-point:AFTER FIELD nmcmseq name="construct.a.page2.nmcmseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmcmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcmseq
            #add-point:ON ACTION controlp INFIELD nmcmseq name="construct.c.page2.nmcmseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmcm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm001
            #add-point:ON ACTION controlp INFIELD nmcm001 name="construct.c.page2.nmcm001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3113'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmcm001  #顯示到畫面上
            NEXT FIELD nmcm001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm001
            #add-point:BEFORE FIELD nmcm001 name="construct.b.page2.nmcm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm001
            
            #add-point:AFTER FIELD nmcm001 name="construct.a.page2.nmcm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmcm001_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm001_desc
            #add-point:ON ACTION controlp INFIELD nmcm001_desc name="construct.c.page2.nmcm001_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmcm001_desc  #顯示到畫面上
            NEXT FIELD nmcm001_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm001_desc
            #add-point:BEFORE FIELD nmcm001_desc name="construct.b.page2.nmcm001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm001_desc
            
            #add-point:AFTER FIELD nmcm001_desc name="construct.a.page2.nmcm001_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm002
            #add-point:BEFORE FIELD nmcm002 name="construct.b.page2.nmcm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm002
            
            #add-point:AFTER FIELD nmcm002 name="construct.a.page2.nmcm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmcm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm002
            #add-point:ON ACTION controlp INFIELD nmcm002 name="construct.c.page2.nmcm002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm003
            #add-point:BEFORE FIELD nmcm003 name="construct.b.page2.nmcm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm003
            
            #add-point:AFTER FIELD nmcm003 name="construct.a.page2.nmcm003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmcm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm003
            #add-point:ON ACTION controlp INFIELD nmcm003 name="construct.c.page2.nmcm003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmcm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm004
            #add-point:ON ACTION controlp INFIELD nmcm004 name="construct.c.page2.nmcm004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 != '1' "
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmcm004  #顯示到畫面上
            NEXT FIELD nmcm004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm004
            #add-point:BEFORE FIELD nmcm004 name="construct.b.page2.nmcm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm004
            
            #add-point:AFTER FIELD nmcm004 name="construct.a.page2.nmcm004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmcm004_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm004_desc
            #add-point:ON ACTION controlp INFIELD nmcm004_desc name="construct.c.page2.nmcm004_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmcm004_desc  #顯示到畫面上
            NEXT FIELD nmcm004_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm004_desc
            #add-point:BEFORE FIELD nmcm004_desc name="construct.b.page2.nmcm004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm004_desc
            
            #add-point:AFTER FIELD nmcm004_desc name="construct.a.page2.nmcm004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmcm005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm005
            #add-point:ON ACTION controlp INFIELD nmcm005 name="construct.c.page2.nmcm005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmcm005  #顯示到畫面上
            NEXT FIELD nmcm005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm005
            #add-point:BEFORE FIELD nmcm005 name="construct.b.page2.nmcm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm005
            
            #add-point:AFTER FIELD nmcm005 name="construct.a.page2.nmcm005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmcm005_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm005_desc
            #add-point:ON ACTION controlp INFIELD nmcm005_desc name="construct.c.page2.nmcm005_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmcm005_desc  #顯示到畫面上
            NEXT FIELD nmcm005_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm005_desc
            #add-point:BEFORE FIELD nmcm005_desc name="construct.b.page2.nmcm005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm005_desc
            
            #add-point:AFTER FIELD nmcm005_desc name="construct.a.page2.nmcm005_desc"
            
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
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "nmck_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "nmed_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "nmcm_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
 
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
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   #161104-00046#13-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#13-----e
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt461.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmt461_query()
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
   CALL g_nmed_d.clear()
   CALL g_nmed2_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL anmt461_set_label_scc('')
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL anmt461_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL anmt461_browser_fill("")
      CALL anmt461_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL anmt461_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL anmt461_fetch("F") 
      #顯示單身筆數
      CALL anmt461_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt461.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmt461_fetch(p_flag)
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
   
   LET g_nmck_m.nmckcomp = g_browser[g_current_idx].b_nmckcomp
   LET g_nmck_m.nmckdocno = g_browser[g_current_idx].b_nmckdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE anmt461_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017,g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005, 
       g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041, 
       g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042, 
       g_nmck_m.nmck010,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124, 
       g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid, 
       g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid, 
       g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103, 
       g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc 
 
   
   #遮罩相關處理
   LET g_nmck_m_mask_o.* =  g_nmck_m.*
   CALL anmt461_nmck_t_mask()
   LET g_nmck_m_mask_n.* =  g_nmck_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt461_set_act_visible()   
   CALL anmt461_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmck_m_t.* = g_nmck_m.*
   LET g_nmck_m_o.* = g_nmck_m.*
   
   LET g_data_owner = g_nmck_m.nmckownid      
   LET g_data_dept  = g_nmck_m.nmckowndp
   
   #重新顯示   
   CALL anmt461_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt461.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt461_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_glaald       LIKE glaa_t.glaald
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_nmed_d.clear()   
   CALL g_nmed2_d.clear()  
 
 
   INITIALIZE g_nmck_m.* TO NULL             #DEFAULT 設定
   
   LET g_nmckcomp_t = NULL
   LET g_nmckdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmck_m.nmckownid = g_user
      LET g_nmck_m.nmckowndp = g_dept
      LET g_nmck_m.nmckcrtid = g_user
      LET g_nmck_m.nmckcrtdp = g_dept 
      LET g_nmck_m.nmckcrtdt = cl_get_current()
      LET g_nmck_m.nmckmodid = g_user
      LET g_nmck_m.nmckmoddt = cl_get_current()
      LET g_nmck_m.nmckstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_nmck_m.nmckstus = "N"
      LET g_nmck_m.nmck043 = "N"
      LET g_nmck_m.nmck001 = "1"
      LET g_nmck_m.nmck026 = "13"
 
  
      #add-point:單頭預設值 name="insert.default"
      #為了避免用戶相同的帳號每次都輸入這些新增的值，賦值如下
      LET g_nmck_m_t.* = g_nmck_m.*
      LET g_nmck_m_t.* = g_nmck_m.*
      #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'6',g_today) RETURNING l_success,g_nmck_m.nmcksite,g_errno

      SELECT ooef017 INTO g_nmck_m.nmckcomp FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_nmck_m.nmcksite

      LET g_nmck_m.nmck003 = g_user
      LET g_nmck_m.nmckdocdt = g_today
      LET g_nmck_m.nmck011 = g_today
      CALL s_axrt300_xrca_ref('xrcasite',g_nmck_m.nmcksite,'','') RETURNING l_success,g_nmck_m.nmcksite_desc
      CALL s_axrt300_xrca_ref('xrcasite',g_nmck_m.nmckcomp,'','') RETURNING l_success,g_nmck_m.nmckcomp_desc
      CALL s_axrt300_xrca_ref('xrca003',g_nmck_m.nmck003,'','') RETURNING l_success,g_nmck_m.nmck003_desc

      CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
      CALL s_ld_sel_glaa(l_glaald,'glaa001') RETURNING g_sub_success,g_nmck_m.nmck100

      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_nmck_m_t.* = g_nmck_m.*
      LET g_nmck_m_o.* = g_nmck_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmck_m.nmckstus 
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
 
 
 
    
      CALL anmt461_input("a")
      
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
         INITIALIZE g_nmck_m.* TO NULL
         INITIALIZE g_nmed_d TO NULL
         INITIALIZE g_nmed2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL anmt461_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_nmed_d.clear()
      #CALL g_nmed2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt461_set_act_visible()   
   CALL anmt461_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmckcomp_t = g_nmck_m.nmckcomp
   LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmckent = " ||g_enterprise|| " AND",
                      " nmckcomp = '", g_nmck_m.nmckcomp, "' "
                      ," AND nmckdocno = '", g_nmck_m.nmckdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt461_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE anmt461_cl
   
   CALL anmt461_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE anmt461_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017,g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005, 
       g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041, 
       g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042, 
       g_nmck_m.nmck010,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124, 
       g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid, 
       g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid, 
       g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103, 
       g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc 
 
   
   
   #遮罩相關處理
   LET g_nmck_m_mask_o.* =  g_nmck_m.*
   CALL anmt461_nmck_t_mask()
   LET g_nmck_m_mask_n.* =  g_nmck_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003,g_nmck_m.nmck003_desc,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
       g_nmck_m.nmck004,g_nmck_m.nmck004_desc,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017, 
       g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005,g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck040_desc, 
       g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041,g_nmck_m.nmck041_desc,g_nmck_m.nmck131, 
       g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042,g_nmck_m.nmck010, 
       g_nmck_m.nmck010_desc,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124, 
       g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckownid_desc, 
       g_nmck_m.nmckowndp,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtid_desc,g_nmck_m.nmckcrtdp, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckmoddt, 
       g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100, 
       g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103,g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck009_desc, 
       g_nmck_m.nmck101,g_nmck_m.nmck113
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_nmck_m.nmckownid      
   LET g_data_dept  = g_nmck_m.nmckowndp
   
   #功能已完成,通報訊息中心
   CALL anmt461_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt461_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   #150813-00015#8--add--str--
   DEFINE l_success   LIKE type_t.num5  
   DEFINE l_slip      LIKE type_t.chr10
   DEFINE l_dfin0033  LIKE type_t.chr80
   DEFINE l_para_date LIKE type_t.dat
   #150813-00015#8--add--end  
   DEFINE l_cnt       LIKE type_t.num5  #160122-00001#29 add
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmck_m_t.* = g_nmck_m.*
   LET g_nmck_m_o.* = g_nmck_m.*
   
   IF g_nmck_m.nmckcomp IS NULL
   OR g_nmck_m.nmckdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_nmckcomp_t = g_nmck_m.nmckcomp
   LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
   CALL s_transaction_begin()
   
   OPEN anmt461_cl USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt461_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt461_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017,g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005, 
       g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041, 
       g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042, 
       g_nmck_m.nmck010,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124, 
       g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid, 
       g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid, 
       g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103, 
       g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc 
 
   
   #檢查是否允許此動作
   IF NOT anmt461_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmck_m_mask_o.* =  g_nmck_m.*
   CALL anmt461_nmck_t_mask()
   LET g_nmck_m_mask_n.* =  g_nmck_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL anmt461_show()
   #add-point:modify段show之後 name="modify.after_show"
   #150813-00015#8--add--str--
   IF g_nmck_m.nmckstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = 'modify'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   #获取单别
   CALL s_aooi200_fin_get_slip(g_nmck_m.nmckdocno) RETURNING l_success,l_slip
   #是否可改日期
   CALL s_fin_get_doc_para(g_glaald,g_nmck_m.nmckcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
   IF l_dfin0033 = 'N' THEN
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk('',g_nmck_m.nmckcomp,'ANM',g_nmck_m.nmckdocdt) RETURNING l_success
      IF l_success = FALSE THEN
         CLOSE anmt461_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   #150813-00015#8--add--end
   #160122-00001#29--add--str--
   #判断当前用户是否有权限操作该交易账号，有权限可以执行删除，反之，不可。
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM nmck_t
    WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp
      AND nmckdocno = g_nmck_m.nmckdocno
      AND (nmck004 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus ='Y') 
          OR nmck004 IN( SELECT nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus ='Y')
          OR TRIM(nmck004) IS NULL)
   IF l_cnt =0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00574'
      LET g_errparam.extend = g_nmck_m.nmck004
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160122-00001#29--add--end
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_nmckcomp_t = g_nmck_m.nmckcomp
      LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_nmck_m.nmckmodid = g_user 
LET g_nmck_m.nmckmoddt = cl_get_current()
LET g_nmck_m.nmckmodid_desc = cl_get_username(g_nmck_m.nmckmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
 
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL anmt461_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE nmck_t SET (nmckmodid,nmckmoddt) = (g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt)
          WHERE nmckent = g_enterprise AND nmckcomp = g_nmckcomp_t
            AND nmckdocno = g_nmckdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_nmck_m.* = g_nmck_m_t.*
            CALL anmt461_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_nmck_m.nmckcomp != g_nmck_m_t.nmckcomp
      OR g_nmck_m.nmckdocno != g_nmck_m_t.nmckdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE nmed_t SET nmedcomp = g_nmck_m.nmckcomp
                                       ,nmeddocno = g_nmck_m.nmckdocno
 
          WHERE nmedent = g_enterprise AND nmedcomp = g_nmck_m_t.nmckcomp
            AND nmeddocno = g_nmck_m_t.nmckdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "nmed_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmed_t:",SQLERRMESSAGE 
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
         
         UPDATE nmcm_t
            SET nmcmcomp = g_nmck_m.nmckcomp
               ,nmcmdocno = g_nmck_m.nmckdocno
 
          WHERE nmcment = g_enterprise AND
                nmcmcomp = g_nmckcomp_t
            AND nmcmdocno = g_nmckdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "nmcm_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmcm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt461_set_act_visible()   
   CALL anmt461_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " nmckent = " ||g_enterprise|| " AND",
                      " nmckcomp = '", g_nmck_m.nmckcomp, "' "
                      ," AND nmckdocno = '", g_nmck_m.nmckdocno, "' "
 
   #填到對應位置
   CALL anmt461_browser_fill("")
 
   CLOSE anmt461_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt461_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="anmt461.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmt461_input(p_cmd)
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
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_pmaa027              LIKE pmaa_t.pmaa027
   DEFINE l_pmaa004              LIKE pmaa_t.pmaa004
   DEFINE l_nmed103              LIKE nmcl_t.nmcl103
   DEFINE l_nmaj002              LIKE nmaj_t.nmaj002
   DEFINE l_origin_str           STRING   #組織範圍
   DEFINE l_errno                LIKE gzze_t.gzze001
   DEFINE l_glaald               LIKE glaa_t.glaald
   DEFINE l_glaa024              LIKE glaa_t.glaa024
   DEFINE l_glaa003              LIKE glaa_t.glaa003
   DEFINE l_glaa005              LIKE glaa_t.glaa005
   DEFINE l_type                 LIKE type_t.chr1
   DEFINE l_nmed003_t            LIKE nmed_t.nmed003
   DEFINE l_nmed004_t            LIKE nmed_t.nmed004
   DEFINE l_nmed005_t            LIKE nmed_t.nmed005
   DEFINE l_gzcb002              LIKE gzcb_t.gzcb002
   DEFINE l_amt1                 LIKE apcc_t.apcc108 
   DEFINE l_amt2                 LIKE apcc_t.apcc118
   DEFINE l_amt3                 LIKE apcc_t.apcc128  
   DEFINE l_amt4                 LIKE apcc_t.apcc138
   DEFINE l_glaa001              LIKE glaa_t.glaa001
   DEFINE l_glaa004              LIKE glaa_t.glaa004
   DEFINE l_glaa025              LIKE glaa_t.glaa025
   DEFINE l_nmed001              LIKE nmed_t.nmed001
   DEFINE l_wc                   STRING   #160930-00013#1
   DEFINE l_sql                  STRING   #160930-00013#1
   DEFINE l_flag                 LIKE type_t.num5     #161104-00046#13
   DEFINE l_slip                 LIKE ooba_t.ooba002  #161104-00046#13
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
   DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003,g_nmck_m.nmck003_desc,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
       g_nmck_m.nmck004,g_nmck_m.nmck004_desc,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017, 
       g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005,g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck040_desc, 
       g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041,g_nmck_m.nmck041_desc,g_nmck_m.nmck131, 
       g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042,g_nmck_m.nmck010, 
       g_nmck_m.nmck010_desc,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124, 
       g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckownid_desc, 
       g_nmck_m.nmckowndp,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtid_desc,g_nmck_m.nmckcrtdp, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckmoddt, 
       g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100, 
       g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103,g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck009_desc, 
       g_nmck_m.nmck101,g_nmck_m.nmck113
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT nmedseq,nmed001,nmedorga,nmed003,nmed004,nmed005,nmed006,nmed011,nmed012, 
       nmed013,nmed002,nmed007,nmed008,nmed009,nmed010,nmed100,nmed101,nmed110,nmed111 FROM nmed_t WHERE  
       nmedent=? AND nmedcomp=? AND nmeddocno=? AND nmedseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt461_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT nmcmseq,nmcm001,nmcm002,nmcm003,nmcm004,nmcm005 FROM nmcm_t WHERE nmcment=?  
       AND nmcmcomp=? AND nmcmdocno=? AND nmcmseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt461_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL anmt461_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL anmt461_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002, 
       g_nmck_m.nmckdocdt,g_nmck_m.nmck004,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017, 
       g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005,g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck123, 
       g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041,g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039, 
       g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042,g_nmck_m.nmck010,g_nmck_m.nmck016,g_nmck_m.nmck114, 
       g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124,g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043, 
       g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103,g_nmck_m.nmck012, 
       g_nmck_m.nmck009,g_nmck_m.nmck101,g_nmck_m.nmck113
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   CALL s_anm_get_site_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_site_wc #160930-00013#1 add
   CALL s_anm_get_comp_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_comp_wc #160930-00013#1 add   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="anmt461.input.head" >}
      #單頭段
      INPUT BY NAME g_nmck_m.nmcksite,g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002, 
          g_nmck_m.nmckdocdt,g_nmck_m.nmck004,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017, 
          g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005,g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck123, 
          g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041,g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039, 
          g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042,g_nmck_m.nmck010,g_nmck_m.nmck016,g_nmck_m.nmck114, 
          g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124,g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043, 
          g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103,g_nmck_m.nmck012, 
          g_nmck_m.nmck009,g_nmck_m.nmck101,g_nmck_m.nmck113 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN anmt461_cl USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt461_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt461_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL anmt461_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL cl_set_comp_required("nmck012",FALSE)          
            CALL cl_set_comp_entry("nmck012",FALSE)
            #end add-point
            CALL anmt461_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcksite
            
            #add-point:AFTER FIELD nmcksite name="input.a.nmcksite"
            IF NOT cl_null(g_nmck_m.nmcksite) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmck_m.nmcksite != g_nmck_m_t.nmcksite OR g_nmck_m_t.nmcksite IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmck_m.nmcksite != g_nmck_m_o.nmcksite OR cl_null(g_nmck_m_o.nmcksite) THEN                                       #160822-00012#5   add
                  LET l_errno = NULL
                  CALL s_fin_account_center_chk(g_nmck_m.nmcksite,'','6',g_nmck_m_t.nmckdocdt) RETURNING l_success,l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_nmck_m.nmcksite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     #LET g_nmck_m.nmcksite = g_nmck_m_t.nmcksite   #160822-00012#5   mark
                     LET g_nmck_m.nmcksite = g_nmck_m_o.nmcksite    #160822-00012#5   add
                     CALL s_axrt300_xrca_ref('xrcasite',g_nmck_m.nmcksite,'','') RETURNING l_success,g_nmck_m.nmcksite_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_nmck_m.nmckcomp) THEN
                     SELECT glaald INTO l_glaald FROM glaa_t
                      WHERE glaaent = g_enterprise AND glaa014 = 'Y'
                        AND glaacomp = g_nmck_m.nmckcomp

                     LET l_errno = NULL
                     #CALL s_fin_account_center_with_ld_chk(g_nmck_m.nmcksite,l_glaald,g_nmck_m.nmck002,'6','N','',g_nmck_m_t.nmckdocdt) #160930-00013#1 maark
                     CALL s_fin_account_center_with_ld_chk(g_nmck_m.nmcksite,'',g_nmck_m.nmck002,'6','N','',g_nmck_m_t.nmckdocdt) #160930-00013#1 add
                        RETURNING l_success,l_errno
                     IF NOT cl_null(l_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = l_errno
                        LET g_errparam.extend = g_nmck_m.nmcksite
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        #LET g_nmck_m.nmcksite = g_nmck_m_t.nmcksite   #160822-00012#5   mark
                        LET g_nmck_m.nmcksite = g_nmck_m_o.nmcksite    #160822-00012#5   add
                        CALL s_axrt300_xrca_ref('xrcasite',g_nmck_m.nmcksite,'','') RETURNING l_success,g_nmck_m.nmcksite_desc
                        NEXT FIELD CURRENT
                     END IF
                     
                     #160930-00013#1 add s---
                     CALL s_anm_get_comp_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_comp_wc
                     IF NOT cl_null(g_nmck_m.nmckcomp) THEN                            
                        IF s_chr_get_index_of(g_comp_wc,g_nmck_m.nmckcomp,1) = 0 THEN               
                        LET g_nmck_m.nmckcomp = ''   #160822-00012#5   add
                        SELECT ooef017 INTO g_nmck_m.nmckcomp
                          FROM ooef_t
                         WHERE ooefent = g_enterprise
                           AND ooef001 = g_nmck_m.nmcksite
                        DISPLAY BY NAME g_nmck_m.nmckcomp
                        CALL s_anm_get_site_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_site_wc
                        END IF  
                     END IF
                     LET g_nmck_m.nmckcomp_desc = s_desc_get_department_desc(g_nmck_m.nmckcomp)
                     DISPLAY BY NAME g_nmck_m.nmckcomp_desc                     
                     #160930-00013#1 add e---
                     
                  END IF
               END IF
            END IF 
            #取得帳務組織下所屬成員
            #CALL s_fin_account_center_sons_query('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt,'1') #160930-00013#1 mark
            CALL s_axrt300_xrca_ref('xrcasite',g_nmck_m.nmcksite,'','') RETURNING l_success,g_nmck_m.nmcksite_desc
            LET g_nmck_m_o.* = g_nmck_m.*    #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcksite
            #add-point:BEFORE FIELD nmcksite name="input.b.nmcksite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcksite
            #add-point:ON CHANGE nmcksite name="input.g.nmcksite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckcomp
            
            #add-point:AFTER FIELD nmckcomp name="input.a.nmckcomp"
            IF  NOT cl_null(g_nmck_m.nmckcomp) AND NOT cl_null(g_nmck_m.nmckdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmck_m.nmckcomp != g_nmckcomp_t  OR g_nmck_m.nmckdocno != g_nmckdocno_t )) THEN 
                  IF NOT ap_chk_notDup(g_nmck_m.nmckcomp,"SELECT COUNT(*) FROM nmck_t WHERE "||"nmckent = '" ||g_enterprise|| "' AND "||"nmckcomp = '"||g_nmck_m.nmckcomp ||"' AND "|| "nmckdocno = '"||g_nmck_m.nmckdocno ||"'",'std-00004',0) THEN 
                     LET g_nmck_m.nmckcomp = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_nmck_m.nmckcomp) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmck_m.nmckcomp != g_nmck_m_t.nmckcomp OR g_nmck_m_t.nmckcomp IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmck_m.nmckcomp != g_nmck_m_o.nmckcomp OR cl_null(g_nmck_m_o.nmckcomp) THEN                                       #160822-00012#5   add
                  LET l_errno = NULL
                  CALL s_fin_comp_chk(g_nmck_m.nmckcomp) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = ''
                     #160321-00016#40 --s add
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     #160321-00016#40 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmck_m.nmckcomp = g_nmck_m_t.nmckcomp   #160822-00012#5   mark
                     LET g_nmck_m.nmckcomp = g_nmck_m_o.nmckcomp    #160822-00012#5   add
                     CALL s_axrt300_xrca_ref('xrcasite',g_nmck_m.nmckcomp,'','') RETURNING l_success,g_nmck_m.nmckcomp_desc
                     NEXT FIELD CURRENT
                  END IF
#160930-00013#1 mark s---                  
#                  IF NOT cl_null(g_nmck_m.nmckcomp)THEN
#                     SELECT glaald INTO l_glaald FROM glaa_t
#                      WHERE glaaent = g_enterprise AND glaa014 = 'Y'
#                        AND glaacomp = g_nmck_m.nmckcomp
#                     LET l_errno = NULL
#                     CALL s_fin_account_center_with_ld_chk(g_nmck_m.nmcksite,l_glaald,g_user,'6','Y','',g_nmck_m.nmckdocdt) 
#                        RETURNING l_success,l_errno
#                     IF NOT l_success THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = l_errno
#                        LET g_errparam.extend = ''
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#                        LET g_nmck_m.nmckcomp = g_nmck_m_t.nmckcomp
#                        CALL s_axrt300_xrca_ref('xrcasite',g_nmck_m.nmckcomp,'','') RETURNING l_success,g_nmck_m.nmckcomp_desc
#                        NEXT FIELD CURRENT
#                     END IF   
#                  END IF
#160930-00013#1 mark e---
                  #160930-00013#1 add s---   
                  IF NOT cl_null(g_nmck_m.nmcksite) THEN  
                     IF s_chr_get_index_of(g_comp_wc,g_nmck_m.nmckcomp,1) = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-02928'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_nmck_m.nmckcomp = g_nmck_m_t.nmckcomp   #160822-00012#5   mark
                        LET g_nmck_m.nmckcomp = g_nmck_m_o.nmckcomp    #160822-00012#5   add
                        CALL s_axrt300_xrca_ref('xrcasite',g_nmck_m.nmckcomp,'','') RETURNING l_success,g_nmck_m.nmckcomp_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF  
                  #160930-00013#1 add e---
                  ##160930-00013#1 add s---
                  #检查用户是否有资金中心对应法人的权限
                  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                              "   AND ooef001 = '",g_nmck_m.nmckcomp,"'",
                              "   AND ooef003 = 'Y'",
                              "   AND ",l_wc CLIPPED
                  PREPARE anmt460_count_prep1 FROM l_sql
                  EXECUTE anmt460_count_prep1 INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00228"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF                  
                  ##160930-00013#1 add e---
               END IF
            END IF
            CALL s_axrt300_xrca_ref('xrcasite',g_nmck_m.nmckcomp,'','') RETURNING l_success,g_nmck_m.nmckcomp_desc
            LET g_nmck_m_o.* = g_nmck_m.*    #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcomp
            #add-point:BEFORE FIELD nmckcomp name="input.b.nmckcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmckcomp
            #add-point:ON CHANGE nmckcomp name="input.g.nmckcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck003
            
            #add-point:AFTER FIELD nmck003 name="input.a.nmck003"
            LET g_nmck_m.nmck003_desc = ' '
            DISPLAY BY NAME g_nmck_m.nmck003_desc
            IF NOT cl_null(g_nmck_m.nmck003) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmck_m.nmck003 != g_nmck_m_t.nmck003 OR g_nmck_m_t.nmck003 IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmck_m.nmck003 != g_nmck_m_o.nmck003 OR cl_null(g_nmck_m_o.nmck003) THEN                                       #160822-00012#5   add
                  #資料存在性、有效性檢查
                  CALL s_employee_chk(g_nmck_m.nmck003) RETURNING l_success
                  IF NOT l_success THEN
                     #LET g_nmck_m.nmck003 = g_nmck_m_t.nmck003   #160822-00012#5   mark
                     LET g_nmck_m.nmck003 = g_nmck_m_o.nmck003    #160822-00012#5   add
                     CALL s_axrt300_xrca_ref('xrca003',g_nmck_m.nmck003,'','') RETURNING l_success,g_nmck_m.nmck003_desc
                     DISPLAY BY NAME g_nmck_m.nmck003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_axrt300_xrca_ref('xrca003',g_nmck_m.nmck003,'','') RETURNING l_success,g_nmck_m.nmck003_desc
            DISPLAY BY NAME g_nmck_m.nmck003,g_nmck_m.nmck003_desc
            LET g_nmck_m_o.* = g_nmck_m.*    #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck003
            #add-point:BEFORE FIELD nmck003 name="input.b.nmck003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck003
            #add-point:ON CHANGE nmck003 name="input.g.nmck003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckdocno
            #add-point:BEFORE FIELD nmckdocno name="input.b.nmckdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckdocno
            
            #add-point:AFTER FIELD nmckdocno name="input.a.nmckdocno"
            IF  NOT cl_null(g_nmck_m.nmckcomp) AND NOT cl_null(g_nmck_m.nmckdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmck_m.nmckcomp != g_nmckcomp_t  OR g_nmck_m.nmckdocno != g_nmckdocno_t )) THEN 
                  IF NOT ap_chk_notDup(g_nmck_m.nmckdocno,"SELECT COUNT(*) FROM nmck_t WHERE "||"nmckent = '" ||g_enterprise|| "' AND "||"nmckcomp = '"||g_nmck_m.nmckcomp ||"' AND "|| "nmckdocno = '"||g_nmck_m.nmckdocno ||"'",'std-00004',0) THEN 
                     LET g_nmck_m.nmckdocno = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_nmck_m.nmckdocno) AND NOT cl_null(g_nmck_m.nmckcomp) THEN
                     SELECT glaald,glaa024 INTO l_glaald,l_glaa024 FROM glaa_t
                      WHERE glaaent = g_enterprise AND glaa014 = 'Y'
                        AND glaacomp = g_nmck_m.nmckcomp
               CALL s_aooi200_fin_chk_slip(l_glaald,l_glaa024,g_nmck_m.nmckdocno,'anmt461') RETURNING l_success
               IF l_success = FALSE THEN 
                  LET g_nmck_m.nmckdocno = g_nmck_m_t.nmckdocno
                  NEXT FIELD nmckdocno
               END IF
               #161104-00046#13-----s
               CALL s_control_chk_doc('1',g_nmck_m.nmckdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN             
               ELSE
                  LET g_nmck_m.nmckdocno = g_nmck_m_o.nmckdocno 
                  NEXT FIELD CURRENT                  
               END IF
               CALL s_aooi200_fin_get_slip(g_nmck_m.nmckdocno) RETURNING g_sub_success,l_slip
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_nmck_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_nmck_m.nmckcomp,'2',l_slip,'','',l_glaald)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_nmck_m.* FROM s_aooi200def1
               #161104-00046#13-----e  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmckdocno
            #add-point:ON CHANGE nmckdocno name="input.g.nmckdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck002
            #add-point:BEFORE FIELD nmck002 name="input.b.nmck002"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck002
            
            #add-point:AFTER FIELD nmck002 name="input.a.nmck002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck002
            #add-point:ON CHANGE nmck002 name="input.g.nmck002"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckdocdt
            #add-point:BEFORE FIELD nmckdocdt name="input.b.nmckdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckdocdt
            
            #add-point:AFTER FIELD nmckdocdt name="input.a.nmckdocdt"
            IF NOT cl_null(g_nmck_m.nmckdocdt) THEN 
               #150813-00015#8--add--str--
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmck_m.nmckdocdt <>g_nmck_m_t.nmckdocdt OR cl_null(g_nmck_m_t.nmckdocdt))) THEN   #160822-00012#5   mark
               IF g_nmck_m.nmckdocdt != g_nmck_m_o.nmckdocdt OR cl_null(g_nmck_m_o.nmckdocdt) THEN                                       #160822-00012#5   add
                  #檢查當單據日期小於等於關帳日期時，不可異動單據
                  CALL s_fin_date_close_chk('',g_nmck_m.nmckcomp,'ANM',g_nmck_m.nmckdocdt) RETURNING l_success
                  IF l_success=FALSE THEN
                     #LET g_nmck_m.nmckdocdt = g_nmck_m_t.nmckdocdt   #160822-00012#5   mark
                     LET g_nmck_m.nmckdocdt = g_nmck_m_o.nmckdocdt    #160822-00012#5   add
                     NEXT FIELD nmckdocdt
                  END IF
               END IF
               #150813-00015#8--add--end
              #IF g_nmck_m.nmckdocdt < g_para_data THEN 
              #   INITIALIZE g_errparam TO NULL
              #   LET g_errparam.code = 'anm-00124'
              #   LET g_errparam.extend = g_nmck_m.nmckdocdt
              #   LET g_errparam.popup = TRUE
              #   CALL cl_err()
              #
              #   LET g_nmck_m.nmckdocdt = g_nmck_m_t.nmckdocdt
              #   NEXT FIELD nmckdocdt
              #END IF
            END IF
            LET g_nmck_m_o.* = g_nmck_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmckdocdt
            #add-point:ON CHANGE nmckdocdt name="input.g.nmckdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck004
            
            #add-point:AFTER FIELD nmck004 name="input.a.nmck004"
            CALL anmt461_nmck004_desc(g_nmck_m.nmck004,g_nmck_m.nmckcomp)
               RETURNING g_nmck_m.nmck004_desc,g_nmck_m.nmas003
            DISPLAY g_nmck_m.nmck004_desc,g_nmck_m.nmas003 TO nmck004_desc,nmas003
            IF NOT cl_null(g_nmck_m.nmck004) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmck_m.nmck004
               LET g_chkparam.arg2 = g_nmck_m.nmckcomp
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"    #160318-00025#13
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmas002_1") THEN
                  #檢查成功時後續處理
                  #160122-00001#29--add---str--
                  IF NOT s_anmi120_nmll002_chk(g_nmck_m.nmck004,g_user) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00574'
                     LET g_errparam.extend = g_nmck_m.nmck004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmck_m.nmck004 = g_nmck_m_t.nmck004
                     CALL anmt461_nmck004_desc(g_nmck_m.nmck004,g_nmck_m.nmckcomp)
                     RETURNING g_nmck_m.nmck004_desc,g_nmck_m.nmas003
                     DISPLAY g_nmck_m.nmck004_desc,g_nmck_m.nmas003 TO nmck004_desc,nmas003
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#29--add---end
                  
                  CALL anmt461_nmck004_desc(g_nmck_m.nmck004,g_nmck_m.nmckcomp)
                     RETURNING g_nmck_m.nmck004_desc,g_nmck_m.nmas003
                  DISPLAY g_nmck_m.nmck004_desc,g_nmck_m.nmas003 TO nmck004_desc,nmas003
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck004 = g_nmck_m_t.nmck004
                  CALL anmt461_nmck004_desc(g_nmck_m.nmck004,g_nmck_m.nmckcomp)
                     RETURNING g_nmck_m.nmck004_desc,g_nmck_m.nmas003
                  DISPLAY g_nmck_m.nmck004_desc,g_nmck_m.nmas003 TO nmck004_desc,nmas003
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck004
            #add-point:BEFORE FIELD nmck004 name="input.b.nmck004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck004
            #add-point:ON CHANGE nmck004 name="input.g.nmck004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmas003
            #add-point:BEFORE FIELD nmas003 name="input.b.nmas003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmas003
            
            #add-point:AFTER FIELD nmas003 name="input.a.nmas003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmas003
            #add-point:ON CHANGE nmas003 name="input.g.nmas003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck019
            #add-point:BEFORE FIELD nmck019 name="input.b.nmck019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck019
            
            #add-point:AFTER FIELD nmck019 name="input.a.nmck019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck019
            #add-point:ON CHANGE nmck019 name="input.g.nmck019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckstus
            #add-point:BEFORE FIELD nmckstus name="input.b.nmckstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckstus
            
            #add-point:AFTER FIELD nmckstus name="input.a.nmckstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmckstus
            #add-point:ON CHANGE nmckstus name="input.g.nmckstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck017
            #add-point:BEFORE FIELD nmck017 name="input.b.nmck017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck017
            
            #add-point:AFTER FIELD nmck017 name="input.a.nmck017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck017
            #add-point:ON CHANGE nmck017 name="input.g.nmck017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck018
            #add-point:BEFORE FIELD nmck018 name="input.b.nmck018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck018
            
            #add-point:AFTER FIELD nmck018 name="input.a.nmck018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck018
            #add-point:ON CHANGE nmck018 name="input.g.nmck018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck121
            #add-point:BEFORE FIELD nmck121 name="input.b.nmck121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck121
            
            #add-point:AFTER FIELD nmck121 name="input.a.nmck121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck121
            #add-point:ON CHANGE nmck121 name="input.g.nmck121"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck005
            
            #add-point:AFTER FIELD nmck005 name="input.a.nmck005"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck005
            #add-point:BEFORE FIELD nmck005 name="input.b.nmck005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck005
            #add-point:ON CHANGE nmck005 name="input.g.nmck005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck037
            #add-point:BEFORE FIELD nmck037 name="input.b.nmck037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck037
            
            #add-point:AFTER FIELD nmck037 name="input.a.nmck037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck037
            #add-point:ON CHANGE nmck037 name="input.g.nmck037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck040
            
            #add-point:AFTER FIELD nmck040 name="input.a.nmck040"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck040
            #add-point:BEFORE FIELD nmck040 name="input.b.nmck040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck040
            #add-point:ON CHANGE nmck040 name="input.g.nmck040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck123
            #add-point:BEFORE FIELD nmck123 name="input.b.nmck123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck123
            
            #add-point:AFTER FIELD nmck123 name="input.a.nmck123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck123
            #add-point:ON CHANGE nmck123 name="input.g.nmck123"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck013
            
            #add-point:AFTER FIELD nmck013 name="input.a.nmck013"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck013
            #add-point:BEFORE FIELD nmck013 name="input.b.nmck013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck013
            #add-point:ON CHANGE nmck013 name="input.g.nmck013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck038
            #add-point:BEFORE FIELD nmck038 name="input.b.nmck038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck038
            
            #add-point:AFTER FIELD nmck038 name="input.a.nmck038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck038
            #add-point:ON CHANGE nmck038 name="input.g.nmck038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck041
            
            #add-point:AFTER FIELD nmck041 name="input.a.nmck041"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck041
            #add-point:BEFORE FIELD nmck041 name="input.b.nmck041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck041
            #add-point:ON CHANGE nmck041 name="input.g.nmck041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck131
            #add-point:BEFORE FIELD nmck131 name="input.b.nmck131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck131
            
            #add-point:AFTER FIELD nmck131 name="input.a.nmck131"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck131
            #add-point:ON CHANGE nmck131 name="input.g.nmck131"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck014
            #add-point:BEFORE FIELD nmck014 name="input.b.nmck014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck014
            
            #add-point:AFTER FIELD nmck014 name="input.a.nmck014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck014
            #add-point:ON CHANGE nmck014 name="input.g.nmck014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck039
            #add-point:BEFORE FIELD nmck039 name="input.b.nmck039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck039
            
            #add-point:AFTER FIELD nmck039 name="input.a.nmck039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck039
            #add-point:ON CHANGE nmck039 name="input.g.nmck039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck133
            #add-point:BEFORE FIELD nmck133 name="input.b.nmck133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck133
            
            #add-point:AFTER FIELD nmck133 name="input.a.nmck133"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck133
            #add-point:ON CHANGE nmck133 name="input.g.nmck133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck015
            #add-point:BEFORE FIELD nmck015 name="input.b.nmck015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck015
            
            #add-point:AFTER FIELD nmck015 name="input.a.nmck015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck015
            #add-point:ON CHANGE nmck015 name="input.g.nmck015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck042
            #add-point:BEFORE FIELD nmck042 name="input.b.nmck042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck042
            
            #add-point:AFTER FIELD nmck042 name="input.a.nmck042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck042
            #add-point:ON CHANGE nmck042 name="input.g.nmck042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck010
            
            #add-point:AFTER FIELD nmck010 name="input.a.nmck010"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck010
            #add-point:BEFORE FIELD nmck010 name="input.b.nmck010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck010
            #add-point:ON CHANGE nmck010 name="input.g.nmck010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck016
            #add-point:BEFORE FIELD nmck016 name="input.b.nmck016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck016
            
            #add-point:AFTER FIELD nmck016 name="input.a.nmck016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck016
            #add-point:ON CHANGE nmck016 name="input.g.nmck016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck114
            #add-point:BEFORE FIELD nmck114 name="input.b.nmck114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck114
            
            #add-point:AFTER FIELD nmck114 name="input.a.nmck114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck114
            #add-point:ON CHANGE nmck114 name="input.g.nmck114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck006
            #add-point:BEFORE FIELD nmck006 name="input.b.nmck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck006
            
            #add-point:AFTER FIELD nmck006 name="input.a.nmck006"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck006
            #add-point:ON CHANGE nmck006 name="input.g.nmck006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck011
            #add-point:BEFORE FIELD nmck011 name="input.b.nmck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck011
            
            #add-point:AFTER FIELD nmck011 name="input.a.nmck011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck011
            #add-point:ON CHANGE nmck011 name="input.g.nmck011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck124
            #add-point:BEFORE FIELD nmck124 name="input.b.nmck124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck124
            
            #add-point:AFTER FIELD nmck124 name="input.a.nmck124"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck124
            #add-point:ON CHANGE nmck124 name="input.g.nmck124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck023
            #add-point:BEFORE FIELD nmck023 name="input.b.nmck023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck023
            
            #add-point:AFTER FIELD nmck023 name="input.a.nmck023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck023
            #add-point:ON CHANGE nmck023 name="input.g.nmck023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck134
            #add-point:BEFORE FIELD nmck134 name="input.b.nmck134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck134
            
            #add-point:AFTER FIELD nmck134 name="input.a.nmck134"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck134
            #add-point:ON CHANGE nmck134 name="input.g.nmck134"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck043
            #add-point:BEFORE FIELD nmck043 name="input.b.nmck043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck043
            
            #add-point:AFTER FIELD nmck043 name="input.a.nmck043"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck043
            #add-point:ON CHANGE nmck043 name="input.g.nmck043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck001
            #add-point:BEFORE FIELD nmck001 name="input.b.nmck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck001
            
            #add-point:AFTER FIELD nmck001 name="input.a.nmck001"
            IF NOT cl_null(g_nmck_m.nmck001) THEN
               IF g_nmck_m.nmck001 <> 5 THEN
                  LET l_count = 0
                  SELECT COUNT(DISTINCT nmed001) INTO l_count FROM nmed_t WHERE nmedent = g_enterprise
                     AND nmeddocno = g_nmck_m.nmckdocno
                     AND nmedcomp = g_nmck_m.nmckcomp
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count > 1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00563'
                     LET g_errparam.extend = g_nmed_d[l_ac].nmed001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmed_d[l_ac].nmed001 = g_nmed_d_t.nmed001
                     NEXT FIELD CURRENT
                  END IF
                  SELECT DISTINCT nmed001 INTO l_nmed001 FROM nmed_t WHERE nmedent = g_enterprise
                     AND nmeddocno = g_nmck_m.nmckdocno
                     AND nmedcomp = g_nmck_m.nmckcomp
                  LET g_errno = ' '
                  CASE
                     WHEN g_nmck_m.nmck001 = '1'
                        IF l_nmed001 <> 'aapt420' THEN LET g_errno = 'anm-00563' END IF
                     WHEN g_nmck_m.nmck001 = '2'
                        IF l_nmed001 <> 'aapt310' THEN LET g_errno = 'anm-00563' END IF
                     WHEN g_nmck_m.nmck001 = '3'
                        IF l_nmed001 <> 'aapt331' THEN LET g_errno = 'anm-00563' END IF
                     WHEN g_nmck_m.nmck001 = '4'
                        IF l_nmed001 <> 'aapt330' THEN LET g_errno = 'anm-00563' END IF
                  END CASE
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmed_d[l_ac].nmed001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmed_d[l_ac].nmed001 = g_nmed_d_t.nmed001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck001
            #add-point:ON CHANGE nmck001 name="input.g.nmck001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck100
            
            #add-point:AFTER FIELD nmck100 name="input.a.nmck100"
            IF NOT cl_null(g_nmck_m.nmck100) THEN
               #160822-00012#5   add---s
               LET l_glaald = ''
               LET l_glaa001 = ''
               LET l_glaa025 = ''
               LET g_nmck_m.nmck101 = ''
               #160822-00012#5   add---e
               CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
               CALL s_ld_sel_glaa(l_glaald,'glaa001|glaa025') RETURNING l_success,l_glaa001,l_glaa025
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmck_m.nmck100
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"    #160318-00025#13
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                  #IF p_cmd = 'a' OR (p_cmd = 'u' AND g_nmck_m.nmck100 <> g_nmck_m_t.nmck100) THEN   #160822-00012#5   mark
                  IF g_nmck_m.nmck100 != g_nmck_m_o.nmck100 OR cl_null(g_nmck_m_o.nmck100) THEN      #160822-00012#5   add
                                              #匯率參照表;帳套;         日期;       來源幣別
                     CALL s_aooi160_get_exrate('2',l_glaald,g_nmck_m.nmckdocdt,g_nmck_m.nmck100,
                                              #目的幣別;  交易金額;              匯類類型
                                               l_glaa001,0,l_glaa025)
                        RETURNING g_nmck_m.nmck101
                     DISPLAY g_nmck_m.nmck101 TO nmck101
                     LET g_nmck_m.nmck113 = g_nmck_m.nmck103 * g_nmck_m.nmck101
                     DISPLAY g_nmck_m.nmck113 TO nmck113
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  #LET g_nmck_m.nmck100 = g_nmck_m_t.nmck100   #160822-00012#5   mark
                  LET g_nmck_m.nmck100 = g_nmck_m_o.nmck100    #160822-00012#5   add
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_nmck_m_o.* = g_nmck_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck100
            #add-point:BEFORE FIELD nmck100 name="input.b.nmck100"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck100
            #add-point:ON CHANGE nmck100 name="input.g.nmck100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck026
            #add-point:BEFORE FIELD nmck026 name="input.b.nmck026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck026
            
            #add-point:AFTER FIELD nmck026 name="input.a.nmck026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck026
            #add-point:ON CHANGE nmck026 name="input.g.nmck026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck008
            #add-point:BEFORE FIELD nmck008 name="input.b.nmck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck008
            
            #add-point:AFTER FIELD nmck008 name="input.a.nmck008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck008
            #add-point:ON CHANGE nmck008 name="input.g.nmck008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck103
            #add-point:BEFORE FIELD nmck103 name="input.b.nmck103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck103
            
            #add-point:AFTER FIELD nmck103 name="input.a.nmck103"
            LET g_nmck_m_o.* = g_nmck_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck103
            #add-point:ON CHANGE nmck103 name="input.g.nmck103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck012
            #add-point:BEFORE FIELD nmck012 name="input.b.nmck012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck012
            
            #add-point:AFTER FIELD nmck012 name="input.a.nmck012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck012
            #add-point:ON CHANGE nmck012 name="input.g.nmck012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck009
            
            #add-point:AFTER FIELD nmck009 name="input.a.nmck009"
            IF NOT cl_null(g_nmck_m.nmck009) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               SELECT glaa005 INTO l_glaa005 FROM glaa_t WHERE glaaent = g_enterprise
                  AND glaacomp = g_nmck_m.nmckcomp AND glaa014 = 'Y'

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_glaa005
               LET g_chkparam.arg2 = g_nmck_m.nmck009
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00149:sub-01302|anmi172|",cl_get_progname("anmi172",g_lang,"2"),"|:EXEPROGanmi172"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmad002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  SELECT nmaj002 INTO l_nmaj002 FROM nmaj_t
                   WHERE nmajent = g_enterprise
                     AND nmaj001 = g_nmck_m.nmck009
                  
                  IF l_nmaj002 <> '2' THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmck_m.nmck009
                     LET g_errparam.code   = "anm-00215" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_nmck_m.nmck009 = g_nmck_m_t.nmck009
                     CALL anmt461_nmck009_desc(g_nmck_m.nmck009) RETURNING g_nmck_m.nmck009_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck009 = g_nmck_m_t.nmck009
                  CALL anmt461_nmck009_desc(g_nmck_m.nmck009) RETURNING g_nmck_m.nmck009_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL anmt461_nmck009_desc(g_nmck_m.nmck009) RETURNING g_nmck_m.nmck009_desc
            DISPLAY BY NAME g_nmck_m.nmck009_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck009
            #add-point:BEFORE FIELD nmck009 name="input.b.nmck009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck009
            #add-point:ON CHANGE nmck009 name="input.g.nmck009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck101
            #add-point:BEFORE FIELD nmck101 name="input.b.nmck101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck101
            
            #add-point:AFTER FIELD nmck101 name="input.a.nmck101"
            LET g_nmck_m_o.* = g_nmck_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck101
            #add-point:ON CHANGE nmck101 name="input.g.nmck101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck113
            #add-point:BEFORE FIELD nmck113 name="input.b.nmck113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck113
            
            #add-point:AFTER FIELD nmck113 name="input.a.nmck113"
            LET g_nmck_m_o.* = g_nmck_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck113
            #add-point:ON CHANGE nmck113 name="input.g.nmck113"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmcksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcksite
            #add-point:ON ACTION controlp INFIELD nmcksite name="input.c.nmcksite"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmck_m.nmcksite
            LET g_qryparam.where = " ooef206 = 'Y'"
            LET g_qryparam.where = g_qryparam.where," AND ooefstus= 'Y'" #161021-00050#9
            #CALL q_ooef001()    #161021-00050#9 mark
            CALL q_ooef001_33()  #161021-00050#9
            LET g_nmck_m.nmcksite = g_qryparam.return1
            DISPLAY g_nmck_m.nmcksite TO nmcksite
            CALL s_axrt300_xrca_ref('xrcasite',g_nmck_m.nmcksite,'','') RETURNING l_success,g_nmck_m.nmcksite_desc
            CALL s_fin_account_center_sons_query('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt,'1')
            NEXT FIELD nmcksite
            #END add-point
 
 
         #Ctrlp:input.c.nmckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcomp
            #add-point:ON ACTION controlp INFIELD nmckcomp name="input.c.nmckcomp"
            #160930-00013#1 mark s---
            ##取得帳務組織下所屬成員
            #CALL s_fin_account_center_sons_query('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt,'1')
            #CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            ##將取回的字串轉換為SQL條件
            #CALL anmt461_change_to_sql(l_origin_str) RETURNING l_origin_str 
            #160930-00013#1 mark e---
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmck_m.nmckcomp
            #LET g_qryparam.where = " ooef001 IN (",l_origin_str CLIPPED,")" #160930-00013#1 mark
            #160930-00013#1 add s---
            CALL s_anm_get_comp_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_comp_wc
            LET g_qryparam.where = " ooef001 IN ",g_comp_wc
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED," AND ooef003 = 'Y'"
            #160930-00013#1 add e---
            #CALL q_ooef001()  #161021-00050#9 mark
            CALL q_ooef001_2() #161021-00050#9
            LET g_nmck_m.nmckcomp = g_qryparam.return1
            DISPLAY g_nmck_m.nmckcomp TO nmckcomp
            NEXT FIELD nmckcomp
            #END add-point
 
 
         #Ctrlp:input.c.nmck003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck003
            #add-point:ON ACTION controlp INFIELD nmck003 name="input.c.nmck003"
 
            #END add-point
 
 
         #Ctrlp:input.c.nmckdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckdocno
            #add-point:ON ACTION controlp INFIELD nmckdocno name="input.c.nmckdocno"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmckdocno             #給予default值

            #給予arg
            SELECT glaald,glaa024 INTO l_glaald,l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise AND glaa014 = 'Y'
               AND glaacomp = g_nmck_m.nmckcomp


            LET g_qryparam.arg1 = l_glaa024
            #LET g_qryparam.arg2 = "anmt461"     #160705-00042#4 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#4 160711 by sakura add
            #161104-00046#13-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc 
            END IF
            #161104-00046#13-----e
            CALL q_ooba002_1()                                #呼叫開窗


            LET g_nmck_m.nmckdocno = g_qryparam.return1              

            DISPLAY g_nmck_m.nmckdocno TO nmckdocno              #

            NEXT FIELD nmckdocno                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.nmck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck002
            #add-point:ON ACTION controlp INFIELD nmck002 name="input.c.nmck002"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmckdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckdocdt
            #add-point:ON ACTION controlp INFIELD nmckdocdt name="input.c.nmckdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck004
            #add-point:ON ACTION controlp INFIELD nmck004 name="input.c.nmck004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck004             #給予default值
            LET g_qryparam.where = " nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                   "              AND ooef017 = '",g_nmck_m.nmckcomp,"')"
                                   #160122-00001#29--add---str
                                  ," AND nmas002 IN (",g_sql_bank,")"  #160122-00001#29 By 07900 --mod
                                   #160122-00001#29--add---end
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_nmas_01()                                #呼叫開窗

            LET g_nmck_m.nmck004 = g_qryparam.return1              
            CALL anmt461_nmck004_desc(g_nmck_m.nmck004,g_nmck_m.nmckcomp)
               RETURNING g_nmck_m.nmck004_desc,g_nmck_m.nmas003
            DISPLAY g_nmck_m.nmck004_desc,g_nmck_m.nmas003 TO nmck004_desc,nmas003
            DISPLAY g_nmck_m.nmck004 TO nmck004              #

            NEXT FIELD nmck004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmas003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmas003
            #add-point:ON ACTION controlp INFIELD nmas003 name="input.c.nmas003"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck019
            #add-point:ON ACTION controlp INFIELD nmck019 name="input.c.nmck019"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmckstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckstus
            #add-point:ON ACTION controlp INFIELD nmckstus name="input.c.nmckstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck017
            #add-point:ON ACTION controlp INFIELD nmck017 name="input.c.nmck017"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck018
            #add-point:ON ACTION controlp INFIELD nmck018 name="input.c.nmck018"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck121
            #add-point:ON ACTION controlp INFIELD nmck121 name="input.c.nmck121"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck005
            #add-point:ON ACTION controlp INFIELD nmck005 name="input.c.nmck005"
 
            #END add-point
 
 
         #Ctrlp:input.c.nmck037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck037
            #add-point:ON ACTION controlp INFIELD nmck037 name="input.c.nmck037"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck040
            #add-point:ON ACTION controlp INFIELD nmck040 name="input.c.nmck040"
 
            #END add-point
 
 
         #Ctrlp:input.c.nmck123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck123
            #add-point:ON ACTION controlp INFIELD nmck123 name="input.c.nmck123"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck013
            #add-point:ON ACTION controlp INFIELD nmck013 name="input.c.nmck013"
 
            #END add-point
 
 
         #Ctrlp:input.c.nmck038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck038
            #add-point:ON ACTION controlp INFIELD nmck038 name="input.c.nmck038"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck041
            #add-point:ON ACTION controlp INFIELD nmck041 name="input.c.nmck041"
 
            #END add-point
 
 
         #Ctrlp:input.c.nmck131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck131
            #add-point:ON ACTION controlp INFIELD nmck131 name="input.c.nmck131"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck014
            #add-point:ON ACTION controlp INFIELD nmck014 name="input.c.nmck014"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck039
            #add-point:ON ACTION controlp INFIELD nmck039 name="input.c.nmck039"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck133
            #add-point:ON ACTION controlp INFIELD nmck133 name="input.c.nmck133"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck015
            #add-point:ON ACTION controlp INFIELD nmck015 name="input.c.nmck015"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck042
            #add-point:ON ACTION controlp INFIELD nmck042 name="input.c.nmck042"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck010
            #add-point:ON ACTION controlp INFIELD nmck010 name="input.c.nmck010"
 
            #END add-point
 
 
         #Ctrlp:input.c.nmck016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck016
            #add-point:ON ACTION controlp INFIELD nmck016 name="input.c.nmck016"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck114
            #add-point:ON ACTION controlp INFIELD nmck114 name="input.c.nmck114"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck006
            #add-point:ON ACTION controlp INFIELD nmck006 name="input.c.nmck006"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck011
            #add-point:ON ACTION controlp INFIELD nmck011 name="input.c.nmck011"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck124
            #add-point:ON ACTION controlp INFIELD nmck124 name="input.c.nmck124"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck023
            #add-point:ON ACTION controlp INFIELD nmck023 name="input.c.nmck023"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck134
            #add-point:ON ACTION controlp INFIELD nmck134 name="input.c.nmck134"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck043
            #add-point:ON ACTION controlp INFIELD nmck043 name="input.c.nmck043"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck001
            #add-point:ON ACTION controlp INFIELD nmck001 name="input.c.nmck001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck100
            #add-point:ON ACTION controlp INFIELD nmck100 name="input.c.nmck100"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck100             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_aooi001_1()                                #呼叫開窗

            LET g_nmck_m.nmck100 = g_qryparam.return1              

            DISPLAY g_nmck_m.nmck100 TO nmck100              #

            NEXT FIELD nmck100                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.nmck026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck026
            #add-point:ON ACTION controlp INFIELD nmck026 name="input.c.nmck026"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck008
            #add-point:ON ACTION controlp INFIELD nmck008 name="input.c.nmck008"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck103
            #add-point:ON ACTION controlp INFIELD nmck103 name="input.c.nmck103"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck012
            #add-point:ON ACTION controlp INFIELD nmck012 name="input.c.nmck012"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck009
            #add-point:ON ACTION controlp INFIELD nmck009 name="input.c.nmck009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck009             #給予default值
            LET g_qryparam.where  = " nmaj002 = '2'" 
            #給予arg
            SELECT glaa005 INTO l_glaa005 FROM glaa_t WHERE glaaent = g_enterprise
               AND glaacomp = g_nmck_m.nmckcomp
               AND glaa014 = 'Y'
            LET g_qryparam.arg1 = l_glaa005

            
            CALL q_nmad002_1()                                #呼叫開窗

            LET g_nmck_m.nmck009 = g_qryparam.return1              
            CALL anmt461_nmck009_desc(g_nmck_m.nmck009) RETURNING g_nmck_m.nmck009_desc
            DISPLAY g_nmck_m.nmck009 TO nmck009              #
            DISPLAY BY NAME g_nmck_m.nmck009_desc

            NEXT FIELD nmck009                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.nmck101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck101
            #add-point:ON ACTION controlp INFIELD nmck101 name="input.c.nmck101"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck113
            #add-point:ON ACTION controlp INFIELD nmck113 name="input.c.nmck113"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               IF g_nmck_m.nmck002 = '2' AND cl_null(g_nmck_m.nmck017) AND cl_null(g_nmck_m.nmck018) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00135'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD nmck017
               END IF
               SELECT glaald,glaa024,glaa003 INTO l_glaald,l_glaa024,l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise
                  AND glaacomp = g_nmck_m.nmckcomp
                  AND glaa014 = 'Y'
               CALL s_aooi200_fin_gen_docno(l_glaald,l_glaa024,l_glaa003,g_nmck_m.nmckdocno,g_nmck_m.nmckdocdt,g_prog)
                   RETURNING l_success,g_nmck_m.nmckdocno     
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_nmck_m.nmckdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD nmckdocno
               END IF 
                    
               LET g_nmck_m.nmck114 =  g_nmck_m.nmck113
               LET g_nmck_m.nmck124 =  g_nmck_m.nmck123
               LET g_nmck_m.nmck134 =  g_nmck_m.nmck133
               #end add-point
               
               INSERT INTO nmck_t (nmckent,nmcksite,nmckcomp,nmck003,nmckdocno,nmck002,nmckdocdt,nmck004, 
                   nmck019,nmckstus,nmck017,nmck018,nmck121,nmck005,nmck037,nmck040,nmck123,nmck013, 
                   nmck038,nmck041,nmck131,nmck014,nmck039,nmck133,nmck015,nmck042,nmck010,nmck016,nmck114, 
                   nmck006,nmck011,nmck124,nmck023,nmck134,nmck043,nmckownid,nmckowndp,nmckcrtid,nmckcrtdp, 
                   nmckcrtdt,nmckmodid,nmckmoddt,nmckcnfid,nmckcnfdt,nmck001,nmck100,nmck026,nmck008, 
                   nmck103,nmck012,nmck009,nmck101,nmck113)
               VALUES (g_enterprise,g_nmck_m.nmcksite,g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno, 
                   g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004,g_nmck_m.nmck019,g_nmck_m.nmckstus, 
                   g_nmck_m.nmck017,g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005,g_nmck_m.nmck037, 
                   g_nmck_m.nmck040,g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041, 
                   g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015, 
                   g_nmck_m.nmck042,g_nmck_m.nmck010,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006, 
                   g_nmck_m.nmck011,g_nmck_m.nmck124,g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043, 
                   g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdt, 
                   g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001, 
                   g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103,g_nmck_m.nmck012, 
                   g_nmck_m.nmck009,g_nmck_m.nmck101,g_nmck_m.nmck113) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_nmck_m:",SQLERRMESSAGE 
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
                  CALL anmt461_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL anmt461_b_fill()
                  CALL anmt461_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               IF g_nmck_m.nmck002 = '2' AND cl_null(g_nmck_m.nmck017) AND cl_null(g_nmck_m.nmck018) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00135'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD nmck017
               END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL anmt461_nmck_t_mask_restore('restore_mask_o')
               
               UPDATE nmck_t SET (nmcksite,nmckcomp,nmck003,nmckdocno,nmck002,nmckdocdt,nmck004,nmck019, 
                   nmckstus,nmck017,nmck018,nmck121,nmck005,nmck037,nmck040,nmck123,nmck013,nmck038, 
                   nmck041,nmck131,nmck014,nmck039,nmck133,nmck015,nmck042,nmck010,nmck016,nmck114,nmck006, 
                   nmck011,nmck124,nmck023,nmck134,nmck043,nmckownid,nmckowndp,nmckcrtid,nmckcrtdp,nmckcrtdt, 
                   nmckmodid,nmckmoddt,nmckcnfid,nmckcnfdt,nmck001,nmck100,nmck026,nmck008,nmck103,nmck012, 
                   nmck009,nmck101,nmck113) = (g_nmck_m.nmcksite,g_nmck_m.nmckcomp,g_nmck_m.nmck003, 
                   g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004,g_nmck_m.nmck019, 
                   g_nmck_m.nmckstus,g_nmck_m.nmck017,g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005, 
                   g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038, 
                   g_nmck_m.nmck041,g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133, 
                   g_nmck_m.nmck015,g_nmck_m.nmck042,g_nmck_m.nmck010,g_nmck_m.nmck016,g_nmck_m.nmck114, 
                   g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124,g_nmck_m.nmck023,g_nmck_m.nmck134, 
                   g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp, 
                   g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt, 
                   g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103, 
                   g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck101,g_nmck_m.nmck113)
                WHERE nmckent = g_enterprise AND nmckcomp = g_nmckcomp_t
                  AND nmckdocno = g_nmckdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "nmck_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
 
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL anmt461_nmck_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_nmck_m_t)
               LET g_log2 = util.JSON.stringify(g_nmck_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_nmckcomp_t = g_nmck_m.nmckcomp
            LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="anmt461.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_nmed_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            LET l_count = 0
            SELECT COUNT(*) INTO l_count FROM nmed_t WHERE nmedent = g_enterprise
               AND nmeddocno = g_nmck_m.nmckdocno
               AND nmedcomp  = g_nmck_m.nmckcomp
            IF cl_null(l_count) THEN LET l_count = 0 END IF
            IF l_count = 0 THEN
               CALL anmt461_open_s01()
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmed_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt461_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_nmed_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            CALL anmt461_set_label_scc(g_nmck_m.nmck001)
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
            OPEN anmt461_cl USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt461_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt461_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmed_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmed_d[l_ac].nmedseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmed_d_t.* = g_nmed_d[l_ac].*  #BACKUP
               LET g_nmed_d_o.* = g_nmed_d[l_ac].*  #BACKUP
               CALL anmt461_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL anmt461_set_no_entry_b(l_cmd)
               IF NOT anmt461_lock_b("nmed_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt461_bcl INTO g_nmed_d[l_ac].nmedseq,g_nmed_d[l_ac].nmed001,g_nmed_d[l_ac].nmedorga, 
                      g_nmed_d[l_ac].nmed003,g_nmed_d[l_ac].nmed004,g_nmed_d[l_ac].nmed005,g_nmed_d[l_ac].nmed006, 
                      g_nmed_d[l_ac].nmed011,g_nmed_d[l_ac].nmed012,g_nmed_d[l_ac].nmed013,g_nmed_d[l_ac].nmed002, 
                      g_nmed_d[l_ac].nmed007,g_nmed_d[l_ac].nmed008,g_nmed_d[l_ac].nmed009,g_nmed_d[l_ac].nmed010, 
                      g_nmed_d[l_ac].nmed100,g_nmed_d[l_ac].nmed101,g_nmed_d[l_ac].nmed110,g_nmed_d[l_ac].nmed111 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmed_d_t.nmedseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmed_d_mask_o[l_ac].* =  g_nmed_d[l_ac].*
                  CALL anmt461_nmed_t_mask()
                  LET g_nmed_d_mask_n[l_ac].* =  g_nmed_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt461_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL anmt461_nmed006_desc(g_nmed_d[l_ac].nmed006) RETURNING g_nmed_d[l_ac].nmed006_desc
            CALL anmt461_nmed011_desc(g_nmed_d[l_ac].nmed011) RETURNING g_nmed_d[l_ac].nmed011_desc
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
            INITIALIZE g_nmed_d[l_ac].* TO NULL 
            INITIALIZE g_nmed_d_t.* TO NULL 
            INITIALIZE g_nmed_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_nmed_d[l_ac].nmed100 = "0"
      LET g_nmed_d[l_ac].nmed110 = "0"
      LET g_nmed_d[l_ac].nmed111 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_nmed_d[l_ac].nmedorga = g_nmck_m.nmcksite  #160930-00013#1 add
            CALL s_anm_orga_chk(g_nmed_d[l_ac].nmedorga,g_nmck_m.nmckcomp) RETURNING g_nmed_d[l_ac].nmedorga  #160930-00013#1 add
            #end add-point
            LET g_nmed_d_t.* = g_nmed_d[l_ac].*     #新輸入資料
            LET g_nmed_d_o.* = g_nmed_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt461_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt461_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmed_d[li_reproduce_target].* = g_nmed_d[li_reproduce].*
 
               LET g_nmed_d[li_reproduce_target].nmedseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF cl_null(g_nmed_d[g_detail_idx].nmedseq) THEN 
               SELECT MAX(nmedseq) INTO g_nmed_d[g_detail_idx].nmedseq
                 FROM nmed_t
                WHERE nmedent = g_enterprise
                  AND nmedcomp = g_nmck_m.nmckcomp
                  AND nmeddocno = g_nmck_m.nmckdocno
                  
               IF cl_null(g_nmed_d[g_detail_idx].nmedseq) THEN 
                  LET g_nmed_d[g_detail_idx].nmedseq = 1
               ELSE
                  LET g_nmed_d[g_detail_idx].nmedseq = g_nmed_d[g_detail_idx].nmedseq + 1
               END IF
            END IF
            DISPLAY g_nmed_d[g_detail_idx].nmedseq TO s_detail1[g_detail_idx].nmedseq
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
            SELECT COUNT(1) INTO l_count FROM nmed_t 
             WHERE nmedent = g_enterprise AND nmedcomp = g_nmck_m.nmckcomp
               AND nmeddocno = g_nmck_m.nmckdocno
 
               AND nmedseq = g_nmed_d[l_ac].nmedseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmck_m.nmckcomp
               LET gs_keys[2] = g_nmck_m.nmckdocno
               LET gs_keys[3] = g_nmed_d[g_detail_idx].nmedseq
               CALL anmt461_insert_b('nmed_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_nmed_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmed_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt461_b_fill()
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
               LET gs_keys[01] = g_nmck_m.nmckcomp
               LET gs_keys[gs_keys.getLength()+1] = g_nmck_m.nmckdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_nmed_d_t.nmedseq
 
            
               #刪除同層單身
               IF NOT anmt461_delete_b('nmed_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt461_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt461_key_delete_b(gs_keys,'nmed_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt461_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt461_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_nmed_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmed_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmedseq
            #add-point:BEFORE FIELD nmedseq name="input.b.page1.nmedseq"
            IF cl_null(g_nmed_d[g_detail_idx].nmedseq) THEN 
               SELECT MAX(nmedseq) INTO g_nmed_d[g_detail_idx].nmedseq
                 FROM nmed_t
                WHERE nmedent = g_enterprise
                  AND nmedcomp = g_nmck_m.nmckcomp
                  AND nmeddocno = g_nmck_m.nmckdocno
                  
               IF cl_null(g_nmed_d[g_detail_idx].nmedseq) THEN 
                  LET g_nmed_d[g_detail_idx].nmedseq = 1
               ELSE
                  LET g_nmed_d[g_detail_idx].nmedseq = g_nmed_d[g_detail_idx].nmedseq + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmedseq
            
            #add-point:AFTER FIELD nmedseq name="input.a.page1.nmedseq"
            #此段落由子樣板a05產生
            IF  g_nmck_m.nmckcomp IS NOT NULL AND g_nmck_m.nmckdocno IS NOT NULL AND g_nmed_d[g_detail_idx].nmedseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmck_m.nmckcomp != g_nmckcomp_t OR g_nmck_m.nmckdocno != g_nmckdocno_t OR g_nmed_d[g_detail_idx].nmedseq != g_nmed_d_t.nmedseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmed_t WHERE "||"nmedent = '" ||g_enterprise|| "' AND "||"nmedcomp = '"||g_nmck_m.nmckcomp ||"' AND "|| "nmeddocno = '"||g_nmck_m.nmckdocno ||"' AND "|| "nmedseq = '"||g_nmed_d[g_detail_idx].nmedseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmedseq
            #add-point:ON CHANGE nmedseq name="input.g.page1.nmedseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed001
            #add-point:BEFORE FIELD nmed001 name="input.b.page1.nmed001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed001
            
            #add-point:AFTER FIELD nmed001 name="input.a.page1.nmed001"
            IF NOT cl_null(g_nmed_d[l_ac].nmed001) THEN
               CALL anmt461_set_entry_b(l_cmd)
               CALL anmt461_set_no_entry_b(l_cmd)
               LET g_nmed_d[l_ac].nmed003 = ''
               LET g_nmed_d[l_ac].nmed004 = ''
               LET g_nmed_d[l_ac].nmed005 = ''
               LET g_nmed_d[l_ac].nmed006 = ''
               LET g_nmed_d[l_ac].nmed006_desc = ''
               LET g_nmed_d[l_ac].nmed011 = ''
               LET g_nmed_d[l_ac].nmed011_desc = ''
               LET g_nmed_d[l_ac].nmed012 = 0
               LET g_nmed_d[l_ac].nmed013 = 0
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed001
            #add-point:ON CHANGE nmed001 name="input.g.page1.nmed001"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmedorga
            #add-point:BEFORE FIELD nmedorga name="input.b.page1.nmedorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmedorga
            
            #add-point:AFTER FIELD nmedorga name="input.a.page1.nmedorga"
            IF NOT cl_null(g_nmed_d[l_ac].nmedorga) THEN 
#160930-00013# mark s---
##此段落由子樣板a19產生
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_nmed_d[l_ac].nmedorga
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_nmed_d[l_ac].nmedorga = g_nmed_d_t.nmedorga
#                  NEXT FIELD CURRENT
#               END IF
                  CALL s_anm_ooef001_chk(g_nmed_d[l_ac].nmedorga) RETURNING g_sub_success,g_errno     
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_nmed_d[l_ac].nmedorga = g_nmed_d_t.nmedorga
                     NEXT FIELD CURRENT
                  END IF
                  

                  CALL s_anm_get_site_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_site_wc
                  IF cl_null(g_site_wc) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03020' #该资金中心下无可用运营据点!
                     LET g_errparam.extend = g_nmck_m.nmcksite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmed_d[l_ac].nmedorga = g_nmed_d_t.nmedorga
                     NEXT FIELD CURRENT
                  END IF                  

                  
                  #檢查輸入組織代碼是否存在法人組織下的組織範圍內(1.與單頭法人組織法人相同2.屬於資金組織3.user具有拜訪權限)
                  IF s_chr_get_index_of(g_site_wc,g_nmed_d[l_ac].nmedorga,1) = 0 THEN
                     LET g_errno ='axc-00099'
                  ELSE
                     IF NOT ap_chk_isExist(g_nmed_d[l_ac].nmedorga,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus ='Y' AND ooef017 = '"||g_nmck_m.nmckcomp||"'",'anm-03022',1) THEN 
                        LET g_nmed_d[l_ac].nmedorga = g_nmed_d_t.nmedorga
                        NEXT FIELD CURRENT
                     END IF 
                  END IF
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_nmed_d[l_ac].nmedorga = g_nmed_d_t.nmedorga
                     NEXT FIELD CURRENT
                  END IF
#160930-00013#1 mark e---            

            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmedorga
            #add-point:ON CHANGE nmedorga name="input.g.page1.nmedorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed003
            #add-point:BEFORE FIELD nmed003 name="input.b.page1.nmed003"
            LET l_nmed003_t = g_nmed_d[l_ac].nmed003
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed003
            
            #add-point:AFTER FIELD nmed003 name="input.a.page1.nmed003"
            IF NOT cl_null(g_nmed_d[l_ac].nmed003) AND NOT cl_null(g_nmed_d[l_ac].nmed004) THEN
               IF g_nmed_d[l_ac].nmed003 <> l_nmed003_t OR cl_null(l_nmed003_t) THEN
                  CALL anmt461_source_chk(g_nmed_d[l_ac].nmed003,g_nmed_d[l_ac].nmed004,g_nmed_d[l_ac].nmed005)
                     RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL anmt461_set_entry_b(l_cmd)
               CALL anmt461_set_no_entry_b(l_cmd)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed003
            #add-point:ON CHANGE nmed003 name="input.g.page1.nmed003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed004
            #add-point:BEFORE FIELD nmed004 name="input.b.page1.nmed004"
            LET l_nmed004_t = g_nmed_d[l_ac].nmed004
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed004
            
            #add-point:AFTER FIELD nmed004 name="input.a.page1.nmed004"
            IF NOT cl_null(g_nmed_d[l_ac].nmed003) AND NOT cl_null(g_nmed_d[l_ac].nmed004) THEN
               IF g_nmed_d[l_ac].nmed004 <> l_nmed004_t OR cl_null(l_nmed004_t) THEN
                  CALL anmt461_source_chk(g_nmed_d[l_ac].nmed003,g_nmed_d[l_ac].nmed004,g_nmed_d[l_ac].nmed005)
                     RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL anmt461_set_entry_b(l_cmd)
               CALL anmt461_set_no_entry_b(l_cmd)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed004
            #add-point:ON CHANGE nmed004 name="input.g.page1.nmed004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed005
            #add-point:BEFORE FIELD nmed005 name="input.b.page1.nmed005"
            LET l_nmed005_t = g_nmed_d[l_ac].nmed005
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed005
            
            #add-point:AFTER FIELD nmed005 name="input.a.page1.nmed005"
            IF NOT cl_null(g_nmed_d[l_ac].nmed003) AND NOT cl_null(g_nmed_d[l_ac].nmed004) AND NOT cl_null(g_nmed_d[l_ac].nmed005) THEN
               IF g_nmed_d[l_ac].nmed005 <> l_nmed005_t OR cl_null(l_nmed005_t) THEN
                  CALL anmt461_source_chk(g_nmed_d[l_ac].nmed003,g_nmed_d[l_ac].nmed004,g_nmed_d[l_ac].nmed005)
                     RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed005
            #add-point:ON CHANGE nmed005 name="input.g.page1.nmed005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed006
            
            #add-point:AFTER FIELD nmed006 name="input.a.page1.nmed006"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed006
            #add-point:BEFORE FIELD nmed006 name="input.b.page1.nmed006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed006
            #add-point:ON CHANGE nmed006 name="input.g.page1.nmed006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed006_desc
            #add-point:BEFORE FIELD nmed006_desc name="input.b.page1.nmed006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed006_desc
            
            #add-point:AFTER FIELD nmed006_desc name="input.a.page1.nmed006_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed006_desc
            #add-point:ON CHANGE nmed006_desc name="input.g.page1.nmed006_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed011
            
            #add-point:AFTER FIELD nmed011 name="input.a.page1.nmed011"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed011
            #add-point:BEFORE FIELD nmed011 name="input.b.page1.nmed011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed011
            #add-point:ON CHANGE nmed011 name="input.g.page1.nmed011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed011_desc
            #add-point:BEFORE FIELD nmed011_desc name="input.b.page1.nmed011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed011_desc
            
            #add-point:AFTER FIELD nmed011_desc name="input.a.page1.nmed011_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed011_desc
            #add-point:ON CHANGE nmed011_desc name="input.g.page1.nmed011_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed012
            #add-point:BEFORE FIELD nmed012 name="input.b.page1.nmed012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed012
            
            #add-point:AFTER FIELD nmed012 name="input.a.page1.nmed012"
            IF NOT cl_null(g_nmed_d[l_ac].nmed012) THEN
               IF g_nmed_d[l_ac].nmed001 = 'aapt420' THEN
                  LET l_type = '1'
               ELSE
                  LET l_type = '2'
               END IF
               CALL s_anmt461_amt(l_type,l_glaald,g_nmed_d[l_ac].nmed003,g_nmed_d[l_ac].nmed004,g_nmed_d[l_ac].nmed005)
                  RETURNING l_amt1,l_amt2,l_amt3,l_amt4
               IF g_nmed_d[l_ac].nmed012 > l_amt1 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'anm-00353'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed012
            #add-point:ON CHANGE nmed012 name="input.g.page1.nmed012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed013
            #add-point:BEFORE FIELD nmed013 name="input.b.page1.nmed013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed013
            
            #add-point:AFTER FIELD nmed013 name="input.a.page1.nmed013"
            IF NOT cl_null(g_nmed_d[l_ac].nmed013) THEN
               IF g_nmed_d[l_ac].nmed001 = 'aapt420' THEN
                  LET l_type = '1'
               ELSE
                  LET l_type = '2'
               END IF
               CALL s_anmt461_amt(l_type,l_glaald,g_nmed_d[l_ac].nmed003,g_nmed_d[l_ac].nmed004,g_nmed_d[l_ac].nmed005)
                  RETURNING l_amt1,l_amt2,l_amt3,l_amt4
               IF g_nmed_d[l_ac].nmed013 > l_amt2 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'anm-00353'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed013
            #add-point:ON CHANGE nmed013 name="input.g.page1.nmed013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed002
            #add-point:BEFORE FIELD nmed002 name="input.b.page1.nmed002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed002
            
            #add-point:AFTER FIELD nmed002 name="input.a.page1.nmed002"
            IF g_nmck_m.nmck001 = 'AP' THEN 
                IF NOT cl_null(g_nmed_d[l_ac].nmed002) THEN 
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmed_d[l_ac].nmed001
                  LET g_chkparam.arg2 = g_nmed_d[l_ac].nmed002
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_apceseq") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                     LET l_n = 0
                     IF l_cmd = 'a' THEN 
                        SELECT COUNT(*) INTO l_n
                          FROM nmck_t,nmed_t
                         WHERE nmedent = g_enterprise
                           AND nmckent = nmedent
                           AND nmckcomp = nmedcomp
                           AND nmckdocno = nmeddocno
                           AND nmed001 = g_nmed_d[l_ac].nmed001
                           AND nmed002 = g_nmed_d[l_ac].nmed002
                           AND nmckstus <> 'X'
                     END IF
                     
                     IF l_cmd = 'u' THEN 
                        SELECT COUNT(*) INTO l_n
                          FROM nmck_t,nmed_t
                         WHERE nmedent = g_enterprise
                           AND nmckent = nmedent
                           AND nmckcomp = nmedcomp
                           AND nmckdocno = nmeddocno
                           AND nmed001 = g_nmed_d[l_ac].nmed001
                           AND nmed002 = g_nmed_d[l_ac].nmed002
                           AND nmckstus <> 'X'
                           AND nmckdocno = g_nmck_m.nmckdocno 
                           AND nmckcomp = g_nmck_m.nmckcomp
                           AND nmedseq <> g_nmed_d[l_ac].nmedseq
                     END IF
                        
                     IF l_n > 0 THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-00137'
                        LET g_errparam.extend = g_nmed_d[l_ac].nmed001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_nmed_d[l_ac].nmed002 = g_nmed_d_t.nmed002
                        NEXT FIELD CURRENT
                     END IF
                     
                     IF NOT cl_null(g_nmed_d[l_ac].nmed001) AND NOT cl_null(g_nmed_d[l_ac].nmed002) THEN 
                        LET l_n = 0
                        SELECT COUNT(*) INTO l_n
                          FROM apda_t
                          LEFT OUTER JOIN apce_t ON apdaent = apceent AND apdald = apceld AND apdadocno = apcedocno
                         WHERE apdaent = g_enterprise
                           AND apdadocno = g_nmed_d[l_ac].nmed001
                           AND apda001 = '40' 
                           AND apda005 = g_nmck_m.nmck005
                           AND apce006 = '20' 
                           AND apce100 = g_nmck_m.nmck100
                           AND apceorga = g_nmed_d[l_ac].nmedorga
                           AND apceseq = g_nmed_d[l_ac].nmed002
                        IF l_n = 0 THEN 
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'anm-00132'
                           LET g_errparam.extend = g_nmed_d[l_ac].nmed001
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           LET g_nmed_d[l_ac].nmed002 = g_nmed_d_t.nmed002
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_nmed_d[l_ac].nmed002 = g_nmed_d_t.nmed002
                     NEXT FIELD CURRENT
                  END IF
               
               
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed002
            #add-point:ON CHANGE nmed002 name="input.g.page1.nmed002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed007
            #add-point:BEFORE FIELD nmed007 name="input.b.page1.nmed007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed007
            
            #add-point:AFTER FIELD nmed007 name="input.a.page1.nmed007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed007
            #add-point:ON CHANGE nmed007 name="input.g.page1.nmed007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed008
            #add-point:BEFORE FIELD nmed008 name="input.b.page1.nmed008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed008
            
            #add-point:AFTER FIELD nmed008 name="input.a.page1.nmed008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed008
            #add-point:ON CHANGE nmed008 name="input.g.page1.nmed008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed009
            #add-point:BEFORE FIELD nmed009 name="input.b.page1.nmed009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed009
            
            #add-point:AFTER FIELD nmed009 name="input.a.page1.nmed009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed009
            #add-point:ON CHANGE nmed009 name="input.g.page1.nmed009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed010
            #add-point:BEFORE FIELD nmed010 name="input.b.page1.nmed010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed010
            
            #add-point:AFTER FIELD nmed010 name="input.a.page1.nmed010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed010
            #add-point:ON CHANGE nmed010 name="input.g.page1.nmed010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed100
            #add-point:BEFORE FIELD nmed100 name="input.b.page1.nmed100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed100
            
            #add-point:AFTER FIELD nmed100 name="input.a.page1.nmed100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed100
            #add-point:ON CHANGE nmed100 name="input.g.page1.nmed100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed101
            #add-point:BEFORE FIELD nmed101 name="input.b.page1.nmed101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed101
            
            #add-point:AFTER FIELD nmed101 name="input.a.page1.nmed101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed101
            #add-point:ON CHANGE nmed101 name="input.g.page1.nmed101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed110
            #add-point:BEFORE FIELD nmed110 name="input.b.page1.nmed110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed110
            
            #add-point:AFTER FIELD nmed110 name="input.a.page1.nmed110"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed110
            #add-point:ON CHANGE nmed110 name="input.g.page1.nmed110"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmed111
            #add-point:BEFORE FIELD nmed111 name="input.b.page1.nmed111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmed111
            
            #add-point:AFTER FIELD nmed111 name="input.a.page1.nmed111"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmed111
            #add-point:ON CHANGE nmed111 name="input.g.page1.nmed111"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmedseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmedseq
            #add-point:ON ACTION controlp INFIELD nmedseq name="input.c.page1.nmedseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed001
            #add-point:ON ACTION controlp INFIELD nmed001 name="input.c.page1.nmed001"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmedorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmedorga
            #add-point:ON ACTION controlp INFIELD nmedorga name="input.c.page1.nmedorga"
            #160930-00013#1 mark s---
            ##取得帳務組織下所屬成員
            #CALL s_fin_account_center_sons_query('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt,'1')
            #CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            ##將取回的字串轉換為SQL條件
            #CALL anmt461_change_to_sql(l_origin_str) RETURNING l_origin_str
            #160930-00013#1 mark e---
            #來源組織
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmed_d[l_ac].nmedorga
            #160930-00013#1  mod s---
            LET g_qryparam.where = "ooef001 IN (",l_origin_str, ") AND ooef017 ='",g_nmck_m.nmckcomp,"' "
            CALL s_fin_get_wc_str(g_site_wc) RETURNING l_origin_str
            LET g_qryparam.where = "ooef017 ='",g_nmck_m.nmckcomp,"' AND ooef001 IN ",l_origin_str CLIPPED
            #160930-00013#1  mod e---
            LET g_qryparam.where = g_qryparam.where," AND ooef201 = 'Y'"  #161021-00050#9
            CALL q_ooef001()
            LET g_nmed_d[l_ac].nmedorga = g_qryparam.return1
            DISPLAY g_nmed_d[l_ac].nmedorga TO nmedorga
            NEXT FIELD nmedorga
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed003
            #add-point:ON ACTION controlp INFIELD nmed003 name="input.c.page1.nmed003"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmed_d[l_ac].nmed003             #給予default值
            IF NOT cl_null(g_nmed_d[l_ac].nmed001) AND NOT cl_null(g_nmed_d[l_ac].nmedorga) THEN
               CASE
                  WHEN g_nmed_d[l_ac].nmed001 = 'aapt420'
                    #給予arg
                    LET g_qryparam.arg1 = g_nmck_m.nmck100
                    LET g_qryparam.arg2 = g_nmed_d[l_ac].nmedorga
                    CALL q_apdedocno()
                  OTHERWISE
                    SELECT glaald INTO l_glaald FROM glaa_t
                     WHERE glaaent = g_enterprise AND glaa014 = 'Y'
                       AND glaacomp = g_nmck_m.nmckcomp
                    #給予arg
                    LET g_qryparam.arg1 = g_nmed_d[l_ac].nmed001
                    LET g_qryparam.arg2 = l_glaald
                    LET g_qryparam.arg3 = g_nmed_d[l_ac].nmedorga
                    LET g_qryparam.arg4 = g_nmck_m.nmck100
                    CALL q_apccdocno()
               END CASE
               LET g_nmed_d[l_ac].nmed003 = g_qryparam.return1
               LET g_nmed_d[l_ac].nmed004 = g_qryparam.return2
               LET g_nmed_d[l_ac].nmed005 = g_qryparam.return3
               IF NOT cl_null(g_nmed_d[l_ac].nmed003) AND NOT cl_null(g_nmed_d[l_ac].nmed004) THEN
                  CALL anmt461_source_chk(g_nmed_d[l_ac].nmed003,g_nmed_d[l_ac].nmed004,g_nmed_d[l_ac].nmed005)
                     RETURNING l_success
               END IF
            END IF

            DISPLAY g_nmed_d[l_ac].nmed003,g_nmed_d[l_ac].nmed004,g_nmed_d[l_ac].nmed005 TO nmed003,nmed004,nmed005

            NEXT FIELD nmed003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed004
            #add-point:ON ACTION controlp INFIELD nmed004 name="input.c.page1.nmed004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed005
            #add-point:ON ACTION controlp INFIELD nmed005 name="input.c.page1.nmed005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed006
            #add-point:ON ACTION controlp INFIELD nmed006 name="input.c.page1.nmed006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed006_desc
            #add-point:ON ACTION controlp INFIELD nmed006_desc name="input.c.page1.nmed006_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed011
            #add-point:ON ACTION controlp INFIELD nmed011 name="input.c.page1.nmed011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed011_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed011_desc
            #add-point:ON ACTION controlp INFIELD nmed011_desc name="input.c.page1.nmed011_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed012
            #add-point:ON ACTION controlp INFIELD nmed012 name="input.c.page1.nmed012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed013
            #add-point:ON ACTION controlp INFIELD nmed013 name="input.c.page1.nmed013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed002
            #add-point:ON ACTION controlp INFIELD nmed002 name="input.c.page1.nmed002"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed007
            #add-point:ON ACTION controlp INFIELD nmed007 name="input.c.page1.nmed007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed008
            #add-point:ON ACTION controlp INFIELD nmed008 name="input.c.page1.nmed008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed009
            #add-point:ON ACTION controlp INFIELD nmed009 name="input.c.page1.nmed009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed010
            #add-point:ON ACTION controlp INFIELD nmed010 name="input.c.page1.nmed010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed100
            #add-point:ON ACTION controlp INFIELD nmed100 name="input.c.page1.nmed100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed101
            #add-point:ON ACTION controlp INFIELD nmed101 name="input.c.page1.nmed101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed110
            #add-point:ON ACTION controlp INFIELD nmed110 name="input.c.page1.nmed110"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmed111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmed111
            #add-point:ON ACTION controlp INFIELD nmed111 name="input.c.page1.nmed111"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmed_d[l_ac].* = g_nmed_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt461_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_nmed_d[l_ac].nmedseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_nmed_d[l_ac].* = g_nmed_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL anmt461_nmed_t_mask_restore('restore_mask_o')
      
               UPDATE nmed_t SET (nmedcomp,nmeddocno,nmedseq,nmed001,nmedorga,nmed003,nmed004,nmed005, 
                   nmed006,nmed011,nmed012,nmed013,nmed002,nmed007,nmed008,nmed009,nmed010,nmed100,nmed101, 
                   nmed110,nmed111) = (g_nmck_m.nmckcomp,g_nmck_m.nmckdocno,g_nmed_d[l_ac].nmedseq,g_nmed_d[l_ac].nmed001, 
                   g_nmed_d[l_ac].nmedorga,g_nmed_d[l_ac].nmed003,g_nmed_d[l_ac].nmed004,g_nmed_d[l_ac].nmed005, 
                   g_nmed_d[l_ac].nmed006,g_nmed_d[l_ac].nmed011,g_nmed_d[l_ac].nmed012,g_nmed_d[l_ac].nmed013, 
                   g_nmed_d[l_ac].nmed002,g_nmed_d[l_ac].nmed007,g_nmed_d[l_ac].nmed008,g_nmed_d[l_ac].nmed009, 
                   g_nmed_d[l_ac].nmed010,g_nmed_d[l_ac].nmed100,g_nmed_d[l_ac].nmed101,g_nmed_d[l_ac].nmed110, 
                   g_nmed_d[l_ac].nmed111)
                WHERE nmedent = g_enterprise AND nmedcomp = g_nmck_m.nmckcomp 
                  AND nmeddocno = g_nmck_m.nmckdocno 
 
                  AND nmedseq = g_nmed_d_t.nmedseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmed_d[l_ac].* = g_nmed_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmed_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmed_d[l_ac].* = g_nmed_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmed_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmck_m.nmckcomp
               LET gs_keys_bak[1] = g_nmckcomp_t
               LET gs_keys[2] = g_nmck_m.nmckdocno
               LET gs_keys_bak[2] = g_nmckdocno_t
               LET gs_keys[3] = g_nmed_d[g_detail_idx].nmedseq
               LET gs_keys_bak[3] = g_nmed_d_t.nmedseq
               CALL anmt461_update_b('nmed_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL anmt461_nmed_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_nmed_d[g_detail_idx].nmedseq = g_nmed_d_t.nmedseq 
 
                  ) THEN
                  LET gs_keys[01] = g_nmck_m.nmckcomp
                  LET gs_keys[gs_keys.getLength()+1] = g_nmck_m.nmckdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_nmed_d_t.nmedseq
 
                  CALL anmt461_key_update_b(gs_keys,'nmed_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmck_m),util.JSON.stringify(g_nmed_d_t)
               LET g_log2 = util.JSON.stringify(g_nmck_m),util.JSON.stringify(g_nmed_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL anmt461_unlock_b("nmed_t","'1'")
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
               LET g_nmed_d[li_reproduce_target].* = g_nmed_d[li_reproduce].*
 
               LET g_nmed_d[li_reproduce_target].nmedseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmed_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmed_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_nmed2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmed2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt461_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_nmed2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmed2_d[l_ac].* TO NULL 
            INITIALIZE g_nmed2_d_t.* TO NULL 
            INITIALIZE g_nmed2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_nmed2_d[l_ac].nmcm002 = "0"
      LET g_nmed2_d[l_ac].nmcm003 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_nmed2_d_t.* = g_nmed2_d[l_ac].*     #新輸入資料
            LET g_nmed2_d_o.* = g_nmed2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt461_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt461_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmed2_d[li_reproduce_target].* = g_nmed2_d[li_reproduce].*
 
               LET g_nmed2_d[li_reproduce_target].nmcmseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            IF l_cmd = 'a' THEN 
               IF cl_null(g_nmed2_d[g_detail_idx].nmcmseq) THEN 
                  SELECT MAX(nmcmseq) INTO g_nmed2_d[g_detail_idx].nmcmseq
                    FROM nmcm_t
                   WHERE nmcment = g_enterprise
                     AND nmcmcomp = g_nmck_m.nmckcomp
                     AND nmcmdocno = g_nmck_m.nmckdocno
                     
                  IF cl_null(g_nmed2_d[g_detail_idx].nmcmseq) THEN 
                     LET g_nmed2_d[g_detail_idx].nmcmseq = 1
                  ELSE
                     LET g_nmed2_d[g_detail_idx].nmcmseq = g_nmed2_d[g_detail_idx].nmcmseq + 1
                  END IF
               END IF
            END IF
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
            OPEN anmt461_cl USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt461_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt461_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmed2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmed2_d[l_ac].nmcmseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_nmed2_d_t.* = g_nmed2_d[l_ac].*  #BACKUP
               LET g_nmed2_d_o.* = g_nmed2_d[l_ac].*  #BACKUP
               CALL anmt461_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL anmt461_set_no_entry_b(l_cmd)
               IF NOT anmt461_lock_b("nmcm_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt461_bcl2 INTO g_nmed2_d[l_ac].nmcmseq,g_nmed2_d[l_ac].nmcm001,g_nmed2_d[l_ac].nmcm002, 
                      g_nmed2_d[l_ac].nmcm003,g_nmed2_d[l_ac].nmcm004,g_nmed2_d[l_ac].nmcm005
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmed2_d_mask_o[l_ac].* =  g_nmed2_d[l_ac].*
                  CALL anmt461_nmcm_t_mask()
                  LET g_nmed2_d_mask_n[l_ac].* =  g_nmed2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt461_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            
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
               LET gs_keys[01] = g_nmck_m.nmckcomp
               LET gs_keys[gs_keys.getLength()+1] = g_nmck_m.nmckdocno
               LET gs_keys[gs_keys.getLength()+1] = g_nmed2_d_t.nmcmseq
            
               #刪除同層單身
               IF NOT anmt461_delete_b('nmcm_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt461_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt461_key_delete_b(gs_keys,'nmcm_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt461_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt461_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_nmed_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmed2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM nmcm_t 
             WHERE nmcment = g_enterprise AND nmcmcomp = g_nmck_m.nmckcomp
               AND nmcmdocno = g_nmck_m.nmckdocno
               AND nmcmseq = g_nmed2_d[l_ac].nmcmseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmck_m.nmckcomp
               LET gs_keys[2] = g_nmck_m.nmckdocno
               LET gs_keys[3] = g_nmed2_d[g_detail_idx].nmcmseq
               CALL anmt461_insert_b('nmcm_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_nmed_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "nmcm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt461_b_fill()
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
               LET g_nmed2_d[l_ac].* = g_nmed2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt461_bcl2
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
               LET g_nmed2_d[l_ac].* = g_nmed2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL anmt461_nmcm_t_mask_restore('restore_mask_o')
                              
               UPDATE nmcm_t SET (nmcmcomp,nmcmdocno,nmcmseq,nmcm001,nmcm002,nmcm003,nmcm004,nmcm005) = (g_nmck_m.nmckcomp, 
                   g_nmck_m.nmckdocno,g_nmed2_d[l_ac].nmcmseq,g_nmed2_d[l_ac].nmcm001,g_nmed2_d[l_ac].nmcm002, 
                   g_nmed2_d[l_ac].nmcm003,g_nmed2_d[l_ac].nmcm004,g_nmed2_d[l_ac].nmcm005) #自訂欄位頁簽 
 
                WHERE nmcment = g_enterprise AND nmcmcomp = g_nmck_m.nmckcomp
                  AND nmcmdocno = g_nmck_m.nmckdocno
                  AND nmcmseq = g_nmed2_d_t.nmcmseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmed2_d[l_ac].* = g_nmed2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmcm_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmed2_d[l_ac].* = g_nmed2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmcm_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmck_m.nmckcomp
               LET gs_keys_bak[1] = g_nmckcomp_t
               LET gs_keys[2] = g_nmck_m.nmckdocno
               LET gs_keys_bak[2] = g_nmckdocno_t
               LET gs_keys[3] = g_nmed2_d[g_detail_idx].nmcmseq
               LET gs_keys_bak[3] = g_nmed2_d_t.nmcmseq
               CALL anmt461_update_b('nmcm_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt461_nmcm_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_nmed2_d[g_detail_idx].nmcmseq = g_nmed2_d_t.nmcmseq 
                  ) THEN
                  LET gs_keys[01] = g_nmck_m.nmckcomp
                  LET gs_keys[gs_keys.getLength()+1] = g_nmck_m.nmckdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_nmed2_d_t.nmcmseq
                  CALL anmt461_key_update_b(gs_keys,'nmcm_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmck_m),util.JSON.stringify(g_nmed2_d_t)
               LET g_log2 = util.JSON.stringify(g_nmck_m),util.JSON.stringify(g_nmed2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcmseq
            #add-point:BEFORE FIELD nmcmseq name="input.b.page2.nmcmseq"
            IF cl_null(g_nmed2_d[g_detail_idx].nmcmseq) THEN 
               SELECT MAX(nmcmseq) INTO g_nmed2_d[g_detail_idx].nmcmseq
                 FROM nmcm_t
                WHERE nmcment = g_enterprise
                  AND nmcmcomp = g_nmck_m.nmckcomp
                  AND nmcmdocno = g_nmck_m.nmckdocno
                  
               IF cl_null(g_nmed2_d[g_detail_idx].nmcmseq) THEN 
                  LET g_nmed2_d[g_detail_idx].nmcmseq = 1
               ELSE
                  LET g_nmed2_d[g_detail_idx].nmcmseq = g_nmed2_d[g_detail_idx].nmcmseq + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcmseq
            
            #add-point:AFTER FIELD nmcmseq name="input.a.page2.nmcmseq"
            #此段落由子樣板a05產生
            IF  g_nmck_m.nmckcomp IS NOT NULL AND g_nmck_m.nmckdocno IS NOT NULL AND g_nmed2_d[g_detail_idx].nmcmseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmck_m.nmckcomp != g_nmckcomp_t OR g_nmck_m.nmckdocno != g_nmckdocno_t OR g_nmed2_d[g_detail_idx].nmcmseq != g_nmed2_d_t.nmcmseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmcm_t WHERE "||"nmcment = '" ||g_enterprise|| "' AND "||"nmcmcomp = '"||g_nmck_m.nmckcomp ||"' AND "|| "nmcmdocno = '"||g_nmck_m.nmckdocno ||"' AND "|| "nmcmseq = '"||g_nmed2_d[g_detail_idx].nmcmseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcmseq
            #add-point:ON CHANGE nmcmseq name="input.g.page2.nmcmseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm001
            
            #add-point:AFTER FIELD nmcm001 name="input.a.page2.nmcm001"
            IF NOT cl_null(g_nmed2_d[l_ac].nmcm001) THEN 
               CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmed2_d[l_ac].nmcm001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3113") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  SELECT glab007 INTO g_nmed2_d[l_ac].nmcm004
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld = l_glaald
                     AND glab001 = '11'
                     AND glab002 = '3113'
                     AND glab003 = g_nmed2_d[l_ac].nmcm001
                  DISPLAY g_nmed2_d[l_ac].nmcm004 TO s_detail2[l_ac].nmcm004
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmed2_d[l_ac].nmcm001 = g_nmed2_d_t.nmcm001
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm001
            #add-point:BEFORE FIELD nmcm001 name="input.b.page2.nmcm001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcm001
            #add-point:ON CHANGE nmcm001 name="input.g.page2.nmcm001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm001_desc
            
            #add-point:AFTER FIELD nmcm001_desc name="input.a.page2.nmcm001_desc"
            LET g_nmed2_d[l_ac].nmcm001 = g_nmed2_d[l_ac].nmcm001_desc
            IF cl_null(g_nmed2_d[l_ac].nmcm001_desc) THEN 
               NEXT FIELD nmcm001_desc
            END IF
            IF NOT cl_null(g_nmed2_d[l_ac].nmcm001_desc) THEN 
               LET l_glaald = ''   #160822-00012#5   add
               CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmed2_d[l_ac].nmcm001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3113") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #IF p_cmd = 'a' OR (p_cmd = 'u' AND g_nmed2_d[l_ac].nmcm001 <> g_nmed2_d_t.nmcm001) THEN   #160822-00012#5   mark
                  IF g_nmed2_d[l_ac].nmcm001 != g_nmed2_d_o.nmcm001 OR cl_null(g_nmed2_d_o.nmcm001) THEN     #160822-00012#5   add
                     LET g_nmed2_d[l_ac].nmcm004 = ''   #160822-00012#5   add
                     SELECT glab007 INTO g_nmed2_d[l_ac].nmcm004
                       FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld = l_glaald
                        AND glab001 = '11'
                        AND glab002 = '3113'
                        AND glab003 = g_nmed2_d[l_ac].nmcm001
                     DISPLAY g_nmed2_d[l_ac].nmcm004 TO s_detail2[l_ac].nmcm004
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  #LET g_nmed2_d[l_ac].nmcm001 = g_nmed2_d_t.nmcm001             #160822-00012#5   mark
                  LET g_nmed2_d[l_ac].nmcm001 = g_nmed2_d_o.nmcm001              #160822-00012#5   add
                  #LET g_nmed2_d[l_ac].nmcm001_desc = g_nmed2_d_t.nmcm001_desc   #160822-00012#5   mark
                  LET g_nmed2_d[l_ac].nmcm001_desc = g_nmed2_d_o.nmcm001_desc    #160822-00012#5   add
                  CALL anmt461_ref_b2()
                  NEXT FIELD CURRENT
               END IF 
            END IF 
            CALL anmt461_ref_b2()
            LET g_nmed2_d_o.* = g_nmed2_d[l_ac].*    #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm001_desc
            #add-point:BEFORE FIELD nmcm001_desc name="input.b.page2.nmcm001_desc"
            LET g_nmed2_d[l_ac].nmcm001_desc = g_nmed2_d[l_ac].nmcm001
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcm001_desc
            #add-point:ON CHANGE nmcm001_desc name="input.g.page2.nmcm001_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm002
            #add-point:BEFORE FIELD nmcm002 name="input.b.page2.nmcm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm002
            
            #add-point:AFTER FIELD nmcm002 name="input.a.page2.nmcm002"
            IF NOT cl_null(g_nmed2_d[l_ac].nmcm002) THEN 
               LET g_nmed2_d[l_ac].nmcm003 = g_nmed2_d[l_ac].nmcm002 * g_nmck_m.nmck101
               DISPLAY g_nmed2_d[l_ac].nmcm003 TO s_detail2[l_ac].nmcm003
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcm002
            #add-point:ON CHANGE nmcm002 name="input.g.page2.nmcm002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm003
            #add-point:BEFORE FIELD nmcm003 name="input.b.page2.nmcm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm003
            
            #add-point:AFTER FIELD nmcm003 name="input.a.page2.nmcm003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcm003
            #add-point:ON CHANGE nmcm003 name="input.g.page2.nmcm003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm004
            
            #add-point:AFTER FIELD nmcm004 name="input.a.page2.nmcm004"
            IF NOT cl_null(g_nmed2_d[l_ac].nmcm004) THEN 
               CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
               CALL s_ld_sel_glaa(l_glaald,'glaa004') RETURNING l_success,l_glaa004
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = l_glaa004
               LET g_chkparam.arg2 = g_nmed2_d[l_ac].nmcm004
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmed2_d[l_ac].nmcm004 = g_nmed2_d_t.nmcm004
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm004
            #add-point:BEFORE FIELD nmcm004 name="input.b.page2.nmcm004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcm004
            #add-point:ON CHANGE nmcm004 name="input.g.page2.nmcm004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm004_desc
            
            #add-point:AFTER FIELD nmcm004_desc name="input.a.page2.nmcm004_desc"
            LET g_nmed2_d[l_ac].nmcm004 = g_nmed2_d[l_ac].nmcm004_desc
            IF NOT cl_null(g_nmed2_d[l_ac].nmcm004_desc) THEN 
            
               # 开窗模糊查询 150916-00015#1 --add 
               SELECT glaa004,glaald INTO l_glaa004,l_glaald
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp  =g_nmck_m.nmckcomp
                  AND glaa014='Y'                  
               IF s_aglt310_getlike_lc_subject(l_glaald,g_nmed2_d[l_ac].nmcm004_desc,"")  THEN            
                                 
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_nmed2_d[l_ac].nmcm004_desc
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_nmed2_d[l_ac].nmcm004_desc
                  LET g_qryparam.arg3 = l_glaald
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET g_nmed2_d[l_ac].nmcm004 = g_qryparam.return1              
                  CALL anmt461_ref_b2()
                  DISPLAY g_nmed2_d[l_ac].nmcm004_desc TO nmcm004_desc                           
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(l_glaald,g_nmed2_d[l_ac].nmcm004,'N') THEN
                  LET g_nmed2_d[l_ac].nmcm004 = g_nmed2_d_t.nmcm004
                  LET g_nmed2_d[l_ac].nmcm004_desc = g_nmed2_d_t.nmcm004_desc
                  CALL anmt461_ref_b2()
                  NEXT FIELD CURRENT
               END IF
               # 150916-00015#1 --end
               
#               CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
#               CALL s_ld_sel_glaa(l_glaald,'glaa004') RETURNING l_success,l_glaa004
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = l_glaa004
#               LET g_chkparam.arg2 = g_nmed2_d[l_ac].nmcm004
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_glac002_3") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_nmed2_d[l_ac].nmcm004 = g_nmed2_d_t.nmcm004
#                  LET g_nmed2_d[l_ac].nmcm004_desc = g_nmed2_d_t.nmcm004_desc
#                  CALL anmt461_ref_b2()
#                  NEXT FIELD CURRENT
#               END IF
            END IF 
            CALL anmt461_ref_b2()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm004_desc
            #add-point:BEFORE FIELD nmcm004_desc name="input.b.page2.nmcm004_desc"
            LET g_nmed2_d[l_ac].nmcm004_desc = g_nmed2_d[l_ac].nmcm004
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcm004_desc
            #add-point:ON CHANGE nmcm004_desc name="input.g.page2.nmcm004_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm005
            
            #add-point:AFTER FIELD nmcm005 name="input.a.page2.nmcm005"
            IF NOT cl_null(g_nmed2_d[l_ac].nmcm005) THEN 
               CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
               CALL s_ld_sel_glaa(l_glaald,'glaa005') RETURNING l_success,l_glaa005
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmed2_d[l_ac].nmcm005
               LET g_chkparam.arg2 = l_glaa005
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmai002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmed2_d[l_ac].nmcm005 = g_nmed2_d_t.nmcm005
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm005
            #add-point:BEFORE FIELD nmcm005 name="input.b.page2.nmcm005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcm005
            #add-point:ON CHANGE nmcm005 name="input.g.page2.nmcm005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcm005_desc
            
            #add-point:AFTER FIELD nmcm005_desc name="input.a.page2.nmcm005_desc"
            LET g_nmed2_d[l_ac].nmcm005 = g_nmed2_d[l_ac].nmcm005_desc
            IF NOT cl_null(g_nmed2_d[l_ac].nmcm005_desc) THEN 
               CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
               CALL s_ld_sel_glaa(l_glaald,'glaa005') RETURNING l_success,l_glaa005
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmed2_d[l_ac].nmcm005
               LET g_chkparam.arg2 = l_glaa005
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmai002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmed2_d[l_ac].nmcm005 = g_nmed2_d_t.nmcm005
                  LET g_nmed2_d[l_ac].nmcm005_desc = g_nmed2_d_t.nmcm005_desc
                  CALL anmt461_ref_b2()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL anmt461_ref_b2()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcm005_desc
            #add-point:BEFORE FIELD nmcm005_desc name="input.b.page2.nmcm005_desc"
            LET g_nmed2_d[l_ac].nmcm005_desc = g_nmed2_d[l_ac].nmcm005
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcm005_desc
            #add-point:ON CHANGE nmcm005_desc name="input.g.page2.nmcm005_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.nmcmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcmseq
            #add-point:ON ACTION controlp INFIELD nmcmseq name="input.c.page2.nmcmseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmcm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm001
            #add-point:ON ACTION controlp INFIELD nmcm001 name="input.c.page2.nmcm001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmed2_d[l_ac].nmcm001             #給予default值
            LET g_qryparam.where = " oocq015 = 'Y'"
            #給予arg
            LET g_qryparam.arg1 = '3113' #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_nmed2_d[l_ac].nmcm001 = g_qryparam.return1              
            #LET g_nmed2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_nmed2_d[l_ac].nmcm001 TO nmcm001              #
            #DISPLAY g_nmed2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD nmcm001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmcm001_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm001_desc
            #add-point:ON ACTION controlp INFIELD nmcm001_desc name="input.c.page2.nmcm001_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmed2_d[l_ac].nmcm001           #給予default值
            LET g_qryparam.default2 = "" #g_nmed2_d[l_ac].oocq002 #應用分類碼
            LET g_qryparam.where = " oocq015 = 'Y'"
            #給予arg
            LET g_qryparam.arg1 = '3113'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_nmed2_d[l_ac].nmcm001 = g_qryparam.return1              
            CALL anmt461_ref_b2()
            DISPLAY g_nmed2_d[l_ac].nmcm001_desc TO nmcm001_desc              #
            #DISPLAY g_nmed2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD nmcm001_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmcm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm002
            #add-point:ON ACTION controlp INFIELD nmcm002 name="input.c.page2.nmcm002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmcm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm003
            #add-point:ON ACTION controlp INFIELD nmcm003 name="input.c.page2.nmcm003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmcm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm004
            #add-point:ON ACTION controlp INFIELD nmcm004 name="input.c.page2.nmcm004"
            CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
            CALL s_ld_sel_glaa(l_glaald,'glaa004') RETURNING l_success,l_glaa004          
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmed2_d[l_ac].nmcm004             #給予default值
            LET g_qryparam.where = " glac001 = '",l_glaa004,"' AND glac003 <> '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",l_glaald,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            #給予arg

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_nmed2_d[l_ac].nmcm004 = g_qryparam.return1              

            DISPLAY g_nmed2_d[l_ac].nmcm004 TO nmcm004              #

            NEXT FIELD nmcm004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmcm004_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm004_desc
            #add-point:ON ACTION controlp INFIELD nmcm004_desc name="input.c.page2.nmcm004_desc"
            CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
            CALL s_ld_sel_glaa(l_glaald,'glaa004') RETURNING l_success,l_glaa004    
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmed2_d[l_ac].nmcm004             #給予default值
            LET g_qryparam.where = " glac001 = '",l_glaa004,"' AND glac003 <> '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",l_glaald,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            #給予arg
            
            CALL aglt310_04()                                #呼叫開窗

            LET g_nmed2_d[l_ac].nmcm004 = g_qryparam.return1              
            CALL anmt461_ref_b2()
            DISPLAY g_nmed2_d[l_ac].nmcm004_desc TO nmcm004_desc              #

            NEXT FIELD nmcm004_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmcm005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm005
            #add-point:ON ACTION controlp INFIELD nmcm005 name="input.c.page2.nmcm005"
            CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
            CALL s_ld_sel_glaa(l_glaald,'glaa005') RETURNING l_success,l_glaa005         
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmed2_d[l_ac].nmcm005             #給予default值
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"'"
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_nmai002()                                #呼叫開窗

            LET g_nmed2_d[l_ac].nmcm005 = g_qryparam.return1              

            DISPLAY g_nmed2_d[l_ac].nmcm005 TO nmcm005              #

            NEXT FIELD nmcm005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmcm005_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcm005_desc
            #add-point:ON ACTION controlp INFIELD nmcm005_desc name="input.c.page2.nmcm005_desc"
            CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
            CALL s_ld_sel_glaa(l_glaald,'glaa005') RETURNING l_success,l_glaa005
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmed2_d[l_ac].nmcm005             #給予default值
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"'"
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_nmai002()                                #呼叫開窗

            LET g_nmed2_d[l_ac].nmcm005 = g_qryparam.return1              
            CALL anmt461_ref_b2()
            DISPLAY g_nmed2_d[l_ac].nmcm005_desc TO nmcm005_desc              #

            NEXT FIELD nmcm005_desc                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmed2_d[l_ac].* = g_nmed2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt461_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL anmt461_unlock_b("nmcm_t","'2'")
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
               LET g_nmed2_d[li_reproduce_target].* = g_nmed2_d[li_reproduce].*
 
               LET g_nmed2_d[li_reproduce_target].nmcmseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmed2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmed2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="anmt461.input.other" >}
      
      #add-point:自定義input name="input.more_input"
 
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD nmckcomp
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmedseq
               WHEN "s_detail2"
                  NEXT FIELD nmcmseq
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               OTHERWISE
                  NEXT FIELD nmedseq
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
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
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   IF NOT INT_FLAG THEN
      CALL anmt461_upd_nmck() RETURNING l_success
   END IF
   CALL anmt461_set_label_scc('')
   #151125-00006#3---S
   IF NOT INT_FLAG THEN
      CALL anmt461_immediately_conf()
   END IF
   #151125-00006#3---E
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="anmt461.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION anmt461_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_nmas001      LIKE nmas_t.nmas001
   DEFINE l_pmaa004      LIKE pmaa_t.pmaa004
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   IF g_nmck_m.nmckstus <> 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)   
   ELSE
      CALL cl_set_act_visible("modify,delete", TRUE)  
   END IF

   SELECT nmas001 INTO l_nmas001 FROM nmas_t
    WHERE nmasent = g_enterprise
      AND nmas002 = g_nmck_m.nmck004
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_nmas001
   CALL ap_ref_array2(g_ref_fields,"SELECT nmaal003 FROM nmaal_t WHERE nmaalent='"||g_enterprise||"' AND nmaal001=? AND nmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck004_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmck004_desc TO nmck004_desc
   
   LET g_nmck_m.nmas003 = ''
   SELECT nmas003 INTO g_nmck_m.nmas003 
     FROM nmaa_t,nmas_t
    WHERE nmaaent = g_enterprise
      AND nmaaent = nmasent
      AND nmaa001 = nmas001
      AND nmas002 = g_nmck_m.nmck004 
      AND nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = g_enterprise
                                               AND ooef017 = g_nmck_m.nmckcomp)
   DISPLAY g_nmck_m.nmas003 TO nmas003
   
   SELECT pmaa004 INTO l_pmaa004
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_nmck_m.nmck005
      
   IF l_pmaa004 <> '2' THEN 
      LET g_nmck_m.nmck006 = ''
   END IF
   #150813-00015#8--add--str--
   SELECT glaald INTO g_glaald FROM glaa_t
    WHERE glaaent = g_enterprise AND glaa014 = 'Y'
      AND glaacomp = g_nmck_m.nmckcomp
   #150813-00015#8--add--end
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL anmt461_b_fill() #單身填充
      CALL anmt461_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL anmt461_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
 
   #end add-point
   
   #遮罩相關處理
   LET g_nmck_m_mask_o.* =  g_nmck_m.*
   CALL anmt461_nmck_t_mask()
   LET g_nmck_m_mask_n.* =  g_nmck_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003,g_nmck_m.nmck003_desc,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
       g_nmck_m.nmck004,g_nmck_m.nmck004_desc,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017, 
       g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005,g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck040_desc, 
       g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041,g_nmck_m.nmck041_desc,g_nmck_m.nmck131, 
       g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042,g_nmck_m.nmck010, 
       g_nmck_m.nmck010_desc,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124, 
       g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckownid_desc, 
       g_nmck_m.nmckowndp,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtid_desc,g_nmck_m.nmckcrtdp, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckmoddt, 
       g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100, 
       g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103,g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck009_desc, 
       g_nmck_m.nmck101,g_nmck_m.nmck113
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmck_m.nmckstus 
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
   FOR l_ac = 1 TO g_nmed_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_nmed2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
 
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL anmt461_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION anmt461_detail_show()
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
 
{<section id="anmt461.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmt461_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE nmck_t.nmckcomp 
   DEFINE l_oldno     LIKE nmck_t.nmckcomp 
   DEFINE l_newno02     LIKE nmck_t.nmckdocno 
   DEFINE l_oldno02     LIKE nmck_t.nmckdocno 
 
   DEFINE l_master    RECORD LIKE nmck_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE nmed_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE nmcm_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_nmck_m.nmckcomp IS NULL
   OR g_nmck_m.nmckdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_nmckcomp_t = g_nmck_m.nmckcomp
   LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
    
   LET g_nmck_m.nmckcomp = ""
   LET g_nmck_m.nmckdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmck_m.nmckownid = g_user
      LET g_nmck_m.nmckowndp = g_dept
      LET g_nmck_m.nmckcrtid = g_user
      LET g_nmck_m.nmckcrtdp = g_dept 
      LET g_nmck_m.nmckcrtdt = cl_get_current()
      LET g_nmck_m.nmckmodid = g_user
      LET g_nmck_m.nmckmoddt = cl_get_current()
      LET g_nmck_m.nmckstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_nmck_m.nmck019 = ''   #160726-00020#13
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmck_m.nmckstus 
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
      LET g_nmck_m.nmckcomp_desc = ''
   DISPLAY BY NAME g_nmck_m.nmckcomp_desc
 
   
   CALL anmt461_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_nmck_m.* TO NULL
      INITIALIZE g_nmed_d TO NULL
      INITIALIZE g_nmed2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL anmt461_show()
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
   CALL anmt461_set_act_visible()   
   CALL anmt461_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmckcomp_t = g_nmck_m.nmckcomp
   LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmckent = " ||g_enterprise|| " AND",
                      " nmckcomp = '", g_nmck_m.nmckcomp, "' "
                      ," AND nmckdocno = '", g_nmck_m.nmckdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt461_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL anmt461_idx_chk()
   
   LET g_data_owner = g_nmck_m.nmckownid      
   LET g_data_dept  = g_nmck_m.nmckowndp
   
   #功能已完成,通報訊息中心
   CALL anmt461_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="anmt461.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION anmt461_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE nmed_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE nmcm_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE anmt461_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
 
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmed_t
    WHERE nmedent = g_enterprise AND nmedcomp = g_nmckcomp_t
     AND nmeddocno = g_nmckdocno_t
 
    INTO TEMP anmt461_detail
 
   #將key修正為調整後   
   UPDATE anmt461_detail 
      #更新key欄位
      SET nmedcomp = g_nmck_m.nmckcomp
          , nmeddocno = g_nmck_m.nmckdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO nmed_t SELECT * FROM anmt461_detail
   
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
   DROP TABLE anmt461_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmcm_t 
    WHERE nmcment = g_enterprise AND nmcmcomp = g_nmckcomp_t
      AND nmcmdocno = g_nmckdocno_t   
 
    INTO TEMP anmt461_detail
 
   #將key修正為調整後   
   UPDATE anmt461_detail SET nmcmcomp = g_nmck_m.nmckcomp
                                       , nmcmdocno = g_nmck_m.nmckdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO nmcm_t SELECT * FROM anmt461_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE anmt461_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_nmckcomp_t = g_nmck_m.nmckcomp
   LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt461_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_glaald        LIKE glaa_t.glaald
   DEFINE l_success        LIKE type_t.num5  #150813-00015#8 add
   DEFINE l_cnt            LIKE type_t.num5  #160122-00001#29 add
   DEFINE l_n              LIKE type_t.num5  #160122-00001#29 By 07900 --add
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_nmck_m.nmckcomp IS NULL
   OR g_nmck_m.nmckdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN anmt461_cl USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt461_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt461_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017,g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005, 
       g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041, 
       g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042, 
       g_nmck_m.nmck010,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124, 
       g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid, 
       g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid, 
       g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103, 
       g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT anmt461_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmck_m_mask_o.* =  g_nmck_m.*
   CALL anmt461_nmck_t_mask()
   LET g_nmck_m_mask_n.* =  g_nmck_m.*
   
   CALL anmt461_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #150813-00015#8--add--str--
   IF g_nmck_m.nmckstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = 'modify'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   CALL s_fin_date_close_chk('',g_nmck_m.nmckcomp,'ANM',g_nmck_m.nmckdocdt) RETURNING l_success
   IF l_success = FALSE THEN
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #150813-00015#8--add--end
   #160122-00001#29--add--str--
   #判断当前用户是否有权限操作改交易账号，有权限可以执行删除，反之，不可。
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM nmck_t
    WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp
      AND nmckdocno = g_nmck_m.nmckdocno
      AND (nmck004 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus ='Y')
          OR nmck004 IN( SELECT nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus ='Y')
          OR TRIM(nmck004) IS NULL)
   IF l_cnt =0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00574'
      LET g_errparam.extend = g_nmck_m.nmck004
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160122-00001#29--add--end
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt461_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
 
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_nmckcomp_t = g_nmck_m.nmckcomp
      LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
 
      DELETE FROM nmck_t
       WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp
         AND nmckdocno = g_nmck_m.nmckdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
     
      CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
      IF NOT s_aooi200_fin_del_docno(l_glaald,g_nmck_m.nmckdocno,g_nmck_m.nmckdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_nmck_m.nmckcomp,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
 
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM nmed_t
       WHERE nmedent = g_enterprise AND nmedcomp = g_nmck_m.nmckcomp
         AND nmeddocno = g_nmck_m.nmckdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmed_t:",SQLERRMESSAGE 
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
      DELETE FROM nmcm_t
       WHERE nmcment = g_enterprise AND
             nmcmcomp = g_nmck_m.nmckcomp AND nmcmdocno = g_nmck_m.nmckdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmcm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_nmck_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE anmt461_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_nmed_d.clear() 
      CALL g_nmed2_d.clear()       
 
     
      CALL anmt461_ui_browser_refresh()  
      #CALL anmt461_ui_headershow()  
      #CALL anmt461_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL anmt461_browser_fill("")
         CALL anmt461_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE anmt461_cl
 
   #功能已完成,通報訊息中心
   CALL anmt461_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="anmt461.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt461_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_nmed_d.clear()
   CALL g_nmed2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
   
   #判斷是否填充
   IF anmt461_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT nmedseq,nmed001,nmedorga,nmed003,nmed004,nmed005,nmed006,nmed011, 
             nmed012,nmed013,nmed002,nmed007,nmed008,nmed009,nmed010,nmed100,nmed101,nmed110,nmed111  FROM nmed_t", 
                
                     " INNER JOIN nmck_t ON nmckent = " ||g_enterprise|| " AND nmckcomp = nmedcomp ",
                     " AND nmckdocno = nmeddocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE nmedent=? AND nmedcomp=? AND nmeddocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY nmed_t.nmedseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt461_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR anmt461_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmed_d[l_ac].nmedseq, 
          g_nmed_d[l_ac].nmed001,g_nmed_d[l_ac].nmedorga,g_nmed_d[l_ac].nmed003,g_nmed_d[l_ac].nmed004, 
          g_nmed_d[l_ac].nmed005,g_nmed_d[l_ac].nmed006,g_nmed_d[l_ac].nmed011,g_nmed_d[l_ac].nmed012, 
          g_nmed_d[l_ac].nmed013,g_nmed_d[l_ac].nmed002,g_nmed_d[l_ac].nmed007,g_nmed_d[l_ac].nmed008, 
          g_nmed_d[l_ac].nmed009,g_nmed_d[l_ac].nmed010,g_nmed_d[l_ac].nmed100,g_nmed_d[l_ac].nmed101, 
          g_nmed_d[l_ac].nmed110,g_nmed_d[l_ac].nmed111   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL anmt461_nmed006_desc(g_nmed_d[l_ac].nmed006) RETURNING g_nmed_d[l_ac].nmed006_desc
         CALL anmt461_nmed011_desc(g_nmed_d[l_ac].nmed011) RETURNING g_nmed_d[l_ac].nmed011_desc
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
   IF anmt461_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT nmcmseq,nmcm001,nmcm002,nmcm003,nmcm004,nmcm005  FROM nmcm_t", 
                
                     " INNER JOIN  nmck_t ON nmckent = " ||g_enterprise|| " AND nmckcomp = nmcmcomp ",
                     " AND nmckdocno = nmcmdocno ",
 
                     "",
                     
                     
                     " WHERE nmcment=? AND nmcmcomp=? AND nmcmdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY nmcm_t.nmcmseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt461_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR anmt461_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmed2_d[l_ac].nmcmseq, 
          g_nmed2_d[l_ac].nmcm001,g_nmed2_d[l_ac].nmcm002,g_nmed2_d[l_ac].nmcm003,g_nmed2_d[l_ac].nmcm004, 
          g_nmed2_d[l_ac].nmcm005   #(ver:78)
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
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_nmed_d.deleteElement(g_nmed_d.getLength())
   CALL g_nmed2_d.deleteElement(g_nmed2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE anmt461_pb
   FREE anmt461_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmed_d.getLength()
      LET g_nmed_d_mask_o[l_ac].* =  g_nmed_d[l_ac].*
      CALL anmt461_nmed_t_mask()
      LET g_nmed_d_mask_n[l_ac].* =  g_nmed_d[l_ac].*
   END FOR
   
   LET g_nmed2_d_mask_o.* =  g_nmed2_d.*
   FOR l_ac = 1 TO g_nmed2_d.getLength()
      LET g_nmed2_d_mask_o[l_ac].* =  g_nmed2_d[l_ac].*
      CALL anmt461_nmcm_t_mask()
      LET g_nmed2_d_mask_n[l_ac].* =  g_nmed2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="anmt461.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt461_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM nmed_t
       WHERE nmedent = g_enterprise AND
         nmedcomp = ps_keys_bak[1] AND nmeddocno = ps_keys_bak[2] AND nmedseq = ps_keys_bak[3]
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
         CALL g_nmed_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM nmcm_t
       WHERE nmcment = g_enterprise AND
             nmcmcomp = ps_keys_bak[1] AND nmcmdocno = ps_keys_bak[2] AND nmcmseq = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmcm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_nmed2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt461_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO nmed_t
                  (nmedent,
                   nmedcomp,nmeddocno,
                   nmedseq
                   ,nmed001,nmedorga,nmed003,nmed004,nmed005,nmed006,nmed011,nmed012,nmed013,nmed002,nmed007,nmed008,nmed009,nmed010,nmed100,nmed101,nmed110,nmed111) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_nmed_d[g_detail_idx].nmed001,g_nmed_d[g_detail_idx].nmedorga,g_nmed_d[g_detail_idx].nmed003, 
                       g_nmed_d[g_detail_idx].nmed004,g_nmed_d[g_detail_idx].nmed005,g_nmed_d[g_detail_idx].nmed006, 
                       g_nmed_d[g_detail_idx].nmed011,g_nmed_d[g_detail_idx].nmed012,g_nmed_d[g_detail_idx].nmed013, 
                       g_nmed_d[g_detail_idx].nmed002,g_nmed_d[g_detail_idx].nmed007,g_nmed_d[g_detail_idx].nmed008, 
                       g_nmed_d[g_detail_idx].nmed009,g_nmed_d[g_detail_idx].nmed010,g_nmed_d[g_detail_idx].nmed100, 
                       g_nmed_d[g_detail_idx].nmed101,g_nmed_d[g_detail_idx].nmed110,g_nmed_d[g_detail_idx].nmed111) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmed_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_nmed_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO nmcm_t
                  (nmcment,
                   nmcmcomp,nmcmdocno,
                   nmcmseq
                   ,nmcm001,nmcm002,nmcm003,nmcm004,nmcm005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_nmed2_d[g_detail_idx].nmcm001,g_nmed2_d[g_detail_idx].nmcm002,g_nmed2_d[g_detail_idx].nmcm003, 
                       g_nmed2_d[g_detail_idx].nmcm004,g_nmed2_d[g_detail_idx].nmcm005)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmcm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_nmed2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt461_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "nmed_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL anmt461_nmed_t_mask_restore('restore_mask_o')
               
      UPDATE nmed_t 
         SET (nmedcomp,nmeddocno,
              nmedseq
              ,nmed001,nmedorga,nmed003,nmed004,nmed005,nmed006,nmed011,nmed012,nmed013,nmed002,nmed007,nmed008,nmed009,nmed010,nmed100,nmed101,nmed110,nmed111) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_nmed_d[g_detail_idx].nmed001,g_nmed_d[g_detail_idx].nmedorga,g_nmed_d[g_detail_idx].nmed003, 
                  g_nmed_d[g_detail_idx].nmed004,g_nmed_d[g_detail_idx].nmed005,g_nmed_d[g_detail_idx].nmed006, 
                  g_nmed_d[g_detail_idx].nmed011,g_nmed_d[g_detail_idx].nmed012,g_nmed_d[g_detail_idx].nmed013, 
                  g_nmed_d[g_detail_idx].nmed002,g_nmed_d[g_detail_idx].nmed007,g_nmed_d[g_detail_idx].nmed008, 
                  g_nmed_d[g_detail_idx].nmed009,g_nmed_d[g_detail_idx].nmed010,g_nmed_d[g_detail_idx].nmed100, 
                  g_nmed_d[g_detail_idx].nmed101,g_nmed_d[g_detail_idx].nmed110,g_nmed_d[g_detail_idx].nmed111)  
 
         WHERE nmedent = g_enterprise AND nmedcomp = ps_keys_bak[1] AND nmeddocno = ps_keys_bak[2] AND nmedseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmed_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmed_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL anmt461_nmed_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "nmcm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL anmt461_nmcm_t_mask_restore('restore_mask_o')
               
      UPDATE nmcm_t 
         SET (nmcmcomp,nmcmdocno,
              nmcmseq
              ,nmcm001,nmcm002,nmcm003,nmcm004,nmcm005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_nmed2_d[g_detail_idx].nmcm001,g_nmed2_d[g_detail_idx].nmcm002,g_nmed2_d[g_detail_idx].nmcm003, 
                  g_nmed2_d[g_detail_idx].nmcm004,g_nmed2_d[g_detail_idx].nmcm005) 
         WHERE nmcment = g_enterprise AND nmcmcomp = ps_keys_bak[1] AND nmcmdocno = ps_keys_bak[2] AND nmcmseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmcm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmcm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL anmt461_nmcm_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION anmt461_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt461.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION anmt461_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt461_lock_b(ps_table,ps_page)
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
   #CALL anmt461_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "nmed_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN anmt461_bcl USING g_enterprise,
                                       g_nmck_m.nmckcomp,g_nmck_m.nmckdocno,g_nmed_d[g_detail_idx].nmedseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt461_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "nmcm_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN anmt461_bcl2 USING g_enterprise,
                                             g_nmck_m.nmckcomp,g_nmck_m.nmckdocno,g_nmed2_d[g_detail_idx].nmcmseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt461_bcl2:",SQLERRMESSAGE 
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
 
{<section id="anmt461.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt461_unlock_b(ps_table,ps_page)
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
      CLOSE anmt461_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE anmt461_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="anmt461.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmt461_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("nmckdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("nmckcomp,nmckdocno",TRUE)
      CALL cl_set_comp_entry("nmckdocdt",TRUE)
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
 
{<section id="anmt461.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmt461_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success  LIKE type_t.num5  
   DEFINE l_slip     LIKE type_t.chr10
   DEFINE l_dfin0033  LIKE type_t.chr80
   DEFINE l_para_date LIKE type_t.dat   #150813-00015#8 add
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("nmckcomp,nmckdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("nmckdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("nmckdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #151130-00015#2 -begin -add by XZG 20151218
#   IF NOT cl_null(g_nmck_m.nmckdocno) THEN  #150813-00015#8 mark
   IF NOT cl_null(g_nmck_m.nmckdocno) AND p_cmd = 'u'  THEN  #150813-00015#8 add
      #获取单别
      CALL s_aooi200_fin_get_slip(g_nmck_m.nmckdocno) RETURNING l_success,l_slip
      #150813-00015#8--add--str--
      SELECT glaald INTO g_glaald FROM glaa_t
       WHERE glaaent = g_enterprise AND glaa014 = 'Y'
         AND glaacomp = g_nmck_m.nmckcomp
      #150813-00015#8--add--end
      #是否可改日期
      CALL s_fin_get_doc_para(g_glaald,g_nmck_m.nmckcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      #抓取关帐日期
      CALL cl_get_para(g_enterprise,g_nmck_m.nmckcomp,'S-FIN-4007') RETURNING l_para_date #150813-00015#8 add
#      IF l_dfin0033 = "N"  THEN  #150813-00015#8 mark
      IF l_dfin0033 = "N" AND g_nmck_m.nmckdocdt <= l_para_date THEN  #150813-00015#8 add
         CALL cl_set_comp_entry("nmckdocdt",FALSE)
      ELSE 
         CALL cl_set_comp_entry("nmckdocdt",TRUE)
      END IF          
   END IF 
   #151130-00015#2  -end
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt461.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt461_set_entry_b(p_cmd)
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
    CALL cl_set_comp_entry("nmed005",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="anmt461.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt461_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_count LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF l_ac > 0 THEN
      LET l_count = 0
      SELECT COUNT(*) INTO l_count FROM apda_t WHERE apdaent = g_enterprise
         AND apdadocno = g_nmed_d[l_ac].nmed003
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count > 0 THEN
         CALL cl_set_comp_entry("nmed005",FALSE)
      END IF
   END IF
   IF g_nmck_m.nmck001 = '1' THEN
      CALL cl_set_comp_entry("nmed005",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="anmt461.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION anmt461_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   IF g_nmck_m.nmckstus <> 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)   
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)  
   END IF

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION anmt461_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION anmt461_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION anmt461_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt461_default_search()
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
      LET ls_wc = ls_wc, " nmckcomp = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmckdocno = '", g_argv[02], "' AND "
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
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "nmck_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "nmed_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "nmcm_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
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
 
{<section id="anmt461.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION anmt461_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_nmed113     LIKE nmcl_t.nmcl113
   DEFINE l_nmed001     LIKE nmed_t.nmed001
   DEFINE l_nmed002     LIKE nmed_t.nmed002
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_today       DATETIME YEAR TO SECOND
   DEFINE l_efin5001    LIKE type_t.chr1
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   DEFINE l_glaald      LIKE glaa_t.glaald
   DEFINE l_cnt         LIKE type_t.num5  #160122-00001#29 add
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_nmck_m.nmckcomp IS NULL
      OR g_nmck_m.nmckdocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN anmt461_cl USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
   IF STATUS THEN
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt461_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE anmt461_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017,g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005, 
       g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041, 
       g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042, 
       g_nmck_m.nmck010,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124, 
       g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid, 
       g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid, 
       g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103, 
       g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT anmt461_action_chk() THEN
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003,g_nmck_m.nmck003_desc,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
       g_nmck_m.nmck004,g_nmck_m.nmck004_desc,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017, 
       g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005,g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck040_desc, 
       g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041,g_nmck_m.nmck041_desc,g_nmck_m.nmck131, 
       g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015,g_nmck_m.nmck042,g_nmck_m.nmck010, 
       g_nmck_m.nmck010_desc,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124, 
       g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckownid_desc, 
       g_nmck_m.nmckowndp,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtid_desc,g_nmck_m.nmckcrtdp, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckmoddt, 
       g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100, 
       g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103,g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck009_desc, 
       g_nmck_m.nmck101,g_nmck_m.nmck113
 
   CASE g_nmck_m.nmckstus
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
   #160122-00001#29--add--str--
   #判断当前用户是否有权限操作改交易账号，有权限可以执行删除，反之，不可。
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM nmck_t
    WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp
      AND nmckdocno = g_nmck_m.nmckdocno
      AND (nmck004 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus ='Y') #160122-00001#29 by 07900 --mod
          OR nmck004 IN( SELECT nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus ='Y')
          OR TRIM(nmck004) IS NULL)
   IF l_cnt =0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00574'
      LET g_errparam.extend = g_nmck_m.nmck004
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160122-00001#29--add--end
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_nmck_m.nmckstus
            
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
      #CALL cl_showmsg_init()
      #151013-00016#7 151104 by sakura add(S)
	   CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",TRUE)
      #無條件關結案
      CALL cl_set_act_visible("closed",FALSE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)

      CASE g_nmck_m.nmckstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold,unhold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",FALSE)
            CLOSE anmt461_cl                #150813-00015#8 add
            CALL s_transaction_end('N','0') #150813-00015#8 add
            RETURN
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unhold",FALSE)

         WHEN "H"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)

          #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"
            CALL cl_set_act_visible("confirmed ",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold,unhold",FALSE)

         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed,hold,unhold",FALSE)

         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",FALSE)
      END CASE
	   #151013-00016#7 151104 by sakura add(E)      
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT anmt461_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt461_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT anmt461_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt461_cl
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
            #151013-00016#7 151104 by sakura mark(S)
            ##150602-00057#2 by 02291 add
            #SELECT glaald INTO l_glaald FROM glaa_t
            # WHERE glaaent = g_enterprise AND glaacomp = g_nmck_m.nmckcomp
            #   AND glaa014 = 'Y'
            #CALL s_aooi200_fin_get_slip(g_nmck_m.nmckdocno) RETURNING l_success,l_ooba002
            #CALL s_fin_chk_E5001(l_glaald,g_nmck_m.nmckcomp,l_ooba002) RETURNING l_efin5001
            #IF l_efin5001 = 'N' THEN
            #   IF g_nmck_m.nmckcrtid = g_user THEN
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = 'axr-00346'
            #      LET g_errparam.extend = ''
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #      CALL s_transaction_end('N','0')
            #      CLOSE anmt461_cl
            #      RETURN
            #   END IF
            #END IF   
            ##150602-00057#2 by 02291 add
            #151013-00016#7 151104 by sakura mark(E)
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
      g_nmck_m.nmckstus = lc_state OR cl_null(lc_state) THEN
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151013-00016#7 151104 by sakura add(S)
   CALL cl_err_collect_init()
   #確認
   IF lc_state = 'Y' THEN
      IF g_nmck_m.nmckstus = 'N' THEN
         CALL s_anmt461_conf_chk(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_anmt461_conf_upd(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                  CALL cl_err_collect_show()
               END IF
            END IF
         END IF
      END IF  
   END IF  
   #取消確認
   IF lc_state = 'N' THEN
      CALL s_anmt461_unconf_chk(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_anmt461_unconf_upd(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #作廢
   IF lc_state = 'X' THEN
      CALL s_anmt461_invalid_chk(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN   #是否執行作廢？
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_anmt461_invalid_upd(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF   
   #151013-00016#7 151104 by sakura add(E)
   #end add-point
   
   LET g_nmck_m.nmckmodid = g_user
   LET g_nmck_m.nmckmoddt = cl_get_current()
   LET g_nmck_m.nmckstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE nmck_t 
      SET (nmckstus,nmckmodid,nmckmoddt) 
        = (g_nmck_m.nmckstus,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt)     
    WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp
      AND nmckdocno = g_nmck_m.nmckdocno
    
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
      EXECUTE anmt461_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
          g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
          g_nmck_m.nmck004,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck017,g_nmck_m.nmck018,g_nmck_m.nmck121, 
          g_nmck_m.nmck005,g_nmck_m.nmck037,g_nmck_m.nmck040,g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038, 
          g_nmck_m.nmck041,g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133,g_nmck_m.nmck015, 
          g_nmck_m.nmck042,g_nmck_m.nmck010,g_nmck_m.nmck016,g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011, 
          g_nmck_m.nmck124,g_nmck_m.nmck023,g_nmck_m.nmck134,g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckowndp, 
          g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt, 
          g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008, 
          g_nmck_m.nmck103,g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmcksite_desc, 
          g_nmck_m.nmckcomp_desc,g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc, 
          g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc,g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc, 
          g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp,g_nmck_m.nmckcomp_desc, 
          g_nmck_m.nmck003,g_nmck_m.nmck003_desc,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
          g_nmck_m.nmck004,g_nmck_m.nmck004_desc,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus, 
          g_nmck_m.nmck017,g_nmck_m.nmck018,g_nmck_m.nmck121,g_nmck_m.nmck005,g_nmck_m.nmck037,g_nmck_m.nmck040, 
          g_nmck_m.nmck040_desc,g_nmck_m.nmck123,g_nmck_m.nmck013,g_nmck_m.nmck038,g_nmck_m.nmck041, 
          g_nmck_m.nmck041_desc,g_nmck_m.nmck131,g_nmck_m.nmck014,g_nmck_m.nmck039,g_nmck_m.nmck133, 
          g_nmck_m.nmck015,g_nmck_m.nmck042,g_nmck_m.nmck010,g_nmck_m.nmck010_desc,g_nmck_m.nmck016, 
          g_nmck_m.nmck114,g_nmck_m.nmck006,g_nmck_m.nmck011,g_nmck_m.nmck124,g_nmck_m.nmck023,g_nmck_m.nmck134, 
          g_nmck_m.nmck043,g_nmck_m.nmckownid,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp,g_nmck_m.nmckowndp_desc, 
          g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtid_desc,g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckcrtdt, 
          g_nmck_m.nmckmodid,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfid_desc, 
          g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck026,g_nmck_m.nmck008,g_nmck_m.nmck103, 
          g_nmck_m.nmck012,g_nmck_m.nmck009,g_nmck_m.nmck009_desc,g_nmck_m.nmck101,g_nmck_m.nmck113
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   #151013-00016#7 151104 by sakura mark(S)
   #LET g_success = 'Y'
   #IF lc_state = 'Y' THEN 
   #   LET l_today  = cl_get_current() 
   #   UPDATE nmck_t SET nmckcnfid = g_user,
   #                     nmckcnfdt = l_today
   #    WHERE nmckent = g_enterprise 
   #      AND nmckcomp =  g_nmck_m.nmckcomp
   #      AND nmckdocno = g_nmck_m.nmckdocno
   #
   #   LET g_nmck_m.nmckcnfid = g_user
   #   LET g_nmck_m.nmckcnfdt = l_today
   #   
   #   CALL anmt461_conf('+')
   #   CALL anmt461_nmbc_ins()    
   #   IF g_success = 'Y' THEN
   #      CALL s_transaction_end('Y','1')
   #   END IF
   #   IF g_success = 'N' THEN
   #      CALL s_transaction_end('N','1')
   #   END IF
   #ELSE
   #   UPDATE nmck_t SET nmckcnfid = '',
   #                     nmckcnfdt = ''
   #    WHERE nmckent = g_enterprise 
   #      AND nmckcomp =  g_nmck_m.nmckcomp
   #      AND nmckdocno = g_nmck_m.nmckdocno
   #   
   #   LET g_nmck_m.nmckcnfid = ''
   #   LET g_nmck_m.nmckcnfdt = ''
   #   
   #   CALL anmt461_conf('-')
   #   CALL anmt461_nmbc_del()
   #   IF g_success = 'Y' THEN
   #      CALL s_transaction_end('Y','1')
   #   END IF
   #   IF g_success = 'N' THEN
   #      CALL s_transaction_end('N','1')
   #   END IF
   #END IF
   ##151013-00016#6---s
   #CALL s_anm_glbc015_upd(l_glaald,g_nmck_m.nmckdocno,g_nmck_m.nmckdocdt,g_nmck_m.nmckstus) RETURNING l_success
   #IF NOT l_success THEN
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF
   ##151013-00016#6---e
   #151013-00016#7 151104 by sakura mark(E)
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   DISPLAY BY NAME g_nmck_m.nmck026,g_nmck_m.nmck012  
   DISPLAY BY NAME g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt
   #end add-point  
 
   CLOSE anmt461_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt461_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt461.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION anmt461_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_nmed_d.getLength() THEN
         LET g_detail_idx = g_nmed_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmed_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmed_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_nmed2_d.getLength() THEN
         LET g_detail_idx = g_nmed2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmed2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmed2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmt461_b_fill2(pi_idx)
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
   
   CALL anmt461_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION anmt461_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt461.status_show" >}
PRIVATE FUNCTION anmt461_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt461.mask_functions" >}
&include "erp/anm/anmt461_mask.4gl"
 
{</section>}
 
{<section id="anmt461.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION anmt461_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL anmt461_show()
   CALL anmt461_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #151013-00016#7 151104 by sakura add(S)
   IF NOT s_anmt461_conf_chk(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) THEN
      CLOSE anmt461_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #151013-00016#7 151104 by sakura add(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_nmck_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_nmed_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_nmed2_d))
 
 
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
   #CALL anmt461_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL anmt461_ui_headershow()
   CALL anmt461_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION anmt461_draw_out()
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
   CALL anmt461_ui_headershow()  
   CALL anmt461_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="anmt461.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt461_set_pk_array()
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
   LET g_pk_array[1].values = g_nmck_m.nmckcomp
   LET g_pk_array[1].column = 'nmckcomp'
   LET g_pk_array[2].values = g_nmck_m.nmckdocno
   LET g_pk_array[2].column = 'nmckdocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt461.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="anmt461.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmt461_msgcentre_notify(lc_state)
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
   CALL anmt461_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmck_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt461.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION anmt461_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt461.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 交易帳戶編碼說明
# Memo...........:
# Usage..........: CALL anmt461_nmck004_desc(p_nmck004)
#                  RETURNING r_nmck004_desc,nmas003
# Input parameter: p_nmck004      交易帳戶編碼
#                : p_nmckcomp     法人
# Return code....: r_nmck004_desc 交易帳戶編碼說明
#                : nmas003        帳戶幣別
# Date & Author..: 2015/05/18 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt461_nmck004_desc(p_nmck004,p_nmckcomp)
   DEFINE p_nmck004      LIKE nmck_t.nmck004
   DEFINE p_nmckcomp     LIKE nmck_t.nmckcomp

   DEFINE r_nmck004_desc LIKE nmaal_t.nmaal003
   DEFINE r_nmas003      LIKE nmas_t.nmas003

   DEFINE l_nmas001      LIKE nmas_t.nmas001

   SELECT nmas001 INTO l_nmas001 FROM nmas_t
    WHERE nmasent = g_enterprise
      AND nmas002 = p_nmck004
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_nmas001
   CALL ap_ref_array2(g_ref_fields,"SELECT nmaal003 FROM nmaal_t WHERE nmaalent='"||g_enterprise||"' AND nmaal001=? AND nmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_nmck004_desc = '', g_rtn_fields[1] , ''
   
   LET r_nmas003 = ''
   SELECT nmas003 INTO r_nmas003 FROM nmaa_t,nmas_t
    WHERE nmaaent = g_enterprise
      AND nmaaent = nmasent
      AND nmaa001 = nmas001
      AND nmas002 = p_nmck004
      AND nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = g_enterprise AND ooef017 = p_nmckcomp)

   RETURN r_nmck004_desc,r_nmas003

END FUNCTION

################################################################################
# Descriptions...: 付款對象說明
# Memo...........:
# Usage..........: CALL anmt461_nmed006_desc(p_nmed006)
#                  RETURNING r_nmed006_desc
# Input parameter: p_nmed006      付款對象編號
# Return code....: r_nmed006_desc 付款對象說明
# Date & Author..: 2015/05/19 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt461_nmed006_desc(p_nmed006)
   DEFINE p_nmed006         LIKE nmed_t.nmed006
   DEFINE r_nmed006_desc    LIKE glacl_t.glacl004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_nmed006
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_nmed006_desc = '', g_rtn_fields[1] , ''

   RETURN r_nmed006_desc
   
END FUNCTION

################################################################################
# Descriptions...: 提存碼說明
# Memo...........:
# Usage..........: CALL anmt461_nmck009_desc(p_nmck009)
#                  RETURNING r_nmck009_desc
# Input parameter: p_nmck009      提存碼編號
# Return code....: r_nmck009_desc 提存碼說明
# Date & Author..: 2015/05/18 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt461_nmck009_desc(p_nmck009)
   DEFINE p_nmck009         LIKE nmck_t.nmck009

   DEFINE r_nmck009_desc    LIKE nmajl_t.nmajl003

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_nmck009
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_nmck009_desc = '', g_rtn_fields[1] , ''

   RETURN r_nmck009_desc

END FUNCTION
################################################################################
# Descriptions...: 科目說明
# Memo...........:
# Usage..........: CALL anmt461_nmed011_desc(p_nmed011)
#                  RETURNING r_nmed011_desc
# Input parameter: p_nmed011      科目編號
# Return code....: r_nmed011_desc 科目對象說明
# Date & Author..: 2015/05/19 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt461_nmed011_desc(p_nmed011)
   DEFINE p_nmed011         LIKE nmed_t.nmed011
   DEFINE r_nmed011_desc    LIKE glacl_t.glacl004
   DEFINE l_glaa004         LIKE glaa_t.glaa004

   SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise
      AND glaacomp = g_nmck_m.nmckcomp AND glaa014 = 'Y'

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa004
   LET g_ref_fields[2] = p_nmed011
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_nmed011_desc = '', g_rtn_fields[1] , ''

   RETURN r_nmed011_desc

END FUNCTION
# 款別代碼
PRIVATE FUNCTION anmt461_set_combo_scc(p_field)
   DEFINE p_field        LIKE type_t.chr80
   DEFINE ps_values      STRING
   DEFINE ps_items       STRING
   DEFINE pc_ooia001     LIKE ooia_t.ooia001      
   DEFINE pc_ooial003    LIKE ooial_t.ooial003  
   DEFINE li_cnt         LIKE type_t.num5
   DEFINE ps_field_name  STRING
   DEFINE lcbo_target    ui.ComboBox
   DEFINE ls_temp        STRING
   DEFINE l_sql          STRING
   DEFINE pa_array DYNAMIC ARRAY OF RECORD
             value       STRING,
             label_tag   STRING,
             label       STRING
                   END RECORD
   DEFINE l_cnt          LIKE type_t.num5                

   IF cl_null(g_nmck_m.nmcksite) THEN
      LET g_nmck_m.nmcksite = g_site
   END IF 
   LET l_cnt = 0
      
   LET l_sql = "SELECT ooia001, ooial003",
               "  FROM ooia_t LEFT JOIN ooial_t ON ooial001 = ooia001",
               "                                 AND ooial002 = '",g_lang,"'",
               "                                 AND ooiaent = ooialent",
               "                                 AND ooiaent = ",g_enterprise,
               " WHERE ooiaent = ",g_enterprise,
               "   AND ooia002 IN ('10','20')"
   PREPARE p_scc_itemp_pe FROM l_sql
   DECLARE p_scc_itemp_cs CURSOR FOR p_scc_itemp_pe

   LET ps_values = ''
   LET ps_items = ''

   #將選項填入陣列
   LET li_cnt = 1
   FOREACH p_scc_itemp_cs INTO pc_ooia001, pc_ooial003
   
      SELECT COUNT(*) INTO l_cnt FROM ooie_t WHERE ooieent = g_enterprise 
                                               AND ooie001 = pc_ooia001 
                                               AND ooiesite = g_nmck_m.nmcksite
      IF l_cnt = 0 THEN
         CONTINUE FOREACH
      END IF         
                                                
      
      LET pa_array[li_cnt].value = pc_ooia001 CLIPPED
      LET pa_array[li_cnt].label_tag = pc_ooia001 CLIPPED
      LET pa_array[li_cnt].label = pc_ooial003 CLIPPED
      LET li_cnt = li_cnt + 1
   END FOREACH

   LET ps_field_name = p_field

   LET ps_field_name = ps_field_name.trim()

   LET lcbo_target = ui.ComboBox.forName(ps_field_name)

   CALL lcbo_target.clear()
   #以下是Combobox的處理
   FOR li_cnt = 1 TO pa_array.getLength()
       IF cl_null(pa_array[li_cnt].label_tag) THEN
          LET ls_temp = pa_array[li_cnt].label
       ELSE
          LET ls_temp = pa_array[li_cnt].label_tag,":",pa_array[li_cnt].label
       END IF
      CALL lcbo_target.addItem(pa_array[li_cnt].value,ls_temp)
   END FOR

END FUNCTION
# 第二單身參考欄位帶值
PRIVATE FUNCTION anmt461_ref_b2()
   DEFINE l_glaald      LIKE glaa_t.glaald
   DEFINE l_glaa005     LIKE glaa_t.glaa005
   DEFINE l_success     LIKE type_t.num5
   #  150916-00015#1 --add 
   DEFINE l_glaa004         LIKE glaa_t.glaa004
   
   LET l_glaa004 = ''   #160822-00012#5   add
   SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise
      AND glaacomp = g_nmck_m.nmckcomp AND glaa014 = 'Y'
   # 150916-00015#1 --end 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmed2_d[l_ac].nmcm001   
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3113' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmed2_d[l_ac].nmcm001_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmed2_d[l_ac].nmcm001_desc TO s_detail2[l_ac].nmcm001_desc
  #  150916-00015#1 --add  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa004
   LET g_ref_fields[2] = g_nmed2_d[l_ac].nmcm004
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmed2_d[l_ac].nmcm004_desc= '', g_rtn_fields[1] , ''
   DISPLAY g_nmed2_d[l_ac].nmcm004_desc TO s_detail2[l_ac].nmcm004_desc
   # 150916-00015#1 --end 
   #160822-00012#5   add---s
   LET l_glaald = ''
   LET l_glaa005 = ''
   #160822-00012#5   add---e
   CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
   CALL s_ld_sel_glaa(l_glaald,'glaa005') RETURNING l_success,l_glaa005  

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmed2_d[l_ac].nmcm005
   LET g_ref_fields[2] = l_glaa005
   CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail002=? AND nmail001 = ? AND nmail003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmed2_d[l_ac].nmcm005_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmed2_d[l_ac].nmcm005_desc TO s_detail2[l_ac].nmcm005_desc
END FUNCTION
# 寫入銀存收支異動檔 nmbc_t
PRIVATE FUNCTION anmt461_nmbc_ins()
   #161128-00061#2---modify----begin---------- 
   #DEFINE l_nmbc       RECORD   LIKE nmbc_t.* 
   #DEFINE l_nmck       RECORD   LIKE nmck_t.*
   DEFINE l_nmbc RECORD  #銀存收支異動檔
       nmbcent LIKE nmbc_t.nmbcent, #企業編號
       nmbcownid LIKE nmbc_t.nmbcownid, #資料所有者
       nmbcowndp LIKE nmbc_t.nmbcowndp, #資料所屬部門
       nmbccrtid LIKE nmbc_t.nmbccrtid, #資料建立者
       nmbccrtdp LIKE nmbc_t.nmbccrtdp, #資料建立部門
       nmbccrtdt LIKE nmbc_t.nmbccrtdt, #資料創建日
       nmbcmodid LIKE nmbc_t.nmbcmodid, #資料修改者
       nmbcmoddt LIKE nmbc_t.nmbcmoddt, #最近修改日
       nmbccnfid LIKE nmbc_t.nmbccnfid, #資料確認者
       nmbccnfdt LIKE nmbc_t.nmbccnfdt, #資料確認日
       nmbcpstid LIKE nmbc_t.nmbcpstid, #資料過帳者
       nmbcpstdt LIKE nmbc_t.nmbcpstdt, #資料過帳日
       nmbcstus LIKE nmbc_t.nmbcstus, #狀態碼
       nmbccomp LIKE nmbc_t.nmbccomp, #法人
       nmbcsite LIKE nmbc_t.nmbcsite, #資金中心
       nmbcdocno LIKE nmbc_t.nmbcdocno, #來源單號
       nmbcseq LIKE nmbc_t.nmbcseq, #項次
       nmbc001 LIKE nmbc_t.nmbc001, #單據來源
       nmbc002 LIKE nmbc_t.nmbc002, #交易帳戶編碼
       nmbc003 LIKE nmbc_t.nmbc003, #交易對象
       nmbc004 LIKE nmbc_t.nmbc004, #交易對象識別碼
       nmbc005 LIKE nmbc_t.nmbc005, #銀行日期
       nmbc006 LIKE nmbc_t.nmbc006, #異動別
       nmbc007 LIKE nmbc_t.nmbc007, #存提碼
       nmbc008 LIKE nmbc_t.nmbc008, #調節碼
       nmbc009 LIKE nmbc_t.nmbc009, #對帳碼
       nmbc010 LIKE nmbc_t.nmbc010, #網銀媒體檔轉出日期
       nmbc011 LIKE nmbc_t.nmbc011, #網銀媒體檔轉出批號
       nmbc100 LIKE nmbc_t.nmbc100, #交易帳戶幣別
       nmbc101 LIKE nmbc_t.nmbc101, #主帳套匯率
       nmbc103 LIKE nmbc_t.nmbc103, #主帳套原幣金額
       nmbc113 LIKE nmbc_t.nmbc113, #主帳套本幣金額
       nmbc121 LIKE nmbc_t.nmbc121, #主帳套本位幣二匯率
       nmbc123 LIKE nmbc_t.nmbc123, #主帳套本位幣二金額
       nmbc131 LIKE nmbc_t.nmbc131, #主帳套本位幣三匯率
       nmbc133 LIKE nmbc_t.nmbc133, #主帳套本位幣三金額
       nmbc012 LIKE nmbc_t.nmbc012, #票據號碼
       nmbc013 LIKE nmbc_t.nmbc013, #款別
       nmbc014 LIKE nmbc_t.nmbc014, #到期日
       nmbc015 LIKE nmbc_t.nmbc015, #匯入銀行編號
       nmbc016 LIKE nmbc_t.nmbc016, #匯入帳號
       nmbc017 LIKE nmbc_t.nmbc017, #受款人全名
       nmbcorga LIKE nmbc_t.nmbcorga  #來源組織
       END RECORD
   #161128-00061#2---modify----end----------
   DEFINE l_nmcm002    LIKE nmcm_t.nmcm002
   DEFINE l_nmcm003    LIKE nmcm_t.nmcm003
   DEFINE l_nmclorga   LIKE nmcl_t.nmclorga  ###160322-00025#25
   
   SELECT SUM(nmcm002),SUM(nmcm003) INTO l_nmcm002,l_nmcm003
     FROM nmcm_t
    WHERE nmcment = g_enterprise
      AND nmcmcomp = g_nmck_m.nmckcomp
      AND nmcmdocno =  g_nmck_m.nmckdocno     
      
   IF cl_null(l_nmcm002) THEN LET l_nmcm002 = 0 END IF
   IF cl_null(l_nmcm003) THEN LET l_nmcm003 = 0 END IF
   
   ##160322-00025#25 add--str--
   SELECT nmclorga INTO l_nmclorga FROM nmcl_t
    WHERE nmclent = g_enterprise 
      AND nmclcomp = g_nmck_m.nmckcomp
      AND nmcldocno = g_nmck_m.nmckdocno 
   ##160322-00025#25 add--end--   
      
   LET l_nmbc.nmbcent = g_enterprise
   LET l_nmbc.nmbccomp = g_nmck_m.nmckcomp
   LET l_nmbc.nmbcsite = g_nmck_m.nmcksite
   LET l_nmbc.nmbcorga = l_nmclorga         #160322-00025#26
   LET l_nmbc.nmbcdocno = g_nmck_m.nmckdocno
   LET l_nmbc.nmbcseq = 1
   LET l_nmbc.nmbc001 = 'anmt461'
   LET l_nmbc.nmbc002 = g_nmck_m.nmck004
   LET l_nmbc.nmbc003 = g_nmck_m.nmck005
   LET l_nmbc.nmbc004 = g_nmck_m.nmck006
   LET l_nmbc.nmbc005 = g_nmck_m.nmck011
   LET l_nmbc.nmbc006 = '2'
   LET l_nmbc.nmbc007 = g_nmck_m.nmck009
   LET l_nmbc.nmbc008 = ''
   LET l_nmbc.nmbc009 = ''
   LET l_nmbc.nmbc010 = ''
   LET l_nmbc.nmbc011 = ''
   LET l_nmbc.nmbc012 = ''                #150818-00032#3 
   LET l_nmbc.nmbc013 = g_nmck_m.nmck002  #150818-00032#3
   LET l_nmbc.nmbc014 = ''                #151012-00014#6
   LET l_nmbc.nmbc015 = ''                #151012-00014#6
   LET l_nmbc.nmbc016 = ''                #151012-00014#6
   LET l_nmbc.nmbc100 = g_nmck_m.nmck100
   LET l_nmbc.nmbc101 = g_nmck_m.nmck101
   LET l_nmbc.nmbc103 = g_nmck_m.nmck103 + l_nmcm002
   LET l_nmbc.nmbc113 = g_nmck_m.nmck113 + l_nmcm003
   LET l_nmbc.nmbc121 = g_nmck_m.nmck121
   LET l_nmbc.nmbc123 = g_nmck_m.nmck123
   LET l_nmbc.nmbc131 = g_nmck_m.nmck131
   LET l_nmbc.nmbc133 = g_nmck_m.nmck133
   LET l_nmbc.nmbcownid = g_user
   LET l_nmbc.nmbcowndp = g_dept
   LET l_nmbc.nmbccrtid = g_user
   LET l_nmbc.nmbccrtdp = g_dept 
   LET l_nmbc.nmbccrtdt = cl_get_current()
   
   #161128-00061#2---modify----begin----------
   #INSERT INTO nmbc_t VALUES(l_nmbc.*)
   INSERT INTO nmbc_t (nmbcent,nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,nmbccrtdt,nmbcmodid,nmbcmoddt,
                       nmbccnfid,nmbccnfdt,nmbcpstid,nmbcpstdt,nmbcstus,nmbccomp,nmbcsite,nmbcdocno,
                       nmbcseq,nmbc001,nmbc002,nmbc003,nmbc004,nmbc005,nmbc006,nmbc007,nmbc008,nmbc009,
                       nmbc010,nmbc011,nmbc100,nmbc101,nmbc103,nmbc113,nmbc121,nmbc123,nmbc131,nmbc133,
                       nmbc012,nmbc013,nmbc014,nmbc015,nmbc016,nmbc017,nmbcorga)
    VALUES(l_nmbc.nmbcent,l_nmbc.nmbcownid,l_nmbc.nmbcowndp,l_nmbc.nmbccrtid,l_nmbc.nmbccrtdp,l_nmbc.nmbccrtdt,l_nmbc.nmbcmodid,l_nmbc.nmbcmoddt,
           l_nmbc.nmbccnfid,l_nmbc.nmbccnfdt,l_nmbc.nmbcpstid,l_nmbc.nmbcpstdt,l_nmbc.nmbcstus,l_nmbc.nmbccomp,l_nmbc.nmbcsite,l_nmbc.nmbcdocno,
           l_nmbc.nmbcseq,l_nmbc.nmbc001,l_nmbc.nmbc002,l_nmbc.nmbc003,l_nmbc.nmbc004,l_nmbc.nmbc005,l_nmbc.nmbc006,l_nmbc.nmbc007,l_nmbc.nmbc008,l_nmbc.nmbc009,
           l_nmbc.nmbc010,l_nmbc.nmbc011,l_nmbc.nmbc100,l_nmbc.nmbc101,l_nmbc.nmbc103,l_nmbc.nmbc113,l_nmbc.nmbc121,l_nmbc.nmbc123,l_nmbc.nmbc131,l_nmbc.nmbc133,
           l_nmbc.nmbc012,l_nmbc.nmbc013,l_nmbc.nmbc014,l_nmbc.nmbc015,l_nmbc.nmbc016,l_nmbc.nmbc017,l_nmbc.nmbcorga)
   #161128-00061#2---modify----end----------
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins nmbc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()         
      LET g_success = 'N'                        
   END IF

END FUNCTION
# 刪除銀存收支異動檔 nmbc_t
PRIVATE FUNCTION anmt461_nmbc_del()
   DELETE FROM nmbc_t 
    WHERE nmbcent = g_enterprise
      AND nmbcdocno = g_nmck_m.nmckdocno
      AND nmbccomp = g_nmck_m.nmckcomp
      
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del nmbc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET g_success = 'N'                        
   END IF
END FUNCTION
#
PRIVATE FUNCTION anmt461_change_to_sql(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF
   END WHILE
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL anmt461_pay_date()

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt461_pay_date()
   DEFINE l_stus LIKE type_t.chr1
   DEFINE l_flag LIKE type_t.chr1
   
   IF g_nmck_m.nmckcomp IS NULL
      OR g_nmck_m.nmckdocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   SELECT DISTINCT nmckstus INTO l_stus FROM nmck_t WHERE nmckent = g_enterprise 
                                                      AND nmckdocno = g_nmck_m.nmckdocno
                                                      AND nmckcomp = g_nmck_m.nmckcomp
   IF l_stus <> 'Y' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "anm-00290" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF  

   IF NOT cl_null(g_nmck_m.nmck012) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "anm-00291" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   CALL cl_set_comp_entry('nmck012',TRUE)
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   INPUT BY NAME g_nmck_m.nmck012 ATTRIBUTE(WITHOUT DEFAULTS)
    BEFORE INPUT
      LET g_nmck_m.nmck012 = g_today
      DISPLAY BY NAME g_nmck_m.nmck012
      CALL cl_set_comp_entry('nmck012',TRUE)
      CALL cl_set_comp_required('nmck012',TRUE)
   END INPUT
   ON ACTION accept
      LET l_flag = 'Y'
      ACCEPT DIALOG
   
   ON ACTION cancel
      LET l_flag = 'N'
      EXIT DIALOG
   END DIALOG
   
   IF l_flag = 'Y' THEN
      LET g_nmck_m.nmck026 = '11'
      UPDATE nmck_t SET nmck012 = g_nmck_m.nmck012,
                        nmck026 = g_nmck_m.nmck026    
                        WHERE nmckent = g_enterprise 
                          AND nmckdocno = g_nmck_m.nmckdocno
                          AND nmckcomp = g_nmck_m.nmckcomp
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd nmck_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
     END IF                                                
   END IF
   DISPLAY BY NAME g_nmck_m.nmck012,g_nmck_m.nmck026
END FUNCTION

################################################################################
# Descriptions...: 開啟子畫面產生單身資料
# Memo...........:
# Usage..........: CALL anmt461_open_s01()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      執行成功否
# Date & Author..: 2015/05/18 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt461_open_s01()
   DEFINE l_sel         type_sel
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_glaald               LIKE glaa_t.glaald

   INITIALIZE l_sel.* TO NULL
   CALL cl_set_comp_visible('s1_gp02',TRUE)

   OPEN WINDOW w_anmt461_s01 WITH FORM cl_ap_formpath("anm","anmt461_s01")

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      INPUT BY NAME l_sel.apdasite,l_sel.radio

         BEFORE INPUT
            LET l_sel.radio = '1'
            CALL cl_set_comp_visible('s1_gp02',FALSE)
            CALL s_fin_get_account_center('',g_nmck_m.nmck003,'3',g_nmck_m.nmckdocdt)
               RETURNING l_success,l_sel.apdasite,g_errno
            CALL s_axrt300_xrca_ref('xrcasite',l_sel.apdasite,'','') RETURNING l_success,l_sel.apdasite_desc

         AFTER FIELD apdasite
            IF NOT cl_null(l_sel.apdasite) THEN
               CALL s_fin_account_center_chk(l_sel.apdasite,'','6',g_nmck_m.nmckdocdt)
                  RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL s_axrt300_xrca_ref('xrcasite',l_sel.apdasite,'','') RETURNING l_success,l_sel.apdasite_desc
            END IF
            DISPLAY BY NAME l_sel.apdasite_desc

         ON CHANGE radio
            IF NOT cl_null(l_sel.radio) THEN
               IF l_sel.radio = '1' THEN
                  CALL cl_set_comp_visible('s1_gp02',FALSE)
               ELSE
                  CALL cl_set_comp_visible('s1_gp02',TRUE)
               END IF
            END IF

         ON ACTION controlp INFIELD apdasite
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_sel.apdasite
            #LET g_qryparam.where = " ooef201 = 'Y' " #161021-00050#9 mark
            #CALL q_ooef001()                         #161021-00050#9 mark
            LET g_qryparam.where = " ooefstus = 'Y'"  #161021-00050#9
            CALL q_ooef001_46()                       #161021-00050#9
            LET l_sel.apdasite = g_qryparam.return1
            CALL s_axrt300_xrca_ref('xrcasite',l_sel.apdasite,'','') RETURNING l_success,l_sel.apdasite_desc
            DISPLAY BY NAME l_sel.apdasite,l_sel.apdasite_desc
            NEXT FIELD apdasite

      END INPUT

      CONSTRUCT BY NAME l_sel.ls_wc ON apdadocno,apdadocdt,apda005

         ON ACTION controlp INFIELD apdadocno
            SELECT glaald INTO l_glaald FROM glaa_t
             WHERE glaaent = g_enterprise AND glaa014 = 'Y'
               AND glaacomp = g_nmck_m.nmckcomp
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "apdesite = '",l_sel.apdasite,"'"
            CASE
               WHEN g_nmck_m.nmck001 = '1'
                  LET g_qryparam.arg1 = "aapt420"
               WHEN g_nmck_m.nmck001 = '1'
                  LET g_qryparam.arg1 = "aapt310"
               WHEN g_nmck_m.nmck001 = '1'
                  LET g_qryparam.arg1 = "aapt331"
               WHEN g_nmck_m.nmck001 = '1'
                  LET g_qryparam.arg1 = "aapt330"
               WHEN g_nmck_m.nmck001 = '5'
                  LET g_qryparam.arg1 = "1"
            END CASE
            LET g_qryparam.arg2 = g_nmck_m.nmck100
            LET g_qryparam.arg4 = l_glaald
            LET g_qryparam.arg5 = ''

            CALL q_apdadocno_4()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdadocno  #顯示到畫面上
            NEXT FIELD apdadocno

         ON ACTION controlp INFIELD apda005
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"   #150211apo
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apda005  #顯示到畫面上
            NEXT FIELD apda005

      END CONSTRUCT

      BEFORE DIALOG
         NEXT FIELD apdasite

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION lbl_accept
         ACCEPT DIALOG

      ON ACTION lbl_cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG

   END DIALOG

   #畫面關閉
   CLOSE WINDOW w_anmt461_s01

   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
   ELSE
      LET INT_FLAG = FALSE
      CALL s_anmt461_p(g_nmck_m.nmck001,g_nmck_m.nmckdocno,g_nmck_m.nmcksite,g_nmck_m.nmckcomp,l_sel.apdasite,l_sel.ls_wc)
         RETURNING l_success
      CALL anmt461_upd_nmck() RETURNING l_success
   END IF

   CALL anmt461_b_fill()

END FUNCTION

################################################################################
# Descriptions...: 更新單頭金額
# Memo...........:
# Usage..........: CALL anmt461_upd_nmck()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      執行成功否
# Date & Author..: 2015/05/19 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt461_upd_nmck()
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_nmck103         LIKE nmck_t.nmck103
   DEFINE l_nmck113         LIKE nmck_t.nmck113

   LET l_nmck103 = 0
   LET l_nmck113 = 0

   LET r_success = TRUE

   SELECT SUM(nmed012),SUM(nmed013) INTO l_nmck103,l_nmck113 FROM nmed_t
    WHERE nmedent = g_enterprise
      AND nmeddocno = g_nmck_m.nmckdocno
      AND nmedcomp = g_nmck_m.nmckcomp
   IF cl_null(l_nmck103) THEN LET l_nmck103 = 0 END IF
   IF cl_null(l_nmck113) THEN LET l_nmck113 = 0 END IF

   UPDATE nmck_t SET nmck103 = l_nmck103,
                     nmck113 = l_nmck103 * g_nmck_m.nmck101
    WHERE nmckent = g_enterprise
      AND nmckdocno = g_nmck_m.nmckdocno
      AND nmckcomp = g_nmck_m.nmckcomp
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF

   SELECT nmck103,nmck113 INTO g_nmck_m.nmck103,g_nmck_m.nmck113 FROM nmck_t
    WHERE nmckent = g_enterprise
      AND nmckdocno = g_nmck_m.nmckdocno
      AND nmckcomp = g_nmck_m.nmckcomp

   DISPLAY BY NAME g_nmck_m.nmck103,g_nmck_m.nmck113

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 來源單存在性、有效性檢查
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
PRIVATE FUNCTION anmt461_source_chk(p_nmed003,p_nmed004,p_nmed005)
   DEFINE p_nmed003       LIKE nmed_t.nmed003
   DEFINE p_nmed004       LIKE nmed_t.nmed004
   DEFINE p_nmed005       LIKE nmed_t.nmed005
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_glaald        LIKE glaa_t.glaald
   DEFINE l_glaa015       LIKE glaa_t.glaa015
   DEFINE l_glaa019       LIKE glaa_t.glaa019
   DEFINE l_apca001         LIKE apca_t.apca001
   DEFINE l_sql           STRING
   DEFINE l_str           STRING
   DEFINE l_prog          STRING
   DEFINE l_gzcb002       LIKE gzcb_t.gzcb002
   DEFINE l_amt1          LIKE apcc_t.apcc108 
   DEFINE l_amt2          LIKE apcc_t.apcc118
   DEFINE l_amt3          LIKE apcc_t.apcc128  
   DEFINE l_amt4          LIKE apcc_t.apcc138
   DEFINE l_tmp           RECORD
            apccdocno     LIKE apcc_t.apccdocno,
            apccseq       LIKE apcc_t.apccseq,
            apcc001       LIKE apcc_t.apcc001,
            apca004       LIKE apca_t.apca004,
            apcc002       LIKE apcc_t.apcc002,
            apde008       LIKE apde_t.apde008,
            apde012       LIKE apde_t.apde012,
            apde011       LIKE apde_t.apde011,
            apde016       LIKE apde_t.apde016,
            apde101       LIKE apde_t.apde101,
            apcc121       LIKE apcc_t.apcc121,
            apcc131       LIKE apcc_t.apcc131
                          END RECORD

   LET r_success = TRUE

   CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald
   CALL s_ld_sel_glaa(l_glaald,'glaa015|glaa019') RETURNING g_sub_success,l_glaa015,l_glaa019 

   IF g_nmed_d[l_ac].nmed001 = 'aapt420' THEN
      SELECT apdedocno,apdeseq,'',apda005,apde006,apde008,apde012,apde011,apde016,apde101,apde121,apde131
        INTO l_tmp.* FROM apda_t,apde_t 
       WHERE apdaent = g_enterprise
         AND apdaent = apdeent 
         AND apdald = apdeld 
         AND apdadocno = apdedocno 
         AND apdastus = 'Y'
         AND apde003 IS NULL
         AND apdald = l_glaald
         AND apde100 = g_nmck_m.nmck100
         AND apdeorga = g_nmed_d[l_ac].nmedorga
         AND apdedocno = p_nmed003
         AND apdeseq = p_nmed004

      IF NOT cl_null(l_tmp.apccdocno) THEN
         CALL s_anmt461_amt('1',l_glaald,l_tmp.apccdocno,l_tmp.apccseq,p_nmed005)
            RETURNING l_amt1,l_amt2,l_amt3,l_amt4
         IF l_amt1 > 0 THEN
            LET g_nmed_d[l_ac].nmed001 = 'aapt420'
            LET g_nmed_d[l_ac].nmed002 = g_nmck_m.nmck002
            LET g_nmed_d[l_ac].nmed003 = l_tmp.apccdocno
            LET g_nmed_d[l_ac].nmed004 = l_tmp.apccseq
            LET g_nmed_d[l_ac].nmed005 = l_tmp.apcc001
            LET g_nmed_d[l_ac].nmed006 = l_tmp.apca004
            LET g_nmed_d[l_ac].nmed007 = l_tmp.apcc002
            LET g_nmed_d[l_ac].nmed008 = l_tmp.apde008
            LET g_nmed_d[l_ac].nmed009 = l_tmp.apde012
            LET g_nmed_d[l_ac].nmed010 = l_tmp.apde011
            LET g_nmed_d[l_ac].nmed011 = l_tmp.apde016
            LET g_nmed_d[l_ac].nmed012 = l_amt1
            LET g_nmed_d[l_ac].nmed013 = l_amt2
         
            IF l_glaa015 = 'Y' THEN  
            LET g_nmed_d[l_ac].nmed100 = l_tmp.apcc121
            LET g_nmed_d[l_ac].nmed101 = l_amt3
            END IF
         
            IF l_glaa019 = 'Y' THEN  
            LET g_nmed_d[l_ac].nmed110 = l_tmp.apcc131
            LET g_nmed_d[l_ac].nmed111 = l_amt4
            END IF
         END IF
      END IF

      IF cl_null(l_tmp.apccdocno) AND g_nmck_m.nmck001 = '1' THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 'anm-00352'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      IF NOT cl_null(l_tmp.apccdocno) AND l_amt1 = 0 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 'anm-00353'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      RETURN r_success
   END IF

   IF cl_null(p_nmed005) THEN RETURN r_success END IF

   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8502' AND gzcb005 IN ('",g_nmed_d[l_ac].nmed001,"')"
   PREPARE s_anmt461_apca001_prep FROM l_sql
   DECLARE s_anmt461_apca001_curs CURSOR FOR s_anmt461_apca001_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH s_anmt461_apca001_curs INTO l_gzcb002
      IF cl_null(l_str) THEN LET l_str = l_gzcb002 CONTINUE FOREACH END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH

   LET l_str = " apca001 IN (",l_str,")"

   LET g_sql = "SELECT apccdocno,apccseq,apcc001,apca004,apcc002,'','','',apca035,",
               "       apcc101,apcc121,apcc131,apca001 ",
               "  FROM apca_t,apcc_t ",
               " WHERE apcaent = '",g_enterprise,"'",
               "   AND apcaent = apccent ",
               "   AND apcald = apccld ",
               "   AND apcadocno = apccdocno ",
               "   AND apcastus = 'Y' ",
               "   AND apcald = '",l_glaald,"'",
               "   AND apca100 = '",g_nmck_m.nmck100,"'",
               "   AND ",l_str,
               "   AND apccdocno = '",p_nmed003,"'",
               "   AND apccseq = '",p_nmed004,"'",
               "   AND apcc001 = '",p_nmed005,"'",
               " ORDER BY apcadocno"
      
   PREPARE anmt461_pre2 FROM g_sql
   DECLARE anmt461_cs2 CURSOR FOR anmt461_pre2
   FOREACH anmt461_cs2 INTO l_tmp.*,l_apca001
      #计算可请款金额
      CALL s_anmt461_amt('2',l_glaald,l_tmp.apccdocno,l_tmp.apccseq,l_tmp.apcc001)
         RETURNING l_amt1,l_amt2,l_amt3,l_amt4
      
      #请款金额不足,不可请款      
      IF l_amt1 < = 0 THEN 
         CONTINUE FOREACH
      END IF 
  
      SELECT gzcb005 INTO g_nmed_d[l_ac].nmed001 FROM gzcb_t WHERE gzcb001 = '8502' AND gzcb002 = l_apca001
  
      LET g_nmed_d[l_ac].nmed002 = g_nmck_m.nmck002
      LET g_nmed_d[l_ac].nmed003 = l_tmp.apccdocno
      LET g_nmed_d[l_ac].nmed004 = l_tmp.apccseq
      LET g_nmed_d[l_ac].nmed005 = l_tmp.apcc001
      LET g_nmed_d[l_ac].nmed006 = l_tmp.apca004
      LET g_nmed_d[l_ac].nmed007 = l_tmp.apcc002
      LET g_nmed_d[l_ac].nmed008 = l_tmp.apde008
      LET g_nmed_d[l_ac].nmed009 = l_tmp.apde012
      LET g_nmed_d[l_ac].nmed010 = l_tmp.apde011
      LET g_nmed_d[l_ac].nmed011 = l_tmp.apde016
      LET g_nmed_d[l_ac].nmed012 = l_amt1
      LET g_nmed_d[l_ac].nmed013 = l_amt2
     #LET g_nmed_d[l_ac].nmed014 = l_tmp.apde101
      
      IF l_glaa015 = 'Y' THEN  
         LET g_nmed_d[l_ac].nmed100 = l_tmp.apcc121
         LET g_nmed_d[l_ac].nmed101 = l_amt3
      END IF
      
      IF l_glaa019 = 'Y' THEN  
         LET g_nmed_d[l_ac].nmed110 = l_tmp.apcc131
         LET g_nmed_d[l_ac].nmed111 = l_amt4
      END IF
  
   END FOREACH

   IF cl_null(l_tmp.apccdocno) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 'anm-00352'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF l_amt1 = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 'anm-00353'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 審核
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
PRIVATE FUNCTION anmt461_conf(p_chr)
   DEFINE p_chr         LIKE type_t.chr1
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_glaald      LIKE glaa_t.glaald
   DEFINE l_nmed001     LIKE nmed_t.nmed001
   DEFINE l_nmed003     LIKE nmed_t.nmed003
   DEFINE l_nmed004     LIKE nmed_t.nmed004
   DEFINE l_nmed005     LIKE nmed_t.nmed005
   DEFINE l_nmed012     LIKE nmed_t.nmed012
   DEFINE l_nmed013     LIKE nmed_t.nmed013
   DEFINE l_sql         STRING

   CALL s_fin_get_major_ld(g_nmck_m.nmckcomp) RETURNING l_glaald

   LET l_sql = "SELECT nmed001,nmed003,nmed004,nmed005,nmed012,nmed013 FROM nmed_t ",
               " WHERE nmedent = '",g_enterprise,"'",
               "   AND nmeddocno = '",g_nmck_m.nmckdocno,"'",
               "   AND nmedcomp  = '",g_nmck_m.nmckcomp,"'"
   PREPARE anmt461_conf_prep FROM l_sql
   DECLARE anmt461_conf_curs CURSOR FOR anmt461_conf_prep

   FOREACH anmt461_conf_curs INTO l_nmed001,l_nmed003,l_nmed004,l_nmed005,l_nmed012,l_nmed013
      IF l_nmed001 = 'aapt420' THEN
         IF p_chr = '+' THEN
            UPDATE apde_t SET apde009 = 'Y',
                              apde003 = g_nmck_m.nmckdocno
             WHERE apdeent = g_enterprise
               AND apdedocno = l_nmed003
               AND apdeseq = l_nmed004
               AND apdeld = l_glaald
         ELSE
            UPDATE apde_t SET apde009 = 'N',
                              apde003 = ''
             WHERE apdeent = g_enterprise
               AND apdedocno = l_nmed003
               AND apdeseq = l_nmed004
               AND apdeld = l_glaald
         END IF
      ELSE
         IF p_chr = '+' THEN
            UPDATE apcc_t SET apcc109 = apcc109 + l_nmed012,
                              apcc119 = apcc119 + l_nmed013
             WHERE apccent = g_enterprise
               AND apccdocno = l_nmed003
               AND apccseq = l_nmed004
               AND apcc001 = l_nmed005
               AND apccld = l_glaald
         ELSE
            UPDATE apcc_t SET apcc109 = apcc109 - l_nmed012,
                              apcc119 = apcc119 - l_nmed013
             WHERE apccent = g_enterprise
               AND apccdocno = l_nmed003
               AND apccseq = l_nmed004
               AND apcc001 = l_nmed005
               AND apccld = l_glaald
         END IF
      END IF
   END FOREACH

END FUNCTION

################################################################################
# Descriptions...: 設置單身來源作業下拉菜單
# Memo...........:
# Usage..........: CALL anmt461_set_label_scc()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/26 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt461_set_label_scc(p_nmck001)
   DEFINE p_nmck001      LIKE nmck_t.nmck001
   DEFINE ps_values      STRING
   DEFINE ps_items       STRING
   DEFINE pc_ooia001     LIKE ooia_t.ooia001      
   DEFINE pc_ooial003    LIKE ooial_t.ooial003  
   DEFINE li_cnt         LIKE type_t.num5
   DEFINE ps_field_name  STRING
   DEFINE lcbo_target    ui.ComboBox
   DEFINE ls_temp        STRING
   DEFINE l_sql          STRING
   DEFINE pa_array DYNAMIC ARRAY OF RECORD
             value       STRING,
             label_tag   STRING,
             label       STRING
                   END RECORD
   DEFINE l_cnt          LIKE type_t.num5                

   IF cl_null(p_nmck001) THEN LET p_nmck001 = 5 END IF

   LET l_cnt = 0
      
   LET l_sql = "SELECT gzzz001, gzzal003 FROM gzzz_t, gzzal_t                        ",
               " WHERE gzzz001 IN (SELECT REGEXP_SUBSTR ((SELECT gzcb003 FROM gzcb_t ",
               "       WHERE gzcb001 = '8726' AND gzcb002 = '",p_nmck001,"'), ",
               "                          '[^,]+',1,ROWNUM)                          ",
               "                     FROM DUAL                                       ",
               "                  CONNECT BY ROWNUM <=                               ",
               "         LENGTH (                                                    ",
               "            (SELECT gzcb003                                          ",
               "               FROM gzcb_t                                           ",
               "        WHERE gzcb001 = '8726' AND gzcb002 = '",p_nmck001,"'))",
               "         - LENGTH (                                                  ",
               "              REPLACE (                                              ",
               "                 (SELECT gzcb003                                     ",
               "                    FROM gzcb_t                                      ",
               "        WHERE gzcb001 = '8726' AND gzcb002 = '",p_nmck001,"'),",
               "                 ',','')) + 1)                                       ",
               "   AND gzzz001 = gzzal001                                            ",
               "   AND gzzal002 = '",g_lang,"'                                       "
   PREPARE p_scc_itemp_prep FROM l_sql
   DECLARE p_scc_itemp_curs CURSOR FOR p_scc_itemp_prep

   LET ps_values = ''
   LET ps_items = ''

   #將選項填入陣列
   LET li_cnt = 1
   FOREACH p_scc_itemp_curs INTO pc_ooia001, pc_ooial003

      LET pa_array[li_cnt].value = pc_ooia001 CLIPPED
      LET pa_array[li_cnt].label_tag = pc_ooia001 CLIPPED
      LET pa_array[li_cnt].label = pc_ooial003 CLIPPED
      LET li_cnt = li_cnt + 1
   END FOREACH

   LET ps_field_name = "nmed001"

   LET ps_field_name = ps_field_name.trim()

   LET lcbo_target = ui.ComboBox.forName(ps_field_name)

   CALL lcbo_target.clear()
   #以下是Combobox的處理
   FOR li_cnt = 1 TO pa_array.getLength()
       IF cl_null(pa_array[li_cnt].label_tag) THEN
          LET ls_temp = pa_array[li_cnt].label
       ELSE
          LET ls_temp = pa_array[li_cnt].label_tag,":",pa_array[li_cnt].label
       END IF
      CALL lcbo_target.addItem(pa_array[li_cnt].value,ls_temp)
   END FOR

END FUNCTION

################################################################################
# Descriptions...: 编辑完后立即审核
# Memo...........:
# Usage..........: CALL anmt461_immediately_conf()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/03 By 07166
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt461_immediately_conf()
#151125-00006#3--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   
   SELECT glaald INTO g_glaald FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_nmck_m.nmckcomp
      AND glaa014 = 'Y'
   IF cl_null(g_glaald)           THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmck_m.nmckcomp)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmck_m.nmckdocno) THEN RETURN END IF   #無資料直接返回不做處理
   
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM nmed_t WHERE nmedent = g_enterprise
      AND nmeddocno = g_nmck_m.nmckdocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #单身無資料直接返回不做處理
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_nmck_m.nmckdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_glaald,g_nmck_m.nmckcomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
        
   IF NOT s_anmt461_conf_chk(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) THEN
      LET l_doc_success = FALSE
   END IF
   
   IF NOT s_anmt461_conf_upd(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) THEN
      LET l_doc_success = FALSE
   END IF 
   
   #異動狀態碼欄位/修改人/修改日期
   LET g_nmck_m.nmckmoddt = cl_get_current()
   LET g_nmck_m.nmckcnfdt = cl_get_current()
   UPDATE nmck_t SET nmckstus = 'Y',
                     nmckmodid= g_user,
                     nmckmoddt= g_nmck_m.nmckmoddt,
                     nmckcnfid= g_user,
                     nmckcnfdt= g_nmck_m.nmckcnfdt
    WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp
      AND nmckdocno = g_nmck_m.nmckdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_doc_success = FALSE
   END IF
   IF l_doc_success = TRUE THEN
      CALL s_transaction_end('Y',1)
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#3--e
END FUNCTION

 
{</section>}
 
