#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt460.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-08-24 08:51:37), PR版次:0012(2017-01-09 11:51:23)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: aapt460
#+ Description: 集團代付款沖銷維護作業
#+ Creator....: 02097(2015-11-02 15:03:08)
#+ Modifier...: 03080 -SD/PR- 06821
 
{</section>}
 
{<section id="aapt460.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151125-00006#2               By 06421    新增[編輯完單據後立即審核]功能
#151130-00015#2   2015/12/22  BY taozf    判断 是否可以更改單據日期 設定開放單據日期修改
#151130-00015#4   2015/12/23  By 02097    配合s_aapt420增加參數
#160122-00001#14  2016/02/14  By yangtt   添加交易帳戶編號用戶權限空管
#160125-00005#6   2016/02/15  By 02097    查詢時，只顯示有權限的帳套
#160225-00001#1   2016/03/04  By 02097    參數D-FIN-0033=N 時不管什麼欄位都不可異動
#160321-00016#21  2016/03/23  By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00025#25  2016/04/26  BY 07900    校验代码重复错误讯息的修改
#160818-00035#1   20160818    BY albireo  整測問題修正
#160825-00012#1   20160825    By 03538    預設帳務中心與修改帳務中心後,必定要重展組織樹取得帳套範圍
#160822-00008#3   2016/08/25  By 08732    新舊值調整
#160905-00002#2   2016/09/05  By Hans     SQL無ENT補上
#160909-00001#1   2016/09/10  By Reanna   修正#160125-00005#6的bug
#161006-00005#5   2016/10/12  By 08732    組織類型與職能開窗調整
#161014-00053#3   2016/10/21  By 08171    帳套權限調整、增加控制組
#161115-00042#5   2016/11/17  By 08729    開窗增加過濾據點
#161104-00046#5   2016/12/30  By 08171    單別預設值;資料依照單別user dept權限過濾單號
#161229-00047#49  2017/01/09  By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
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
PRIVATE type type_g_apfg_m        RECORD
       apfgsite LIKE apfg_t.apfgsite, 
   apfgsite_desc LIKE type_t.chr80, 
   apfg001 LIKE apfg_t.apfg001, 
   apfg001_desc LIKE type_t.chr80, 
   apfgld LIKE apfg_t.apfgld, 
   apfgld_desc LIKE type_t.chr80, 
   apfgcomp LIKE apfg_t.apfgcomp, 
   apfgdocno LIKE apfg_t.apfgdocno, 
   apfgdocno_desc LIKE type_t.chr80, 
   apfgdocdt LIKE apfg_t.apfgdocdt, 
   apfg002 LIKE apfg_t.apfg002, 
   apfg002_desc LIKE type_t.chr80, 
   apfgstus LIKE apfg_t.apfgstus, 
   apfgownid LIKE apfg_t.apfgownid, 
   apfgownid_desc LIKE type_t.chr80, 
   apfgowndp LIKE apfg_t.apfgowndp, 
   apfgowndp_desc LIKE type_t.chr80, 
   apfgcrtid LIKE apfg_t.apfgcrtid, 
   apfgcrtid_desc LIKE type_t.chr80, 
   apfgcrtdp LIKE apfg_t.apfgcrtdp, 
   apfgcrtdp_desc LIKE type_t.chr80, 
   apfgcrtdt LIKE apfg_t.apfgcrtdt, 
   apfgmodid LIKE apfg_t.apfgmodid, 
   apfgmodid_desc LIKE type_t.chr80, 
   apfgmoddt LIKE apfg_t.apfgmoddt, 
   apfgcnfid LIKE apfg_t.apfgcnfid, 
   apfgcnfid_desc LIKE type_t.chr80, 
   apfgcnfdt LIKE apfg_t.apfgcnfdt, 
   apfgpstid LIKE apfg_t.apfgpstid, 
   apfgpstid_desc LIKE type_t.chr80, 
   apfgpstdt LIKE apfg_t.apfgpstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_apfh_d        RECORD
       apfhseq LIKE apfh_t.apfhseq, 
   apfh001 LIKE apfh_t.apfh001, 
   apfh001_desc LIKE type_t.chr500, 
   apfhld LIKE apfh_t.apfhld, 
   apfhld_desc LIKE type_t.chr500, 
   apfh006 LIKE apfh_t.apfh006, 
   apfh004 LIKE apfh_t.apfh004, 
   apfh002 LIKE apfh_t.apfh002, 
   apfh003 LIKE apfh_t.apfh003, 
   apfh008 LIKE apfh_t.apfh008, 
   apfh100 LIKE apfh_t.apfh100, 
   apfh103 LIKE apfh_t.apfh103, 
   apfh101 LIKE apfh_t.apfh101, 
   apfh104 LIKE apfh_t.apfh104, 
   apfh005 LIKE apfh_t.apfh005, 
   apfh005_desc LIKE type_t.chr500, 
   apfh201 LIKE apfh_t.apfh201, 
   apfh204 LIKE apfh_t.apfh204, 
   apfh007 LIKE apfh_t.apfh007
       END RECORD
PRIVATE TYPE type_g_apfh2_d RECORD
       apfiseq LIKE apfi_t.apfiseq, 
   apfi001 LIKE apfi_t.apfi001, 
   apfi001_desc LIKE type_t.chr500, 
   apfi002 LIKE apfi_t.apfi002, 
   apfi006 LIKE apfi_t.apfi006, 
   apfi003 LIKE apfi_t.apfi003, 
   apfi004 LIKE apfi_t.apfi004, 
   apfi005 LIKE apfi_t.apfi005, 
   apfi011 LIKE apfi_t.apfi011, 
   apfi100 LIKE apfi_t.apfi100, 
   apfi101 LIKE apfi_t.apfi101, 
   apfi103 LIKE apfi_t.apfi103, 
   apfi104 LIKE apfi_t.apfi104, 
   apfi201 LIKE apfi_t.apfi201, 
   apfi204 LIKE apfi_t.apfi204, 
   apfi013 LIKE apfi_t.apfi013
       END RECORD
PRIVATE TYPE type_g_apfh3_d RECORD
       apfiseq LIKE apfi_t.apfiseq, 
   apfi012 LIKE apfi_t.apfi012, 
   apfi012_desc LIKE type_t.chr500, 
   apfi009 LIKE apfi_t.apfi009, 
   apfi009_desc LIKE type_t.chr500, 
   apfi010 LIKE apfi_t.apfi010, 
   apfi010_desc LIKE type_t.chr500, 
   apfi008 LIKE apfi_t.apfi008, 
   apfi008_desc LIKE type_t.chr500, 
   apfi007 LIKE apfi_t.apfi007, 
   apfi007_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_apfgdocno LIKE apfg_t.apfgdocno,
      b_apfg002 LIKE apfg_t.apfg002,
   b_apfg002_desc LIKE type_t.chr80,
      b_apfgdocdt LIKE apfg_t.apfgdocdt,
      b_apfgsite LIKE apfg_t.apfgsite,
   b_apfgsite_desc LIKE type_t.chr80,
      b_apfg001 LIKE apfg_t.apfg001,
   b_apfg001_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa                RECORD
                             glaacomp  LIKE glaa_t.glaacomp,
                             glaa001   LIKE glaa_t.glaa001,
                             glaa004   LIKE glaa_t.glaa004,
                             glaa015   LIKE glaa_t.glaa015,
                             glaa016   LIKE glaa_t.glaa016,
                             glaa017   LIKE glaa_t.glaa017,
                             glaa019   LIKE glaa_t.glaa019,
                             glaa020   LIKE glaa_t.glaa020,
                             glaa021   LIKE glaa_t.glaa021,
                             glaa024   LIKE glaa_t.glaa024,
                             glaa121   LIKE glaa_t.glaa121
                         END RECORD
DEFINE g_ap_slip             LIKE ooba_t.ooba002      #應付帳款單單別
DEFINE g_wc_apfgcomp         STRING                   #帳務組織條件
DEFINE g_wc_apfgld           STRING
DEFINE g_wc_cs_ld            STRING                #160125-00005#6
DEFINE g_wc_cs_orga          STRING                #160125-00005#6

DEFINE g_sql_bank            STRING                #160122-00001#14 add by07675
DEFINE g_sql_ctrl            STRING    #交易對象控制組              #161014-00053#3
DEFINE g_site_str            STRING                #161014-00053#3
DEFINE g_wc_apcald           STRING                #161014-00053#3
#161104-00046#5 --s add
DEFINE g_user_dept_wc      STRING
DEFINE g_user_dept_wc_q    STRING
DEFINE g_user_slip_wc      STRING
#161104-00046#5 --e add
DEFINE g_wc_cs_comp        STRING  #161229-00047#49 add
DEFINE g_comp_str          STRING  #161229-00047#49 add 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_apfg_m          type_g_apfg_m
DEFINE g_apfg_m_t        type_g_apfg_m
DEFINE g_apfg_m_o        type_g_apfg_m
DEFINE g_apfg_m_mask_o   type_g_apfg_m #轉換遮罩前資料
DEFINE g_apfg_m_mask_n   type_g_apfg_m #轉換遮罩後資料
 
   DEFINE g_apfgdocno_t LIKE apfg_t.apfgdocno
 
 
DEFINE g_apfh_d          DYNAMIC ARRAY OF type_g_apfh_d
DEFINE g_apfh_d_t        type_g_apfh_d
DEFINE g_apfh_d_o        type_g_apfh_d
DEFINE g_apfh_d_mask_o   DYNAMIC ARRAY OF type_g_apfh_d #轉換遮罩前資料
DEFINE g_apfh_d_mask_n   DYNAMIC ARRAY OF type_g_apfh_d #轉換遮罩後資料
DEFINE g_apfh2_d          DYNAMIC ARRAY OF type_g_apfh2_d
DEFINE g_apfh2_d_t        type_g_apfh2_d
DEFINE g_apfh2_d_o        type_g_apfh2_d
DEFINE g_apfh2_d_mask_o   DYNAMIC ARRAY OF type_g_apfh2_d #轉換遮罩前資料
DEFINE g_apfh2_d_mask_n   DYNAMIC ARRAY OF type_g_apfh2_d #轉換遮罩後資料
DEFINE g_apfh3_d          DYNAMIC ARRAY OF type_g_apfh3_d
DEFINE g_apfh3_d_t        type_g_apfh3_d
DEFINE g_apfh3_d_o        type_g_apfh3_d
DEFINE g_apfh3_d_mask_o   DYNAMIC ARRAY OF type_g_apfh3_d #轉換遮罩前資料
DEFINE g_apfh3_d_mask_n   DYNAMIC ARRAY OF type_g_apfh3_d #轉換遮罩後資料
 
 
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

#end add-point
 
{</section>}
 
{<section id="aapt460.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_fin_create_account_center_tmp()                   #展組織下階成員所需之暫存檔 
   CALL s_aap_create_multi_bill_perod_tmp()                 #新增多帳期FUNCTION用的TEMP TABLE
   CALL s_aapp330_cre_tmp()       RETURNING g_sub_success   #傳票拋轉
   CALL s_aap_create_multi_bill_perod_tmp()                    #新增多帳期FUNCTION用的TEMP TABLE
   CALL s_fin_azzi800_sons_query(g_today)                      #160125-00005#6
   CALL s_fin_account_center_sons_str() RETURNING g_wc_cs_orga #160125-00005#6
   CALL s_fin_get_wc_str(g_wc_cs_orga) RETURNING g_wc_cs_orga  #160125-00005#6
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld     #160909-00001#1
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld      #160909-00001#1
   #161104-00046#5 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_apfg_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','apfgld','apfgent','apfgdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#5 --e add
   #161229-00047#49 --s add
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#49 --e add      
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT apfgsite,'',apfg001,'',apfgld,'',apfgcomp,apfgdocno,'',apfgdocdt,apfg002, 
       '',apfgstus,apfgownid,'',apfgowndp,'',apfgcrtid,'',apfgcrtdp,'',apfgcrtdt,apfgmodid,'',apfgmoddt, 
       apfgcnfid,'',apfgcnfdt,apfgpstid,'',apfgpstdt", 
                      " FROM apfg_t",
                      " WHERE apfgent= ? AND apfgdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt460_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.apfgsite,t0.apfg001,t0.apfgld,t0.apfgcomp,t0.apfgdocno,t0.apfgdocdt, 
       t0.apfg002,t0.apfgstus,t0.apfgownid,t0.apfgowndp,t0.apfgcrtid,t0.apfgcrtdp,t0.apfgcrtdt,t0.apfgmodid, 
       t0.apfgmoddt,t0.apfgcnfid,t0.apfgcnfdt,t0.apfgpstid,t0.apfgpstdt,t1.ooefl003 ,t2.ooag011 ,t3.glaal002 , 
       t4.pmaal004 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooag011 ,t11.ooag011", 
 
               " FROM apfg_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.apfgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.apfg001  ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.apfgld AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.apfg002 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.apfgownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.apfgowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.apfgcrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.apfgcrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.apfgmodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.apfgcnfid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.apfgpstid  ",
 
               " WHERE t0.apfgent = " ||g_enterprise|| " AND t0.apfgdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapt460_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapt460 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapt460_init()   
 
      #進入選單 Menu (="N")
      CALL aapt460_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapt460
      
   END IF 
   
   CLOSE aapt460_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE s_aap_tmp1            #多帳期
   DROP TABLE s_fin_tmp1            #下層組織
   DROP TABLE s_voucher_tmp         #分錄底稿
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapt460.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapt460_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_str    STRING
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('apfgstus','13','Y,N,A,D,R,W,X')
 
      CALL cl_set_combo_scc('apfh006','8506') 
   CALL cl_set_combo_scc('apfh004','8310') 
   CALL cl_set_combo_scc('apfh007','8310') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2','3',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #付款單身--(S)
   LET l_str = s_aap_get_acc_str('8506',"gzcb004 = '2' AND gzcb002 <> '17' ") CLIPPED      
   CALL cl_set_combo_scc_part('apfh006','8506',l_str)    #付款類型     
   LET l_str = s_aap_get_acc_str('8310',"gzcb002 <> 'ZZ' ") CLIPPED    
   CALL cl_set_combo_scc_part('apfh004','8310',l_str)    #款別性質
   #付款單身--(E)
   #帳款單身--(S)
   LET l_str = s_aap_get_acc_str('8506',"gzcb004 = '1'") CLIPPED 
   CALL cl_set_combo_scc_part('apfi006','8506',l_str)
   #帳款單身--(E)
   
   #160122-00001#14--add-by07675-str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#14--add--end
   #161014-00053#3 --s add
   #控制組
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00042#5 mark
   #161115-00042#5-add(s)
   SELECT ooef017 INTO g_apfg_m.apfgcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apfg_m.apfgcomp) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#49 mark
   #161115-00042#5-add(e)
   #161014-00053#3 --e add
   #end add-point
   
   #初始化搜尋條件
   CALL aapt460_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aapt460.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aapt460_ui_dialog()
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
   DEFINE l_cn        LIKE type_t.num10 #151125-00006#2
   DEFINE l_dfin0033    LIKE type_t.chr1        #160225-00001#1
   DEFINE l_slip        LIKE apca_t.apcadocno   #160225-00001#1
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
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
            CALL aapt460_insert()
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
         INITIALIZE g_apfg_m.* TO NULL
         CALL g_apfh_d.clear()
         CALL g_apfh2_d.clear()
         CALL g_apfh3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapt460_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
         
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL aapt460_fetch('') # reload data
               LET l_ac = 1
               CALL aapt460_ui_detailshow() #Setting the current row 
         
               CALL aapt460_idx_chk()
               #NEXT FIELD apfhseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_apfh_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt460_idx_chk()
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
               CALL aapt460_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_apfh2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt460_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2','3',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2','3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aapt460_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_apfh3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt460_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL aapt460_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aapt460_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
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
               CALL aapt460_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aapt460_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aapt460_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aapt460_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aapt460_set_act_visible()   
            CALL aapt460_set_act_no_visible()
            IF NOT (g_apfg_m.apfgdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " apfgent = " ||g_enterprise|| " AND",
                                  " apfgdocno = '", g_apfg_m.apfgdocno, "' "
 
               #填到對應位置
               CALL aapt460_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "apfg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apfh_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apfi_t" 
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
               CALL aapt460_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
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
                     WHEN la_wc[li_idx].tableid = "apfg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apfh_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apfi_t" 
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
                  CALL aapt460_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapt460_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aapt460_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aapt460_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt460_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aapt460_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt460_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aapt460_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt460_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aapt460_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt460_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aapt460_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt460_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_apfh_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_apfh2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_apfh3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD apfhseq
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
               CALL aapt460_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#2---s
               CALL aapt460_immediately_conf()
               SELECT COUNT(*) INTO l_cn FROM apfg_t 
               WHERE apfgld  = g_apfg_m.apfgld AND  apfgcomp = g_apfg_m.apfgcomp AND apfgdocno = g_apfg_m.apfgdocno
                 AND apfgent = g_enterprise #160905-00002#2  
               IF l_cn > 0 THEN
                  CALL aapt460_ui_headershow()
               END IF
               #151125-00006#2---e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aapt460_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#2---s
               CALL aapt460_immediately_conf()
               SELECT COUNT(*) INTO l_cn FROM apfg_t 
               WHERE apfgld  = g_apfg_m.apfgld AND  apfgcomp = g_apfg_m.apfgcomp AND apfgdocno = g_apfg_m.apfgdocno
                 AND apfgent = g_enterprise #160905-00002#2   
               IF l_cn > 0 THEN
                  CALL aapt460_ui_headershow()
               END IF
               #151125-00006#2---e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION opne_aapt460_02
            LET g_action_choice="opne_aapt460_02"
            IF cl_auth_chk_act("opne_aapt460_02") THEN
               
               #add-point:ON ACTION opne_aapt460_02 name="menu.opne_aapt460_02"
               #160225-00001#1--(S)
               CALL s_aooi200_fin_get_slip(g_apfg_m.apfgdocno) RETURNING g_sub_success,l_slip
               CALL s_fin_get_doc_para(g_apfg_m.apfgld,g_apfg_m.apfgcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
               CALL s_fin_date_close_chk('',g_apfg_m.apfgcomp,'AAP',g_apfg_m.apfgdocdt) RETURNING g_sub_success
               IF l_dfin0033 = "N" AND NOT g_sub_success THEN 
               ELSE
               #160225-00001#1--(E)
                  CALL aapt460_diff() RETURNING g_sub_success
               END IF   #160225-00001#1
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aapt460_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt460_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#2---s
               CALL aapt460_immediately_conf()
               SELECT COUNT(*) INTO l_cn FROM apfg_t 
               WHERE apfgld  = g_apfg_m.apfgld AND  apfgcomp = g_apfg_m.apfgcomp AND apfgdocno = g_apfg_m.apfgdocno
                 AND apfgent = g_enterprise #160905-00002#2  
               IF l_cn > 0 THEN
                  CALL aapt460_ui_headershow()
               END IF
               #151125-00006#2---e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/aap/aapt460_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/aap/aapt460_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aapt460_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               #151125-00006#2---s
               CALL aapt460_immediately_conf()
               SELECT COUNT(*) INTO l_cn FROM apfg_t 
               WHERE apfgld  = g_apfg_m.apfgld AND  apfgcomp = g_apfg_m.apfgcomp AND apfgdocno = g_apfg_m.apfgdocno
                 AND apfgent = g_enterprise #160905-00002#2  
               IF l_cn > 0 THEN
                  CALL aapt460_ui_headershow()
               END IF
               #151125-00006#2---e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION opne_aapt460_01
            LET g_action_choice="opne_aapt460_01"
            IF cl_auth_chk_act("opne_aapt460_01") THEN
               
               #add-point:ON ACTION opne_aapt460_01 name="menu.opne_aapt460_01"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapt460_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_apfg001
            LET g_action_choice="prog_apfg001"
            IF cl_auth_chk_act("prog_apfg001") THEN
               
               #add-point:ON ACTION prog_apfg001 name="menu.prog_apfg001"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_apfg_m.apfg001)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapt460_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt460_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt460_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_apfg_m.apfgdocdt)
 
 
 
         
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
 
{<section id="aapt460.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aapt460_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_n               LIKE type_t.num5     #160126-00010#14
   DEFINE l_ld_str          STRING               #161014-00053#3 add
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
   
   #161014-00053#3 --s add
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str  
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apfgld")
   LET l_wc = l_wc," AND ",l_ld_str
   #161014-00053#3 --e add
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT apfgdocno ",
                      " FROM apfg_t ",
                      " ",
                      " LEFT JOIN apfh_t ON apfhent = apfgent AND apfgdocno = apfhdocno ", "  ",
                      #add-point:browser_fill段sql(apfh_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN apfi_t ON apfient = apfgent AND apfgdocno = apfidocno", "  ",
                      #add-point:browser_fill段sql(apfi_t1) name="browser_fill.cnt.join.apfi_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE apfgent = " ||g_enterprise|| " AND apfhent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("apfg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT apfgdocno ",
                      " FROM apfg_t ", 
                      "  ",
                      "  ",
                      " WHERE apfgent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("apfg_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #160122-00001#14----add--str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT apfgdocno ",
                      " FROM apfg_t ",
                      " LEFT JOIN apfh_t ON apfhent = apfgent AND apfgdocno = apfhdocno ", "  ",
                      " LEFT JOIN apfi_t ON apfient = apfgent AND apfgdocno = apfidocno", "  ",
                      " WHERE apfgent = '" ||g_enterprise|| "' AND apfhent = '" ||g_enterprise|| "' ",
                      "   AND TRIM(apfi009) IS NULL ",
                      "   AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("apfg_t"),
                      " UNION ",
                      " SELECT DISTINCT apfgdocno ",
                      " FROM apfg_t ",
                      " LEFT JOIN apfh_t ON apfhent = apfgent AND apfgdocno = apfhdocno ", "  ",
                      " ,apfi_t ",
                      " WHERE apfient = apfgent AND apfgdocno = apfidocno ",
                      "   AND apfgent = '" ||g_enterprise|| "' AND apfhent = '" ||g_enterprise|| "' ",
#                      "   AND apfi009 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                      "   AND apfi009 IN(",g_sql_bank,")",#160122-00001#14 mod by 07675
                      "   AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("apfg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT apfgdocno ",
                      " FROM apfg_t ", 
                      " LEFT JOIN apfi_t ON apfient = apfgent AND apfgdocno = apfidocno", "  ",
                      " WHERE apfgent = '" ||g_enterprise|| "' ",
                      "   AND TRIM(apfi009) IS NULL ",
                      "   AND ",l_wc CLIPPED, cl_sql_add_filter("apfg_t"),
                      " UNION ",
                      " SELECT DISTINCT apfgdocno ",
                      " FROM apfg_t,apfi_t ", 
                      " WHERE apfient = apfgent AND apfgdocno = apfidocno ",
                      "   AND apfgent = '" ||g_enterprise|| "' ",
#                      "   AND apfi009 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                      "   AND apfi009 IN(",g_sql_bank,")",#160122-00001#14 mod by 07675
                      "   AND ",l_wc CLIPPED, cl_sql_add_filter("apfg_t")
   END IF
   #160122-00001#14----add--end
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
      INITIALIZE g_apfg_m.* TO NULL
      CALL g_apfh_d.clear()        
      CALL g_apfh2_d.clear() 
      CALL g_apfh3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.apfgdocno,t0.apfg002,t0.apfgdocdt,t0.apfgsite,t0.apfg001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apfgstus,t0.apfgdocno,t0.apfg002,t0.apfgdocdt,t0.apfgsite,t0.apfg001, 
          t1.pmaal004 ,t2.ooefl003 ,t3.ooag011 ",
                  " FROM apfg_t t0",
                  "  ",
                  "  LEFT JOIN apfh_t ON apfhent = apfgent AND apfgdocno = apfhdocno ", "  ", 
                  #add-point:browser_fill段sql(apfh_t1) name="browser_fill.join.apfh_t1"
                  
                  #end add-point
                  "  LEFT JOIN apfi_t ON apfient = apfgent AND apfgdocno = apfidocno", "  ", 
                  #add-point:browser_fill段sql(apfi_t1) name="browser_fill.join.apfi_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.apfg002 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.apfgsite AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.apfg001  ",
 
                  " WHERE t0.apfgent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("apfg_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apfgstus,t0.apfgdocno,t0.apfg002,t0.apfgdocdt,t0.apfgsite,t0.apfg001, 
          t1.pmaal004 ,t2.ooefl003 ,t3.ooag011 ",
                  " FROM apfg_t t0",
                  "  ",
                                 " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.apfg002 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.apfgsite AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.apfg001  ",
 
                  " WHERE t0.apfgent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("apfg_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #161115-00042#5-add(s)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = apfgent ",
                        "                AND pmaa001 = apfg004 )"
   END IF
   #161115-00042#5-add(e)
   #160122-00001#14----add--str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apfgstus,t0.apfgdocno,t0.apfg002,t0.apfgdocdt,t0.apfgsite,t0.apfg001, 
          t1.pmaal004 ,t2.ooefl003 ,t3.ooag011 ",
                  " FROM apfg_t t0",
                  "  ",
                  "  LEFT JOIN apfh_t ON apfhent = apfgent AND apfgdocno = apfhdocno ", "  ", 
                  "  LEFT JOIN apfi_t ON apfient = apfgent AND apfgdocno = apfidocno", "  ", 
                  " LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=t0.apfg002 AND t1.pmaal002='"||g_dlang||"' ",
                  " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.apfgsite AND t2.ooefl002='"||g_dlang||"' ",
                  " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.apfg001  ",
 
                  " WHERE t0.apfgent = '" ||g_enterprise|| "' ",
                  "   AND TRIM(apfi009) IS NULL ",
                  "   AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("apfg_t"),
                  " UNION ",
                  " SELECT DISTINCT t4.apfgstus,t4.apfgdocno,t4.apfg002,t4.apfgdocdt,t4.apfgsite,t4.apfg001, 
          t5.pmaal004 ,t6.ooefl003 ,t7.ooag011 ",
                  " FROM apfg_t t4",
                  "  ",
                  "  LEFT JOIN apfh_t ON apfhent = apfgent AND apfgdocno = apfhdocno ", "  ", 
                  " LEFT JOIN pmaal_t t5 ON t5.pmaalent='"||g_enterprise||"' AND t5.pmaal001=t4.apfg002 AND t5.pmaal002='"||g_dlang||"' ",
                  " LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=t4.apfgsite AND t6.ooefl002='"||g_dlang||"' ",
                  " LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=t4.apfg001  ",
                  " ,apfi_t ",
                  " WHERE apfient = t4.apfgent AND t4.apfgdocno = apfidocno ",
                  "   AND t4.apfgent = '" ||g_enterprise|| "' ",
#                  "   AND apfi009 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                  "   AND apfi009 IN(",g_sql_bank,")",#160122-00001#14 mod by 07675
                  "   AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("apfg_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apfgstus,t0.apfgdocno,t0.apfg002,t0.apfgdocdt,t0.apfgsite,t0.apfg001, 
          t1.pmaal004 ,t2.ooefl003 ,t3.ooag011 ",
                  " FROM apfg_t t0",
                  "  ",
                                 " LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=t0.apfg002 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.apfgsite AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.apfg001  ",
               "  LEFT JOIN apfi_t ON apfient = t0.apfgent AND t0.apfgdocno = apfidocno", "  ", 
 
                  " WHERE t0.apfgent = '" ||g_enterprise|| "' ",
                  "   AND TRIM(apfi009) IS NULL ",
                  "   AND ",l_wc, cl_sql_add_filter("apfg_t"),
                  " UNION ",
                  " SELECT DISTINCT t4.apfgstus,t4.apfgdocno,t4.apfg002,t4.apfgdocdt,t4.apfgsite,t4.apfg001, 
          t5.pmaal004 ,t6.ooefl003 ,t7.ooag011 ",
                  " FROM apfg_t t4",
                  "  ",
                  " LEFT JOIN pmaal_t t5 ON t5.pmaalent='"||g_enterprise||"' AND t5.pmaal001=t4.apfg002 AND t5.pmaal002='"||g_dlang||"' ",
                  " LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=t4.apfgsite AND t6.ooefl002='"||g_dlang||"' ",
                  " LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=t4.apfg001  ",
                  " ,apfi_t ",
                  " WHERE apfient = t4.apfgent AND t4.apfgdocno = apfidocno ",
                  "   AND t4.apfgent = '" ||g_enterprise|| "' ",
#                  "   AND apfi009 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                  "   AND apfi009 IN(",g_sql_bank,")",#160122-00001#14 mod by 07675
                  "   AND ",l_wc, cl_sql_add_filter("apfg_t")
                  
   END IF
   #160122-00001#14----add--end
   #end add-point
   LET g_sql = g_sql, " ORDER BY apfgdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"apfg_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_apfgdocno,g_browser[g_cnt].b_apfg002, 
          g_browser[g_cnt].b_apfgdocdt,g_browser[g_cnt].b_apfgsite,g_browser[g_cnt].b_apfg001,g_browser[g_cnt].b_apfg002_desc, 
          g_browser[g_cnt].b_apfgsite_desc,g_browser[g_cnt].b_apfg001_desc
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
      
         #遮罩相關處理
         CALL aapt460_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_apfgdocno) THEN
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
 
{<section id="aapt460.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aapt460_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_apfg_m.apfgdocno = g_browser[g_current_idx].b_apfgdocno   
 
   EXECUTE aapt460_master_referesh USING g_apfg_m.apfgdocno INTO g_apfg_m.apfgsite,g_apfg_m.apfg001, 
       g_apfg_m.apfgld,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfgstus, 
       g_apfg_m.apfgownid,g_apfg_m.apfgowndp,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtdp,g_apfg_m.apfgcrtdt, 
       g_apfg_m.apfgmodid,g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid, 
       g_apfg_m.apfgpstdt,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001_desc,g_apfg_m.apfgld_desc,g_apfg_m.apfg002_desc, 
       g_apfg_m.apfgownid_desc,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid_desc,g_apfg_m.apfgcrtdp_desc, 
       g_apfg_m.apfgmodid_desc,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgpstid_desc
   
   CALL aapt460_apfg_t_mask()
   CALL aapt460_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aapt460.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aapt460_ui_detailshow()
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
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapt460_ui_browser_refresh()
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
      IF g_browser[l_i].b_apfgdocno = g_apfg_m.apfgdocno 
 
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
 
{<section id="aapt460.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt460_construct()
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
   DEFINE l_apfh006  LIKE apfh_t.apfh006
   DEFINE l_ld_str    STRING  #161014-00053#3 add
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_apfg_m.* TO NULL
   CALL g_apfh_d.clear()        
   CALL g_apfh2_d.clear() 
   CALL g_apfh3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   LET g_site_str = NULL   #161014-00053#3
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON apfgsite,apfg001,apfgld,apfgcomp,apfgdocno,apfgdocno_desc,apfgdocdt, 
          apfg002,apfgstus,apfgownid,apfgowndp,apfgcrtid,apfgcrtdp,apfgcrtdt,apfgmodid,apfgmoddt,apfgcnfid, 
          apfgcnfdt,apfgpstid,apfgpstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apfgcrtdt>>----
         AFTER FIELD apfgcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apfgmoddt>>----
         AFTER FIELD apfgmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apfgcnfdt>>----
         AFTER FIELD apfgcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apfgpstdt>>----
         AFTER FIELD apfgpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.apfgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgsite
            #add-point:ON ACTION controlp INFIELD apfgsite name="construct.c.apfgsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#5   mark
            CALL q_ooef001_46()   #161006-00005#5   add               #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfgsite  #顯示到畫面上
            NEXT FIELD apfgsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgsite
            #add-point:BEFORE FIELD apfgsite name="construct.b.apfgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgsite
            
            #add-point:AFTER FIELD apfgsite name="construct.a.apfgsite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str   #161014-00053#3 add
            #END add-point
            
 
 
         #Ctrlp:construct.c.apfg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfg001
            #add-point:ON ACTION controlp INFIELD apfg001 name="construct.c.apfg001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfg001  #顯示到畫面上
            NEXT FIELD apfg001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfg001
            #add-point:BEFORE FIELD apfg001 name="construct.b.apfg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfg001
            
            #add-point:AFTER FIELD apfg001 name="construct.a.apfg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apfgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgld
            #add-point:ON ACTION controlp INFIELD apfgld name="construct.c.apfgld"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段     
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str #161014-00053#3 add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #LET g_qryparam.where = " glaald IN ",g_wc_cs_ld   #160125-00005#6              #161014-00053#3 mark
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')" #161014-00053#3 add
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO apfgld
            NEXT FIELD apfgld
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgld
            #add-point:BEFORE FIELD apfgld name="construct.b.apfgld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgld
            
            #add-point:AFTER FIELD apfgld name="construct.a.apfgld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apfgcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgcomp
            #add-point:ON ACTION controlp INFIELD apfgcomp name="construct.c.apfgcomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfgcomp  #顯示到畫面上
            NEXT FIELD apfgcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgcomp
            #add-point:BEFORE FIELD apfgcomp name="construct.b.apfgcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgcomp
            
            #add-point:AFTER FIELD apfgcomp name="construct.a.apfgcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgdocno
            #add-point:BEFORE FIELD apfgdocno name="construct.b.apfgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgdocno
            
            #add-point:AFTER FIELD apfgdocno name="construct.a.apfgdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apfgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgdocno
            #add-point:ON ACTION controlp INFIELD apfgdocno name="construct.c.apfgdocno"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161115-00042#5-add(s)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = apfgent ",
                                                       "                AND pmaa001 = apfg002 )"
            END IF
            #查詢依帳套權限管理
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apfgld")
            LET g_qryparam.where = l_ld_str
            #161115-00042#5-add(e)
            #161104-00046#5 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#5 --e add  
            CALL q_apfgdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfgdocno  #顯示到畫面上
            NEXT FIELD apfgdocno                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgdocno_desc
            #add-point:BEFORE FIELD apfgdocno_desc name="construct.b.apfgdocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgdocno_desc
            
            #add-point:AFTER FIELD apfgdocno_desc name="construct.a.apfgdocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apfgdocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgdocno_desc
            #add-point:ON ACTION controlp INFIELD apfgdocno_desc name="construct.c.apfgdocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgdocdt
            #add-point:BEFORE FIELD apfgdocdt name="construct.b.apfgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgdocdt
            
            #add-point:AFTER FIELD apfgdocdt name="construct.a.apfgdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apfgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgdocdt
            #add-point:ON ACTION controlp INFIELD apfgdocdt name="construct.c.apfgdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apfg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfg002
            #add-point:ON ACTION controlp INFIELD apfg002 name="construct.c.apfg002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            #161014-00053#3 --s add
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161014-00053#3 --e add
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfg002  #顯示到畫面上
            NEXT FIELD apfg002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfg002
            #add-point:BEFORE FIELD apfg002 name="construct.b.apfg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfg002
            
            #add-point:AFTER FIELD apfg002 name="construct.a.apfg002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgstus
            #add-point:BEFORE FIELD apfgstus name="construct.b.apfgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgstus
            
            #add-point:AFTER FIELD apfgstus name="construct.a.apfgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apfgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgstus
            #add-point:ON ACTION controlp INFIELD apfgstus name="construct.c.apfgstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apfgownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgownid
            #add-point:ON ACTION controlp INFIELD apfgownid name="construct.c.apfgownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfgownid  #顯示到畫面上
            NEXT FIELD apfgownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgownid
            #add-point:BEFORE FIELD apfgownid name="construct.b.apfgownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgownid
            
            #add-point:AFTER FIELD apfgownid name="construct.a.apfgownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apfgowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgowndp
            #add-point:ON ACTION controlp INFIELD apfgowndp name="construct.c.apfgowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfgowndp  #顯示到畫面上
            NEXT FIELD apfgowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgowndp
            #add-point:BEFORE FIELD apfgowndp name="construct.b.apfgowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgowndp
            
            #add-point:AFTER FIELD apfgowndp name="construct.a.apfgowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apfgcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgcrtid
            #add-point:ON ACTION controlp INFIELD apfgcrtid name="construct.c.apfgcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfgcrtid  #顯示到畫面上
            NEXT FIELD apfgcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgcrtid
            #add-point:BEFORE FIELD apfgcrtid name="construct.b.apfgcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgcrtid
            
            #add-point:AFTER FIELD apfgcrtid name="construct.a.apfgcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apfgcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgcrtdp
            #add-point:ON ACTION controlp INFIELD apfgcrtdp name="construct.c.apfgcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfgcrtdp  #顯示到畫面上
            NEXT FIELD apfgcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgcrtdp
            #add-point:BEFORE FIELD apfgcrtdp name="construct.b.apfgcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgcrtdp
            
            #add-point:AFTER FIELD apfgcrtdp name="construct.a.apfgcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgcrtdt
            #add-point:BEFORE FIELD apfgcrtdt name="construct.b.apfgcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apfgmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgmodid
            #add-point:ON ACTION controlp INFIELD apfgmodid name="construct.c.apfgmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfgmodid  #顯示到畫面上
            NEXT FIELD apfgmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgmodid
            #add-point:BEFORE FIELD apfgmodid name="construct.b.apfgmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgmodid
            
            #add-point:AFTER FIELD apfgmodid name="construct.a.apfgmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgmoddt
            #add-point:BEFORE FIELD apfgmoddt name="construct.b.apfgmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apfgcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgcnfid
            #add-point:ON ACTION controlp INFIELD apfgcnfid name="construct.c.apfgcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfgcnfid  #顯示到畫面上
            NEXT FIELD apfgcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgcnfid
            #add-point:BEFORE FIELD apfgcnfid name="construct.b.apfgcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgcnfid
            
            #add-point:AFTER FIELD apfgcnfid name="construct.a.apfgcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgcnfdt
            #add-point:BEFORE FIELD apfgcnfdt name="construct.b.apfgcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apfgpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgpstid
            #add-point:ON ACTION controlp INFIELD apfgpstid name="construct.c.apfgpstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfgpstid  #顯示到畫面上
            NEXT FIELD apfgpstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgpstid
            #add-point:BEFORE FIELD apfgpstid name="construct.b.apfgpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgpstid
            
            #add-point:AFTER FIELD apfgpstid name="construct.a.apfgpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgpstdt
            #add-point:BEFORE FIELD apfgpstdt name="construct.b.apfgpstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON apfhseq,apfh001,apfh006,apfh004,apfh002,apfh003,apfh008,apfh100,apfh103, 
          apfh101,apfh104,apfh005,apfh201,apfh204,apfh007
           FROM s_detail1[1].apfhseq,s_detail1[1].apfh001,s_detail1[1].apfh006,s_detail1[1].apfh004, 
               s_detail1[1].apfh002,s_detail1[1].apfh003,s_detail1[1].apfh008,s_detail1[1].apfh100,s_detail1[1].apfh103, 
               s_detail1[1].apfh101,s_detail1[1].apfh104,s_detail1[1].apfh005,s_detail1[1].apfh201,s_detail1[1].apfh204, 
               s_detail1[1].apfh007
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfhseq
            #add-point:BEFORE FIELD apfhseq name="construct.b.page1.apfhseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfhseq
            
            #add-point:AFTER FIELD apfhseq name="construct.a.page1.apfhseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfhseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfhseq
            #add-point:ON ACTION controlp INFIELD apfhseq name="construct.c.page1.apfhseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.apfh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh001
            #add-point:ON ACTION controlp INFIELD apfh001 name="construct.c.page1.apfh001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_wc_cs_orga) THEN         #160125-00005#6
   			   LET g_qryparam.where = " ooef001 IN ",g_wc_cs_orga
   			END IF         #160125-00005#6
            #CALL q_ooef001()     #161006-00005#5   mark
            CALL q_ooef001_33()   #161006-00005#5   add 
            DISPLAY g_qryparam.return1 TO apfh001
            NEXT FIELD apfh001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh001
            #add-point:BEFORE FIELD apfh001 name="construct.b.page1.apfh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh001
            
            #add-point:AFTER FIELD apfh001 name="construct.a.page1.apfh001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh006
            #add-point:BEFORE FIELD apfh006 name="construct.b.page1.apfh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh006
            
            #add-point:AFTER FIELD apfh006 name="construct.a.page1.apfh006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh006
            #add-point:ON ACTION controlp INFIELD apfh006 name="construct.c.page1.apfh006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh004
            #add-point:BEFORE FIELD apfh004 name="construct.b.page1.apfh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh004
            
            #add-point:AFTER FIELD apfh004 name="construct.a.page1.apfh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh004
            #add-point:ON ACTION controlp INFIELD apfh004 name="construct.c.page1.apfh004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh002
            #add-point:BEFORE FIELD apfh002 name="construct.b.page1.apfh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh002
            
            #add-point:AFTER FIELD apfh002 name="construct.a.page1.apfh002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh002
            #add-point:ON ACTION controlp INFIELD apfh002 name="construct.c.page1.apfh002"
            LET l_apfh006 = ''
            LET l_apfh006 = GET_FLDBUF(apfh006)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE            
            CASE l_apfh006
               WHEN '10'   #付款
                  CALL q_nmckdocno_2()                    #呼叫開窗
               WHEN '16'   #收票轉付
                  CALL q_nmbadocno_3()
            END CASE
            DISPLAY g_qryparam.return1 TO apfh006
            NEXT FIELD apfh006 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh003
            #add-point:BEFORE FIELD apfh003 name="construct.b.page1.apfh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh003
            
            #add-point:AFTER FIELD apfh003 name="construct.a.page1.apfh003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh003
            #add-point:ON ACTION controlp INFIELD apfh003 name="construct.c.page1.apfh003"
            ###160818-00035#1-----s
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            CALL q_nmas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfh003  #顯示到畫面上
            NEXT FIELD apfh003    
            ###160818-00035#1-----e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh008
            #add-point:BEFORE FIELD apfh008 name="construct.b.page1.apfh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh008
            
            #add-point:AFTER FIELD apfh008 name="construct.a.page1.apfh008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh008
            #add-point:ON ACTION controlp INFIELD apfh008 name="construct.c.page1.apfh008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.apfh100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh100
            #add-point:ON ACTION controlp INFIELD apfh100 name="construct.c.page1.apfh100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfh100  #顯示到畫面上
            NEXT FIELD apfh100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh100
            #add-point:BEFORE FIELD apfh100 name="construct.b.page1.apfh100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh100
            
            #add-point:AFTER FIELD apfh100 name="construct.a.page1.apfh100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh103
            #add-point:BEFORE FIELD apfh103 name="construct.b.page1.apfh103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh103
            
            #add-point:AFTER FIELD apfh103 name="construct.a.page1.apfh103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfh103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh103
            #add-point:ON ACTION controlp INFIELD apfh103 name="construct.c.page1.apfh103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh101
            #add-point:BEFORE FIELD apfh101 name="construct.b.page1.apfh101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh101
            
            #add-point:AFTER FIELD apfh101 name="construct.a.page1.apfh101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfh101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh101
            #add-point:ON ACTION controlp INFIELD apfh101 name="construct.c.page1.apfh101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh104
            #add-point:BEFORE FIELD apfh104 name="construct.b.page1.apfh104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh104
            
            #add-point:AFTER FIELD apfh104 name="construct.a.page1.apfh104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfh104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh104
            #add-point:ON ACTION controlp INFIELD apfh104 name="construct.c.page1.apfh104"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.apfh005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh005
            #add-point:ON ACTION controlp INFIELD apfh005 name="construct.c.page1.apfh005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfh005  #顯示到畫面上
            NEXT FIELD apfh005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh005
            #add-point:BEFORE FIELD apfh005 name="construct.b.page1.apfh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh005
            
            #add-point:AFTER FIELD apfh005 name="construct.a.page1.apfh005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh201
            #add-point:BEFORE FIELD apfh201 name="construct.b.page1.apfh201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh201
            
            #add-point:AFTER FIELD apfh201 name="construct.a.page1.apfh201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfh201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh201
            #add-point:ON ACTION controlp INFIELD apfh201 name="construct.c.page1.apfh201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh204
            #add-point:BEFORE FIELD apfh204 name="construct.b.page1.apfh204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh204
            
            #add-point:AFTER FIELD apfh204 name="construct.a.page1.apfh204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfh204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh204
            #add-point:ON ACTION controlp INFIELD apfh204 name="construct.c.page1.apfh204"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh007
            #add-point:BEFORE FIELD apfh007 name="construct.b.page1.apfh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh007
            
            #add-point:AFTER FIELD apfh007 name="construct.a.page1.apfh007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apfh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh007
            #add-point:ON ACTION controlp INFIELD apfh007 name="construct.c.page1.apfh007"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON apfiseq,apfi001,apfi002,apfi006,apfi003,apfi004,apfi005,apfi011,apfi100, 
          apfi101,apfi103,apfi104,apfi201,apfi204,apfi013,apfi012,apfi009,apfi010,apfi008,apfi007
           FROM s_detail2[1].apfiseq,s_detail2[1].apfi001,s_detail2[1].apfi002,s_detail2[1].apfi006, 
               s_detail2[1].apfi003,s_detail2[1].apfi004,s_detail2[1].apfi005,s_detail2[1].apfi011,s_detail2[1].apfi100, 
               s_detail2[1].apfi101,s_detail2[1].apfi103,s_detail2[1].apfi104,s_detail2[1].apfi201,s_detail2[1].apfi204, 
               s_detail2[1].apfi013,s_detail3[1].apfi012,s_detail3[1].apfi009,s_detail3[1].apfi010,s_detail3[1].apfi008, 
               s_detail3[1].apfi007
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfiseq
            #add-point:BEFORE FIELD apfiseq name="construct.b.page2.apfiseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfiseq
            
            #add-point:AFTER FIELD apfiseq name="construct.a.page2.apfiseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfiseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfiseq
            #add-point:ON ACTION controlp INFIELD apfiseq name="construct.c.page2.apfiseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.apfi001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi001
            #add-point:ON ACTION controlp INFIELD apfi001 name="construct.c.page2.apfi001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_wc_cs_orga) THEN         #160125-00005#6
   			   LET g_qryparam.where = " ooef001 IN ",g_wc_cs_orga,
   			                          " AND ooef003 = 'Y'"   #161006-00005#5   add
   			END IF         #160125-00005#6
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO apfi001
            NEXT FIELD apfi001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi001
            #add-point:BEFORE FIELD apfi001 name="construct.b.page2.apfi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi001
            
            #add-point:AFTER FIELD apfi001 name="construct.a.page2.apfi001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi002
            #add-point:ON ACTION controlp INFIELD apfi002 name="construct.c.page2.apfi002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfi002  #顯示到畫面上
            NEXT FIELD apfi002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi002
            #add-point:BEFORE FIELD apfi002 name="construct.b.page2.apfi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi002
            
            #add-point:AFTER FIELD apfi002 name="construct.a.page2.apfi002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi006
            #add-point:BEFORE FIELD apfi006 name="construct.b.page2.apfi006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi006
            
            #add-point:AFTER FIELD apfi006 name="construct.a.page2.apfi006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi006
            #add-point:ON ACTION controlp INFIELD apfi006 name="construct.c.page2.apfi006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi003
            #add-point:BEFORE FIELD apfi003 name="construct.b.page2.apfi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi003
            
            #add-point:AFTER FIELD apfi003 name="construct.a.page2.apfi003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi003
            #add-point:ON ACTION controlp INFIELD apfi003 name="construct.c.page2.apfi003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi004
            #add-point:BEFORE FIELD apfi004 name="construct.b.page2.apfi004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi004
            
            #add-point:AFTER FIELD apfi004 name="construct.a.page2.apfi004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi004
            #add-point:ON ACTION controlp INFIELD apfi004 name="construct.c.page2.apfi004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi005
            #add-point:BEFORE FIELD apfi005 name="construct.b.page2.apfi005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi005
            
            #add-point:AFTER FIELD apfi005 name="construct.a.page2.apfi005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi005
            #add-point:ON ACTION controlp INFIELD apfi005 name="construct.c.page2.apfi005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi011
            #add-point:BEFORE FIELD apfi011 name="construct.b.page2.apfi011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi011
            
            #add-point:AFTER FIELD apfi011 name="construct.a.page2.apfi011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi011
            #add-point:ON ACTION controlp INFIELD apfi011 name="construct.c.page2.apfi011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.apfi100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi100
            #add-point:ON ACTION controlp INFIELD apfi100 name="construct.c.page2.apfi100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfi100  #顯示到畫面上
            NEXT FIELD apfi100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi100
            #add-point:BEFORE FIELD apfi100 name="construct.b.page2.apfi100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi100
            
            #add-point:AFTER FIELD apfi100 name="construct.a.page2.apfi100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi101
            #add-point:BEFORE FIELD apfi101 name="construct.b.page2.apfi101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi101
            
            #add-point:AFTER FIELD apfi101 name="construct.a.page2.apfi101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi101
            #add-point:ON ACTION controlp INFIELD apfi101 name="construct.c.page2.apfi101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi103
            #add-point:BEFORE FIELD apfi103 name="construct.b.page2.apfi103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi103
            
            #add-point:AFTER FIELD apfi103 name="construct.a.page2.apfi103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi103
            #add-point:ON ACTION controlp INFIELD apfi103 name="construct.c.page2.apfi103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi104
            #add-point:BEFORE FIELD apfi104 name="construct.b.page2.apfi104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi104
            
            #add-point:AFTER FIELD apfi104 name="construct.a.page2.apfi104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi104
            #add-point:ON ACTION controlp INFIELD apfi104 name="construct.c.page2.apfi104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi201
            #add-point:BEFORE FIELD apfi201 name="construct.b.page2.apfi201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi201
            
            #add-point:AFTER FIELD apfi201 name="construct.a.page2.apfi201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi201
            #add-point:ON ACTION controlp INFIELD apfi201 name="construct.c.page2.apfi201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi204
            #add-point:BEFORE FIELD apfi204 name="construct.b.page2.apfi204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi204
            
            #add-point:AFTER FIELD apfi204 name="construct.a.page2.apfi204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi204
            #add-point:ON ACTION controlp INFIELD apfi204 name="construct.c.page2.apfi204"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi013
            #add-point:BEFORE FIELD apfi013 name="construct.b.page2.apfi013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi013
            
            #add-point:AFTER FIELD apfi013 name="construct.a.page2.apfi013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apfi013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi013
            #add-point:ON ACTION controlp INFIELD apfi013 name="construct.c.page2.apfi013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.apfi012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi012
            #add-point:ON ACTION controlp INFIELD apfi012 name="construct.c.page3.apfi012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3211"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfi012  #顯示到畫面上
            NEXT FIELD apfi012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi012
            #add-point:BEFORE FIELD apfi012 name="construct.b.page3.apfi012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi012
            
            #add-point:AFTER FIELD apfi012 name="construct.a.page3.apfi012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi009
            #add-point:BEFORE FIELD apfi009 name="construct.b.page3.apfi009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi009
            
            #add-point:AFTER FIELD apfi009 name="construct.a.page3.apfi009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apfi009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi009
            #add-point:ON ACTION controlp INFIELD apfi009 name="construct.c.page3.apfi009"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#14--add---str
#            LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"  #160122-00001#14 mod by 07675                  
            #160122-00001#14--add---end
            CALL q_nmas002_6()                           #呼叫開窗
            #160122-00001#14--mod---str
#            DISPLAY g_qryparam.return1 TO xrfc009  #顯示到畫面上
#            NEXT FIELD xrfc009                     #返回原欄位
            DISPLAY g_qryparam.return1 TO apfi009  #顯示到畫面上
            LET g_qryparam.where = " "          
            NEXT FIELD apfi009                     #返回原欄位
            #160122-00001#14--mod---end
            #END add-point
 
 
         #Ctrlp:construct.c.page3.apfi010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi010
            #add-point:ON ACTION controlp INFIELD apfi010 name="construct.c.page3.apfi010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfi010  #顯示到畫面上
            NEXT FIELD apfi010                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi010
            #add-point:BEFORE FIELD apfi010 name="construct.b.page3.apfi010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi010
            
            #add-point:AFTER FIELD apfi010 name="construct.a.page3.apfi010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apfi008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi008
            #add-point:ON ACTION controlp INFIELD apfi008 name="construct.c.page3.apfi008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfi008  #顯示到畫面上
            NEXT FIELD apfi008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi008
            #add-point:BEFORE FIELD apfi008 name="construct.b.page3.apfi008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi008
            
            #add-point:AFTER FIELD apfi008 name="construct.a.page3.apfi008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.apfi007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi007
            #add-point:ON ACTION controlp INFIELD apfi007 name="construct.c.page3.apfi007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161115-00042#5-add(s)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = pmadent ",
                                      "            AND pmaa001 = pmad001 )"
            END IF
            #161115-00042#5-add(e)
            CALL q_pmad002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apfi007  #顯示到畫面上
            NEXT FIELD apfi007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi007
            #add-point:BEFORE FIELD apfi007 name="construct.b.page3.apfi007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi007
            
            #add-point:AFTER FIELD apfi007 name="construct.a.page3.apfi007"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#49 add
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
                  WHEN la_wc[li_idx].tableid = "apfg_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apfh_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apfi_t" 
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
   #161104-00046#5 --s add
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#5 --e add
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt460.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aapt460_filter()
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
      CONSTRUCT g_wc_filter ON apfgdocno,apfg002,apfgdocdt,apfgsite,apfg001
                          FROM s_browse[1].b_apfgdocno,s_browse[1].b_apfg002,s_browse[1].b_apfgdocdt, 
                              s_browse[1].b_apfgsite,s_browse[1].b_apfg001
 
         BEFORE CONSTRUCT
               DISPLAY aapt460_filter_parser('apfgdocno') TO s_browse[1].b_apfgdocno
            DISPLAY aapt460_filter_parser('apfg002') TO s_browse[1].b_apfg002
            DISPLAY aapt460_filter_parser('apfgdocdt') TO s_browse[1].b_apfgdocdt
            DISPLAY aapt460_filter_parser('apfgsite') TO s_browse[1].b_apfgsite
            DISPLAY aapt460_filter_parser('apfg001') TO s_browse[1].b_apfg001
      
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
 
      CALL aapt460_filter_show('apfgdocno')
   CALL aapt460_filter_show('apfg002')
   CALL aapt460_filter_show('apfgdocdt')
   CALL aapt460_filter_show('apfgsite')
   CALL aapt460_filter_show('apfg001')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt460.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aapt460_filter_parser(ps_field)
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
 
{<section id="aapt460.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aapt460_filter_show(ps_field)
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
   LET ls_condition = aapt460_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapt460.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapt460_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF   
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_apfh_d.clear()
   CALL g_apfh2_d.clear()
   CALL g_apfh3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aapt460_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapt460_browser_fill("")
      CALL aapt460_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aapt460_filter_show('apfgdocno')
   CALL aapt460_filter_show('apfg002')
   CALL aapt460_filter_show('apfgdocdt')
   CALL aapt460_filter_show('apfgsite')
   CALL aapt460_filter_show('apfg001')
   CALL aapt460_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aapt460_fetch("F") 
      #顯示單身筆數
      CALL aapt460_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt460.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapt460_fetch(p_flag)
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
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_apfg_m.apfgdocno = g_browser[g_current_idx].b_apfgdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aapt460_master_referesh USING g_apfg_m.apfgdocno INTO g_apfg_m.apfgsite,g_apfg_m.apfg001, 
       g_apfg_m.apfgld,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfgstus, 
       g_apfg_m.apfgownid,g_apfg_m.apfgowndp,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtdp,g_apfg_m.apfgcrtdt, 
       g_apfg_m.apfgmodid,g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid, 
       g_apfg_m.apfgpstdt,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001_desc,g_apfg_m.apfgld_desc,g_apfg_m.apfg002_desc, 
       g_apfg_m.apfgownid_desc,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid_desc,g_apfg_m.apfgcrtdp_desc, 
       g_apfg_m.apfgmodid_desc,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgpstid_desc
   
   #遮罩相關處理
   LET g_apfg_m_mask_o.* =  g_apfg_m.*
   CALL aapt460_apfg_t_mask()
   LET g_apfg_m_mask_n.* =  g_apfg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt460_set_act_visible()   
   CALL aapt460_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apfg_m_t.* = g_apfg_m.*
   LET g_apfg_m_o.* = g_apfg_m.*
   
   LET g_data_owner = g_apfg_m.apfgownid      
   LET g_data_dept  = g_apfg_m.apfgowndp
   
   #重新顯示   
   CALL aapt460_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt460.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt460_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_apfh_d.clear()   
   CALL g_apfh2_d.clear()  
   CALL g_apfh3_d.clear()  
 
 
   INITIALIZE g_apfg_m.* TO NULL             #DEFAULT 設定
   
   LET g_apfgdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apfg_m.apfgownid = g_user
      LET g_apfg_m.apfgowndp = g_dept
      LET g_apfg_m.apfgcrtid = g_user
      LET g_apfg_m.apfgcrtdp = g_dept 
      LET g_apfg_m.apfgcrtdt = cl_get_current()
      LET g_apfg_m.apfgmodid = g_user
      LET g_apfg_m.apfgmoddt = cl_get_current()
      LET g_apfg_m.apfgstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_apfg_m.apfg001   = g_user        #帳務人員
      LET g_apfg_m.apfgdocdt = g_today       #帳款日期
      CALL s_desc_get_person_desc(g_apfg_m.apfg001) RETURNING g_apfg_m.apfg001_desc

      CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,g_apfg_m.apfgsite,g_apfg_m.apfgld,g_apfg_m.apfgcomp
      CALL s_desc_get_department_desc(g_apfg_m.apfgsite) RETURNING g_apfg_m.apfgsite_desc
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apfg_m.apfgcomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#5 add #161229-00047#49 mark
      CALL s_fin_get_wc_str(g_apfg_m.apfgcomp) RETURNING g_comp_str  #161229-00047#49 add 
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#49 add 
      #160825-00012#1--s
      CALL s_fin_account_center_sons_query('3',g_apfg_m.apfgsite,g_apfg_m.apfgdocdt,'1') 
      CALL s_fin_account_center_comp_str() RETURNING g_wc_apfgcomp
      CALL s_fin_get_wc_str(g_wc_apfgcomp) RETURNING g_wc_apfgcomp
      CALL s_fin_account_center_ld_str() RETURNING g_wc_apfgld
      CALL s_fin_get_wc_str(g_wc_apfgld) RETURNING g_wc_apfgld    
      #160825-00012#1--e      
      #設定帳別相關預設值
      IF NOT cl_null(g_apfg_m.apfgld) THEN
         CALL s_desc_get_ld_desc(g_apfg_m.apfgld)  RETURNING g_apfg_m.apfgld_desc
         CALL aapt460_set_ld_info(g_apfg_m.apfgld,'')
      END IF
      DISPLAY BY NAME g_apfg_m.apfgsite,g_apfg_m.apfgsite_desc,g_apfg_m.apfgld,g_apfg_m.apfgld_desc,
                      g_apfg_m.apfg001,g_apfg_m.apfg001_desc,g_apfg_m.apfgdocdt
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_apfg_m_t.* = g_apfg_m.*
      LET g_apfg_m_o.* = g_apfg_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apfg_m.apfgstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
 
 
 
    
      CALL aapt460_input("a")
      
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
         INITIALIZE g_apfg_m.* TO NULL
         INITIALIZE g_apfh_d TO NULL
         INITIALIZE g_apfh2_d TO NULL
         INITIALIZE g_apfh3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aapt460_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_apfh_d.clear()
      #CALL g_apfh2_d.clear()
      #CALL g_apfh3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt460_set_act_visible()   
   CALL aapt460_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apfgdocno_t = g_apfg_m.apfgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apfgent = " ||g_enterprise|| " AND",
                      " apfgdocno = '", g_apfg_m.apfgdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt460_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aapt460_cl
   
   CALL aapt460_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapt460_master_referesh USING g_apfg_m.apfgdocno INTO g_apfg_m.apfgsite,g_apfg_m.apfg001, 
       g_apfg_m.apfgld,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfgstus, 
       g_apfg_m.apfgownid,g_apfg_m.apfgowndp,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtdp,g_apfg_m.apfgcrtdt, 
       g_apfg_m.apfgmodid,g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid, 
       g_apfg_m.apfgpstdt,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001_desc,g_apfg_m.apfgld_desc,g_apfg_m.apfg002_desc, 
       g_apfg_m.apfgownid_desc,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid_desc,g_apfg_m.apfgcrtdp_desc, 
       g_apfg_m.apfgmodid_desc,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgpstid_desc
   
   
   #遮罩相關處理
   LET g_apfg_m_mask_o.* =  g_apfg_m.*
   CALL aapt460_apfg_t_mask()
   LET g_apfg_m_mask_n.* =  g_apfg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apfg_m.apfgsite,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001,g_apfg_m.apfg001_desc,g_apfg_m.apfgld, 
       g_apfg_m.apfgld_desc,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocno_desc,g_apfg_m.apfgdocdt, 
       g_apfg_m.apfg002,g_apfg_m.apfg002_desc,g_apfg_m.apfgstus,g_apfg_m.apfgownid,g_apfg_m.apfgownid_desc, 
       g_apfg_m.apfgowndp,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtid_desc,g_apfg_m.apfgcrtdp, 
       g_apfg_m.apfgcrtdp_desc,g_apfg_m.apfgcrtdt,g_apfg_m.apfgmodid,g_apfg_m.apfgmodid_desc,g_apfg_m.apfgmoddt, 
       g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid,g_apfg_m.apfgpstid_desc, 
       g_apfg_m.apfgpstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_apfg_m.apfgownid      
   LET g_data_dept  = g_apfg_m.apfgowndp
   
   #功能已完成,通報訊息中心
   CALL aapt460_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt460_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apfg_m_t.* = g_apfg_m.*
   LET g_apfg_m_o.* = g_apfg_m.*
   
   IF g_apfg_m.apfgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_apfgdocno_t = g_apfg_m.apfgdocno
 
   CALL s_transaction_begin()
   
   OPEN aapt460_cl USING g_enterprise,g_apfg_m.apfgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt460_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt460_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt460_master_referesh USING g_apfg_m.apfgdocno INTO g_apfg_m.apfgsite,g_apfg_m.apfg001, 
       g_apfg_m.apfgld,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfgstus, 
       g_apfg_m.apfgownid,g_apfg_m.apfgowndp,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtdp,g_apfg_m.apfgcrtdt, 
       g_apfg_m.apfgmodid,g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid, 
       g_apfg_m.apfgpstdt,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001_desc,g_apfg_m.apfgld_desc,g_apfg_m.apfg002_desc, 
       g_apfg_m.apfgownid_desc,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid_desc,g_apfg_m.apfgcrtdp_desc, 
       g_apfg_m.apfgmodid_desc,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgpstid_desc
   
   #檢查是否允許此動作
   IF NOT aapt460_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apfg_m_mask_o.* =  g_apfg_m.*
   CALL aapt460_apfg_t_mask()
   LET g_apfg_m_mask_n.* =  g_apfg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   CALL s_fin_account_center_sons_query('3',g_apfg_m.apfgsite,g_apfg_m.apfgdocdt,'1')
   CALL s_fin_account_center_comp_str() RETURNING g_wc_apfgcomp
   CALL s_fin_get_wc_str(g_wc_apfgcomp) RETURNING g_wc_apfgcomp  
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apfgld
   CALL s_fin_get_wc_str(g_wc_apfgld) RETURNING g_wc_apfgld 
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL aapt460_show()
   #add-point:modify段show之後 name="modify.after_show"
   IF g_apfg_m.apfgstus NOT MATCHES '[NDR]' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = g_apfg_m.apfgstus
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_apfgdocno_t = g_apfg_m.apfgdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_apfg_m.apfgmodid = g_user 
LET g_apfg_m.apfgmoddt = cl_get_current()
LET g_apfg_m.apfgmodid_desc = cl_get_username(g_apfg_m.apfgmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      LET g_apfg_m_o.* = g_apfg_m.*  #舊值備份
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_apfg_m.apfgstus MATCHES "[DR]" THEN 
         LET g_apfg_m.apfgstus = "N"
      END IF 
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aapt460_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE apfg_t SET (apfgmodid,apfgmoddt) = (g_apfg_m.apfgmodid,g_apfg_m.apfgmoddt)
          WHERE apfgent = g_enterprise AND apfgdocno = g_apfgdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_apfg_m.* = g_apfg_m_t.*
            CALL aapt460_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_apfg_m.apfgdocno != g_apfg_m_t.apfgdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE apfh_t SET apfhdocno = g_apfg_m.apfgdocno
 
          WHERE apfhent = g_enterprise AND apfhdocno = g_apfg_m_t.apfgdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apfh_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apfh_t:",SQLERRMESSAGE 
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
         
         UPDATE apfi_t
            SET apfidocno = g_apfg_m.apfgdocno
 
          WHERE apfient = g_enterprise AND
                apfidocno = g_apfgdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apfi_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apfi_t:",SQLERRMESSAGE 
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
   CALL aapt460_set_act_visible()   
   CALL aapt460_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " apfgent = " ||g_enterprise|| " AND",
                      " apfgdocno = '", g_apfg_m.apfgdocno, "' "
 
   #填到對應位置
   CALL aapt460_browser_fill("")
 
   CLOSE aapt460_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt460_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aapt460.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapt460_input(p_cmd)
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
   DEFINE  ls_js                 STRING
   DEFINE  lc_param_apfh002      RECORD
                orga             LIKE apfh_t.apfh001, #代付組織
                apfh002          LIKE apfh_t.apfh002, #已付款單號
                apfh003          LIKE apfh_t.apfh003, #付款帳戶
                apfh004          LIKE apfh_t.apfh004, #款別性質
                apfh006          LIKE apfh_t.apfh006, #付款類型
                apfh008          LIKE apfh_t.apfh008  #票據號碼
                             END RECORD
   DEFINE  l_wc_apfi003          STRING 
   DEFINE  l_sfin2002            LIKE type_t.chr1
   DEFINE  l_ooef019             LIKE ooef_t.ooef019
   DEFINE  l_oodb004             LIKE oodb_t.oodb004
   DEFINE  l_apce048             LIKE apce_t.apce048
   DEFINE  l_no_use              LIKE type_t.chr1
   
   DEFINE l_nmag002              LIKE nmag_t.nmag002
   DEFINE l_comp_wc              STRING  #161014-00053#3 add
   DEFINE l_flag                 LIKE type_t.num5      #161104-00046#5
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
   DISPLAY BY NAME g_apfg_m.apfgsite,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001,g_apfg_m.apfg001_desc,g_apfg_m.apfgld, 
       g_apfg_m.apfgld_desc,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocno_desc,g_apfg_m.apfgdocdt, 
       g_apfg_m.apfg002,g_apfg_m.apfg002_desc,g_apfg_m.apfgstus,g_apfg_m.apfgownid,g_apfg_m.apfgownid_desc, 
       g_apfg_m.apfgowndp,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtid_desc,g_apfg_m.apfgcrtdp, 
       g_apfg_m.apfgcrtdp_desc,g_apfg_m.apfgcrtdt,g_apfg_m.apfgmodid,g_apfg_m.apfgmodid_desc,g_apfg_m.apfgmoddt, 
       g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid,g_apfg_m.apfgpstid_desc, 
       g_apfg_m.apfgpstdt
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT apfhseq,apfh001,apfhld,apfh006,apfh004,apfh002,apfh003,apfh008,apfh100, 
       apfh103,apfh101,apfh104,apfh005,apfh201,apfh204,apfh007 FROM apfh_t WHERE apfhent=? AND apfhdocno=?  
       AND apfhseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt460_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT apfiseq,apfi001,apfi002,apfi006,apfi003,apfi004,apfi005,apfi011,apfi100, 
       apfi101,apfi103,apfi104,apfi201,apfi204,apfi013,apfiseq,apfi012,apfi009,apfi010,apfi008,apfi007  
       FROM apfi_t WHERE apfient=? AND apfidocno=? AND apfiseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt460_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aapt460_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aapt460_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_apfg_m.apfgsite,g_apfg_m.apfg001,g_apfg_m.apfgld,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno, 
       g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfgstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aapt460.input.head" >}
      #單頭段
      INPUT BY NAME g_apfg_m.apfgsite,g_apfg_m.apfg001,g_apfg_m.apfgld,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno, 
          g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfgstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aapt460_cl USING g_enterprise,g_apfg_m.apfgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt460_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt460_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aapt460_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aapt460_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgsite
            
            #add-point:AFTER FIELD apfgsite name="input.a.apfgsite"
            LET g_apfg_m.apfgsite_desc = ''
            IF NOT cl_null(g_apfg_m.apfgsite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apfg_m.apfgsite != g_apfg_m_t.apfgsite OR cl_null(g_apfg_m_t.apfgsite) )) THEN  #160822-00008#3  mark
               IF g_apfg_m.apfgsite != g_apfg_m_o.apfgsite OR cl_null(g_apfg_m_o.apfgsite) THEN                                       #160822-00008#3
                  #以目前的資料重展結構,避免[帳套]有值時會比對錯誤,在s_fin_account_center_with_ld_chk做勾稽時會依據這個結構做是否有符合的帳套
                  CALL s_fin_account_center_sons_query('3',g_apfg_m.apfgsite,g_apfg_m.apfgdocdt,'1')
                  #如果帳務中心不同 且帳套有值 先依據現在的帳務中心跟帳套勾稽一次---(S)---
                  #避免USER 在帳務中心跟帳套卡住走不了 增加對帳套有資料的處理
                  #IF g_apfg_m_t.apfgsite != g_apfg_m.apfgsite AND NOT cl_null(g_apfg_m.apfgld) THEN   #160822-00008#3  mark
                  IF g_apfg_m_o.apfgsite != g_apfg_m.apfgsite AND NOT cl_null(g_apfg_m.apfgld) THEN    #160822-00008#3
                     CALL s_fin_account_center_with_ld_chk(g_apfg_m.apfgsite,g_apfg_m.apfgld,g_user,'3','N','',g_apfg_m.apfgdocdt) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        #勾稽失敗:目前的帳套不在這個帳務中心下 因此預設值給帳務中心的主帳套
                        CALL s_fin_orga_get_comp_ld(g_apfg_m.apfgsite) RETURNING g_sub_success,g_errno,g_apfg_m.apfgcomp,g_apfg_m.apfgld
                        #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apfg_m.apfgcomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#5 add  #161229-00047#49 mark
                        CALL s_fin_get_wc_str(g_apfg_m.apfgcomp) RETURNING g_comp_str  #161229-00047#49 add 
                        CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#49 add 
                        #判斷這個主帳套使用者是否有權限
                        CALL s_fin_account_center_with_ld_chk(g_apfg_m.apfgsite,g_apfg_m.apfgld,g_user,'3','N','',g_apfg_m.apfgdocdt) RETURNING g_sub_success,g_errno
                     END IF
                     #判斷完成後 若勾稽失敗則回復舊值
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_apfg_m.apfgsite = g_apfg_m_t.apfgsite  #160822-00008#3  mark
                        #LET g_apfg_m.apfgld   = g_apfg_m_t.apfgld    #160822-00008#3  mark
                        LET g_apfg_m.apfgsite = g_apfg_m_o.apfgsite   #160822-00008#3
                        LET g_apfg_m.apfgld   = g_apfg_m_o.apfgld     #160822-00008#3
                        CALL s_desc_get_department_desc(g_apfg_m.apfgsite) RETURNING g_apfg_m.apfgsite_desc
                        DISPLAY BY NAME g_apfg_m.apfgsite_desc
                        NEXT FIELD CURRENT
                     END IF
                     CALL s_desc_get_ld_desc(g_apfg_m.apfgld) RETURNING g_apfg_m.apfgld_desc
                     CALL aapt460_set_ld_info(g_apfg_m.apfgld,'')
                     DISPLAY BY NAME g_apfg_m.apfgld_desc
                  END IF
                  #如果帳務中心不同 且帳套有值 先依據現在的帳務中心跟帳套勾稽一次---(E)---
                  CALL s_fin_account_center_with_ld_chk(g_apfg_m.apfgsite,g_apfg_m.apfgld,g_user,'3','N','',g_apfg_m.apfgdocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apfg_m.apfgsite = g_apfg_m_t.apfgsite   #160822-00008#3  mark
                     LET g_apfg_m.apfgsite = g_apfg_m_o.apfgsite    #160822-00008#3
                     CALL s_desc_get_department_desc(g_apfg_m.apfgsite) RETURNING g_apfg_m.apfgsite_desc
                     DISPLAY BY NAME g_apfg_m.apfgsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               CALL s_fin_account_center_sons_query('3',g_apfg_m.apfgsite,g_apfg_m.apfgdocdt,'1')  #依據正確的資料再重展一次結構
               CALL s_fin_account_center_comp_str() RETURNING g_wc_apfgcomp
               CALL s_fin_get_wc_str(g_wc_apfgcomp) RETURNING g_wc_apfgcomp
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apfgld
               CALL s_fin_get_wc_str(g_wc_apfgld) RETURNING g_wc_apfgld 
               LET g_apfg_m_t.apfgsite = g_apfg_m.apfgsite
            END IF
            CALL s_desc_get_department_desc(g_apfg_m.apfgsite) RETURNING g_apfg_m.apfgsite_desc                    
            DISPLAY BY NAME g_apfg_m.apfgsite_desc
            #161014-00053#3 --s add
            CALL s_fin_account_center_sons_query('3',g_apfg_m.apfgsite,g_today,'1')  #依據正確的資料再重展一次結構
            #取得帳務中心底下的帳套範圍 
            CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
            CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
            #161014-00053#3 --e add
            LET g_apfg_m_o.* = g_apfg_m.*   #160822-00008#3
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgsite
            #add-point:BEFORE FIELD apfgsite name="input.b.apfgsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfgsite
            #add-point:ON CHANGE apfgsite name="input.g.apfgsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfg001
            
            #add-point:AFTER FIELD apfg001 name="input.a.apfg001"
            LET g_apfg_m.apfg001_desc = ' '
            IF NOT cl_null(g_apfg_m.apfg001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apfg_m.apfg001 != g_apfg_m_t.apfg001 OR g_apfg_m_t.apfg001 IS NULL )) THEN  #160822-00008#3  mark
               IF g_apfg_m.apfg001 != g_apfg_m_o.apfg001 OR cl_null(g_apfg_m_o.apfg001) THEN                                      #160822-00008#3
                  LET g_errno = ''
                  CALL s_employee_chk(g_apfg_m.apfg001) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     #LET g_apfg_m.apfg001 = g_apfg_m_t.apfg001  #160822-00008#3  mark
                     LET g_apfg_m.apfg001 = g_apfg_m_o.apfg001   #160822-00008#3
                     CALL s_desc_get_person_desc(g_apfg_m.apfg001) RETURNING g_apfg_m.apfg001_desc
                     DISPLAY BY NAME g_apfg_m.apfg001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_apfg_m.apfg001) RETURNING g_apfg_m.apfg001_desc
            DISPLAY BY NAME g_apfg_m.apfg001_desc 
            LET g_apfg_m_o.* = g_apfg_m.*   #160822-00008#3
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfg001
            #add-point:BEFORE FIELD apfg001 name="input.b.apfg001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfg001
            #add-point:ON CHANGE apfg001 name="input.g.apfg001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgld
            
            #add-point:AFTER FIELD apfgld name="input.a.apfgld"
            LET g_apfg_m.apfgld_desc = ''
            #IF NOT cl_null(g_apfg_m.apfgld) AND NOT cl_null(g_apfg_m.apfgsite) THEN  #161014-00053#3 mark
            IF NOT cl_null(g_apfg_m.apfgld) THEN  #161014-00053#3 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apfg_m.apfgld != g_apfg_m_t.apfgld OR g_apfg_m_t.apfgld IS NULL )) THEN    #160822-00008#3  mark
               IF g_apfg_m.apfgld != g_apfg_m_o.apfgld OR cl_null(g_apfg_m_o.apfgld) THEN                                        #160822-00008#3
                  #CALL s_fin_account_center_with_ld_chk(g_apfg_m.apfgsite,g_apfg_m.apfgld,g_user,'3','N',g_wc_apfgld,g_apfg_m.apfgdocdt) RETURNING g_sub_success,g_errno #161014-00053#3 mark
                  CALL s_fin_account_center_with_ld_chk(g_apfg_m.apfgsite,g_apfg_m.apfgld,g_user,'3','Y',g_wc_apcald,g_apfg_m.apfgdocdt) RETURNING g_sub_success,g_errno      #161014-00053#3 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apfg_m.apfgld = g_apfg_m_t.apfgld      #160822-00008#3  mark
                     #LET g_apfg_m.apfgcomp = g_apfg_m_t.apfgcomp  #160822-00008#3  mark
                     LET g_apfg_m.apfgld = g_apfg_m_o.apfgld       #160822-00008#3
                     LET g_apfg_m.apfgcomp = g_apfg_m_o.apfgcomp   #160822-00008#3
                     NEXT FIELD CURRENT
                  END IF
                  CALL aapt460_set_ld_info(g_apfg_m.apfgld,'')
               END IF
            END IF
            CALL s_desc_get_ld_desc(g_apfg_m.apfgld) RETURNING g_apfg_m.apfgld_desc
            DISPLAY BY NAME g_apfg_m.apfgld_desc
            LET g_apfg_m_o.* = g_apfg_m.*   #160822-00008#3
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgld
            #add-point:BEFORE FIELD apfgld name="input.b.apfgld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfgld
            #add-point:ON CHANGE apfgld name="input.g.apfgld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgcomp
            #add-point:BEFORE FIELD apfgcomp name="input.b.apfgcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgcomp
            
            #add-point:AFTER FIELD apfgcomp name="input.a.apfgcomp"
            LET g_apfg_m_o.* = g_apfg_m.*   #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfgcomp
            #add-point:ON CHANGE apfgcomp name="input.g.apfgcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgdocno
            
            #add-point:AFTER FIELD apfgdocno name="input.a.apfgdocno"
            LET g_apfg_m.apfgdocno_desc = ' '
            IF NOT cl_null(g_apfg_m.apfgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (cl_null(g_apfg_m_t.apfgdocno) OR g_apfg_m.apfgdocno != g_apfg_m_t.apfgdocno)) THEN 
                  #檢查是否有重複的單據編號(企業代碼/帳別/單號)
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apfg_t WHERE "||"apfgent = '" ||g_enterprise|| "' AND "||"apfgdocno = '"||g_apfg_m.apfgdocno ||"'  AND "||"apfgld = '"||g_apfg_m.apfgld ||"' ",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_fin_chk_docno(g_apfg_m.apfgld,'','',g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt,g_prog) THEN
                     LET g_apfg_m.apfgdocno = g_apfg_m_t.apfgdocno
                     NEXT FIELD CURRENT
                  END IF                                  
               END IF
               #161104-00046#5 --s add
               CALL s_control_chk_doc('1',g_apfg_m.apfgdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN             
               ELSE
                  LET g_apfg_m.apfgdocno = g_apfg_m_t.apfgdocno
                  NEXT FIELD CURRENT                  
               END IF
               CALL s_aooi200_fin_get_slip(g_apfg_m.apfgdocno) RETURNING g_sub_success,g_ap_slip
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_apfg_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_apfg_m.apfgsite,'2',g_ap_slip,'','',g_apfg_m.apfgld)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_apfg_m.* FROM s_aooi200def1
               #161104-00046#5 --e add 
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_apfg_m.apfgdocno) RETURNING g_apfg_m.apfgdocno_desc
            DISPLAY BY NAME g_apfg_m.apfgdocno_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgdocno
            #add-point:BEFORE FIELD apfgdocno name="input.b.apfgdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfgdocno
            #add-point:ON CHANGE apfgdocno name="input.g.apfgdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgdocdt
            #add-point:BEFORE FIELD apfgdocdt name="input.b.apfgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgdocdt
            
            #add-point:AFTER FIELD apfgdocdt name="input.a.apfgdocdt"
            IF NOT cl_null(g_apfg_m.apfgdocdt) THEN
               CALL s_fin_date_close_chk('',g_apfg_m.apfgcomp,'AAP',g_apfg_m.apfgdocdt) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_apfg_m.apfgdocdt= g_apfg_m_t.apfgdocdt
                  NEXT FIELD CURRENT
               END IF  
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apfg_m.apfgdocdt != g_apfg_m_t.apfgdocdt OR g_apfg_m_t.apfgdocdt IS NULL )) THEN
                  CALL s_fin_account_center_with_ld_chk(g_apfg_m.apfgsite,g_apfg_m.apfgld,g_user,'3','N',g_wc_apfgld,g_apfg_m.apfgdocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apfg_m.apfgdocdt= g_apfg_m_t.apfgdocdt
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfgdocdt
            #add-point:ON CHANGE apfgdocdt name="input.g.apfgdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfg002
            
            #add-point:AFTER FIELD apfg002 name="input.a.apfg002"
            LET g_apfg_m.apfg002_desc = ''
            IF NOT cl_null(g_apfg_m.apfg002) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apfg_m.apfg002 != g_apfg_m_t.apfg002 OR g_apfg_m_t.apfg002 IS NULL )) THEN  #160822-00008#3  mark
               IF g_apfg_m.apfg002 != g_apfg_m_o.apfg002 OR cl_null(g_apfg_m_o.apfg002) THEN                                      #160822-00008#3
                  CALL s_aap_apca004_chk(g_apfg_m.apfg002) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#21 --s add
                     LET g_errparam.replace[1] = 'apmm100'
                     LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                     LET g_errparam.exeprog = 'apmm100'
                     #160321-00016#21 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apfg_m.apfg002 = g_apfg_m_t.apfg002  #160822-00008#3  mark
                     LET g_apfg_m.apfg002 = g_apfg_m_o.apfg002  #160822-00008#3
                     CALL s_desc_get_trading_partner_abbr_desc(g_apfg_m.apfg002) RETURNING g_apfg_m.apfg002_desc
                     DISPLAY BY NAME g_apfg_m.apfg002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161014-00053#3 --s add
                  #檢核客戶在控制組與單據別控制內是否可使用(整合)
                  CALL s_control_check_supplier(g_apfg_m.apfg002,'4',g_apfg_m.apfgsite,g_user,g_dept,'')
                  RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     #檢查失敗時後續處理
                     LET g_apfg_m.apfg002 = g_apfg_m_o.apfg002
                     #發票客戶說明
                     CALL s_desc_get_trading_partner_abbr_desc(g_apfg_m.apfg002) RETURNING g_apfg_m.apfg002_desc
                     DISPLAY BY NAME g_apfg_m.apfg002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161014-00053#3 --e add               
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_apfg_m.apfg002) RETURNING g_apfg_m.apfg002_desc
            DISPLAY BY NAME g_apfg_m.apfg002_desc
            LET g_apfg_m_o.* = g_apfg_m.*   #160822-00008#3
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfg002
            #add-point:BEFORE FIELD apfg002 name="input.b.apfg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfg002
            #add-point:ON CHANGE apfg002 name="input.g.apfg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfgstus
            #add-point:BEFORE FIELD apfgstus name="input.b.apfgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfgstus
            
            #add-point:AFTER FIELD apfgstus name="input.a.apfgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfgstus
            #add-point:ON CHANGE apfgstus name="input.g.apfgstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apfgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgsite
            #add-point:ON ACTION controlp INFIELD apfgsite name="input.c.apfgsite"
            #帳務中心  
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfg_m.apfgsite             
            #CALL q_ooef001()     #161006-00005#5   mark
            CALL q_ooef001_46()   #161006-00005#5   add                               #呼叫開窗
            LET g_apfg_m.apfgsite = g_qryparam.return1          
            CALL s_desc_get_department_desc(g_apfg_m.apfgsite) RETURNING g_apfg_m.apfgsite_desc                    
            DISPLAY BY NAME g_apfg_m.apfgsite,g_apfg_m.apfgsite_desc            
            NEXT FIELD apfgsite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apfg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfg001
            #add-point:ON ACTION controlp INFIELD apfg001 name="input.c.apfg001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfg_m.apfg001             #給予default值
            CALL q_ooag001()            
            LET g_apfg_m.apfg001 = g_qryparam.return1              
            CALL s_desc_get_person_desc(g_apfg_m.apfg001) RETURNING g_apfg_m.apfg001_desc
            DISPLAY BY NAME g_apfg_m.apfg001,g_apfg_m.apfg001_desc
            NEXT FIELD apfg001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apfgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgld
            #add-point:ON ACTION controlp INFIELD apfgld name="input.c.apfgld"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #161014-00053#3 --s add
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_comp_wc
            #將取回的字串轉換為SQL條件
            CALL aapt460_get_ooef001_wc(l_comp_wc) RETURNING l_comp_wc
            #161014-00053#3 --e add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfg_m.apfgld             #給予default值
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            #LET g_qryparam.where = " glaald IN ",g_wc_apfgld                                         #161014-00053#3 mark
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,""  #161014-00053#3 add
            CALL q_authorised_ld()                                #呼叫開窗
            CALL s_desc_get_ld_desc(g_apfg_m.apfgld) RETURNING g_apfg_m.apfgld_desc
            LET g_apfg_m.apfgld = g_qryparam.return1              
            DISPLAY BY NAME g_apfg_m.apfgld,g_apfg_m.apfgld_desc
            NEXT FIELD apfgld                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apfgcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgcomp
            #add-point:ON ACTION controlp INFIELD apfgcomp name="input.c.apfgcomp"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apfg_m.apfgcomp             #給予default值
            LET g_qryparam.default2 = "" #g_apfg_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooef001()                                #呼叫開窗

            LET g_apfg_m.apfgcomp = g_qryparam.return1              
            #LET g_apfg_m.ooef001 = g_qryparam.return2 
            DISPLAY g_apfg_m.apfgcomp TO apfgcomp              #
            #DISPLAY g_apfg_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD apfgcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.apfgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgdocno
            #add-point:ON ACTION controlp INFIELD apfgdocno name="input.c.apfgdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfg_m.apfgdocno             #給予default值
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = g_prog
            #161104-00046#5 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#5 --e add
            CALL q_ooba002_1()          
            LET g_apfg_m.apfgdocno = g_qryparam.return1              
            DISPLAY BY NAME g_apfg_m.apfgdocno
            NEXT FIELD apfgdocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apfgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgdocdt
            #add-point:ON ACTION controlp INFIELD apfgdocdt name="input.c.apfgdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apfg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfg002
            #add-point:ON ACTION controlp INFIELD apfg002 name="input.c.apfg002"
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfg_m.apfg002      
            LET g_qryparam.arg1 = "('1','3')"
            #161014-00053#3 --s add
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161014-00053#3 --e add
            CALL q_pmaa001_1()                          
            LET g_apfg_m.apfg002 = g_qryparam.return1    
            CALL s_desc_get_trading_partner_abbr_desc(g_apfg_m.apfg002) RETURNING g_apfg_m.apfg002_desc
            DISPLAY BY NAME g_apfg_m.apfg002,g_apfg_m.apfg002_desc
            NEXT FIELD apfg002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apfgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfgstus
            #add-point:ON ACTION controlp INFIELD apfgstus name="input.c.apfgstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_apfg_m.apfgdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #新增前才取單號
               CALL s_aooi200_fin_gen_docno(g_apfg_m.apfgld,'','',g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt,g_prog)
                    RETURNING g_sub_success,g_apfg_m.apfgdocno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_apfg_m.apfgdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD apfgdocno
               END IF
               DISPLAY BY NAME g_apfg_m.apfgdocno
               #end add-point
               
               INSERT INTO apfg_t (apfgent,apfgsite,apfg001,apfgld,apfgcomp,apfgdocno,apfgdocdt,apfg002, 
                   apfgstus,apfgownid,apfgowndp,apfgcrtid,apfgcrtdp,apfgcrtdt,apfgmodid,apfgmoddt,apfgcnfid, 
                   apfgcnfdt,apfgpstid,apfgpstdt)
               VALUES (g_enterprise,g_apfg_m.apfgsite,g_apfg_m.apfg001,g_apfg_m.apfgld,g_apfg_m.apfgcomp, 
                   g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfgstus,g_apfg_m.apfgownid, 
                   g_apfg_m.apfgowndp,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtdp,g_apfg_m.apfgcrtdt,g_apfg_m.apfgmodid, 
                   g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid,g_apfg_m.apfgpstdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_apfg_m:",SQLERRMESSAGE 
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
                  CALL aapt460_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aapt460_b_fill()
                  CALL aapt460_b_fill2('0')
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
               CALL aapt460_apfg_t_mask_restore('restore_mask_o')
               
               UPDATE apfg_t SET (apfgsite,apfg001,apfgld,apfgcomp,apfgdocno,apfgdocdt,apfg002,apfgstus, 
                   apfgownid,apfgowndp,apfgcrtid,apfgcrtdp,apfgcrtdt,apfgmodid,apfgmoddt,apfgcnfid,apfgcnfdt, 
                   apfgpstid,apfgpstdt) = (g_apfg_m.apfgsite,g_apfg_m.apfg001,g_apfg_m.apfgld,g_apfg_m.apfgcomp, 
                   g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfgstus,g_apfg_m.apfgownid, 
                   g_apfg_m.apfgowndp,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtdp,g_apfg_m.apfgcrtdt,g_apfg_m.apfgmodid, 
                   g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid,g_apfg_m.apfgpstdt) 
 
                WHERE apfgent = g_enterprise AND apfgdocno = g_apfgdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apfg_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aapt460_apfg_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_apfg_m_t)
               LET g_log2 = util.JSON.stringify(g_apfg_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_apfgdocno_t = g_apfg_m.apfgdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aapt460.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_apfh_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apfh_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt460_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_apfh_d.getLength()
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
            OPEN aapt460_cl USING g_enterprise,g_apfg_m.apfgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt460_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt460_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apfh_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apfh_d[l_ac].apfhseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_apfh_d_t.* = g_apfh_d[l_ac].*  #BACKUP
               LET g_apfh_d_o.* = g_apfh_d[l_ac].*  #BACKUP
               CALL aapt460_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aapt460_set_no_entry_b(l_cmd)
               IF NOT aapt460_lock_b("apfh_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt460_bcl INTO g_apfh_d[l_ac].apfhseq,g_apfh_d[l_ac].apfh001,g_apfh_d[l_ac].apfhld, 
                      g_apfh_d[l_ac].apfh006,g_apfh_d[l_ac].apfh004,g_apfh_d[l_ac].apfh002,g_apfh_d[l_ac].apfh003, 
                      g_apfh_d[l_ac].apfh008,g_apfh_d[l_ac].apfh100,g_apfh_d[l_ac].apfh103,g_apfh_d[l_ac].apfh101, 
                      g_apfh_d[l_ac].apfh104,g_apfh_d[l_ac].apfh005,g_apfh_d[l_ac].apfh201,g_apfh_d[l_ac].apfh204, 
                      g_apfh_d[l_ac].apfh007
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apfh_d_t.apfhseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apfh_d_mask_o[l_ac].* =  g_apfh_d[l_ac].*
                  CALL aapt460_apfh_t_mask()
                  LET g_apfh_d_mask_n[l_ac].* =  g_apfh_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt460_show()
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
            INITIALIZE g_apfh_d[l_ac].* TO NULL 
            INITIALIZE g_apfh_d_t.* TO NULL 
            INITIALIZE g_apfh_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_apfh_d[l_ac].apfhseq = "0"
      LET g_apfh_d[l_ac].apfh103 = "0"
      LET g_apfh_d[l_ac].apfh101 = "0"
      LET g_apfh_d[l_ac].apfh104 = "0"
      LET g_apfh_d[l_ac].apfh201 = "0"
      LET g_apfh_d[l_ac].apfh204 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_apfh_d[l_ac].apfhld  = g_apfg_m.apfgld
            LET g_apfh_d[l_ac].apfh001 = g_apfg_m.apfgcomp  #代付組織
            CALL s_desc_get_department_desc(g_apfh_d[l_ac].apfh001) RETURNING g_apfh_d[l_ac].apfh001_desc              
            DISPLAY BY NAME g_apfh_d[l_ac].apfh001,g_apfh_d[l_ac].apfh001_desc
            LET g_apfh_d[l_ac].apfh006 = '10'   #付款類型
            LET g_apfh_d[l_ac].apfh004 = '20'   #款別性質
            LET g_apfh_d[l_ac].apfh007 = s_fin_get_scc_value('8506',g_apfh_d[l_ac].apfh006,'1')   #160818-00035#1
            DISPLAY BY NAME g_apfh_d[l_ac].apfh007  #160818-00035#1
            LET g_apfh_d[l_ac].apfh100 = g_glaa.glaa001
            LET g_apfh_d[l_ac].apfh101 = 1      
            LET g_apfh_d[l_ac].apfh201 = 1      #代付方本幣匯率
            SELECT MAX(apfhseq)+1 INTO g_apfh_d[l_ac].apfhseq
              FROM apfh_t
             WHERE apfhent = g_enterprise
               AND apfhdocno = g_apfg_m.apfgdocno        
            IF cl_null(g_apfh_d[l_ac].apfhseq) THEN LET g_apfh_d[l_ac].apfhseq = 1 END IF  
            #end add-point
            LET g_apfh_d_t.* = g_apfh_d[l_ac].*     #新輸入資料
            LET g_apfh_d_o.* = g_apfh_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt460_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt460_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apfh_d[li_reproduce_target].* = g_apfh_d[li_reproduce].*
 
               LET g_apfh_d[li_reproduce_target].apfhseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM apfh_t 
             WHERE apfhent = g_enterprise AND apfhdocno = g_apfg_m.apfgdocno
 
               AND apfhseq = g_apfh_d[l_ac].apfhseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apfg_m.apfgdocno
               LET gs_keys[2] = g_apfh_d[g_detail_idx].apfhseq
               CALL aapt460_insert_b('apfh_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_apfh_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apfh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt460_b_fill()
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
               LET gs_keys[01] = g_apfg_m.apfgdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_apfh_d_t.apfhseq
 
            
               #刪除同層單身
               IF NOT aapt460_delete_b('apfh_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt460_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt460_key_delete_b(gs_keys,'apfh_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt460_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt460_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_apfh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apfh_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfhseq
            #add-point:BEFORE FIELD apfhseq name="input.b.page1.apfhseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfhseq
            
            #add-point:AFTER FIELD apfhseq name="input.a.page1.apfhseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_apfg_m.apfgdocno IS NOT NULL AND g_apfh_d[g_detail_idx].apfhseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apfg_m.apfgdocno != g_apfgdocno_t OR g_apfh_d[g_detail_idx].apfhseq != g_apfh_d_t.apfhseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apfh_t WHERE "||"apfhent = '" ||g_enterprise|| "' AND "||"apfhdocno = '"||g_apfg_m.apfgdocno ||"' AND "|| "apfhseq = '"||g_apfh_d[g_detail_idx].apfhseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfhseq
            #add-point:ON CHANGE apfhseq name="input.g.page1.apfhseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh001
            
            #add-point:AFTER FIELD apfh001 name="input.a.page1.apfh001"
            LET g_apfh_d[l_ac].apfh001_desc = ''
            IF NOT cl_null(g_apfh_d[l_ac].apfh001) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apfh_d[l_ac].apfh001 != g_apfh_d_t.apfh001 OR g_apfh_d_t.apfh001 IS NULL )) THEN   #160822-00008#3  mark
               IF g_apfh_d[l_ac].apfh001 != g_apfh_d_o.apfh001 OR cl_null(g_apfh_d_o.apfh001) THEN                                       #160822-00008#3
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apfh_d[l_ac].apfh001
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #LET g_apfh_d[l_ac].apfh001 = g_apfh_d_t.apfh001  #160822-00008#3  mark
                     LET g_apfh_d[l_ac].apfh001 = g_apfh_d_o.apfh001   #160822-00008#3
                     NEXT FIELD CURRENT
                  END IF
                  IF s_chr_get_index_of(g_wc_apfgcomp,g_apfh_d[l_ac].apfh001,1) = 0 THEN
                     LET g_errparam.code = 'aap-00127'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apfh_d[l_ac].apfh001 = g_apfh_d_t.apfh001  #160822-00008#3  mark
                     LET g_apfh_d[l_ac].apfh001 = g_apfh_d_o.apfh001   #160822-00008#3
                     NEXT FIELD CURRENT
                  END IF
               END IF  
            END IF
            CALL s_desc_get_department_desc(g_apfh_d[l_ac].apfh001) RETURNING g_apfh_d[l_ac].apfh001_desc              
            DISPLAY BY NAME g_apfh_d[l_ac].apfh001_desc
            #kris15/11/10:缴款单一定是单头“账套”归属的法人的,所以代付時, 付款個選項只能跟單頭同帳套, 同法人
            IF g_apfh_d[l_ac].apfh001 <> g_apfg_m.apfgcomp THEN
               LET g_apfh_d[l_ac].apfh006 = ''     #付款類型
               LET g_apfh_d[l_ac].apfh004 = ''     #款別性質
               CALL aapt460_set_entry_b(l_cmd)
               CALL aapt460_set_no_entry_b(l_cmd)
               CALL aapt460_tran_rate_apfh('Y')
               NEXT FIELD apfh006
            END IF
            LET g_apfh_d_o.* = g_apfh_d[l_ac].*    #160822-00008#3
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh001
            #add-point:BEFORE FIELD apfh001 name="input.b.page1.apfh001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh001
            #add-point:ON CHANGE apfh001 name="input.g.page1.apfh001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfhld
            
            #add-point:AFTER FIELD apfhld name="input.a.page1.apfhld"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apfh_d[l_ac].apfhld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apfh_d[l_ac].apfhld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apfh_d[l_ac].apfhld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfhld
            #add-point:BEFORE FIELD apfhld name="input.b.page1.apfhld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfhld
            #add-point:ON CHANGE apfhld name="input.g.page1.apfhld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh006
            #add-point:BEFORE FIELD apfh006 name="input.b.page1.apfh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh006
            
            #add-point:AFTER FIELD apfh006 name="input.a.page1.apfh006"
            LET g_apfh_d_o.* = g_apfh_d[l_ac].*    #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh006
            #add-point:ON CHANGE apfh006 name="input.g.page1.apfh006"
            LET g_apfh_d[l_ac].apfh007 = s_fin_get_scc_value('8506',g_apfh_d[l_ac].apfh006,'1')
            DISPLAY BY NAME g_apfh_d[l_ac].apfh007  #160818-00035#1
            #付款類型
            #kris15/11/10:[10.付款]那個選項是跟單頭相同
            IF g_apfh_d[l_ac].apfh001 <> g_apfg_m.apfgcomp AND g_apfh_d[l_ac].apfh006 = '10' THEN
               LET g_apfh_d[l_ac].apfh006 = ''
               NEXT FIELD apfh006
            END IF
            CALL aapt460_set_entry_b(l_cmd)
            CALL aapt460_set_no_entry_b(l_cmd)   
            #非[10.現金]款別清空
            IF g_apfh_d[l_ac].apfh006 <> '10' THEN
               LET g_apfh_d[l_ac].apfh004 =''
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh004
            #add-point:BEFORE FIELD apfh004 name="input.b.page1.apfh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh004
            
            #add-point:AFTER FIELD apfh004 name="input.a.page1.apfh004"
            LET g_apfh_d_o.* = g_apfh_d[l_ac].*    #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh004
            #add-point:ON CHANGE apfh004 name="input.g.page1.apfh004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh002
            #add-point:BEFORE FIELD apfh002 name="input.b.page1.apfh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh002
            
            #add-point:AFTER FIELD apfh002 name="input.a.page1.apfh002"
            #已付款單號
            IF NOT cl_null(g_apfh_d[l_ac].apfh002) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apfh_d[l_ac].apfh002 != g_apfh_d_t.apfh002 OR g_apfh_d_t.apfh002 IS NULL )) THEN  #160822-00008#3  mark
               IF g_apfh_d[l_ac].apfh002 != g_apfh_d_o.apfh002 OR cl_null(g_apfh_d_o.apfh002) THEN                                      #160822-00008#3
                  LET lc_param_apfh002.orga    = g_apfh_d[l_ac].apfh001
                  LET lc_param_apfh002.apfh002 = g_apfh_d[l_ac].apfh002
                  LET lc_param_apfh002.apfh003 = g_apfh_d[l_ac].apfh003
                  LET lc_param_apfh002.apfh004 = g_apfh_d[l_ac].apfh004
                  LET lc_param_apfh002.apfh006 = g_apfh_d[l_ac].apfh006
                  LET lc_param_apfh002.apfh008 = g_apfh_d[l_ac].apfh008
                  LET ls_js = util.JSON.stringify(lc_param_apfh002)
                  CALL s_aapt460_apfh002_chk(ls_js) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apfh_d[l_ac].apfh002 = g_apfh_d_t.apfh002  #160822-00008#3  mark
                     LET g_apfh_d[l_ac].apfh002 = g_apfh_d_o.apfh002   #160822-00008#3
                     NEXT FIELD CURRENT
                  END IF
                  CALL aapt460_set_entry_b(l_cmd)
                  CALL aapt460_set_no_entry_b(l_cmd) 
                  
                  CASE g_apfh_d[l_ac].apfh006
                     WHEN '10'    #付款
                          CALL aapt460_nmck_carry(g_apfh_d[l_ac].apfh001,g_apfh_d[l_ac].apfh002)
                          NEXT FIELD apfh103
                     WHEN '16'   #收票轉付
                          CALL aapt460_nmbb_carry(g_apfh_d[l_ac].apfh001,g_apfh_d[l_ac].apfh002,g_apfh_d[l_ac].apfh008)
                          IF cl_null(g_apfh_d[l_ac].apfh008) THEN 
                             NEXT FIELD apfh008            
                          ELSE
                             NEXT FIELD apfh101
                          END IF                           
                  END CASE
               END IF          
            END IF
            LET g_apfh_d_o.* = g_apfh_d[l_ac].*    #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh002
            #add-point:ON CHANGE apfh002 name="input.g.page1.apfh002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh003
            #add-point:BEFORE FIELD apfh003 name="input.b.page1.apfh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh003
            
            #add-point:AFTER FIELD apfh003 name="input.a.page1.apfh003"
            LET g_apfh_d_o.* = g_apfh_d[l_ac].*    #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh003
            #add-point:ON CHANGE apfh003 name="input.g.page1.apfh003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh008
            #add-point:BEFORE FIELD apfh008 name="input.b.page1.apfh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh008
            
            #add-point:AFTER FIELD apfh008 name="input.a.page1.apfh008"
            LET g_apfh_d_o.* = g_apfh_d[l_ac].*    #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh008
            #add-point:ON CHANGE apfh008 name="input.g.page1.apfh008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh100
            #add-point:BEFORE FIELD apfh100 name="input.b.page1.apfh100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh100
            
            #add-point:AFTER FIELD apfh100 name="input.a.page1.apfh100"
            IF NOT cl_null(g_apfh_d[l_ac].apfh100) THEN  
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apfh_d[l_ac].apfh100 != g_apfh_d_t.apfh100 OR g_apfh_d_t.apfh100 IS NULL )) THEN   #160822-00008#3  mark
               IF g_apfh_d[l_ac].apfh100 != g_apfh_d_o.apfh100 OR cl_null(g_apfh_d_o.apfh100) THEN                                       #160822-00008#3
                  CALL s_aap_ooaj001_chk(g_apfg_m.apfgld,g_apfh_d[l_ac].apfh100) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     #160321-00016#21 --s add
                     LET g_errparam.replace[1] = 'aooi150'
                     LET g_errparam.replace[2] = cl_get_progname('aooi150',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi150'
                     #160321-00016#21 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apfh_d[l_ac].apfh100 = g_apfh_d_t.apfh100  #160822-00008#3  mark
                     LET g_apfh_d[l_ac].apfh100 = g_apfh_d_o.apfh100   #160822-00008#3
                     NEXT FIELD CURRENT
                  END IF            
                  LET g_apfh_d_t.apfh100 = g_apfh_d[l_ac].apfh100
                  #幣別變換時,重取本幣匯率與重算本幣金額
                  CALL aapt460_tran_rate_apfh('Y')   
               END IF
            END IF
            LET g_apfh_d_o.* = g_apfh_d[l_ac].*    #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh100
            #add-point:ON CHANGE apfh100 name="input.g.page1.apfh100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh103
            #add-point:BEFORE FIELD apfh103 name="input.b.page1.apfh103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh103
            
            #add-point:AFTER FIELD apfh103 name="input.a.page1.apfh103"
            CALL aapt460_tran_rate_apfh('N')
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh103
            #add-point:ON CHANGE apfh103 name="input.g.page1.apfh103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh101
            #add-point:BEFORE FIELD apfh101 name="input.b.page1.apfh101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh101
            
            #add-point:AFTER FIELD apfh101 name="input.a.page1.apfh101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh101
            #add-point:ON CHANGE apfh101 name="input.g.page1.apfh101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh104
            #add-point:BEFORE FIELD apfh104 name="input.b.page1.apfh104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh104
            
            #add-point:AFTER FIELD apfh104 name="input.a.page1.apfh104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh104
            #add-point:ON CHANGE apfh104 name="input.g.page1.apfh104"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh005
            
            #add-point:AFTER FIELD apfh005 name="input.a.page1.apfh005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apfh_d[l_ac].apfh005
            CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apfh_d[l_ac].apfh005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apfh_d[l_ac].apfh005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh005
            #add-point:BEFORE FIELD apfh005 name="input.b.page1.apfh005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh005
            #add-point:ON CHANGE apfh005 name="input.g.page1.apfh005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh201
            #add-point:BEFORE FIELD apfh201 name="input.b.page1.apfh201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh201
            
            #add-point:AFTER FIELD apfh201 name="input.a.page1.apfh201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh201
            #add-point:ON CHANGE apfh201 name="input.g.page1.apfh201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh204
            #add-point:BEFORE FIELD apfh204 name="input.b.page1.apfh204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh204
            
            #add-point:AFTER FIELD apfh204 name="input.a.page1.apfh204"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh204
            #add-point:ON CHANGE apfh204 name="input.g.page1.apfh204"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfh007
            #add-point:BEFORE FIELD apfh007 name="input.b.page1.apfh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfh007
            
            #add-point:AFTER FIELD apfh007 name="input.a.page1.apfh007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfh007
            #add-point:ON CHANGE apfh007 name="input.g.page1.apfh007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apfhseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfhseq
            #add-point:ON ACTION controlp INFIELD apfhseq name="input.c.page1.apfhseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh001
            #add-point:ON ACTION controlp INFIELD apfh001 name="input.c.page1.apfh001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段           
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh_d[l_ac].apfh001
            LET g_qryparam.where    = "ooef003 = 'Y' AND ooef017 IN ",g_wc_apfgcomp                   
            #CALL q_ooef001()     #161006-00005#5   mark
            CALL q_ooef001_33()   #161006-00005#5   add 
            LET g_apfh_d[l_ac].apfh001 = g_qryparam.return1              
            DISPLAY g_apfh_d[l_ac].apfh001 TO apfh001
            NEXT FIELD apfh001
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfhld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfhld
            #add-point:ON ACTION controlp INFIELD apfhld name="input.c.page1.apfhld"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh_d[l_ac].apfhld             #給予default值
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            LET g_qryparam.where = " glaald IN ",g_wc_apfgld
            CALL q_authorised_ld()     
            LET g_apfh_d[l_ac].apfhld = g_qryparam.return1              
            DISPLAY g_apfh_d[l_ac].apfhld TO apfhld              #
            NEXT FIELD apfhld                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh006
            #add-point:ON ACTION controlp INFIELD apfh006 name="input.c.page1.apfh006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh004
            #add-point:ON ACTION controlp INFIELD apfh004 name="input.c.page1.apfh004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh002
            #add-point:ON ACTION controlp INFIELD apfh002 name="input.c.page1.apfh002"
            #已付款單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh_d[l_ac].apfh002
            CASE g_apfh_d[l_ac].apfh006      #付款性質
               WHEN '10' 
                  LET g_qryparam.where = " NOT EXISTS ",
                                         "    (SELECT 1 FROM apde_t WHERE apdeent = nmckent ",
                                         "        AND apdeorga = nmcksite ",
                                         "        AND apde003 = nmckdocno ",
                                         "        AND apdedocno = '",g_apfg_m.apfgdocno,"')"
                  LET g_qryparam.arg1 = g_apfh_d[l_ac].apfh001    #資金中心
                  LET g_qryparam.arg2 = g_apfh_d[l_ac].apfh004    #款別性質
                  LET g_qryparam.arg3 = g_apfg_m.apfg002          #付款對象
                  CALL q_nmckdocno_2()
                  LET g_apfh_d[l_ac].apfh002 = g_qryparam.return1      #將開窗取得的值回傳到變數
                  DISPLAY BY NAME g_apfh_d[l_ac].apfh002
               WHEN '16'
                  LET g_qryparam.where = " NOT EXISTS ",
                                         "    (SELECT 1 FROM apde_t WHERE apdeent = nmbaent ",
                                         "        AND apdecomp = nmbacomp ",
                                         "        AND apde003 = nmbadocno )"           
                  LET g_qryparam.arg1 = g_apfg_m.apfgcomp
                  CALL q_nmbadocno_3()
                  LET g_apfh_d[l_ac].apfh008 = g_qryparam.return1       #帳戶/票據號碼
                  LET g_apfh_d[l_ac].apfh002 = g_qryparam.return2       #收支單號
                  DISPLAY BY NAME g_apfh_d[l_ac].apfh002,g_apfh_d[l_ac].apfh003
            END CASE
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh003
            #add-point:ON ACTION controlp INFIELD apfh003 name="input.c.page1.apfh003"
            ###160818-00035#1-----s
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL               
            LET g_qryparam.reqry = FALSE                 
            LET g_qryparam.default1 = g_apfh_d[l_ac].apfh003
            CASE g_apfh_d[l_ac].apfh006
               WHEN '10'
                  #開窗i段
                  #給予arg
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE                 
                  LET g_qryparam.default1 = g_apfh_d[l_ac].apfh003             #給予default值

                  LET l_nmag002 = '5'
                  LET g_qryparam.where =  " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                          "              AND ooef017 = '",g_apfg_m.apfgcomp,"')",                  
                                          " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",
                                          " AND nmagent = nmaaent ",   #160819-00014#1
                                          " AND nmag002 IN ('1','",l_nmag002,"'))",
                                          " AND nmas002 IN (",g_sql_bank,")"
                  CALL q_nmas_01()                                #呼叫開窗
                  LET g_apfh_d[l_ac].apfh003 = g_qryparam.return1
                  LET g_apfh_d[l_ac].apfh100 = s_anm_get_nmas003(g_apfh_d[l_ac].apfh003)
                  DISPLAY BY NAME g_apfh_d[l_ac].apfh100                                                      
            END CASE
            
   
            DISPLAY g_apfh_d[l_ac].apfh003 TO apfh003 
            NEXT FIELD apfh003   #返回原欄位
            ###160818-00035#1-----e
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh008
            #add-point:ON ACTION controlp INFIELD apfh008 name="input.c.page1.apfh008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh100
            #add-point:ON ACTION controlp INFIELD apfh100 name="input.c.page1.apfh100"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh_d[l_ac].apfh100 
            CALL q_ooaj002()                                #呼叫開窗
            LET g_apfh_d[l_ac].apfh100 = g_qryparam.return1              

            DISPLAY g_apfh_d[l_ac].apfh100 TO apfh100              #
            NEXT FIELD apfh100                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh103
            #add-point:ON ACTION controlp INFIELD apfh103 name="input.c.page1.apfh103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh101
            #add-point:ON ACTION controlp INFIELD apfh101 name="input.c.page1.apfh101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh104
            #add-point:ON ACTION controlp INFIELD apfh104 name="input.c.page1.apfh104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh005
            #add-point:ON ACTION controlp INFIELD apfh005 name="input.c.page1.apfh005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段-銀行存提碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh_d[l_ac].apfh005             #給予default值
            LET g_qryparam.arg1 = " nmaj002 = '2'" #提出
            CALL q_nmaj001()                                #呼叫開窗
            LET g_apfh_d[l_ac].apfh005 = g_qryparam.return1         
            DISPLAY g_apfh_d[l_ac].apfh005 TO apfh005              #
            NEXT FIELD apfh005                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh201
            #add-point:ON ACTION controlp INFIELD apfh201 name="input.c.page1.apfh201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh204
            #add-point:ON ACTION controlp INFIELD apfh204 name="input.c.page1.apfh204"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apfh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfh007
            #add-point:ON ACTION controlp INFIELD apfh007 name="input.c.page1.apfh007"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apfh_d[l_ac].* = g_apfh_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt460_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_apfh_d[l_ac].apfhseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_apfh_d[l_ac].* = g_apfh_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               LET g_apfh_d[l_ac].apfh007 = s_fin_get_scc_value('8506',g_apfh_d[l_ac].apfh006,'1')
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aapt460_apfh_t_mask_restore('restore_mask_o')
      
               UPDATE apfh_t SET (apfhdocno,apfhseq,apfh001,apfhld,apfh006,apfh004,apfh002,apfh003,apfh008, 
                   apfh100,apfh103,apfh101,apfh104,apfh005,apfh201,apfh204,apfh007) = (g_apfg_m.apfgdocno, 
                   g_apfh_d[l_ac].apfhseq,g_apfh_d[l_ac].apfh001,g_apfh_d[l_ac].apfhld,g_apfh_d[l_ac].apfh006, 
                   g_apfh_d[l_ac].apfh004,g_apfh_d[l_ac].apfh002,g_apfh_d[l_ac].apfh003,g_apfh_d[l_ac].apfh008, 
                   g_apfh_d[l_ac].apfh100,g_apfh_d[l_ac].apfh103,g_apfh_d[l_ac].apfh101,g_apfh_d[l_ac].apfh104, 
                   g_apfh_d[l_ac].apfh005,g_apfh_d[l_ac].apfh201,g_apfh_d[l_ac].apfh204,g_apfh_d[l_ac].apfh007) 
 
                WHERE apfhent = g_enterprise AND apfhdocno = g_apfg_m.apfgdocno 
 
                  AND apfhseq = g_apfh_d_t.apfhseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apfh_d[l_ac].* = g_apfh_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apfh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apfh_d[l_ac].* = g_apfh_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apfh_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apfg_m.apfgdocno
               LET gs_keys_bak[1] = g_apfgdocno_t
               LET gs_keys[2] = g_apfh_d[g_detail_idx].apfhseq
               LET gs_keys_bak[2] = g_apfh_d_t.apfhseq
               CALL aapt460_update_b('apfh_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aapt460_apfh_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_apfh_d[g_detail_idx].apfhseq = g_apfh_d_t.apfhseq 
 
                  ) THEN
                  LET gs_keys[01] = g_apfg_m.apfgdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_apfh_d_t.apfhseq
 
                  CALL aapt460_key_update_b(gs_keys,'apfh_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apfg_m),util.JSON.stringify(g_apfh_d_t)
               LET g_log2 = util.JSON.stringify(g_apfg_m),util.JSON.stringify(g_apfh_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aapt460_unlock_b("apfh_t","'1'")
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
               LET g_apfh_d[li_reproduce_target].* = g_apfh_d[li_reproduce].*
 
               LET g_apfh_d[li_reproduce_target].apfhseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_apfh_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apfh_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_apfh2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apfh2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt460_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2','3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apfh2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apfh2_d[l_ac].* TO NULL 
            INITIALIZE g_apfh2_d_t.* TO NULL 
            INITIALIZE g_apfh2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_apfh2_d[l_ac].apfiseq = "0"
      LET g_apfh2_d[l_ac].apfi004 = "0"
      LET g_apfh2_d[l_ac].apfi005 = "0"
      LET g_apfh2_d[l_ac].apfi101 = "0"
      LET g_apfh2_d[l_ac].apfi103 = "0"
      LET g_apfh2_d[l_ac].apfi104 = "0"
      LET g_apfh2_d[l_ac].apfi201 = "0"
      LET g_apfh2_d[l_ac].apfi204 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            LET g_apfh2_d[l_ac].apfi001 = g_apfg_m.apfgcomp
            CALL cl_get_para(g_enterprise,g_apfh2_d[l_ac].apfi001,'S-FIN-2002') RETURNING l_sfin2002
            CALL s_desc_get_department_desc(g_apfh2_d[l_ac].apfi001) RETURNING g_apfh2_d[l_ac].apfi001_desc      
            CALL s_fin_get_major_ld(g_apfh2_d[l_ac].apfi001) RETURNING g_apfh2_d[l_ac].apfi002
            SELECT MAX(apfiseq)+1 INTO g_apfh2_d[l_ac].apfiseq
              FROM apfi_t
             WHERE apfient = g_enterprise
               AND apfidocno = g_apfg_m.apfgdocno        
            IF cl_null(g_apfh2_d[l_ac].apfiseq) THEN LET g_apfh2_d[l_ac].apfiseq = 1 END IF  
            #end add-point
            LET g_apfh2_d_t.* = g_apfh2_d[l_ac].*     #新輸入資料
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt460_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt460_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apfh2_d[li_reproduce_target].* = g_apfh2_d[li_reproduce].*
               LET g_apfh3_d[li_reproduce_target].* = g_apfh3_d[li_reproduce].*
 
               LET g_apfh2_d[li_reproduce_target].apfiseq = NULL
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
            OPEN aapt460_cl USING g_enterprise,g_apfg_m.apfgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt460_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt460_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apfh2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apfh2_d[l_ac].apfiseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apfh2_d_t.* = g_apfh2_d[l_ac].*  #BACKUP
               LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #BACKUP
               CALL aapt460_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               IF NOT cl_null(g_apfh2_d[l_ac].apfi001) THEN
                  CALL cl_get_para(g_enterprise,g_apfh2_d[l_ac].apfi001,'S-FIN-2002') RETURNING l_sfin2002
               END IF
               #end add-point  
               CALL aapt460_set_no_entry_b(l_cmd)
               IF NOT aapt460_lock_b("apfi_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt460_bcl2 INTO g_apfh2_d[l_ac].apfiseq,g_apfh2_d[l_ac].apfi001,g_apfh2_d[l_ac].apfi002, 
                      g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004,g_apfh2_d[l_ac].apfi005, 
                      g_apfh2_d[l_ac].apfi011,g_apfh2_d[l_ac].apfi100,g_apfh2_d[l_ac].apfi101,g_apfh2_d[l_ac].apfi103, 
                      g_apfh2_d[l_ac].apfi104,g_apfh2_d[l_ac].apfi201,g_apfh2_d[l_ac].apfi204,g_apfh2_d[l_ac].apfi013, 
                      g_apfh3_d[l_ac].apfiseq,g_apfh3_d[l_ac].apfi012,g_apfh3_d[l_ac].apfi009,g_apfh3_d[l_ac].apfi010, 
                      g_apfh3_d[l_ac].apfi008,g_apfh3_d[l_ac].apfi007
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apfh2_d_mask_o[l_ac].* =  g_apfh2_d[l_ac].*
                  CALL aapt460_apfi_t_mask()
                  LET g_apfh2_d_mask_n[l_ac].* =  g_apfh2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt460_show()
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
               LET gs_keys[01] = g_apfg_m.apfgdocno
               LET gs_keys[gs_keys.getLength()+1] = g_apfh2_d_t.apfiseq
            
               #刪除同層單身
               IF NOT aapt460_delete_b('apfi_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt460_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt460_key_delete_b(gs_keys,'apfi_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt460_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt460_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_apfh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apfh2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM apfi_t 
             WHERE apfient = g_enterprise AND apfidocno = g_apfg_m.apfgdocno
               AND apfiseq = g_apfh2_d[l_ac].apfiseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apfg_m.apfgdocno
               LET gs_keys[2] = g_apfh2_d[g_detail_idx].apfiseq
               CALL aapt460_insert_b('apfi_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apfh_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "apfi_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt460_b_fill()
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
               LET g_apfh2_d[l_ac].* = g_apfh2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt460_bcl2
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
               LET g_apfh2_d[l_ac].* = g_apfh2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               LET g_apfh2_d[l_ac].apfi013 = s_fin_get_scc_value('8506',g_apfh2_d[l_ac].apfi006,'1')
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aapt460_apfi_t_mask_restore('restore_mask_o')
                              
               UPDATE apfi_t SET (apfidocno,apfiseq,apfi001,apfi002,apfi006,apfi003,apfi004,apfi005, 
                   apfi011,apfi100,apfi101,apfi103,apfi104,apfi201,apfi204,apfi013,apfi012,apfi009,apfi010, 
                   apfi008,apfi007) = (g_apfg_m.apfgdocno,g_apfh2_d[l_ac].apfiseq,g_apfh2_d[l_ac].apfi001, 
                   g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004, 
                   g_apfh2_d[l_ac].apfi005,g_apfh2_d[l_ac].apfi011,g_apfh2_d[l_ac].apfi100,g_apfh2_d[l_ac].apfi101, 
                   g_apfh2_d[l_ac].apfi103,g_apfh2_d[l_ac].apfi104,g_apfh2_d[l_ac].apfi201,g_apfh2_d[l_ac].apfi204, 
                   g_apfh2_d[l_ac].apfi013,g_apfh3_d[l_ac].apfi012,g_apfh3_d[l_ac].apfi009,g_apfh3_d[l_ac].apfi010, 
                   g_apfh3_d[l_ac].apfi008,g_apfh3_d[l_ac].apfi007) #自訂欄位頁簽
                WHERE apfient = g_enterprise AND apfidocno = g_apfg_m.apfgdocno
                  AND apfiseq = g_apfh2_d_t.apfiseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apfh2_d[l_ac].* = g_apfh2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apfi_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apfh2_d[l_ac].* = g_apfh2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apfi_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apfg_m.apfgdocno
               LET gs_keys_bak[1] = g_apfgdocno_t
               LET gs_keys[2] = g_apfh2_d[g_detail_idx].apfiseq
               LET gs_keys_bak[2] = g_apfh2_d_t.apfiseq
               CALL aapt460_update_b('apfi_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt460_apfi_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apfh2_d[g_detail_idx].apfiseq = g_apfh2_d_t.apfiseq 
                  ) THEN
                  LET gs_keys[01] = g_apfg_m.apfgdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apfh2_d_t.apfiseq
                  CALL aapt460_key_update_b(gs_keys,'apfi_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apfg_m),util.JSON.stringify(g_apfh2_d_t)
               LET g_log2 = util.JSON.stringify(g_apfg_m),util.JSON.stringify(g_apfh2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfiseq
            #add-point:BEFORE FIELD apfiseq name="input.b.page2.apfiseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfiseq
            
            #add-point:AFTER FIELD apfiseq name="input.a.page2.apfiseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_apfg_m.apfgdocno IS NOT NULL AND g_apfh2_d[g_detail_idx].apfiseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apfg_m.apfgdocno != g_apfgdocno_t OR g_apfh2_d[g_detail_idx].apfiseq != g_apfh2_d_t.apfiseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apfi_t WHERE "||"apfient = '" ||g_enterprise|| "' AND "||"apfidocno = '"||g_apfg_m.apfgdocno ||"' AND "|| "apfiseq = '"||g_apfh2_d[g_detail_idx].apfiseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfiseq
            #add-point:ON CHANGE apfiseq name="input.g.page2.apfiseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi001
            
            #add-point:AFTER FIELD apfi001 name="input.a.page2.apfi001"
            #帳款法人組織
            LET g_apfh2_d[l_ac].apfi001_desc = ''
            IF NOT cl_null(g_apfh2_d[l_ac].apfi001) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apfh2_d[l_ac].apfi001 != g_apfh2_d_t.apfi001 OR g_apfh2_d_t.apfi001 IS NULL )) THEN  #160822-00008#3   mark
               IF g_apfh2_d[l_ac].apfi001 != g_apfh2_d_o.apfi001 OR cl_null(g_apfh2_d_o.apfi001) THEN                                     #160822-00008#3
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apfh2_d[l_ac].apfi001
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #LET g_apfh2_d[l_ac].apfi001 = g_apfh2_d_t.apfi001  #160822-00008#3  mark
                     LET g_apfh2_d[l_ac].apfi001 = g_apfh2_d_o.apfi001   #160822-00008#3
                     NEXT FIELD CURRENT
                  END IF
                  IF s_chr_get_index_of(g_wc_apfgcomp,g_apfh2_d[l_ac].apfi001,1) = 0 THEN
                     LET g_errparam.code = 'aap-00127'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apfh2_d[l_ac].apfi001 = g_apfh2_d_t.apfi001  #160822-00008#3  mark
                     LET g_apfh2_d[l_ac].apfi001 = g_apfh2_d_o.apfi001   #160822-00008#3
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_get_major_ld(g_apfh2_d[l_ac].apfi001) RETURNING g_apfh2_d[l_ac].apfi002
                  CALL cl_get_para(g_enterprise,g_apfh2_d[l_ac].apfi001,'S-FIN-2002') RETURNING l_sfin2002
               END IF  
            END IF
            CALL s_desc_get_department_desc(g_apfh2_d[l_ac].apfi001) RETURNING g_apfh2_d[l_ac].apfi001_desc              
            DISPLAY BY NAME g_apfh2_d[l_ac].apfi001_desc
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi001
            #add-point:BEFORE FIELD apfi001 name="input.b.page2.apfi001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi001
            #add-point:ON CHANGE apfi001 name="input.g.page2.apfi001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi002
            #add-point:BEFORE FIELD apfi002 name="input.b.page2.apfi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi002
            
            #add-point:AFTER FIELD apfi002 name="input.a.page2.apfi002"
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi002
            #add-point:ON CHANGE apfi002 name="input.g.page2.apfi002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi006
            #add-point:BEFORE FIELD apfi006 name="input.b.page2.apfi006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi006
            
            #add-point:AFTER FIELD apfi006 name="input.a.page2.apfi006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi006
            #add-point:ON CHANGE apfi006 name="input.g.page2.apfi006"
            LET g_apfh2_d[l_ac].apfi013 = s_fin_get_scc_value('8506',g_apfh2_d[l_ac].apfi006,'1')
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi003
            #add-point:BEFORE FIELD apfi003 name="input.b.page2.apfi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi003
            
            #add-point:AFTER FIELD apfi003 name="input.a.page2.apfi003"
            IF NOT cl_null(g_apfh2_d[l_ac].apfi003) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apfh2_d[l_ac].apfi003 != g_apfh2_d_t.apfi003 OR g_apfh2_d_t.apfi003 IS NULL )) THEN
                  IF NOT cl_null(g_apfh2_d[l_ac].apfi003) AND NOT cl_null(g_apfh2_d[l_ac].apfi004) AND NOT cl_null(g_apfh2_d[l_ac].apfi005) THEN
                     CALL s_aapt420_exist_chk(g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004,g_apfh2_d[l_ac].apfi005,g_apfg_m.apfg002,'') #151130-00015#4
                             RETURNING g_sub_success,g_errno                        
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apfh2_d[l_ac].apfi003 = g_apfh2_d_t.apfi003
                        DISPLAY BY NAME g_apfh2_d[l_ac].apfi003
                        NEXT FIELD CURRENT
                     END IF                
                     IF g_apfh2_d[l_ac].apfi006[1,1] THEN
                        SELECT apcc009 INTO l_apce048
                          FROM apcc_t
                         WHERE apccent = g_enterprise
                           AND apccld  = l_apce.apceld  AND apccdocno = l_apce.apce003 
                           AND apccseq = l_apce.apce004 AND apcc001 = l_apce.apce005
                     END IF     
                     CALL cl_get_para(g_enterprise,g_apfh2_d[l_ac].apfi001,'S-FIN-2002') RETURNING l_sfin2002
                     #帶回開窗帳款單資訊          
                     CALL s_aapt420_source_doc_carry(g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004,g_apfh2_d[l_ac].apfi002,
                                                     g_apfg_m.apfgdocno,g_apfh2_d[l_ac].apfiseq,g_apfh2_d[l_ac].apfi002,
                                                     g_apfh2_d[l_ac].apfi005  ,l_apce048,l_sfin2002)
                          RETURNING l_no_use      ,l_no_use,g_apfh2_d[l_ac].apfi100,g_apfh2_d[l_ac].apfi103,g_apfh2_d[l_ac].apfi101,
                                    g_apfh2_d[l_ac].apfi104,l_no_use,l_no_use,l_no_use,l_no_use,
                                    l_no_use      ,l_no_use,g_apfh2_d[l_ac].apfi011,l_no_use,l_no_use,
                                    l_no_use      ,l_no_use,l_no_use,l_no_use,l_no_use,
                                    l_no_use      ,l_no_use,l_no_use,l_no_use,l_no_use,
                                    l_no_use      ,l_no_use,l_no_use,l_no_use,l_no_use,
                                    l_no_use      ,l_no_use,l_no_use,l_no_use,l_no_use,
                                    l_no_use
                     #檢核金額不可超出可沖金額
                     CALL s_aapt420_apcc_used_chk(g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004,g_apfh2_d[l_ac].apfi005,
                                                  g_apfh2_d[l_ac].apfi103,g_apfg_m.apfgdocno,g_apfh2_d[l_ac].apfiseq,'1','0')
                                RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apfh2_d[l_ac].apfi003 = g_apfh2_d_t.apfi003
                        DISPLAY BY NAME g_apfh2_d[l_ac].apfi003 
                        NEXT FIELD CURRENT
                     END IF                  
                     CALL s_aapt460_get_rate(g_apfh2_d[l_ac].apfi001,g_apfh2_d[l_ac].apfi001,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfh2_d[l_ac].apfi100)
                          RETURNING l_no_use,g_apfh2_d[l_ac].apfi201
                     
                     LET g_apfh2_d[l_ac].apfi204 = g_apfh2_d[l_ac].apfi103 * g_apfh2_d[l_ac].apfi201
                     IF cl_null(g_apfh2_d[l_ac].apfi204) THEN LET g_apfh2_d[l_ac].apfi204 = 0 END IF
                     CALL s_curr_round_ld('1',g_apfg_m.apfgld,g_glaa.glaa001,g_apfh2_d[l_ac].apfi204,2) 
                          RETURNING g_sub_success,g_errno,g_apfh2_d[l_ac].apfi204
                  END IF
               END IF
            END IF               
            CALL aapt460_tran_rate_apfi('N')
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi003
            #add-point:ON CHANGE apfi003 name="input.g.page2.apfi003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi004
            #add-point:BEFORE FIELD apfi004 name="input.b.page2.apfi004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi004
            
            #add-point:AFTER FIELD apfi004 name="input.a.page2.apfi004"
            IF NOT cl_null(g_apfh2_d[l_ac].apfi004) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apfh2_d[l_ac].apfi004 != g_apfh2_d_t.apfi004 OR g_apfh2_d_t.apfi004 IS NULL )) THEN  #160822-00008#3  mark
               IF g_apfh2_d[l_ac].apfi004 != g_apfh2_d_o.apfi004 OR cl_null(g_apfh2_d_o.apfi004) THEN                                      #160822-00008#3
                  IF NOT cl_null(g_apfh2_d[l_ac].apfi003) AND NOT cl_null(g_apfh2_d[l_ac].apfi004) AND NOT cl_null(g_apfh2_d[l_ac].apfi005) THEN
                     CALL s_aapt420_exist_chk(g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004,g_apfh2_d[l_ac].apfi005,g_apfg_m.apfg002,'') #151130-00015#4
                             RETURNING g_sub_success,g_errno                        
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_apfh2_d[l_ac].apfi004 = g_apfh2_d_t.apfi004  #160822-00008#3  mark
                        LET g_apfh2_d[l_ac].apfi004 = g_apfh2_d_o.apfi004   #160822-00008#3
                        DISPLAY BY NAME g_apfh2_d[l_ac].apfi004
                        NEXT FIELD CURRENT
                     END IF                
                     IF g_apfh2_d[l_ac].apfi006[1,1] THEN
                        SELECT apcc009 INTO l_apce048
                          FROM apcc_t
                         WHERE apccent = g_enterprise
                           AND apccld  = l_apce.apceld  AND apccdocno = l_apce.apce003 
                           AND apccseq = l_apce.apce004 AND apcc001 = l_apce.apce005
                     END IF     
                     CALL cl_get_para(g_enterprise,g_apfh2_d[l_ac].apfi001,'S-FIN-2002') RETURNING l_sfin2002
                     #帶回開窗帳款單資訊          
                     #160822-00008#3--add--s--
                     LET g_apfh2_d[l_ac].apfi100 = ''
                     LET g_apfh2_d[l_ac].apfi103 = ''
                     LET g_apfh2_d[l_ac].apfi101 = ''
                     LET g_apfh2_d[l_ac].apfi104 = ''
                     LET g_apfh2_d[l_ac].apfi011 = ''
                     #160822-00008#3--add--e--
                     CALL s_aapt420_source_doc_carry(g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004,g_apfh2_d[l_ac].apfi002,
                                                     g_apfg_m.apfgdocno,g_apfh2_d[l_ac].apfiseq,g_apfh2_d[l_ac].apfi002,
                                                     g_apfh2_d[l_ac].apfi005  ,l_apce048,l_sfin2002)
                          RETURNING l_no_use      ,l_no_use,g_apfh2_d[l_ac].apfi100,g_apfh2_d[l_ac].apfi103,g_apfh2_d[l_ac].apfi101,
                                    g_apfh2_d[l_ac].apfi104,l_no_use,l_no_use               ,l_no_use,l_no_use,
                                    l_no_use               ,l_no_use,g_apfh2_d[l_ac].apfi011,l_no_use,l_no_use,
                                    l_no_use               ,l_no_use,l_no_use               ,l_no_use,l_no_use,
                                    l_no_use               ,l_no_use,l_no_use               ,l_no_use,l_no_use,
                                    l_no_use               ,l_no_use,l_no_use               ,l_no_use,l_no_use,
                                    l_no_use               ,l_no_use,l_no_use               ,l_no_use,l_no_use,
                                    l_no_use
                     #檢核金額不可超出可沖金額
                     CALL s_aapt420_apcc_used_chk(g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004,g_apfh2_d[l_ac].apfi005,
                                                  g_apfh2_d[l_ac].apfi103,g_apfg_m.apfgdocno,g_apfh2_d[l_ac].apfiseq,'1','0')
                                RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_apfh2_d[l_ac].apfi004 = g_apfh2_d_t.apfi004  #160822-00008#3  mark
                        LET g_apfh2_d[l_ac].apfi004 = g_apfh2_d_o.apfi004   #160822-00008#3
                        DISPLAY BY NAME g_apfh2_d[l_ac].apfi004 
                        NEXT FIELD CURRENT
                     END IF                  
                     CALL s_aapt460_get_rate(g_apfh2_d[l_ac].apfi001,g_apfh2_d[l_ac].apfi001,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfh2_d[l_ac].apfi100)
                          RETURNING l_no_use,g_apfh2_d[l_ac].apfi201
                     
                     LET g_apfh2_d[l_ac].apfi204 = g_apfh2_d[l_ac].apfi103 * g_apfh2_d[l_ac].apfi201
                     IF cl_null(g_apfh2_d[l_ac].apfi204) THEN LET g_apfh2_d[l_ac].apfi204 = 0 END IF
                     CALL s_curr_round_ld('1',g_apfg_m.apfgld,g_glaa.glaa001,g_apfh2_d[l_ac].apfi204,2) 
                          RETURNING g_sub_success,g_errno,g_apfh2_d[l_ac].apfi204
                  END IF
               END IF
            END IF   
            CALL aapt460_tran_rate_apfi('N')   
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi004
            #add-point:ON CHANGE apfi004 name="input.g.page2.apfi004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi005
            #add-point:BEFORE FIELD apfi005 name="input.b.page2.apfi005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi005
            
            #add-point:AFTER FIELD apfi005 name="input.a.page2.apfi005"
            IF NOT cl_null(g_apfh2_d[l_ac].apfi005) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apfh2_d[l_ac].apfi005 != g_apfh2_d_t.apfi005 OR g_apfh2_d_t.apfi005 IS NULL )) THEN  #160822-00008#3  mark
               IF g_apfh2_d[l_ac].apfi005 != g_apfh2_d_o.apfi005 OR cl_null(g_apfh2_d_o.apfi005) THEN                                      #160822-00008#3
                  IF NOT cl_null(g_apfh2_d[l_ac].apfi003) AND NOT cl_null(g_apfh2_d[l_ac].apfi004) AND NOT cl_null(g_apfh2_d[l_ac].apfi005) THEN
                     CALL s_aapt420_exist_chk(g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004,g_apfh2_d[l_ac].apfi005,g_apfg_m.apfg002,'') #151130-00015#4
                             RETURNING g_sub_success,g_errno                        
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_apfh2_d[l_ac].apfi005 = g_apfh2_d_t.apfi005
                        DISPLAY BY NAME g_apfh2_d[l_ac].apfi005
                        NEXT FIELD CURRENT
                     END IF                
                     IF g_apfh2_d[l_ac].apfi006[1,1] THEN
                        SELECT apcc009 INTO l_apce048
                          FROM apcc_t
                         WHERE apccent = g_enterprise
                           AND apccld  = l_apce.apceld  AND apccdocno = l_apce.apce003 
                           AND apccseq = l_apce.apce004 AND apcc001 = l_apce.apce005
                     END IF     
                     CALL cl_get_para(g_enterprise,g_apfh2_d[l_ac].apfi001,'S-FIN-2002') RETURNING l_sfin2002
                     #帶回開窗帳款單資訊          
                     CALL s_aapt420_source_doc_carry(g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004,g_apfh2_d[l_ac].apfi002,
                                                     g_apfg_m.apfgdocno,g_apfh2_d[l_ac].apfiseq,g_apfh2_d[l_ac].apfi002,
                                                     g_apfh2_d[l_ac].apfi005  ,l_apce048,l_sfin2002)
                          RETURNING l_no_use      ,l_no_use,g_apfh2_d[l_ac].apfi100,g_apfh2_d[l_ac].apfi103,g_apfh2_d[l_ac].apfi101,
                                    g_apfh2_d[l_ac].apfi104,l_no_use,l_no_use,l_no_use,l_no_use,
                                    l_no_use      ,l_no_use,g_apfh2_d[l_ac].apfi011,l_no_use,l_no_use,
                                    l_no_use      ,l_no_use,l_no_use,l_no_use,l_no_use,
                                    l_no_use      ,l_no_use,l_no_use,l_no_use,l_no_use,
                                    l_no_use      ,l_no_use,l_no_use,l_no_use,l_no_use,
                                    l_no_use      ,l_no_use,l_no_use,l_no_use,l_no_use,
                                    l_no_use
                     #檢核金額不可超出可沖金額
                     CALL s_aapt420_apcc_used_chk(g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004,g_apfh2_d[l_ac].apfi005,
                                                  g_apfh2_d[l_ac].apfi103,g_apfg_m.apfgdocno,g_apfh2_d[l_ac].apfiseq,'1','0')
                                RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_apfh2_d[l_ac].apfi005 = g_apfh2_d_t.apfi005  #160822-00008#3  mark
                        LET g_apfh2_d[l_ac].apfi005 = g_apfh2_d_o.apfi005   #160822-00008#3
                        DISPLAY BY NAME g_apfh2_d[l_ac].apfi005
                        NEXT FIELD CURRENT
                     END IF 
                     CALL s_aapt460_get_rate(g_apfh2_d[l_ac].apfi001,g_apfh2_d[l_ac].apfi001,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfh2_d[l_ac].apfi100)
                          RETURNING l_no_use,g_apfh2_d[l_ac].apfi201
                     
                     LET g_apfh2_d[l_ac].apfi204 = g_apfh2_d[l_ac].apfi103 * g_apfh2_d[l_ac].apfi201
                     IF cl_null(g_apfh2_d[l_ac].apfi204) THEN LET g_apfh2_d[l_ac].apfi204 = 0 END IF
                     CALL s_curr_round_ld('1',g_apfg_m.apfgld,g_glaa.glaa001,g_apfh2_d[l_ac].apfi204,2) 
                          RETURNING g_sub_success,g_errno,g_apfh2_d[l_ac].apfi204                     
                  END IF
               END IF
            END IF     
            CALL aapt460_tran_rate_apfi('N')
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi005
            #add-point:ON CHANGE apfi005 name="input.g.page2.apfi005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi011
            #add-point:BEFORE FIELD apfi011 name="input.b.page2.apfi011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi011
            
            #add-point:AFTER FIELD apfi011 name="input.a.page2.apfi011"
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi011
            #add-point:ON CHANGE apfi011 name="input.g.page2.apfi011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi100
            #add-point:BEFORE FIELD apfi100 name="input.b.page2.apfi100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi100
            
            #add-point:AFTER FIELD apfi100 name="input.a.page2.apfi100"
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi100
            #add-point:ON CHANGE apfi100 name="input.g.page2.apfi100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi101
            #add-point:BEFORE FIELD apfi101 name="input.b.page2.apfi101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi101
            
            #add-point:AFTER FIELD apfi101 name="input.a.page2.apfi101"
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi101
            #add-point:ON CHANGE apfi101 name="input.g.page2.apfi101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi103
            #add-point:BEFORE FIELD apfi103 name="input.b.page2.apfi103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi103
            
            #add-point:AFTER FIELD apfi103 name="input.a.page2.apfi103"
            IF NOT cl_null(g_apfh2_d[l_ac].apfi103) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apfh2_d[l_ac].apfi103 != g_apfh2_d_t.apfi103 OR g_apfh2_d_t.apfi103 IS NULL )) THEN  #160822-00008#3  mark
               IF g_apfh2_d[l_ac].apfi103 != g_apfh2_d_o.apfi103 OR cl_null(g_apfh2_d_o.apfi103) THEN                                      #160822-00008#3
                  LET g_apfh2_d[l_ac].apfi104 = g_apfh2_d[l_ac].apfi103 * g_apfh2_d[l_ac].apfi101
                  LET g_apfh2_d[l_ac].apfi204 = g_apfh2_d[l_ac].apfi103 * g_apfh2_d[l_ac].apfi201
               END IF  
            END IF
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi103
            #add-point:ON CHANGE apfi103 name="input.g.page2.apfi103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi104
            #add-point:BEFORE FIELD apfi104 name="input.b.page2.apfi104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi104
            
            #add-point:AFTER FIELD apfi104 name="input.a.page2.apfi104"
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi104
            #add-point:ON CHANGE apfi104 name="input.g.page2.apfi104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi201
            #add-point:BEFORE FIELD apfi201 name="input.b.page2.apfi201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi201
            
            #add-point:AFTER FIELD apfi201 name="input.a.page2.apfi201"
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi201
            #add-point:ON CHANGE apfi201 name="input.g.page2.apfi201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi204
            #add-point:BEFORE FIELD apfi204 name="input.b.page2.apfi204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi204
            
            #add-point:AFTER FIELD apfi204 name="input.a.page2.apfi204"
            LET g_apfh2_d_o.* = g_apfh2_d[l_ac].*  #160822-00008#3
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi204
            #add-point:ON CHANGE apfi204 name="input.g.page2.apfi204"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi013
            #add-point:BEFORE FIELD apfi013 name="input.b.page2.apfi013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi013
            
            #add-point:AFTER FIELD apfi013 name="input.a.page2.apfi013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi013
            #add-point:ON CHANGE apfi013 name="input.g.page2.apfi013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.apfiseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfiseq
            #add-point:ON ACTION controlp INFIELD apfiseq name="input.c.page2.apfiseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi001
            #add-point:ON ACTION controlp INFIELD apfi001 name="input.c.page2.apfi001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh2_d[l_ac].apfi001             #給予default值
            LET g_qryparam.where    = "ooef003 = 'Y' AND ooef017 IN ",g_wc_apfgcomp                 
            CALL q_ooef001()
            LET g_apfh2_d[l_ac].apfi001 = g_qryparam.return1              
            DISPLAY g_apfh2_d[l_ac].apfi001 TO apfi001
            NEXT FIELD apfi001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi002
            #add-point:ON ACTION controlp INFIELD apfi002 name="input.c.page2.apfi002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh2_d[l_ac].apfi002
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s
            CALL q_authorised_ld()
            LET g_apfh2_d[l_ac].apfi002 = g_qryparam.return1              
            DISPLAY g_apfh2_d[l_ac].apfi002 TO apfi002
            NEXT FIELD apfi002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi006
            #add-point:ON ACTION controlp INFIELD apfi006 name="input.c.page2.apfi006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi003
            #add-point:ON ACTION controlp INFIELD apfi003 name="input.c.page2.apfi003"
            #依帳款類型開窗
            CALL s_aapt420_source_doc_query(g_apfg_m.apfgld,g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi001,g_apfg_m.apfg002,g_apfg_m.apfgdocdt,'') #151130-00015#4
                 RETURNING l_wc_apfi003
           #無選擇任何一筆
           IF g_qryparam.str_array.getLength() = 0 THEN
              NEXT FIELD apfi003
           ELSE
              CALL cl_err_collect_init() 
              #寫入帳款單身
              CALL s_aapt460_ins_payable_detail(g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfh2_d[l_ac].apfi001,g_apfh2_d[l_ac].apfi002,g_apfg_m.apfg002,
                                                g_apfg_m.apfgdocdt,l_sfin2002,l_wc_apfi003,g_apfh2_d[l_ac].apfi006[1,1]) 
                   RETURNING g_sub_success   
              IF NOT g_sub_success THEN
                 CALL cl_err_collect_show() 
                 CALL s_transaction_end('N','0')
              ELSE
                 CALL cl_err_collect_show()    
                 CALL s_transaction_end('Y','0')
              END IF  
              CALL aapt460_show()
              EXIT DIALOG
           END IF              

            NEXT FIELD apfi003
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi004
            #add-point:ON ACTION controlp INFIELD apfi004 name="input.c.page2.apfi004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi005
            #add-point:ON ACTION controlp INFIELD apfi005 name="input.c.page2.apfi005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi011
            #add-point:ON ACTION controlp INFIELD apfi011 name="input.c.page2.apfi011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi100
            #add-point:ON ACTION controlp INFIELD apfi100 name="input.c.page2.apfi100"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apfh2_d[l_ac].apfi100             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooai001()                                #呼叫開窗

            LET g_apfh2_d[l_ac].apfi100 = g_qryparam.return1              

            DISPLAY g_apfh2_d[l_ac].apfi100 TO apfi100              #

            NEXT FIELD apfi100                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi101
            #add-point:ON ACTION controlp INFIELD apfi101 name="input.c.page2.apfi101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi103
            #add-point:ON ACTION controlp INFIELD apfi103 name="input.c.page2.apfi103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi104
            #add-point:ON ACTION controlp INFIELD apfi104 name="input.c.page2.apfi104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi201
            #add-point:ON ACTION controlp INFIELD apfi201 name="input.c.page2.apfi201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi204
            #add-point:ON ACTION controlp INFIELD apfi204 name="input.c.page2.apfi204"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apfi013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi013
            #add-point:ON ACTION controlp INFIELD apfi013 name="input.c.page2.apfi013"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apfh2_d[l_ac].* = g_apfh2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt460_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt460_unlock_b("apfi_t","'2'")
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
               LET g_apfh2_d[li_reproduce_target].* = g_apfh2_d[li_reproduce].*
               LET g_apfh3_d[li_reproduce_target].* = g_apfh3_d[li_reproduce].*
 
               LET g_apfh2_d[li_reproduce_target].apfiseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apfh2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apfh2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_apfh3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            
            CALL aapt460_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apfh3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apfh3_d[l_ac].* TO NULL 
            INITIALIZE g_apfh3_d_t.* TO NULL 
            INITIALIZE g_apfh3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_apfh3_d_t.* = g_apfh3_d[l_ac].*     #新輸入資料
            LET g_apfh3_d_o.* = g_apfh3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt460_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt460_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apfh2_d[li_reproduce_target].* = g_apfh2_d[li_reproduce].*
               LET g_apfh3_d[li_reproduce_target].* = g_apfh3_d[li_reproduce].*
 
               LET g_apfh3_d[li_reproduce_target].apfiseq = NULL
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
            OPEN aapt460_cl USING g_enterprise,g_apfg_m.apfgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt460_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt460_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apfh3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apfh3_d[l_ac].apfiseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apfh3_d_t.* = g_apfh3_d[l_ac].*  #BACKUP
               LET g_apfh3_d_o.* = g_apfh3_d[l_ac].*  #BACKUP
               CALL aapt460_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               CALL s_tax_get_ooef019(g_apfh2_d[l_ac].apfi001) RETURNING g_sub_success,l_ooef019
               #end add-point  
               CALL aapt460_set_no_entry_b(l_cmd)
               IF NOT aapt460_lock_b("apfi_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt460_bcl2 INTO g_apfh2_d[l_ac].apfiseq,g_apfh2_d[l_ac].apfi001,g_apfh2_d[l_ac].apfi002, 
                      g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004,g_apfh2_d[l_ac].apfi005, 
                      g_apfh2_d[l_ac].apfi011,g_apfh2_d[l_ac].apfi100,g_apfh2_d[l_ac].apfi101,g_apfh2_d[l_ac].apfi103, 
                      g_apfh2_d[l_ac].apfi104,g_apfh2_d[l_ac].apfi201,g_apfh2_d[l_ac].apfi204,g_apfh2_d[l_ac].apfi013, 
                      g_apfh3_d[l_ac].apfiseq,g_apfh3_d[l_ac].apfi012,g_apfh3_d[l_ac].apfi009,g_apfh3_d[l_ac].apfi010, 
                      g_apfh3_d[l_ac].apfi008,g_apfh3_d[l_ac].apfi007
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apfh3_d_mask_o[l_ac].* =  g_apfh3_d[l_ac].*
                  CALL aapt460_apfi_t_mask()
                  LET g_apfh3_d_mask_n[l_ac].* =  g_apfh3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt460_show()
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
               LET gs_keys[01] = g_apfg_m.apfgdocno
               LET gs_keys[gs_keys.getLength()+1] = g_apfh3_d_t.apfiseq
            
               #刪除同層單身
               IF NOT aapt460_delete_b('apfi_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt460_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt460_key_delete_b(gs_keys,'apfi_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt460_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt460_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_apfh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apfh3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM apfi_t 
             WHERE apfient = g_enterprise AND apfidocno = g_apfg_m.apfgdocno
               AND apfiseq = g_apfh3_d[l_ac].apfiseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apfg_m.apfgdocno
               LET gs_keys[2] = g_apfh3_d[g_detail_idx].apfiseq
               CALL aapt460_insert_b('apfi_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apfh_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "apfi_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt460_b_fill()
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
               LET g_apfh3_d[l_ac].* = g_apfh3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt460_bcl2
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
               LET g_apfh3_d[l_ac].* = g_apfh3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aapt460_apfi_t_mask_restore('restore_mask_o')
                              
               UPDATE apfi_t SET (apfidocno,apfiseq,apfi001,apfi002,apfi006,apfi003,apfi004,apfi005, 
                   apfi011,apfi100,apfi101,apfi103,apfi104,apfi201,apfi204,apfi013,apfi012,apfi009,apfi010, 
                   apfi008,apfi007) = (g_apfg_m.apfgdocno,g_apfh2_d[l_ac].apfiseq,g_apfh2_d[l_ac].apfi001, 
                   g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004, 
                   g_apfh2_d[l_ac].apfi005,g_apfh2_d[l_ac].apfi011,g_apfh2_d[l_ac].apfi100,g_apfh2_d[l_ac].apfi101, 
                   g_apfh2_d[l_ac].apfi103,g_apfh2_d[l_ac].apfi104,g_apfh2_d[l_ac].apfi201,g_apfh2_d[l_ac].apfi204, 
                   g_apfh2_d[l_ac].apfi013,g_apfh3_d[l_ac].apfi012,g_apfh3_d[l_ac].apfi009,g_apfh3_d[l_ac].apfi010, 
                   g_apfh3_d[l_ac].apfi008,g_apfh3_d[l_ac].apfi007) #自訂欄位頁簽
                WHERE apfient = g_enterprise AND apfidocno = g_apfg_m.apfgdocno
                  AND apfiseq = g_apfh3_d_t.apfiseq #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apfh3_d[l_ac].* = g_apfh3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apfi_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apfh3_d[l_ac].* = g_apfh3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apfi_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apfg_m.apfgdocno
               LET gs_keys_bak[1] = g_apfgdocno_t
               LET gs_keys[2] = g_apfh3_d[g_detail_idx].apfiseq
               LET gs_keys_bak[2] = g_apfh3_d_t.apfiseq
               CALL aapt460_update_b('apfi_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt460_apfi_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apfh3_d[g_detail_idx].apfiseq = g_apfh3_d_t.apfiseq 
                  ) THEN
                  LET gs_keys[01] = g_apfg_m.apfgdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apfh3_d_t.apfiseq
                  CALL aapt460_key_update_b(gs_keys,'apfi_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apfg_m),util.JSON.stringify(g_apfh3_d_t)
               LET g_log2 = util.JSON.stringify(g_apfg_m),util.JSON.stringify(g_apfh3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi012
            
            #add-point:AFTER FIELD apfi012 name="input.a.page3.apfi012"
            #帳款類別
            LET g_apfh3_d[l_ac].apfi012_desc = ''
            IF NOT cl_null(g_apfh3_d[l_ac].apfi012) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apfh3_d[l_ac].apfi012 != g_apfh3_d_t.apfi012 OR g_apfh3_d_t.apfi012 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('3211',g_apfh3_d[l_ac].apfi012) THEN
                     LET g_apfh3_d[l_ac].apfi012 = g_apfh3_d_t.apfi012
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF   
            CALL s_desc_get_acc_desc('3211',g_apfh3_d[l_ac].apfi012) RETURNING g_apfh3_d[l_ac].apfi012_desc
            DISPLAY BY NAME g_apfh3_d[l_ac].apfi012_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi012
            #add-point:BEFORE FIELD apfi012 name="input.b.page3.apfi012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi012
            #add-point:ON CHANGE apfi012 name="input.g.page3.apfi012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi009
            
            #add-point:AFTER FIELD apfi009 name="input.a.page3.apfi009"
            #內部銀行帳戶
            LET g_apfh3_d[l_ac].apfi009_desc = ''
            IF NOT cl_null(g_apfh3_d[l_ac].apfi009) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apfh3_d[l_ac].apfi009 != g_apfh3_d_t.apfi009 OR g_apfh3_d_t.apfi009 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apfh3_d[l_ac].apfi009
                  LET g_chkparam.arg2 = g_apfh2_d[l_ac].apfi001 #法人
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_nmas002_1") THEN
                     LET g_apfh3_d[l_ac].apfi009 = g_apfh3_d_t.apfi009
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#14--add---str
                  IF NOT s_anmi120_nmll002_chk(g_apfh3_d[l_ac].apfi009,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apfh3_d[l_ac].apfi009
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_apfh3_d[l_ac].apfi009 = g_apfh3_d_t.apfi009
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#14--add---end
               END IF
            END IF
            CALL s_desc_get_nmas002_desc(g_apfh3_d[l_ac].apfi009) RETURNING g_apfh3_d[l_ac].apfi009_desc
            DISPLAY BY NAME g_apfh3_d[l_ac].apfi009_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi009
            #add-point:BEFORE FIELD apfi009 name="input.b.page3.apfi009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi009
            #add-point:ON CHANGE apfi009 name="input.g.page3.apfi009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi010
            
            #add-point:AFTER FIELD apfi010 name="input.a.page3.apfi010"
            #內部銀行存提碼
            LET g_apfh3_d[l_ac].apfi010_desc = ''
            IF NOT cl_null(g_apfh3_d[l_ac].apfi010) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apfh3_d[l_ac].apfi010 != g_apfh3_d_t.apfi010 OR g_apfh3_d_t.apfi010 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apfh3_d[l_ac].apfi010
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_nmaj001") THEN
                     LET g_apfh3_d[l_ac].apfi010 = g_apfh3_d_t.apfi010
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_nmajl003_desc(g_apfh3_d[l_ac].apfi010) RETURNING g_apfh3_d[l_ac].apfi010_desc
            DISPLAY BY NAME g_apfh3_d[l_ac].apfi010,g_apfh3_d[l_ac].apfi010_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi010
            #add-point:BEFORE FIELD apfi010 name="input.b.page3.apfi010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi010
            #add-point:ON CHANGE apfi010 name="input.g.page3.apfi010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi008
            
            #add-point:AFTER FIELD apfi008 name="input.a.page3.apfi008"
            #稅別
            IF NOT cl_null(g_apfh3_d[l_ac].apfi008) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND ((g_apfh3_d[l_ac].apfi008 != g_apfh3_d_t.apfi008 OR g_apfh3_d_t.apfi008 IS NULL ) )) THEN
                  CALL s_tax_chk(g_apfh2_d[l_ac].apfi001,g_apfh3_d[l_ac].apfi008) RETURNING g_sub_success,l_oodb004,l_oodb004,l_oodb004,l_oodb004
                  IF NOT g_sub_success THEN
                     LET g_apfh3_d[l_ac].apfi008 = g_apfh3_d_t.apfi008
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_desc_get_tax_desc(l_ooef019,g_apfh3_d[l_ac].apfi008) RETURNING g_apfh3_d[l_ac].apfi008_desc
            END IF
            DISPLAY BY NAME g_apfh3_d[l_ac].apfi008,g_apfh3_d[l_ac].apfi008_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi008
            #add-point:BEFORE FIELD apfi008 name="input.b.page3.apfi008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi008
            #add-point:ON CHANGE apfi008 name="input.g.page3.apfi008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apfi007
            
            #add-point:AFTER FIELD apfi007 name="input.a.page3.apfi007"
            #付款條件
            LET g_apfh3_d[l_ac].apfi007_desc = ' '
            IF NOT cl_null(g_apfh3_d[l_ac].apfi007) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apfh3_d[l_ac].apfi007 != g_apfh3_d_t.apfi007 OR g_apfh3_d_t.apfi007 IS NULL )) THEN
                  CALL s_aap_ooib002_chk(g_apfh3_d[l_ac].apfi007,'1')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.popup = TRUE
                     #160321-00016#21 --s add
                     LET g_errparam.replace[1] = 'aooi716'
                     LET g_errparam.replace[2] = cl_get_progname('aooi716',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi716'
                     #160321-00016#21 --e add
                     CALL cl_err()
                     LET g_apfh3_d[l_ac].apfi007 = g_apfh3_d_t.apfi007
                     NEXT FIELD CURRENT
                  END IF           
               END IF
            END IF
            CALL s_desc_get_ooib002_desc(g_apfh3_d[l_ac].apfi007) RETURNING g_apfh3_d[l_ac].apfi007_desc
            DISPLAY BY NAME g_apfh3_d[l_ac].apfi007_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apfi007
            #add-point:BEFORE FIELD apfi007 name="input.b.page3.apfi007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apfi007
            #add-point:ON CHANGE apfi007 name="input.g.page3.apfi007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.apfi012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi012
            #add-point:ON ACTION controlp INFIELD apfi012 name="input.c.page3.apfi012"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh3_d[l_ac].apfi012
            LET g_qryparam.arg1 = "3211"
            CALL q_oocq002()
            LET g_apfh3_d[l_ac].apfi012 = g_qryparam.return1              
            DISPLAY g_apfh3_d[l_ac].apfi012 TO apfi012
            NEXT FIELD apfi012
            #END add-point
 
 
         #Ctrlp:input.c.page3.apfi009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi009
            #add-point:ON ACTION controlp INFIELD apfi009 name="input.c.page3.apfi009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh3_d[l_ac].apfi009
            #160122-00001#14--mod---str
#            LET g_qryparam.where = " nmaa002 IN (SELECT ooef001 FROM ooef_t ",
#                                                " WHERE ooefent = ",g_enterprise," AND ooef017 = '",g_apfh2_d[l_ac].apfi001,"')"
            
#            LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')",
            LET g_qryparam.where = " nmas002 IN(",g_sql_bank,")",#160122-00001#14 mod by 07675
                                   " AND nmaa002 IN (SELECT ooef001 FROM ooef_t ",
                                   " WHERE ooefent = ",g_enterprise," AND ooef017 = '",g_apfh2_d[l_ac].apfi001,"')"
            #160122-00001#14--mod---end
            CALL q_nmas002_6()        
            LET g_apfh3_d[l_ac].apfi009 = g_qryparam.return1              
            DISPLAY g_apfh3_d[l_ac].apfi009 TO apfi009              #
            LET g_qryparam.where = " "             #160122-00001#14
            NEXT FIELD apfi009                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page3.apfi010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi010
            #add-point:ON ACTION controlp INFIELD apfi010 name="input.c.page3.apfi010"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh3_d[l_ac].apfi010             #給予default值
            CALL q_nmaj001()                                #呼叫開窗
            LET g_apfh3_d[l_ac].apfi010 = g_qryparam.return1        
            DISPLAY g_apfh3_d[l_ac].apfi010 TO apfi010              
            NEXT FIELD apfi010                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page3.apfi008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi008
            #add-point:ON ACTION controlp INFIELD apfi008 name="input.c.page3.apfi008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh3_d[l_ac].apfi008             #給予default值
            LET g_qryparam.arg1 = l_ooef019   #稅區
            CALL q_oodb002_5()
            LET g_apfh3_d[l_ac].apfi008 = g_qryparam.return1              
            DISPLAY g_apfh3_d[l_ac].apfi008 TO apfi008
            NEXT FIELD apfi008            
            #END add-point
 
 
         #Ctrlp:input.c.page3.apfi007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apfi007
            #add-point:ON ACTION controlp INFIELD apfi007 name="input.c.page3.apfi007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apfh3_d[l_ac].apfi007             #給予default值
            LET g_qryparam.arg1 =g_apfg_m.apfg002
            #161115-00042#5-add(s)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = pmadent ",
                                      "            AND pmaa001 = pmad001 )"
            END IF
            #161115-00042#5-add(e)
            CALL q_pmad002_2()                   
            LET g_apfh3_d[l_ac].apfi007 = g_qryparam.return1              
            DISPLAY g_apfh3_d[l_ac].apfi007 TO apfi007              #
            NEXT FIELD apfi007                          #返回原欄位
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apfh3_d[l_ac].* = g_apfh3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt460_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt460_unlock_b("apfi_t","'3'")
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
               LET g_apfh2_d[li_reproduce_target].* = g_apfh2_d[li_reproduce].*
               LET g_apfh3_d[li_reproduce_target].* = g_apfh3_d[li_reproduce].*
 
               LET g_apfh3_d[li_reproduce_target].apfiseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apfh3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apfh3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aapt460.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2','3',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD apfgdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD apfhseq
               WHEN "s_detail2"
                  NEXT FIELD apfiseq
               WHEN "s_detail3"
                  NEXT FIELD apfiseq_3
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aapt460.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aapt460_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_ooef019  LIKE ooef_t.ooef019
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aapt460_b_fill() #單身填充
      CALL aapt460_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aapt460_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_aooi200_fin_get_slip_desc(g_apfg_m.apfgdocno) RETURNING g_apfg_m.apfgdocno_desc
   DISPLAY BY NAME g_apfg_m.apfgdocno_desc
   CALL aapt460_set_ld_info(g_apfg_m.apfgld,'s')
   #end add-point
   
   #遮罩相關處理
   LET g_apfg_m_mask_o.* =  g_apfg_m.*
   CALL aapt460_apfg_t_mask()
   LET g_apfg_m_mask_n.* =  g_apfg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apfg_m.apfgsite,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001,g_apfg_m.apfg001_desc,g_apfg_m.apfgld, 
       g_apfg_m.apfgld_desc,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocno_desc,g_apfg_m.apfgdocdt, 
       g_apfg_m.apfg002,g_apfg_m.apfg002_desc,g_apfg_m.apfgstus,g_apfg_m.apfgownid,g_apfg_m.apfgownid_desc, 
       g_apfg_m.apfgowndp,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtid_desc,g_apfg_m.apfgcrtdp, 
       g_apfg_m.apfgcrtdp_desc,g_apfg_m.apfgcrtdt,g_apfg_m.apfgmodid,g_apfg_m.apfgmodid_desc,g_apfg_m.apfgmoddt, 
       g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid,g_apfg_m.apfgpstid_desc, 
       g_apfg_m.apfgpstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apfg_m.apfgstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
   FOR l_ac = 1 TO g_apfh_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_apfh2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_apfh3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      CALL s_tax_get_ooef019(g_apfh2_d[l_ac].apfi001) RETURNING g_sub_success,l_ooef019
      CALL s_desc_get_tax_desc(l_ooef019,g_apfh3_d[l_ac].apfi008) RETURNING g_apfh3_d[l_ac].apfi008_desc
      CALL s_desc_get_nmas002_desc(g_apfh3_d[l_ac].apfi009) RETURNING g_apfh3_d[l_ac].apfi009_desc
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aapt460_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aapt460_detail_show()
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
 
{<section id="aapt460.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapt460_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE apfg_t.apfgdocno 
   DEFINE l_oldno     LIKE apfg_t.apfgdocno 
 
   DEFINE l_master    RECORD LIKE apfg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE apfh_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE apfi_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_apfg_m.apfgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_apfgdocno_t = g_apfg_m.apfgdocno
 
    
   LET g_apfg_m.apfgdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apfg_m.apfgownid = g_user
      LET g_apfg_m.apfgowndp = g_dept
      LET g_apfg_m.apfgcrtid = g_user
      LET g_apfg_m.apfgcrtdp = g_dept 
      LET g_apfg_m.apfgcrtdt = cl_get_current()
      LET g_apfg_m.apfgmodid = g_user
      LET g_apfg_m.apfgmoddt = cl_get_current()
      LET g_apfg_m.apfgstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apfg_m.apfgstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
      LET g_apfg_m.apfgdocno_desc = ''
   DISPLAY BY NAME g_apfg_m.apfgdocno_desc
 
   
   CALL aapt460_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_apfg_m.* TO NULL
      INITIALIZE g_apfh_d TO NULL
      INITIALIZE g_apfh2_d TO NULL
      INITIALIZE g_apfh3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aapt460_show()
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
   CALL aapt460_set_act_visible()   
   CALL aapt460_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apfgdocno_t = g_apfg_m.apfgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apfgent = " ||g_enterprise|| " AND",
                      " apfgdocno = '", g_apfg_m.apfgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt460_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aapt460_idx_chk()
   
   LET g_data_owner = g_apfg_m.apfgownid      
   LET g_data_dept  = g_apfg_m.apfgowndp
   
   #功能已完成,通報訊息中心
   CALL aapt460_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt460.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aapt460_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE apfh_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE apfi_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aapt460_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apfh_t
    WHERE apfhent = g_enterprise AND apfhdocno = g_apfgdocno_t
 
    INTO TEMP aapt460_detail
 
   #將key修正為調整後   
   UPDATE aapt460_detail 
      #更新key欄位
      SET apfhdocno = g_apfg_m.apfgdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO apfh_t SELECT * FROM aapt460_detail
   
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
   DROP TABLE aapt460_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apfi_t 
    WHERE apfient = g_enterprise AND apfidocno = g_apfgdocno_t
 
    INTO TEMP aapt460_detail
 
   #將key修正為調整後   
   UPDATE aapt460_detail SET apfidocno = g_apfg_m.apfgdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO apfi_t SELECT * FROM aapt460_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt460_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_apfgdocno_t = g_apfg_m.apfgdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt460_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_n             LIKE type_t.num5    #160122-00001#14
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_apfg_m.apfgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aapt460_cl USING g_enterprise,g_apfg_m.apfgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt460_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt460_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt460_master_referesh USING g_apfg_m.apfgdocno INTO g_apfg_m.apfgsite,g_apfg_m.apfg001, 
       g_apfg_m.apfgld,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfgstus, 
       g_apfg_m.apfgownid,g_apfg_m.apfgowndp,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtdp,g_apfg_m.apfgcrtdt, 
       g_apfg_m.apfgmodid,g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid, 
       g_apfg_m.apfgpstdt,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001_desc,g_apfg_m.apfgld_desc,g_apfg_m.apfg002_desc, 
       g_apfg_m.apfgownid_desc,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid_desc,g_apfg_m.apfgcrtdp_desc, 
       g_apfg_m.apfgmodid_desc,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgpstid_desc
   
   
   #檢查是否允許此動作
   IF NOT aapt460_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apfg_m_mask_o.* =  g_apfg_m.*
   CALL aapt460_apfg_t_mask()
   LET g_apfg_m_mask_n.* =  g_apfg_m.*
   
   CALL aapt460_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   IF g_apfg_m.apfgstus <> 'N' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = g_apfg_m.apfgstus
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt460_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      #add-point:相關文件刪除前
      #160126-00010#14---add---str
      LET l_n = 0 
      #單身存在當前用戶沒有權限的交易帳戶編碼
      SELECT COUNT(*) INTO l_n FROM apfi_t
       WHERE apfient = g_enterprise AND apfidocno = g_apfg_m.apfgdocno
         AND apfi009 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus='Y')
          #160122-00001#14--add-by 07675-str
         AND apfi009 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus='Y')
         AND TRIM(apfi009) IS NOT NULL
      IF l_n > 0 THEN
         IF NOT cl_ask_confirm('anm-00395') THEN
            CLOSE aapt460_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #160122-00001#14--add--end
      #IF l_n = 0 THEN
      #160126-00010#14---add---end
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_apfgdocno_t = g_apfg_m.apfgdocno
 
 
      DELETE FROM apfg_t
       WHERE apfgent = g_enterprise AND apfgdocno = g_apfg_m.apfgdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_apfg_m.apfgdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_apfg_m.apfgld,g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #END IF    #160126-00010#14
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM apfh_t
       WHERE apfhent = g_enterprise AND apfhdocno = g_apfg_m.apfgdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apfh_t:",SQLERRMESSAGE 
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
      DELETE FROM apfi_t
       WHERE apfient = g_enterprise AND
             apfidocno = g_apfg_m.apfgdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
#      #160126-00010#14---add---str
#         AND (apfi009 IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user)
#          OR apfi009 IS NULL)
#      #160126-00010#14--add---end
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apfi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_apfg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aapt460_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_apfh_d.clear() 
      CALL g_apfh2_d.clear()       
      CALL g_apfh3_d.clear()       
 
     
      CALL aapt460_ui_browser_refresh()  
      #CALL aapt460_ui_headershow()  
      #CALL aapt460_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aapt460_browser_fill("")
         CALL aapt460_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aapt460_cl
 
   #功能已完成,通報訊息中心
   CALL aapt460_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aapt460.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt460_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_apfh_d.clear()
   CALL g_apfh2_d.clear()
   CALL g_apfh3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aapt460_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apfhseq,apfh001,apfhld,apfh006,apfh004,apfh002,apfh003,apfh008, 
             apfh100,apfh103,apfh101,apfh104,apfh005,apfh201,apfh204,apfh007 ,t1.ooefl003 ,t2.glaal002 , 
             t3.nmajl003 FROM apfh_t",   
                     " INNER JOIN apfg_t ON apfgent = " ||g_enterprise|| " AND apfgdocno = apfhdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=apfh001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=apfhld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t3 ON t3.nmajlent="||g_enterprise||" AND t3.nmajl001=apfh005 AND t3.nmajl002='"||g_dlang||"' ",
 
                     " WHERE apfhent=? AND apfhdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apfh_t.apfhseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt460_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aapt460_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_apfg_m.apfgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_apfg_m.apfgdocno INTO g_apfh_d[l_ac].apfhseq,g_apfh_d[l_ac].apfh001, 
          g_apfh_d[l_ac].apfhld,g_apfh_d[l_ac].apfh006,g_apfh_d[l_ac].apfh004,g_apfh_d[l_ac].apfh002, 
          g_apfh_d[l_ac].apfh003,g_apfh_d[l_ac].apfh008,g_apfh_d[l_ac].apfh100,g_apfh_d[l_ac].apfh103, 
          g_apfh_d[l_ac].apfh101,g_apfh_d[l_ac].apfh104,g_apfh_d[l_ac].apfh005,g_apfh_d[l_ac].apfh201, 
          g_apfh_d[l_ac].apfh204,g_apfh_d[l_ac].apfh007,g_apfh_d[l_ac].apfh001_desc,g_apfh_d[l_ac].apfhld_desc, 
          g_apfh_d[l_ac].apfh005_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
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
   IF aapt460_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apfiseq,apfi001,apfi002,apfi006,apfi003,apfi004,apfi005,apfi011, 
             apfi100,apfi101,apfi103,apfi104,apfi201,apfi204,apfi013,apfiseq,apfi012,apfi009,apfi010, 
             apfi008,apfi007 ,t4.ooefl003 ,t5.oocql004 ,t6.nmajl003 ,t7.ooibl004 FROM apfi_t",   
                     " INNER JOIN  apfg_t ON apfgent = " ||g_enterprise|| " AND apfgdocno = apfidocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=apfi001 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='3211' AND t5.oocql002=apfi012 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t6 ON t6.nmajlent="||g_enterprise||" AND t6.nmajl001=apfi010 AND t6.nmajl002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t7 ON t7.ooiblent="||g_enterprise||" AND t7.ooibl002=apfi007 AND t7.ooibl003='"||g_dlang||"' ",
 
                     " WHERE apfient=? AND apfidocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
#         LET g_sql = g_sql CLIPPED," AND (apfi009 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')
#                                      OR apfi009 IS NULL)"  #160122-00001#14
          LET g_sql = g_sql CLIPPED," AND (apfi009 IN(",g_sql_bank,") OR TRIM(apfi009) IS NULL)"  #160122-00001#14 mod by 07675
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  #160122-00001#14
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apfi_t.apfiseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt460_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aapt460_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_apfg_m.apfgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_apfg_m.apfgdocno INTO g_apfh2_d[l_ac].apfiseq,g_apfh2_d[l_ac].apfi001, 
          g_apfh2_d[l_ac].apfi002,g_apfh2_d[l_ac].apfi006,g_apfh2_d[l_ac].apfi003,g_apfh2_d[l_ac].apfi004, 
          g_apfh2_d[l_ac].apfi005,g_apfh2_d[l_ac].apfi011,g_apfh2_d[l_ac].apfi100,g_apfh2_d[l_ac].apfi101, 
          g_apfh2_d[l_ac].apfi103,g_apfh2_d[l_ac].apfi104,g_apfh2_d[l_ac].apfi201,g_apfh2_d[l_ac].apfi204, 
          g_apfh2_d[l_ac].apfi013,g_apfh3_d[l_ac].apfiseq,g_apfh3_d[l_ac].apfi012,g_apfh3_d[l_ac].apfi009, 
          g_apfh3_d[l_ac].apfi010,g_apfh3_d[l_ac].apfi008,g_apfh3_d[l_ac].apfi007,g_apfh2_d[l_ac].apfi001_desc, 
          g_apfh3_d[l_ac].apfi012_desc,g_apfh3_d[l_ac].apfi010_desc,g_apfh3_d[l_ac].apfi007_desc   #(ver:78) 
 
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
   
   CALL g_apfh_d.deleteElement(g_apfh_d.getLength())
   CALL g_apfh2_d.deleteElement(g_apfh2_d.getLength())
   CALL g_apfh3_d.deleteElement(g_apfh3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aapt460_pb
   FREE aapt460_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_apfh_d.getLength()
      LET g_apfh_d_mask_o[l_ac].* =  g_apfh_d[l_ac].*
      CALL aapt460_apfh_t_mask()
      LET g_apfh_d_mask_n[l_ac].* =  g_apfh_d[l_ac].*
   END FOR
   
   LET g_apfh2_d_mask_o.* =  g_apfh2_d.*
   FOR l_ac = 1 TO g_apfh2_d.getLength()
      LET g_apfh2_d_mask_o[l_ac].* =  g_apfh2_d[l_ac].*
      CALL aapt460_apfi_t_mask()
      LET g_apfh2_d_mask_n[l_ac].* =  g_apfh2_d[l_ac].*
   END FOR
   LET g_apfh3_d_mask_o.* =  g_apfh3_d.*
   FOR l_ac = 1 TO g_apfh3_d.getLength()
      LET g_apfh3_d_mask_o[l_ac].* =  g_apfh3_d[l_ac].*
      CALL aapt460_apfi_t_mask()
      LET g_apfh3_d_mask_n[l_ac].* =  g_apfh3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aapt460.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt460_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM apfh_t
       WHERE apfhent = g_enterprise AND
         apfhdocno = ps_keys_bak[1] AND apfhseq = ps_keys_bak[2]
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
         CALL g_apfh_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2','3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM apfi_t
       WHERE apfient = g_enterprise AND
             apfidocno = ps_keys_bak[1] AND apfiseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apfi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apfh2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_apfh3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt460_insert_b(ps_table,ps_keys,ps_page)
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
      LET g_apfh_d[g_detail_idx].apfh007 = s_fin_get_scc_value('8506',g_apfh_d[g_detail_idx].apfh006,'1')
      #end add-point 
      INSERT INTO apfh_t
                  (apfhent,
                   apfhdocno,
                   apfhseq
                   ,apfh001,apfhld,apfh006,apfh004,apfh002,apfh003,apfh008,apfh100,apfh103,apfh101,apfh104,apfh005,apfh201,apfh204,apfh007) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_apfh_d[g_detail_idx].apfh001,g_apfh_d[g_detail_idx].apfhld,g_apfh_d[g_detail_idx].apfh006, 
                       g_apfh_d[g_detail_idx].apfh004,g_apfh_d[g_detail_idx].apfh002,g_apfh_d[g_detail_idx].apfh003, 
                       g_apfh_d[g_detail_idx].apfh008,g_apfh_d[g_detail_idx].apfh100,g_apfh_d[g_detail_idx].apfh103, 
                       g_apfh_d[g_detail_idx].apfh101,g_apfh_d[g_detail_idx].apfh104,g_apfh_d[g_detail_idx].apfh005, 
                       g_apfh_d[g_detail_idx].apfh201,g_apfh_d[g_detail_idx].apfh204,g_apfh_d[g_detail_idx].apfh007) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apfh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apfh_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2','3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      LET g_apfh2_d[g_detail_idx].apfi013 = s_fin_get_scc_value('8506',g_apfh2_d[g_detail_idx].apfi006,'1')
      #end add-point 
      INSERT INTO apfi_t
                  (apfient,
                   apfidocno,
                   apfiseq
                   ,apfi001,apfi002,apfi006,apfi003,apfi004,apfi005,apfi011,apfi100,apfi101,apfi103,apfi104,apfi201,apfi204,apfi013,apfi012,apfi009,apfi010,apfi008,apfi007) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_apfh2_d[g_detail_idx].apfi001,g_apfh2_d[g_detail_idx].apfi002,g_apfh2_d[g_detail_idx].apfi006, 
                       g_apfh2_d[g_detail_idx].apfi003,g_apfh2_d[g_detail_idx].apfi004,g_apfh2_d[g_detail_idx].apfi005, 
                       g_apfh2_d[g_detail_idx].apfi011,g_apfh2_d[g_detail_idx].apfi100,g_apfh2_d[g_detail_idx].apfi101, 
                       g_apfh2_d[g_detail_idx].apfi103,g_apfh2_d[g_detail_idx].apfi104,g_apfh2_d[g_detail_idx].apfi201, 
                       g_apfh2_d[g_detail_idx].apfi204,g_apfh2_d[g_detail_idx].apfi013,g_apfh3_d[g_detail_idx].apfi012, 
                       g_apfh3_d[g_detail_idx].apfi009,g_apfh3_d[g_detail_idx].apfi010,g_apfh3_d[g_detail_idx].apfi008, 
                       g_apfh3_d[g_detail_idx].apfi007)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apfi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apfh2_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_apfh3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt460_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apfh_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aapt460_apfh_t_mask_restore('restore_mask_o')
               
      UPDATE apfh_t 
         SET (apfhdocno,
              apfhseq
              ,apfh001,apfhld,apfh006,apfh004,apfh002,apfh003,apfh008,apfh100,apfh103,apfh101,apfh104,apfh005,apfh201,apfh204,apfh007) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_apfh_d[g_detail_idx].apfh001,g_apfh_d[g_detail_idx].apfhld,g_apfh_d[g_detail_idx].apfh006, 
                  g_apfh_d[g_detail_idx].apfh004,g_apfh_d[g_detail_idx].apfh002,g_apfh_d[g_detail_idx].apfh003, 
                  g_apfh_d[g_detail_idx].apfh008,g_apfh_d[g_detail_idx].apfh100,g_apfh_d[g_detail_idx].apfh103, 
                  g_apfh_d[g_detail_idx].apfh101,g_apfh_d[g_detail_idx].apfh104,g_apfh_d[g_detail_idx].apfh005, 
                  g_apfh_d[g_detail_idx].apfh201,g_apfh_d[g_detail_idx].apfh204,g_apfh_d[g_detail_idx].apfh007)  
 
         WHERE apfhent = g_enterprise AND apfhdocno = ps_keys_bak[1] AND apfhseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apfh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apfh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt460_apfh_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2','3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apfi_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aapt460_apfi_t_mask_restore('restore_mask_o')
               
      UPDATE apfi_t 
         SET (apfidocno,
              apfiseq
              ,apfi001,apfi002,apfi006,apfi003,apfi004,apfi005,apfi011,apfi100,apfi101,apfi103,apfi104,apfi201,apfi204,apfi013,apfi012,apfi009,apfi010,apfi008,apfi007) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_apfh2_d[g_detail_idx].apfi001,g_apfh2_d[g_detail_idx].apfi002,g_apfh2_d[g_detail_idx].apfi006, 
                  g_apfh2_d[g_detail_idx].apfi003,g_apfh2_d[g_detail_idx].apfi004,g_apfh2_d[g_detail_idx].apfi005, 
                  g_apfh2_d[g_detail_idx].apfi011,g_apfh2_d[g_detail_idx].apfi100,g_apfh2_d[g_detail_idx].apfi101, 
                  g_apfh2_d[g_detail_idx].apfi103,g_apfh2_d[g_detail_idx].apfi104,g_apfh2_d[g_detail_idx].apfi201, 
                  g_apfh2_d[g_detail_idx].apfi204,g_apfh2_d[g_detail_idx].apfi013,g_apfh3_d[g_detail_idx].apfi012, 
                  g_apfh3_d[g_detail_idx].apfi009,g_apfh3_d[g_detail_idx].apfi010,g_apfh3_d[g_detail_idx].apfi008, 
                  g_apfh3_d[g_detail_idx].apfi007) 
         WHERE apfient = g_enterprise AND apfidocno = ps_keys_bak[1] AND apfiseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apfi_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apfi_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt460_apfi_t_mask_restore('restore_mask_n')
 
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
 
