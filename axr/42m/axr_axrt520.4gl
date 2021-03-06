#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-07-13 16:09:06), PR版次:0005(2017-01-24 11:27:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000020
#+ Filename...: axrt520
#+ Description: 銷售信用狀修改作業
#+ Creator....: 03080(2016-07-13 16:09:06)
#+ Modifier...: 03080 -SD/PR- 08729
 
{</section>}
 
{<section id="axrt520.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Memos
#160905-00002#2   2016/09/05  By Hans     SQL無ENT補上
#160829-00004#4   2016/09/06  By 08729    處理取匯率但取錯幣別
#161111-00049#10  2016/11/30  By 07900    控制组权限修改
#161128-00061#5   2016/12/05  by 02481    标准程式定义采用宣告模式,弃用.*写法
#161104-00046#9   2017/01/11  By 06821    資料依照單別user dept權限過濾單號
#170119-00024#10  2017/01/23  By 08729    新舊值處理
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
PRIVATE type type_g_xrgd_m        RECORD
       xrgdcomp LIKE xrgd_t.xrgdcomp, 
   xrgdcomp_desc LIKE type_t.chr80, 
   xrgd005 LIKE xrgd_t.xrgd005, 
   xrgd005_desc LIKE type_t.chr80, 
   xrgd006 LIKE xrgd_t.xrgd006, 
   xrgddocno LIKE xrgd_t.xrgddocno, 
   xrgd900 LIKE xrgd_t.xrgd900, 
   xrgd002 LIKE xrgd_t.xrgd002, 
   xrgddocdt LIKE xrgd_t.xrgddocdt, 
   xrgd003 LIKE xrgd_t.xrgd003, 
   xrgd004 LIKE xrgd_t.xrgd004, 
   xrgd004_desc LIKE type_t.chr80, 
   xrgd001 LIKE xrgd_t.xrgd001, 
   xrgd024 LIKE xrgd_t.xrgd024, 
   xrgd025 LIKE xrgd_t.xrgd025, 
   xrgdstus LIKE xrgd_t.xrgdstus, 
   xrgdownid LIKE xrgd_t.xrgdownid, 
   xrgdownid_desc LIKE type_t.chr80, 
   xrgdowndp LIKE xrgd_t.xrgdowndp, 
   xrgdowndp_desc LIKE type_t.chr80, 
   xrgdcrtid LIKE xrgd_t.xrgdcrtid, 
   xrgdcrtid_desc LIKE type_t.chr80, 
   xrgdcrtdp LIKE xrgd_t.xrgdcrtdp, 
   xrgdcrtdp_desc LIKE type_t.chr80, 
   xrgdcrtdt LIKE xrgd_t.xrgdcrtdt, 
   xrgdmodid LIKE xrgd_t.xrgdmodid, 
   xrgdmodid_desc LIKE type_t.chr80, 
   xrgdmoddt LIKE xrgd_t.xrgdmoddt, 
   xrgdcnfid LIKE xrgd_t.xrgdcnfid, 
   xrgdcnfid_desc LIKE type_t.chr80, 
   xrgdcnfdt LIKE xrgd_t.xrgdcnfdt, 
   xrgdpstid LIKE xrgd_t.xrgdpstid, 
   xrgdpstid_desc LIKE type_t.chr80, 
   xrgdpstdt LIKE xrgd_t.xrgdpstdt, 
   xrgd008 LIKE xrgd_t.xrgd008, 
   xrgd008_desc LIKE type_t.chr80, 
   xrgd009 LIKE xrgd_t.xrgd009, 
   xrgd009_desc LIKE type_t.chr80, 
   xrgd022 LIKE xrgd_t.xrgd022, 
   xrgd022_desc LIKE type_t.chr80, 
   xrgd007 LIKE xrgd_t.xrgd007, 
   xrgd010 LIKE xrgd_t.xrgd010, 
   xrgd013 LIKE xrgd_t.xrgd013, 
   xrgd012 LIKE xrgd_t.xrgd012, 
   xrgd011 LIKE xrgd_t.xrgd011, 
   xrgd014 LIKE xrgd_t.xrgd014, 
   xrgd023 LIKE xrgd_t.xrgd023, 
   xrgd100 LIKE xrgd_t.xrgd100, 
   xrgd103 LIKE xrgd_t.xrgd103, 
   xrgd104 LIKE xrgd_t.xrgd104, 
   l_xrga104diff LIKE type_t.num20_6, 
   l_glaa001 LIKE type_t.chr10, 
   xrgd101 LIKE xrgd_t.xrgd101, 
   xrgd113 LIKE xrgd_t.xrgd113, 
   xrgd015 LIKE xrgd_t.xrgd015, 
   xrgd016 LIKE xrgd_t.xrgd016, 
   xrgd016_desc LIKE type_t.chr80, 
   xrgd017 LIKE xrgd_t.xrgd017, 
   xrgd018 LIKE xrgd_t.xrgd018, 
   xrgd019 LIKE xrgd_t.xrgd019, 
   xrgd020 LIKE xrgd_t.xrgd020, 
   xrgd021 LIKE xrgd_t.xrgd021
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xrge_d        RECORD
       xrgeseq LIKE xrge_t.xrgeseq, 
   xrgeorga LIKE xrge_t.xrgeorga, 
   xrgeorga_desc LIKE type_t.chr500, 
   xrge001 LIKE xrge_t.xrge001, 
   xrge002 LIKE xrge_t.xrge002, 
   xrge003 LIKE xrge_t.xrge003, 
   xrge004 LIKE xrge_t.xrge004, 
   xrge005 LIKE xrge_t.xrge005, 
   xrge008 LIKE xrge_t.xrge008, 
   xrge006 LIKE xrge_t.xrge006, 
   xrge007 LIKE xrge_t.xrge007, 
   xrge100 LIKE xrge_t.xrge100, 
   xrge101 LIKE xrge_t.xrge101, 
   xrge009 LIKE xrge_t.xrge009, 
   xrge105 LIKE xrge_t.xrge105, 
   xrge115 LIKE xrge_t.xrge115, 
   xrge901 LIKE xrge_t.xrge901, 
   xrge902 LIKE xrge_t.xrge902, 
   xrge903 LIKE xrge_t.xrge903
       END RECORD
PRIVATE TYPE type_g_xrge2_d RECORD
       apgcseq LIKE apgc_t.apgcseq, 
   apgcorga LIKE apgc_t.apgcorga, 
   apgc001 LIKE apgc_t.apgc001, 
   apgc001_desc LIKE type_t.chr500, 
   apgc002 LIKE apgc_t.apgc002, 
   apgc003 LIKE apgc_t.apgc003, 
   apgc005 LIKE apgc_t.apgc005, 
   apgc014 LIKE apgc_t.apgc014, 
   apgc100 LIKE apgc_t.apgc100, 
   apgc101 LIKE apgc_t.apgc101, 
   apgc006 LIKE apgc_t.apgc006, 
   apgc007 LIKE apgc_t.apgc007, 
   apgc008 LIKE apgc_t.apgc008, 
   apgc009 LIKE apgc_t.apgc009, 
   apgc010 LIKE apgc_t.apgc010, 
   apgc011 LIKE apgc_t.apgc011, 
   apgc103 LIKE apgc_t.apgc103, 
   apgc104 LIKE apgc_t.apgc104, 
   apgc105 LIKE apgc_t.apgc105, 
   apgc113 LIKE apgc_t.apgc113, 
   apgc114 LIKE apgc_t.apgc114, 
   apgc115 LIKE apgc_t.apgc115, 
   apgc004 LIKE apgc_t.apgc004, 
   apgc004_desc LIKE type_t.chr100, 
   apgc015 LIKE apgc_t.apgc015, 
   apgc015_desc LIKE type_t.chr500, 
   apgc016 LIKE apgc_t.apgc016, 
   apgc016_desc LIKE type_t.chr100, 
   apgc012 LIKE apgc_t.apgc012, 
   apgc013 LIKE apgc_t.apgc013
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xrgdcomp LIKE xrgd_t.xrgdcomp,
      b_xrgddocno LIKE xrgd_t.xrgddocno,
      b_xrgd900 LIKE xrgd_t.xrgd900
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xrge_d_color DYNAMIC ARRAY OF RECORD  
   xrgeseq       STRING,
   xrgeorga      STRING,
   xrgeorga_desc STRING,
   xrge001       STRING,
   xrge002       STRING,
   xrge003       STRING,
   xrge004       STRING,
   xrge005       STRING,
   xrge008       STRING,
   xrge006       STRING,
   xrge007       STRING,
   xrge100       STRING,
   xrge101       STRING,
   xrge009       STRING,
   xrge105       STRING,
   xrge115       STRING,
   xrge901       STRING,
   xrge902       STRING,
   xrge903       STRING
   END RECORD

DEFINE g_wc_cs_comp    STRING    #azzi800的權限可看的資料範圍
DEFINE g_wc_apgborga   STRING
DEFINE g_sql_ctrl      STRING
DEFINE g_sql_ctrl2     STRING                #161111-00049#10 Add 料件控制组
#161104-00046#9 --s add
DEFINE g_user_dept_wc    STRING     
DEFINE g_user_dept_wc_q  STRING      
#161104-00046#9 --e add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xrgd_m          type_g_xrgd_m
DEFINE g_xrgd_m_t        type_g_xrgd_m
DEFINE g_xrgd_m_o        type_g_xrgd_m
DEFINE g_xrgd_m_mask_o   type_g_xrgd_m #轉換遮罩前資料
DEFINE g_xrgd_m_mask_n   type_g_xrgd_m #轉換遮罩後資料
 
   DEFINE g_xrgdcomp_t LIKE xrgd_t.xrgdcomp
DEFINE g_xrgddocno_t LIKE xrgd_t.xrgddocno
DEFINE g_xrgd900_t LIKE xrgd_t.xrgd900
 
 
DEFINE g_xrge_d          DYNAMIC ARRAY OF type_g_xrge_d
DEFINE g_xrge_d_t        type_g_xrge_d
DEFINE g_xrge_d_o        type_g_xrge_d
DEFINE g_xrge_d_mask_o   DYNAMIC ARRAY OF type_g_xrge_d #轉換遮罩前資料
DEFINE g_xrge_d_mask_n   DYNAMIC ARRAY OF type_g_xrge_d #轉換遮罩後資料
DEFINE g_xrge2_d          DYNAMIC ARRAY OF type_g_xrge2_d
DEFINE g_xrge2_d_t        type_g_xrge2_d
DEFINE g_xrge2_d_o        type_g_xrge2_d
DEFINE g_xrge2_d_mask_o   DYNAMIC ARRAY OF type_g_xrge2_d #轉換遮罩前資料
DEFINE g_xrge2_d_mask_n   DYNAMIC ARRAY OF type_g_xrge2_d #轉換遮罩後資料
 
 
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
 
{<section id="axrt520.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   #161111-00049#10 Add  ---(S)---
   SELECT ooef017 INTO g_xrgd_m.xrgdcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_xrgd_m.xrgdcomp) RETURNING g_sub_success,g_sql_ctrl
   #161111-00049#10 Add  ---(E)---
   #161104-00046#9 --s add
   #xrgd
   #查詢時單別控制組
   LET g_user_dept_wc_q = ''
   CALL s_fin_get_user_dept_control('xrgdcomp','','xrgdent','xrgddocno') RETURNING g_user_dept_wc_q
   #xrga
   #新增時單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('xrgacomp','','xrgaent','xrgadocno') RETURNING g_user_dept_wc
   #161104-00046#9 --e add   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xrgdcomp,'',xrgd005,'',xrgd006,xrgddocno,xrgd900,xrgd002,xrgddocdt,xrgd003, 
       xrgd004,'',xrgd001,xrgd024,xrgd025,xrgdstus,xrgdownid,'',xrgdowndp,'',xrgdcrtid,'',xrgdcrtdp, 
       '',xrgdcrtdt,xrgdmodid,'',xrgdmoddt,xrgdcnfid,'',xrgdcnfdt,xrgdpstid,'',xrgdpstdt,xrgd008,'', 
       xrgd009,'',xrgd022,'',xrgd007,xrgd010,xrgd013,xrgd012,xrgd011,xrgd014,xrgd023,xrgd100,xrgd103, 
       xrgd104,'','',xrgd101,xrgd113,xrgd015,xrgd016,'',xrgd017,xrgd018,xrgd019,xrgd020,xrgd021", 
                      " FROM xrgd_t",
                      " WHERE xrgdent= ? AND xrgdcomp=? AND xrgddocno=? AND xrgd900=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt520_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xrgdcomp,t0.xrgd005,t0.xrgd006,t0.xrgddocno,t0.xrgd900,t0.xrgd002, 
       t0.xrgddocdt,t0.xrgd003,t0.xrgd004,t0.xrgd001,t0.xrgd024,t0.xrgd025,t0.xrgdstus,t0.xrgdownid, 
       t0.xrgdowndp,t0.xrgdcrtid,t0.xrgdcrtdp,t0.xrgdcrtdt,t0.xrgdmodid,t0.xrgdmoddt,t0.xrgdcnfid,t0.xrgdcnfdt, 
       t0.xrgdpstid,t0.xrgdpstdt,t0.xrgd008,t0.xrgd009,t0.xrgd022,t0.xrgd007,t0.xrgd010,t0.xrgd013,t0.xrgd012, 
       t0.xrgd011,t0.xrgd014,t0.xrgd023,t0.xrgd100,t0.xrgd103,t0.xrgd104,t0.xrgd101,t0.xrgd113,t0.xrgd015, 
       t0.xrgd016,t0.xrgd017,t0.xrgd018,t0.xrgd019,t0.xrgd020,t0.xrgd021,t2.ooag011 ,t3.pmaal003 ,t4.ooag011 , 
       t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011 ,t10.ooag011 ,t11.nmabl003 ,t12.nmabl003 , 
       t13.nmabl003 ,t14.oocql004",
               " FROM xrgd_t t0",
                              " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.xrgd005  ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.xrgd004 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.xrgdownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.xrgdowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.xrgdcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.xrgdcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.xrgdmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.xrgdcnfid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.xrgdpstid  ",
               " LEFT JOIN nmabl_t t11 ON t11.nmablent="||g_enterprise||" AND t11.nmabl001=t0.xrgd008 AND t11.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t12 ON t12.nmablent="||g_enterprise||" AND t12.nmabl001=t0.xrgd009 AND t12.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t13 ON t13.nmablent="||g_enterprise||" AND t13.nmabl001=t0.xrgd022 AND t13.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t14 ON t14.oocqlent="||g_enterprise||" AND t14.oocql001='263' AND t14.oocql002=t0.xrgd016 AND t14.oocql003='"||g_dlang||"' ",
 
               " WHERE t0.xrgdent = " ||g_enterprise|| " AND t0.xrgdcomp = ? AND t0.xrgddocno = ? AND t0.xrgd900 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrt520_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrt520 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrt520_init()   
 
      #進入選單 Menu (="N")
      CALL axrt520_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrt520
      
   END IF 
   
   CLOSE axrt520_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrt520.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrt520_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('xrgdstus','13','N,Y,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()    #8營運中心
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success            #不走分錄時使用
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #走分錄時使用
   CALL s_fin_continue_no_tmp()
   CALL s_aap_create_multi_bill_perod_tmp()
   CALL cl_set_combo_scc('apgc011','9719')
   CALL cl_set_combo_scc_part('xrgdstus','13','N,Y,A,D,R,W,X')
    
   CALL cl_set_combo_scc('xrgd006','8517') 
   CALL cl_set_combo_scc('xrgd007','8515') 
   CALL cl_set_combo_scc('xrgd013','8516')
   #end add-point
   
   #初始化搜尋條件
   CALL axrt520_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axrt520.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axrt520_ui_dialog()
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
            CALL axrt520_insert()
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
         INITIALIZE g_xrgd_m.* TO NULL
         CALL g_xrge_d.clear()
         CALL g_xrge2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrt520_init()
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
               
               CALL axrt520_fetch('') # reload data
               LET l_ac = 1
               CALL axrt520_ui_detailshow() #Setting the current row 
         
               CALL axrt520_idx_chk()
               #NEXT FIELD xrgeseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_xrge_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axrt520_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL s_hint_show('xrgh_t','xrge_t','xrgb_t',g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrge_d[l_ac].xrgeseq,'','')
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
               CALL axrt520_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               CALL DIALOG.setCellAttributes(g_xrge_d_color)
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xrge2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axrt520_idx_chk()
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
               CALL axrt520_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axrt520_browser_fill("")
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
               CALL axrt520_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axrt520_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axrt520_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axrt520_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axrt520_set_act_visible()   
            CALL axrt520_set_act_no_visible()
            IF NOT (g_xrgd_m.xrgdcomp IS NULL
              OR g_xrgd_m.xrgddocno IS NULL
              OR g_xrgd_m.xrgd900 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xrgdent = " ||g_enterprise|| " AND",
                                  " xrgdcomp = '", g_xrgd_m.xrgdcomp, "' "
                                  ," AND xrgddocno = '", g_xrgd_m.xrgddocno, "' "
                                  ," AND xrgd900 = '", g_xrgd_m.xrgd900, "' "
 
               #填到對應位置
               CALL axrt520_browser_fill("")
            END IF
         
          
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
                     WHEN la_wc[li_idx].tableid = "xrgd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrge_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apgc_t" 
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
               CALL axrt520_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "xrgd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrge_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apgc_t" 
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
                  CALL axrt520_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axrt520_fetch("F")
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
               CALL axrt520_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axrt520_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt520_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axrt520_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt520_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axrt520_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt520_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axrt520_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt520_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axrt520_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt520_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xrge_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xrge2_d)
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
               NEXT FIELD xrgeseq
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
               CALL axrt520_modify()
               #add-point:ON ACTION modify name="menu.modify"
               CALL axrt520_show()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axrt520_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               CALL axrt520_show()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axrt520_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axrt520_insert()
               #add-point:ON ACTION insert name="menu.insert"
               CALL axrt520_show()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrt520_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_axrt560
            LET g_action_choice="prog_axrt560"
            IF cl_auth_chk_act("prog_axrt560") THEN
               
               #add-point:ON ACTION prog_axrt560 name="menu.prog_axrt560"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'axrt560'
               LET la_param.param[2] = g_xrgd_m.xrgd024

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axrt520_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axrt520_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axrt520_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_xrgd_m.xrgddocdt)
 
 
 
         
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
 
{<section id="axrt520.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axrt520_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
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
      LET l_sub_sql = " SELECT DISTINCT xrgdcomp,xrgddocno,xrgd900 ",
                      " FROM xrgd_t ",
                      " ",
                      " LEFT JOIN xrge_t ON xrgeent = xrgdent AND xrgdcomp = xrgecomp AND xrgddocno = xrgedocno AND xrgd900 = xrge900 ", "  ",
                      #add-point:browser_fill段sql(xrge_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN apgc_t ON apgcent = xrgdent AND xrgdcomp = apgccomp AND xrgddocno = apgcdocno AND xrgd900 = apgc900", "  ",
                      #add-point:browser_fill段sql(apgc_t1) name="browser_fill.cnt.join.apgc_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE xrgdent = " ||g_enterprise|| " AND xrgeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xrgd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xrgdcomp,xrgddocno,xrgd900 ",
                      " FROM xrgd_t ", 
                      "  ",
                      "  ",
                      " WHERE xrgdent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xrgd_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
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
      INITIALIZE g_xrgd_m.* TO NULL
      CALL g_xrge_d.clear()        
      CALL g_xrge2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xrgdcomp,t0.xrgddocno,t0.xrgd900 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xrgdstus,t0.xrgdcomp,t0.xrgddocno,t0.xrgd900 ",
                  " FROM xrgd_t t0",
                  "  ",
                  "  LEFT JOIN xrge_t ON xrgeent = xrgdent AND xrgdcomp = xrgecomp AND xrgddocno = xrgedocno AND xrgd900 = xrge900 ", "  ", 
                  #add-point:browser_fill段sql(xrge_t1) name="browser_fill.join.xrge_t1"
                  
                  #end add-point
                  "  LEFT JOIN apgc_t ON apgcent = xrgdent AND xrgdcomp = apgccomp AND xrgddocno = apgcdocno AND xrgd900 = apgc900", "  ", 
                  #add-point:browser_fill段sql(apgc_t1) name="browser_fill.join.apgc_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.xrgdent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xrgd_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xrgdstus,t0.xrgdcomp,t0.xrgddocno,t0.xrgd900 ",
                  " FROM xrgd_t t0",
                  "  ",
                  
                  " WHERE t0.xrgdent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xrgd_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #161111-00049#10 Add  ---(S)---
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = xrgdent ",
                        "                AND pmaa001 = xrgd004 )"
   END IF
   #161111-00049#10 Add  ---(S)---
   #end add-point
   LET g_sql = g_sql, " ORDER BY xrgdcomp,xrgddocno,xrgd900 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xrgd_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xrgdcomp,g_browser[g_cnt].b_xrgddocno, 
          g_browser[g_cnt].b_xrgd900
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
         CALL axrt520_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_xrgdcomp) THEN
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
 
{<section id="axrt520.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axrt520_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xrgd_m.xrgdcomp = g_browser[g_current_idx].b_xrgdcomp   
   LET g_xrgd_m.xrgddocno = g_browser[g_current_idx].b_xrgddocno   
   LET g_xrgd_m.xrgd900 = g_browser[g_current_idx].b_xrgd900   
 
   EXECUTE axrt520_master_referesh USING g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900 INTO g_xrgd_m.xrgdcomp, 
       g_xrgd_m.xrgd005,g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt, 
       g_xrgd_m.xrgd003,g_xrgd_m.xrgd004,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus, 
       g_xrgd_m.xrgdownid,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdt, 
       g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid, 
       g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd009,g_xrgd_m.xrgd022,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
       g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100, 
       g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.xrgd101,g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016, 
       g_xrgd_m.xrgd017,g_xrgd_m.xrgd018,g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021,g_xrgd_m.xrgd005_desc, 
       g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp_desc,g_xrgd_m.xrgdcrtid_desc, 
       g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdmodid_desc,g_xrgd_m.xrgdcnfid_desc,g_xrgd_m.xrgdpstid_desc, 
       g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022_desc,g_xrgd_m.xrgd016_desc
   
   CALL axrt520_xrgd_t_mask()
   CALL axrt520_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axrt520.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axrt520_ui_detailshow()
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
 
{<section id="axrt520.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axrt520_ui_browser_refresh()
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
      IF g_browser[l_i].b_xrgdcomp = g_xrgd_m.xrgdcomp 
         AND g_browser[l_i].b_xrgddocno = g_xrgd_m.xrgddocno 
         AND g_browser[l_i].b_xrgd900 = g_xrgd_m.xrgd900 
 
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
 
{<section id="axrt520.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrt520_construct()
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
   DEFINE l_ooef019   LIKE ooef_t.ooef019
   DEFINE l_ooef017     LIKE ooef_t.ooef017   #161111-00049#10 Add
   DEFINE l_glaa004     LIKE glaa_t.glaa004   #161111-00049#10 Add
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   #161111-00049#10 Add  ---(S)---
   LET g_sql_ctrl2 = NULL
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   CALL s_control_get_item_sql('2',l_ooef017,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl2
   #161111-00049#10 Add  ---(E)---
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xrgd_m.* TO NULL
   CALL g_xrge_d.clear()        
   CALL g_xrge2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON xrgdcomp,xrgd005,xrgd006,xrgddocno,xrgd900,xrgd002,xrgddocdt,xrgd003, 
          xrgd004,xrgd001,xrgd024,xrgd025,xrgdstus,xrgdownid,xrgdowndp,xrgdcrtid,xrgdcrtdp,xrgdcrtdt, 
          xrgdmodid,xrgdmoddt,xrgdcnfid,xrgdcnfdt,xrgdpstid,xrgdpstdt,xrgd008,xrgd009,xrgd022,xrgd007, 
          xrgd010,xrgd013,xrgd012,xrgd011,xrgd014,xrgd023,xrgd100,xrgd103,xrgd104,l_xrga104diff,xrgd101, 
          xrgd113,xrgd015,xrgd016,xrgd017,xrgd018,xrgd019,xrgd020,xrgd021
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xrgdcrtdt>>----
         AFTER FIELD xrgdcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xrgdmoddt>>----
         AFTER FIELD xrgdmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrgdcnfdt>>----
         AFTER FIELD xrgdcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrgdpstdt>>----
         AFTER FIELD xrgdpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdcomp
            #add-point:BEFORE FIELD xrgdcomp name="construct.b.xrgdcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgdcomp
            
            #add-point:AFTER FIELD xrgdcomp name="construct.a.xrgdcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgdcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgdcomp
            #add-point:ON ACTION controlp INFIELD xrgdcomp name="construct.c.xrgdcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_wc_cs_comp)THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO xrgdcomp
            NEXT FIELD xrgdcomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd005
            #add-point:BEFORE FIELD xrgd005 name="construct.b.xrgd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd005
            
            #add-point:AFTER FIELD xrgd005 name="construct.a.xrgd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd005
            #add-point:ON ACTION controlp INFIELD xrgd005 name="construct.c.xrgd005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgd005  #顯示到畫面上
            NEXT FIELD xrgd005     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd006
            #add-point:BEFORE FIELD xrgd006 name="construct.b.xrgd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd006
            
            #add-point:AFTER FIELD xrgd006 name="construct.a.xrgd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd006
            #add-point:ON ACTION controlp INFIELD xrgd006 name="construct.c.xrgd006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgddocno
            #add-point:BEFORE FIELD xrgddocno name="construct.b.xrgddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgddocno
            
            #add-point:AFTER FIELD xrgddocno name="construct.a.xrgddocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgddocno
            #add-point:ON ACTION controlp INFIELD xrgddocno name="construct.c.xrgddocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xrgdcomp IN ",g_wc_cs_comp
            #161111-00049#10 Add--s--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = xrgdent ",
                                                       "                AND pmaa001 = xrgd004 )"
            END IF
            #161111-00049#10 Add--e--
            #161104-00046#9 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#9 --e add             
            CALL q_xrgddocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgddocno  #顯示到畫面上
            NEXT FIELD xrgddocno  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd900
            #add-point:BEFORE FIELD xrgd900 name="construct.b.xrgd900"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd900
            
            #add-point:AFTER FIELD xrgd900 name="construct.a.xrgd900"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd900
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd900
            #add-point:ON ACTION controlp INFIELD xrgd900 name="construct.c.xrgd900"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd002
            #add-point:BEFORE FIELD xrgd002 name="construct.b.xrgd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd002
            
            #add-point:AFTER FIELD xrgd002 name="construct.a.xrgd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd002
            #add-point:ON ACTION controlp INFIELD xrgd002 name="construct.c.xrgd002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgddocdt
            #add-point:BEFORE FIELD xrgddocdt name="construct.b.xrgddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgddocdt
            
            #add-point:AFTER FIELD xrgddocdt name="construct.a.xrgddocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgddocdt
            #add-point:ON ACTION controlp INFIELD xrgddocdt name="construct.c.xrgddocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd003
            #add-point:BEFORE FIELD xrgd003 name="construct.b.xrgd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd003
            
            #add-point:AFTER FIELD xrgd003 name="construct.a.xrgd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd003
            #add-point:ON ACTION controlp INFIELD xrgd003 name="construct.c.xrgd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd004
            #add-point:BEFORE FIELD xrgd004 name="construct.b.xrgd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd004
            
            #add-point:AFTER FIELD xrgd004 name="construct.a.xrgd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd004
            #add-point:ON ACTION controlp INFIELD xrgd004 name="construct.c.xrgd004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO xrgd004      #顯示到畫面上
            NEXT FIELD xrgd004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd001
            #add-point:BEFORE FIELD xrgd001 name="construct.b.xrgd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd001
            
            #add-point:AFTER FIELD xrgd001 name="construct.a.xrgd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd001
            #add-point:ON ACTION controlp INFIELD xrgd001 name="construct.c.xrgd001"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrga001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgd001  #顯示到畫面上
            NEXT FIELD xrgd001 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd024
            #add-point:BEFORE FIELD xrgd024 name="construct.b.xrgd024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd024
            
            #add-point:AFTER FIELD xrgd024 name="construct.a.xrgd024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd024
            #add-point:ON ACTION controlp INFIELD xrgd024 name="construct.c.xrgd024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd025
            #add-point:BEFORE FIELD xrgd025 name="construct.b.xrgd025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd025
            
            #add-point:AFTER FIELD xrgd025 name="construct.a.xrgd025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd025
            #add-point:ON ACTION controlp INFIELD xrgd025 name="construct.c.xrgd025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdstus
            #add-point:BEFORE FIELD xrgdstus name="construct.b.xrgdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgdstus
            
            #add-point:AFTER FIELD xrgdstus name="construct.a.xrgdstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgdstus
            #add-point:ON ACTION controlp INFIELD xrgdstus name="construct.c.xrgdstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrgdownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgdownid
            #add-point:ON ACTION controlp INFIELD xrgdownid name="construct.c.xrgdownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgdownid  #顯示到畫面上
            NEXT FIELD xrgdownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdownid
            #add-point:BEFORE FIELD xrgdownid name="construct.b.xrgdownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgdownid
            
            #add-point:AFTER FIELD xrgdownid name="construct.a.xrgdownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgdowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgdowndp
            #add-point:ON ACTION controlp INFIELD xrgdowndp name="construct.c.xrgdowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgdowndp  #顯示到畫面上
            NEXT FIELD xrgdowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdowndp
            #add-point:BEFORE FIELD xrgdowndp name="construct.b.xrgdowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgdowndp
            
            #add-point:AFTER FIELD xrgdowndp name="construct.a.xrgdowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgdcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgdcrtid
            #add-point:ON ACTION controlp INFIELD xrgdcrtid name="construct.c.xrgdcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgdcrtid  #顯示到畫面上
            NEXT FIELD xrgdcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdcrtid
            #add-point:BEFORE FIELD xrgdcrtid name="construct.b.xrgdcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgdcrtid
            
            #add-point:AFTER FIELD xrgdcrtid name="construct.a.xrgdcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgdcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgdcrtdp
            #add-point:ON ACTION controlp INFIELD xrgdcrtdp name="construct.c.xrgdcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgdcrtdp  #顯示到畫面上
            NEXT FIELD xrgdcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdcrtdp
            #add-point:BEFORE FIELD xrgdcrtdp name="construct.b.xrgdcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgdcrtdp
            
            #add-point:AFTER FIELD xrgdcrtdp name="construct.a.xrgdcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdcrtdt
            #add-point:BEFORE FIELD xrgdcrtdt name="construct.b.xrgdcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrgdmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgdmodid
            #add-point:ON ACTION controlp INFIELD xrgdmodid name="construct.c.xrgdmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgdmodid  #顯示到畫面上
            NEXT FIELD xrgdmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdmodid
            #add-point:BEFORE FIELD xrgdmodid name="construct.b.xrgdmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgdmodid
            
            #add-point:AFTER FIELD xrgdmodid name="construct.a.xrgdmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdmoddt
            #add-point:BEFORE FIELD xrgdmoddt name="construct.b.xrgdmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrgdcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgdcnfid
            #add-point:ON ACTION controlp INFIELD xrgdcnfid name="construct.c.xrgdcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgdcnfid  #顯示到畫面上
            NEXT FIELD xrgdcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdcnfid
            #add-point:BEFORE FIELD xrgdcnfid name="construct.b.xrgdcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgdcnfid
            
            #add-point:AFTER FIELD xrgdcnfid name="construct.a.xrgdcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdcnfdt
            #add-point:BEFORE FIELD xrgdcnfdt name="construct.b.xrgdcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrgdpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgdpstid
            #add-point:ON ACTION controlp INFIELD xrgdpstid name="construct.c.xrgdpstid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgdpstid  #顯示到畫面上
            NEXT FIELD xrgdpstid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdpstid
            #add-point:BEFORE FIELD xrgdpstid name="construct.b.xrgdpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgdpstid
            
            #add-point:AFTER FIELD xrgdpstid name="construct.a.xrgdpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdpstdt
            #add-point:BEFORE FIELD xrgdpstdt name="construct.b.xrgdpstdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd008
            #add-point:BEFORE FIELD xrgd008 name="construct.b.xrgd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd008
            
            #add-point:AFTER FIELD xrgd008 name="construct.a.xrgd008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd008
            #add-point:ON ACTION controlp INFIELD xrgd008 name="construct.c.xrgd008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgd008  #顯示到畫面上
            NEXT FIELD xrgd008
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd009
            #add-point:BEFORE FIELD xrgd009 name="construct.b.xrgd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd009
            
            #add-point:AFTER FIELD xrgd009 name="construct.a.xrgd009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd009
            #add-point:ON ACTION controlp INFIELD xrgd009 name="construct.c.xrgd009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgd009  #顯示到畫面上
            NEXT FIELD xrgd009    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd022
            #add-point:BEFORE FIELD xrgd022 name="construct.b.xrgd022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd022
            
            #add-point:AFTER FIELD xrgd022 name="construct.a.xrgd022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd022
            #add-point:ON ACTION controlp INFIELD xrgd022 name="construct.c.xrgd022"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgd022  #顯示到畫面上
            NEXT FIELD xrgd022  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd007
            #add-point:BEFORE FIELD xrgd007 name="construct.b.xrgd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd007
            
            #add-point:AFTER FIELD xrgd007 name="construct.a.xrgd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd007
            #add-point:ON ACTION controlp INFIELD xrgd007 name="construct.c.xrgd007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd010
            #add-point:BEFORE FIELD xrgd010 name="construct.b.xrgd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd010
            
            #add-point:AFTER FIELD xrgd010 name="construct.a.xrgd010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd010
            #add-point:ON ACTION controlp INFIELD xrgd010 name="construct.c.xrgd010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd013
            #add-point:BEFORE FIELD xrgd013 name="construct.b.xrgd013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd013
            
            #add-point:AFTER FIELD xrgd013 name="construct.a.xrgd013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd013
            #add-point:ON ACTION controlp INFIELD xrgd013 name="construct.c.xrgd013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd012
            #add-point:BEFORE FIELD xrgd012 name="construct.b.xrgd012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd012
            
            #add-point:AFTER FIELD xrgd012 name="construct.a.xrgd012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd012
            #add-point:ON ACTION controlp INFIELD xrgd012 name="construct.c.xrgd012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd011
            #add-point:BEFORE FIELD xrgd011 name="construct.b.xrgd011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd011
            
            #add-point:AFTER FIELD xrgd011 name="construct.a.xrgd011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd011
            #add-point:ON ACTION controlp INFIELD xrgd011 name="construct.c.xrgd011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd014
            #add-point:BEFORE FIELD xrgd014 name="construct.b.xrgd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd014
            
            #add-point:AFTER FIELD xrgd014 name="construct.a.xrgd014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd014
            #add-point:ON ACTION controlp INFIELD xrgd014 name="construct.c.xrgd014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd023
            #add-point:BEFORE FIELD xrgd023 name="construct.b.xrgd023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd023
            
            #add-point:AFTER FIELD xrgd023 name="construct.a.xrgd023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd023
            #add-point:ON ACTION controlp INFIELD xrgd023 name="construct.c.xrgd023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd100
            #add-point:BEFORE FIELD xrgd100 name="construct.b.xrgd100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd100
            
            #add-point:AFTER FIELD xrgd100 name="construct.a.xrgd100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd100
            #add-point:ON ACTION controlp INFIELD xrgd100 name="construct.c.xrgd100"
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                     
            DISPLAY g_qryparam.return1 TO xrgd100  #顯示到畫面上
            NEXT FIELD xrgd100 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd103
            #add-point:BEFORE FIELD xrgd103 name="construct.b.xrgd103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd103
            
            #add-point:AFTER FIELD xrgd103 name="construct.a.xrgd103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd103
            #add-point:ON ACTION controlp INFIELD xrgd103 name="construct.c.xrgd103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd104
            #add-point:BEFORE FIELD xrgd104 name="construct.b.xrgd104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd104
            
            #add-point:AFTER FIELD xrgd104 name="construct.a.xrgd104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd104
            #add-point:ON ACTION controlp INFIELD xrgd104 name="construct.c.xrgd104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrga104diff
            #add-point:BEFORE FIELD l_xrga104diff name="construct.b.l_xrga104diff"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrga104diff
            
            #add-point:AFTER FIELD l_xrga104diff name="construct.a.l_xrga104diff"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_xrga104diff
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrga104diff
            #add-point:ON ACTION controlp INFIELD l_xrga104diff name="construct.c.l_xrga104diff"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd101
            #add-point:BEFORE FIELD xrgd101 name="construct.b.xrgd101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd101
            
            #add-point:AFTER FIELD xrgd101 name="construct.a.xrgd101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd101
            #add-point:ON ACTION controlp INFIELD xrgd101 name="construct.c.xrgd101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd113
            #add-point:BEFORE FIELD xrgd113 name="construct.b.xrgd113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd113
            
            #add-point:AFTER FIELD xrgd113 name="construct.a.xrgd113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd113
            #add-point:ON ACTION controlp INFIELD xrgd113 name="construct.c.xrgd113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd015
            #add-point:BEFORE FIELD xrgd015 name="construct.b.xrgd015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd015
            
            #add-point:AFTER FIELD xrgd015 name="construct.a.xrgd015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd015
            #add-point:ON ACTION controlp INFIELD xrgd015 name="construct.c.xrgd015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd016
            #add-point:BEFORE FIELD xrgd016 name="construct.b.xrgd016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd016
            
            #add-point:AFTER FIELD xrgd016 name="construct.a.xrgd016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd016
            #add-point:ON ACTION controlp INFIELD xrgd016 name="construct.c.xrgd016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1  = '263'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgd016  #顯示到畫面上
            NEXT FIELD xrgd016   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd017
            #add-point:BEFORE FIELD xrgd017 name="construct.b.xrgd017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd017
            
            #add-point:AFTER FIELD xrgd017 name="construct.a.xrgd017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd017
            #add-point:ON ACTION controlp INFIELD xrgd017 name="construct.c.xrgd017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd018
            #add-point:BEFORE FIELD xrgd018 name="construct.b.xrgd018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd018
            
            #add-point:AFTER FIELD xrgd018 name="construct.a.xrgd018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd018
            #add-point:ON ACTION controlp INFIELD xrgd018 name="construct.c.xrgd018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd019
            #add-point:BEFORE FIELD xrgd019 name="construct.b.xrgd019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd019
            
            #add-point:AFTER FIELD xrgd019 name="construct.a.xrgd019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd019
            #add-point:ON ACTION controlp INFIELD xrgd019 name="construct.c.xrgd019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd020
            #add-point:BEFORE FIELD xrgd020 name="construct.b.xrgd020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd020
            
            #add-point:AFTER FIELD xrgd020 name="construct.a.xrgd020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd020
            #add-point:ON ACTION controlp INFIELD xrgd020 name="construct.c.xrgd020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd021
            #add-point:BEFORE FIELD xrgd021 name="construct.b.xrgd021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd021
            
            #add-point:AFTER FIELD xrgd021 name="construct.a.xrgd021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrgd021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd021
            #add-point:ON ACTION controlp INFIELD xrgd021 name="construct.c.xrgd021"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xrgeseq,xrgeorga,xrge001,xrge002,xrge003,xrge004,xrge005,xrge008,xrge006, 
          xrge007,xrge100,xrge101,xrge009,xrge105,xrge115,xrge901,xrge902,xrge903
           FROM s_detail1[1].xrgeseq,s_detail1[1].xrgeorga,s_detail1[1].xrge001,s_detail1[1].xrge002, 
               s_detail1[1].xrge003,s_detail1[1].xrge004,s_detail1[1].xrge005,s_detail1[1].xrge008,s_detail1[1].xrge006, 
               s_detail1[1].xrge007,s_detail1[1].xrge100,s_detail1[1].xrge101,s_detail1[1].xrge009,s_detail1[1].xrge105, 
               s_detail1[1].xrge115,s_detail1[1].xrge901,s_detail1[1].xrge902,s_detail1[1].xrge903
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgeseq
            #add-point:BEFORE FIELD xrgeseq name="construct.b.page1.xrgeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgeseq
            
            #add-point:AFTER FIELD xrgeseq name="construct.a.page1.xrgeseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrgeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgeseq
            #add-point:ON ACTION controlp INFIELD xrgeseq name="construct.c.page1.xrgeseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgeorga
            #add-point:BEFORE FIELD xrgeorga name="construct.b.page1.xrgeorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgeorga
            
            #add-point:AFTER FIELD xrgeorga name="construct.a.page1.xrgeorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrgeorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgeorga
            #add-point:ON ACTION controlp INFIELD xrgeorga name="construct.c.page1.xrgeorga"
          INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrgeorga  #顯示到畫面上
            NEXT FIELD xrgeorga
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge001
            #add-point:BEFORE FIELD xrge001 name="construct.b.page1.xrge001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge001
            
            #add-point:AFTER FIELD xrge001 name="construct.a.page1.xrge001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge001
            #add-point:ON ACTION controlp INFIELD xrge001 name="construct.c.page1.xrge001"
      		INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL  q_xmdadocno_2()                 
            DISPLAY g_qryparam.return1 TO xrge001
            NEXT FIELD xrge001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge002
            #add-point:BEFORE FIELD xrge002 name="construct.b.page1.xrge002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge002
            
            #add-point:AFTER FIELD xrge002 name="construct.a.page1.xrge002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge002
            #add-point:ON ACTION controlp INFIELD xrge002 name="construct.c.page1.xrge002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge003
            #add-point:BEFORE FIELD xrge003 name="construct.b.page1.xrge003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge003
            
            #add-point:AFTER FIELD xrge003 name="construct.a.page1.xrge003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge003
            #add-point:ON ACTION controlp INFIELD xrge003 name="construct.c.page1.xrge003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#10 Add  ---(S)---
            IF NOT cl_null(g_sql_ctrl2) AND NOT g_sql_ctrl2 = ' 1=1'  THEN
               LET g_qryparam.where =  g_sql_ctrl2," AND imafsite = '",l_ooef017,"'"
            END IF                      
		  	   #161111-00049#10 Add  ---(E)---
            CALL q_imaf001()
            DISPLAY g_qryparam.return1 TO xrge003
            NEXT FIELD xrge003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge004
            #add-point:BEFORE FIELD xrge004 name="construct.b.page1.xrge004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge004
            
            #add-point:AFTER FIELD xrge004 name="construct.a.page1.xrge004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge004
            #add-point:ON ACTION controlp INFIELD xrge004 name="construct.c.page1.xrge004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge005
            #add-point:BEFORE FIELD xrge005 name="construct.b.page1.xrge005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge005
            
            #add-point:AFTER FIELD xrge005 name="construct.a.page1.xrge005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge005
            #add-point:ON ACTION controlp INFIELD xrge005 name="construct.c.page1.xrge005"
            #單位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()
            DISPLAY g_qryparam.return1 TO xrge005
            NEXT FIELD xrge005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge008
            #add-point:BEFORE FIELD xrge008 name="construct.b.page1.xrge008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge008
            
            #add-point:AFTER FIELD xrge008 name="construct.a.page1.xrge008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge008
            #add-point:ON ACTION controlp INFIELD xrge008 name="construct.c.page1.xrge008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge006
            #add-point:BEFORE FIELD xrge006 name="construct.b.page1.xrge006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge006
            
            #add-point:AFTER FIELD xrge006 name="construct.a.page1.xrge006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge006
            #add-point:ON ACTION controlp INFIELD xrge006 name="construct.c.page1.xrge006"
            #稅別
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = l_ooef019
            CALL q_oodb002_5()
            DISPLAY g_qryparam.return1 TO xrge006
            NEXT FIELD xrge006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge007
            #add-point:BEFORE FIELD xrge007 name="construct.b.page1.xrge007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge007
            
            #add-point:AFTER FIELD xrge007 name="construct.a.page1.xrge007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge007
            #add-point:ON ACTION controlp INFIELD xrge007 name="construct.c.page1.xrge007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge100
            #add-point:BEFORE FIELD xrge100 name="construct.b.page1.xrge100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge100
            
            #add-point:AFTER FIELD xrge100 name="construct.a.page1.xrge100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge100
            #add-point:ON ACTION controlp INFIELD xrge100 name="construct.c.page1.xrge100"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()
            DISPLAY g_qryparam.return1 TO xrge100
            NEXT FIELD xrge100
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge101
            #add-point:BEFORE FIELD xrge101 name="construct.b.page1.xrge101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge101
            
            #add-point:AFTER FIELD xrge101 name="construct.a.page1.xrge101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge101
            #add-point:ON ACTION controlp INFIELD xrge101 name="construct.c.page1.xrge101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge009
            #add-point:BEFORE FIELD xrge009 name="construct.b.page1.xrge009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge009
            
            #add-point:AFTER FIELD xrge009 name="construct.a.page1.xrge009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge009
            #add-point:ON ACTION controlp INFIELD xrge009 name="construct.c.page1.xrge009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge105
            #add-point:BEFORE FIELD xrge105 name="construct.b.page1.xrge105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge105
            
            #add-point:AFTER FIELD xrge105 name="construct.a.page1.xrge105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge105
            #add-point:ON ACTION controlp INFIELD xrge105 name="construct.c.page1.xrge105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge115
            #add-point:BEFORE FIELD xrge115 name="construct.b.page1.xrge115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge115
            
            #add-point:AFTER FIELD xrge115 name="construct.a.page1.xrge115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge115
            #add-point:ON ACTION controlp INFIELD xrge115 name="construct.c.page1.xrge115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge901
            #add-point:BEFORE FIELD xrge901 name="construct.b.page1.xrge901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge901
            
            #add-point:AFTER FIELD xrge901 name="construct.a.page1.xrge901"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge901
            #add-point:ON ACTION controlp INFIELD xrge901 name="construct.c.page1.xrge901"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge902
            #add-point:BEFORE FIELD xrge902 name="construct.b.page1.xrge902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge902
            
            #add-point:AFTER FIELD xrge902 name="construct.a.page1.xrge902"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge902
            #add-point:ON ACTION controlp INFIELD xrge902 name="construct.c.page1.xrge902"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge903
            #add-point:BEFORE FIELD xrge903 name="construct.b.page1.xrge903"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge903
            
            #add-point:AFTER FIELD xrge903 name="construct.a.page1.xrge903"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrge903
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge903
            #add-point:ON ACTION controlp INFIELD xrge903 name="construct.c.page1.xrge903"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON apgcseq,apgcorga,apgc001,apgc002,apgc003,apgc005,apgc014,apgc100,apgc101, 
          apgc006,apgc007,apgc008,apgc009,apgc010,apgc011,apgc103,apgc104,apgc105,apgc113,apgc114,apgc115, 
          apgc004,apgc015,apgc016,apgc012,apgc013
           FROM s_detail2[1].apgcseq,s_detail2[1].apgcorga,s_detail2[1].apgc001,s_detail2[1].apgc002, 
               s_detail2[1].apgc003,s_detail2[1].apgc005,s_detail2[1].apgc014,s_detail2[1].apgc100,s_detail2[1].apgc101, 
               s_detail2[1].apgc006,s_detail2[1].apgc007,s_detail2[1].apgc008,s_detail2[1].apgc009,s_detail2[1].apgc010, 
               s_detail2[1].apgc011,s_detail2[1].apgc103,s_detail2[1].apgc104,s_detail2[1].apgc105,s_detail2[1].apgc113, 
               s_detail2[1].apgc114,s_detail2[1].apgc115,s_detail2[1].apgc004,s_detail2[1].apgc015,s_detail2[1].apgc016, 
               s_detail2[1].apgc012,s_detail2[1].apgc013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgcseq
            #add-point:BEFORE FIELD apgcseq name="construct.b.page2.apgcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgcseq
            
            #add-point:AFTER FIELD apgcseq name="construct.a.page2.apgcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgcseq
            #add-point:ON ACTION controlp INFIELD apgcseq name="construct.c.page2.apgcseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.apgcorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgcorga
            #add-point:ON ACTION controlp INFIELD apgcorga name="construct.c.page2.apgcorga"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgcorga  #顯示到畫面上
            NEXT FIELD apgcorga                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgcorga
            #add-point:BEFORE FIELD apgcorga name="construct.b.page2.apgcorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgcorga
            
            #add-point:AFTER FIELD apgcorga name="construct.a.page2.apgcorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc001
            #add-point:ON ACTION controlp INFIELD apgc001 name="construct.c.page2.apgc001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3117'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apgc001
            NEXT FIELD apgc001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc001
            #add-point:BEFORE FIELD apgc001 name="construct.b.page2.apgc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc001
            
            #add-point:AFTER FIELD apgc001 name="construct.a.page2.apgc001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc002
            #add-point:BEFORE FIELD apgc002 name="construct.b.page2.apgc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc002
            
            #add-point:AFTER FIELD apgc002 name="construct.a.page2.apgc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc002
            #add-point:ON ACTION controlp INFIELD apgc002 name="construct.c.page2.apgc002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc003
            #add-point:BEFORE FIELD apgc003 name="construct.b.page2.apgc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc003
            
            #add-point:AFTER FIELD apgc003 name="construct.a.page2.apgc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc003
            #add-point:ON ACTION controlp INFIELD apgc003 name="construct.c.page2.apgc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc005
            #add-point:BEFORE FIELD apgc005 name="construct.b.page2.apgc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc005
            
            #add-point:AFTER FIELD apgc005 name="construct.a.page2.apgc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc005
            #add-point:ON ACTION controlp INFIELD apgc005 name="construct.c.page2.apgc005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.apgc014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc014
            #add-point:ON ACTION controlp INFIELD apgc014 name="construct.c.page2.apgc014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgc014  #顯示到畫面上
            NEXT FIELD apgc014                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc014
            #add-point:BEFORE FIELD apgc014 name="construct.b.page2.apgc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc014
            
            #add-point:AFTER FIELD apgc014 name="construct.a.page2.apgc014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc100
            #add-point:ON ACTION controlp INFIELD apgc100 name="construct.c.page2.apgc100"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgc100  #顯示到畫面上
            NEXT FIELD apgc100                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc100
            #add-point:BEFORE FIELD apgc100 name="construct.b.page2.apgc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc100
            
            #add-point:AFTER FIELD apgc100 name="construct.a.page2.apgc100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc101
            #add-point:BEFORE FIELD apgc101 name="construct.b.page2.apgc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc101
            
            #add-point:AFTER FIELD apgc101 name="construct.a.page2.apgc101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc101
            #add-point:ON ACTION controlp INFIELD apgc101 name="construct.c.page2.apgc101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc006
            #add-point:BEFORE FIELD apgc006 name="construct.b.page2.apgc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc006
            
            #add-point:AFTER FIELD apgc006 name="construct.a.page2.apgc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc006
            #add-point:ON ACTION controlp INFIELD apgc006 name="construct.c.page2.apgc006"
            #稅別
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = l_ooef019
            CALL q_oodb002_5()
            DISPLAY g_qryparam.return1 TO apgc006
            NEXT FIELD apgc006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc007
            #add-point:BEFORE FIELD apgc007 name="construct.b.page2.apgc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc007
            
            #add-point:AFTER FIELD apgc007 name="construct.a.page2.apgc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc007
            #add-point:ON ACTION controlp INFIELD apgc007 name="construct.c.page2.apgc007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_isac002()
            DISPLAY g_qryparam.return1 TO apgc007
            NEXT FIELD apgc007
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc008
            #add-point:BEFORE FIELD apgc008 name="construct.b.page2.apgc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc008
            
            #add-point:AFTER FIELD apgc008 name="construct.a.page2.apgc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc008
            #add-point:ON ACTION controlp INFIELD apgc008 name="construct.c.page2.apgc008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc009
            #add-point:BEFORE FIELD apgc009 name="construct.b.page2.apgc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc009
            
            #add-point:AFTER FIELD apgc009 name="construct.a.page2.apgc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc009
            #add-point:ON ACTION controlp INFIELD apgc009 name="construct.c.page2.apgc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc010
            #add-point:BEFORE FIELD apgc010 name="construct.b.page2.apgc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc010
            
            #add-point:AFTER FIELD apgc010 name="construct.a.page2.apgc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc010
            #add-point:ON ACTION controlp INFIELD apgc010 name="construct.c.page2.apgc010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc011
            #add-point:BEFORE FIELD apgc011 name="construct.b.page2.apgc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc011
            
            #add-point:AFTER FIELD apgc011 name="construct.a.page2.apgc011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc011
            #add-point:ON ACTION controlp INFIELD apgc011 name="construct.c.page2.apgc011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO apgc004   #顯示到畫面上
            NEXT FIELD apgc004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc103
            #add-point:BEFORE FIELD apgc103 name="construct.b.page2.apgc103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc103
            
            #add-point:AFTER FIELD apgc103 name="construct.a.page2.apgc103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc103
            #add-point:ON ACTION controlp INFIELD apgc103 name="construct.c.page2.apgc103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc104
            #add-point:BEFORE FIELD apgc104 name="construct.b.page2.apgc104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc104
            
            #add-point:AFTER FIELD apgc104 name="construct.a.page2.apgc104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc104
            #add-point:ON ACTION controlp INFIELD apgc104 name="construct.c.page2.apgc104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc105
            #add-point:BEFORE FIELD apgc105 name="construct.b.page2.apgc105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc105
            
            #add-point:AFTER FIELD apgc105 name="construct.a.page2.apgc105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc105
            #add-point:ON ACTION controlp INFIELD apgc105 name="construct.c.page2.apgc105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc113
            #add-point:BEFORE FIELD apgc113 name="construct.b.page2.apgc113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc113
            
            #add-point:AFTER FIELD apgc113 name="construct.a.page2.apgc113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc113
            #add-point:ON ACTION controlp INFIELD apgc113 name="construct.c.page2.apgc113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc114
            #add-point:BEFORE FIELD apgc114 name="construct.b.page2.apgc114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc114
            
            #add-point:AFTER FIELD apgc114 name="construct.a.page2.apgc114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc114
            #add-point:ON ACTION controlp INFIELD apgc114 name="construct.c.page2.apgc114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc115
            #add-point:BEFORE FIELD apgc115 name="construct.b.page2.apgc115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc115
            
            #add-point:AFTER FIELD apgc115 name="construct.a.page2.apgc115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc115
            #add-point:ON ACTION controlp INFIELD apgc115 name="construct.c.page2.apgc115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc004
            #add-point:BEFORE FIELD apgc004 name="construct.b.page2.apgc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc004
            
            #add-point:AFTER FIELD apgc004 name="construct.a.page2.apgc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc004
            #add-point:ON ACTION controlp INFIELD apgc004 name="construct.c.page2.apgc004"
                      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
                           LET g_qryparam.reqry = FALSE
                           LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            #161111-00049#10 --ADD--S--
			   SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
			   LET g_qryparam.where = g_qryparam.where," AND glac001 = '",l_glaa004,"'"
			   #161111-00049#10 --ADD--E--               
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO apgc004   #顯示到畫面上
            NEXT FIELD apgc004
            #END add-point
 
 
         #Ctrlp:construct.c.page2.apgc015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc015
            #add-point:ON ACTION controlp INFIELD apgc015 name="construct.c.page2.apgc015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgc015  #顯示到畫面上
            NEXT FIELD apgc015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc015
            #add-point:BEFORE FIELD apgc015 name="construct.b.page2.apgc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc015
            
            #add-point:AFTER FIELD apgc015 name="construct.a.page2.apgc015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc016
            #add-point:ON ACTION controlp INFIELD apgc016 name="construct.c.page2.apgc016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgc016  #顯示到畫面上
            NEXT FIELD apgc016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc016
            #add-point:BEFORE FIELD apgc016 name="construct.b.page2.apgc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc016
            
            #add-point:AFTER FIELD apgc016 name="construct.a.page2.apgc016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc012
            #add-point:BEFORE FIELD apgc012 name="construct.b.page2.apgc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc012
            
            #add-point:AFTER FIELD apgc012 name="construct.a.page2.apgc012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc012
            #add-point:ON ACTION controlp INFIELD apgc012 name="construct.c.page2.apgc012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc013
            #add-point:BEFORE FIELD apgc013 name="construct.b.page2.apgc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc013
            
            #add-point:AFTER FIELD apgc013 name="construct.a.page2.apgc013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc013
            #add-point:ON ACTION controlp INFIELD apgc013 name="construct.c.page2.apgc013"
            
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
                  WHEN la_wc[li_idx].tableid = "xrgd_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xrge_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apgc_t" 
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
   #161104-00046#9 --s add
   IF cl_null(g_user_dept_wc_q)THEN
      LET g_user_dept_wc_q = ' 1=1'
   END IF
   IF g_user_dept_wc_q <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc_q CLIPPED
   END IF   
   #161104-00046#9 --e add
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrt520.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axrt520_filter()
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
      CONSTRUCT g_wc_filter ON xrgdcomp,xrgddocno,xrgd900
                          FROM s_browse[1].b_xrgdcomp,s_browse[1].b_xrgddocno,s_browse[1].b_xrgd900
 
         BEFORE CONSTRUCT
               DISPLAY axrt520_filter_parser('xrgdcomp') TO s_browse[1].b_xrgdcomp
            DISPLAY axrt520_filter_parser('xrgddocno') TO s_browse[1].b_xrgddocno
            DISPLAY axrt520_filter_parser('xrgd900') TO s_browse[1].b_xrgd900
      
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
 
      CALL axrt520_filter_show('xrgdcomp')
   CALL axrt520_filter_show('xrgddocno')
   CALL axrt520_filter_show('xrgd900')
 
END FUNCTION
 
{</section>}
 
{<section id="axrt520.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axrt520_filter_parser(ps_field)
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
 
{<section id="axrt520.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axrt520_filter_show(ps_field)
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
   LET ls_condition = axrt520_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrt520.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axrt520_query()
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
   CALL g_xrge_d.clear()
   CALL g_xrge2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axrt520_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axrt520_browser_fill("")
      CALL axrt520_fetch("")
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
      CALL axrt520_filter_show('xrgdcomp')
   CALL axrt520_filter_show('xrgddocno')
   CALL axrt520_filter_show('xrgd900')
   CALL axrt520_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axrt520_fetch("F") 
      #顯示單身筆數
      CALL axrt520_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrt520.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axrt520_fetch(p_flag)
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
   
   LET g_xrgd_m.xrgdcomp = g_browser[g_current_idx].b_xrgdcomp
   LET g_xrgd_m.xrgddocno = g_browser[g_current_idx].b_xrgddocno
   LET g_xrgd_m.xrgd900 = g_browser[g_current_idx].b_xrgd900
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axrt520_master_referesh USING g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900 INTO g_xrgd_m.xrgdcomp, 
       g_xrgd_m.xrgd005,g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt, 
       g_xrgd_m.xrgd003,g_xrgd_m.xrgd004,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus, 
       g_xrgd_m.xrgdownid,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdt, 
       g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid, 
       g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd009,g_xrgd_m.xrgd022,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
       g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100, 
       g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.xrgd101,g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016, 
       g_xrgd_m.xrgd017,g_xrgd_m.xrgd018,g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021,g_xrgd_m.xrgd005_desc, 
       g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp_desc,g_xrgd_m.xrgdcrtid_desc, 
       g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdmodid_desc,g_xrgd_m.xrgdcnfid_desc,g_xrgd_m.xrgdpstid_desc, 
       g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022_desc,g_xrgd_m.xrgd016_desc
   
   #遮罩相關處理
   LET g_xrgd_m_mask_o.* =  g_xrgd_m.*
   CALL axrt520_xrgd_t_mask()
   LET g_xrgd_m_mask_n.* =  g_xrgd_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axrt520_set_act_visible()   
   CALL axrt520_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   LET g_xrgd_m.l_xrga104diff = g_xrgd_m.xrgd103 - g_xrgd_m.xrgd104
   SELECT glaa001 INTO g_xrgd_m.l_glaa001 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_xrgd_m.xrgdcomp
      AND glaa014 = 'Y'
   #end add-point
   
   #保存單頭舊值
   LET g_xrgd_m_t.* = g_xrgd_m.*
   LET g_xrgd_m_o.* = g_xrgd_m.*
   
   LET g_data_owner = g_xrgd_m.xrgdownid      
   LET g_data_dept  = g_xrgd_m.xrgdowndp
   
   #重新顯示   
   CALL axrt520_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axrt520.insert" >}
#+ 資料新增
PRIVATE FUNCTION axrt520_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xrge_d.clear()   
   CALL g_xrge2_d.clear()  
 
 
   INITIALIZE g_xrgd_m.* TO NULL             #DEFAULT 設定
   
   LET g_xrgdcomp_t = NULL
   LET g_xrgddocno_t = NULL
   LET g_xrgd900_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrgd_m.xrgdownid = g_user
      LET g_xrgd_m.xrgdowndp = g_dept
      LET g_xrgd_m.xrgdcrtid = g_user
      LET g_xrgd_m.xrgdcrtdp = g_dept 
      LET g_xrgd_m.xrgdcrtdt = cl_get_current()
      LET g_xrgd_m.xrgdmodid = g_user
      LET g_xrgd_m.xrgdmoddt = cl_get_current()
      LET g_xrgd_m.xrgdstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xrgd_m.xrgd900 = "0"
      LET g_xrgd_m.xrgd002 = "0"
      LET g_xrgd_m.xrgd103 = "0"
      LET g_xrgd_m.xrgd104 = "0"
      LET g_xrgd_m.l_xrga104diff = "0"
      LET g_xrgd_m.xrgd101 = "0"
      LET g_xrgd_m.xrgd113 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
     
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xrgd_m_t.* = g_xrgd_m.*
      LET g_xrgd_m_o.* = g_xrgd_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrgd_m.xrgdstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL axrt520_input("a")
      
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
         INITIALIZE g_xrgd_m.* TO NULL
         INITIALIZE g_xrge_d TO NULL
         INITIALIZE g_xrge2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axrt520_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xrge_d.clear()
      #CALL g_xrge2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axrt520_set_act_visible()   
   CALL axrt520_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xrgdcomp_t = g_xrgd_m.xrgdcomp
   LET g_xrgddocno_t = g_xrgd_m.xrgddocno
   LET g_xrgd900_t = g_xrgd_m.xrgd900
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrgdent = " ||g_enterprise|| " AND",
                      " xrgdcomp = '", g_xrgd_m.xrgdcomp, "' "
                      ," AND xrgddocno = '", g_xrgd_m.xrgddocno, "' "
                      ," AND xrgd900 = '", g_xrgd_m.xrgd900, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axrt520_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axrt520_cl
   
   CALL axrt520_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axrt520_master_referesh USING g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900 INTO g_xrgd_m.xrgdcomp, 
       g_xrgd_m.xrgd005,g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt, 
       g_xrgd_m.xrgd003,g_xrgd_m.xrgd004,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus, 
       g_xrgd_m.xrgdownid,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdt, 
       g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid, 
       g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd009,g_xrgd_m.xrgd022,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
       g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100, 
       g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.xrgd101,g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016, 
       g_xrgd_m.xrgd017,g_xrgd_m.xrgd018,g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021,g_xrgd_m.xrgd005_desc, 
       g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp_desc,g_xrgd_m.xrgdcrtid_desc, 
       g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdmodid_desc,g_xrgd_m.xrgdcnfid_desc,g_xrgd_m.xrgdpstid_desc, 
       g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022_desc,g_xrgd_m.xrgd016_desc
   
   
   #遮罩相關處理
   LET g_xrgd_m_mask_o.* =  g_xrgd_m.*
   CALL axrt520_xrgd_t_mask()
   LET g_xrgd_m_mask_n.* =  g_xrgd_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrgd_m.xrgdcomp,g_xrgd_m.xrgdcomp_desc,g_xrgd_m.xrgd005,g_xrgd_m.xrgd005_desc,g_xrgd_m.xrgd006, 
       g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt,g_xrgd_m.xrgd003,g_xrgd_m.xrgd004, 
       g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus,g_xrgd_m.xrgdownid, 
       g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdowndp_desc,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtid_desc, 
       g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdcrtdt,g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmodid_desc, 
       g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfid_desc,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid, 
       g_xrgd_m.xrgdpstid_desc,g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009, 
       g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022,g_xrgd_m.xrgd022_desc,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
       g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100, 
       g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.l_xrga104diff,g_xrgd_m.l_glaa001,g_xrgd_m.xrgd101, 
       g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016,g_xrgd_m.xrgd016_desc,g_xrgd_m.xrgd017,g_xrgd_m.xrgd018, 
       g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_xrgd_m.xrgdownid      
   LET g_data_dept  = g_xrgd_m.xrgdowndp
   
   #功能已完成,通報訊息中心
   CALL axrt520_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.modify" >}
#+ 資料修改
PRIVATE FUNCTION axrt520_modify()
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
   LET g_xrgd_m_t.* = g_xrgd_m.*
   LET g_xrgd_m_o.* = g_xrgd_m.*
   
   IF g_xrgd_m.xrgdcomp IS NULL
   OR g_xrgd_m.xrgddocno IS NULL
   OR g_xrgd_m.xrgd900 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xrgdcomp_t = g_xrgd_m.xrgdcomp
   LET g_xrgddocno_t = g_xrgd_m.xrgddocno
   LET g_xrgd900_t = g_xrgd_m.xrgd900
 
   CALL s_transaction_begin()
   
   OPEN axrt520_cl USING g_enterprise,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt520_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axrt520_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axrt520_master_referesh USING g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900 INTO g_xrgd_m.xrgdcomp, 
       g_xrgd_m.xrgd005,g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt, 
       g_xrgd_m.xrgd003,g_xrgd_m.xrgd004,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus, 
       g_xrgd_m.xrgdownid,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdt, 
       g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid, 
       g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd009,g_xrgd_m.xrgd022,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
       g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100, 
       g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.xrgd101,g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016, 
       g_xrgd_m.xrgd017,g_xrgd_m.xrgd018,g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021,g_xrgd_m.xrgd005_desc, 
       g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp_desc,g_xrgd_m.xrgdcrtid_desc, 
       g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdmodid_desc,g_xrgd_m.xrgdcnfid_desc,g_xrgd_m.xrgdpstid_desc, 
       g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022_desc,g_xrgd_m.xrgd016_desc
   
   #檢查是否允許此動作
   IF NOT axrt520_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xrgd_m_mask_o.* =  g_xrgd_m.*
   CALL axrt520_xrgd_t_mask()
   LET g_xrgd_m_mask_n.* =  g_xrgd_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL axrt520_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_xrgdcomp_t = g_xrgd_m.xrgdcomp
      LET g_xrgddocno_t = g_xrgd_m.xrgddocno
      LET g_xrgd900_t = g_xrgd_m.xrgd900
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xrgd_m.xrgdmodid = g_user 
LET g_xrgd_m.xrgdmoddt = cl_get_current()
LET g_xrgd_m.xrgdmodid_desc = cl_get_username(g_xrgd_m.xrgdmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axrt520_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xrgd_t SET (xrgdmodid,xrgdmoddt) = (g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmoddt)
          WHERE xrgdent = g_enterprise AND xrgdcomp = g_xrgdcomp_t
            AND xrgddocno = g_xrgddocno_t
            AND xrgd900 = g_xrgd900_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xrgd_m.* = g_xrgd_m_t.*
            CALL axrt520_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xrgd_m.xrgdcomp != g_xrgd_m_t.xrgdcomp
      OR g_xrgd_m.xrgddocno != g_xrgd_m_t.xrgddocno
      OR g_xrgd_m.xrgd900 != g_xrgd_m_t.xrgd900
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xrge_t SET xrgecomp = g_xrgd_m.xrgdcomp
                                       ,xrgedocno = g_xrgd_m.xrgddocno
                                       ,xrge900 = g_xrgd_m.xrgd900
 
          WHERE xrgeent = g_enterprise AND xrgecomp = g_xrgd_m_t.xrgdcomp
            AND xrgedocno = g_xrgd_m_t.xrgddocno
            AND xrge900 = g_xrgd_m_t.xrgd900
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xrge_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrge_t:",SQLERRMESSAGE 
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
         
         UPDATE apgc_t
            SET apgccomp = g_xrgd_m.xrgdcomp
               ,apgcdocno = g_xrgd_m.xrgddocno
               ,apgc900 = g_xrgd_m.xrgd900
 
          WHERE apgcent = g_enterprise AND
                apgccomp = g_xrgdcomp_t
            AND apgcdocno = g_xrgddocno_t
            AND apgc900 = g_xrgd900_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apgc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
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
   CALL axrt520_set_act_visible()   
   CALL axrt520_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xrgdent = " ||g_enterprise|| " AND",
                      " xrgdcomp = '", g_xrgd_m.xrgdcomp, "' "
                      ," AND xrgddocno = '", g_xrgd_m.xrgddocno, "' "
                      ," AND xrgd900 = '", g_xrgd_m.xrgd900, "' "
 
   #填到對應位置
   CALL axrt520_browser_fill("")
 
   CLOSE axrt520_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axrt520_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axrt520.input" >}
#+ 資料輸入
PRIVATE FUNCTION axrt520_input(p_cmd)
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
   DEFINE l_glaa024              LIKE glaa_t.glaa024
   DEFINE l_ld                   LIKE glaa_t.glaald
   DEFINE l_ooef006              LIKE ooef_t.ooef006
   
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004,
            ooib001     LIKE ooib_t.ooib001        
                    END RECORD
   DEFINE l_glaa001     LIKE glaa_t.glaa001
   DEFINE l_dummy1      LIKE type_t.num20_6
   DEFINE l_dummy2      LIKE type_t.num20_6
   DEFINE l_dummy3      LIKE type_t.num20_6
   DEFINE l_using       LIKE type_t.num5
   DEFINE ls_js         STRING
   DEFINE l_sql         STRING   
   DEFINE l_chr         LIKE type_t.chr10
   
   DEFINE l_oodb004  LIKE oodb_t.oodb004
   DEFINE l_apca013  LIKE apca_t.apca013
   DEFINE l_apca012  LIKE apca_t.apca012
   DEFINE l_oodb011  LIKE oodb_t.oodb011
   DEFINE l_comp     LIKE ooef_t.ooef001
   DEFINE l_autoins     LIKE type_t.num5
   DEFINE l_wc          STRING
   DEFINE l_xmdc011  LIKE xmdc_t.xmdc011
   DEFINE l_xrge008  LIKE xrgb_t.xrgb008
   
      DEFINE l_pmab037     LIKE pmab_t.pmab037
   DEFINE l_pmab055     LIKE pmab_t.pmab055
   DEFINE l_pmab034     LIKE pmab_t.pmab034 
   DEFINE l_pmab056     LIKE pmab_t.pmab056
   DEFINE l_glab005     LIKE glab_t.glab005
   DEFINE l_glab006     LIKE glab_t.glab006
   DEFINE l_glab007     LIKE glab_t.glab007
   DEFINE l_glaa005     LIKE glaa_t.glaa005
   DEFINE l_glaa004     LIKE glaa_t.glaa004
   DEFINE l_isac004     LIKE isac_t.isac004
   DEFINE l_glaa015     LIKE glaa_t.glaa015
   DEFINE l_glaa019     LIKE glaa_t.glaa019
   DEFINE l_glaa017     LIKE glaa_t.glaa017
   DEFINE l_glaa021     LIKE glaa_t.glaa021
   DEFINE l_xrcd        RECORD
                        xrcd103 LIKE xrcd_t.xrcd103,
                        xrcd104 LIKE xrcd_t.xrcd104,
                        xrcd105 LIKE xrcd_t.xrcd105,
                        xrcd113 LIKE xrcd_t.xrcd113,
                        xrcd114 LIKE xrcd_t.xrcd114,
                        xrcd115 LIKE xrcd_t.xrcd115,                        
                        xrcd123 LIKE xrcd_t.xrcd123,
                        xrcd124 LIKE xrcd_t.xrcd124,
                        xrcd125 LIKE xrcd_t.xrcd125,
                        xrcd133 LIKE xrcd_t.xrcd133,
                        xrcd134 LIKE xrcd_t.xrcd134,
                        xrcd135 LIKE xrcd_t.xrcd135
                        END RECORD
   DEFINE l_ooef019     LIKE ooef_t.ooef019
   DEFINE l_xrgbsum     LIKE type_t.num20_6
   DEFINE l_xrgasum     LIKE type_t.num20_6
   DEFINE l_xrgesum     LIKE type_t.num20_6
   DEFINE l_xrgdsum     LIKE type_t.num20_6
   DEFINE l_flag        LIKE type_t.num5      #161104-00046#9 add
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
   DISPLAY BY NAME g_xrgd_m.xrgdcomp,g_xrgd_m.xrgdcomp_desc,g_xrgd_m.xrgd005,g_xrgd_m.xrgd005_desc,g_xrgd_m.xrgd006, 
       g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt,g_xrgd_m.xrgd003,g_xrgd_m.xrgd004, 
       g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus,g_xrgd_m.xrgdownid, 
       g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdowndp_desc,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtid_desc, 
       g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdcrtdt,g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmodid_desc, 
       g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfid_desc,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid, 
       g_xrgd_m.xrgdpstid_desc,g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009, 
       g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022,g_xrgd_m.xrgd022_desc,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
       g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100, 
       g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.l_xrga104diff,g_xrgd_m.l_glaa001,g_xrgd_m.xrgd101, 
       g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016,g_xrgd_m.xrgd016_desc,g_xrgd_m.xrgd017,g_xrgd_m.xrgd018, 
       g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021
   
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
   LET g_forupd_sql = "SELECT xrgeseq,xrgeorga,xrge001,xrge002,xrge003,xrge004,xrge005,xrge008,xrge006, 
       xrge007,xrge100,xrge101,xrge009,xrge105,xrge115,xrge901,xrge902,xrge903 FROM xrge_t WHERE xrgeent=?  
       AND xrgecomp=? AND xrgedocno=? AND xrge900=? AND xrgeseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt520_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT apgcseq,apgcorga,apgc001,apgc002,apgc003,apgc005,apgc014,apgc100,apgc101, 
       apgc006,apgc007,apgc008,apgc009,apgc010,apgc011,apgc103,apgc104,apgc105,apgc113,apgc114,apgc115, 
       apgc004,apgc015,apgc016,apgc012,apgc013 FROM apgc_t WHERE apgcent=? AND apgccomp=? AND apgcdocno=?  
       AND apgc900=? AND apgcseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt520_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axrt520_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axrt520_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xrgd_m.xrgdcomp,g_xrgd_m.xrgd005,g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900, 
       g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt,g_xrgd_m.xrgd003,g_xrgd_m.xrgd004,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024, 
       g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus,g_xrgd_m.xrgd008,g_xrgd_m.xrgd009,g_xrgd_m.xrgd022,g_xrgd_m.xrgd007, 
       g_xrgd_m.xrgd010,g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023, 
       g_xrgd_m.xrgd100,g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.l_xrga104diff,g_xrgd_m.l_glaa001, 
       g_xrgd_m.xrgd101,g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016,g_xrgd_m.xrgd017,g_xrgd_m.xrgd018, 
       g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axrt520.input.head" >}
      #單頭段
      INPUT BY NAME g_xrgd_m.xrgdcomp,g_xrgd_m.xrgd005,g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900, 
          g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt,g_xrgd_m.xrgd003,g_xrgd_m.xrgd004,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024, 
          g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus,g_xrgd_m.xrgd008,g_xrgd_m.xrgd009,g_xrgd_m.xrgd022,g_xrgd_m.xrgd007, 
          g_xrgd_m.xrgd010,g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023, 
          g_xrgd_m.xrgd100,g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.l_xrga104diff,g_xrgd_m.l_glaa001, 
          g_xrgd_m.xrgd101,g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016,g_xrgd_m.xrgd017,g_xrgd_m.xrgd018, 
          g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axrt520_cl USING g_enterprise,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axrt520_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axrt520_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axrt520_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL axrt520_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgdcomp
            
            #add-point:AFTER FIELD xrgdcomp name="input.a.xrgdcomp"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xrgd_m.xrgdcomp) AND NOT cl_null(g_xrgd_m.xrgddocno) AND NOT cl_null(g_xrgd_m.xrgd900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xrgd_m.xrgdcomp != g_xrgdcomp_t  OR g_xrgd_m.xrgddocno != g_xrgddocno_t  OR g_xrgd_m.xrgd900 != g_xrgd900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrgd_t WHERE "||"xrgdent = '" ||g_enterprise|| "' AND "||"xrgdcomp = '"||g_xrgd_m.xrgdcomp ||"' AND "|| "xrgddocno = '"||g_xrgd_m.xrgddocno ||"' AND "|| "xrgd900 = '"||g_xrgd_m.xrgd900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdcomp
            #add-point:BEFORE FIELD xrgdcomp name="input.b.xrgdcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgdcomp
            #add-point:ON CHANGE xrgdcomp name="input.g.xrgdcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd005
            
            #add-point:AFTER FIELD xrgd005 name="input.a.xrgd005"
            #業務人員
            LET g_xrgd_m.xrgd005_desc = ''
            IF NOT cl_null(g_xrgd_m.xrgd005) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrgd_m.xrgd005 != g_xrgd_m_t.xrgd005 OR g_xrgd_m_t.xrgd005 IS NULL )) THEN #170119-00024#10 mark
               IF g_xrgd_m.xrgd005 != g_xrgd_m_o.xrgd005 OR cl_null(g_xrgd_m_o.xrgd005) THEN #170119-00024#10 add
                  LET g_errno = ''
                  CALL s_employee_chk(g_xrgd_m.xrgd005) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     #LET g_xrgd_m.xrgd005 = g_xrgd_m_t.xrgd005 #170119-00024#10 mark
                     LET g_xrgd_m.xrgd005 = g_xrgd_m_o.xrgd005  #170119-00024#10 add
                     CALL s_desc_get_person_desc(g_xrgd_m.xrgd005) RETURNING g_xrgd_m.xrgd005_desc
                     DISPLAY BY NAME g_xrgd_m.xrgd005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_xrgd_m.xrgd005) RETURNING g_xrgd_m.xrgd005_desc
            DISPLAY BY NAME g_xrgd_m.xrgd005_desc
            LET g_xrgd_m_o.* = g_xrgd_m.* #170119-00024#10 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd005
            #add-point:BEFORE FIELD xrgd005 name="input.b.xrgd005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd005
            #add-point:ON CHANGE xrgd005 name="input.g.xrgd005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd006
            #add-point:BEFORE FIELD xrgd006 name="input.b.xrgd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd006
            
            #add-point:AFTER FIELD xrgd006 name="input.a.xrgd006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd006
            #add-point:ON CHANGE xrgd006 name="input.g.xrgd006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgddocno
            #add-point:BEFORE FIELD xrgddocno name="input.b.xrgddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgddocno
            
            #add-point:AFTER FIELD xrgddocno name="input.a.xrgddocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xrgd_m.xrgdcomp) AND NOT cl_null(g_xrgd_m.xrgddocno) AND NOT cl_null(g_xrgd_m.xrgd900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xrgd_m.xrgdcomp != g_xrgdcomp_t  OR g_xrgd_m.xrgddocno != g_xrgddocno_t  OR g_xrgd_m.xrgd900 != g_xrgd900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrgd_t WHERE "||"xrgdent = '" ||g_enterprise|| "' AND "||"xrgdcomp = '"||g_xrgd_m.xrgdcomp ||"' AND "|| "xrgddocno = '"||g_xrgd_m.xrgddocno ||"' AND "|| "xrgd900 = '"||g_xrgd_m.xrgd900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xrgd_m.xrgddocno) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrgd_m.xrgddocno != g_xrgd_m_t.xrgddocno OR g_xrgd_m_t.xrgddocno IS NULL )) THEN #170119-00024#10 mark
               IF g_xrgd_m.xrgddocno != g_xrgd_m_o.xrgddocno OR cl_null(g_xrgd_m_o.xrgddocno) THEN #170119-00024#10 add
                  CALL axrt520_xrgddocno_chk(g_xrgd_m.xrgddocno)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_xrgd_m.xrgddocno = g_xrgd_m_t.xrgddocno #170119-00024#10 mark
                     LET g_xrgd_m.xrgddocno = g_xrgd_m_o.xrgddocno  #170119-00024#10 add
                     NEXT FIELD CURRENT
                  END IF
                  #161104-00046#9 --s add
                  CALL s_control_chk_doc('1',g_xrgd_m.xrgddocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
                  IF g_sub_success AND l_flag THEN             
                  ELSE
                     #LET g_xrgd_m.xrgddocno = g_xrgd_m_t.xrgddocno #170119-00024#10 mark
                     LET g_xrgd_m.xrgddocno = g_xrgd_m_o.xrgddocno  #170119-00024#10 add
                     NEXT FIELD CURRENT           
                  END IF           
                  #161104-00046#9 --e add                    
               END IF
            END IF

            IF axrt520_xrgddocno_ins_xrgd() THEN

            END IF

            IF axrt520_xrgddocno_ins_xrge() THEN

            END IF
            LET g_xrgd_m_o.* = g_xrgd_m.* #170119-00024#10 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgddocno
            #add-point:ON CHANGE xrgddocno name="input.g.xrgddocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd900
            #add-point:BEFORE FIELD xrgd900 name="input.b.xrgd900"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd900
            
            #add-point:AFTER FIELD xrgd900 name="input.a.xrgd900"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xrgd_m.xrgdcomp) AND NOT cl_null(g_xrgd_m.xrgddocno) AND NOT cl_null(g_xrgd_m.xrgd900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xrgd_m.xrgdcomp != g_xrgdcomp_t  OR g_xrgd_m.xrgddocno != g_xrgddocno_t  OR g_xrgd_m.xrgd900 != g_xrgd900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrgd_t WHERE "||"xrgdent = '" ||g_enterprise|| "' AND "||"xrgdcomp = '"||g_xrgd_m.xrgdcomp ||"' AND "|| "xrgddocno = '"||g_xrgd_m.xrgddocno ||"' AND "|| "xrgd900 = '"||g_xrgd_m.xrgd900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd900
            #add-point:ON CHANGE xrgd900 name="input.g.xrgd900"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd002
            #add-point:BEFORE FIELD xrgd002 name="input.b.xrgd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd002
            
            #add-point:AFTER FIELD xrgd002 name="input.a.xrgd002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd002
            #add-point:ON CHANGE xrgd002 name="input.g.xrgd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgddocdt
            #add-point:BEFORE FIELD xrgddocdt name="input.b.xrgddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgddocdt
            
            #add-point:AFTER FIELD xrgddocdt name="input.a.xrgddocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgddocdt
            #add-point:ON CHANGE xrgddocdt name="input.g.xrgddocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd003
            #add-point:BEFORE FIELD xrgd003 name="input.b.xrgd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd003
            
            #add-point:AFTER FIELD xrgd003 name="input.a.xrgd003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd003
            #add-point:ON CHANGE xrgd003 name="input.g.xrgd003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd004
            
            #add-point:AFTER FIELD xrgd004 name="input.a.xrgd004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrgd_m.xrgd004
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrgd_m.xrgd004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrgd_m.xrgd004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd004
            #add-point:BEFORE FIELD xrgd004 name="input.b.xrgd004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd004
            #add-point:ON CHANGE xrgd004 name="input.g.xrgd004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd001
            #add-point:BEFORE FIELD xrgd001 name="input.b.xrgd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd001
            
            #add-point:AFTER FIELD xrgd001 name="input.a.xrgd001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd001
            #add-point:ON CHANGE xrgd001 name="input.g.xrgd001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd024
            #add-point:BEFORE FIELD xrgd024 name="input.b.xrgd024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd024
            
            #add-point:AFTER FIELD xrgd024 name="input.a.xrgd024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd024
            #add-point:ON CHANGE xrgd024 name="input.g.xrgd024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd025
            #add-point:BEFORE FIELD xrgd025 name="input.b.xrgd025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd025
            
            #add-point:AFTER FIELD xrgd025 name="input.a.xrgd025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd025
            #add-point:ON CHANGE xrgd025 name="input.g.xrgd025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgdstus
            #add-point:BEFORE FIELD xrgdstus name="input.b.xrgdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgdstus
            
            #add-point:AFTER FIELD xrgdstus name="input.a.xrgdstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgdstus
            #add-point:ON CHANGE xrgdstus name="input.g.xrgdstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd008
            
            #add-point:AFTER FIELD xrgd008 name="input.a.xrgd008"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrgd_m.xrgd008
            CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrgd_m.xrgd008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrgd_m.xrgd008_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd008
            #add-point:BEFORE FIELD xrgd008 name="input.b.xrgd008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd008
            #add-point:ON CHANGE xrgd008 name="input.g.xrgd008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd009
            
            #add-point:AFTER FIELD xrgd009 name="input.a.xrgd009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrgd_m.xrgd009
            CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrgd_m.xrgd009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrgd_m.xrgd009_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd009
            #add-point:BEFORE FIELD xrgd009 name="input.b.xrgd009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd009
            #add-point:ON CHANGE xrgd009 name="input.g.xrgd009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd022
            
            #add-point:AFTER FIELD xrgd022 name="input.a.xrgd022"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrgd_m.xrgd022
            CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrgd_m.xrgd022_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrgd_m.xrgd022_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd022
            #add-point:BEFORE FIELD xrgd022 name="input.b.xrgd022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd022
            #add-point:ON CHANGE xrgd022 name="input.g.xrgd022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd007
            #add-point:BEFORE FIELD xrgd007 name="input.b.xrgd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd007
            
            #add-point:AFTER FIELD xrgd007 name="input.a.xrgd007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd007
            #add-point:ON CHANGE xrgd007 name="input.g.xrgd007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd010
            #add-point:BEFORE FIELD xrgd010 name="input.b.xrgd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd010
            
            #add-point:AFTER FIELD xrgd010 name="input.a.xrgd010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd010
            #add-point:ON CHANGE xrgd010 name="input.g.xrgd010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd013
            #add-point:BEFORE FIELD xrgd013 name="input.b.xrgd013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd013
            
            #add-point:AFTER FIELD xrgd013 name="input.a.xrgd013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd013
            #add-point:ON CHANGE xrgd013 name="input.g.xrgd013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd012
            #add-point:BEFORE FIELD xrgd012 name="input.b.xrgd012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd012
            
            #add-point:AFTER FIELD xrgd012 name="input.a.xrgd012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd012
            #add-point:ON CHANGE xrgd012 name="input.g.xrgd012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd011
            #add-point:BEFORE FIELD xrgd011 name="input.b.xrgd011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd011
            
            #add-point:AFTER FIELD xrgd011 name="input.a.xrgd011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd011
            #add-point:ON CHANGE xrgd011 name="input.g.xrgd011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd014
            #add-point:BEFORE FIELD xrgd014 name="input.b.xrgd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd014
            
            #add-point:AFTER FIELD xrgd014 name="input.a.xrgd014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd014
            #add-point:ON CHANGE xrgd014 name="input.g.xrgd014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd023
            #add-point:BEFORE FIELD xrgd023 name="input.b.xrgd023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd023
            
            #add-point:AFTER FIELD xrgd023 name="input.a.xrgd023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd023
            #add-point:ON CHANGE xrgd023 name="input.g.xrgd023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd100
            #add-point:BEFORE FIELD xrgd100 name="input.b.xrgd100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd100
            
            #add-point:AFTER FIELD xrgd100 name="input.a.xrgd100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd100
            #add-point:ON CHANGE xrgd100 name="input.g.xrgd100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd103
            #add-point:BEFORE FIELD xrgd103 name="input.b.xrgd103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd103
            
            #add-point:AFTER FIELD xrgd103 name="input.a.xrgd103"
            #開狀金額          
            IF NOT cl_null(g_xrgd_m.xrgd103)THEN
               IF cl_null(g_xrgd_m_o.xrgd103) OR (g_xrgd_m_o.xrgd103 <> g_xrgd_m.xrgd103)THEN
                  LET g_xrgd_m.xrgd113 = '' #170119-00024#10 add
                  #113=103*101
                  IF cl_null(g_xrgd_m.xrgd103)THEN LET g_xrgd_m.xrgd103 = 0 END IF
                  IF cl_null(g_xrgd_m.xrgd101)THEN LET g_xrgd_m.xrgd101 = 0 END IF  
                  LET g_xrgd_m.xrgd113 = g_xrgd_m.xrgd103 * g_xrgd_m.xrgd101
                  #本幣取位
                  CALL s_curr_round_ld('1',l_ld,l_glaa001,g_xrgd_m.xrgd113,2) RETURNING g_sub_success,g_errno,g_xrgd_m.xrgd113
                  DISPLAY BY NAME g_xrgd_m.xrgd113
               END IF
            END IF
            CALL axrt520_to_o_h()
            LET g_xrgd_m.l_xrga104diff = g_xrgd_m.xrgd103 - g_xrgd_m.xrgd104
            DISPLAY BY NAME g_xrgd_m.l_xrga104diff
            LET g_xrgd_m_o.* = g_xrgd_m.* #170119-00024#10 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd103
            #add-point:ON CHANGE xrgd103 name="input.g.xrgd103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd104
            #add-point:BEFORE FIELD xrgd104 name="input.b.xrgd104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd104
            
            #add-point:AFTER FIELD xrgd104 name="input.a.xrgd104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd104
            #add-point:ON CHANGE xrgd104 name="input.g.xrgd104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrga104diff
            #add-point:BEFORE FIELD l_xrga104diff name="input.b.l_xrga104diff"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrga104diff
            
            #add-point:AFTER FIELD l_xrga104diff name="input.a.l_xrga104diff"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrga104diff
            #add-point:ON CHANGE l_xrga104diff name="input.g.l_xrga104diff"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glaa001
            #add-point:BEFORE FIELD l_glaa001 name="input.b.l_glaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glaa001
            
            #add-point:AFTER FIELD l_glaa001 name="input.a.l_glaa001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glaa001
            #add-point:ON CHANGE l_glaa001 name="input.g.l_glaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd101
            #add-point:BEFORE FIELD xrgd101 name="input.b.xrgd101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd101
            
            #add-point:AFTER FIELD xrgd101 name="input.a.xrgd101"
            LET l_ld = NULL
            LET l_glaa001 = NULL
            SELECT glaald,glaa001 INTO l_ld,l_glaa001 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014 = 'Y'           
            IF NOT cl_null(g_xrgd_m.xrgd101)THEN
               IF cl_null(g_xrgd_m_o.xrgd101) OR (g_xrgd_m_o.xrgd101<> g_xrgd_m.xrgd101)THEN
                  #CALL s_curr_round_ld('1',l_ld,l_glaa001,g_xrgd_m.xrgd101,3) RETURNING g_sub_success,g_errno,g_xrgd_m.xrgd101 #160829-00004#4 mark
                  CALL s_curr_round_ld('1',l_ld,g_xrgd_m.xrgd100,g_xrgd_m.xrgd101,3) RETURNING g_sub_success,g_errno,g_xrgd_m.xrgd101 #160829-00004#4
                  LET g_xrgd_m.xrgd113 = '' #170119-00024#10 add
                  #113=103*101
                  IF cl_null(g_xrgd_m.xrgd103)THEN LET g_xrgd_m.xrgd103 = 0 END IF
                  IF cl_null(g_xrgd_m.xrgd101)THEN LET g_xrgd_m.xrgd101 = 0 END IF  
                  LET g_xrgd_m.xrgd113 = g_xrgd_m.xrgd103 * g_xrgd_m.xrgd101
                  #本幣取位
                  CALL s_curr_round_ld('1',l_ld,l_glaa001,g_xrgd_m.xrgd113,2) RETURNING g_sub_success,g_errno,g_xrgd_m.xrgd113
                  DISPLAY BY NAME g_xrgd_m.xrgd113
               END IF
            END IF
            CALL axrt520_to_o_h()
            LET g_xrgd_m_o.* = g_xrgd_m.* #170119-00024#10 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd101
            #add-point:ON CHANGE xrgd101 name="input.g.xrgd101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd113
            #add-point:BEFORE FIELD xrgd113 name="input.b.xrgd113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd113
            
            #add-point:AFTER FIELD xrgd113 name="input.a.xrgd113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd113
            #add-point:ON CHANGE xrgd113 name="input.g.xrgd113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd015
            #add-point:BEFORE FIELD xrgd015 name="input.b.xrgd015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd015
            
            #add-point:AFTER FIELD xrgd015 name="input.a.xrgd015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd015
            #add-point:ON CHANGE xrgd015 name="input.g.xrgd015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd016
            
            #add-point:AFTER FIELD xrgd016 name="input.a.xrgd016"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrgd_m.xrgd016
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrgd_m.xrgd016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrgd_m.xrgd016_desc

            LET g_xrgd_m.xrgd016_desc = ' '
            IF NOT cl_null(g_xrgd_m.xrgd016) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrgd_m.xrgd016 != g_xrgd_m_t.xrgd016 OR g_xrgd_m_t.xrgd016 IS NULL )) THEN #170119-00024#10 mark
               IF g_xrgd_m.xrgd016 != g_xrgd_m_o.xrgd016 OR cl_null(g_xrgd_m_o.xrgd016) THEN #170119-00024#10 add
                  IF NOT s_azzi650_chk_exist('263',g_xrgd_m.xrgd016) THEN
                     #LET g_xrgd_m.xrgd016  = g_xrgd_m_t.xrgd016 #170119-00024#10 mark
                     LET g_xrgd_m.xrgd016  = g_xrgd_m_o.xrgd016  #170119-00024#10 add
                     CALL s_desc_get_acc_desc('263',g_xrgd_m.xrgd016) RETURNING g_xrgd_m.xrgd016_desc
                     DISPLAY BY NAME g_xrgd_m.xrgd016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF   
            CALL s_desc_get_acc_desc('263',g_xrgd_m.xrgd016) RETURNING g_xrgd_m.xrgd016_desc
            DISPLAY BY NAME g_xrgd_m.xrgd016_desc
            LET g_xrgd_m_o.* = g_xrgd_m.* #170119-00024#10 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd016
            #add-point:BEFORE FIELD xrgd016 name="input.b.xrgd016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd016
            #add-point:ON CHANGE xrgd016 name="input.g.xrgd016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd017
            #add-point:BEFORE FIELD xrgd017 name="input.b.xrgd017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd017
            
            #add-point:AFTER FIELD xrgd017 name="input.a.xrgd017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd017
            #add-point:ON CHANGE xrgd017 name="input.g.xrgd017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd018
            #add-point:BEFORE FIELD xrgd018 name="input.b.xrgd018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd018
            
            #add-point:AFTER FIELD xrgd018 name="input.a.xrgd018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd018
            #add-point:ON CHANGE xrgd018 name="input.g.xrgd018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd019
            #add-point:BEFORE FIELD xrgd019 name="input.b.xrgd019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd019
            
            #add-point:AFTER FIELD xrgd019 name="input.a.xrgd019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd019
            #add-point:ON CHANGE xrgd019 name="input.g.xrgd019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd020
            #add-point:BEFORE FIELD xrgd020 name="input.b.xrgd020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd020
            
            #add-point:AFTER FIELD xrgd020 name="input.a.xrgd020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd020
            #add-point:ON CHANGE xrgd020 name="input.g.xrgd020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgd021
            #add-point:BEFORE FIELD xrgd021 name="input.b.xrgd021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgd021
            
            #add-point:AFTER FIELD xrgd021 name="input.a.xrgd021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgd021
            #add-point:ON CHANGE xrgd021 name="input.g.xrgd021"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xrgdcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgdcomp
            #add-point:ON ACTION controlp INFIELD xrgdcomp name="input.c.xrgdcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd005
            #add-point:ON ACTION controlp INFIELD xrgd005 name="input.c.xrgd005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrgd_m.xrgd005
            CALL q_ooag001_8()
            LET g_xrgd_m.xrgd005 = g_qryparam.return1
            CALL s_desc_get_person_desc(g_xrgd_m.xrgd005) RETURNING g_xrgd_m.xrgd005_desc
            DISPLAY BY NAME g_xrgd_m.xrgd005,g_xrgd_m.xrgd005_desc
            NEXT FIELD xrgd005
            #END add-point
 
 
         #Ctrlp:input.c.xrgd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd006
            #add-point:ON ACTION controlp INFIELD xrgd006 name="input.c.xrgd006"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgddocno
            #add-point:ON ACTION controlp INFIELD xrgddocno name="input.c.xrgddocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrgd_m.xrgddocno
            LET g_qryparam.where = " xrgacomp IN ",g_wc_cs_comp CLIPPED
            #161111-00049#10 Add--s--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = xrgaent ",
                                                       "                AND pmaa001 = xrga004 )"
            END IF
            #161111-00049#10 Add--e--  
            #161104-00046#9 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc) AND NOT g_user_dept_wc = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc CLIPPED
            END IF
            #161104-00046#9 --e add            
            CALL q_xrgadocno()
            LET g_xrgd_m.xrgddocno = g_qryparam.return1
            DISPLAY BY NAME g_xrgd_m.xrgddocno
            NEXT FIELD xrgddocno
            #END add-point
 
 
         #Ctrlp:input.c.xrgd900
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd900
            #add-point:ON ACTION controlp INFIELD xrgd900 name="input.c.xrgd900"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd002
            #add-point:ON ACTION controlp INFIELD xrgd002 name="input.c.xrgd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgddocdt
            #add-point:ON ACTION controlp INFIELD xrgddocdt name="input.c.xrgddocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd003
            #add-point:ON ACTION controlp INFIELD xrgd003 name="input.c.xrgd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd004
            #add-point:ON ACTION controlp INFIELD xrgd004 name="input.c.xrgd004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd001
            #add-point:ON ACTION controlp INFIELD xrgd001 name="input.c.xrgd001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd024
            #add-point:ON ACTION controlp INFIELD xrgd024 name="input.c.xrgd024"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd025
            #add-point:ON ACTION controlp INFIELD xrgd025 name="input.c.xrgd025"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgdstus
            #add-point:ON ACTION controlp INFIELD xrgdstus name="input.c.xrgdstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd008
            #add-point:ON ACTION controlp INFIELD xrgd008 name="input.c.xrgd008"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd009
            #add-point:ON ACTION controlp INFIELD xrgd009 name="input.c.xrgd009"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd022
            #add-point:ON ACTION controlp INFIELD xrgd022 name="input.c.xrgd022"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd007
            #add-point:ON ACTION controlp INFIELD xrgd007 name="input.c.xrgd007"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd010
            #add-point:ON ACTION controlp INFIELD xrgd010 name="input.c.xrgd010"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd013
            #add-point:ON ACTION controlp INFIELD xrgd013 name="input.c.xrgd013"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd012
            #add-point:ON ACTION controlp INFIELD xrgd012 name="input.c.xrgd012"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd011
            #add-point:ON ACTION controlp INFIELD xrgd011 name="input.c.xrgd011"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd014
            #add-point:ON ACTION controlp INFIELD xrgd014 name="input.c.xrgd014"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd023
            #add-point:ON ACTION controlp INFIELD xrgd023 name="input.c.xrgd023"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd100
            #add-point:ON ACTION controlp INFIELD xrgd100 name="input.c.xrgd100"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd103
            #add-point:ON ACTION controlp INFIELD xrgd103 name="input.c.xrgd103"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd104
            #add-point:ON ACTION controlp INFIELD xrgd104 name="input.c.xrgd104"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_xrga104diff
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrga104diff
            #add-point:ON ACTION controlp INFIELD l_xrga104diff name="input.c.l_xrga104diff"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_glaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glaa001
            #add-point:ON ACTION controlp INFIELD l_glaa001 name="input.c.l_glaa001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrgd_m.l_glaa001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooai001()                                #呼叫開窗
 
            LET g_xrgd_m.l_glaa001 = g_qryparam.return1              

            DISPLAY g_xrgd_m.l_glaa001 TO l_glaa001              #

            NEXT FIELD l_glaa001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xrgd101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd101
            #add-point:ON ACTION controlp INFIELD xrgd101 name="input.c.xrgd101"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd113
            #add-point:ON ACTION controlp INFIELD xrgd113 name="input.c.xrgd113"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd015
            #add-point:ON ACTION controlp INFIELD xrgd015 name="input.c.xrgd015"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd016
            #add-point:ON ACTION controlp INFIELD xrgd016 name="input.c.xrgd016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrgd_m.xrgd016   
            LET g_qryparam.arg1 = "263"
            CALL q_oocq002()                          
            LET g_xrgd_m.xrgd016 = g_qryparam.return1    
            CALL s_desc_get_acc_desc('263',g_xrgd_m.xrgd016) RETURNING g_xrgd_m.xrgd016_desc
            DISPLAY BY NAME g_xrgd_m.xrgd016,g_xrgd_m.xrgd016_desc
            NEXT FIELD xrgd016
            #END add-point
 
 
         #Ctrlp:input.c.xrgd017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd017
            #add-point:ON ACTION controlp INFIELD xrgd017 name="input.c.xrgd017"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd018
            #add-point:ON ACTION controlp INFIELD xrgd018 name="input.c.xrgd018"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd019
            #add-point:ON ACTION controlp INFIELD xrgd019 name="input.c.xrgd019"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd020
            #add-point:ON ACTION controlp INFIELD xrgd020 name="input.c.xrgd020"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrgd021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgd021
            #add-point:ON ACTION controlp INFIELD xrgd021 name="input.c.xrgd021"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO xrgd_t (xrgdent,xrgdcomp,xrgd005,xrgd006,xrgddocno,xrgd900,xrgd002,xrgddocdt, 
                   xrgd003,xrgd004,xrgd001,xrgd024,xrgd025,xrgdstus,xrgdownid,xrgdowndp,xrgdcrtid,xrgdcrtdp, 
                   xrgdcrtdt,xrgdmodid,xrgdmoddt,xrgdcnfid,xrgdcnfdt,xrgdpstid,xrgdpstdt,xrgd008,xrgd009, 
                   xrgd022,xrgd007,xrgd010,xrgd013,xrgd012,xrgd011,xrgd014,xrgd023,xrgd100,xrgd103,xrgd104, 
                   xrgd101,xrgd113,xrgd015,xrgd016,xrgd017,xrgd018,xrgd019,xrgd020,xrgd021)
               VALUES (g_enterprise,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgd005,g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno, 
                   g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt,g_xrgd_m.xrgd003,g_xrgd_m.xrgd004, 
                   g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus,g_xrgd_m.xrgdownid, 
                   g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdt,g_xrgd_m.xrgdmodid, 
                   g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid,g_xrgd_m.xrgdpstdt, 
                   g_xrgd_m.xrgd008,g_xrgd_m.xrgd009,g_xrgd_m.xrgd022,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
                   g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023, 
                   g_xrgd_m.xrgd100,g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.xrgd101,g_xrgd_m.xrgd113, 
                   g_xrgd_m.xrgd015,g_xrgd_m.xrgd016,g_xrgd_m.xrgd017,g_xrgd_m.xrgd018,g_xrgd_m.xrgd019, 
                   g_xrgd_m.xrgd020,g_xrgd_m.xrgd021) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xrgd_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               CALL axrt520_xrgd_ins_xrgh()
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axrt520_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axrt520_b_fill()
                  CALL axrt520_b_fill2('0')
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
               CALL axrt520_xrgd_t_mask_restore('restore_mask_o')
               
               UPDATE xrgd_t SET (xrgdcomp,xrgd005,xrgd006,xrgddocno,xrgd900,xrgd002,xrgddocdt,xrgd003, 
                   xrgd004,xrgd001,xrgd024,xrgd025,xrgdstus,xrgdownid,xrgdowndp,xrgdcrtid,xrgdcrtdp, 
                   xrgdcrtdt,xrgdmodid,xrgdmoddt,xrgdcnfid,xrgdcnfdt,xrgdpstid,xrgdpstdt,xrgd008,xrgd009, 
                   xrgd022,xrgd007,xrgd010,xrgd013,xrgd012,xrgd011,xrgd014,xrgd023,xrgd100,xrgd103,xrgd104, 
                   xrgd101,xrgd113,xrgd015,xrgd016,xrgd017,xrgd018,xrgd019,xrgd020,xrgd021) = (g_xrgd_m.xrgdcomp, 
                   g_xrgd_m.xrgd005,g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002, 
                   g_xrgd_m.xrgddocdt,g_xrgd_m.xrgd003,g_xrgd_m.xrgd004,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024, 
                   g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus,g_xrgd_m.xrgdownid,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdcrtid, 
                   g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdt,g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid, 
                   g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid,g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd009, 
                   g_xrgd_m.xrgd022,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010,g_xrgd_m.xrgd013,g_xrgd_m.xrgd012, 
                   g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100,g_xrgd_m.xrgd103, 
                   g_xrgd_m.xrgd104,g_xrgd_m.xrgd101,g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016, 
                   g_xrgd_m.xrgd017,g_xrgd_m.xrgd018,g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021) 
 
                WHERE xrgdent = g_enterprise AND xrgdcomp = g_xrgdcomp_t
                  AND xrgddocno = g_xrgddocno_t
                  AND xrgd900 = g_xrgd900_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrgd_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               CALL axrt520_xrgd_ins_xrgh()
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL axrt520_xrgd_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xrgd_m_t)
               LET g_log2 = util.JSON.stringify(g_xrgd_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xrgdcomp_t = g_xrgd_m.xrgdcomp
            LET g_xrgddocno_t = g_xrgd_m.xrgddocno
            LET g_xrgd900_t = g_xrgd_m.xrgd900
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axrt520.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xrge_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xrge_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axrt520_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xrge_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            #albireo 160728-----s
            #點入單身時已有單身資訊
            LET l_count = NULL
            SELECT COUNT(*) INTO l_count FROM xrge_t
             WHERE xrgeent   = g_enterprise
               AND xrgecomp  = g_xrgd_m.xrgdcomp
               AND xrgedocno = g_xrgd_m.xrgddocno
               AND xrge900   = g_xrgd_m.xrgd900
            IF cl_null(l_count)THEN LET l_count = 0 END IF

            IF l_count > 0 THEN
               #判斷是否有任意單身有訂單變更單且變更日大於申請日
               LET l_count = NULL
               SELECT COUNT(*) INTO l_count FROM xrge_t,xrgd_t
                WHERE xrgeent   = g_enterprise
                  AND xrgecomp  = g_xrgd_m.xrgdcomp
                  AND xrgedocno = g_xrgd_m.xrgddocno
                  AND xrge900   = g_xrgd_m.xrgd900  
                  AND xrgecomp  = xrgdcomp
                  AND xrgedocno = xrgddocno
                  AND xrgeent   = xrgdent
                  AND xrge900   = xrgd900
                  AND EXISTS(SELECT 1 FROM xmee_t WHERE xmeeent = xrgeent AND xmee902 >= xrgd003
                                AND xmeedocno = xrge001 AND xmeestus = 'Y')
               IF cl_null(l_count)THEN LET l_count = 0 END IF
               
               IF l_count > 0 THEN
                  IF cl_ask_confirm('axr-01030') THEN
                     CALL s_transaction_begin()
                     CALL cl_err_collect_init()
                     CALL axrt520_reins_xrge()RETURNING g_sub_success
                     CALL axrt520_b_fill()                     
                     FOR l_i = 1 TO g_xrge_d.getLength()
                        CALL axrt520_xrge_ins_xrgh(g_xrge_d[l_i].*)RETURNING g_sub_success
                     END FOR                      
                     CALL s_transaction_end('Y','0')
                     CALL cl_err_collect_init()
                     CALL cl_err_collect_show()
                     CALL axrt520_b_fill()   
                  END IF
               END IF
            END IF
            #albireo 160728-----e
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
            OPEN axrt520_cl USING g_enterprise,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axrt520_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axrt520_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xrge_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xrge_d[l_ac].xrgeseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xrge_d_t.* = g_xrge_d[l_ac].*  #BACKUP
               LET g_xrge_d_o.* = g_xrge_d[l_ac].*  #BACKUP
               CALL axrt520_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL axrt520_set_no_entry_b(l_cmd)
               IF NOT axrt520_lock_b("xrge_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt520_bcl INTO g_xrge_d[l_ac].xrgeseq,g_xrge_d[l_ac].xrgeorga,g_xrge_d[l_ac].xrge001, 
                      g_xrge_d[l_ac].xrge002,g_xrge_d[l_ac].xrge003,g_xrge_d[l_ac].xrge004,g_xrge_d[l_ac].xrge005, 
                      g_xrge_d[l_ac].xrge008,g_xrge_d[l_ac].xrge006,g_xrge_d[l_ac].xrge007,g_xrge_d[l_ac].xrge100, 
                      g_xrge_d[l_ac].xrge101,g_xrge_d[l_ac].xrge009,g_xrge_d[l_ac].xrge105,g_xrge_d[l_ac].xrge115, 
                      g_xrge_d[l_ac].xrge901,g_xrge_d[l_ac].xrge902,g_xrge_d[l_ac].xrge903
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xrge_d_t.xrgeseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrge_d_mask_o[l_ac].* =  g_xrge_d[l_ac].*
                  CALL axrt520_xrge_t_mask()
                  LET g_xrge_d_mask_n[l_ac].* =  g_xrge_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axrt520_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #161111-00049#10 Add  ---(S)---
            LET g_sql_ctrl2 = NULL
            CALL s_control_get_item_sql('2',g_xrgd_m.xrgdcomp,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl2
            #161111-00049#10 Add  ---(E)---       
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
            INITIALIZE g_xrge_d[l_ac].* TO NULL 
            INITIALIZE g_xrge_d_t.* TO NULL 
            INITIALIZE g_xrge_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_xrge_d[l_ac].xrgeseq = "0"
      LET g_xrge_d[l_ac].xrge002 = "0"
      LET g_xrge_d[l_ac].xrge008 = "0"
      LET g_xrge_d[l_ac].xrge101 = "0"
      LET g_xrge_d[l_ac].xrge009 = "0"
      LET g_xrge_d[l_ac].xrge105 = "0"
      LET g_xrge_d[l_ac].xrge115 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
        LET g_xrge_d[l_ac].xrgeseq = NULL
            SELECT MAX(xrgeseq)+1 INTO g_xrge_d[l_ac].xrgeseq
              FROM xrge_t
             WHERE xrgeent = g_enterprise
               AND xrgecomp = g_xrgd_m.xrgdcomp
               AND xrgedocno = g_xrgd_m.xrgddocno
            IF cl_null(g_xrge_d[l_ac].xrgeseq)THEN
               LET g_xrge_d[l_ac].xrgeseq = 1 
            END IF
              
            #預設g_site
            #法人比對單頭法人
            #檢核是否為法人下組織   #用8營運中心展
            #下展組織與權限也要符合才可帶出
            LET g_xrge_d[l_ac].xrgeorga = g_site
            LET l_sql = "SELECT COUNT(*) FROM ooef_t ",
                        " WHERE ooefent = ",g_enterprise," ",
                        "   AND ooef001 = '",g_xrge_d[l_ac].xrgeorga,"' ",
                        "   AND ooef017 = '",g_xrgd_m.xrgdcomp,"' ",
                        "   AND ooef001 IN ",g_wc_apgborga,
                        "   AND ooefstus = 'Y' "
            PREPARE sel_ooefp1 FROM l_sql
            LET l_count = NULL
            EXECUTE sel_ooefp1 INTO l_count 
            IF cl_null(l_count)THEN LET l_count = 0 END IF
            IF l_count = 0 THEN
               LET g_xrge_d[l_ac].xrgeorga = ''
            END IF
            LET g_xrge_d[l_ac].xrge002 = ''
            
            LET g_xrge_d[l_ac].xrgeorga_desc = s_desc_get_department_desc(g_xrge_d[l_ac].xrgeorga)
            DISPLAY BY NAME g_xrge_d[l_ac].xrgeorga_desc
            
            IF l_ac > 1 THEN
               LET g_xrge_d[l_ac].xrge006 = g_xrge_d[l_ac-1].xrge006
            END IF
            CALL s_tax_chk(g_xrgd_m.xrgdcomp,g_xrge_d[l_ac].xrge006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
            LET g_xrge_d[l_ac].xrge007 = l_apca013
            IF cl_null(l_apca013)THEN
               LET g_xrge_d[l_ac].xrge007 = 'N'
            END IF
            #end add-point
            LET g_xrge_d_t.* = g_xrge_d[l_ac].*     #新輸入資料
            LET g_xrge_d_o.* = g_xrge_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axrt520_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL axrt520_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrge_d[li_reproduce_target].* = g_xrge_d[li_reproduce].*
 
               LET g_xrge_d[li_reproduce_target].xrgeseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xrge_t 
             WHERE xrgeent = g_enterprise AND xrgecomp = g_xrgd_m.xrgdcomp
               AND xrgedocno = g_xrgd_m.xrgddocno
               AND xrge900 = g_xrgd_m.xrgd900
 
               AND xrgeseq = g_xrge_d[l_ac].xrgeseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrgd_m.xrgdcomp
               LET gs_keys[2] = g_xrgd_m.xrgddocno
               LET gs_keys[3] = g_xrgd_m.xrgd900
               LET gs_keys[4] = g_xrge_d[g_detail_idx].xrgeseq
               CALL axrt520_insert_b('xrge_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xrge_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrge_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt520_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               IF NOT axrt520_xrge_ins_xrgh(g_xrge_d[l_ac].*)THEN
                  LET g_xrge_d[l_ac].* = g_xrge_d_t.*
                  CALL s_transaction_end('N','0')                    
               END IF
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
               LET gs_keys[01] = g_xrgd_m.xrgdcomp
               LET gs_keys[gs_keys.getLength()+1] = g_xrgd_m.xrgddocno
               LET gs_keys[gs_keys.getLength()+1] = g_xrgd_m.xrgd900
 
               LET gs_keys[gs_keys.getLength()+1] = g_xrge_d_t.xrgeseq
 
            
               #刪除同層單身
               IF NOT axrt520_delete_b('xrge_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt520_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axrt520_key_delete_b(gs_keys,'xrge_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt520_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axrt520_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xrge_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xrge_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgeseq
            #add-point:BEFORE FIELD xrgeseq name="input.b.page1.xrgeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgeseq
            
            #add-point:AFTER FIELD xrgeseq name="input.a.page1.xrgeseq"
            # NO ENTRY
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgeseq
            #add-point:ON CHANGE xrgeseq name="input.g.page1.xrgeseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrgeorga
            
            #add-point:AFTER FIELD xrgeorga name="input.a.page1.xrgeorga"
            LET g_xrge_d[l_ac].xrgeorga_desc = ''
            DISPLAY BY NAME g_xrge_d[l_ac].xrgeorga_desc
            LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014 = 'Y'
            #來源組織
            IF NOT cl_null(g_xrge_d[l_ac].xrgeorga) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xrge_d[l_ac].xrgeorga != g_xrge_d_t.xrgeorga OR g_xrge_d_t.xrgeorga IS NULL )) THEN #170119-00024#10 mark
               IF g_xrge_d[l_ac].xrgeorga != g_xrge_d_o.xrgeorga OR cl_null(g_xrge_d_o.xrgeorga) THEN #170119-00024#10 add               
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrge_d[l_ac].xrgeorga
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #LET g_xrge_d[l_ac].xrgeorga = g_xrge_d_t.xrgeorga #170119-00024#10 mark
                     LET g_xrge_d[l_ac].xrgeorga = g_xrge_d_o.xrgeorga  #170119-00024#10 add
                     LET g_xrge_d[l_ac].xrgeorga_desc = s_desc_get_department_desc(g_xrge_d[l_ac].xrgeorga)
                     DISPLAY BY NAME g_xrge_d[l_ac].xrgeorga_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aap_apcborga_chk(l_ld,g_xrgd_m.xrgddocno,g_xrge_d[l_ac].xrgeorga,g_wc_apgborga) 
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_xrge_d[l_ac].xrgeorga = g_xrge_d_t.xrgeorga #170119-00024#10 mark
                     LET g_xrge_d[l_ac].xrgeorga = g_xrge_d_o.xrgeorga  #170119-00024#10 add
                     LET g_xrge_d[l_ac].xrgeorga_desc = s_desc_get_department_desc(g_xrge_d[l_ac].xrgeorga)
                     DISPLAY BY NAME g_xrge_d[l_ac].xrgeorga_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_fin_orga_get_comp_ld(g_xrge_d[l_ac].xrgeorga) RETURNING g_sub_success,g_errno,l_comp,l_ld
                  IF l_comp <> g_xrgd_m.xrgdcomp THEN
                     LET g_errparam.code = 'axc-00112'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_xrge_d[l_ac].xrgeorga = g_xrge_d_t.xrgeorga #170119-00024#10 mark
                     LET g_xrge_d[l_ac].xrgeorga = g_xrge_d_o.xrgeorga  #170119-00024#10 add
                     LET g_xrge_d[l_ac].xrgeorga_desc = s_desc_get_department_desc(g_xrge_d[l_ac].xrgeorga)
                     DISPLAY BY NAME g_xrge_d[l_ac].xrgeorga_desc
                     NEXT FIELD CURRENT
                  END IF                  
               END IF  
            END IF  
            LET g_xrge_d[l_ac].xrgeorga_desc = s_desc_get_department_desc(g_xrge_d[l_ac].xrgeorga)
            DISPLAY BY NAME g_xrge_d[l_ac].xrgeorga_desc 
            LET g_xrge_d_o.* = g_xrge_d[l_ac].*  #170119-00024#10 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrgeorga
            #add-point:BEFORE FIELD xrgeorga name="input.b.page1.xrgeorga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrgeorga
            #add-point:ON CHANGE xrgeorga name="input.g.page1.xrgeorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge001
            #add-point:BEFORE FIELD xrge001 name="input.b.page1.xrge001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge001
            
            #add-point:AFTER FIELD xrge001 name="input.a.page1.xrge001"
            LET l_ld = NULL
            SELECT glaald INTO l_ld
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_xrge_d[l_ac].xrge001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrge_d[l_ac].xrge001 != g_xrge_d_t.xrge001 OR g_xrge_d_t.xrge001 IS NULL )) THEN #170119-00024#10 mark
               IF g_xrge_d[l_ac].xrge001 != g_xrge_d_o.xrge001 OR cl_null(g_xrge_d_o.xrge001) THEN  #170119-00024#10 add
                  CALL axrt520_xrge001_002_chk(g_xrge_d[l_ac].xrgeorga,g_xrgd_m.xrgd004,g_xrge_d[l_ac].xrge001,g_xrge_d[l_ac].xrge002)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_xrge_d[l_ac].xrge001 = g_xrge_d_t.xrge001 #170119-00024#10 mark
                     #LET g_xrge_d[l_ac].xrge002 = g_xrge_d_t.xrge002 #170119-00024#10 mark
                     LET g_xrge_d[l_ac].xrge001 = g_xrge_d_o.xrge001  #170119-00024#10 add
                     LET g_xrge_d[l_ac].xrge002 = g_xrge_d_o.xrge002  #170119-00024#10 add
                     CALL axrt520_set_no_entry_b(p_cmd)
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_xrge_d[l_ac].xrge002)THEN
                     CALL axrt520_xrge001_002_carry(l_ac)
                  END IF
               END IF
            END IF
            CALL axrt520_set_no_entry_b(p_cmd)
            LET g_xrge_d_o.* = g_xrge_d[l_ac].*  #170119-00024#10 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge001
            #add-point:ON CHANGE xrge001 name="input.g.page1.xrge001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge002
            #add-point:BEFORE FIELD xrge002 name="input.b.page1.xrge002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge002
            
            #add-point:AFTER FIELD xrge002 name="input.a.page1.xrge002"
            LET l_ld = NULL
            SELECT glaald INTO l_ld
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_xrge_d[l_ac].xrge002) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrge_d[l_ac].xrge002 != g_xrge_d_t.xrge002 OR g_xrge_d_t.xrge002 IS NULL )) THEN #170119-00024#10 mark
               IF g_xrge_d[l_ac].xrge002 != g_xrge_d_o.xrge002 OR cl_null(g_xrge_d_o.xrge002) THEN #170119-00024#10 add
                  CALL axrt520_xrge001_002_chk(g_xrge_d[l_ac].xrgeorga,g_xrgd_m.xrgd004,g_xrge_d[l_ac].xrge001,g_xrge_d[l_ac].xrge002)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_xrge_d[l_ac].xrge002 = g_xrge_d_t.xrge002 #170119-00024#10 mark
                     #LET g_xrge_d[l_ac].xrge001 = g_xrge_d_t.xrge001 #170119-00024#10 mark
                     LET g_xrge_d[l_ac].xrge002 = g_xrge_d_o.xrge002  #170119-00024#10 add
                     LET g_xrge_d[l_ac].xrge001 = g_xrge_d_o.xrge001  #170119-00024#10 add
                     CALL axrt520_set_no_entry(p_cmd)
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_xrge_d[l_ac].xrge001)THEN
                     CALL axrt520_xrge001_002_carry(l_ac)
                  END IF
               END IF
            END IF
            CALL axrt520_set_no_entry(p_cmd)
            LET g_xrge_d_o.* = g_xrge_d[l_ac].*  #170119-00024#10 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge002
            #add-point:ON CHANGE xrge002 name="input.g.page1.xrge002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge003
            #add-point:BEFORE FIELD xrge003 name="input.b.page1.xrge003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge003
            
            #add-point:AFTER FIELD xrge003 name="input.a.page1.xrge003"
            IF g_xrge_d[l_ac].xrge003 != g_xrge_d_o.xrge003 OR cl_null(g_xrge_d_o.xrge003) THEN #170119-00024#10 add
               #161111-00049#10 Add  ---(S)---
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_xrgd_m.xrgdcomp
               LET g_chkparam.arg2 = g_xrge_d[l_ac].xrge003
               IF NOT cl_chk_exist("v_imaf001_3") THEN
                  #LET g_xrgd_m.xrgddocno = '' #170119-00024#10 mark
                  LET g_xrgd_m.xrgddocno = g_xrgd_m_o.xrgddocno #170119-00024#10 add
                  LET g_xrge_d[l_ac].xrge003 = g_xrge_d_o.xrge003  #170119-00024#10 add
                  NEXT FIELD CURRENT
               END IF
               IF NOT s_control_check_item(g_xrge_d[l_ac].xrge003,'2',g_xrgd_m.xrgdcomp,g_user,g_dept,'') THEN
                  #LET g_xrge_d[l_ac].xrge003 = g_xrge_d_t.xrge003 #170119-00024#10 mark
                  LET g_xrge_d[l_ac].xrge003 = g_xrge_d_o.xrge003  #170119-00024#10 add
                  NEXT FIELD CURRENT
		    	   END IF
               #161111-00049#10 Add  ---(E)---
            END IF #170119-00024#10   
            LET g_xrge_d_o.* = g_xrge_d[l_ac].*  #170119-00024#10 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge003
            #add-point:ON CHANGE xrge003 name="input.g.page1.xrge003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge004
            #add-point:BEFORE FIELD xrge004 name="input.b.page1.xrge004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge004
            
            #add-point:AFTER FIELD xrge004 name="input.a.page1.xrge004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge004
            #add-point:ON CHANGE xrge004 name="input.g.page1.xrge004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge005
            #add-point:BEFORE FIELD xrge005 name="input.b.page1.xrge005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge005
            
            #add-point:AFTER FIELD xrge005 name="input.a.page1.xrge005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge005
            #add-point:ON CHANGE xrge005 name="input.g.page1.xrge005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge008
            #add-point:BEFORE FIELD xrge008 name="input.b.page1.xrge008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge008
            
            #add-point:AFTER FIELD xrge008 name="input.a.page1.xrge008"
            IF NOT cl_ap_chk_range(g_xrge_d[l_ac].xrge008,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xrge008
            END IF 
            
            LET l_ld = NULL   LET l_glaa001 = NULL
            SELECT glaald ,glaa001
              INTO l_ld ,l_glaa001
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014  = 'Y'
            IF NOT cl_null(g_xrge_d[l_ac].xrge008)THEN
               IF cl_null(g_xrge_d_o.xrge008) OR (g_xrge_d_o.xrge008 <> g_xrge_d[l_ac].xrge008)THEN
                  IF NOT cl_null(g_xrge_d[l_ac].xrge001) AND NOT cl_null(g_xrge_d[l_ac].xrge002)THEN
                     LET l_xmdc011 = NULL    LET l_xrge008 =NULL
                     SELECT xmdc011 INTO l_xmdc011 FROM xmdc_t
                      WHERE xmdcent = g_enterprise
                        AND xmdcdocno = g_xrge_d[l_ac].xrge001
                        AND xmdcseq   = g_xrge_d[l_ac].xrge002
                     IF cl_null(l_xmdc011)THEN LET l_xmdc011 = 0 END IF
                     
                     SELECT SUM(xrge008) INTO l_xrge008 FROM xrge_t,xrgd_t
                      WHERE xrgeent = g_enterprise
                        AND xrgedocno <> g_xrge_m.xrgedocno
                        AND xrgecomp <> g_xrge_m.xrgecomp
                        AND xrge001 = g_xrge_d[l_ac].xrge001
                        AND xrge002 = g_xrge_d[l_ac].xrge002
                        AND xrgeent = xrgdent
                        AND xrgedocno = xrgddocno
                        AND xrgecomp = xrgdcomp
                        AND xrgdstus <> 'X'
                     
                     IF cl_null(l_xrge008)THEN LET l_xrge008 = 0 END IF
                     
                     IF (l_xmdc011 - l_xrge008 - g_xrge_d[l_ac].xrge008) < 0 THEN
                        INITIALIZE g_errparam.* TO NULL
                        LET g_errparam.code = ''
                        LET g_errparam.popup = TRUE
                        LET g_errparam.extend = ''
                        CALL cl_err()
                        LET g_xrge_d[l_ac].xrge008 = g_xrge_d_o.xrge008
                        DISPLAY BY NAME g_xrge_d[l_ac].xrge008
                        NEXT FIELD xrge008
                     END IF
                  END IF  
                  LET g_xrge_d[l_ac].xrge105 = '' #170119-00024#10 add
                  #原幣含稅金額
                  LET g_xrge_d[l_ac].xrge105 = g_xrge_d[l_ac].xrge008 * g_xrge_d[l_ac].xrge009
                  #取位(原幣)
                  CALL s_curr_round_ld('1',l_ld,g_xrgd_m.xrgd100,g_xrge_d[l_ac].xrge105,2) RETURNING g_sub_success,g_errno,g_xrge_d[l_ac].xrge105
                  LET g_xrge_d[l_ac].xrge115 = '' #170119-00024#10 add
                  #本幣含稅金額
                  LET g_xrge_d[l_ac].xrge115 = g_xrge_d[l_ac].xrge105 * g_xrge_d[l_ac].xrge101
                  #取位(本幣)
                  CALL s_curr_round_ld('1',l_ld,l_glaa001,g_xrge_d[l_ac].xrge115,2) RETURNING g_sub_success,g_errno,g_xrge_d[l_ac].xrge115
                    
                  DISPLAY BY NAME g_xrge_d[l_ac].xrge105,g_xrge_d[l_ac].xrge008,g_xrge_d[l_ac].xrge115                    
               END IF
            END IF
            
            CALL axrt520_to_o_b1(l_ac)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge008
            #add-point:ON CHANGE xrge008 name="input.g.page1.xrge008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge006
            #add-point:BEFORE FIELD xrge006 name="input.b.page1.xrge006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge006
            
            #add-point:AFTER FIELD xrge006 name="input.a.page1.xrge006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge006
            #add-point:ON CHANGE xrge006 name="input.g.page1.xrge006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge007
            #add-point:BEFORE FIELD xrge007 name="input.b.page1.xrge007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge007
            
            #add-point:AFTER FIELD xrge007 name="input.a.page1.xrge007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge007
            #add-point:ON CHANGE xrge007 name="input.g.page1.xrge007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge100
            #add-point:BEFORE FIELD xrge100 name="input.b.page1.xrge100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge100
            
            #add-point:AFTER FIELD xrge100 name="input.a.page1.xrge100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge100
            #add-point:ON CHANGE xrge100 name="input.g.page1.xrge100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge101
            #add-point:BEFORE FIELD xrge101 name="input.b.page1.xrge101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge101
            
            #add-point:AFTER FIELD xrge101 name="input.a.page1.xrge101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge101
            #add-point:ON CHANGE xrge101 name="input.g.page1.xrge101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge009
            #add-point:BEFORE FIELD xrge009 name="input.b.page1.xrge009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge009
            
            #add-point:AFTER FIELD xrge009 name="input.a.page1.xrge009"
            IF NOT cl_ap_chk_range(g_xrge_d[l_ac].xrge009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xrge009
            END IF 
            LET l_ld = NULL   LET l_glaa001 = NULL
            SELECT glaald ,glaa001
              INTO l_ld ,l_glaa001
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014  = 'Y'
            IF NOT cl_null(g_xrge_d[l_ac].xrge009)THEN
               IF cl_null(g_xrge_d_o.xrge009) OR (g_xrge_d_o.xrge009 <> g_xrge_d[l_ac].xrge009)THEN
                  LET g_xrge_d[l_ac].xrge105 = '' #170119-00024#10 add
                  #原幣含稅金額
                  LET g_xrge_d[l_ac].xrge105 = g_xrge_d[l_ac].xrge008 * g_xrge_d[l_ac].xrge009
                  #取位(原幣)
                  CALL s_curr_round_ld('1',l_ld,g_xrgd_m.xrgd100,g_xrge_d[l_ac].xrge105,2) RETURNING g_sub_success,g_errno,g_xrge_d[l_ac].xrge105
                  LET g_xrge_d[l_ac].xrge115 = '' #170119-00024#10 add
                  #本幣含稅金額
                  LET g_xrge_d[l_ac].xrge115 = g_xrge_d[l_ac].xrge105 * g_xrge_d[l_ac].xrge101
                  #取位(本幣)
                  CALL s_curr_round_ld('1',l_ld,l_glaa001,g_xrge_d[l_ac].xrge115,2) RETURNING g_sub_success,g_errno,g_xrge_d[l_ac].xrge115
                    
                  DISPLAY BY NAME g_xrge_d[l_ac].xrge105,g_xrge_d[l_ac].xrge008,g_xrge_d[l_ac].xrge115                    
               END IF
            END IF
            CALL axrt520_to_o_b1(l_ac)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge009
            #add-point:ON CHANGE xrge009 name="input.g.page1.xrge009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge105
            #add-point:BEFORE FIELD xrge105 name="input.b.page1.xrge105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge105
            
            #add-point:AFTER FIELD xrge105 name="input.a.page1.xrge105"
            IF NOT cl_ap_chk_range(g_xrge_d[l_ac].xrge105,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xrge105
            END IF 
            
            LET l_ld = NULL   LET l_glaa001 = NULL
            SELECT glaald ,glaa001
              INTO l_ld ,l_glaa001
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014  = 'Y'
            IF NOT cl_null(g_xrge_d[l_ac].xrge105)THEN
               IF cl_null(g_xrge_d_o.xrge105) OR (g_xrge_d_o.xrge105 <> g_xrge_d[l_ac].xrge105)THEN
                  LET g_xrge_d[l_ac].xrge115 = '' #170119-00024#10 add
                  #本幣含稅金額
                  LET g_xrge_d[l_ac].xrge115 = g_xrge_d[l_ac].xrge105 * g_xrge_d[l_ac].xrge101
                  #取位(本幣)
                  CALL s_curr_round_ld('1',l_ld,l_glaa001,g_xrge_d[l_ac].xrge115,2) RETURNING g_sub_success,g_errno,g_xrge_d[l_ac].xrge115
                    
                  DISPLAY BY NAME g_xrge_d[l_ac].xrge105,g_xrge_d[l_ac].xrge008,g_xrge_d[l_ac].xrge115                    
               END IF
            END IF
            CALL axrt520_to_o_b1(l_ac)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge105
            #add-point:ON CHANGE xrge105 name="input.g.page1.xrge105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge115
            #add-point:BEFORE FIELD xrge115 name="input.b.page1.xrge115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge115
            
            #add-point:AFTER FIELD xrge115 name="input.a.page1.xrge115"
            IF NOT cl_ap_chk_range(g_xrge_d[l_ac].xrge115,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xrge115
            END IF 
            CALL axrt520_to_o_b1(l_ac)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge115
            #add-point:ON CHANGE xrge115 name="input.g.page1.xrge115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge901
            #add-point:BEFORE FIELD xrge901 name="input.b.page1.xrge901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge901
            
            #add-point:AFTER FIELD xrge901 name="input.a.page1.xrge901"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge901
            #add-point:ON CHANGE xrge901 name="input.g.page1.xrge901"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge902
            #add-point:BEFORE FIELD xrge902 name="input.b.page1.xrge902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge902
            
            #add-point:AFTER FIELD xrge902 name="input.a.page1.xrge902"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge902
            #add-point:ON CHANGE xrge902 name="input.g.page1.xrge902"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrge903
            #add-point:BEFORE FIELD xrge903 name="input.b.page1.xrge903"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrge903
            
            #add-point:AFTER FIELD xrge903 name="input.a.page1.xrge903"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrge903
            #add-point:ON CHANGE xrge903 name="input.g.page1.xrge903"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xrgeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgeseq
            #add-point:ON ACTION controlp INFIELD xrgeseq name="input.c.page1.xrgeseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrgeorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrgeorga
            #add-point:ON ACTION controlp INFIELD xrgeorga name="input.c.page1.xrgeorga"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrge_d[l_ac].xrgeorga
            LET g_qryparam.where    = "ooef001 IN ",g_wc_apgborga, " AND ooef017 ='",g_xrgd_m.xrgdcomp,"' "
            CALL q_ooef001()                                 
            LET g_xrge_d[l_ac].xrgeorga = g_qryparam.return1 
            LET g_xrge_d[l_ac].xrgeorga_desc = s_desc_get_department_desc(g_xrge_d[l_ac].xrgeorga)
            DISPLAY BY NAME g_xrge_d[l_ac].xrgeorga,g_xrge_d[l_ac].xrgeorga_desc
            NEXT FIELD xrgeorga
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge001
            #add-point:ON ACTION controlp INFIELD xrge001 name="input.c.page1.xrge001"
            #訂單單號+項次
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrge_d[l_ac].xrge001
            LET g_qryparam.default2 = g_xrge_d[l_ac].xrge002
            LET g_qryparam.where    = "xmda004 = '",g_xrgd_m.xrgd004,"' AND xmddsite = '",g_xrge_d[l_ac].xrgeorga,"' "
            CALL q_xmdadocno_13()                                 
            LET g_xrge_d[l_ac].xrge001 = g_qryparam.return1       
            LET g_xrge_d[l_ac].xrge002 = g_qryparam.return2
            DISPLAY BY NAME g_xrge_d[l_ac].xrge001,g_xrge_d[l_ac].xrge002
            NEXT FIELD xrge001
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge002
            #add-point:ON ACTION controlp INFIELD xrge002 name="input.c.page1.xrge002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge003
            #add-point:ON ACTION controlp INFIELD xrge003 name="input.c.page1.xrge003"
            #161111-00049#10 Add  ---(S)---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrge_d[l_ac].xrge003            #給予default值
         		  	   
            LET g_qryparam.arg1 = g_xrgd_m.xrgdcomp
            IF NOT cl_null(g_sql_ctrl2) AND NOT g_sql_ctrl2 = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl2
            END IF
            CALL q_imaf001_7()                #呼叫開窗
            LET g_xrge_d[l_ac].xrge003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xrge_d[l_ac].xrge003 TO xrge003              #顯示到畫面上
            NEXT FIELD xrge003                         #返回原欄位
		  	   #161111-00049#3 Add  ---(E)---
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge004
            #add-point:ON ACTION controlp INFIELD xrge004 name="input.c.page1.xrge004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge005
            #add-point:ON ACTION controlp INFIELD xrge005 name="input.c.page1.xrge005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge008
            #add-point:ON ACTION controlp INFIELD xrge008 name="input.c.page1.xrge008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge006
            #add-point:ON ACTION controlp INFIELD xrge006 name="input.c.page1.xrge006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge007
            #add-point:ON ACTION controlp INFIELD xrge007 name="input.c.page1.xrge007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge100
            #add-point:ON ACTION controlp INFIELD xrge100 name="input.c.page1.xrge100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge101
            #add-point:ON ACTION controlp INFIELD xrge101 name="input.c.page1.xrge101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge009
            #add-point:ON ACTION controlp INFIELD xrge009 name="input.c.page1.xrge009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge105
            #add-point:ON ACTION controlp INFIELD xrge105 name="input.c.page1.xrge105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge115
            #add-point:ON ACTION controlp INFIELD xrge115 name="input.c.page1.xrge115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge901
            #add-point:ON ACTION controlp INFIELD xrge901 name="input.c.page1.xrge901"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge902
            #add-point:ON ACTION controlp INFIELD xrge902 name="input.c.page1.xrge902"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrge903
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrge903
            #add-point:ON ACTION controlp INFIELD xrge903 name="input.c.page1.xrge903"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xrge_d[l_ac].* = g_xrge_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axrt520_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xrge_d[l_ac].xrgeseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xrge_d[l_ac].* = g_xrge_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               LET l_count = NULL
               SELECT COUNT(*) INTO l_count FROM xrgb_t
                WHERE xrgbent = g_enterprise
                  AND xrgbcomp = g_xrgd_m.xrgdcomp
                  AND xrgbdocno = g_xrgd_m.xrgddocno
                  AND xrgbseq   = g_xrge_d[l_ac].xrgeseq
               IF cl_null(l_count)THEN LET l_count = 0 END IF
               IF l_count = 0 THEN
                  LET g_xrge_d[l_ac].xrge901 = '3'
               ELSE
                  LET g_xrge_d[l_ac].xrge901 = '2'
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axrt520_xrge_t_mask_restore('restore_mask_o')
      
               UPDATE xrge_t SET (xrgecomp,xrgedocno,xrge900,xrgeseq,xrgeorga,xrge001,xrge002,xrge003, 
                   xrge004,xrge005,xrge008,xrge006,xrge007,xrge100,xrge101,xrge009,xrge105,xrge115,xrge901, 
                   xrge902,xrge903) = (g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrge_d[l_ac].xrgeseq, 
                   g_xrge_d[l_ac].xrgeorga,g_xrge_d[l_ac].xrge001,g_xrge_d[l_ac].xrge002,g_xrge_d[l_ac].xrge003, 
                   g_xrge_d[l_ac].xrge004,g_xrge_d[l_ac].xrge005,g_xrge_d[l_ac].xrge008,g_xrge_d[l_ac].xrge006, 
                   g_xrge_d[l_ac].xrge007,g_xrge_d[l_ac].xrge100,g_xrge_d[l_ac].xrge101,g_xrge_d[l_ac].xrge009, 
                   g_xrge_d[l_ac].xrge105,g_xrge_d[l_ac].xrge115,g_xrge_d[l_ac].xrge901,g_xrge_d[l_ac].xrge902, 
                   g_xrge_d[l_ac].xrge903)
                WHERE xrgeent = g_enterprise AND xrgecomp = g_xrgd_m.xrgdcomp 
                  AND xrgedocno = g_xrgd_m.xrgddocno 
                  AND xrge900 = g_xrgd_m.xrgd900 
 
                  AND xrgeseq = g_xrge_d_t.xrgeseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xrge_d[l_ac].* = g_xrge_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrge_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xrge_d[l_ac].* = g_xrge_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrge_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrgd_m.xrgdcomp
               LET gs_keys_bak[1] = g_xrgdcomp_t
               LET gs_keys[2] = g_xrgd_m.xrgddocno
               LET gs_keys_bak[2] = g_xrgddocno_t
               LET gs_keys[3] = g_xrgd_m.xrgd900
               LET gs_keys_bak[3] = g_xrgd900_t
               LET gs_keys[4] = g_xrge_d[g_detail_idx].xrgeseq
               LET gs_keys_bak[4] = g_xrge_d_t.xrgeseq
               CALL axrt520_update_b('xrge_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axrt520_xrge_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xrge_d[g_detail_idx].xrgeseq = g_xrge_d_t.xrgeseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xrgd_m.xrgdcomp
                  LET gs_keys[gs_keys.getLength()+1] = g_xrgd_m.xrgddocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xrgd_m.xrgd900
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xrge_d_t.xrgeseq
 
                  CALL axrt520_key_update_b(gs_keys,'xrge_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xrgd_m),util.JSON.stringify(g_xrge_d_t)
               LET g_log2 = util.JSON.stringify(g_xrgd_m),util.JSON.stringify(g_xrge_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF NOT axrt520_xrge_ins_xrgh(g_xrge_d[l_ac].*)THEN
                  LET g_xrge_d[l_ac].* = g_xrge_d_t.*
                  CALL s_transaction_end('N','0')                    
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL axrt520_unlock_b("xrge_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            #151008-00010#18 mark-----s
            #LET l_xrgdsum = NULL   LET l_xrgesum = NULL
            #SELECT xrgd103 INTO l_xrgdsum FROM xrgd_t
            # WHERE xrgdent = g_enterprise
            #   AND xrgdcomp = g_xrgd_m.xrgdcomp
            #   AND xrgddocno = g_xrgd_m.xrgddocno
            #   AND xrgd900   = g_xrgd_m.xrgd900
            #IF cl_null(l_xrgdsum)THEN LET l_xrgdsum = 0 END IF
            #
            #SELECT SUM(xrge105)INTO l_xrgesum FROM xrge_t
            # WHERE xrgeent = g_enterprise
            #   AND xrgecomp = g_xrgd_m.xrgdcomp
            #   AND xrgedocno = g_xrgd_m.xrgddocno
            #   AND xrge900   = g_xrgd_m.xrgd900
            #IF cl_null(l_xrgesum)THEN LET l_xrgesum = 0 END IF
            #
            #IF l_xrgesum <> l_xrgdsum THEN
            #   IF cl_ask_confirm('aap-00528')THEN
            #      LET g_xrgd_m.xrgd103 = l_xrgesum
            #      #113=103*101
            #      IF cl_null(g_xrgd_m.xrgd103)THEN LET g_xrgd_m.xrgd103 = 0 END IF
            #      IF cl_null(g_xrgd_m.xrgd101)THEN LET g_xrgd_m.xrgd101 = 0 END IF  
            #      LET g_xrgd_m.xrgd113 = g_xrgd_m.xrgd103 * g_xrgd_m.xrgd101
            #      #本幣取位
            #      CALL s_curr_round_ld('1',l_ld,l_glaa001,g_xrgd_m.xrgd113,2) RETURNING g_sub_success,g_errno,g_xrgd_m.xrgd113
            #      DISPLAY BY NAME g_xrgd_m.xrgd113
            #      UPDATE xrgd_t SET xrgd113 = g_xrgd_m.xrgd113,
            #                        xrgd103 = g_xrgd_m.xrgd103
            #       WHERE xrgdent = g_enterprise
            #         AND xrgdcomp = g_xrgd_m.xrgdcomp
            #         AND xrgddocno = g_xrgd_m.xrgddocno
            #         AND xrgd900   = g_xrgd_m.xrgd900
            #   END IF
            #END IF
            #151008-00010#18 mark-----e
            #151008-00010#18-----s
            #後續aapt510有修改規格因此要依aapt510多幣別判斷及處理邏輯重新判斷
            
            #先判斷是否有非單頭原幣的單身
            LET l_count = NULL
            SELECT COUNT(*) INTO l_count FROM xrgb_t
             WHERE xrgeent = g_enterprise
               AND xrgecomp = g_xrgd_m.xrgdcomp
               AND xrgedocno = g_xrgd_m.xrgddocno
               AND xrge100   <> g_xrgd_m.xrgd100
               AND xrge900   = g_xrgd_m.xrgd900
            IF cl_null(l_count)THEN LET l_count = 0 END IF            
            IF l_count = 0 THEN
               LET l_xrgdsum = NULL   LET l_xrgesum = NULL
               SELECT xrgd103 INTO l_xrgdsum FROM xrgd_t
                WHERE xrgdent = g_enterprise
                  AND xrgdcomp = g_xrgd_m.xrgdcomp
                  AND xrgddocno = g_xrgd_m.xrgddocno
                  AND xrgd900   = g_xrgd_m.xrgd900
               IF cl_null(l_xrgdsum)THEN LET l_xrgdsum = 0 END IF
               
               SELECT SUM(xrge105)INTO l_xrgesum FROM xrge_t
                WHERE xrgeent = g_enterprise
                  AND xrgecomp = g_xrgd_m.xrgdcomp
                  AND xrgedocno = g_xrgd_m.xrgddocno
                  AND xrge900   = g_xrgd_m.xrgd900
               IF cl_null(l_xrgesum)THEN LET l_xrgesum = 0 END IF
               
               IF l_xrgesum <> l_xrgdsum THEN
                  IF cl_ask_confirm('aap-00528')THEN
                     LET g_xrgd_m.xrgd103 = l_xrgesum
                     #113=103*101
                     IF cl_null(g_xrgd_m.xrgd103)THEN LET g_xrgd_m.xrgd103 = 0 END IF
                     IF cl_null(g_xrgd_m.xrgd101)THEN LET g_xrgd_m.xrgd101 = 0 END IF  
                     LET g_xrgd_m.xrgd113 = g_xrgd_m.xrgd103 * g_xrgd_m.xrgd101
                     #本幣取位
                     CALL s_curr_round_ld('1',l_ld,l_glaa001,g_xrgd_m.xrgd113,2) RETURNING g_sub_success,g_errno,g_xrgd_m.xrgd113
                     DISPLAY BY NAME g_xrgd_m.xrgd113
                     UPDATE xrgd_t SET xrgd113 = g_xrgd_m.xrgd113,
                                       xrgd103 = g_xrgd_m.xrgd103
                      WHERE xrgdent = g_enterprise
                        AND xrgdcomp = g_xrgd_m.xrgdcomp
                        AND xrgddocno = g_xrgd_m.xrgddocno
                        AND xrgd900   = g_xrgd_m.xrgd900
                  END IF
               END IF        
            ELSE
               LET l_xrgdsum = NULL   LET l_xrgesum = NULL
               SELECT xrgd113 INTO l_xrgdsum FROM xrgd_t
                WHERE xrgdent = g_enterprise
                  AND xrgdcomp = g_xrgd_m.xrgdcomp
                  AND xrgddocno = g_xrgd_m.xrgddocno
                  AND xrgd900   = g_xrgd_m.xrgd900
               IF cl_null(l_xrgdsum)THEN LET l_xrgdsum = 0 END IF
               
               SELECT SUM(xrge115)INTO l_xrgesum FROM xrge_t
                WHERE xrgeent = g_enterprise
                  AND xrgecomp = g_xrgd_m.xrgdcomp
                  AND xrgedocno = g_xrgd_m.xrgddocno
                  AND xrge900   = g_xrgd_m.xrgd900
               IF cl_null(l_xrgesum)THEN LET l_xrgesum = 0 END IF
               
               IF l_xrgesum <> l_xrgdsum THEN
                  IF cl_ask_confirm('aap-00528')THEN
                     LET g_xrgd_m.xrgd113 = l_xrgesum
                     #113=103*101
                     IF cl_null(g_xrgd_m.xrgd113)THEN LET g_xrgd_m.xrgd113 = 0 END IF
                     IF cl_null(g_xrgd_m.xrgd101)THEN LET g_xrgd_m.xrgd101 = 1 END IF  
                     LET g_xrgd_m.xrgd103 = g_xrgd_m.xrgd113 / g_xrgd_m.xrgd101
                     #本幣取位
                     CALL s_curr_round_ld('1',l_ld,g_xrgd_m.xrgd100,g_xrgd_m.xrgd103,2) RETURNING g_sub_success,g_errno,g_xrgd_m.xrgd103
                     DISPLAY BY NAME g_xrgd_m.xrgd113
                     UPDATE xrgd_t SET xrgd113 = g_xrgd_m.xrgd113,
                                       xrgd103 = g_xrgd_m.xrgd103
                      WHERE xrgdent = g_enterprise
                        AND xrgdcomp = g_xrgd_m.xrgdcomp
                        AND xrgddocno = g_xrgd_m.xrgddocno
                        AND xrgd900   = g_xrgd_m.xrgd900
                  END IF
               END IF            
            END IF            
            #151008-00010#18-----e
            CALL axrt520_xrgd_ins_xrgh()
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xrge_d[li_reproduce_target].* = g_xrge_d[li_reproduce].*
 
               LET g_xrge_d[li_reproduce_target].xrgeseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrge_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrge_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_xrge2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xrge2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axrt520_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xrge2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            #albireo 160728-----s
            #點入單身時已有單身資訊
            LET l_count = NULL
            SELECT COUNT(*) INTO l_count FROM xrge_t
             WHERE xrgeent   = g_enterprise
               AND xrgecomp  = g_xrgd_m.xrgdcomp
               AND xrgedocno = g_xrgd_m.xrgddocno
               AND xrge900   = g_xrgd_m.xrgd900
            IF cl_null(l_count)THEN LET l_count = 0 END IF

            IF l_count > 0 THEN
               #判斷是否有任意單身有訂單變更單且變更日大於申請日
               LET l_count = NULL
               SELECT COUNT(*) INTO l_count FROM xrge_t,xrgd_t
                WHERE xrgeent   = g_enterprise
                  AND xrgecomp  = g_xrgd_m.xrgdcomp
                  AND xrgedocno = g_xrgd_m.xrgddocno
                  AND xrge900   = g_xrgd_m.xrgd900  
                  AND xrgecomp  = xrgdcomp
                  AND xrgedocno = xrgddocno
                  AND xrgeent   = xrgdent
                  AND xrge900   = xrgd900
                  AND EXISTS(SELECT 1 FROM xmee_t WHERE xmeeent = xrgeent AND xmee902 >= xrgd003
                                AND xmeedocno = xrge001 AND xmeestus = 'Y')
               IF cl_null(l_count)THEN LET l_count = 0 END IF
               
               IF l_count > 0 THEN
                  IF cl_ask_confirm('axr-01030') THEN
                     CALL s_transaction_begin()
                     CALL cl_err_collect_init()
                     CALL axrt520_reins_xrge()RETURNING g_sub_success
                     CALL axrt520_b_fill()                     
                     FOR l_i = 1 TO g_xrge_d.getLength()
                        CALL axrt520_xrge_ins_xrgh(g_xrge_d[l_i].*)RETURNING g_sub_success
                     END FOR                      
                     CALL s_transaction_end('Y','0')
                     CALL cl_err_collect_init()
                     CALL cl_err_collect_show()
                     CALL axrt520_b_fill()   
                  END IF
               END IF
            END IF
            #albireo 160728-----e
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrge2_d[l_ac].* TO NULL 
            INITIALIZE g_xrge2_d_t.* TO NULL 
            INITIALIZE g_xrge2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_xrge2_d[l_ac].apgcseq = "0"
      LET g_xrge2_d[l_ac].apgc101 = "0"
      LET g_xrge2_d[l_ac].apgc103 = "0"
      LET g_xrge2_d[l_ac].apgc104 = "0"
      LET g_xrge2_d[l_ac].apgc105 = "0"
      LET g_xrge2_d[l_ac].apgc113 = "0"
      LET g_xrge2_d[l_ac].apgc114 = "0"
      LET g_xrge2_d[l_ac].apgc115 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            SELECT MAX(apgcseq)+1 INTO g_xrge2_d[l_ac].apgcseq 
              FROM apgc_t
             WHERE apgcent = g_enterprise
               AND apgccomp = g_xrgd_m.xrgdcomp
               AND apgcdocno = g_xrgd_m.xrgddocno
               AND apgc900 = g_xrgd_m.xrgd900
            IF cl_null(g_xrge2_d[l_ac].apgcseq)THEN LET g_xrge2_d[l_ac].apgcseq = 1 END IF
            
            #預設g_site
            #法人比對單頭法人
            #檢核是否為法人下組織   #用8營運中心展
            #下展組織與權限也要符合才可帶出
            LET g_xrge2_d[l_ac].apgcorga = g_site
            LET l_sql = "SELECT COUNT(*) FROM ooef_t ",
                        " WHERE ooefent = ",g_enterprise," ",
                        "   AND ooef001 = '",g_xrge2_d[l_ac].apgcorga,"' ",
                        "   AND ooef017 = '",g_xrgd_m.xrgdcomp,"' ",
                        "   AND ooef001 IN ",g_wc_apgborga,
                        "   AND ooefstus = 'Y' "
            PREPARE sel_ooefp3 FROM l_sql
            LET l_count = NULL
            EXECUTE sel_ooefp3 INTO l_count 
            IF cl_null(l_count)THEN LET l_count = 0 END IF
            IF l_count = 0 THEN
               LET g_xrge2_d[l_ac].apgcorga = ''
            END IF            
            
            LET l_pmab037 = NULL LET l_pmab055 = NULL
            LET l_pmab034 = NULL LET l_pmab056 = NULL
            #SELECT pmab037,pmab055,pmab034,pmab056
            #  INTO l_pmab037,l_pmab055,l_pmab034,l_pmab056
            #  FROM pmab_t
            # WHERE pmabent = g_enterprise
            #   AND pmabsite = g_xrgd_m.xrgdcomp
            #   AND pmab001 = g_xrgd_m.xrgd004
            #160926-00018#1-----s
            CALL s_apmm101_sel_pmab(g_xrgd_m.xrgdcomp,g_xrgd_m.xrgd004,'pmab037|pmab055|pmab034|pmab056')
               RETURNING g_sub_success,g_errno,l_pmab037,l_pmab055,l_pmab034,l_pmab056            
            #160926-00018#1-----e
            LET g_xrge2_d[l_ac].apgc002 = g_xrgd_m.xrgd004
            LET g_xrge2_d[l_ac].apgc003 = l_pmab037   #預帶對象主要付款條件 pmab037
            LET g_xrge2_d[l_ac].apgc005 = l_pmab055   #慣用帳款類別 pmab055
            LET g_xrge2_d[l_ac].apgc006 = l_pmab034   #預帶交易對象慣用稅別  pmab034
            LET g_xrge2_d[l_ac].apgc007 = l_pmab056   #慣用發票類型 pmab056
            
            LET g_xrge2_d[l_ac].apgc100 = g_xrgd_m.xrgd100
            LET g_xrge2_d[l_ac].apgc101 = g_xrgd_m.xrgd101
            LET g_xrge2_d[l_ac].apgc013 = 'axrt520'    
            #end add-point
            LET g_xrge2_d_t.* = g_xrge2_d[l_ac].*     #新輸入資料
            LET g_xrge2_d_o.* = g_xrge2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axrt520_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL axrt520_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrge2_d[li_reproduce_target].* = g_xrge2_d[li_reproduce].*
 
               LET g_xrge2_d[li_reproduce_target].apgcseq = NULL
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
            OPEN axrt520_cl USING g_enterprise,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axrt520_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axrt520_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xrge2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xrge2_d[l_ac].apgcseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xrge2_d_t.* = g_xrge2_d[l_ac].*  #BACKUP
               LET g_xrge2_d_o.* = g_xrge2_d[l_ac].*  #BACKUP
               CALL axrt520_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL axrt520_set_no_entry_b(l_cmd)
               IF NOT axrt520_lock_b("apgc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt520_bcl2 INTO g_xrge2_d[l_ac].apgcseq,g_xrge2_d[l_ac].apgcorga,g_xrge2_d[l_ac].apgc001, 
                      g_xrge2_d[l_ac].apgc002,g_xrge2_d[l_ac].apgc003,g_xrge2_d[l_ac].apgc005,g_xrge2_d[l_ac].apgc014, 
                      g_xrge2_d[l_ac].apgc100,g_xrge2_d[l_ac].apgc101,g_xrge2_d[l_ac].apgc006,g_xrge2_d[l_ac].apgc007, 
                      g_xrge2_d[l_ac].apgc008,g_xrge2_d[l_ac].apgc009,g_xrge2_d[l_ac].apgc010,g_xrge2_d[l_ac].apgc011, 
                      g_xrge2_d[l_ac].apgc103,g_xrge2_d[l_ac].apgc104,g_xrge2_d[l_ac].apgc105,g_xrge2_d[l_ac].apgc113, 
                      g_xrge2_d[l_ac].apgc114,g_xrge2_d[l_ac].apgc115,g_xrge2_d[l_ac].apgc004,g_xrge2_d[l_ac].apgc015, 
                      g_xrge2_d[l_ac].apgc016,g_xrge2_d[l_ac].apgc012,g_xrge2_d[l_ac].apgc013
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrge2_d_mask_o[l_ac].* =  g_xrge2_d[l_ac].*
                  CALL axrt520_apgc_t_mask()
                  LET g_xrge2_d_mask_n[l_ac].* =  g_xrge2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axrt520_show()
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
               LET gs_keys[01] = g_xrgd_m.xrgdcomp
               LET gs_keys[gs_keys.getLength()+1] = g_xrgd_m.xrgddocno
               LET gs_keys[gs_keys.getLength()+1] = g_xrgd_m.xrgd900
               LET gs_keys[gs_keys.getLength()+1] = g_xrge2_d_t.apgcseq
            
               #刪除同層單身
               IF NOT axrt520_delete_b('apgc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt520_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axrt520_key_delete_b(gs_keys,'apgc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt520_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axrt520_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_xrge_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xrge2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM apgc_t 
             WHERE apgcent = g_enterprise AND apgccomp = g_xrgd_m.xrgdcomp
               AND apgcdocno = g_xrgd_m.xrgddocno
               AND apgc900 = g_xrgd_m.xrgd900
               AND apgcseq = g_xrge2_d[l_ac].apgcseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrgd_m.xrgdcomp
               LET gs_keys[2] = g_xrgd_m.xrgddocno
               LET gs_keys[3] = g_xrgd_m.xrgd900
               LET gs_keys[4] = g_xrge2_d[g_detail_idx].apgcseq
               CALL axrt520_insert_b('apgc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xrge_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt520_b_fill()
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
               LET g_xrge2_d[l_ac].* = g_xrge2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axrt520_bcl2
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
               LET g_xrge2_d[l_ac].* = g_xrge2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL axrt520_apgc_t_mask_restore('restore_mask_o')
                              
               UPDATE apgc_t SET (apgccomp,apgcdocno,apgc900,apgcseq,apgcorga,apgc001,apgc002,apgc003, 
                   apgc005,apgc014,apgc100,apgc101,apgc006,apgc007,apgc008,apgc009,apgc010,apgc011,apgc103, 
                   apgc104,apgc105,apgc113,apgc114,apgc115,apgc004,apgc015,apgc016,apgc012,apgc013) = (g_xrgd_m.xrgdcomp, 
                   g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrge2_d[l_ac].apgcseq,g_xrge2_d[l_ac].apgcorga, 
                   g_xrge2_d[l_ac].apgc001,g_xrge2_d[l_ac].apgc002,g_xrge2_d[l_ac].apgc003,g_xrge2_d[l_ac].apgc005, 
                   g_xrge2_d[l_ac].apgc014,g_xrge2_d[l_ac].apgc100,g_xrge2_d[l_ac].apgc101,g_xrge2_d[l_ac].apgc006, 
                   g_xrge2_d[l_ac].apgc007,g_xrge2_d[l_ac].apgc008,g_xrge2_d[l_ac].apgc009,g_xrge2_d[l_ac].apgc010, 
                   g_xrge2_d[l_ac].apgc011,g_xrge2_d[l_ac].apgc103,g_xrge2_d[l_ac].apgc104,g_xrge2_d[l_ac].apgc105, 
                   g_xrge2_d[l_ac].apgc113,g_xrge2_d[l_ac].apgc114,g_xrge2_d[l_ac].apgc115,g_xrge2_d[l_ac].apgc004, 
                   g_xrge2_d[l_ac].apgc015,g_xrge2_d[l_ac].apgc016,g_xrge2_d[l_ac].apgc012,g_xrge2_d[l_ac].apgc013)  
                   #自訂欄位頁簽
                WHERE apgcent = g_enterprise AND apgccomp = g_xrgd_m.xrgdcomp
                  AND apgcdocno = g_xrgd_m.xrgddocno
                  AND apgc900 = g_xrgd_m.xrgd900
                  AND apgcseq = g_xrge2_d_t.apgcseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xrge2_d[l_ac].* = g_xrge2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apgc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xrge2_d[l_ac].* = g_xrge2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrgd_m.xrgdcomp
               LET gs_keys_bak[1] = g_xrgdcomp_t
               LET gs_keys[2] = g_xrgd_m.xrgddocno
               LET gs_keys_bak[2] = g_xrgddocno_t
               LET gs_keys[3] = g_xrgd_m.xrgd900
               LET gs_keys_bak[3] = g_xrgd900_t
               LET gs_keys[4] = g_xrge2_d[g_detail_idx].apgcseq
               LET gs_keys_bak[4] = g_xrge2_d_t.apgcseq
               CALL axrt520_update_b('apgc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axrt520_apgc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xrge2_d[g_detail_idx].apgcseq = g_xrge2_d_t.apgcseq 
                  ) THEN
                  LET gs_keys[01] = g_xrgd_m.xrgdcomp
                  LET gs_keys[gs_keys.getLength()+1] = g_xrgd_m.xrgddocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xrgd_m.xrgd900
                  LET gs_keys[gs_keys.getLength()+1] = g_xrge2_d_t.apgcseq
                  CALL axrt520_key_update_b(gs_keys,'apgc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xrgd_m),util.JSON.stringify(g_xrge2_d_t)
               LET g_log2 = util.JSON.stringify(g_xrgd_m),util.JSON.stringify(g_xrge2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgcseq
            #add-point:BEFORE FIELD apgcseq name="input.b.page2.apgcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgcseq
            
            #add-point:AFTER FIELD apgcseq name="input.a.page2.apgcseq"
            #應用 a05 樣板自動產生(Version:3)
            ##確認資料無重複
            #IF  g_xrgd_m.xrgdcomp IS NOT NULL AND g_xrgd_m.xrgddocno IS NOT NULL AND g_xrgd_m.xrgd900 IS NOT NULL AND g_xrge2_d[g_detail_idx].apgcseq IS NOT NULL THEN 
            #   IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xrgd_m.xrgdcomp != g_xrgdcomp_t OR g_xrgd_m.xrgddocno != g_xrgddocno_t OR g_xrgd_m.xrgd900 != g_xrgd900_t OR g_xrge2_d[g_detail_idx].apgcseq != g_xrge2_d_t.apgcseq)) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apgc_t WHERE "||"apgcent = '" ||g_enterprise|| "' AND "||"apgccomp = '"||g_xrgd_m.xrgdcomp ||"' AND "|| "apgcdocno = '"||g_xrgd_m.xrgddocno ||"' AND "|| "apgc900 = '"||g_xrgd_m.xrgd900 ||"' AND "|| "apgcseq = '"||g_xrge2_d[g_detail_idx].apgcseq ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgcseq
            #add-point:ON CHANGE apgcseq name="input.g.page2.apgcseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgcorga
            #add-point:BEFORE FIELD apgcorga name="input.b.page2.apgcorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgcorga
            
            #add-point:AFTER FIELD apgcorga name="input.a.page2.apgcorga"
            LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014 = 'Y'
            #來源組織
            IF NOT cl_null(g_xrge2_d[l_ac].apgcorga) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xrge_d[l_ac].xrgeorga != g_xrge2_d_t.apgcorga OR g_xrge2_d_t.apgcorga IS NULL )) THEN #170119-00024#10 mark
               IF g_xrge_d[l_ac].xrgeorga != g_xrge2_d_o.apgcorga OR cl_null(g_xrge2_d_o.apgcorga) THEN  #170119-00024#10 add               
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrge2_d[l_ac].apgcorga
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #LET g_xrge2_d[l_ac].apgcorga = g_xrge2_d_t.apgcorga #170119-00024#10 mark
                     LET g_xrge2_d[l_ac].apgcorga = g_xrge2_d_o.apgcorga  #170119-00024#10 add
                     DISPLAY BY NAME g_xrge2_d[l_ac].apgcorga
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aap_apcborga_chk(l_ld,g_xrgd_m.xrgddocno,g_xrge2_d[l_ac].apgcorga,g_wc_apgborga) 
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_xrge2_d[l_ac].apgcorga = g_xrge2_d_t.apgcorga #170119-00024#10 mark
                     LET g_xrge2_d[l_ac].apgcorga = g_xrge2_d_o.apgcorga  #170119-00024#10 add
                     DISPLAY BY NAME g_xrge2_d[l_ac].apgcorga
                     NEXT FIELD CURRENT
                  END IF
                  
                   CALL s_fin_orga_get_comp_ld(g_xrge2_d[l_ac].apgcorga) RETURNING g_sub_success,g_errno,l_comp,l_ld
                   IF l_comp <> g_xrgd_m.xrgdcomp THEN
                      LET g_errparam.code = 'axc-00112'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      #LET g_xrge2_d[l_ac].apgcorga = g_xrge2_d_t.apgcorga #170119-00024#10 mark
                      LET g_xrge2_d[l_ac].apgcorga = g_xrge2_d_o.apgcorga  #170119-00024#10 add
                      DISPLAY BY NAME g_xrge2_d[l_ac].apgcorga
                      NEXT FIELD CURRENT
                   END IF
               END IF  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgcorga
            #add-point:ON CHANGE apgcorga name="input.g.page2.apgcorga"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc001
            
            #add-point:AFTER FIELD apgc001 name="input.a.page2.apgc001"
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_xrge2_d[l_ac].apgc001
            #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3117' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_xrge2_d[l_ac].apgc001_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_xrge2_d[l_ac].apgc001_desc

            LET l_ld = NULL   LET l_glaa005 = NULL
            SELECT glaald ,glaa005
              INTO l_ld ,l_glaa005
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014 = 'Y'               
            LET g_xrge2_d[l_ac].apgc001_desc = ' '
            IF NOT cl_null(g_xrge2_d[l_ac].apgc001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrge2_d[l_ac].apgc001 != g_xrge2_d_o.apgc001 OR g_xrge2_d_o.apgc001 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('3117',g_xrge2_d[l_ac].apgc001) THEN
                     LET g_xrge2_d[l_ac].apgc001  = g_xrge2_d_o.apgc001
                     CALL s_desc_get_acc_desc('3117',g_xrge2_d[l_ac].apgc001) RETURNING g_xrge2_d[l_ac].apgc001_desc
                     DISPLAY BY NAME g_xrge2_d[l_ac].apgc001_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_glab005 = NULL LET l_glab006 = NULL LET l_glab007 = NULL
                  SELECT glab005,glab006,glab007
                    INTO l_glab005,l_glab006,l_glab007
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = l_ld
                     AND glab001 = '15'
                     AND glab002 = '3117'                     
                     AND glab003 = g_xrge2_d[l_ac].apgc001
                     
                  LET g_xrge2_d[l_ac].apgc004 = l_glab005
                  LET g_xrge2_d[l_ac].apgc015 = l_glab006
                  LET g_xrge2_d[l_ac].apgc016 = l_glab007
                  LET g_xrge2_d[l_ac].apgc004_desc = s_desc_get_account_desc(l_ld,g_xrge2_d[l_ac].apgc004)
                  LET g_xrge2_d[l_ac].apgc015_desc = s_desc_get_nmajl003_desc(g_xrge2_d[l_ac].apgc015)                
                  LET g_xrge2_d[l_ac].apgc016_desc =s_desc_get_nmail004_desc(l_glaa005,g_xrge2_d[l_ac].apgc016)
                  DISPLAY BY NAME g_xrge2_d[l_ac].apgc004,g_xrge2_d[l_ac].apgc015,g_xrge2_d[l_ac].apgc016
                  
                  
               END IF
            END IF
            CALL s_desc_get_acc_desc('3117',g_xrge2_d[l_ac].apgc001) RETURNING g_xrge2_d[l_ac].apgc001_desc
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc001_desc
            LET g_xrge2_d_o.* = g_xrge2_d[l_ac].*    #160926-00018#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc001
            #add-point:BEFORE FIELD apgc001 name="input.b.page2.apgc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc001
            #add-point:ON CHANGE apgc001 name="input.g.page2.apgc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc002
            #add-point:BEFORE FIELD apgc002 name="input.b.page2.apgc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc002
            
            #add-point:AFTER FIELD apgc002 name="input.a.page2.apgc002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc002
            #add-point:ON CHANGE apgc002 name="input.g.page2.apgc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc003
            #add-point:BEFORE FIELD apgc003 name="input.b.page2.apgc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc003
            
            #add-point:AFTER FIELD apgc003 name="input.a.page2.apgc003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc003
            #add-point:ON CHANGE apgc003 name="input.g.page2.apgc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc005
            #add-point:BEFORE FIELD apgc005 name="input.b.page2.apgc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc005
            
            #add-point:AFTER FIELD apgc005 name="input.a.page2.apgc005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc005
            #add-point:ON CHANGE apgc005 name="input.g.page2.apgc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc014
            #add-point:BEFORE FIELD apgc014 name="input.b.page2.apgc014"
            CALL axrt520_set_entry_b(p_cmd)   #160926-00018#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc014
            
            #add-point:AFTER FIELD apgc014 name="input.a.page2.apgc014"
            IF NOT cl_null(g_xrge2_d[l_ac].apgc014) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrge2_d[l_ac].apgc014 != g_xrge2_d_o.apgc014 OR g_xrge2_d_o.apgc014 IS NULL )) THEN
                  LET g_chkparam.arg1 = g_xrge2_d[l_ac].apgc014
                  LET g_chkparam.arg2 = g_xrgd_m.xrgdcomp
                  LET g_chkparam.arg3 = '5'    #kris  aapt5系列皆付現  所以帳戶為零用金類型(比照aapt420現金類處理)
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi20",g_lang,"2"),"|:EXEPROGanmi120"
                  IF cl_chk_exist("v_nmas002_4") THEN
                     IF NOT s_anmi120_nmll002_chk(g_xrge2_d[l_ac].apgc014,g_user) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_xrge2_d[l_ac].apgc014
                        LET g_errparam.code   = 'anm-00574'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_xrge2_d[l_ac].apgc014 = g_xrge2_d_o.apgc014
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xrge2_d[l_ac].apgc009 = '' #160926-00018#1 #改變幣別清空發票號碼日期
                  LET g_xrge2_d[l_ac].apgc010 = '' #160926-00018#1
                  LET g_xrge2_d[l_ac].apgc100 = s_anm_get_nmas003(g_xrge2_d[l_ac].apgc014)
                  DISPLAY BY NAME g_xrge2_d[l_ac].apgc014
                  CALL axrt520_curr_recount_b2(l_ac)
                  CALL axrt520_to_o_b2(l_ac)
               END IF
            END IF
            CALL axrt520_set_no_entry_b(p_cmd)   #160926-00018#1
            CALL axrt520_to_o_b2(l_ac)   #160926-00018#1
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc014
            #add-point:ON CHANGE apgc014 name="input.g.page2.apgc014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc100
            #add-point:BEFORE FIELD apgc100 name="input.b.page2.apgc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc100
            
            #add-point:AFTER FIELD apgc100 name="input.a.page2.apgc100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc100
            #add-point:ON CHANGE apgc100 name="input.g.page2.apgc100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc101
            #add-point:BEFORE FIELD apgc101 name="input.b.page2.apgc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc101
            
            #add-point:AFTER FIELD apgc101 name="input.a.page2.apgc101"
            IF NOT cl_null(g_xrge2_d[l_ac].apgc101)THEN
               IF cl_null(g_xrge2_d_o.apgc101) OR (g_xrge2_d_o.apgc101 <> g_xrge2_d[l_ac].apgc101)THEN 
                  #160824-00049#1-----s
                  CALL s_curr_round_ld('1',l_ld,g_xrge2_d[l_ac].apgc100,g_xrge2_d[l_ac].apgc101,3) 
                     RETURNING g_sub_success,g_errno,g_xrge2_d[l_ac].apgc101               
                  #160824-00049#1-----e               
                  CALL axrt520_tax_ins_b2(l_ac)
                  CALL axrt520_to_o_b2(l_ac)
                  DISPLAY BY NAME g_xrge2_d[l_ac].apgc101
               END IF
            END IF
            CALL axrt520_to_o_b2(l_ac)
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc101 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc101
            #add-point:ON CHANGE apgc101 name="input.g.page2.apgc101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc006
            #add-point:BEFORE FIELD apgc006 name="input.b.page2.apgc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc006
            
            #add-point:AFTER FIELD apgc006 name="input.a.page2.apgc006"
            IF NOT cl_null(g_xrge2_d[l_ac].apgc006) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND ((g_xrge2_d[l_ac].apgc006 != g_xrge2_d_o.apgc006 OR g_xrge2_d_o.apgc006 IS NULL ) )) THEN
                  CALL s_tax_chk(g_xrgd_m.xrgdcomp,g_xrge2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  IF NOT g_sub_success THEN
                     LET g_xrge2_d[l_ac].apgc006 = g_xrge2_d_o.apgc006
                     DISPLAY BY NAME g_xrge2_d[l_ac].apgc006
                     NEXT FIELD CURRENT
                  END IF
                  CALL axrt520_tax_ins_b2(l_ac)
                  CALL axrt520_to_o_b2(l_ac)
                  DISPLAY BY NAME g_xrge2_d[l_ac].apgc006
               END IF
            END IF
            CALL axrt520_to_o_b2(l_ac)   #160926-00018#1 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc006
            #add-point:ON CHANGE apgc006 name="input.g.page2.apgc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc007
            #add-point:BEFORE FIELD apgc007 name="input.b.page2.apgc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc007
            
            #add-point:AFTER FIELD apgc007 name="input.a.page2.apgc007"
            IF NOT cl_null(g_xrge2_d[l_ac].apgc007)THEN
               IF cl_null(g_xrge2_d_t.apgc007) OR (g_xrge2_d_t.apgc007 <> g_xrge2_d[l_ac].apgc007)THEN
                  LET l_ooef019 = NULL
                  SELECT ooef019 INTO l_ooef019 FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_xrgd_m.xrgdcomp                   
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_ooef019
                  LET g_chkparam.arg2 = g_xrge2_d[l_ac].apgc007
                  IF NOT cl_chk_exist("v_isac002_3") THEN
                     LET g_xrge2_d[l_ac].apgc007 = g_xrge2_d_t.apgc007
                     DISPLAY BY NAME g_xrge2_d[l_ac].apgc007
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_isac004 = ''
                  SELECT isac004 INTO l_isac004 FROM isac_t
                   WHERE isacent = g_enterprise 
                     AND isac002 = g_xrge2_d[l_ac].apgc007
                     AND isac001 = l_ooef019
                  LET g_xrge2_d[l_ac].apgc011 = '1' 
                  IF cl_null(l_isac004) THEN LET g_xrge2_d[l_ac].apgc011 = '3' END IF
                  DISPLAY BY NAME g_xrge2_d[l_ac].apgc011
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc007
            #add-point:ON CHANGE apgc007 name="input.g.page2.apgc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc008
            #add-point:BEFORE FIELD apgc008 name="input.b.page2.apgc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc008
            
            #add-point:AFTER FIELD apgc008 name="input.a.page2.apgc008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc008
            #add-point:ON CHANGE apgc008 name="input.g.page2.apgc008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc009
            #add-point:BEFORE FIELD apgc009 name="input.b.page2.apgc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc009
            
            #add-point:AFTER FIELD apgc009 name="input.a.page2.apgc009"
            CALL axrt520_to_o_b2(l_ac)   #160926-00018#1 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc009
            #add-point:ON CHANGE apgc009 name="input.g.page2.apgc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc010
            #add-point:BEFORE FIELD apgc010 name="input.b.page2.apgc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc010
            
            #add-point:AFTER FIELD apgc010 name="input.a.page2.apgc010"
            CALL axrt520_to_o_b2(l_ac)   #160926-00018#1 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc010
            #add-point:ON CHANGE apgc010 name="input.g.page2.apgc010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc011
            #add-point:BEFORE FIELD apgc011 name="input.b.page2.apgc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc011
            
            #add-point:AFTER FIELD apgc011 name="input.a.page2.apgc011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc011
            #add-point:ON CHANGE apgc011 name="input.g.page2.apgc011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc103
            #add-point:BEFORE FIELD apgc103 name="input.b.page2.apgc103"
            #160428-00001#15-----s
            CALL s_tax_chk(g_xrgd_m.xrgdcomp,g_xrge2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
            IF l_apca013 = 'Y' AND g_xrge2_d[l_ac].apgc103 = 0 AND g_xrge2_d[l_ac].apgc105 = 0 THEN
               NEXT FIELD apgc105
            END IF
            #160428-00001#15-----e
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc103
            
            #add-point:AFTER FIELD apgc103 name="input.a.page2.apgc103"
            LET l_ld = NULL   LET l_glaa001 = NULL
            SELECT glaald ,glaa001
              INTO l_ld,l_glaa001
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014 = 'Y'
                         
            #原幣未稅金額
            IF NOT cl_null(g_xrge2_d[l_ac].apgc103) THEN 
               IF g_xrge2_d[l_ac].apgc103 != g_xrge2_d_o.apgc103 OR g_xrge2_d_o.apgc103 IS NULL THEN  
                  CALL s_tax_chk(g_xrgd_m.xrgdcomp,g_xrge2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
 
                  IF l_apca013 = 'N' THEN   #稅別未稅時修改未稅金額使用s_tax_ins   #seq2存變更序
                     CALL s_tax_ins(g_xrgd_m.xrgddocno,g_xrge2_d[l_ac].apgcseq,'0',g_xrge2_d[l_ac].apgcorga,g_xrge2_d[l_ac].apgc103,
                                    g_xrge2_d[l_ac].apgc006,1,g_xrge2_d[l_ac].apgc100,g_xrge2_d[l_ac].apgc101,l_ld,1,1)
                          RETURNING g_xrge2_d[l_ac].apgc103,g_xrge2_d[l_ac].apgc104,g_xrge2_d[l_ac].apgc105,
                                    g_xrge2_d[l_ac].apgc113,g_xrge2_d[l_ac].apgc114,g_xrge2_d[l_ac].apgc115,
                                    l_dummy2,l_dummy2,l_dummy2,
                                    l_dummy3,l_dummy3,l_dummy3
                  #稅別含稅,修改未稅金额后使用公式反推稅額、計算本幣金額
                   ELSE
                      LET g_xrge2_d[l_ac].apgc104 = g_xrge2_d[l_ac].apgc105 - g_xrge2_d[l_ac].apgc103
                      LET g_xrge2_d[l_ac].apgc113 = g_xrge2_d[l_ac].apgc103 * g_xrge2_d[l_ac].apgc101
                      LET g_xrge2_d[l_ac].apgc113 = s_curr_round(g_xrgd_m.xrgdcomp,l_glaa001,g_xrge2_d[l_ac].apgc113,2)
                      LET g_xrge2_d[l_ac].apgc114 = g_xrge2_d[l_ac].apgc115 - g_xrge2_d[l_ac].apgc113   
                      UPDATE xrcd_t SET xrcd103 = g_xrge2_d[l_ac].apgc103,
                                        xrcd104 = g_xrge2_d[l_ac].apgc104,
                                        xrcd105 = g_xrge2_d[l_ac].apgc105,
                                        xrcd113 = g_xrge2_d[l_ac].apgc113,
                                        xrcd114 = g_xrge2_d[l_ac].apgc114,
                                        xrcd115 = g_xrge2_d[l_ac].apgc115
                       WHERE xrcdent   = g_enterprise
                         AND xrcddocno = g_xrgd_m.xrgddocno
                         AND xrcdseq   = g_xrge2_d[l_ac].apgcseq
                         AND xrcdseq2  = 0
                         AND xrcdcomp  = g_xrgd_m.xrgdcomp                     
                  END IF
                  CALL axrt520_to_o_b2(l_ac)
                  DISPLAY BY NAME g_xrge2_d[l_ac].apgc103
               END IF
            END IF
            CALL axrt520_to_o_b2(l_ac)    #160926-00018#1 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc103
            #add-point:ON CHANGE apgc103 name="input.g.page2.apgc103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc104
            #add-point:BEFORE FIELD apgc104 name="input.b.page2.apgc104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc104
            
            #add-point:AFTER FIELD apgc104 name="input.a.page2.apgc104"
            IF NOT cl_null(g_xrge2_d[l_ac].apgc104) THEN
               IF g_xrge2_d[l_ac].apgc104 != g_xrge2_d_o.apgc104 OR g_xrge2_d_o.apgc104 IS NULL THEN 
                  CALL s_tax_chk(g_xrgd_m.xrgdcomp,g_xrge2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  IF l_apca013 = 'Y' THEN
                     LET g_xrge2_d[l_ac].apgc103 = g_xrge2_d[l_ac].apgc105 - g_xrge2_d[l_ac].apgc104
                     LET g_xrge2_d[l_ac].apgc114 = g_xrge2_d[l_ac].apgc104 * g_xrge2_d[l_ac].apgc101  
                     LET g_xrge2_d[l_ac].apgc114 = s_curr_round(g_xrgd_m.xrgdcomp,l_glaa001,g_xrge2_d[l_ac].apgc114,2)
                     LET g_xrge2_d[l_ac].apgc113 = g_xrge2_d[l_ac].apgc115 - g_xrge2_d[l_ac].apgc114
                  ELSE
                     LET g_xrge2_d[l_ac].apgc105 = g_xrge2_d[l_ac].apgc103 + g_xrge2_d[l_ac].apgc104
                     LET g_xrge2_d[l_ac].apgc114 = g_xrge2_d[l_ac].apgc104 * g_xrge2_d[l_ac].apgc101  
                     LET g_xrge2_d[l_ac].apgc114 = s_curr_round(g_xrgd_m.xrgdcomp,l_glaa001,g_xrge2_d[l_ac].apgc114,2)
                     LET g_xrge2_d[l_ac].apgc115 = g_xrge2_d[l_ac].apgc113 + g_xrge2_d[l_ac].apgc114
                  END IF
                  UPDATE xrcd_t SET xrcd103 = g_xrge2_d[l_ac].apgc103,
                                    xrcd104 = g_xrge2_d[l_ac].apgc104,
                                    xrcd105 = g_xrge2_d[l_ac].apgc105,
                                    xrcd113 = g_xrge2_d[l_ac].apgc113,
                                    xrcd114 = g_xrge2_d[l_ac].apgc114,
                                    xrcd115 = g_xrge2_d[l_ac].apgc115
                   WHERE xrcdent   = g_enterprise
                     AND xrcddocno = g_xrgd_m.xrgddocno
                     AND xrcdseq   = g_xrge2_d[l_ac].apgcseq
                     AND xrcdseq2  = 0
                     AND xrcdcomp  = g_xrgd_m.xrgdcomp
                  CALL axrt520_to_o_b2(l_ac) 
                  DISPLAY BY NAME g_xrge2_d[l_ac].apgc104                  
               END IF
            END IF
            CALL axrt520_to_o_b2(l_ac)    #160926-00018#1 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc104
            #add-point:ON CHANGE apgc104 name="input.g.page2.apgc104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc105
            #add-point:BEFORE FIELD apgc105 name="input.b.page2.apgc105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc105
            
            #add-point:AFTER FIELD apgc105 name="input.a.page2.apgc105"
            IF NOT cl_null(g_xrge2_d[l_ac].apgc105) THEN 
               IF g_xrge2_d[l_ac].apgc105 != g_xrge2_d_o.apgc105 OR g_xrge2_d_o.apgc105 IS NULL THEN
                  CALL s_tax_chk(g_xrgd_m.xrgdcomp,g_xrge2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  IF l_apca013 = 'Y' THEN   
                     CALL s_tax_ins(g_xrgd_m.xrgddocno,g_xrge2_d[l_ac].apgcseq,'0',g_xrge2_d[l_ac].apgcorga,g_xrge2_d[l_ac].apgc105,
                                    g_xrge2_d[l_ac].apgc006,1,g_xrge2_d[l_ac].apgc100,g_xrge2_d[l_ac].apgc101,l_ld,1,1)
                          RETURNING g_xrge2_d[l_ac].apgc103,g_xrge2_d[l_ac].apgc104,g_xrge2_d[l_ac].apgc105,
                                    g_xrge2_d[l_ac].apgc113,g_xrge2_d[l_ac].apgc114,g_xrge2_d[l_ac].apgc115,
                                    l_dummy2,l_dummy2,l_dummy2,
                                    l_dummy3,l_dummy3,l_dummy3
                  ELSE
                     LET g_xrge2_d[l_ac].apgc104 = g_xrge2_d[l_ac].apgc105 - g_xrge2_d[l_ac].apgc103
                     LET g_xrge2_d[l_ac].apgc115 = g_xrge2_d[l_ac].apgc105 * g_xrge2_d[l_ac].apgc101
                     LET g_xrge2_d[l_ac].apgc115 = s_curr_round(g_xrgd_m.xrgdcomp,l_glaa001,g_xrge2_d[l_ac].apgc115,2)
                     LET g_xrge2_d[l_ac].apgc114 = g_xrge2_d[l_ac].apgc115 - g_xrge2_d[l_ac].apgc113                       

                     UPDATE xrcd_t SET xrcd103 = g_xrge2_d[l_ac].apgc103,
                                       xrcd104 = g_xrge2_d[l_ac].apgc104,
                                       xrcd105 = g_xrge2_d[l_ac].apgc105,
                                       xrcd113 = g_xrge2_d[l_ac].apgc113,
                                       xrcd114 = g_xrge2_d[l_ac].apgc114,
                                       xrcd115 = g_xrge2_d[l_ac].apgc115
                      WHERE xrcdent   = g_enterprise
                        AND xrcddocno = g_xrgd_m.xrgddocno
                        AND xrcdseq   = g_xrge2_d[l_ac].apgcseq
                        AND xrcdseq2  = 0
                        AND xrcdcomp  = g_xrgd_m.xrgdcomp 
                  END IF
                  CALL axrt520_to_o_b2(l_ac)
                  DISPLAY BY NAME g_xrge2_d[l_ac].apgc105
               END IF
            END IF
            CALL axrt520_to_o_b2(l_ac)    #160926-00018#1 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc105
            #add-point:ON CHANGE apgc105 name="input.g.page2.apgc105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc113
            #add-point:BEFORE FIELD apgc113 name="input.b.page2.apgc113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc113
            
            #add-point:AFTER FIELD apgc113 name="input.a.page2.apgc113"
            IF NOT cl_null(g_xrge2_d[l_ac].apgc113) THEN
               IF g_xrge2_d[l_ac].apgc113 != g_xrge2_d_o.apgc113 OR g_xrge2_d_o.apgc113 IS NULL THEN  
                  CALL s_tax_chk(g_xrgd_m.xrgdcomp,g_xrge2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  IF g_xrge2_d[l_ac].apgc113 = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00047'
                     LET g_errparam.extend = g_xrge2_d[l_ac].apgc113
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  IF l_apca013 = 'Y' THEN
                     LET g_xrge2_d[l_ac].apgc114 = g_xrge2_d[l_ac].apgc115 - g_xrge2_d[l_ac].apgc113
                  ELSE
                     LET g_xrge2_d[l_ac].apgc115 = g_xrge2_d[l_ac].apgc113 + g_xrge2_d[l_ac].apgc114
                  END IF
                  UPDATE xrcd_t SET xrcd113 = g_xrge2_d[l_ac].apgc113,
                                    xrcd114 = g_xrge2_d[l_ac].apgc114,
                                    xrcd115 = g_xrge2_d[l_ac].apgc115
                   WHERE xrcdent   = g_enterprise
                     AND xrcddocno = g_xrgd_m.xrgddocno
                     AND xrcdseq   = g_xrge2_d[l_ac].apgcseq
                     AND xrcdcomp  = g_xrgd_m.xrgdcomp
                     AND xrcdseq2  = 0
                     
                   CALL axrt520_to_o_b2(l_ac)
                   DISPLAY BY NAME g_xrge2_d[l_ac].apgc113
                         
               END IF
            END IF
            CALL axrt520_to_o_b2(l_ac)    #160926-00018#1
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc113
            #add-point:ON CHANGE apgc113 name="input.g.page2.apgc113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc114
            #add-point:BEFORE FIELD apgc114 name="input.b.page2.apgc114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc114
            
            #add-point:AFTER FIELD apgc114 name="input.a.page2.apgc114"
            IF NOT cl_null(g_xrge2_d[l_ac].apgc114) THEN
               IF g_xrge2_d[l_ac].apgc114 != g_xrge2_d_o.apgc114 OR g_xrge2_d_o.apgc114 IS NULL THEN  
                  CALL s_tax_chk(g_xrgd_m.xrgdcomp,g_xrge2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011               
                  IF l_apca013 = 'Y' THEN
                     LET g_xrge2_d[l_ac].apgc113 = g_xrge2_d[l_ac].apgc115 - g_xrge2_d[l_ac].apgc114
                  ELSE
                     LET g_xrge2_d[l_ac].apgc115 = g_xrge2_d[l_ac].apgc113 + g_xrge2_d[l_ac].apgc114
                  END IF
                  UPDATE xrcd_t SET xrcd113 = g_xrge2_d[l_ac].apgc113,
                                    xrcd114 = g_xrge2_d[l_ac].apgc114,
                                    xrcd115 = g_xrge2_d[l_ac].apgc115
                   WHERE xrcdent   = g_enterprise
                     AND xrcddocno = g_xrgd_m.xrgddocno
                     AND xrcdseq   = g_xrge2_d[l_ac].apgcseq
                     AND xrcdcomp  = g_xrgd_m.xrgdcomp
                     AND xrcdseq2  = 0
                  CALL axrt520_to_o_b2(l_ac)
                  DISPLAY BY NAME g_xrge2_d[l_ac].apgc114                  
               END IF
            END IF
            CALL axrt520_to_o_b2(l_ac)    #160926-00018#1
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc114
            #add-point:ON CHANGE apgc114 name="input.g.page2.apgc114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc115
            #add-point:BEFORE FIELD apgc115 name="input.b.page2.apgc115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc115
            
            #add-point:AFTER FIELD apgc115 name="input.a.page2.apgc115"
            IF NOT cl_null(g_xrge2_d[l_ac].apgc115) THEN
               IF g_xrge2_d[l_ac].apgc115 != g_xrge2_d_o.apgc115 OR g_xrge2_d_o.apgc115 IS NULL THEN 
                  CALL s_tax_chk(g_xrgd_m.xrgdcomp,g_xrge2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011                              
                  IF g_xrge2_d[l_ac].apgc115 = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00047'
                     LET g_errparam.extend = g_xrge2_d[l_ac].apgc115
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  IF l_apca013 = 'Y' THEN
                     LET g_xrge2_d[l_ac].apgc113 = g_xrge2_d[l_ac].apgc115 - g_xrge2_d[l_ac].apgc114  
                  ELSE
                     LET g_xrge2_d[l_ac].apgc114 = g_xrge2_d[l_ac].apgc115 - g_xrge2_d[l_ac].apgc113  
                  END IF
                  UPDATE xrcd_t SET xrcd113 = g_xrge2_d[l_ac].apgc113,
                                    xrcd114 = g_xrge2_d[l_ac].apgc114,
                                    xrcd115 = g_xrge2_d[l_ac].apgc115
                   WHERE xrcdent   = g_enterprise
                     AND xrcddocno = g_xrgd_m.xrgddocno
                     AND xrcdseq   = g_xrge2_d[l_ac].apgcseq
                     AND xrcdseq2  = 0
                     AND xrcdcomp  = g_xrgd_m.xrgdcomp
                     
                   CALL axrt520_to_o_b2(l_ac)
                   DISPLAY BY NAME g_xrge2_d[l_ac].apgc115
               END IF       
            END IF
            CALL axrt520_to_o_b2(l_ac)    #160926-00018#1
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc115
            #add-point:ON CHANGE apgc115 name="input.g.page2.apgc115"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc004
            
            #add-point:AFTER FIELD apgc004 name="input.a.page2.apgc004"
            LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_xrge2_d[l_ac].apgc004)THEN
               IF g_xrge2_d[l_ac].apgc004 != g_xrge2_d_o.apgc004 OR g_xrge2_d_o.apgc004 IS NULL THEN
                  CALL s_aap_glac002_chk(g_xrge2_d[l_ac].apgc004,l_ld) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.replace[1] = 'agli020'
                     LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                     LET g_errparam.exeprog = 'agli020'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                
                     LET g_xrge2_d[l_ac].apgc004 = g_xrge2_d_o.apgc004
                     CALL s_desc_get_account_desc(l_ld,g_xrge2_d[l_ac].apgc004) RETURNING g_xrge2_d[l_ac].apgc004_desc
                     DISPLAY BY NAME g_xrge2_d[l_ac].apgc004_desc
                     NEXT FIELD CURRENT
                  END IF                
               END IF
            END IF
            CALL s_desc_get_account_desc(l_ld,g_xrge2_d[l_ac].apgc004) RETURNING g_xrge2_d[l_ac].apgc004_desc
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc004_desc
            CALL axrt520_to_o_b2(l_ac)    #160926-00018#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc004
            #add-point:BEFORE FIELD apgc004 name="input.b.page2.apgc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc004
            #add-point:ON CHANGE apgc004 name="input.g.page2.apgc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc004_desc
            #add-point:BEFORE FIELD apgc004_desc name="input.b.page2.apgc004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc004_desc
            
            #add-point:AFTER FIELD apgc004_desc name="input.a.page2.apgc004_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc004_desc
            #add-point:ON CHANGE apgc004_desc name="input.g.page2.apgc004_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc015
            
            #add-point:AFTER FIELD apgc015 name="input.a.page2.apgc015"
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_xrge2_d[l_ac].apgc015
            #CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_xrge2_d[l_ac].apgc015_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_xrge2_d[l_ac].apgc015_desc

            LET g_xrge2_d[l_ac].apgc015_desc = ''
            LET g_xrge2_d[l_ac].apgc016_desc = ''
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc015_desc,g_xrge2_d[l_ac].apgc016_desc
            IF NOT cl_null(g_xrge2_d[l_ac].apgc015) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xrge2_d[l_ac].apgc015 !=  g_xrge2_d_o.apgc015 OR  g_xrge2_d_o.apgc015 IS NULL)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrge2_d[l_ac].apgc015
                  LET g_chkparam.arg2 = 2
                  LET g_errshow = TRUE

                  IF NOT cl_chk_exist("v_nmaj001_1") THEN
                     LET l_glaa005 = NULL
                     SELECT glaa005 INTO l_glaa005 FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaacomp = g_agpa_m.xrgdcomp
                        AND glaa014  = 'Y'
                     #檢查失敗時後續處理
                     LET g_xrge2_d[l_ac].apgc015 = g_xrge2_d_o.apgc015
                     LET g_xrge2_d[l_ac].apgc016 = s_anm_get_nmad003(l_glaa005,g_xrge2_d[l_ac].apgc015)
                     DISPLAY BY NAME g_xrge2_d[l_ac].apgc015,g_xrge2_d[l_ac].apgc016
                     LET g_xrge2_d[l_ac].apgc015_desc = s_desc_get_nmajl003_desc(g_xrge2_d[l_ac].apgc015)
                     LET g_xrge2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_xrge2_d[l_ac].apgc016)
                     DISPLAY BY NAME g_xrge2_d[l_ac].apgc016_desc,g_xrge2_d[l_ac].apgc015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET l_glaa005 = NULL
               SELECT glaa005 INTO l_glaa005 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp = g_xrgd_m.xrgdcomp
                  AND glaa014 = 'Y'
               LET g_xrge2_d[l_ac].apgc016 = s_anm_get_nmad003(l_glaa005,g_xrge2_d[l_ac].apgc015)
               DISPLAY BY NAME g_xrge2_d[l_ac].apgc016
               LET g_xrge2_d[l_ac].apgc015_desc = s_desc_get_nmajl003_desc(g_xrge2_d[l_ac].apgc015)
               LET g_xrge2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_xrge2_d[l_ac].apgc016)
               DISPLAY BY NAME g_xrge2_d[l_ac].apgc016_desc,g_xrge2_d[l_ac].apgc015_desc
            END IF
            CALL axrt520_to_o_b2(l_ac)    #160926-00018#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc015
            #add-point:BEFORE FIELD apgc015 name="input.b.page2.apgc015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc015
            #add-point:ON CHANGE apgc015 name="input.g.page2.apgc015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc016
            
            #add-point:AFTER FIELD apgc016 name="input.a.page2.apgc016"
            LET g_xrge2_d[l_ac].apgc016_desc =''
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc016_desc
            IF NOT cl_null(g_xrge2_d[l_ac].apgc016) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xrge2_d[l_ac].apgc016 != g_xrge2_d_o.apgc016 OR g_xrge2_d_o.apgc016 IS NULL )) THEN
                  LET l_glaa005 = NULL
                  SELECT glaa005 INTO l_glaa005 FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaacomp = g_xrgd_m.xrgdcomp
                     AND glaa014 = 'Y'
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xrge2_d[l_ac].apgc016
                  LET g_chkparam.arg2 = l_glaa005
                  LET g_errshow = TRUE
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmai002") THEN
                     #檢查失敗時後續處
                     LET g_xrge2_d[l_ac].apgc016 = g_xrge2_d_o.apgc016
                     LET g_xrge2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_xrge2_d[l_ac].apgc016)
                     DISPLAY BY NAME g_xrge2_d[l_ac].apgc016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
    
               LET l_glaa005 = NULL
               SELECT glaa005 INTO l_glaa005 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp  = g_xrgd_m.xrgdcomp
                  AND glaa014   = 'Y'
               LET g_xrge2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_xrge2_d[l_ac].apgc016)
               DISPLAY BY NAME g_xrge2_d[l_ac].apgc016_desc
            END IF
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp  = g_xrgd_m.xrgdcomp
               AND glaa014   = 'Y'
            LET g_xrge2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_xrge2_d[l_ac].apgc016)
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc016_desc
            CALL axrt520_to_o_b2(l_ac)    #160926-00018#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc016
            #add-point:BEFORE FIELD apgc016 name="input.b.page2.apgc016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc016
            #add-point:ON CHANGE apgc016 name="input.g.page2.apgc016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc016_desc
            #add-point:BEFORE FIELD apgc016_desc name="input.b.page2.apgc016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc016_desc
            
            #add-point:AFTER FIELD apgc016_desc name="input.a.page2.apgc016_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc016_desc
            #add-point:ON CHANGE apgc016_desc name="input.g.page2.apgc016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc012
            #add-point:BEFORE FIELD apgc012 name="input.b.page2.apgc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc012
            
            #add-point:AFTER FIELD apgc012 name="input.a.page2.apgc012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc012
            #add-point:ON CHANGE apgc012 name="input.g.page2.apgc012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc013
            #add-point:BEFORE FIELD apgc013 name="input.b.page2.apgc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc013
            
            #add-point:AFTER FIELD apgc013 name="input.a.page2.apgc013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc013
            #add-point:ON CHANGE apgc013 name="input.g.page2.apgc013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.apgcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgcseq
            #add-point:ON ACTION controlp INFIELD apgcseq name="input.c.page2.apgcseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgcorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgcorga
            #add-point:ON ACTION controlp INFIELD apgcorga name="input.c.page2.apgcorga"
            #應用 a07 樣板自動產生(Version:3)   
            #來源組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrge2_d[l_ac].apgcorga
            LET g_qryparam.where    = "ooef001 IN ",g_wc_apgborga, " AND ooef017 ='",g_xrgd_m.xrgdcomp,"' "
            CALL q_ooef001()                                 
            LET g_xrge2_d[l_ac].apgcorga = g_qryparam.return1            
            DISPLAY BY NAME g_xrge2_d[l_ac].apgcorga
            NEXT FIELD apgcorga                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc001
            #add-point:ON ACTION controlp INFIELD apgc001 name="input.c.page2.apgc001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3117'
            LET g_qryparam.default1 = g_xrge2_d[l_ac].apgc001
            CALL q_oocq002()
            LET g_xrge2_d[l_ac].apgc001 = g_qryparam.return1
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrge2_d[l_ac].apgc001
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3117' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrge2_d[l_ac].apgc001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc001_desc
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc001
            NEXT FIELD apgc001
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc002
            #add-point:ON ACTION controlp INFIELD apgc002 name="input.c.page2.apgc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc003
            #add-point:ON ACTION controlp INFIELD apgc003 name="input.c.page2.apgc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc005
            #add-point:ON ACTION controlp INFIELD apgc005 name="input.c.page2.apgc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc014
            #add-point:ON ACTION controlp INFIELD apgc014 name="input.c.page2.apgc014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrge2_d[l_ac].apgc014
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrge2_d[l_ac].apgc014
            LET g_qryparam.where = " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," ",
                                   "              AND ooef017 = '",g_xrgd_m.xrgdcomp,"')",
                                   " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",
                                   "                                   AND nmagent = nmaaent ", #160905-00002#2
                                   " AND nmag002 IN ('1','5'))",
                                   " AND nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"')"
            CALL q_nmas_01()                             
            LET g_xrge2_d[l_ac].apgc014 = g_qryparam.return1
            LET g_xrge2_d[l_ac].apgc100 = s_anm_get_nmas003(g_xrge2_d[l_ac].apgc014)
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc100,g_xrge2_d[l_ac].apgc014
            NEXT FIELD apgc014  
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc100
            #add-point:ON ACTION controlp INFIELD apgc100 name="input.c.page2.apgc100"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc101
            #add-point:ON ACTION controlp INFIELD apgc101 name="input.c.page2.apgc101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc006
            #add-point:ON ACTION controlp INFIELD apgc006 name="input.c.page2.apgc006"
            LET l_ooef019 = NULL
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_xrgd_m.xrgdcomp
            #稅別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrge2_d[l_ac].apgc006
            LET g_qryparam.arg1 = l_ooef019   
            CALL q_oodb002_5()
            LET g_xrge2_d[l_ac].apgc006 = g_qryparam.return1
            NEXT FIELD apgc006
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc007
            #add-point:ON ACTION controlp INFIELD apgc007 name="input.c.page2.apgc007"
            LET l_ooef019 = NULL
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_xrgd_m.xrgdcomp   
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrge2_d[l_ac].apgc007
            LET g_qryparam.where = " isac003 IN ('1','3') AND isac001 = '",l_ooef019,"' "
            CALL q_isac002()
            LET g_xrge2_d[l_ac].apgc007 = g_qryparam.return1
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc007
            NEXT FIELD apgc007
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc008
            #add-point:ON ACTION controlp INFIELD apgc008 name="input.c.page2.apgc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc009
            #add-point:ON ACTION controlp INFIELD apgc009 name="input.c.page2.apgc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc010
            #add-point:ON ACTION controlp INFIELD apgc010 name="input.c.page2.apgc010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc011
            #add-point:ON ACTION controlp INFIELD apgc011 name="input.c.page2.apgc011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc103
            #add-point:ON ACTION controlp INFIELD apgc103 name="input.c.page2.apgc103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc104
            #add-point:ON ACTION controlp INFIELD apgc104 name="input.c.page2.apgc104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc105
            #add-point:ON ACTION controlp INFIELD apgc105 name="input.c.page2.apgc105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc113
            #add-point:ON ACTION controlp INFIELD apgc113 name="input.c.page2.apgc113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc114
            #add-point:ON ACTION controlp INFIELD apgc114 name="input.c.page2.apgc114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc115
            #add-point:ON ACTION controlp INFIELD apgc115 name="input.c.page2.apgc115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc004
            #add-point:ON ACTION controlp INFIELD apgc004 name="input.c.page2.apgc004"
    			LET l_ld = NULL   LET l_glaa004 = NULL
    			SELECT glaald,glaa004
    			  INTO l_ld,l_glaa004
    			  FROM glaa_t
    			 WHERE glaaent  = g_enterprise
    			   AND glaacomp = g_xrgd_m.xrgdcomp
    			   AND glaa014 = 'Y'
    			
    			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrge2_d[l_ac].apgc004       
            LET g_qryparam.where = "glac001 = '",l_glaa004,"' AND  glac003 <>'1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",l_ld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )" 
            CALL aglt310_04()                          
            LET g_xrge2_d[l_ac].apgc004 = g_qryparam.return1     
            CALL s_desc_get_account_desc(l_ld,g_xrge2_d[l_ac].apgc004) RETURNING g_xrge2_d[l_ac].apgc004_desc
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc004_desc,g_xrge2_d[l_ac].apgc004
            NEXT FIELD apgc004 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc004_desc
            #add-point:ON ACTION controlp INFIELD apgc004_desc name="input.c.page2.apgc004_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc015
            #add-point:ON ACTION controlp INFIELD apgc015 name="input.c.page2.apgc015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '2' "   #提出
            LET g_qryparam.default1 = g_xrge2_d[l_ac].apgc015
            CALL q_nmaj001()                                       
            LET g_xrge2_d[l_ac].apgc015   = g_qryparam.return1

            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014  = 'Y'
            LET g_xrge2_d[l_ac].apgc016   = s_anm_get_nmad003(l_glaa005,g_xrge2_d[l_ac].apgc015)
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc016 ,g_xrge2_d[l_ac].apgc015
            LET g_xrge2_d[l_ac].apgc015_desc = s_desc_get_nmajl003_desc(g_xrge2_d[l_ac].apgc015)
            LET g_xrge2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_xrge2_d[l_ac].apgc016)
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc015_desc,g_xrge2_d[l_ac].apgc016_desc
            NEXT FIELD apgc015
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc016
            #add-point:ON ACTION controlp INFIELD apgc016 name="input.c.page2.apgc016"
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_xrgd_m.xrgdcomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"' "
            LET g_qryparam.default1 = g_xrge2_d[l_ac].apgc016
            CALL q_nmai002()                                  #呼叫開窗
            LET g_xrge2_d[l_ac].apgc016 = g_qryparam.return1
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc016
            LET g_xrge2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_xrge2_d[l_ac].apgc016)
            DISPLAY BY NAME g_xrge2_d[l_ac].apgc016_desc
            NEXT FIELD apgc016
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc016_desc
            #add-point:ON ACTION controlp INFIELD apgc016_desc name="input.c.page2.apgc016_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc012
            #add-point:ON ACTION controlp INFIELD apgc012 name="input.c.page2.apgc012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc013
            #add-point:ON ACTION controlp INFIELD apgc013 name="input.c.page2.apgc013"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xrge2_d[l_ac].* = g_xrge2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axrt520_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axrt520_unlock_b("apgc_t","'2'")
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
               LET g_xrge2_d[li_reproduce_target].* = g_xrge2_d[li_reproduce].*
 
               LET g_xrge2_d[li_reproduce_target].apgcseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrge2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrge2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="axrt520.input.other" >}
      
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
            NEXT FIELD xrgddocno
            #end add-point  
            NEXT FIELD xrgdcomp
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xrgeseq
               WHEN "s_detail2"
                  NEXT FIELD apgcseq
 
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
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axrt520.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axrt520_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axrt520_b_fill() #單身填充
      CALL axrt520_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axrt520_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   LET g_xrgd_m.l_xrga104diff = g_xrgd_m.xrgd103 - g_xrgd_m.xrgd104
   DISPLAY BY NAME g_xrgd_m.l_xrga104diff
   
   SELECT glaa001 INTO g_xrgd_m.l_glaa001 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_xrgd_m.xrgdcomp
      AND glaa014 = 'Y'
   #end add-point
   
   #遮罩相關處理
   LET g_xrgd_m_mask_o.* =  g_xrgd_m.*
   CALL axrt520_xrgd_t_mask()
   LET g_xrgd_m_mask_n.* =  g_xrgd_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xrgd_m.xrgdcomp,g_xrgd_m.xrgdcomp_desc,g_xrgd_m.xrgd005,g_xrgd_m.xrgd005_desc,g_xrgd_m.xrgd006, 
       g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt,g_xrgd_m.xrgd003,g_xrgd_m.xrgd004, 
       g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus,g_xrgd_m.xrgdownid, 
       g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdowndp_desc,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtid_desc, 
       g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdcrtdt,g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmodid_desc, 
       g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfid_desc,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid, 
       g_xrgd_m.xrgdpstid_desc,g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009, 
       g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022,g_xrgd_m.xrgd022_desc,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
       g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100, 
       g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.l_xrga104diff,g_xrgd_m.l_glaa001,g_xrgd_m.xrgd101, 
       g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016,g_xrgd_m.xrgd016_desc,g_xrgd_m.xrgd017,g_xrgd_m.xrgd018, 
       g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrgd_m.xrgdstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xrge_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xrge2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axrt520_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL s_fin_account_center_sons_query('8',g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocdt,'1')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apgborga
   CALL s_fin_get_wc_str(g_wc_apgborga) RETURNING g_wc_apgborga
   CALL axrt520_head_color()
   CALL s_hint_show('xrgh_t','xrgd_t','xrga_t',g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,0,'','')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axrt520_detail_show()
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
 
{<section id="axrt520.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axrt520_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xrgd_t.xrgdcomp 
   DEFINE l_oldno     LIKE xrgd_t.xrgdcomp 
   DEFINE l_newno02     LIKE xrgd_t.xrgddocno 
   DEFINE l_oldno02     LIKE xrgd_t.xrgddocno 
   DEFINE l_newno03     LIKE xrgd_t.xrgd900 
   DEFINE l_oldno03     LIKE xrgd_t.xrgd900 
 
   DEFINE l_master    RECORD LIKE xrgd_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xrge_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE apgc_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_xrgd_m.xrgdcomp IS NULL
   OR g_xrgd_m.xrgddocno IS NULL
   OR g_xrgd_m.xrgd900 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xrgdcomp_t = g_xrgd_m.xrgdcomp
   LET g_xrgddocno_t = g_xrgd_m.xrgddocno
   LET g_xrgd900_t = g_xrgd_m.xrgd900
 
    
   LET g_xrgd_m.xrgdcomp = ""
   LET g_xrgd_m.xrgddocno = ""
   LET g_xrgd_m.xrgd900 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrgd_m.xrgdownid = g_user
      LET g_xrgd_m.xrgdowndp = g_dept
      LET g_xrgd_m.xrgdcrtid = g_user
      LET g_xrgd_m.xrgdcrtdp = g_dept 
      LET g_xrgd_m.xrgdcrtdt = cl_get_current()
      LET g_xrgd_m.xrgdmodid = g_user
      LET g_xrgd_m.xrgdmoddt = cl_get_current()
      LET g_xrgd_m.xrgdstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrgd_m.xrgdstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_xrgd_m.xrgdcomp_desc = ''
   DISPLAY BY NAME g_xrgd_m.xrgdcomp_desc
 
   
   CALL axrt520_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xrgd_m.* TO NULL
      INITIALIZE g_xrge_d TO NULL
      INITIALIZE g_xrge2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axrt520_show()
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
   CALL axrt520_set_act_visible()   
   CALL axrt520_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xrgdcomp_t = g_xrgd_m.xrgdcomp
   LET g_xrgddocno_t = g_xrgd_m.xrgddocno
   LET g_xrgd900_t = g_xrgd_m.xrgd900
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrgdent = " ||g_enterprise|| " AND",
                      " xrgdcomp = '", g_xrgd_m.xrgdcomp, "' "
                      ," AND xrgddocno = '", g_xrgd_m.xrgddocno, "' "
                      ," AND xrgd900 = '", g_xrgd_m.xrgd900, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axrt520_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axrt520_idx_chk()
   
   LET g_data_owner = g_xrgd_m.xrgdownid      
   LET g_data_dept  = g_xrgd_m.xrgdowndp
   
   #功能已完成,通報訊息中心
   CALL axrt520_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axrt520.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axrt520_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xrge_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE apgc_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axrt520_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrge_t
    WHERE xrgeent = g_enterprise AND xrgecomp = g_xrgdcomp_t
     AND xrgedocno = g_xrgddocno_t
     AND xrge900 = g_xrgd900_t
 
    INTO TEMP axrt520_detail
 
   #將key修正為調整後   
   UPDATE axrt520_detail 
      #更新key欄位
      SET xrgecomp = g_xrgd_m.xrgdcomp
          , xrgedocno = g_xrgd_m.xrgddocno
          , xrge900 = g_xrgd_m.xrgd900
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xrge_t SELECT * FROM axrt520_detail
   
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
   DROP TABLE axrt520_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apgc_t 
    WHERE apgcent = g_enterprise AND apgccomp = g_xrgdcomp_t
      AND apgcdocno = g_xrgddocno_t   
      AND apgc900 = g_xrgd900_t   
 
    INTO TEMP axrt520_detail
 
   #將key修正為調整後   
   UPDATE axrt520_detail SET apgccomp = g_xrgd_m.xrgdcomp
                                       , apgcdocno = g_xrgd_m.xrgddocno
                                       , apgc900 = g_xrgd_m.xrgd900
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO apgc_t SELECT * FROM axrt520_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axrt520_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xrgdcomp_t = g_xrgd_m.xrgdcomp
   LET g_xrgddocno_t = g_xrgd_m.xrgddocno
   LET g_xrgd900_t = g_xrgd_m.xrgd900
 
   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axrt520_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xrgd_m.xrgdcomp IS NULL
   OR g_xrgd_m.xrgddocno IS NULL
   OR g_xrgd_m.xrgd900 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axrt520_cl USING g_enterprise,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt520_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axrt520_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axrt520_master_referesh USING g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900 INTO g_xrgd_m.xrgdcomp, 
       g_xrgd_m.xrgd005,g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt, 
       g_xrgd_m.xrgd003,g_xrgd_m.xrgd004,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus, 
       g_xrgd_m.xrgdownid,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdt, 
       g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid, 
       g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd009,g_xrgd_m.xrgd022,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
       g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100, 
       g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.xrgd101,g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016, 
       g_xrgd_m.xrgd017,g_xrgd_m.xrgd018,g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021,g_xrgd_m.xrgd005_desc, 
       g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp_desc,g_xrgd_m.xrgdcrtid_desc, 
       g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdmodid_desc,g_xrgd_m.xrgdcnfid_desc,g_xrgd_m.xrgdpstid_desc, 
       g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022_desc,g_xrgd_m.xrgd016_desc
   
   
   #檢查是否允許此動作
   IF NOT axrt520_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xrgd_m_mask_o.* =  g_xrgd_m.*
   CALL axrt520_xrgd_t_mask()
   LET g_xrgd_m_mask_n.* =  g_xrgd_m.*
   
   CALL axrt520_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt520_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xrgdcomp_t = g_xrgd_m.xrgdcomp
      LET g_xrgddocno_t = g_xrgd_m.xrgddocno
      LET g_xrgd900_t = g_xrgd_m.xrgd900
 
 
      DELETE FROM xrgd_t
       WHERE xrgdent = g_enterprise AND xrgdcomp = g_xrgd_m.xrgdcomp
         AND xrgddocno = g_xrgd_m.xrgddocno
         AND xrgd900 = g_xrgd_m.xrgd900
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xrgd_m.xrgdcomp,":",SQLERRMESSAGE  
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
      
      DELETE FROM xrge_t
       WHERE xrgeent = g_enterprise AND xrgecomp = g_xrgd_m.xrgdcomp
         AND xrgedocno = g_xrgd_m.xrgddocno
         AND xrge900 = g_xrgd_m.xrgd900
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrge_t:",SQLERRMESSAGE 
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
      DELETE FROM apgc_t
       WHERE apgcent = g_enterprise AND
             apgccomp = g_xrgd_m.xrgdcomp AND apgcdocno = g_xrgd_m.xrgddocno AND apgc900 = g_xrgd_m.xrgd900
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      DELETE FROM xrgh_t
       WHERE xrghent = g_enterprise AND xrghcomp = g_xrgd_m.xrgdcomp
         AND xrghdocno = g_xrgd_m.xrgddocno
         AND xrgh001 = g_xrgd_m.xrgd900
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xrgd_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axrt520_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xrge_d.clear() 
      CALL g_xrge2_d.clear()       
 
     
      CALL axrt520_ui_browser_refresh()  
      #CALL axrt520_ui_headershow()  
      #CALL axrt520_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axrt520_browser_fill("")
         CALL axrt520_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axrt520_cl
 
   #功能已完成,通報訊息中心
   CALL axrt520_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axrt520.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrt520_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_ld       LIKE glaa_t.glaald
   DEFINE l_glaa005  LIKE glaa_t.glaa005
   DEFINE l_ooef019  LIKE ooef_t.ooef019
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   LET l_ld = NULL    LET l_glaa005 = NULL
   SELECT glaald ,glaa005 INTO l_ld,l_glaa005
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_xrgd_m.xrgdcomp
      AND glaa014 = 'Y'
   
   LET l_ooef019 = NULL
   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_xrgd_m.xrgdcomp
   #end add-point
   
   #清空第一階單身
   CALL g_xrge_d.clear()
   CALL g_xrge2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF axrt520_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrgeseq,xrgeorga,xrge001,xrge002,xrge003,xrge004,xrge005,xrge008, 
             xrge006,xrge007,xrge100,xrge101,xrge009,xrge105,xrge115,xrge901,xrge902,xrge903 ,t1.ooefl003 FROM xrge_t", 
                
                     " INNER JOIN xrgd_t ON xrgdent = " ||g_enterprise|| " AND xrgdcomp = xrgecomp ",
                     " AND xrgddocno = xrgedocno ",
                     " AND xrgd900 = xrge900 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=xrgeorga AND t1.ooefl002='"||g_dlang||"' ",
 
                     " WHERE xrgeent=? AND xrgecomp=? AND xrgedocno=? AND xrge900=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xrge_t.xrgeseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axrt520_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axrt520_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900 INTO g_xrge_d[l_ac].xrgeseq, 
          g_xrge_d[l_ac].xrgeorga,g_xrge_d[l_ac].xrge001,g_xrge_d[l_ac].xrge002,g_xrge_d[l_ac].xrge003, 
          g_xrge_d[l_ac].xrge004,g_xrge_d[l_ac].xrge005,g_xrge_d[l_ac].xrge008,g_xrge_d[l_ac].xrge006, 
          g_xrge_d[l_ac].xrge007,g_xrge_d[l_ac].xrge100,g_xrge_d[l_ac].xrge101,g_xrge_d[l_ac].xrge009, 
          g_xrge_d[l_ac].xrge105,g_xrge_d[l_ac].xrge115,g_xrge_d[l_ac].xrge901,g_xrge_d[l_ac].xrge902, 
          g_xrge_d[l_ac].xrge903,g_xrge_d[l_ac].xrgeorga_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL axrt520_detail_color(l_ac)
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
   IF axrt520_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apgcseq,apgcorga,apgc001,apgc002,apgc003,apgc005,apgc014,apgc100, 
             apgc101,apgc006,apgc007,apgc008,apgc009,apgc010,apgc011,apgc103,apgc104,apgc105,apgc113, 
             apgc114,apgc115,apgc004,apgc015,apgc016,apgc012,apgc013 ,t2.oocql004 ,t3.nmajl003 FROM apgc_t", 
                
                     " INNER JOIN  xrgd_t ON xrgdent = " ||g_enterprise|| " AND xrgdcomp = apgccomp ",
                     " AND xrgddocno = apgcdocno ",
                     " AND xrgd900 = apgc900 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='3117' AND t2.oocql002=apgc001 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t3 ON t3.nmajlent="||g_enterprise||" AND t3.nmajl001=apgc015 AND t3.nmajl002='"||g_dlang||"' ",
 
                     " WHERE apgcent=? AND apgccomp=? AND apgcdocno=? AND apgc900=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apgc_t.apgcseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axrt520_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR axrt520_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900 INTO g_xrge2_d[l_ac].apgcseq, 
          g_xrge2_d[l_ac].apgcorga,g_xrge2_d[l_ac].apgc001,g_xrge2_d[l_ac].apgc002,g_xrge2_d[l_ac].apgc003, 
          g_xrge2_d[l_ac].apgc005,g_xrge2_d[l_ac].apgc014,g_xrge2_d[l_ac].apgc100,g_xrge2_d[l_ac].apgc101, 
          g_xrge2_d[l_ac].apgc006,g_xrge2_d[l_ac].apgc007,g_xrge2_d[l_ac].apgc008,g_xrge2_d[l_ac].apgc009, 
          g_xrge2_d[l_ac].apgc010,g_xrge2_d[l_ac].apgc011,g_xrge2_d[l_ac].apgc103,g_xrge2_d[l_ac].apgc104, 
          g_xrge2_d[l_ac].apgc105,g_xrge2_d[l_ac].apgc113,g_xrge2_d[l_ac].apgc114,g_xrge2_d[l_ac].apgc115, 
          g_xrge2_d[l_ac].apgc004,g_xrge2_d[l_ac].apgc015,g_xrge2_d[l_ac].apgc016,g_xrge2_d[l_ac].apgc012, 
          g_xrge2_d[l_ac].apgc013,g_xrge2_d[l_ac].apgc001_desc,g_xrge2_d[l_ac].apgc015_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL s_desc_get_account_desc(l_ld,g_xrge2_d[l_ac].apgc004) RETURNING g_xrge2_d[l_ac].apgc004_desc
         LET g_xrge2_d[l_ac].apgc015_desc = s_desc_get_nmajl003_desc(g_xrge2_d[l_ac].apgc015)
         LET g_xrge2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_xrge2_d[l_ac].apgc016) 
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
   
   CALL g_xrge_d.deleteElement(g_xrge_d.getLength())
   CALL g_xrge2_d.deleteElement(g_xrge2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axrt520_pb
   FREE axrt520_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xrge_d.getLength()
      LET g_xrge_d_mask_o[l_ac].* =  g_xrge_d[l_ac].*
      CALL axrt520_xrge_t_mask()
      LET g_xrge_d_mask_n[l_ac].* =  g_xrge_d[l_ac].*
   END FOR
   
   LET g_xrge2_d_mask_o.* =  g_xrge2_d.*
   FOR l_ac = 1 TO g_xrge2_d.getLength()
      LET g_xrge2_d_mask_o[l_ac].* =  g_xrge2_d[l_ac].*
      CALL axrt520_apgc_t_mask()
      LET g_xrge2_d_mask_n[l_ac].* =  g_xrge2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axrt520.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axrt520_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM xrge_t
       WHERE xrgeent = g_enterprise AND
         xrgecomp = ps_keys_bak[1] AND xrgedocno = ps_keys_bak[2] AND xrge900 = ps_keys_bak[3] AND xrgeseq = ps_keys_bak[4]
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
         CALL g_xrge_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM apgc_t
       WHERE apgcent = g_enterprise AND
             apgccomp = ps_keys_bak[1] AND apgcdocno = ps_keys_bak[2] AND apgc900 = ps_keys_bak[3] AND apgcseq = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xrge2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axrt520_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE l_count     LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM xrgb_t
       WHERE xrgbent = g_enterprise
         AND xrgbcomp = g_xrgd_m.xrgdcomp
         AND xrgbdocno = g_xrgd_m.xrgddocno
         AND xrgbseq   = g_xrge_d[l_ac].xrgeseq
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET g_xrge_d[l_ac].xrge901 = '3'
      ELSE
         LET g_xrge_d[l_ac].xrge901 = '2'
      END IF
      #end add-point 
      INSERT INTO xrge_t
                  (xrgeent,
                   xrgecomp,xrgedocno,xrge900,
                   xrgeseq
                   ,xrgeorga,xrge001,xrge002,xrge003,xrge004,xrge005,xrge008,xrge006,xrge007,xrge100,xrge101,xrge009,xrge105,xrge115,xrge901,xrge902,xrge903) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_xrge_d[g_detail_idx].xrgeorga,g_xrge_d[g_detail_idx].xrge001,g_xrge_d[g_detail_idx].xrge002, 
                       g_xrge_d[g_detail_idx].xrge003,g_xrge_d[g_detail_idx].xrge004,g_xrge_d[g_detail_idx].xrge005, 
                       g_xrge_d[g_detail_idx].xrge008,g_xrge_d[g_detail_idx].xrge006,g_xrge_d[g_detail_idx].xrge007, 
                       g_xrge_d[g_detail_idx].xrge100,g_xrge_d[g_detail_idx].xrge101,g_xrge_d[g_detail_idx].xrge009, 
                       g_xrge_d[g_detail_idx].xrge105,g_xrge_d[g_detail_idx].xrge115,g_xrge_d[g_detail_idx].xrge901, 
                       g_xrge_d[g_detail_idx].xrge902,g_xrge_d[g_detail_idx].xrge903)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrge_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xrge_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO apgc_t
                  (apgcent,
                   apgccomp,apgcdocno,apgc900,
                   apgcseq
                   ,apgcorga,apgc001,apgc002,apgc003,apgc005,apgc014,apgc100,apgc101,apgc006,apgc007,apgc008,apgc009,apgc010,apgc011,apgc103,apgc104,apgc105,apgc113,apgc114,apgc115,apgc004,apgc015,apgc016,apgc012,apgc013) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_xrge2_d[g_detail_idx].apgcorga,g_xrge2_d[g_detail_idx].apgc001,g_xrge2_d[g_detail_idx].apgc002, 
                       g_xrge2_d[g_detail_idx].apgc003,g_xrge2_d[g_detail_idx].apgc005,g_xrge2_d[g_detail_idx].apgc014, 
                       g_xrge2_d[g_detail_idx].apgc100,g_xrge2_d[g_detail_idx].apgc101,g_xrge2_d[g_detail_idx].apgc006, 
                       g_xrge2_d[g_detail_idx].apgc007,g_xrge2_d[g_detail_idx].apgc008,g_xrge2_d[g_detail_idx].apgc009, 
                       g_xrge2_d[g_detail_idx].apgc010,g_xrge2_d[g_detail_idx].apgc011,g_xrge2_d[g_detail_idx].apgc103, 
                       g_xrge2_d[g_detail_idx].apgc104,g_xrge2_d[g_detail_idx].apgc105,g_xrge2_d[g_detail_idx].apgc113, 
                       g_xrge2_d[g_detail_idx].apgc114,g_xrge2_d[g_detail_idx].apgc115,g_xrge2_d[g_detail_idx].apgc004, 
                       g_xrge2_d[g_detail_idx].apgc015,g_xrge2_d[g_detail_idx].apgc016,g_xrge2_d[g_detail_idx].apgc012, 
                       g_xrge2_d[g_detail_idx].apgc013)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xrge2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axrt520_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   DEFINE l_count          LIKE type_t.num10
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xrge_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM xrgb_t
       WHERE xrgbent = g_enterprise
         AND xrgbcomp = g_xrgd_m.xrgdcomp
         AND xrgbdocno = g_xrgd_m.xrgddocno
         AND xrgbseq   = g_xrge_d[g_detail_idx].xrgeseq
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET g_xrge_d[g_detail_idx].xrge901 = '3'
      ELSE
         LET g_xrge_d[g_detail_idx].xrge901 = '2'
      END IF
      #end add-point 
      
      #將遮罩欄位還原
      CALL axrt520_xrge_t_mask_restore('restore_mask_o')
               
      UPDATE xrge_t 
         SET (xrgecomp,xrgedocno,xrge900,
              xrgeseq
              ,xrgeorga,xrge001,xrge002,xrge003,xrge004,xrge005,xrge008,xrge006,xrge007,xrge100,xrge101,xrge009,xrge105,xrge115,xrge901,xrge902,xrge903) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_xrge_d[g_detail_idx].xrgeorga,g_xrge_d[g_detail_idx].xrge001,g_xrge_d[g_detail_idx].xrge002, 
                  g_xrge_d[g_detail_idx].xrge003,g_xrge_d[g_detail_idx].xrge004,g_xrge_d[g_detail_idx].xrge005, 
                  g_xrge_d[g_detail_idx].xrge008,g_xrge_d[g_detail_idx].xrge006,g_xrge_d[g_detail_idx].xrge007, 
                  g_xrge_d[g_detail_idx].xrge100,g_xrge_d[g_detail_idx].xrge101,g_xrge_d[g_detail_idx].xrge009, 
                  g_xrge_d[g_detail_idx].xrge105,g_xrge_d[g_detail_idx].xrge115,g_xrge_d[g_detail_idx].xrge901, 
                  g_xrge_d[g_detail_idx].xrge902,g_xrge_d[g_detail_idx].xrge903) 
         WHERE xrgeent = g_enterprise AND xrgecomp = ps_keys_bak[1] AND xrgedocno = ps_keys_bak[2] AND xrge900 = ps_keys_bak[3] AND xrgeseq = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrge_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrge_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axrt520_xrge_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apgc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axrt520_apgc_t_mask_restore('restore_mask_o')
               
      UPDATE apgc_t 
         SET (apgccomp,apgcdocno,apgc900,
              apgcseq
              ,apgcorga,apgc001,apgc002,apgc003,apgc005,apgc014,apgc100,apgc101,apgc006,apgc007,apgc008,apgc009,apgc010,apgc011,apgc103,apgc104,apgc105,apgc113,apgc114,apgc115,apgc004,apgc015,apgc016,apgc012,apgc013) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_xrge2_d[g_detail_idx].apgcorga,g_xrge2_d[g_detail_idx].apgc001,g_xrge2_d[g_detail_idx].apgc002, 
                  g_xrge2_d[g_detail_idx].apgc003,g_xrge2_d[g_detail_idx].apgc005,g_xrge2_d[g_detail_idx].apgc014, 
                  g_xrge2_d[g_detail_idx].apgc100,g_xrge2_d[g_detail_idx].apgc101,g_xrge2_d[g_detail_idx].apgc006, 
                  g_xrge2_d[g_detail_idx].apgc007,g_xrge2_d[g_detail_idx].apgc008,g_xrge2_d[g_detail_idx].apgc009, 
                  g_xrge2_d[g_detail_idx].apgc010,g_xrge2_d[g_detail_idx].apgc011,g_xrge2_d[g_detail_idx].apgc103, 
                  g_xrge2_d[g_detail_idx].apgc104,g_xrge2_d[g_detail_idx].apgc105,g_xrge2_d[g_detail_idx].apgc113, 
                  g_xrge2_d[g_detail_idx].apgc114,g_xrge2_d[g_detail_idx].apgc115,g_xrge2_d[g_detail_idx].apgc004, 
                  g_xrge2_d[g_detail_idx].apgc015,g_xrge2_d[g_detail_idx].apgc016,g_xrge2_d[g_detail_idx].apgc012, 
                  g_xrge2_d[g_detail_idx].apgc013) 
         WHERE apgcent = g_enterprise AND apgccomp = ps_keys_bak[1] AND apgcdocno = ps_keys_bak[2] AND apgc900 = ps_keys_bak[3] AND apgcseq = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apgc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axrt520_apgc_t_mask_restore('restore_mask_n')
 
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
 
{<section id="axrt520.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axrt520_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="axrt520.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axrt520_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axrt520.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axrt520_lock_b(ps_table,ps_page)
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
   #CALL axrt520_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "xrge_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axrt520_bcl USING g_enterprise,
                                       g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrge_d[g_detail_idx].xrgeseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axrt520_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "apgc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axrt520_bcl2 USING g_enterprise,
                                             g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrge2_d[g_detail_idx].apgcseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axrt520_bcl2:",SQLERRMESSAGE 
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
 
{<section id="axrt520.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axrt520_unlock_b(ps_table,ps_page)
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
      CLOSE axrt520_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axrt520_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axrt520.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axrt520_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xrgddocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xrgdcomp,xrgddocno,xrgd900",TRUE)
      CALL cl_set_comp_entry("xrgddocdt",TRUE)
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
 
{<section id="axrt520.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axrt520_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xrgdcomp,xrgddocno,xrgd900",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xrgddocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("xrgddocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   CALL cl_set_comp_entry("xrgdcomp,xrgd900",FALSE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axrt520.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axrt520_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("apgc101",TRUE)   #160926-00018#1 
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axrt520.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axrt520_set_no_entry_b(p_cmd)
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
   #160926-00018#1-----s
   IF g_xrge2_d[l_ac].apgc100 = g_xrgd_m.xrgd100 THEN
      CALL cl_set_comp_entry("apgc101",FALSE) 
   END IF   
   
   IF g_xrge2_d[l_ac].apgc100 = g_xrgd_m.l_glaa001 THEN
      CALL cl_set_comp_entry("apgc101",FALSE) 
   END IF   
   #160926-00018#1-----e
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="axrt520.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axrt520_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axrt520_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_xrgd_m.xrgdstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF



   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axrt520_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axrt520_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axrt520_default_search()
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
      LET ls_wc = ls_wc, " xrgdcomp = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xrgddocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xrgd900 = '", g_argv[03], "' AND "
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
               WHEN la_wc[li_idx].tableid = "xrgd_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xrge_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apgc_t" 
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
 
{<section id="axrt520.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axrt520_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xrgd_m.xrgdcomp IS NULL
      OR g_xrgd_m.xrgddocno IS NULL      OR g_xrgd_m.xrgd900 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axrt520_cl USING g_enterprise,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900
   IF STATUS THEN
      CLOSE axrt520_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt520_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axrt520_master_referesh USING g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900 INTO g_xrgd_m.xrgdcomp, 
       g_xrgd_m.xrgd005,g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt, 
       g_xrgd_m.xrgd003,g_xrgd_m.xrgd004,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus, 
       g_xrgd_m.xrgdownid,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdt, 
       g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid, 
       g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd009,g_xrgd_m.xrgd022,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
       g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100, 
       g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.xrgd101,g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016, 
       g_xrgd_m.xrgd017,g_xrgd_m.xrgd018,g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021,g_xrgd_m.xrgd005_desc, 
       g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp_desc,g_xrgd_m.xrgdcrtid_desc, 
       g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdmodid_desc,g_xrgd_m.xrgdcnfid_desc,g_xrgd_m.xrgdpstid_desc, 
       g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022_desc,g_xrgd_m.xrgd016_desc
   
 
   #檢查是否允許此動作
   IF NOT axrt520_action_chk() THEN
      CLOSE axrt520_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrgd_m.xrgdcomp,g_xrgd_m.xrgdcomp_desc,g_xrgd_m.xrgd005,g_xrgd_m.xrgd005_desc,g_xrgd_m.xrgd006, 
       g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt,g_xrgd_m.xrgd003,g_xrgd_m.xrgd004, 
       g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus,g_xrgd_m.xrgdownid, 
       g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdowndp_desc,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtid_desc, 
       g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdcrtdt,g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmodid_desc, 
       g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfid_desc,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid, 
       g_xrgd_m.xrgdpstid_desc,g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009, 
       g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022,g_xrgd_m.xrgd022_desc,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
       g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100, 
       g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.l_xrga104diff,g_xrgd_m.l_glaa001,g_xrgd_m.xrgd101, 
       g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016,g_xrgd_m.xrgd016_desc,g_xrgd_m.xrgd017,g_xrgd_m.xrgd018, 
       g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021
 
   CASE g_xrgd_m.xrgdstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_xrgd_m.xrgdstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("invalid,confirmed",TRUE)
      CALL cl_set_act_visible("unconfirmed,closed",FALSE)
      
      CASE g_xrgd_m.xrgdstus
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
            CALL s_transaction_end('N','0')      #150401-00001#13
            RETURN


         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      #end add-point
      
      
	  
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
      AND lc_state <> "X"
      ) OR 
      g_xrgd_m.xrgdstus = lc_state OR cl_null(lc_state) THEN
      CLOSE axrt520_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      CALL cl_err_collect_init()
      IF NOT s_axrt520_conf_chk(g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900) THEN
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
            IF NOT s_axrt520_conf_upd(g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900) THEN
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
      CALL cl_err_collect_init()
      IF NOT s_axrt520_void_chk(g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900)  THEN
        CALL s_transaction_end('N','0')      
        CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')     
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_axrt520_void_upd(g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900) THEN
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
   #end add-point
   
   LET g_xrgd_m.xrgdmodid = g_user
   LET g_xrgd_m.xrgdmoddt = cl_get_current()
   LET g_xrgd_m.xrgdstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xrgd_t 
      SET (xrgdstus,xrgdmodid,xrgdmoddt) 
        = (g_xrgd_m.xrgdstus,g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmoddt)     
    WHERE xrgdent = g_enterprise AND xrgdcomp = g_xrgd_m.xrgdcomp
      AND xrgddocno = g_xrgd_m.xrgddocno      AND xrgd900 = g_xrgd_m.xrgd900
    
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
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE axrt520_master_referesh USING g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900 INTO g_xrgd_m.xrgdcomp, 
          g_xrgd_m.xrgd005,g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt, 
          g_xrgd_m.xrgd003,g_xrgd_m.xrgd004,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025,g_xrgd_m.xrgdstus, 
          g_xrgd_m.xrgdownid,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdt, 
          g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid, 
          g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008,g_xrgd_m.xrgd009,g_xrgd_m.xrgd022,g_xrgd_m.xrgd007,g_xrgd_m.xrgd010, 
          g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014,g_xrgd_m.xrgd023,g_xrgd_m.xrgd100, 
          g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.xrgd101,g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016, 
          g_xrgd_m.xrgd017,g_xrgd_m.xrgd018,g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021,g_xrgd_m.xrgd005_desc, 
          g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp_desc,g_xrgd_m.xrgdcrtid_desc, 
          g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdmodid_desc,g_xrgd_m.xrgdcnfid_desc,g_xrgd_m.xrgdpstid_desc, 
          g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022_desc,g_xrgd_m.xrgd016_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xrgd_m.xrgdcomp,g_xrgd_m.xrgdcomp_desc,g_xrgd_m.xrgd005,g_xrgd_m.xrgd005_desc, 
          g_xrgd_m.xrgd006,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,g_xrgd_m.xrgd002,g_xrgd_m.xrgddocdt,g_xrgd_m.xrgd003, 
          g_xrgd_m.xrgd004,g_xrgd_m.xrgd004_desc,g_xrgd_m.xrgd001,g_xrgd_m.xrgd024,g_xrgd_m.xrgd025, 
          g_xrgd_m.xrgdstus,g_xrgd_m.xrgdownid,g_xrgd_m.xrgdownid_desc,g_xrgd_m.xrgdowndp,g_xrgd_m.xrgdowndp_desc, 
          g_xrgd_m.xrgdcrtid,g_xrgd_m.xrgdcrtid_desc,g_xrgd_m.xrgdcrtdp,g_xrgd_m.xrgdcrtdp_desc,g_xrgd_m.xrgdcrtdt, 
          g_xrgd_m.xrgdmodid,g_xrgd_m.xrgdmodid_desc,g_xrgd_m.xrgdmoddt,g_xrgd_m.xrgdcnfid,g_xrgd_m.xrgdcnfid_desc, 
          g_xrgd_m.xrgdcnfdt,g_xrgd_m.xrgdpstid,g_xrgd_m.xrgdpstid_desc,g_xrgd_m.xrgdpstdt,g_xrgd_m.xrgd008, 
          g_xrgd_m.xrgd008_desc,g_xrgd_m.xrgd009,g_xrgd_m.xrgd009_desc,g_xrgd_m.xrgd022,g_xrgd_m.xrgd022_desc, 
          g_xrgd_m.xrgd007,g_xrgd_m.xrgd010,g_xrgd_m.xrgd013,g_xrgd_m.xrgd012,g_xrgd_m.xrgd011,g_xrgd_m.xrgd014, 
          g_xrgd_m.xrgd023,g_xrgd_m.xrgd100,g_xrgd_m.xrgd103,g_xrgd_m.xrgd104,g_xrgd_m.l_xrga104diff, 
          g_xrgd_m.l_glaa001,g_xrgd_m.xrgd101,g_xrgd_m.xrgd113,g_xrgd_m.xrgd015,g_xrgd_m.xrgd016,g_xrgd_m.xrgd016_desc, 
          g_xrgd_m.xrgd017,g_xrgd_m.xrgd018,g_xrgd_m.xrgd019,g_xrgd_m.xrgd020,g_xrgd_m.xrgd021
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE axrt520_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axrt520_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt520.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axrt520_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xrge_d.getLength() THEN
         LET g_detail_idx = g_xrge_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xrge_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrge_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xrge2_d.getLength() THEN
         LET g_detail_idx = g_xrge2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xrge2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrge2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrt520_b_fill2(pi_idx)
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
   
   CALL axrt520_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axrt520_fill_chk(ps_idx)
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
 
{<section id="axrt520.status_show" >}
PRIVATE FUNCTION axrt520_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrt520.mask_functions" >}
&include "erp/axr/axrt520_mask.4gl"
 
{</section>}
 
{<section id="axrt520.signature" >}
   
 
{</section>}
 
{<section id="axrt520.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axrt520_set_pk_array()
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
   LET g_pk_array[1].values = g_xrgd_m.xrgdcomp
   LET g_pk_array[1].column = 'xrgdcomp'
   LET g_pk_array[2].values = g_xrgd_m.xrgddocno
   LET g_pk_array[2].column = 'xrgddocno'
   LET g_pk_array[3].values = g_xrgd_m.xrgd900
   LET g_pk_array[3].column = 'xrgd900'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt520.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axrt520.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axrt520_msgcentre_notify(lc_state)
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
   CALL axrt520_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xrgd_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt520.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axrt520_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axrt520.other_function" readonly="Y" >}

PRIVATE FUNCTION axrt520_xrge001_002_chk(p_orga,p_xrga004,p_docno,p_seq)
   DEFINE p_orga   LIKE ooef_t.ooef001
   DEFINE p_xrga004 LIKE xrga_t.xrga004
   DEFINE p_docno   LIKE xrgb_t.xrgb001
   DEFINE p_seq     LIKE xrgb_t.xrgb002   
   DEFINE r_success LIKE type_t.num5
   DEFINE r_errno   LIKE gzze_t.gzze001
   DEFINE l_site    LIKE ooef_t.ooef001
   DEFINE l_stus    LIKE pmdl_t.pmdlstus 
   DEFINE l_cust    LIKE pmdl_t.pmdl021
   DEFINE l_docdt   LIKE pmdl_t.pmdldocdt
   
   LET r_success = TRUE
   LET r_errno = ''
   
   
   LET l_site = NULL LET l_stus = NULL
   LET l_cust = NULL LET l_docdt = NULL
   IF cl_null(p_seq) THEN
      SELECT xmdastus,xmdasite,xmda004,xmdadocdt
        INTO l_stus,l_site,l_cust,l_docdt
        FROM xmda_t
       WHERE xmdaent   = g_enterprise
         AND xmdadocno = p_docno
   ELSE
      SELECT DISTINCT xmdastus,xmdasite,xmda004,xmdadocdt
        INTO l_stus,l_site,l_cust,l_docdt
        FROM xmda_t,xmdc_t
       WHERE xmdaent   = g_enterprise
         AND xmdadocno = p_docno AND xmdcseq = p_seq
         AND xmdaent = xmdcent AND xmdadocno = xmdcdocno
   END IF   
   
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_errno = 'aap-00051'#無此單據
         LET r_success = FALSE
      WHEN l_stus <> 'Y'          #不為已確認
         LET r_errno = 'aap-00074'
      WHEN NOT cl_null(p_xrga004)
         IF l_cust <> p_xrga004 THEN
            LET r_errno = 'aap-00067'
            LET r_success = FALSE
         END IF
      WHEN NOT cl_null(p_orga) OR (p_orga <> l_site)
         LET r_errno   ='aap-00274'
         LET r_success = FALSE
   END CASE      
   
   RETURN r_success,r_errno
END FUNCTION

PRIVATE FUNCTION axrt520_xrge001_002_carry(p_ac)
   DEFINE l_xmdc   RECORD
                   xmdc001   LIKE xmdc_t.xmdc001,
                   xmdc010   LIKE xmdc_t.xmdc010,
                   xmdc016   LIKE xmdc_t.xmdc016,
                   xmdc011   LIKE xmdc_t.xmdc011,
                   xmdc047   LIKE xmdc_t.xmdc047
                   END RECORD
   DEFINE p_ac   LIKE type_t.num10
   DEFINE l_ld   LIKE glaa_t.glaald
   DEFINE l_pmdn047   LIKE pmdn_t.pmdn047
   DEFINE l_pmdn007   LIKE pmdn_t.pmdn007
   DEFINE l_glaa001   LIKE glaa_t.glaa001
   DEFINE l_oodb004   LIKE oodb_t.oodb004
   DEFINE l_apca013   LIKE apca_t.apca013
   DEFINE l_apca012   LIKE apca_t.apca012
   DEFINE l_oodb011   LIKE oodb_t.oodb011   

   DEFINE l_xrge0041 LIKE xrge_t.xrge004
   DEFINE l_xrge0042 LIKE xrge_t.xrge004
   DEFINE l_dummy2   LIKE type_t.num20_6
   DEFINE l_dummy3   LIKE type_t.num20_6
   DEFINE ls_js      STRING
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004
                    END RECORD

   IF cl_null(p_ac) OR p_ac <= 0 THEN RETURN END IF
   
   LET l_ld = NULL   LET l_glaa001 = NULL
   SELECT glaald ,glaa001
     INTO l_ld ,l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_xrgd_m.xrgdcomp
      AND glaa014 = 'Y'   
   
   INITIALIZE l_xmdc.* TO NULL
   SELECT xmdc001,xmdc010,xmdc016,
          xmdc011,xmdc047
     INTO l_xmdc.*
     FROM xmdc_t
    WHERE xmdcent   = g_enterprise
      AND xmdcdocno = g_xrge_d[l_ac].xrge001
      AND xmdcseq   = g_xrge_d[l_ac].xrge002
   IF cl_null(l_xmdc.xmdc011)THEN LET l_xmdc.xmdc011 = 0 END IF
   IF cl_null(l_xmdc.xmdc047)THEN LET l_xmdc.xmdc047 = 0 END IF
   LET g_xrge_d[l_ac].xrge003 = l_xmdc.xmdc001
   
   CALL s_desc_get_item_desc(l_xmdc.xmdc001) RETURNING l_xrge0041,l_xrge0042
   CASE
      WHEN NOT cl_null(l_xrge0041) AND NOT cl_null(l_xrge0042)
         LET g_xrge_d[l_ac].xrge004 = l_xrge0041,'/',l_xrge0042
      OTHERWISE
         LET g_xrge_d[l_ac].xrge004 = l_xrge0041 CLIPPED,l_xrge0042
   END CASE
   LET g_xrge_d[l_ac].xrge005 = l_xmdc.xmdc010
   LET g_xrge_d[l_ac].xrge006 = l_xmdc.xmdc016
   
   
   CALL s_tax_chk(g_xrgd_m.xrgdcomp,g_xrge_d[p_ac].xrge006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
   LET g_xrge_d[p_ac].xrge007 = l_apca013
   
   LET g_xrge_d[p_ac].xrge008 = l_xmdc.xmdc011
   LET g_xrge_d[p_ac].xrge105 = l_xmdc.xmdc047
   
   IF g_xrge_d[p_ac].xrge008  = 0 THEN
      LET g_xrge_d[p_ac].xrge009 = 0
   ELSE
      LET g_xrge_d[p_ac].xrge009 = g_xrge_d[p_ac].xrge105 / g_xrge_d[p_ac].xrge008 
   END IF
   #取位(原幣)
   CALL s_curr_round_ld('1',l_ld,g_xrgd_m.xrgd100,g_xrge_d[p_ac].xrge009,1) RETURNING g_sub_success,g_errno,g_xrge_d[l_ac].xrge009
   #LET g_xrge_d[p_ac].xrge010 = 0   
   
   LET g_xrge_d[p_ac].xrge100 = NULL
   SELECT xmda015 INTO g_xrge_d[p_ac].xrge100 FROM xmda_t
    WHERE xmdaent = g_enterprise
      AND xmdadocno = g_xrge_d[p_ac].xrge001
      
   ##本幣含稅金額
   #LET g_xrge_d[p_ac].xrge115 = g_xrge_d[p_ac].xrge105 * g_xrgd_m.xrgd101
   LET g_xrge_d[p_ac].xrge101 = ''  #170119-00024#10 add
   LET g_xrge_d[p_ac].xrge115 = ''  #170119-00024#10 add
   IF NOT g_xrge_d[p_ac].xrge100 = g_xrgd_m.xrgd100 THEN
      LET lc_param.apca004 = g_xrgd_m.xrgd004
      LET ls_js = util.JSON.stringify(lc_param)
      CALL s_fin_get_curr_rate(g_xrgd_m.xrgdcomp,l_ld,g_xrgd_m.xrgd003,g_xrge_d[p_ac].xrge100,ls_js)
                          RETURNING g_xrge_d[p_ac].xrge101,l_dummy2,l_dummy3
   ELSE
      LET g_xrge_d[p_ac].xrge101 = g_xrgd_m.xrgd101
   END IF
   LET g_xrge_d[p_ac].xrge115 = g_xrge_d[p_ac].xrge105 * g_xrge_d[p_ac].xrge101 

   #取位(本幣)
   CALL s_curr_round_ld('1',l_ld,l_glaa001,g_xrge_d[p_ac].xrge115,2) RETURNING g_sub_success,g_errno,g_xrge_d[l_ac].xrge115    
   
END FUNCTION

PRIVATE FUNCTION axrt520_to_o_b1(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   
   LET g_xrge_d_o.* = g_xrge_d[p_ac].*
END FUNCTION

PRIVATE FUNCTION axrt520_tax_ins_b2(p_ac)
DEFINE p_ac         LIKE type_t.num10
   DEFINE l_sfin4012   LIKE type_t.chr80
   DEFINE l_ld         LIKE glaa_t.glaald
   DEFINE l_dummy2     LIKE type_t.num20_6
   DEFINE l_dummy3     LIKE type_t.num20_6
   DEFINE l_glaa001    LIKE glaa_t.glaa001
   DEFINE l_oodb004    LIKE oodb_t.oodb004
   DEFINE l_oodb005    LIKE oodb_t.oodb005
   DEFINE l_oodb006    LIKE oodb_t.oodb006
   DEFINE l_oodb011    LIKE oodb_t.oodb011
   DEFINE l_apcb105    LIKE apcb_t.apcb105
   DEFINE ls_js         STRING
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004
                    END RECORD  

   LET l_ld = NULL
   SELECT glaald INTO l_ld FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_xrgd_m.xrgdcomp
      AND glaa014 = 'Y'
   
   #匯率修改產生s_tax
   IF NOT cl_null(g_xrge2_d[p_ac].apgc006) AND NOT cl_null(g_xrge2_d[p_ac].apgc100)
      AND NOT cl_null(g_xrge2_d[p_ac].apgc101) AND NOT cl_null(l_ld)
      THEN
      CALL s_tax_chk(g_xrge2_d[p_ac].apgcorga, g_xrge2_d[p_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_oodb005,l_oodb006,l_oodb011
      IF l_oodb005 = 'Y' THEN
         LET l_apcb105 = g_xrge2_d[p_ac].apgc105
      ELSE
         LET l_apcb105 = g_xrge2_d[p_ac].apgc103
      END IF
      #170119-00024#10 add(s)
      LET g_xrge2_d[p_ac].apgc103 = '' LET g_xrge2_d[p_ac].apgc104 = '' LET g_xrge2_d[p_ac].apgc105 = '' 
      LET g_xrge2_d[p_ac].apgc113 = '' LET g_xrge2_d[p_ac].apgc114 = '' LET g_xrge2_d[p_ac].apgc115 = '' 
      #170119-00024#10 add(e)
      CALL s_tax_ins(g_xrgd_m.xrgddocno,g_xrge2_d[p_ac].apgcseq,'0',g_xrge2_d[p_ac].apgcorga,l_apcb105,
                     g_xrge2_d[p_ac].apgc006,1,g_xrge2_d[p_ac].apgc100,g_xrge2_d[p_ac].apgc101,l_ld,1,1)
           RETURNING g_xrge2_d[p_ac].apgc103,g_xrge2_d[p_ac].apgc104,g_xrge2_d[p_ac].apgc105,
                     g_xrge2_d[p_ac].apgc113,g_xrge2_d[p_ac].apgc114,g_xrge2_d[p_ac].apgc115,
                     l_dummy2,l_dummy2,l_dummy2,
                     l_dummy3,l_dummy3,l_dummy3
   END IF
   DISPLAY BY NAME g_xrge2_d[p_ac].apgc006
END FUNCTION

PRIVATE FUNCTION axrt520_curr_recount_b2(p_ac)
   DEFINE p_ac         LIKE type_t.num10
   DEFINE l_sfin4012   LIKE type_t.chr80
   DEFINE l_ld         LIKE glaa_t.glaald
   DEFINE l_dummy2     LIKE type_t.num20_6
   DEFINE l_dummy3     LIKE type_t.num20_6
   DEFINE l_glaa001    LIKE glaa_t.glaa001
   DEFINE l_oodb004    LIKE oodb_t.oodb004
   DEFINE l_oodb005    LIKE oodb_t.oodb005
   DEFINE l_oodb006    LIKE oodb_t.oodb006
   DEFINE l_oodb011    LIKE oodb_t.oodb011
   DEFINE l_apcb105    LIKE apcb_t.apcb105
   DEFINE ls_js         STRING
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004
                    END RECORD
   
   
   LET l_ld = NULL LET l_glaa001 = NULL
   SELECT glaald ,glaa001
     INTO l_ld ,l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_xrgd_m.xrgdcomp
      AND glaa014 = 'Y'
   IF cl_null(p_ac) OR p_ac <=0 THEN RETURN END IF
   
   #有輸入交易帳戶時,取銀存支出匯率來源
   IF NOT cl_null(g_xrge2_d[l_ac].apgc014) THEN
      CALL cl_get_para(g_enterprise,g_xrgd_m.xrgdcomp,'S-FIN-4012') RETURNING l_sfin4012
   ELSE
      LET l_sfin4012 = ''
   END IF
   #160926-00018#1-----s
   IF g_xrge2_d[l_ac].apgc100 = l_glaa001 THEN
      LET g_xrge2_d[l_ac].apgc101 = 1
   ELSE
      IF g_xrge2_d[l_ac].apgc100 <> g_xrgd_m.xrgd100 THEN   
   #160926-00018#1-----e
         LET g_xrge2_d[l_ac].apgc101 = '' #170119-00024#10 add
         IF l_sfin4012  = '23' THEN
            #銀行日平均匯率
            CALL s_anm_get_exrate(l_ld,g_xrgd_m.xrgdcomp,g_xrge2_d[l_ac].apgc014,g_xrge2_d[l_ac].apgc100,l_glaa001,g_xrgd_m.xrgd003) RETURNING g_xrge2_d[l_ac].apgc101
         ELSE
            LET lc_param.apca004 = g_xrgd_m.xrgd004
            LET ls_js = util.JSON.stringify(lc_param)
            CALL s_fin_get_curr_rate(g_xrgd_m.xrgdcomp,l_ld,g_xrgd_m.xrgd003,g_xrge2_d[l_ac].apgc100,ls_js)
                 RETURNING g_xrge2_d[l_ac].apgc101,l_dummy2,l_dummy3
         END IF   
   #160824-00049#1-----s
      ELSE
         LET g_xrge2_d[l_ac].apgc101 = g_xrgd_m.xrgd101
      END IF
   END IF
   #160824-00049#1-----e
   
   CALL axrt520_tax_ins_b2(p_ac)
END FUNCTION

PRIVATE FUNCTION axrt520_to_o_b2(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   
   LET g_xrge2_d_o.* = g_xrge2_d[p_ac].*
END FUNCTION

PRIVATE FUNCTION axrt520_to_o_h()
   LET g_xrgd_m_o.xrgd101 = g_xrgd_m.xrgd101
   LET g_xrgd_m_o.xrgd103 = g_xrgd_m.xrgd103
   LET g_xrgd_m_o.xrgd113 = g_xrgd_m.xrgd113
END FUNCTION

PRIVATE FUNCTION axrt520_xrgddocno_chk(p_docno)
   DEFINE p_docno   LIKE apgd_t.apgddocno
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_errno       LIKE gzze_t.gzze001
   DEFINE l_count       LIKE type_t.num10

   LET r_success = TRUE
   LET r_errno = ''

   LET l_count = NULL
   SELECT COUNT(*)
     INTO l_count
     FROM xrgd_t
    WHERE xrgdent = g_enterprise
      AND xrgddocno = p_docno
      AND xrgdstus = 'N'
   IF cl_null(l_count)THEN LET l_count = 0 END IF

   IF l_count > 0 THEN
      LET r_success = FALSE
      LET r_errno = 'aap-00506'
   END IF
   RETURN r_success,r_errno
END FUNCTION

PRIVATE FUNCTION axrt520_xrgddocno_ins_xrgd()
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrga   RECORD LIKE xrga_t.*
   DEFINE l_xrga RECORD  #銷售信用狀主檔
       xrgaent LIKE xrga_t.xrgaent, #企業編號
       xrgaownid LIKE xrga_t.xrgaownid, #資料所有者
       xrgaowndp LIKE xrga_t.xrgaowndp, #資料所屬部門
       xrgacrtid LIKE xrga_t.xrgacrtid, #資料建立者
       xrgacrtdp LIKE xrga_t.xrgacrtdp, #資料建立部門
       xrgacrtdt LIKE xrga_t.xrgacrtdt, #資料創建日
       xrgamodid LIKE xrga_t.xrgamodid, #資料修改者
       xrgamoddt LIKE xrga_t.xrgamoddt, #最近修改日
       xrgacnfid LIKE xrga_t.xrgacnfid, #資料確認者
       xrgacnfdt LIKE xrga_t.xrgacnfdt, #資料確認日
       xrgastus LIKE xrga_t.xrgastus, #狀態碼
       xrgacomp LIKE xrga_t.xrgacomp, #法人
       xrgadocno LIKE xrga_t.xrgadocno, #收狀單號
       xrgadocdt LIKE xrga_t.xrgadocdt, #收狀日期
       xrga001 LIKE xrga_t.xrga001, #L/C No.
       xrga002 LIKE xrga_t.xrga002, #版次
       xrga003 LIKE xrga_t.xrga003, #開狀日期
       xrga004 LIKE xrga_t.xrga004, #客戶編號
       xrga005 LIKE xrga_t.xrga005, #業務人員
       xrga006 LIKE xrga_t.xrga006, #收款類型
       xrga007 LIKE xrga_t.xrga007, #信用狀類別
       xrga008 LIKE xrga_t.xrga008, #開狀銀行
       xrga009 LIKE xrga_t.xrga009, #通知銀行
       xrga010 LIKE xrga_t.xrga010, #保兌信用狀否
       xrga011 LIKE xrga_t.xrga011, #信用狀有效日期
       xrga012 LIKE xrga_t.xrga012, #承兌日期
       xrga013 LIKE xrga_t.xrga013, #保兌費用支付方
       xrga014 LIKE xrga_t.xrga014, #可否分批交運
       xrga015 LIKE xrga_t.xrga015, #最後裝運日
       xrga016 LIKE xrga_t.xrga016, #運送方式
       xrga017 LIKE xrga_t.xrga017, #裝載港/機場
       xrga018 LIKE xrga_t.xrga018, #卸載港/機場
       xrga019 LIKE xrga_t.xrga019, #E.T.D
       xrga020 LIKE xrga_t.xrga020, #E.T.A
       xrga021 LIKE xrga_t.xrga021, #備註
       xrga022 LIKE xrga_t.xrga022, #押匯銀行
       xrga023 LIKE xrga_t.xrga023, #許可證號
       xrga024 LIKE xrga_t.xrga024, #費用應付憑單
       xrga025 LIKE xrga_t.xrga025, #結案否
       xrga100 LIKE xrga_t.xrga100, #幣別
       xrga101 LIKE xrga_t.xrga101, #收狀匯率
       xrga103 LIKE xrga_t.xrga103, #收狀原幣金額
       xrga104 LIKE xrga_t.xrga104, #押匯原幣金額
       xrga113 LIKE xrga_t.xrga113, #收狀本幣金額
       xrga109 LIKE xrga_t.xrga109  #初開狀金額
       END RECORD
   #161128-00061#5---modify----end------------- 
   DEFINE r_success LIKE type_t.num5
   DEFINE l_xrgd900 LIKE xrgd_t.xrgd900

   LET r_success = TRUE
   #161128-00061#5---modify----begin------------- 
   #SELECT * INTO l_xrga.* 
   SELECT xrgaent,xrgaownid,xrgaowndp,xrgacrtid,xrgacrtdp,xrgacrtdt,xrgamodid,xrgamoddt,xrgacnfid,
          xrgacnfdt,xrgastus,xrgacomp,xrgadocno,xrgadocdt,xrga001,xrga002,xrga003,xrga004,xrga005,
          xrga006,xrga007,xrga008,xrga009,xrga010,xrga011,xrga012,xrga013,xrga014,xrga015,xrga016,
          xrga017,xrga018,xrga019,xrga020,xrga021,xrga022,xrga023,xrga024,xrga025,xrga100,xrga101,
          xrga103,xrga104,xrga113,xrga109 INTO l_xrga.* 
   #161128-00061#5---modify----end------------- 
   FROM xrga_t
    WHERE xrgaent = g_enterprise
      AND xrgadocno = g_xrgd_m.xrgddocno
   LET g_xrgd_m.xrgdcomp = l_xrga.xrgacomp
   LET g_xrgd_m.xrgd001 = l_xrga.xrga001
   LET g_xrgd_m.xrgd002 = l_xrga.xrga002 + 1
   LET g_xrgd_m.xrgd003 = l_xrga.xrga003
   LET g_xrgd_m.xrgd004 = l_xrga.xrga004
   LET g_xrgd_m.xrgd005 = l_xrga.xrga005
   LET g_xrgd_m.xrgd006 = l_xrga.xrga006
   LET g_xrgd_m.xrgd007 = l_xrga.xrga007
   LET g_xrgd_m.xrgd008 = l_xrga.xrga008
   LET g_xrgd_m.xrgd009 = l_xrga.xrga009
   LET g_xrgd_m.xrgd010 = l_xrga.xrga010
   LET g_xrgd_m.xrgd011 = l_xrga.xrga011
   LET g_xrgd_m.xrgd012 = l_xrga.xrga012
   LET g_xrgd_m.xrgd013 = l_xrga.xrga013
   LET g_xrgd_m.xrgd014 = l_xrga.xrga014
   LET g_xrgd_m.xrgd015 = l_xrga.xrga015
   LET g_xrgd_m.xrgd016 = l_xrga.xrga016
   LET g_xrgd_m.xrgd017 = l_xrga.xrga017
   LET g_xrgd_m.xrgd018 = l_xrga.xrga018
   LET g_xrgd_m.xrgd019 = l_xrga.xrga019
   LET g_xrgd_m.xrgd020 = l_xrga.xrga020
   LEt g_xrgd_m.xrgd021 = l_xrga.xrga021
   LET g_xrgd_m.xrgd022 = l_xrga.xrga022
   LET g_xrgd_m.xrgd023 = l_xrga.xrga023
   LET g_xrgd_m.xrgd024 = l_xrga.xrga024
   LET g_xrgd_m.xrgd025 = l_xrga.xrga025
   LET g_xrgd_m.xrgd100 = l_xrga.xrga100
   LET g_xrgd_m.xrgd101 = l_xrga.xrga101
   LET g_xrgd_m.xrgd103 = l_xrga.xrga103
   LET g_xrgd_m.xrgd104 = l_xrga.xrga104
   LET g_xrgd_m.xrgd113 = l_xrga.xrga113
   LET l_xrgd900 = ''
   SELECT MAX(xrgd900) + 1 INTO l_xrgd900
     FROM xrgd_t
    WHERE xrgdent = g_enterprise
      AND xrgddocno = g_xrgd_m.xrgddocno
      #AND xrgdcomp = g_xrgd_m.xrgdcomp
   IF cl_null(l_xrgd900)THEN LET l_xrgd900 = 1 END IF

   IF l_xrgd900 = (g_xrgd_m.xrgd900 + 1) THEN
      IF g_xrgd_m.xrgd900 = 0 THEN
         LET g_xrgd_m.xrgd900 = 1
      ELSE

      END IF
   ELSE
      LET g_xrgd_m.xrgd900 = l_xrgd900
   END IF
   SELECT glaa001 INTO g_xrgd_m.l_glaa001 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_xrgd_m.xrgdcomp
      AND glaa014 = 'Y'
      
   CALL s_desc_get_department_desc(g_xrgd_m.xrgdcomp) RETURNING g_xrgd_m.xrgdcomp_desc
   DISPLAY BY NAME g_xrgd_m.xrgdcomp_desc
   LET g_xrgd_m_t.* = g_xrgd_m.*
   LET g_xrgd_m_o.* = g_xrgd_m.*

   CALL s_fin_account_center_sons_query('8',g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocdt,'1')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apgborga
   CALL s_fin_get_wc_str(g_wc_apgborga) RETURNING g_wc_apgborga

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axrt520_xrgddocno_ins_xrge()
   DEFINE l_sql   STRING
   DEFINE l_idx   LIKE type_t.num10
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrge  RECORD LIKE xrge_t.*
   DEFINE l_xrge RECORD  #銷售信用狀變更明細檔
       xrgeent LIKE xrge_t.xrgeent, #企業編號
       xrgecomp LIKE xrge_t.xrgecomp, #法人
       xrgedocno LIKE xrge_t.xrgedocno, #申請單號
       xrgeseq LIKE xrge_t.xrgeseq, #項次
       xrgeorga LIKE xrge_t.xrgeorga, #來源組織
       xrge001 LIKE xrge_t.xrge001, #訂單單號
       xrge002 LIKE xrge_t.xrge002, #訂單項次
       xrge003 LIKE xrge_t.xrge003, #產品編號
       xrge004 LIKE xrge_t.xrge004, #品名規格
       xrge005 LIKE xrge_t.xrge005, #單位
       xrge006 LIKE xrge_t.xrge006, #稅別
       xrge007 LIKE xrge_t.xrge007, #含稅否
       xrge008 LIKE xrge_t.xrge008, #訂單數量
       xrge009 LIKE xrge_t.xrge009, #原幣含稅單價
       xrge105 LIKE xrge_t.xrge105, #原幣含稅金額
       xrge115 LIKE xrge_t.xrge115, #本幣含稅金額
       xrge900 LIKE xrge_t.xrge900, #變更序
       xrge901 LIKE xrge_t.xrge901, #變更類型
       xrge902 LIKE xrge_t.xrge902, #變更理由
       xrge903 LIKE xrge_t.xrge903, #變更備註
       xrge100 LIKE xrge_t.xrge100, #幣別
       xrge101 LIKE xrge_t.xrge101  #匯率
       END RECORD
   #161128-00061#5---modify----end------------- 
   DEFINE r_success LIKE type_t.num5
   
   LET l_sql = "SELECT xrgbseq,xrgborga,xrgb001,xrgb002,xrgb003,xrgb004,xrgb005,xrgb008, 
               xrgb006,xrgb007,xrgb100,xrgb101,xrgb009,xrgb105,xrgb115,'','','','' FROM xrgb_t ",
               " WHERE xrgbent = ",g_enterprise," ",
               "   AND xrgbdocno = '",g_xrgd_m.xrgddocno,"' "
   PREPARE sel_xrgbp1 FROM l_sql
   DECLARE sel_xrgbc1 CURSOR FOR sel_xrgbp1
   LET l_idx = 1
   FOREACH sel_xrgbc1 INTO g_xrge_d[l_idx].xrgeseq,g_xrge_d[l_idx].xrgeorga,g_xrge_d[l_idx].xrge001,g_xrge_d[l_idx].xrge002, 
          g_xrge_d[l_idx].xrge003,g_xrge_d[l_idx].xrge004,g_xrge_d[l_idx].xrge005,g_xrge_d[l_idx].xrge008, 
          g_xrge_d[l_idx].xrge006,g_xrge_d[l_idx].xrge007,g_xrge_d[l_idx].xrge100,g_xrge_d[l_idx].xrge101, 
          g_xrge_d[l_idx].xrge009,g_xrge_d[l_idx].xrge105,g_xrge_d[l_idx].xrge115,g_xrge_d[l_idx].xrge901, 
          g_xrge_d[l_idx].xrge902,g_xrge_d[l_idx].xrge903,g_xrge_d[l_idx].xrgeorga_desc
          IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      INITIALIZE l_xrge.* TO NULL
      LET l_xrge.xrgeent   = g_enterprise
      LET l_xrge.xrgecomp  = g_xrgd_m.xrgdcomp
      LET l_xrge.xrgedocno = g_xrgd_m.xrgddocno
      LET l_xrge.xrgeseq   = g_xrge_d[l_idx].xrgeseq
      LET l_xrge.xrge900   = g_xrgd_m.xrgd900      
      LET l_xrge.xrgeorga  = g_xrge_d[l_idx].xrgeorga
      LET l_xrge.xrge001   = g_xrge_d[l_idx].xrge001
      LET l_xrge.xrge002   = g_xrge_d[l_idx].xrge002
      LET l_xrge.xrge003   = g_xrge_d[l_idx].xrge003
      LET l_xrge.xrge004   = g_xrge_d[l_idx].xrge004
      LET l_xrge.xrge005   = g_xrge_d[l_idx].xrge005
      LET l_xrge.xrge006   = g_xrge_d[l_idx].xrge006
      LET l_xrge.xrge007   = g_xrge_d[l_idx].xrge007
      LET l_xrge.xrge008   = g_xrge_d[l_idx].xrge008
      LET l_xrge.xrge009   = g_xrge_d[l_idx].xrge009
      LET l_xrge.xrge105   = g_xrge_d[l_idx].xrge105
      LET l_xrge.xrge115   = g_xrge_d[l_idx].xrge115
      LET l_xrge.xrge100   = g_xrge_d[l_idx].xrge100
      LET l_xrge.xrge101   = g_xrge_d[l_idx].xrge101
      
      #161128-00061#5---modify----begin------------- 
      #INSERT INTO xrge_t VALUES(l_xrge.*)
      INSERT INTO xrge_t (xrgeent,xrgecomp,xrgedocno,xrgeseq,xrgeorga,xrge001,xrge002,xrge003,xrge004,
                          xrge005,xrge006,xrge007,xrge008,xrge009,xrge105,xrge115,xrge900,xrge901,xrge902,
                          xrge903,xrge100,xrge101)
       VALUES(l_xrge.xrgeent,l_xrge.xrgecomp,l_xrge.xrgedocno,l_xrge.xrgeseq,l_xrge.xrgeorga,l_xrge.xrge001,l_xrge.xrge002,l_xrge.xrge003,l_xrge.xrge004,
              l_xrge.xrge005,l_xrge.xrge006,l_xrge.xrge007,l_xrge.xrge008,l_xrge.xrge009,l_xrge.xrge105,l_xrge.xrge115,l_xrge.xrge900,l_xrge.xrge901,l_xrge.xrge902,
              l_xrge.xrge903,l_xrge.xrge100,l_xrge.xrge101)
      #161128-00061#5---modify----end------------- 
      
      LET l_idx = l_idx + 1
   END FOREACH
   
   DISPLAY ARRAY g_xrge_d TO s_detail1.* ATTRIBUTES(COUNT=l_idx)
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY

   RETURN r_success   
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
PRIVATE FUNCTION axrt520_xrgd_ins_xrgh()
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrga   RECORD LIKE xrga_t.*
   DEFINE l_xrga RECORD  #銷售信用狀主檔
       xrgaent LIKE xrga_t.xrgaent, #企業編號
       xrgaownid LIKE xrga_t.xrgaownid, #資料所有者
       xrgaowndp LIKE xrga_t.xrgaowndp, #資料所屬部門
       xrgacrtid LIKE xrga_t.xrgacrtid, #資料建立者
       xrgacrtdp LIKE xrga_t.xrgacrtdp, #資料建立部門
       xrgacrtdt LIKE xrga_t.xrgacrtdt, #資料創建日
       xrgamodid LIKE xrga_t.xrgamodid, #資料修改者
       xrgamoddt LIKE xrga_t.xrgamoddt, #最近修改日
       xrgacnfid LIKE xrga_t.xrgacnfid, #資料確認者
       xrgacnfdt LIKE xrga_t.xrgacnfdt, #資料確認日
       xrgastus LIKE xrga_t.xrgastus, #狀態碼
       xrgacomp LIKE xrga_t.xrgacomp, #法人
       xrgadocno LIKE xrga_t.xrgadocno, #收狀單號
       xrgadocdt LIKE xrga_t.xrgadocdt, #收狀日期
       xrga001 LIKE xrga_t.xrga001, #L/C No.
       xrga002 LIKE xrga_t.xrga002, #版次
       xrga003 LIKE xrga_t.xrga003, #開狀日期
       xrga004 LIKE xrga_t.xrga004, #客戶編號
       xrga005 LIKE xrga_t.xrga005, #業務人員
       xrga006 LIKE xrga_t.xrga006, #收款類型
       xrga007 LIKE xrga_t.xrga007, #信用狀類別
       xrga008 LIKE xrga_t.xrga008, #開狀銀行
       xrga009 LIKE xrga_t.xrga009, #通知銀行
       xrga010 LIKE xrga_t.xrga010, #保兌信用狀否
       xrga011 LIKE xrga_t.xrga011, #信用狀有效日期
       xrga012 LIKE xrga_t.xrga012, #承兌日期
       xrga013 LIKE xrga_t.xrga013, #保兌費用支付方
       xrga014 LIKE xrga_t.xrga014, #可否分批交運
       xrga015 LIKE xrga_t.xrga015, #最後裝運日
       xrga016 LIKE xrga_t.xrga016, #運送方式
       xrga017 LIKE xrga_t.xrga017, #裝載港/機場
       xrga018 LIKE xrga_t.xrga018, #卸載港/機場
       xrga019 LIKE xrga_t.xrga019, #E.T.D
       xrga020 LIKE xrga_t.xrga020, #E.T.A
       xrga021 LIKE xrga_t.xrga021, #備註
       xrga022 LIKE xrga_t.xrga022, #押匯銀行
       xrga023 LIKE xrga_t.xrga023, #許可證號
       xrga024 LIKE xrga_t.xrga024, #費用應付憑單
       xrga025 LIKE xrga_t.xrga025, #結案否
       xrga100 LIKE xrga_t.xrga100, #幣別
       xrga101 LIKE xrga_t.xrga101, #收狀匯率
       xrga103 LIKE xrga_t.xrga103, #收狀原幣金額
       xrga104 LIKE xrga_t.xrga104, #押匯原幣金額
       xrga113 LIKE xrga_t.xrga113, #收狀本幣金額
       xrga109 LIKE xrga_t.xrga109  #初開狀金額
       END RECORD
   #161128-00061#5---modify----end----------
   DEFINE l_xrgh007  LIKE xrgh_t.xrgh007
   
   #先查出原單單頭
   INITIALIZE l_xrga.* TO NULL
   #161128-00061#5---modify----begin------------- 
   #SELECT * INTO l_xrga.* 
   SELECT xrgaent,xrgaownid,xrgaowndp,xrgacrtid,xrgacrtdp,xrgacrtdt,xrgamodid,xrgamoddt,xrgacnfid,
          xrgacnfdt,xrgastus,xrgacomp,xrgadocno,xrgadocdt,xrga001,xrga002,xrga003,xrga004,xrga005,
          xrga006,xrga007,xrga008,xrga009,xrga010,xrga011,xrga012,xrga013,xrga014,xrga015,xrga016,
          xrga017,xrga018,xrga019,xrga020,xrga021,xrga022,xrga023,xrga024,xrga025,xrga100,xrga101,
          xrga103,xrga104,xrga113,xrga109 INTO l_xrga.* 
   #161128-00061#5---modify----end----------
   FROM xrga_t
    WHERE xrgaent = g_enterprise
      AND xrgacomp = g_xrgd_m.xrgdcomp
      AND xrgadocno = g_xrgd_m.xrgddocno
   
   #比對各欄位有不同處
   IF NOT(cl_null(l_xrga.xrga001) AND cl_null(g_xrgd_m.xrgd001)) THEN
      IF (l_xrga.xrga001 <> g_xrgd_m.xrgd001) OR (cl_null(l_xrga.xrga001)) OR (cl_null(g_xrgd_m.xrgd001))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga001','1',l_xrga.xrga001,g_xrgd_m.xrgd001,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga003) AND cl_null(g_xrgd_m.xrgd003)) THEN
      IF (l_xrga.xrga003 <> g_xrgd_m.xrgd003) OR (cl_null(l_xrga.xrga003)) OR (cl_null(g_xrgd_m.xrgd003))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga003','1',l_xrga.xrga003,g_xrgd_m.xrgd003,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga004) AND cl_null(g_xrgd_m.xrgd004)) THEN
      IF (l_xrga.xrga004 <> g_xrgd_m.xrgd004) OR (cl_null(l_xrga.xrga004)) OR (cl_null(g_xrgd_m.xrgd004))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga004','1',l_xrga.xrga004,g_xrgd_m.xrgd004,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga005) AND cl_null(g_xrgd_m.xrgd005)) THEN
      IF (l_xrga.xrga005 <> g_xrgd_m.xrgd005) OR (cl_null(l_xrga.xrga005)) OR (cl_null(g_xrgd_m.xrgd005))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga005','1',l_xrga.xrga005,g_xrgd_m.xrgd005,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga006) AND cl_null(g_xrgd_m.xrgd006)) THEN
      IF (l_xrga.xrga006 <> g_xrgd_m.xrgd006) OR (cl_null(l_xrga.xrga006)) OR (cl_null(g_xrgd_m.xrgd006))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga006','1',l_xrga.xrga006,g_xrgd_m.xrgd006,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga007) AND cl_null(g_xrgd_m.xrgd007)) THEN
      IF (l_xrga.xrga007 <> g_xrgd_m.xrgd007) OR (cl_null(l_xrga.xrga007)) OR (cl_null(g_xrgd_m.xrgd007))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga007','1',l_xrga.xrga007,g_xrgd_m.xrgd007,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga008) AND cl_null(g_xrgd_m.xrgd008)) THEN
      IF (l_xrga.xrga008 <> g_xrgd_m.xrgd008) OR (cl_null(l_xrga.xrga008)) OR (cl_null(g_xrgd_m.xrgd008))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga008','1',l_xrga.xrga008,g_xrgd_m.xrgd008,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga009) AND cl_null(g_xrgd_m.xrgd009)) THEN
      IF (l_xrga.xrga009 <> g_xrgd_m.xrgd009) OR (cl_null(l_xrga.xrga009)) OR (cl_null(g_xrgd_m.xrgd009))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga009','1',l_xrga.xrga009,g_xrgd_m.xrgd009,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga010) AND cl_null(g_xrgd_m.xrgd010)) THEN
      IF (l_xrga.xrga010 <> g_xrgd_m.xrgd010) OR (cl_null(l_xrga.xrga010)) OR (cl_null(g_xrgd_m.xrgd010))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga010','1',l_xrga.xrga010,g_xrgd_m.xrgd010,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga011) AND cl_null(g_xrgd_m.xrgd011)) THEN
      IF (l_xrga.xrga011 <> g_xrgd_m.xrgd011) OR (cl_null(l_xrga.xrga011)) OR (cl_null(g_xrgd_m.xrgd011))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga011','1',l_xrga.xrga011,g_xrgd_m.xrgd011,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga012) AND cl_null(g_xrgd_m.xrgd012)) THEN
      IF (l_xrga.xrga012 <> g_xrgd_m.xrgd012) OR (cl_null(l_xrga.xrga012)) OR (cl_null(g_xrgd_m.xrgd012))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga012','1',l_xrga.xrga012,g_xrgd_m.xrgd012,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga013) AND cl_null(g_xrgd_m.xrgd013)) THEN
      IF (l_xrga.xrga013 <> g_xrgd_m.xrgd013) OR (cl_null(l_xrga.xrga013)) OR (cl_null(g_xrgd_m.xrgd013))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga013','1',l_xrga.xrga013,g_xrgd_m.xrgd013,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga014) AND cl_null(g_xrgd_m.xrgd014)) THEN
      IF (l_xrga.xrga014 <> g_xrgd_m.xrgd014) OR (cl_null(l_xrga.xrga014)) OR (cl_null(g_xrgd_m.xrgd014))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga014','1',l_xrga.xrga014,g_xrgd_m.xrgd014,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga015) AND cl_null(g_xrgd_m.xrgd015)) THEN
      IF (l_xrga.xrga015 <> g_xrgd_m.xrgd015) OR (cl_null(l_xrga.xrga015)) OR (cl_null(g_xrgd_m.xrgd015))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga015','1',l_xrga.xrga015,g_xrgd_m.xrgd015,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga016) AND cl_null(g_xrgd_m.xrgd016)) THEN
      IF (l_xrga.xrga016 <> g_xrgd_m.xrgd016) OR (cl_null(l_xrga.xrga016)) OR (cl_null(g_xrgd_m.xrgd016))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga016','1',l_xrga.xrga016,g_xrgd_m.xrgd016,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga017) AND cl_null(g_xrgd_m.xrgd017)) THEN
      IF (l_xrga.xrga017 <> g_xrgd_m.xrgd017) OR (cl_null(l_xrga.xrga017)) OR (cl_null(g_xrgd_m.xrgd017))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga017','1',l_xrga.xrga017,g_xrgd_m.xrgd017,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga018) AND cl_null(g_xrgd_m.xrgd018)) THEN
      IF (l_xrga.xrga018 <> g_xrgd_m.xrgd018) OR (cl_null(l_xrga.xrga018)) OR (cl_null(g_xrgd_m.xrgd018))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga018','1',l_xrga.xrga018,g_xrgd_m.xrgd018,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   IF NOT(cl_null(l_xrga.xrga019) AND cl_null(g_xrgd_m.xrgd019)) THEN
      IF (l_xrga.xrga019 <> g_xrgd_m.xrgd019) OR (cl_null(l_xrga.xrga019)) OR (cl_null(g_xrgd_m.xrgd019))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga019','1',l_xrga.xrga019,g_xrgd_m.xrgd019,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF   
   
   IF NOT(cl_null(l_xrga.xrga019) AND cl_null(g_xrgd_m.xrgd019)) THEN
      IF (l_xrga.xrga019 <> g_xrgd_m.xrgd019) OR (cl_null(l_xrga.xrga019)) OR (cl_null(g_xrgd_m.xrgd019))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga019','1',l_xrga.xrga019,g_xrgd_m.xrgd019,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga020) AND cl_null(g_xrgd_m.xrgd020)) THEN
      IF (l_xrga.xrga020 <> g_xrgd_m.xrgd020) OR (cl_null(l_xrga.xrga020)) OR (cl_null(g_xrgd_m.xrgd020))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga020','1',l_xrga.xrga020,g_xrgd_m.xrgd020,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga021) AND cl_null(g_xrgd_m.xrgd021)) THEN
      IF (l_xrga.xrga021 <> g_xrgd_m.xrgd021) OR (cl_null(l_xrga.xrga021)) OR (cl_null(g_xrgd_m.xrgd021))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga021','1',l_xrga.xrga021,g_xrgd_m.xrgd021,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga022) AND cl_null(g_xrgd_m.xrgd022)) THEN
      IF (l_xrga.xrga022 <> g_xrgd_m.xrgd022) OR (cl_null(l_xrga.xrga022)) OR (cl_null(g_xrgd_m.xrgd022))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga022','1',l_xrga.xrga022,g_xrgd_m.xrgd022,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga023) AND cl_null(g_xrgd_m.xrgd023)) THEN
      IF (l_xrga.xrga023 <> g_xrgd_m.xrgd023) OR (cl_null(l_xrga.xrga023)) OR (cl_null(g_xrgd_m.xrgd023))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga023','1',l_xrga.xrga023,g_xrgd_m.xrgd023,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga024) AND cl_null(g_xrgd_m.xrgd024)) THEN
      IF (l_xrga.xrga024 <> g_xrgd_m.xrgd024) OR (cl_null(l_xrga.xrga024)) OR (cl_null(g_xrgd_m.xrgd024))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga024','1',l_xrga.xrga024,g_xrgd_m.xrgd024,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga025) AND cl_null(g_xrgd_m.xrgd025)) THEN
      IF (l_xrga.xrga025 <> g_xrgd_m.xrgd025) OR (cl_null(l_xrga.xrga025)) OR (cl_null(g_xrgd_m.xrgd025))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga025','1',l_xrga.xrga025,g_xrgd_m.xrgd025,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
     
   IF NOT(cl_null(l_xrga.xrga100) AND cl_null(g_xrgd_m.xrgd100)) THEN
      IF (l_xrga.xrga100 <> g_xrgd_m.xrgd100) OR (cl_null(l_xrga.xrga100)) OR (cl_null(g_xrgd_m.xrgd100))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga100','1',l_xrga.xrga100,g_xrgd_m.xrgd100,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga101) AND cl_null(g_xrgd_m.xrgd101)) THEN
      IF (l_xrga.xrga101 <> g_xrgd_m.xrgd101) OR (cl_null(l_xrga.xrga101)) OR (cl_null(g_xrgd_m.xrgd101))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga101','1',l_xrga.xrga101,g_xrgd_m.xrgd101,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga103) AND cl_null(g_xrgd_m.xrgd103)) THEN
      IF (l_xrga.xrga103 <> g_xrgd_m.xrgd103) OR (cl_null(l_xrga.xrga103)) OR (cl_null(g_xrgd_m.xrgd103))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga103','1',l_xrga.xrga103,g_xrgd_m.xrgd103,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
   IF NOT(cl_null(l_xrga.xrga104) AND cl_null(g_xrgd_m.xrgd104)) THEN
      IF (l_xrga.xrga104 <> g_xrgd_m.xrgd104) OR (cl_null(l_xrga.xrga104)) OR (cl_null(g_xrgd_m.xrgd104))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga104','1',l_xrga.xrga104,g_xrgd_m.xrgd104,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
        
   IF NOT(cl_null(l_xrga.xrga113) AND cl_null(g_xrgd_m.xrgd113)) THEN
      IF (l_xrga.xrga113 <> g_xrgd_m.xrgd113) OR (cl_null(l_xrga.xrga113)) OR (cl_null(g_xrgd_m.xrgd113))THEN
         LET l_xrgh007 = ''
         CALL s_axrt520_ins_xrgh(0,'xrga113','1',l_xrga.xrga113,g_xrgd_m.xrgd113,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
      END IF
   END IF
   
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
PRIVATE FUNCTION axrt520_xrge_ins_xrgh(p_xrge_d)
   DEFINE p_xrge_d          type_g_xrge_d
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrgb            RECORD LIKE xrgb_t.*
   DEFINE l_xrgb RECORD  #銷售信用狀明細檔
       xrgbent LIKE xrgb_t.xrgbent, #企業編號
       xrgbcomp LIKE xrgb_t.xrgbcomp, #法人
       xrgbdocno LIKE xrgb_t.xrgbdocno, #申請單號
       xrgbseq LIKE xrgb_t.xrgbseq, #項次
       xrgborga LIKE xrgb_t.xrgborga, #來源組織
       xrgb001 LIKE xrgb_t.xrgb001, #訂單單號
       xrgb002 LIKE xrgb_t.xrgb002, #訂單項次
       xrgb003 LIKE xrgb_t.xrgb003, #產品編號
       xrgb004 LIKE xrgb_t.xrgb004, #品名規格
       xrgb005 LIKE xrgb_t.xrgb005, #單位
       xrgb006 LIKE xrgb_t.xrgb006, #稅別
       xrgb007 LIKE xrgb_t.xrgb007, #含稅否
       xrgb008 LIKE xrgb_t.xrgb008, #訂單數量
       xrgb009 LIKE xrgb_t.xrgb009, #原幣含稅單價
       xrgb010 LIKE xrgb_t.xrgb010, #已出貨數量
       xrgb105 LIKE xrgb_t.xrgb105, #原幣含稅金額
       xrgb115 LIKE xrgb_t.xrgb115, #本幣含稅金額
       xrgb100 LIKE xrgb_t.xrgb100, #幣別
       xrgb101 LIKE xrgb_t.xrgb101  #匯率
       END RECORD
   #161128-00061#5---modify----end------------- 
   DEFINE l_xrgh007         LIKE xrgh_t.xrgh007
   DEFINE r_success         LIKE type_t.num5
   
   LET r_success = TRUE
   
   INITIALIZE l_xrgb.* TO NULL
   #161128-00061#5---modify----begin------------- 
   #SELECT * INTO l_xrgb.*
   SELECT xrgbent,xrgbcomp,xrgbdocno,xrgbseq,xrgborga,xrgb001,xrgb002,xrgb003,xrgb004,
          xrgb005,xrgb006,xrgb007,xrgb008,xrgb009,xrgb010,xrgb105,xrgb115,xrgb100,xrgb101 INTO l_xrgb.*
   #161128-00061#5---modify----end------------- 
   FROM xrgb_t
    WHERE xrgbent = g_enterprise
      AND xrgbcomp = g_xrgd_m.xrgdcomp
      AND xrgbdocno = g_xrgd_m.xrgddocno
      AND xrgbseq   = p_xrge_d.xrgeseq
    
   IF NOT(cl_null(l_xrgb.xrgborga) AND cl_null(p_xrge_d.xrgeorga)) THEN
      IF (l_xrgb.xrgborga <> p_xrge_d.xrgeorga) OR (cl_null(l_xrgb.xrgborga)) OR (cl_null(p_xrge_d.xrgeorga))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgborga','1',l_xrgb.xrgborga,p_xrge_d.xrgeorga,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   IF NOT(cl_null(l_xrgb.xrgb001) AND cl_null(p_xrge_d.xrge001)) THEN
      IF (l_xrgb.xrgb001 <> p_xrge_d.xrge001) OR (cl_null(l_xrgb.xrgb001)) OR (cl_null(p_xrge_d.xrge001))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb001','1',l_xrgb.xrgb001,p_xrge_d.xrge001,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
            
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   IF NOT(cl_null(l_xrgb.xrgb002) AND cl_null(p_xrge_d.xrge002)) THEN
      IF (l_xrgb.xrgb002 <> p_xrge_d.xrge002) OR (cl_null(l_xrgb.xrgb002)) OR (cl_null(p_xrge_d.xrge002))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb002','1',l_xrgb.xrgb002,p_xrge_d.xrge002,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   IF NOT(cl_null(l_xrgb.xrgb003) AND cl_null(p_xrge_d.xrge003)) THEN
      IF (l_xrgb.xrgb003 <> p_xrge_d.xrge003) OR (cl_null(l_xrgb.xrgb003)) OR (cl_null(p_xrge_d.xrge003))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb003','1',l_xrgb.xrgb003,p_xrge_d.xrge003,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   IF NOT(cl_null(l_xrgb.xrgb004) AND cl_null(p_xrge_d.xrge004)) THEN
      IF (l_xrgb.xrgb004 <> p_xrge_d.xrge004) OR (cl_null(l_xrgb.xrgb004)) OR (cl_null(p_xrge_d.xrge004))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb004','1',l_xrgb.xrgb004,p_xrge_d.xrge004,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   IF NOT(cl_null(l_xrgb.xrgb005) AND cl_null(p_xrge_d.xrge005)) THEN
      IF (l_xrgb.xrgb005 <> p_xrge_d.xrge005) OR (cl_null(l_xrgb.xrgb005)) OR (cl_null(p_xrge_d.xrge005))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb005','1',l_xrgb.xrgb005,p_xrge_d.xrge005,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
 
   IF NOT(cl_null(l_xrgb.xrgb006) AND cl_null(p_xrge_d.xrge006)) THEN
      IF (l_xrgb.xrgb006 <> p_xrge_d.xrge006) OR (cl_null(l_xrgb.xrgb006)) OR (cl_null(p_xrge_d.xrge006))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb006','1',l_xrgb.xrgb006,p_xrge_d.xrge006,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   IF NOT(cl_null(l_xrgb.xrgb007) AND cl_null(p_xrge_d.xrge007)) THEN
      IF (l_xrgb.xrgb007 <> p_xrge_d.xrge007) OR (cl_null(l_xrgb.xrgb007)) OR (cl_null(p_xrge_d.xrge007))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb007','1',l_xrgb.xrgb007,p_xrge_d.xrge007,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF

   IF NOT(cl_null(l_xrgb.xrgb008) AND cl_null(p_xrge_d.xrge008)) THEN
      IF (l_xrgb.xrgb008 <> p_xrge_d.xrge008) OR (cl_null(l_xrgb.xrgb008)) OR (cl_null(p_xrge_d.xrge008))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb008','1',l_xrgb.xrgb008,p_xrge_d.xrge008,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   IF NOT(cl_null(l_xrgb.xrgb009) AND cl_null(p_xrge_d.xrge009)) THEN
      IF (l_xrgb.xrgb009 <> p_xrge_d.xrge009) OR (cl_null(l_xrgb.xrgb009)) OR (cl_null(p_xrge_d.xrge009))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb009','1',l_xrgb.xrgb009,p_xrge_d.xrge009,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   

   
   IF NOT(cl_null(l_xrgb.xrgb105) AND cl_null(p_xrge_d.xrge105)) THEN
      IF (l_xrgb.xrgb105 <> p_xrge_d.xrge105) OR (cl_null(l_xrgb.xrgb105)) OR (cl_null(p_xrge_d.xrge105))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb105','1',l_xrgb.xrgb105,p_xrge_d.xrge105,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   IF NOT(cl_null(l_xrgb.xrgb115) AND cl_null(p_xrge_d.xrge115)) THEN
      IF (l_xrgb.xrgb115 <> p_xrge_d.xrge115) OR (cl_null(l_xrgb.xrgb115)) OR (cl_null(p_xrge_d.xrge115))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb115','1',l_xrgb.xrgb115,p_xrge_d.xrge115,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   IF NOT(cl_null(l_xrgb.xrgb100) AND cl_null(p_xrge_d.xrge100)) THEN
      IF (l_xrgb.xrgb100 <> p_xrge_d.xrge100) OR (cl_null(l_xrgb.xrgb100)) OR (cl_null(p_xrge_d.xrge100))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb100','1',l_xrgb.xrgb100,p_xrge_d.xrge100,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   IF NOT(cl_null(l_xrgb.xrgb101) AND cl_null(p_xrge_d.xrge101)) THEN
      IF (l_xrgb.xrgb101 <> p_xrge_d.xrge101) OR (cl_null(l_xrgb.xrgb101)) OR (cl_null(p_xrge_d.xrge101))THEN
         CALL s_axrt520_ins_xrgh(p_xrge_d.xrgeseq,'xrgb101','1',l_xrgb.xrgb101,p_xrge_d.xrge101,g_xrgd_m.xrgdcomp,g_xrgd_m.xrgddocno,g_xrgd_m.xrgd900,l_xrgh007)
            RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF   
   RETURN r_success
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
PRIVATE FUNCTION axrt520_head_init_color()
   CALL cl_set_comp_font_color("xrgdcomp,xrgddocno,xrgd900,xrgd002,xrgd005,xrgd006","black")
   CALL cl_set_comp_font_color("xrgd004,xrgd003,xrgd001,xrgd007,xrgd100,xrgd013","black")
   CALL cl_set_comp_font_color("xrgd101,xrgd105,xrgd030,xrgd103,xrgd113",'black')
   CALL cl_set_comp_font_color("xrgd016,xrgd012,xrgd015,xrgd017",'black')
   CALL cl_set_comp_font_color("xrgd104,xrgd018,xrgd010",'black')
   CALL cl_set_comp_font_color("xrgd011,xrgd019,xrgd020,xrgd021",'black')
   CALL cl_set_comp_font_color("xrgd022,xrgd023,xrgd024,xrgd025",'black')
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
PRIVATE FUNCTION axrt520_head_color()
   DEFINE l_xrgh002   LIKE xrgh_t.xrgh002
   
   CALL axrt520_head_init_color()
   
   DECLARE sel_xrgh_cs1 CURSOR FOR
    SELECT xrgh002 FROM xrgh_t
     WHERE xrghent = g_enterprise
       AND xrghdocno = g_xrgd_m.xrgddocno
       AND xrgh001 = g_xrgd_m.xrgd900
       AND xrghseq = 0
       
   FOREACH sel_xrgh_cs1 INTO l_xrgh002
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      LET l_xrgh002 = cl_replace_str(l_xrgh002,'xrga','xrgd')

      CALL cl_set_comp_font_color(l_xrgh002,"red")
   END FOREACH   
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
PRIVATE FUNCTION axrt520_detail_init_color(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   
   IF cl_null(p_ac) OR p_ac <=0 THEN RETURN END IF
   LET g_xrge_d_color[p_ac].xrgeseq       ='black'
   LET g_xrge_d_color[p_ac].xrgeorga      ='black'
   LET g_xrge_d_color[p_ac].xrgeorga_desc ='black'
   LET g_xrge_d_color[p_ac].xrge001       ='black'
   LET g_xrge_d_color[p_ac].xrge002       ='black'
   LET g_xrge_d_color[p_ac].xrge003       ='black'
   LET g_xrge_d_color[p_ac].xrge004       ='black'
   LET g_xrge_d_color[p_ac].xrge005       ='black'
   LET g_xrge_d_color[p_ac].xrge006       ='black'
   LET g_xrge_d_color[p_ac].xrge007       ='black'
   LET g_xrge_d_color[p_ac].xrge008       ='black'
   LET g_xrge_d_color[p_ac].xrge009       ='black'
   LET g_xrge_d_color[p_ac].xrge105       ='black'
   LET g_xrge_d_color[p_ac].xrge115       ='black'
   LET g_xrge_d_color[p_ac].xrge901       ='black'
   LET g_xrge_d_color[p_ac].xrge902       ='black'
   LET g_xrge_d_color[p_ac].xrge903       ='black'
   LET g_xrge_d_color[p_ac].xrge100       ='black'
   LET g_xrge_d_color[p_ac].xrge101       ='black'   
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
PRIVATE FUNCTION axrt520_detail_color(p_ac)
 DEFINE p_ac    LIKE type_t.num10
   DEFINE l_xrgh002   LIKE xrgh_t.xrgh002
   
   IF cl_null(p_ac) OR p_ac <=0 THEN RETURN END IF
   DECLARE sel_xrgh_cs2 CURSOR FOR
    SELECT xrgh002 FROM xrgh_t
     WHERE xrghent   = g_enterprise
       AND xrghdocno = g_xrgd_m.xrgddocno
       AND xrgh001   = g_xrgd_m.xrgd900
       AND xrghseq   = g_xrge_d[p_ac].xrgeseq
      
   CALL axrt520_detail_init_color(p_ac)      
   FOREACH sel_xrgh_cs2 INTO l_xrgh002
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      LET l_xrgh002 = cl_replace_str(l_xrgh002,'xrgb','xrge')
      
      CASE
         WHEN l_xrgh002 = 'xrgeorga'
            LET g_xrge_d_color[p_ac].xrgeorga       = 'red'
            LET g_xrge_d_color[p_ac].xrgeorga_desc  = 'red'
         WHEN l_xrgh002 = 'xrge001'
            LET g_xrge_d_color[p_ac].xrge001       = 'red'
         WHEN l_xrgh002 = 'xrge002'
            LET g_xrge_d_color[p_ac].xrge002       = 'red'
         WHEN l_xrgh002 = 'xrge003'
            LET g_xrge_d_color[p_ac].xrge003       = 'red'
         WHEN l_xrgh002 = 'xrge004'
            LET g_xrge_d_color[p_ac].xrge004       = 'red'
         WHEN l_xrgh002 = 'xrge005'
            LET g_xrge_d_color[p_ac].xrge005       = 'red'
         WHEN l_xrgh002 = 'xrge006'
            LET g_xrge_d_color[p_ac].xrge006       = 'red'
         WHEN l_xrgh002 = 'xrge007'
            LET g_xrge_d_color[p_ac].xrge007       = 'red'
         WHEN l_xrgh002 = 'xrge008'
            LET g_xrge_d_color[p_ac].xrge008       = 'red'
         WHEN l_xrgh002 = 'xrge009'
            LET g_xrge_d_color[p_ac].xrge009       = 'red'
         WHEN l_xrgh002 = 'xrge105'
            LET g_xrge_d_color[p_ac].xrge105       = 'red'
         WHEN l_xrgh002 = 'xrge115'
            LET g_xrge_d_color[p_ac].xrge115       = 'red'
         WHEN l_xrgh002 = 'xrge100'
            LET g_xrge_d_color[p_ac].xrge100       ='red'
         WHEN l_xrgh002 = 'xrge101'
            LET g_xrge_d_color[p_ac].xrge101       ='red'   
      END CASE
   END FOREACH
END FUNCTION

PRIVATE FUNCTION axrt520_reins_xrge()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_xrge001   LIKE xrge_t.xrge001
   DEFINE l_xrgear    type_g_xrge_d
    #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrge  RECORD LIKE xrge_t.*
   DEFINE l_xrge RECORD  #銷售信用狀變更明細檔
       xrgeent LIKE xrge_t.xrgeent, #企業編號
       xrgecomp LIKE xrge_t.xrgecomp, #法人
       xrgedocno LIKE xrge_t.xrgedocno, #申請單號
       xrgeseq LIKE xrge_t.xrgeseq, #項次
       xrgeorga LIKE xrge_t.xrgeorga, #來源組織
       xrge001 LIKE xrge_t.xrge001, #訂單單號
       xrge002 LIKE xrge_t.xrge002, #訂單項次
       xrge003 LIKE xrge_t.xrge003, #產品編號
       xrge004 LIKE xrge_t.xrge004, #品名規格
       xrge005 LIKE xrge_t.xrge005, #單位
       xrge006 LIKE xrge_t.xrge006, #稅別
       xrge007 LIKE xrge_t.xrge007, #含稅否
       xrge008 LIKE xrge_t.xrge008, #訂單數量
       xrge009 LIKE xrge_t.xrge009, #原幣含稅單價
       xrge105 LIKE xrge_t.xrge105, #原幣含稅金額
       xrge115 LIKE xrge_t.xrge115, #本幣含稅金額
       xrge900 LIKE xrge_t.xrge900, #變更序
       xrge901 LIKE xrge_t.xrge901, #變更類型
       xrge902 LIKE xrge_t.xrge902, #變更理由
       xrge903 LIKE xrge_t.xrge903, #變更備註
       xrge100 LIKE xrge_t.xrge100, #幣別
       xrge101 LIKE xrge_t.xrge101  #匯率
       END RECORD
   #161128-00061#5---modify----end------------- 
   DEFINE l_xmdc   RECORD
                   xmdc001   LIKE xmdc_t.xmdc001,
                   xmdc010   LIKE xmdc_t.xmdc010,
                   xmdc016   LIKE xmdc_t.xmdc016,
                   xmdc011   LIKE xmdc_t.xmdc011,
                   xmdc047   LIKE xmdc_t.xmdc047
                   END RECORD
   DEFINE p_ac   LIKE type_t.num10
   DEFINE l_ld   LIKE glaa_t.glaald
   DEFINE l_pmdn047   LIKE pmdn_t.pmdn047
   DEFINE l_pmdn007   LIKE pmdn_t.pmdn007
   DEFINE l_glaa001   LIKE glaa_t.glaa001
   DEFINE l_oodb004   LIKE oodb_t.oodb004
   DEFINE l_apca013   LIKE apca_t.apca013
   DEFINE l_apca012   LIKE apca_t.apca012
   DEFINE l_oodb011   LIKE oodb_t.oodb011   

   DEFINE l_xrge0041 LIKE xrge_t.xrge004
   DEFINE l_xrge0042 LIKE xrge_t.xrge004
   DEFINE l_dummy2   LIKE type_t.num20_6
   DEFINE l_dummy3   LIKE type_t.num20_6
   DEFINE ls_js      STRING
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004
                    END RECORD   
   DEFINE l_count   LIKE type_t.num10
   #####
   LET r_success = TRUE
   
   #先抓出單身採購單
   LET l_sql = "SELECT DISTINCT xrge001 FROM xrge_t ",
               " WHERE xrgeent = ",g_enterprise," ",
               "   AND xrgedocno = '",g_xrgd_m.xrgddocno,"' ",
               "   AND xrgecomp  = '",g_xrgd_m.xrgdcomp,"' ",
               "   AND xrge900   = ", g_xrgd_m.xrgd900," "
   PREPARE sel_xrgep1 FROM l_sql
   DECLARE sel_xrgec1 CURSOR FOR sel_xrgep1               
     
   LET l_sql = "SELECT 0,'','',xmdcdocno,xmdcseq,'','','','', ",   
               "       '','','','','','','','','','','' ",
               "  FROM xmdc_t ",
               " WHERE xmdcent = ",g_enterprise," ",
               "   AND xmdcdocno = ? "
   PREPARE sel_xmdcp1 FROM l_sql
   DECLARE sel_xmdcc1 CURSOR FOR sel_xmdcp1
   
   FOREACH sel_xrgec1 INTO l_xrge001
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM xmee_t 
       WHERE xmeeent = g_enterprise AND xmee902 >= g_xrgd_m.xrgd003
         AND xmeedocno = l_xrge001
         AND xmeestus = 'Y'         
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      
      IF l_count > 0 THEN
         #LET l_pmdl015 = NULL
         #LET l_pmdl016 = NULL
         #SELECT pmdl015,pmdl016 
         #  INTO l_pmdl015,l_pmdl016
         #  FROM pmdl_t 
         # WHERE pmdlent = g_enterprise
         #   AND pmdldocno = l_apge001
         ##檢查幣別是大於兩種
         #CALL aapt520_curry_chk(l_pmdl015) RETURNING g_sub_success,g_errno
         #IF NOT r_success THEN     
         #   CONTINUE FOREACH
         #END IF 
      
         DELETE FROM xrge_t 
          WHERE xrgeent = g_enterprise
            AND xrgecomp = g_xrgd_m.xrgdcomp
            AND xrgedocno = g_xrgd_m.xrgddocno
            AND xrge900 = g_xrgd_m.xrgd900
            AND xrge001 = l_xrge001
         FOREACH sel_xmdcc1 USING l_xrge001 INTO l_xrgear.*
            IF SQLCA.SQLCODE THEN EXIT FOREACH END IF

            INITIALIZE l_xmdc.* TO NULL
            SELECT xmdc001,xmdc010,xmdc016,
                   xmdc011,xmdc047
              INTO l_xmdc.*
              FROM xmdc_t
             WHERE xmdcent   = g_enterprise
               AND xmdcdocno = l_xrgear.xrge001
               AND xmdcseq   = l_xrgear.xrge002
            IF cl_null(l_xmdc.xmdc011)THEN LET l_xmdc.xmdc011 = 0 END IF
            IF cl_null(l_xmdc.xmdc047)THEN LET l_xmdc.xmdc047 = 0 END IF
            LET l_xrgear.xrge003 = l_xmdc.xmdc001
            
            CALL s_desc_get_item_desc(l_xmdc.xmdc001) RETURNING l_xrge0041,l_xrge0042
            CASE
               WHEN NOT cl_null(l_xrge0041) AND NOT cl_null(l_xrge0042)
                  LET l_xrgear.xrge004 = l_xrge0041,'/',l_xrge0042
               OTHERWISE
                  LET l_xrgear.xrge004 = l_xrge0041 CLIPPED,l_xrge0042
            END CASE
            LET l_xrgear.xrge005 = l_xmdc.xmdc010
            LET l_xrgear.xrge006 = l_xmdc.xmdc016
            
            
            CALL s_tax_chk(g_xrgd_m.xrgdcomp,l_xrgear.xrge006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
            LET l_xrgear.xrge007 = l_apca013
            LET l_xrgear.xrge008 = l_xmdc.xmdc011
            LET l_xrgear.xrge105 = l_xmdc.xmdc047
            
            IF l_xrgear.xrge008  = 0 THEN
               LET l_xrgear.xrge009 = 0
            ELSE
               LET l_xrgear.xrge009 = l_xrgear.xrge105 / l_xrgear.xrge008 
            END IF
            #取位(原幣)
            CALL s_curr_round_ld('1',l_ld,g_xrgd_m.xrgd100,l_xrgear.xrge009,1) RETURNING g_sub_success,g_errno,l_xrgear.xrge009
            
            LET l_xrgear.xrge100 = NULL
            SELECT xmda015 INTO l_xrgear.xrge100 FROM xmda_t
             WHERE xmdaent = g_enterprise
               AND xmdadocno = l_xrgear.xrge001
               
            ##本幣含稅金額
            #LET g_xrge_d[p_ac].xrge115 = g_xrge_d[p_ac].xrge105 * g_xrgd_m.xrgd101
            IF NOT l_xrgear.xrge100 = g_xrgd_m.xrgd100 THEN
               LET lc_param.apca004 = g_xrgd_m.xrgd004
               LET ls_js = util.JSON.stringify(lc_param)
               CALL s_fin_get_curr_rate(g_xrgd_m.xrgdcomp,l_ld,g_xrgd_m.xrgd003,l_xrgear.xrge100,ls_js)
                                   RETURNING l_xrgear.xrge101,l_dummy2,l_dummy3
            ELSE
               LET l_xrgear.xrge101 = g_xrgd_m.xrgd101
            END IF
            LET l_xrgear.xrge115 = l_xrgear.xrge105 * l_xrgear.xrge101 
            
            #取位(本幣)
            CALL s_curr_round_ld('1',l_ld,l_glaa001,l_xrgear.xrge115,2) RETURNING g_sub_success,g_errno,l_xrgear.xrge115       
            #######
            
            SELECT MAX(xrgeseq)+1 INTO l_xrgear.xrgeseq
              FROM xrge_t
             WHERE xrgeent   = g_enterprise
               AND xrgecomp  = g_xrgd_m.xrgdcomp
               AND xrgedocno = g_xrgd_m.xrgddocno
               AND xrge900   = g_xrgd_m.xrgd900
            IF cl_null(l_xrgear.xrgeseq)THEN
               LET l_xrgear.xrgeseq = 1 
            END IF

            INITIALIZE l_xrge.* TO NULL
            LET l_xrge.xrgeent   = g_enterprise
            LET l_xrge.xrgecomp  = g_xrgd_m.xrgdcomp
            LET l_xrge.xrgedocno = g_xrgd_m.xrgddocno
            LET l_xrge.xrgeseq   = l_xrgear.xrgeseq
            LET l_xrge.xrge900   = g_xrgd_m.xrgd900
            LET l_xrge.xrgeorga  = g_xrgd_m.xrgdcomp
            LET l_xrge.xrge001   = l_xrgear.xrge001
            LET l_xrge.xrge002   = l_xrgear.xrge002
            LET l_xrge.xrge003   = l_xrgear.xrge003
            LET l_xrge.xrge004   = l_xrgear.xrge004
            LET l_xrge.xrge005   = l_xrgear.xrge005
            LET l_xrge.xrge006   = l_xrgear.xrge006
            LET l_xrge.xrge007   = l_xrgear.xrge007
            LET l_xrge.xrge008   = l_xrgear.xrge008
            LET l_xrge.xrge009   = l_xrgear.xrge009
            LET l_xrge.xrge105   = l_xrgear.xrge105
            LET l_xrge.xrge115   = l_xrgear.xrge115
            LET l_xrge.xrge100   = l_xrgear.xrge100
            LET l_xrge.xrge101   = l_xrgear.xrge101
            LET l_count = NULL
            SELECT COUNT(*) INTO l_count FROM xrgb_t
             WHERE xrgbent = g_enterprise
               AND xrgbcomp = g_xrgd_m.xrgdcomp
               AND xrgbdocno = g_xrgd_m.xrgddocno
               AND xrgbseq   = l_xrge.xrgeorga
            IF cl_null(l_count)THEN LET l_count = 0 END IF
            IF l_count = 0 THEN
               LET l_xrge.xrge901 = '3'
            ELSE
               LET l_xrge.xrge901 = '2'
            END IF 
            #161128-00061#5---modify----begin------------- 
            #INSERT INTO xrge_t VALUES(l_xrge.*)
            INSERT INTO xrge_t (xrgeent,xrgecomp,xrgedocno,xrgeseq,xrgeorga,xrge001,xrge002,xrge003,xrge004,
                                xrge005,xrge006,xrge007,xrge008,xrge009,xrge105,xrge115,xrge900,xrge901,xrge902,
                                xrge903,xrge100,xrge101)
             VALUES(l_xrge.xrgeent,l_xrge.xrgecomp,l_xrge.xrgedocno,l_xrge.xrgeseq,l_xrge.xrgeorga,l_xrge.xrge001,l_xrge.xrge002,l_xrge.xrge003,l_xrge.xrge004,
                    l_xrge.xrge005,l_xrge.xrge006,l_xrge.xrge007,l_xrge.xrge008,l_xrge.xrge009,l_xrge.xrge105,l_xrge.xrge115,l_xrge.xrge900,l_xrge.xrge901,l_xrge.xrge902,
                    l_xrge.xrge903,l_xrge.xrge100,l_xrge.xrge101)
            #161128-00061#5---modify----end------------- 
      
         END FOREACH
      END IF
   END FOREACH
   #####
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