{<section id="aapt460.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aapt460_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt460.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aapt460_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt460.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt460_lock_b(ps_table,ps_page)
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
   #CALL aapt460_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "apfh_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aapt460_bcl USING g_enterprise,
                                       g_apfg_m.apfgdocno,g_apfh_d[g_detail_idx].apfhseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt460_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2','3',"
   #僅鎖定自身table
   LET ls_group = "apfi_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt460_bcl2 USING g_enterprise,
                                             g_apfg_m.apfgdocno,g_apfh2_d[g_detail_idx].apfiseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt460_bcl2:",SQLERRMESSAGE 
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
 
{<section id="aapt460.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt460_unlock_b(ps_table,ps_page)
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
      CLOSE aapt460_bcl
   END IF
   
   LET ls_group = "'2','3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt460_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aapt460.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapt460_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("apfgdocno,apfgld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("apfgdocno",TRUE)
      CALL cl_set_comp_entry("apfgdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("apfgsite,apfg002",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt460.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapt460_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_dfin0033  LIKE type_t.chr1  #151130-00015#2
   DEFINE l_success   LIKE type_t.chr1  #151130-00015#2
   DEFINE l_slip      LIKE type_t.chr80  #151130-00015#2 
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("apfgdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("apfgsite,apfg002",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("apfgdocno,apfgld",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("apfgdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #151130-00015#2  -add -str
   IF NOT cl_null(g_apfg_m.apfgdocno) THEN  
      #获取单别
      CALL s_aooi200_fin_get_slip(g_apfg_m.apfgdocno) RETURNING l_success,l_slip
      #取得單別設置的"是否直接審核"參數
      CALL s_fin_get_doc_para(g_apfg_m.apfgld,g_apfg_m.apfgcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "Y"  THEN 
         CALL cl_set_comp_entry("apfgdocdt",TRUE)
    
      END IF          
   END IF 
   #151130-00015#2  -end -str
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt460.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt460_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("apfh002,apfh003,apfh004",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aapt460.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt460_set_no_entry_b(p_cmd)
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
   CASE g_apfh_d[l_ac].apfh006      #付款類型
        WHEN '10'                   #10.付款
            #10.現金/20.電匯款/30.票據
            IF NOT(g_apfh_d[l_ac].apfh004 = '10' OR g_apfh_d[l_ac].apfh004 = '20' OR g_apfh_d[l_ac].apfh004 = '30') THEN 
               CALL cl_set_comp_entry("apfh003",FALSE)      #帳戶/票券
               LET g_apfh_d[l_ac].apfh003 = '' 
               IF g_apfh_d[l_ac].apfh004 = '90' THEN        #90.其他類型
                  CALL cl_set_comp_entry("apfh002",FALSE)   #已付款單號                         
                  LET g_apfh_d[l_ac].apfh002 = ''
               END IF
            END IF                                         
		  WHEN '16'
   		     CALL cl_set_comp_entry("apfh004",FALSE)   #款別
   		     IF NOT cl_null(g_apfh_d[l_ac].apfh002) THEN
                  CALL cl_set_comp_entry("apfh100,apfh103,apfh104",FALSE)
              END IF
		   OTHERWISE
            CALL cl_set_comp_entry("apfh002",FALSE)   #已付款單號
            LET g_apfh_d[l_ac].apfh002 = ''
            CALL cl_set_comp_entry("apfh003",FALSE)   #帳戶/票券
            LET g_apfh_d[l_ac].apfh003 = ''
            CALL cl_set_comp_entry("apfh004",FALSE)   #款別
            LET g_apfh_d[l_ac].apfh004 = ''
      END CASE  
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aapt460.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapt460_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapt460_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_ld          LIKE glaa_t.glaald      #160225-00001#1
   DEFINE l_dfin0033    LIKE type_t.chr1        #160225-00001#1
   DEFINE l_slip        LIKE apca_t.apcadocno   #160225-00001#1
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_apfg_m.apfgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   CALL cl_set_act_visible("output", FALSE)
   CALL cl_set_act_visible("reproduce", FALSE)
   #160225-00001#1--(S)
   IF NOT cl_null(g_apfg_m.apfgdocno) THEN
      SELECT glaald INTO l_ld FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_apfg_m.apfgcomp
         AND glaa014 = 'Y'
      CALL s_aooi200_fin_get_slip(g_apfg_m.apfgdocno) RETURNING g_sub_success,l_slip
      CALL s_fin_get_doc_para(l_ld,g_apfg_m.apfgcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      CALL s_fin_date_close_chk('@',g_apfg_m.apfgcomp,'AAP',g_apfg_m.apfgdocdt) RETURNING g_sub_success
      IF l_dfin0033 = "N" AND NOT g_sub_success THEN 
         CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
      END IF
   END IF
   #160225-00001#1--(E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aapt460_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aapt460_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt460_default_search()
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
      LET ls_wc = ls_wc, " apfgdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "apfg_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apfh_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apfi_t" 
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
 
{<section id="aapt460.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aapt460_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   CALL aapt460_diff() RETURNING g_sub_success
   IF NOT g_sub_success THEN RETURN END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_apfg_m.apfgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aapt460_cl USING g_enterprise,g_apfg_m.apfgdocno
   IF STATUS THEN
      CLOSE aapt460_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt460_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aapt460_master_referesh USING g_apfg_m.apfgdocno INTO g_apfg_m.apfgsite,g_apfg_m.apfg001, 
       g_apfg_m.apfgld,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfgstus, 
       g_apfg_m.apfgownid,g_apfg_m.apfgowndp,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtdp,g_apfg_m.apfgcrtdt, 
       g_apfg_m.apfgmodid,g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid, 
       g_apfg_m.apfgpstdt,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001_desc,g_apfg_m.apfgld_desc,g_apfg_m.apfg002_desc, 
       g_apfg_m.apfgownid_desc,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid_desc,g_apfg_m.apfgcrtdp_desc, 
       g_apfg_m.apfgmodid_desc,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgpstid_desc
   
 
   #檢查是否允許此動作
   IF NOT aapt460_action_chk() THEN
      CLOSE aapt460_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apfg_m.apfgsite,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001,g_apfg_m.apfg001_desc,g_apfg_m.apfgld, 
       g_apfg_m.apfgld_desc,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocno_desc,g_apfg_m.apfgdocdt, 
       g_apfg_m.apfg002,g_apfg_m.apfg002_desc,g_apfg_m.apfgstus,g_apfg_m.apfgownid,g_apfg_m.apfgownid_desc, 
       g_apfg_m.apfgowndp,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtid_desc,g_apfg_m.apfgcrtdp, 
       g_apfg_m.apfgcrtdp_desc,g_apfg_m.apfgcrtdt,g_apfg_m.apfgmodid,g_apfg_m.apfgmodid_desc,g_apfg_m.apfgmoddt, 
       g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid,g_apfg_m.apfgpstid_desc, 
       g_apfg_m.apfgpstdt
 
   CASE g_apfg_m.apfgstus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
         CASE g_apfg_m.apfgstus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "N"
               HIDE OPTION "unconfirmed"
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
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_apfg_m.apfgstus
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
            CALL s_transaction_end('N','0')      #150401-00001#13
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
            IF NOT aapt460_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt460_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aapt460_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt460_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
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
   IF (lc_state <> "Y" 
      AND lc_state <> "N"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_apfg_m.apfgstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aapt460_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #取消確認
   IF lc_state = 'N' THEN
      CALL s_aapt460_prepare_declare()
      CALL cl_err_collect_init()
      IF NOT s_aapt460_unconf_chk(g_apfg_m.apfgld,g_apfg_m.apfgdocno)  THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()   
         RETURN    #一定要RETURN,避免執行後面的UPDATE狀態的程式段
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()   
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_aapt460_unconf_upd(g_apfg_m.apfgld,g_apfg_m.apfgdocno) THEN
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
   #確認
   IF lc_state = 'Y' THEN
      CALL s_aapt460_prepare_declare()
      CALL cl_err_collect_init()
      IF NOT s_aapt460_conf_chk(g_apfg_m.apfgld,g_apfg_m.apfgdocno)  THEN
         CALL s_transaction_end('N','0') 
         CALL cl_err_collect_show()
         RETURN    #一定要RETURN,避免執行後面的UPDATE狀態的程式段
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()   
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_aapt460_conf_upd(g_apfg_m.apfgld,g_apfg_m.apfgdocno) THEN
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
   #作廢
   IF lc_state = 'X' THEN
      CALL s_aapt460_prepare_declare()
      CALL cl_err_collect_init()           
      IF NOT s_aapt460_void_chk(g_apfg_m.apfgld,g_apfg_m.apfgdocno)  THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()   
         RETURN    #一定要RETURN,避免執行後面的UPDATE狀態的程式段
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()   
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_aapt460_void_upd(g_apfg_m.apfgld,g_apfg_m.apfgdocno) THEN
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
   
   LET g_apfg_m.apfgmodid = g_user
   LET g_apfg_m.apfgmoddt = cl_get_current()
   LET g_apfg_m.apfgstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE apfg_t 
      SET (apfgstus,apfgmodid,apfgmoddt) 
        = (g_apfg_m.apfgstus,g_apfg_m.apfgmodid,g_apfg_m.apfgmoddt)     
    WHERE apfgent = g_enterprise AND apfgdocno = g_apfg_m.apfgdocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
      EXECUTE aapt460_master_referesh USING g_apfg_m.apfgdocno INTO g_apfg_m.apfgsite,g_apfg_m.apfg001, 
          g_apfg_m.apfgld,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfgstus, 
          g_apfg_m.apfgownid,g_apfg_m.apfgowndp,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtdp,g_apfg_m.apfgcrtdt, 
          g_apfg_m.apfgmodid,g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid, 
          g_apfg_m.apfgpstdt,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001_desc,g_apfg_m.apfgld_desc,g_apfg_m.apfg002_desc, 
          g_apfg_m.apfgownid_desc,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid_desc,g_apfg_m.apfgcrtdp_desc, 
          g_apfg_m.apfgmodid_desc,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgpstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_apfg_m.apfgsite,g_apfg_m.apfgsite_desc,g_apfg_m.apfg001,g_apfg_m.apfg001_desc, 
          g_apfg_m.apfgld,g_apfg_m.apfgld_desc,g_apfg_m.apfgcomp,g_apfg_m.apfgdocno,g_apfg_m.apfgdocno_desc, 
          g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfg_m.apfg002_desc,g_apfg_m.apfgstus,g_apfg_m.apfgownid, 
          g_apfg_m.apfgownid_desc,g_apfg_m.apfgowndp,g_apfg_m.apfgowndp_desc,g_apfg_m.apfgcrtid,g_apfg_m.apfgcrtid_desc, 
          g_apfg_m.apfgcrtdp,g_apfg_m.apfgcrtdp_desc,g_apfg_m.apfgcrtdt,g_apfg_m.apfgmodid,g_apfg_m.apfgmodid_desc, 
          g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfid_desc,g_apfg_m.apfgcnfdt,g_apfg_m.apfgpstid, 
          g_apfg_m.apfgpstid_desc,g_apfg_m.apfgpstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   SELECT apfgmodid,apfgmoddt,apfgcnfid,apfgcnfdt
     INTO g_apfg_m.apfgmodid,g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfdt
     FROM apfg_t
    WHERE apfgent = g_enterprise 
      AND apfgld = g_apfg_m.apfgld AND apfgdocno = g_apfg_m.apfgdocno
   DISPLAY BY NAME g_apfg_m.apfgmodid,g_apfg_m.apfgmoddt,g_apfg_m.apfgcnfid,g_apfg_m.apfgcnfdt
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aapt460_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt460_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt460.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aapt460_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_apfh_d.getLength() THEN
         LET g_detail_idx = g_apfh_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apfh_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apfh_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_apfh2_d.getLength() THEN
         LET g_detail_idx = g_apfh2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apfh2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apfh2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_apfh3_d.getLength() THEN
         LET g_detail_idx = g_apfh3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apfh3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apfh3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapt460_b_fill2(pi_idx)
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
   
   CALL aapt460_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aapt460_fill_chk(ps_idx)
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
 
{<section id="aapt460.status_show" >}
PRIVATE FUNCTION aapt460_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapt460.mask_functions" >}
&include "erp/aap/aapt460_mask.4gl"
 
{</section>}
 
{<section id="aapt460.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aapt460_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL aapt460_show()
   CALL aapt460_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_apfg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_apfh_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_apfh2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_apfh3_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   CALL s_aapt460_prepare_declare()
   IF NOT s_aapt460_conf_chk(g_apfg_m.apfgld,g_apfg_m.apfgdocno) THEN
      CLOSE aapt460_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL aapt460_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aapt460_ui_headershow()
   CALL aapt460_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aapt460_draw_out()
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
   CALL aapt460_ui_headershow()  
   CALL aapt460_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aapt460.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt460_set_pk_array()
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
   LET g_pk_array[1].values = g_apfg_m.apfgdocno
   LET g_pk_array[1].column = 'apfgdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt460.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aapt460.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapt460_msgcentre_notify(lc_state)
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
   CALL aapt460_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_apfg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt460.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aapt460_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt460.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 15/10/30 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt460_set_ld_info(p_ld,p_stus)
DEFINE p_ld          LIKE apca_t.apcald
DEFINE p_stus        LIKE type_t.chr1
DEFINE l_gzzd005     LIKE gzzd_t.gzzd005
DEFINE l_using       LIKE type_t.num5
DEFINE l_i           LIKE type_t.num5
DEFINE l_str         LIKE type_t.chr100
DEFINE l_sql         STRING
DEFINE l_title       DYNAMIC ARRAY OF RECORD        
                     curr1      LIKE type_t.chr100,
                     curr2      LIKE type_t.chr100,
                     curr3      LIKE type_t.chr100
                 END RECORD 

   IF cl_null(p_ld) THEN RETURN END IF
   CALL s_ld_sel_glaa(p_ld,'glaacomp|glaa001|glaa004|glaa015|glaa016|glaa017|glaa019|glaa020|glaa021|glaa024|glaa121')
        RETURNING g_sub_success,g_glaa.*
  #LET g_apfg_m.apfg120 = g_glaa.glaa016
  #LET g_apfg_m.apfg130 = g_glaa.glaa020
  #LET g_apfg_m.glaa001 = g_glaa.glaa001
  #LET g_apfg_m.glaa0011= g_glaa.glaa001
   LET g_apfg_m.apfgcomp= g_glaa.glaacomp
   
  #DISPLAY BY NAME g_apca_m.glaa001,g_apca_m.glaa0011,g_apca_m.apca120,g_apca_m.apca130
   
   #取得帳務組織下所屬成員
   IF cl_null(p_stus) THEN
      CALL s_fin_account_center_sons_query('3',g_apfg_m.apfgsite,g_apfg_m.apfgdocdt,'1')
      CALL s_fin_account_center_comp_str() RETURNING g_wc_apfgcomp
      CALL s_fin_get_wc_str(g_wc_apfgcomp) RETURNING g_wc_apfgcomp
      CALL s_fin_account_center_ld_str() RETURNING g_wc_apfgld
      CALL s_fin_get_wc_str(g_wc_apfgld) RETURNING g_wc_apfgld   
   END IF
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apfg_m.apfgcomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#5 add #161229-00047#49 mark
   CALL s_fin_get_wc_str(g_apfg_m.apfgcomp) RETURNING g_comp_str  #161229-00047#49 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#49 add 
   ##設定欄位名稱
   #LET l_title[1].curr1 = 'apcb1131'   LET l_title[2].curr1 = 'apcb1141'   LET l_title[3].curr1 = 'apcb1151'
   #LET l_title[1].curr2 = 'apcb1231'   LET l_title[2].curr2 = 'apcb1241'   LET l_title[3].curr2 = 'apcb1251'
   #LET l_title[1].curr3 = 'apcb1331'   LET l_title[2].curr3 = 'apcb1341'   LET l_title[3].curr3 = 'apcb1351'
   #LET l_sql = "SELECT gzzd005 FROM gzzd_t",
   #            " WHERE gzzd001 = ? AND gzzd002 = '",g_lang,"'",
   #            "   AND gzzd003 = ? AND gzzdstus = 'Y'"
   #PREPARE get_title_pre FROM l_sql
   #
   ##本幣處理===(S)===
   ##單身幣別名稱設定(azzi902要設定)
   #FOR l_i = 1 TO l_title.getLength()
   #    LET l_str = "lbl_",l_title[l_i].curr1
   #    EXECUTE get_title_pre USING g_prog,l_str INTO l_gzzd005
   #    LET l_str = l_gzzd005,"(",g_apca_m.glaa001,")"
   #    CALL cl_set_comp_att_text(l_title[l_i].curr1,l_str)
   #END FOR
   ##本幣處理===(E)===
   #IF g_glaa.glaa015 = 'N' AND  g_glaa.glaa019 = 'N' THEN
   #   CALL cl_set_comp_visible('page7,bpage2,xrcd124,xrcd134',FALSE)    #本位幣頁籤隱藏
   #   CALL cl_set_comp_required('apca121,apca131',FALSE)
   #ELSE
   #   CALL cl_set_comp_visible('page7,bpage2',TRUE)     #本位幣頁籤顯示
   #   #本幣二處理===(S)===
   #   IF g_glaa.glaa015 = 'Y' THEN LET l_using = TRUE ELSE LET l_using = FALSE END IF
   #   CALL cl_set_comp_visible('apca120,apca121,apca123,apca124,apca126,apca128,apcc123,apcc129,net128',l_using)
   #   CALL cl_set_comp_visible('apcb1231,apcb1241,apcb1251,xrcd124',l_using)
   #   CALL cl_set_comp_required('apca121',l_using)
   #   IF g_glaa.glaa015 = 'Y' THEN
   #      FOR l_i = 1 TO l_title.getLength()
   #          LET l_str = "lbl_",l_title[l_i].curr2
   #          EXECUTE get_title_pre USING g_prog,l_str INTO l_gzzd005
   #          LET l_str = l_gzzd005,"(",g_apca_m.apca120,")"
   #          CALL cl_set_comp_att_text(l_title[l_i].curr2,l_str)
   #      END FOR
   #   END IF
   #   #本幣二處理===(E)===
   #   
   #   #本幣三處理===(S)===
   #   LET l_using = TRUE
   #   IF g_glaa.glaa019 = 'Y' THEN LET l_using = TRUE ELSE LET l_using = FALSE END IF
   #   CALL cl_set_comp_visible('apca130,apca131,apca133,apca134,apca136,apca138,apcc133,apcc139,net138',l_using)
   #   CALL cl_set_comp_visible('apcb1331,apcb1341,apcb1351,xrcd134',l_using)
   #   CALL cl_set_comp_required('apca131',l_using)
   #   IF g_glaa.glaa019 = 'Y' THEN
   #      FOR l_i = 1 TO l_title.getLength()
   #          LET l_str = "lbl_",l_title[l_i].curr3
   #          EXECUTE get_title_pre USING g_prog,l_str INTO l_gzzd005
   #          LET l_str = l_gzzd005,"(",g_apca_m.apca130,")"
   #          CALL cl_set_comp_att_text(l_title[l_i].curr3,l_str)
   #      END FOR
   #   END IF
   #   #本幣三處理===(E)===
   #END IF
END FUNCTION

################################################################################
# Date & Author..: 15/11/10 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt460_tran_rate_apfh(p_type1)
DEFINE p_type1                LIKE type_t.chr1     #是否重取匯率
DEFINE l_apfh001_glaa001      LIKE glaa_t.glaa001  #代付方本幣
DEFINE l_apfh001_glaald       LIKE glaa_t.glaald   #代付方帳套
   
   IF p_type1 = 'Y' THEN
      #CALL s_aapt460_get_rate(g_apfg_m.apfgcomp,g_apfh2_d[l_ac].apfi001,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfh2_d[l_ac].apfi100)   #160818-00035#1 mark
      CALL s_aapt460_get_rate(g_apfg_m.apfgcomp,g_apfg_m.apfgcomp,g_apfg_m.apfgdocdt,g_apfg_m.apfg002,g_apfh_d[l_ac].apfh100)            #albireo 160818 add #160818-00035#1
           RETURNING g_apfh_d[l_ac].apfh101,g_apfh_d[l_ac].apfh201
   END IF  
   
   #法人組織本幣
   SELECT glaa001,glaald INTO l_apfh001_glaa001,l_apfh001_glaald
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaacomp = g_apfh_d[l_ac].apfh001
      AND glaa014 = 'Y'
      
   LET g_apfh_d[l_ac].apfh104 = g_apfh_d[l_ac].apfh103 * g_apfh_d[l_ac].apfh101
   IF cl_null(g_apfh_d[l_ac].apfh104) THEN LET g_apfh_d[l_ac].apfh104 = 0 END IF
   CALL s_curr_round_ld('1',l_apfh001_glaald,l_apfh001_glaa001,g_apfh_d[l_ac].apfh104,2) RETURNING g_sub_success,g_errno,g_apfh_d[l_ac].apfh104
   
   #代付方本幣(單頭帳套的主幣別)
   LET g_apfh_d[l_ac].apfh204 = g_apfh_d[l_ac].apfh103 * g_apfh_d[l_ac].apfh201
   IF cl_null(g_apfh_d[l_ac].apfh204) THEN LET g_apfh_d[l_ac].apfh204 = 0 END IF
   CALL s_curr_round_ld('1',g_apfg_m.apfgld,g_glaa.glaa001,g_apfh_d[l_ac].apfh204,2) RETURNING g_sub_success,g_errno,g_apfh_d[l_ac].apfh204
   
   DISPLAY BY NAME g_apfh_d[l_ac].apfh101,g_apfh_d[l_ac].apfh104,
                   g_apfh_d[l_ac].apfh201,g_apfh_d[l_ac].apfh204
   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 15/11/13 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt460_tran_rate_apfi(p_type1)
DEFINE p_type1                LIKE type_t.chr1     #是否重取匯率
DEFINE l_apfh001_glaa001      LIKE glaa_t.glaa001  #代付方本幣
DEFINE l_apfh001_glaald       LIKE glaa_t.glaald   #代付方帳套
      
   #法人組織本幣
   SELECT glaa001,glaald INTO l_apfh001_glaa001,l_apfh001_glaald
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaacomp = g_apfh2_d[l_ac].apfi001
      AND glaa014 = 'Y'
      
   LET g_apfh2_d[l_ac].apfi104 = g_apfh2_d[l_ac].apfi103 * g_apfh2_d[l_ac].apfi101
   IF cl_null(g_apfh2_d[l_ac].apfi104) THEN LET g_apfh2_d[l_ac].apfi104 = 0 END IF
   CALL s_curr_round_ld('1',l_apfh001_glaald,l_apfh001_glaa001,g_apfh2_d[l_ac].apfi104,2) 
        RETURNING g_sub_success,g_errno,g_apfh2_d[l_ac].apfi104
   
   #代付方本幣(單頭帳套的主幣別)
   LET g_apfh2_d[l_ac].apfi204 = g_apfh2_d[l_ac].apfi103 * g_apfh2_d[l_ac].apfi201
   IF cl_null(g_apfh2_d[l_ac].apfi204) THEN LET g_apfh2_d[l_ac].apfi204 = 0 END IF
   CALL s_curr_round_ld('1',g_apfg_m.apfgld,g_glaa.glaa001,g_apfh2_d[l_ac].apfi204,2) 
        RETURNING g_sub_success,g_errno,g_apfh2_d[l_ac].apfi204
   
   DISPLAY BY NAME g_apfh2_d[l_ac].apfi104,g_apfh2_d[l_ac].apfi204
   
END FUNCTION

################################################################################
# Descriptions...: 
# Date & Author..: 15/11/10 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt460_nmck_carry(p_nmckcomp,p_nmckdocno)
DEFINE p_nmckcomp    LIKE nmck_t.nmckcomp
DEFINE p_nmckdocno   LIKE nmck_t.nmckdocno
DEFINE l_nmck        RECORD
         nmck002     LIKE nmck_t.nmck002,
         nmck003     LIKE nmck_t.nmck003,
         nmck004     LIKE nmck_t.nmck004,
         nmck005     LIKE nmck_t.nmck005,
         nmck009     LIKE nmck_t.nmck009, #
         nmck010     LIKE nmck_t.nmck010,
         nmck012     LIKE nmck_t.nmck012,
         nmck013     LIKE nmck_t.nmck013,
         nmck014     LIKE nmck_t.nmck014,
         nmck025     LIKE nmck_t.nmck025,
         nmck100     LIKE nmck_t.nmck100, #
         nmck101     LIKE nmck_t.nmck101,
         nmck121     LIKE nmck_t.nmck121,
         nmck131     LIKE nmck_t.nmck131
                 END RECORD
DEFINE l_apde119     LIKE apde_t.apde119

   SELECT nmck002,nmck003,nmck004,nmck005,nmck009,
          nmck010,nmck012,nmck013,nmck014,nmck025,
          nmck100,nmck101,nmck121,nmck131
     INTO l_nmck.*
     FROM nmck_t
    WHERE nmckent = g_enterprise
      AND nmckcomp = p_nmckcomp AND nmckdocno = p_nmckdocno

   LET g_apfh_d[l_ac].apfh003 = l_nmck.nmck004  #付款帳戶
   LET g_apfh_d[l_ac].apfh005 = l_nmck.nmck009  #銀行存提碼
   LET g_apfh_d[l_ac].apfh008 = l_nmck.nmck025  #票據號碼
   LET g_apfh_d[l_ac].apfh100 = l_nmck.nmck100	#付款幣別
   LET g_apfh_d[l_ac].apfh101 = l_nmck.nmck101	#匯率

   #取得已付款單剩餘可沖金額
   CALL s_aapt420_get_payed_amount(g_apfg_m.apfgld,g_apfg_m.apfgdocno,g_apfh_d[l_ac].apfhseq,p_nmckcomp,g_apfh_d[l_ac].apfh002)
        RETURNING g_apfh_d[l_ac].apfh103,g_apfh_d[l_ac].apfh104,l_apde119,l_apde119
  
   DISPLAY BY NAME g_apfh_d[l_ac].apfh003,g_apfh_d[l_ac].apfh005,g_apfh_d[l_ac].apfh008,g_apfh_d[l_ac].apfh100,
                   g_apfh_d[l_ac].apfh101,g_apfh_d[l_ac].apfh103,g_apfh_d[l_ac].apfh104
   CALL aapt460_tran_rate_apfh('N')

END FUNCTION

################################################################################
# Descriptions...: 收票轉付
# Memo...........:
# Usage..........: CALL aapt460_apfh003_carry
# Date & Author..: 15/11/27 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt460_nmbb_carry(p_nmbbcomp,p_nmbbdocno,p_nmbb030)
DEFINE  p_nmbbcomp   LIKE nmbb_t.nmbbcomp   #法人
DEFINE  p_nmbbdocno  LIKE nmbb_t.nmbbdocno  #單號
DEFINE  p_nmbb030    LIKE nmbb_t.nmbb030    #票據號碼
DEFINE  l_nmbb       RECORD
           nmbb043   LIKE nmbb_t.nmbb043,
           nmbb028   LIKE nmbb_t.nmbb028,
           nmbb031   LIKE nmbb_t.nmbb031,
           nmbb004   LIKE nmbb_t.nmbb004,
           nmbb056   LIKE nmbb_t.nmbb056,
           nmbb006   LIKE nmbb_t.nmbb006,
           nmbb058   LIKE nmbb_t.nmbb058       
                 END RECORD

   IF cl_null(p_nmbbdocno) OR cl_null(p_nmbb030) THEN RETURN END IF
 
   SELECT nmbb043,nmbb028,nmbb031,nmbb004,nmbb056,
          nmbb006,nmbb058
     INTO l_nmbb.*
     FROM nmbb_t
    WHERE nmbbent = g_enterprise
      AND nmbbcomp = p_nmbbcomp
      AND nmbbdocno = p_nmbbdocno AND nmbb030 = p_nmbb030

   LET g_apfh_d[l_ac].apfh100 = l_nmbb.nmbb004	#付款幣別
   LET g_apfh_d[l_ac].apfh101 = l_nmbb.nmbb056	#匯率
   LET g_apfh_d[l_ac].apfh103 = l_nmbb.nmbb006  #原幣沖帳金額
   LET g_apfh_d[l_ac].apfh104 = l_nmbb.nmbb058  #本幣沖帳金額
   
   DISPLAY BY NAME g_apfh_d[l_ac].apfh100,g_apfh_d[l_ac].apfh101,g_apfh_d[l_ac].apfh103,g_apfh_d[l_ac].apfh104
   CALL aapt460_tran_rate_apfh('N')
  
	
END FUNCTION

################################################################################
# Descriptions...: 差異處理
# Memo...........:
# Date & Author..: 2015/11/20 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt460_diff()
DEFINE l_flag           LIKE type_t.chr1
DEFINE l_amt            LIKE apfh_t.apfh204
DEFINE l_apfi204        LIKE apfh_t.apfh204
DEFINE l_apfh204        LIKE apfh_t.apfh204
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE

   #檢核帳款明細單身與預設付款明細單身本幣金額是否為平
   SELECT SUM(CASE apfi013 WHEN 'D' THEN apfi204 ELSE 0 END) - SUM(CASE apfi013 WHEN 'C' THEN apfi204 ELSE 0 END)
     INTO l_apfi204 
     FROM apfi_t
    WHERE apfient = g_enterprise AND apfidocno = g_apfg_m.apfgdocno    
    
   SELECT SUM(CASE apfh007 WHEN 'C' THEN apfh204 ELSE 0 END) - SUM(CASE apfh007 WHEN 'D' THEN apfh204 ELSE 0 END)
     INTO l_apfh204
     FROM apfh_t
    WHERE apfhent = g_enterprise AND apfhdocno = g_apfg_m.apfgdocno
       
   IF cl_null(l_apfh204) THEN LET l_apfh204 = 0 END IF
   IF cl_null(l_apfi204) THEN LET l_apfi204 = 0 END IF
   IF l_apfh204 <> l_apfi204 THEN
      IF l_apfh204 > l_apfi204 THEN 
         #LET l_flag = '1' #付款>帳款   #160818-00035#1 mark
         LET l_flag = '2'              #160818-00035#1 
         
         LET l_amt  = l_apfh204 - l_apfi204
      ELSE
         #LET l_flag = '2' #付款<帳款    #160818-00035#1 mark
         LET l_flag = '1'               #160818-00035#1
         LET l_amt  = l_apfi204 - l_apfh204
      END IF
      CALL aapt460_02(g_apfg_m.apfgdocno,l_flag,l_amt) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_apfg_m.apfgdocno
         LET g_errparam.code   = "axr-00205"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         #RETURN   #albireo 160818 mark   #160818-00035#1 mark
         LET r_success = FALSE   #albireo 160818 add   #160818-00035#1
         RETURN r_success        #albireo 160818 add   #160818-00035#1
      ELSE
         CALL aapt460_b_fill()
      END IF
   END IF
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 編輯完單據後立即審核
# Memo...........:
# Usage..........: CALL aapt460_immediately_conf()
#                  RETURNING ---
# Date & Author..: 2015/12/02 By 06421
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt460_immediately_conf()
#151125-00006#2--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   IF cl_null(g_apfg_m.apfgld)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_apfg_m.apfgsite)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_apfg_m.apfgdocno) THEN RETURN END IF   #無資料直接返回不做處理
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM apfh_t WHERE apfhent = g_enterprise
      AND apfhdocno = g_apfg_m.apfgdocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #第一单身無資料直接返回不做處理
   
   SELECT COUNT(*) INTO l_count FROM apfi_t WHERE apfient = g_enterprise
      AND apfidocno = g_apfg_m.apfgdocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #第二单身無資料直接返回不做處理
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_apfg_m.apfgdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_apfg_m.apfgld,g_apfg_m.apfgcomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
      

   IF NOT s_aapt460_conf_chk(g_apfg_m.apfgld,g_apfg_m.apfgdocno) THEN
      LET l_doc_success = FALSE
   END IF
   
   IF NOT s_aapt460_conf_upd(g_apfg_m.apfgld,g_apfg_m.apfgdocno) THEN
      LET l_doc_success = FALSE
   END IF

   
   #異動狀態碼欄位/修改人/修改日期
   LET g_apfg_m.apfgmoddt = cl_get_current()
   LET g_apfg_m.apfgcnfdt = cl_get_current()
   UPDATE apfg_t SET apfgstus = 'Y',
                     apfgmodid= g_user,
                     apfgmoddt= g_apfg_m.apfgmoddt,
                     apfgcnfid= g_user,
                     apfgcnfdt= g_apfg_m.apfgcnfdt
    WHERE apfgent = g_enterprise AND apfgld = g_apfg_m.apfgld
      AND apfgdocno = g_apfg_m.apfgdocno
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
#151125-00006#2--e

END FUNCTION

################################################################################
# Descriptions...: 轉成SQL
# Memo...........: #161014-00053#3
# Usage..........: CALL aapt460_get_ooef001_wc(p_wc)
#                  RETURNING 回传参数
# Input parameter: p_wc 帳套
# Return code....: r_wc ('帳套')
# Date & Author..: 161021 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt460_get_ooef001_wc(p_wc)
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
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
END FUNCTION

 
{</section>}
 
