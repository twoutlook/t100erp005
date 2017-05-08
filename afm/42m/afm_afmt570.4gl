#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt570.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2015-12-09 19:16:13), PR版次:0015(2017-01-20 11:36:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000063
#+ Filename...: afmt570
#+ Description: 投資月底重評價維護
#+ Creator....: 04152(2015-04-30 16:07:43)
#+ Modifier...: 02159 -SD/PR- 08729
 
{</section>}
 
{<section id="afmt570.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150401-00001#13 2015/07/21 By RayHuang statechange段問題修正
#150916-00015#1  2015/12/07 By Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#151126-00013#6  2015/12/09 By sakura   加單頭傳票編號串查
#151217-00011#1  2015/12/17 By 03538    增加交易原始單號與afmt530摘要
#151217-00011#2  2015/12/21 By Jessy    增加列印功能
#160129-00015#11 2016/02/25 by sakura   效能調整
#160321-00016#27 2016/03/24 By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00025#50 2016/04/26 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息
#160620-00010#2  2016/06/21 By 01531    拋轉傳票時，傳票憑證日期應該預設單據的財務日期，而非系統日期
#160818-00017#13 2016/08/23 By 07900    删除修改未重新判断状态码
#160913-00017#2  2016/09/21 By 07900    AFM模组调整交易客商开窗
#161004-00012#1  2016/10/04 By albireo  傳票還原需多檢核是否為過帳
#161006-00005#14 2016/10/19 By 08732    組織類型與職能開窗調整
#170103-00019#22 2017/01/10 By Reanna   产生凭证时，应一并检核立冲否，并写入立冲明细表；为科目冲销时，明细操作的立冲处理需开放点选。
#161213-00023#4  2017/01/17 By 06694    新增axrp330_01元件單別參數，默認拋轉單別
#161104-00046#21 2017/01/20 By 08729    單別預設值;資料依照單別user dept權限過濾單號
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
PRIVATE type type_g_fmna_m        RECORD
       fmnasite LIKE fmna_t.fmnasite, 
   fmnasite_desc LIKE type_t.chr80, 
   fmna001 LIKE fmna_t.fmna001, 
   fmna001_desc LIKE type_t.chr80, 
   fmnacomp LIKE fmna_t.fmnacomp, 
   fmnacomp_desc LIKE type_t.chr80, 
   fmnadocno LIKE fmna_t.fmnadocno, 
   fmnadocno_desc LIKE type_t.chr80, 
   fmnadocdt LIKE fmna_t.fmnadocdt, 
   fmna006 LIKE fmna_t.fmna006, 
   fmna006_desc LIKE type_t.chr80, 
   fmna004 LIKE fmna_t.fmna004, 
   fmna002 LIKE fmna_t.fmna002, 
   fmna003 LIKE fmna_t.fmna003, 
   fmna005 LIKE fmna_t.fmna005, 
   fmnastus LIKE fmna_t.fmnastus, 
   fmnaownid LIKE fmna_t.fmnaownid, 
   fmnaownid_desc LIKE type_t.chr80, 
   fmnaowndp LIKE fmna_t.fmnaowndp, 
   fmnaowndp_desc LIKE type_t.chr80, 
   fmnacrtid LIKE fmna_t.fmnacrtid, 
   fmnacrtid_desc LIKE type_t.chr80, 
   fmnacrtdp LIKE fmna_t.fmnacrtdp, 
   fmnacrtdp_desc LIKE type_t.chr80, 
   fmnacrtdt LIKE fmna_t.fmnacrtdt, 
   fmnamodid LIKE fmna_t.fmnamodid, 
   fmnamodid_desc LIKE type_t.chr80, 
   fmnamoddt LIKE fmna_t.fmnamoddt, 
   fmnacnfid LIKE fmna_t.fmnacnfid, 
   fmnacnfid_desc LIKE type_t.chr80, 
   fmnacnfdt LIKE fmna_t.fmnacnfdt, 
   fmnapstid LIKE fmna_t.fmnapstid, 
   fmnapstid_desc LIKE type_t.chr80, 
   fmnapstdt LIKE fmna_t.fmnapstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fmnb_d        RECORD
       fmnbseq LIKE fmnb_t.fmnbseq, 
   fmnb030 LIKE fmnb_t.fmnb030, 
   fmnb033 LIKE fmnb_t.fmnb033, 
   l_fmmj027 LIKE type_t.chr500, 
   fmnb002 LIKE fmnb_t.fmnb002, 
   fmnb003 LIKE fmnb_t.fmnb003, 
   fmnb004 LIKE fmnb_t.fmnb004, 
   fmnb032 LIKE fmnb_t.fmnb032, 
   fmnb100 LIKE fmnb_t.fmnb100, 
   fmnb101 LIKE fmnb_t.fmnb101, 
   fmnb102 LIKE fmnb_t.fmnb102, 
   fmnb103 LIKE fmnb_t.fmnb103, 
   fmnb113 LIKE fmnb_t.fmnb113, 
   fmnb114 LIKE fmnb_t.fmnb114, 
   fmnb115 LIKE fmnb_t.fmnb115, 
   fmnb116 LIKE fmnb_t.fmnb116
       END RECORD
PRIVATE TYPE type_g_fmnb2_d RECORD
       fmnbseq LIKE fmnb_t.fmnbseq, 
   fmnb121 LIKE fmnb_t.fmnb121, 
   fmnb122 LIKE fmnb_t.fmnb122, 
   fmnb123 LIKE fmnb_t.fmnb123, 
   fmnb124 LIKE fmnb_t.fmnb124, 
   fmnb125 LIKE fmnb_t.fmnb125, 
   fmnb126 LIKE fmnb_t.fmnb126
       END RECORD
PRIVATE TYPE type_g_fmnb3_d RECORD
       fmnbseq LIKE fmnb_t.fmnbseq, 
   fmnb131 LIKE fmnb_t.fmnb131, 
   fmnb132 LIKE fmnb_t.fmnb132, 
   fmnb133 LIKE fmnb_t.fmnb133, 
   fmnb134 LIKE fmnb_t.fmnb134, 
   fmnb135 LIKE fmnb_t.fmnb135, 
   fmnb136 LIKE fmnb_t.fmnb136
       END RECORD
PRIVATE TYPE type_g_fmnb4_d RECORD
       fmnbseq LIKE fmnb_t.fmnbseq, 
   fmnb028 LIKE fmnb_t.fmnb028, 
   fmnb028_desc LIKE type_t.chr500, 
   fmnb029 LIKE fmnb_t.fmnb029, 
   fmnb029_desc LIKE type_t.chr500, 
   fmnb031 LIKE fmnb_t.fmnb031, 
   fmnb005 LIKE fmnb_t.fmnb005, 
   fmnb005_desc LIKE type_t.chr500, 
   fmnb006 LIKE fmnb_t.fmnb006, 
   fmnb006_desc LIKE type_t.chr500, 
   fmnb007 LIKE fmnb_t.fmnb007, 
   fmnb007_desc LIKE type_t.chr500, 
   fmnb008 LIKE fmnb_t.fmnb008, 
   fmnb008_desc LIKE type_t.chr500, 
   fmnb009 LIKE fmnb_t.fmnb009, 
   fmnb009_desc LIKE type_t.chr500, 
   fmnb010 LIKE fmnb_t.fmnb010, 
   fmnb010_desc LIKE type_t.chr500, 
   fmnb011 LIKE fmnb_t.fmnb011, 
   fmnb011_desc LIKE type_t.chr500, 
   fmnb012 LIKE fmnb_t.fmnb012, 
   fmnb012_desc LIKE type_t.chr500, 
   fmnb013 LIKE fmnb_t.fmnb013, 
   fmnb013_desc LIKE type_t.chr500, 
   fmnb014 LIKE fmnb_t.fmnb014, 
   fmnb014_desc LIKE type_t.chr500, 
   fmnb015 LIKE fmnb_t.fmnb015, 
   fmnb015_desc LIKE type_t.chr500, 
   fmnb016 LIKE fmnb_t.fmnb016, 
   fmnb016_desc LIKE type_t.chr500, 
   fmnb017 LIKE fmnb_t.fmnb017, 
   fmnb017_desc LIKE type_t.chr500, 
   fmnb018 LIKE fmnb_t.fmnb018, 
   fmnb018_desc LIKE type_t.chr500, 
   fmnb019 LIKE fmnb_t.fmnb019, 
   fmnb019_desc LIKE type_t.chr500, 
   fmnb020 LIKE fmnb_t.fmnb020, 
   fmnb020_desc LIKE type_t.chr500, 
   fmnb021 LIKE fmnb_t.fmnb021, 
   fmnb021_desc LIKE type_t.chr500, 
   fmnb022 LIKE fmnb_t.fmnb022, 
   fmnb022_desc LIKE type_t.chr500, 
   fmnb023 LIKE fmnb_t.fmnb023, 
   fmnb023_desc LIKE type_t.chr500, 
   fmnb024 LIKE fmnb_t.fmnb024, 
   fmnb024_desc LIKE type_t.chr500, 
   fmnb025 LIKE fmnb_t.fmnb025, 
   fmnb025_desc LIKE type_t.chr500, 
   fmnb026 LIKE fmnb_t.fmnb026, 
   fmnb026_desc LIKE type_t.chr500, 
   fmnb027 LIKE fmnb_t.fmnb027, 
   fmnb027_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fmnasite LIKE fmna_t.fmnasite,
      b_fmna001 LIKE fmna_t.fmna001,
      b_fmnacomp LIKE fmna_t.fmnacomp,
      b_fmnadocno LIKE fmna_t.fmnadocno,
      b_fmnadocdt LIKE fmna_t.fmnadocdt,
      b_fmna006 LIKE fmna_t.fmna006,
      b_fmna004 LIKE fmna_t.fmna004,
      b_fmna002 LIKE fmna_t.fmna002,
      b_fmna003 LIKE fmna_t.fmna003,
      b_fmna005 LIKE fmna_t.fmna005
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa                RECORD
                             glaacomp  LIKE glaa_t.glaacomp,
                             glaa004   LIKE glaa_t.glaa004,
                             glaa015   LIKE glaa_t.glaa015,
                             glaa019   LIKE glaa_t.glaa019,
                             glaa024   LIKE glaa_t.glaa024,
                             glaa102   LIKE glaa_t.glaa102,
                             glaa121   LIKE glaa_t.glaa121
                         END RECORD
DEFINE g_glaa013         LIKE glaa_t.glaa013
DEFINE g_glad                RECORD
               glad0171         LIKE  glad_t.glad0171,
               glad0172         LIKE  glad_t.glad0172,
               glad0181         LIKE  glad_t.glad0181,
               glad0182         LIKE  glad_t.glad0182,
               glad0191         LIKE  glad_t.glad0191,
               glad0192         LIKE  glad_t.glad0192,
               glad0201         LIKE  glad_t.glad0201,
               glad0202         LIKE  glad_t.glad0202,
               glad0211         LIKE  glad_t.glad0211,
               glad0212         LIKE  glad_t.glad0212,
               glad0221         LIKE  glad_t.glad0221,
               glad0222         LIKE  glad_t.glad0222,
               glad0231         LIKE  glad_t.glad0231,
               glad0232         LIKE  glad_t.glad0232,
               glad0241         LIKE  glad_t.glad0241,
               glad0242         LIKE  glad_t.glad0242,
               glad0251         LIKE  glad_t.glad0251,
               glad0252         LIKE  glad_t.glad0252,
               glad0261         LIKE  glad_t.glad0261,
               glad0262         LIKE  glad_t.glad0262
                             END RECORD
DEFINE g_wc_fmnasite         STRING
DEFINE g_wc_fmna001          STRING
DEFINE g_wc_cs_comp          STRING   #161006-00005#14   add
DEFINE g_wc_orga             STRING   #161006-00005#14   add
#161104-00046#21 --s add
DEFINE g_user_dept_wc        STRING     
DEFINE g_user_dept_wc_q      STRING    
#161104-00046#21 --e add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_fmna_m          type_g_fmna_m
DEFINE g_fmna_m_t        type_g_fmna_m
DEFINE g_fmna_m_o        type_g_fmna_m
DEFINE g_fmna_m_mask_o   type_g_fmna_m #轉換遮罩前資料
DEFINE g_fmna_m_mask_n   type_g_fmna_m #轉換遮罩後資料
 
   DEFINE g_fmnadocno_t LIKE fmna_t.fmnadocno
 
 
DEFINE g_fmnb_d          DYNAMIC ARRAY OF type_g_fmnb_d
DEFINE g_fmnb_d_t        type_g_fmnb_d
DEFINE g_fmnb_d_o        type_g_fmnb_d
DEFINE g_fmnb_d_mask_o   DYNAMIC ARRAY OF type_g_fmnb_d #轉換遮罩前資料
DEFINE g_fmnb_d_mask_n   DYNAMIC ARRAY OF type_g_fmnb_d #轉換遮罩後資料
DEFINE g_fmnb2_d          DYNAMIC ARRAY OF type_g_fmnb2_d
DEFINE g_fmnb2_d_t        type_g_fmnb2_d
DEFINE g_fmnb2_d_o        type_g_fmnb2_d
DEFINE g_fmnb2_d_mask_o   DYNAMIC ARRAY OF type_g_fmnb2_d #轉換遮罩前資料
DEFINE g_fmnb2_d_mask_n   DYNAMIC ARRAY OF type_g_fmnb2_d #轉換遮罩後資料
DEFINE g_fmnb3_d          DYNAMIC ARRAY OF type_g_fmnb3_d
DEFINE g_fmnb3_d_t        type_g_fmnb3_d
DEFINE g_fmnb3_d_o        type_g_fmnb3_d
DEFINE g_fmnb3_d_mask_o   DYNAMIC ARRAY OF type_g_fmnb3_d #轉換遮罩前資料
DEFINE g_fmnb3_d_mask_n   DYNAMIC ARRAY OF type_g_fmnb3_d #轉換遮罩後資料
DEFINE g_fmnb4_d          DYNAMIC ARRAY OF type_g_fmnb4_d
DEFINE g_fmnb4_d_t        type_g_fmnb4_d
DEFINE g_fmnb4_d_o        type_g_fmnb4_d
DEFINE g_fmnb4_d_mask_o   DYNAMIC ARRAY OF type_g_fmnb4_d #轉換遮罩前資料
DEFINE g_fmnb4_d_mask_n   DYNAMIC ARRAY OF type_g_fmnb4_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
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
 
{<section id="afmt570.main" >}
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
   #161104-00046#21 --s add
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','fmna001','fmnaent','fmnadocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   #161104-00046#21 --e add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmnasite,'',fmna001,'',fmnacomp,'',fmnadocno,'',fmnadocdt,fmna006,'', 
       fmna004,fmna002,fmna003,fmna005,fmnastus,fmnaownid,'',fmnaowndp,'',fmnacrtid,'',fmnacrtdp,'', 
       fmnacrtdt,fmnamodid,'',fmnamoddt,fmnacnfid,'',fmnacnfdt,fmnapstid,'',fmnapstdt", 
                      " FROM fmna_t",
                      " WHERE fmnaent= ? AND fmnadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt570_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmnasite,t0.fmna001,t0.fmnacomp,t0.fmnadocno,t0.fmnadocdt,t0.fmna006, 
       t0.fmna004,t0.fmna002,t0.fmna003,t0.fmna005,t0.fmnastus,t0.fmnaownid,t0.fmnaowndp,t0.fmnacrtid, 
       t0.fmnacrtdp,t0.fmnacrtdt,t0.fmnamodid,t0.fmnamoddt,t0.fmnacnfid,t0.fmnacnfdt,t0.fmnapstid,t0.fmnapstdt, 
       t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011 ,t7.ooag011",
               " FROM fmna_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.fmnaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.fmnaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.fmnacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.fmnacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.fmnamodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fmnacnfid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.fmnapstid  ",
 
               " WHERE t0.fmnaent = " ||g_enterprise|| " AND t0.fmnadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmt570_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmt570 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmt570_init()   
 
      #進入選單 Menu (="N")
      CALL afmt570_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmt570
      
   END IF 
   
   CLOSE afmt570_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmt570.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt570_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('fmnastus','13','Y,N,A,D,R,W,X')
 
      CALL cl_set_combo_scc('fmna004','8805') 
   CALL cl_set_combo_scc('fmnb015','6013') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2','3','4',","1")
   CALL g_idx_group.addAttribute("","1")
   CALL g_idx_group.addAttribute("","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #啟用分錄底稿用
   CALL s_fin_continue_no_tmp()
   #資料來源
   CALL cl_set_combo_scc('fmna004','8805')
   #經營方式
   CALL cl_set_combo_scc('fmnb015_desc','6013')
   
   #161006-00005#14   add---s
   CALL s_fin_azzi800_sons_query(g_today) 
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   CALL s_fin_account_center_sons_str() RETURNING g_wc_orga   
   CALL s_fin_get_wc_str(g_wc_orga) RETURNING g_wc_orga
   #161006-00005#14   add---e
   #end add-point
   
   #初始化搜尋條件
   CALL afmt570_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afmt570.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afmt570_ui_dialog()
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
   DEFINE l_wc        STRING
   DEFINE l_count     LIKE type_t.num5
   DEFINE l_slip      LIKE glap_t.glapdocno
   DEFINE l_date      LIKE glap_t.glapdocdt
   DEFINE l_glapdocdt LIKE glap_t.glapdocdt
   DEFINE l_sfin3007  LIKE type_t.dat
   DEFINE l_glap001   LIKE glap_t.glap001    #傳票性質
   DEFINE l_glca002   LIKE glca_t.glca002
   DEFINE l_stus      LIKE glap_t.glapstus
   DEFINE l_sys       LIKE type_t.chr2       #150829
   #170103-00019#22 add ------
   DEFINE l_scom0002  LIKE type_t.chr10
   DEFINE l_success   LIKE type_t.num5
   #170103-00019#22 add end---
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
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_fmna_m.* TO NULL
         CALL g_fmnb_d.clear()
         CALL g_fmnb2_d.clear()
         CALL g_fmnb3_d.clear()
         CALL g_fmnb4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmt570_init()
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
               
               CALL afmt570_fetch('') # reload data
               LET l_ac = 1
               CALL afmt570_ui_detailshow() #Setting the current row 
         
               CALL afmt570_idx_chk()
               #NEXT FIELD fmnbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_fmnb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt570_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2','3','4',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','3','4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL afmt570_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_fmnb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt570_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL afmt570_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fmnb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt570_idx_chk()
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
               CALL afmt570_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fmnb4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt570_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL afmt570_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL afmt570_browser_fill("")
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
               CALL afmt570_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afmt570_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afmt570_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL afmt570_set_act_visible()
            CALL afmt570_set_act_no_visible()
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afmt570_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afmt570_set_act_visible()   
            CALL afmt570_set_act_no_visible()
            IF NOT (g_fmna_m.fmnadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fmnaent = " ||g_enterprise|| " AND",
                                  " fmnadocno = '", g_fmna_m.fmnadocno, "' "
 
               #填到對應位置
               CALL afmt570_browser_fill("")
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
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "fmna_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmnb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL afmt570_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "fmna_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmnb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afmt570_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt570_fetch("F")
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
               CALL afmt570_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afmt570_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt570_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afmt570_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt570_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afmt570_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt570_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afmt570_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt570_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afmt570_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt570_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_fmnb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fmnb2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_fmnb3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_fmnb4_d)
                  LET g_export_id[4]   = "s_detail4"
 
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
               NEXT FIELD fmnbseq
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
               CALL afmt570_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afmt570_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapp330
            LET g_action_choice="open_aapp330"
            IF cl_auth_chk_act("open_aapp330") THEN
               
               #add-point:ON ACTION open_aapp330 name="menu.open_aapp330"
               IF g_fmna_m.fmnadocno IS NULL THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = "" 
                 LET g_errparam.code   = "std-00003" 
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 CONTINUE DIALOG
               END IF
               
               #未確認單據不可拋轉
               IF g_fmna_m.fmnastus = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00185'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               #無傳票號碼才可拋轉
               IF cl_null(g_fmna_m.fmna005) THEN
                  
                  ##取所屬法人關帳日
                  #CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-3007') RETURNING l_sfin3007 
                  
                  #產生單別/日期
                  #CALL axrp330_01(g_fmna_m.fmna001) RETURNING l_slip,l_date                    #160620-00010#2 mark
                  CALL axrp330_01(g_fmna_m.fmna001,g_fmna_m.fmnadocdt,g_fmna_m.fmnadocno) RETURNING l_slip,l_date  #160620-00010#2 add  #161213-00023#4 add  g_fmna_m.fmnadocno
                  
                  
                  #若取消產生時，就不往下走拋轉了
                  IF cl_null(l_slip) THEN
                     CONTINUE DIALOG
                  END IF
                  
                  ##必須大於帳套關帳日期才可拋轉
                  #IF l_date < l_sfin3007 THEN
                  #   LET g_errparam.code = 'aap-00077'
                  #   LET g_errparam.extend = ''
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #   CONTINUE DIALOG
                  #END IF
                  
                  CALL s_transaction_begin()

                  CALL cl_err_collect_init()
                  IF g_glaa.glaa121 = 'Y' THEN 
                     LET l_wc =" glgbdocno = '",g_fmna_m.fmnadocno,"' "
                     CALL s_pre_voucher_ins_glap('FM','M10',g_fmna_m.fmna001,l_date,l_slip,'1',l_wc) 
                          RETURNING g_sub_success,g_fmna_m.fmna005,g_fmna_m.fmna005
                  ELSE
                     LET l_wc =" fmnadocno = '",g_fmna_m.fmnadocno,"' "
                     CALL s_voucher_gen_fm('3',g_fmna_m.fmna001,l_date,l_slip,'0',l_wc,'N','afmt570')
                          RETURNING g_sub_success,g_fmna_m.fmna005,g_fmna_m.fmna005
                  END IF
                  CALL cl_err_collect_show()

                  IF g_sub_success THEN
                     UPDATE glga_t SET glga007 = g_fmna_m.fmna005
                      WHERE glgaent = g_enterprise AND glgald = g_fmna_m.fmna001
                        AND glgadocno=g_fmna_m.fmnadocno AND glga100 = 'FM' AND glga101 = 'M10'
                     CALL s_transaction_end('Y','0')
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'adz-00217'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  ELSE
                     IF cl_null(g_fmna_m.fmna005) THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'axc-00530'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     ELSE
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'axr-00120'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF
                     CALL s_transaction_end('N','0')
                  END IF
                  
                  #重新顯示傳票號碼
                  SELECT fmna005 INTO g_fmna_m.fmna005
                    FROM fmna_t
                   WHERE fmnaent = g_enterprise
                     AND fmnadocno = g_fmna_m.fmnadocno
                  DISPLAY BY NAME g_fmna_m.fmna005
               ELSE
                  LET l_glap001 = ''
                  SELECT glap001 INTO l_glap001
                    FROM glap_t
                   WHERE glapent = g_enterprise AND glapld = g_fmna_m.fmna001
                     AND glapdocno = g_fmna_m.fmna005
                  IF NOT l_glap001 MATCHES '[1235]' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00029'
                     LET g_errparam.extend = g_fmna_m.fmnadocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  ELSE
                     #150829 add ------
                     SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_glca002
                       FROM glca_t
                      WHERE glcaent = g_enterprise
                        AND glcald  = g_fmna_m.fmna001 AND glca001 = 'FM'
                     IF l_glca002 = 'Y' THEN
                        LET g_prog = 'aglt350'
                     ELSE
                        LET g_prog = 'aglt310'
                     END IF
                     #150829 add end---
                     LET la_param.prog = g_prog
                     LET la_param.param[1] = g_fmna_m.fmna001
                     LET la_param.param[2] = g_fmna_m.fmna005
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun(ls_js)
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               #產生分錄底稿
               IF NOT cl_null(g_fmna_m.fmnadocno) AND g_fmna_m.fmnastus = 'N' THEN
                  CALL s_transaction_begin()
                  CALL s_pre_voucher_ins('FM','M10',g_fmna_m.fmna001,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt,'3')
                       RETURNING g_sub_success
                  IF g_sub_success THEN
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt300_14
            LET g_action_choice="open_aapt300_14"
            IF cl_auth_chk_act("open_aapt300_14") THEN
               
               #add-point:ON ACTION open_aapt300_14 name="menu.open_aapt300_14"
               #傳票預覽
               #150829 add ------
               SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_glca002
                 FROM glca_t
                WHERE glcaent = g_enterprise
                  AND glcald  = g_fmna_m.fmna001 AND glca001 = 'FM'
               IF l_glca002 = 'Y' THEN
                  LET l_sys = 'AC'
               ELSE
                  LET l_sys = 'FM'
               END IF
               #150829 add end---
               IF g_glaa.glaa121 = 'Y' THEN
                 #CALL s_pre_voucher('FM','M10',g_fmna_m.fmna001,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt)   #150829 mark
                  CALL s_pre_voucher(l_sys,'M10',g_fmna_m.fmna001,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt)  #150829
               ELSE
                  CALL axrt300_13('FM',g_fmna_m.fmna001,g_fmna_m.fmnadocno,'afmt570')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_reback
            LET g_action_choice="open_reback"
            IF cl_auth_chk_act("open_reback") THEN
               
               #add-point:ON ACTION open_reback name="menu.open_reback"
               CALL s_transaction_begin()
               #傳票還原
               IF g_fmna_m.fmnadocno IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "std-00003"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #無傳票 不可還原
               IF g_fmna_m.fmna005 IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "anm-00186"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #傳票還原單據日期不可小於等於過帳日期             
               CALL s_afm_close_day_chk(g_fmna_m.fmna001,g_fmna_m.fmna005) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF


               IF NOT cl_ask_confirm('aap-00239') THEN
                  CALL s_transaction_end('N','0')
                  EXIT DIALOG
               ELSE
                  #傳票已經確認不可還原
                  SELECT glapstus INTO l_stus
                    FROM glap_t
                   WHERE glapent = g_enterprise
                     AND glapdocno = g_fmna_m.fmna005
                  
                  #IF l_stus = 'Y' THEN    #161004-00012#1 mark
                  IF l_stus = 'Y' OR l_stus = 'S' THEN   #161004-00012#1
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00076'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  ELSE
                     #170103-00019#22 add ------
                     #更新相关的细项立冲账资料
                     LET l_success = TRUE
                     CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-COM-0002') RETURNING l_scom0002
                     CALL s_pre_voucher_delete_glax(g_fmna_m.fmna001,g_fmna_m.fmna005,'',l_scom0002) RETURNING l_success
                     IF l_success = FALSE THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                     
                     IF l_scom0002 = 'Y' THEN
                        #凭证作废处理
                        UPDATE glap_t SET glapstus = 'X'
                         WHERE glapent = g_enterprise
                           AND glapld = g_fmna_m.fmna001
                           AND glapdocno = g_fmna_m.fmna005
                        IF SQLCA.SQLCODE THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.SQLCODE
                           LET g_errparam.extend = 'UPDATE glap_t'
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                           CONTINUE DIALOG
                        END IF
                     ELSE
                        #删除凭证
                     #170103-00019#22 add end---
                        #取得傳票日期
                        SELECT glapdocdt INTO l_glapdocdt
                          FROM glap_t
                         WHERE glapent = g_enterprise
                           AND glapld = g_fmna_m.fmna001
                           AND glapdocno = g_fmna_m.fmna005
                        #刪除單頭
                        DELETE FROM glap_t
                         WHERE glapent   = g_enterprise
                           AND glapld = g_fmna_m.fmna001
                           AND glapdocno = g_fmna_m.fmna005
                        #刪除單身
                        DELETE FROM glaq_t
                         WHERE glaqent = g_enterprise
                           AND glaqld = g_fmna_m.fmna001
                           AND glaqdocno = g_fmna_m.fmna005
                        #150825-00004#8 add ------
                        #刪除傳票產生的現金變動碼
                        CALL s_cashflow_nm_del_glbc(l_glapdocdt,g_fmna_m.fmna001,g_fmna_m.fmna005,'')
                             RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code   = g_errno
                           LET g_errparam.extend = 'DELETE glbc_t'
                           LET g_errparam.popup  = TRUE
                           CALL s_transaction_end('N','0')
                           CALL cl_err()
                        END IF
                        #150825-00004#8 add end---
                        #170103-00019#22 mark ------
                        ##更新月結這邊的傳票號碼要給空
                        #UPDATE fmna_t SET fmna005 = ''
                        # WHERE fmnaent = g_enterprise
                        #   AND fmnadocno = g_fmna_m.fmnadocno
                        #170103-00019#22 mark end---
                        #更新最大號
                        SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_glca002
                          FROM glca_t
                         WHERE glcaent = g_enterprise
                           AND glcald  = g_fmna_m.fmna001 AND glca001 = 'FM'
                        IF l_glca002 = 'Y' THEN
                           LET g_prog = 'aglt350'
                        ELSE
                           LET g_prog = 'aglt310'
                        END IF
                        IF NOT s_aooi200_fin_del_docno(g_fmna_m.fmna001,g_fmna_m.fmna005,l_glapdocdt) THEN
                           CALL s_transaction_end('N','0')
                           CONTINUE DIALOG
                        END IF
                        LET g_prog = 'afmt570'
                        #170103-00019#22 mark ------
                        #LET g_fmna_m.fmna005 = ''
                        #DISPLAY BY NAME g_fmna_m.fmna005
                        #170103-00019#22 mark end---
                        #分錄底稿
                        UPDATE glga_t SET glga007 = ''
                         WHERE glgaent = g_enterprise AND glgald = g_fmna_m.fmna001
                           AND glgadocno=g_fmna_m.fmnadocno AND glga100 = 'FM' AND glga101 = 'M10'
   
                     #170103-00019#22 add ------  
                     END IF
                     #更新月結這邊的傳票號碼要給空
                     UPDATE fmna_t SET fmna005 = ''
                      WHERE fmnaent = g_enterprise
                        AND fmnadocno = g_fmna_m.fmnadocno
                     LET g_fmna_m.fmna005 = ''
                     DISPLAY BY NAME g_fmna_m.fmna005
                     #170103-00019#22 add end---
                     
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " fmnaent = ",g_enterprise," AND fmnadocno = '",g_fmna_m.fmnadocno,"' AND fmnastus <> 'X' "  #151217-00011#2
               #END add-point
               &include "erp/afm/afmt570_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " fmnaent = ",g_enterprise," AND fmnadocno = '",g_fmna_m.fmnadocno,"' AND fmnastus <> 'X' "  #151217-00011#2
               #END add-point
               &include "erp/afm/afmt570_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt570_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fmna006
            LET g_action_choice="prog_fmna006"
            IF cl_auth_chk_act("prog_fmna006") THEN
               
               #add-point:ON ACTION prog_fmna006 name="menu.prog_fmna006"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_fmna_m.fmna006)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fmna005
            LET g_action_choice="prog_fmna005"
            IF cl_auth_chk_act("prog_fmna005") THEN
               
               #add-point:ON ACTION prog_fmna005 name="menu.prog_fmna005"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               #151126-00013#6(S)
               INITIALIZE la_param.* TO NULL
               IF NOT cl_null(g_fmna_m.fmna005) THEN
                  LET l_glap001 = ''
                  SELECT glap001 INTO l_glap001 
                    FROM glap_t 
                   WHERE glapent = g_enterprise
                     AND glapdocno = g_fmna_m.fmna005  
                     AND glapld = g_fmna_m.fmna001               
                  CASE
                     WHEN l_glap001 = '1'
                        LET la_param.prog = "aglt310"
                     WHEN l_glap001 = '2'
                        LET la_param.prog = "aglt320"
                     WHEN l_glap001 = '3'
                        LET la_param.prog = "aglt330"
                     WHEN l_glap001 = '5'
                        LET la_param.prog = "aglt350"
                  END CASE
                  LET la_param.param[1] = g_fmna_m.fmna001
                  LET la_param.param[2] = g_fmna_m.fmna005
                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #151126-00013#6(E)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt570_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt570_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt570_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmna_m.fmnadocdt)
 
 
 
         
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
 
{<section id="afmt570.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afmt570_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT fmnadocno ",
                      " FROM fmna_t ",
                      " ",
                      " LEFT JOIN fmnb_t ON fmnbent = fmnaent AND fmnadocno = fmnbdocno ", "  ",
                      #add-point:browser_fill段sql(fmnb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE fmnaent = " ||g_enterprise|| " AND fmnbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fmna_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fmnadocno ",
                      " FROM fmna_t ", 
                      "  ",
                      "  ",
                      " WHERE fmnaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fmna_t")
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
      INITIALIZE g_fmna_m.* TO NULL
      CALL g_fmnb_d.clear()        
      CALL g_fmnb2_d.clear() 
      CALL g_fmnb3_d.clear() 
      CALL g_fmnb4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fmnasite,t0.fmna001,t0.fmnacomp,t0.fmnadocno,t0.fmnadocdt,t0.fmna006,t0.fmna004,t0.fmna002,t0.fmna003,t0.fmna005 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmnastus,t0.fmnasite,t0.fmna001,t0.fmnacomp,t0.fmnadocno,t0.fmnadocdt, 
          t0.fmna006,t0.fmna004,t0.fmna002,t0.fmna003,t0.fmna005 ",
                  " FROM fmna_t t0",
                  "  ",
                  "  LEFT JOIN fmnb_t ON fmnbent = fmnaent AND fmnadocno = fmnbdocno ", "  ", 
                  #add-point:browser_fill段sql(fmnb_t1) name="browser_fill.join.fmnb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.fmnaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("fmna_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmnastus,t0.fmnasite,t0.fmna001,t0.fmnacomp,t0.fmnadocno,t0.fmnadocdt, 
          t0.fmna006,t0.fmna004,t0.fmna002,t0.fmna003,t0.fmna005 ",
                  " FROM fmna_t t0",
                  "  ",
                  
                  " WHERE t0.fmnaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("fmna_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY fmnadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmna_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmnasite,g_browser[g_cnt].b_fmna001, 
          g_browser[g_cnt].b_fmnacomp,g_browser[g_cnt].b_fmnadocno,g_browser[g_cnt].b_fmnadocdt,g_browser[g_cnt].b_fmna006, 
          g_browser[g_cnt].b_fmna004,g_browser[g_cnt].b_fmna002,g_browser[g_cnt].b_fmna003,g_browser[g_cnt].b_fmna005 
 
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
         CALL afmt570_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_fmnadocno) THEN
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
 
{<section id="afmt570.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afmt570_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fmna_m.fmnadocno = g_browser[g_current_idx].b_fmnadocno   
 
   EXECUTE afmt570_master_referesh USING g_fmna_m.fmnadocno INTO g_fmna_m.fmnasite,g_fmna_m.fmna001, 
       g_fmna_m.fmnacomp,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt,g_fmna_m.fmna006,g_fmna_m.fmna004,g_fmna_m.fmna002, 
       g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus,g_fmna_m.fmnaownid,g_fmna_m.fmnaowndp,g_fmna_m.fmnacrtid, 
       g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid, 
       g_fmna_m.fmnacnfdt,g_fmna_m.fmnapstid,g_fmna_m.fmnapstdt,g_fmna_m.fmnaownid_desc,g_fmna_m.fmnaowndp_desc, 
       g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp_desc,g_fmna_m.fmnamodid_desc,g_fmna_m.fmnacnfid_desc, 
       g_fmna_m.fmnapstid_desc
   
   CALL afmt570_fmna_t_mask()
   CALL afmt570_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afmt570.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afmt570_ui_detailshow()
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
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt570_ui_browser_refresh()
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
      IF g_browser[l_i].b_fmnadocno = g_fmna_m.fmnadocno 
 
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
 
{<section id="afmt570.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt570_construct()
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
   INITIALIZE g_fmna_m.* TO NULL
   CALL g_fmnb_d.clear()        
   CALL g_fmnb2_d.clear() 
   CALL g_fmnb3_d.clear() 
   CALL g_fmnb4_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON fmnasite,fmna001,fmnacomp,fmnadocno,fmnadocdt,fmna006,fmna004,fmna002, 
          fmna003,fmna005,fmnastus,fmnaownid,fmnaowndp,fmnacrtid,fmnacrtdp,fmnacrtdt,fmnamodid,fmnamoddt, 
          fmnacnfid,fmnacnfdt,fmnapstid,fmnapstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmnacrtdt>>----
         AFTER FIELD fmnacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmnamoddt>>----
         AFTER FIELD fmnamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmnacnfdt>>----
         AFTER FIELD fmnacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmnapstdt>>----
         AFTER FIELD fmnapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.fmnasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnasite
            #add-point:ON ACTION controlp INFIELD fmnasite name="construct.c.fmnasite"
            #帳務中心
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef204 = 'Y' "   #161006-00005#14   mark 
            #CALL q_ooef001()     #161006-00005#14   mark                    
            CALL q_ooef001_46()   #161006-00005#14   add
            DISPLAY g_qryparam.return1 TO fmnasite
            NEXT FIELD fmnasite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnasite
            #add-point:BEFORE FIELD fmnasite name="construct.b.fmnasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnasite
            
            #add-point:AFTER FIELD fmnasite name="construct.a.fmnasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmna001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmna001
            #add-point:ON ACTION controlp INFIELD fmna001 name="construct.c.fmna001"
            #帳套
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO fmna001
            NEXT FIELD fmna001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmna001
            #add-point:BEFORE FIELD fmna001 name="construct.b.fmna001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmna001
            
            #add-point:AFTER FIELD fmna001 name="construct.a.fmna001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmnacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnacomp
            #add-point:ON ACTION controlp INFIELD fmnacomp name="construct.c.fmnacomp"
            #歸屬法人
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' ",
                                   " AND ooef001 IN ", g_wc_cs_comp  #161006-00005#14   add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO fmnacomp
            NEXT FIELD fmnacomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnacomp
            #add-point:BEFORE FIELD fmnacomp name="construct.b.fmnacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnacomp
            
            #add-point:AFTER FIELD fmnacomp name="construct.a.fmnacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmnadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnadocno
            #add-point:ON ACTION controlp INFIELD fmnadocno name="construct.c.fmnadocno"
            #重評價帳務單號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161104-00046#21 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_user_dept_wc_q 
            END IF
            #161104-00046#21 --e add 
            CALL q_fmnadocno()
            DISPLAY g_qryparam.return1 TO fmnadocno
            NEXT FIELD fmnadocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnadocno
            #add-point:BEFORE FIELD fmnadocno name="construct.b.fmnadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnadocno
            
            #add-point:AFTER FIELD fmnadocno name="construct.a.fmnadocno"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnadocdt
            #add-point:BEFORE FIELD fmnadocdt name="construct.b.fmnadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnadocdt
            
            #add-point:AFTER FIELD fmnadocdt name="construct.a.fmnadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmnadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnadocdt
            #add-point:ON ACTION controlp INFIELD fmnadocdt name="construct.c.fmnadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmna006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmna006
            #add-point:ON ACTION controlp INFIELD fmna006 name="construct.c.fmna006"
            #帳務人員
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO fmna006
            NEXT FIELD fmna006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmna006
            #add-point:BEFORE FIELD fmna006 name="construct.b.fmna006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmna006
            
            #add-point:AFTER FIELD fmna006 name="construct.a.fmna006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmna004
            #add-point:BEFORE FIELD fmna004 name="construct.b.fmna004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmna004
            
            #add-point:AFTER FIELD fmna004 name="construct.a.fmna004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmna004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmna004
            #add-point:ON ACTION controlp INFIELD fmna004 name="construct.c.fmna004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmna002
            #add-point:BEFORE FIELD fmna002 name="construct.b.fmna002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmna002
            
            #add-point:AFTER FIELD fmna002 name="construct.a.fmna002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmna002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmna002
            #add-point:ON ACTION controlp INFIELD fmna002 name="construct.c.fmna002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmna003
            #add-point:BEFORE FIELD fmna003 name="construct.b.fmna003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmna003
            
            #add-point:AFTER FIELD fmna003 name="construct.a.fmna003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmna003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmna003
            #add-point:ON ACTION controlp INFIELD fmna003 name="construct.c.fmna003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmna005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmna005
            #add-point:ON ACTION controlp INFIELD fmna005 name="construct.c.fmna005"
            #傳票編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmna005()
            DISPLAY g_qryparam.return1 TO fmna005
            NEXT FIELD fmna005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmna005
            #add-point:BEFORE FIELD fmna005 name="construct.b.fmna005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmna005
            
            #add-point:AFTER FIELD fmna005 name="construct.a.fmna005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnastus
            #add-point:BEFORE FIELD fmnastus name="construct.b.fmnastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnastus
            
            #add-point:AFTER FIELD fmnastus name="construct.a.fmnastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmnastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnastus
            #add-point:ON ACTION controlp INFIELD fmnastus name="construct.c.fmnastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmnaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnaownid
            #add-point:ON ACTION controlp INFIELD fmnaownid name="construct.c.fmnaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmnaownid  #顯示到畫面上
            NEXT FIELD fmnaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnaownid
            #add-point:BEFORE FIELD fmnaownid name="construct.b.fmnaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnaownid
            
            #add-point:AFTER FIELD fmnaownid name="construct.a.fmnaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmnaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnaowndp
            #add-point:ON ACTION controlp INFIELD fmnaowndp name="construct.c.fmnaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmnaowndp  #顯示到畫面上
            NEXT FIELD fmnaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnaowndp
            #add-point:BEFORE FIELD fmnaowndp name="construct.b.fmnaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnaowndp
            
            #add-point:AFTER FIELD fmnaowndp name="construct.a.fmnaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmnacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnacrtid
            #add-point:ON ACTION controlp INFIELD fmnacrtid name="construct.c.fmnacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmnacrtid  #顯示到畫面上
            NEXT FIELD fmnacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnacrtid
            #add-point:BEFORE FIELD fmnacrtid name="construct.b.fmnacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnacrtid
            
            #add-point:AFTER FIELD fmnacrtid name="construct.a.fmnacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmnacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnacrtdp
            #add-point:ON ACTION controlp INFIELD fmnacrtdp name="construct.c.fmnacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmnacrtdp  #顯示到畫面上
            NEXT FIELD fmnacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnacrtdp
            #add-point:BEFORE FIELD fmnacrtdp name="construct.b.fmnacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnacrtdp
            
            #add-point:AFTER FIELD fmnacrtdp name="construct.a.fmnacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnacrtdt
            #add-point:BEFORE FIELD fmnacrtdt name="construct.b.fmnacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmnamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnamodid
            #add-point:ON ACTION controlp INFIELD fmnamodid name="construct.c.fmnamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmnamodid  #顯示到畫面上
            NEXT FIELD fmnamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnamodid
            #add-point:BEFORE FIELD fmnamodid name="construct.b.fmnamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnamodid
            
            #add-point:AFTER FIELD fmnamodid name="construct.a.fmnamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnamoddt
            #add-point:BEFORE FIELD fmnamoddt name="construct.b.fmnamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmnacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnacnfid
            #add-point:ON ACTION controlp INFIELD fmnacnfid name="construct.c.fmnacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmnacnfid  #顯示到畫面上
            NEXT FIELD fmnacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnacnfid
            #add-point:BEFORE FIELD fmnacnfid name="construct.b.fmnacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnacnfid
            
            #add-point:AFTER FIELD fmnacnfid name="construct.a.fmnacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnacnfdt
            #add-point:BEFORE FIELD fmnacnfdt name="construct.b.fmnacnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmnapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnapstid
            #add-point:ON ACTION controlp INFIELD fmnapstid name="construct.c.fmnapstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmnapstid  #顯示到畫面上
            NEXT FIELD fmnapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnapstid
            #add-point:BEFORE FIELD fmnapstid name="construct.b.fmnapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnapstid
            
            #add-point:AFTER FIELD fmnapstid name="construct.a.fmnapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnapstdt
            #add-point:BEFORE FIELD fmnapstdt name="construct.b.fmnapstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON fmnbseq,fmnb030,fmnb033,fmnb002,fmnb003,fmnb004,fmnb032,fmnb100,fmnb101, 
          fmnb102,fmnb103,fmnb113,fmnb114,fmnb115,fmnb116,fmnb121,fmnb122,fmnb123,fmnb124,fmnb125,fmnb126, 
          fmnb131,fmnb132,fmnb133,fmnb134,fmnb135,fmnb136,fmnb028,fmnb028_desc,fmnb029,fmnb029_desc, 
          fmnb031,fmnb005,fmnb005_desc,fmnb006,fmnb006_desc,fmnb007,fmnb007_desc,fmnb008,fmnb008_desc, 
          fmnb009,fmnb009_desc,fmnb010,fmnb010_desc,fmnb011,fmnb011_desc,fmnb012,fmnb012_desc,fmnb013, 
          fmnb013_desc,fmnb014,fmnb014_desc,fmnb015,fmnb015_desc,fmnb016,fmnb016_desc,fmnb017,fmnb017_desc 
 
           FROM s_detail1[1].fmnbseq,s_detail1[1].fmnb030,s_detail1[1].fmnb033,s_detail1[1].fmnb002, 
               s_detail1[1].fmnb003,s_detail1[1].fmnb004,s_detail1[1].fmnb032,s_detail1[1].fmnb100,s_detail1[1].fmnb101, 
               s_detail1[1].fmnb102,s_detail1[1].fmnb103,s_detail1[1].fmnb113,s_detail1[1].fmnb114,s_detail1[1].fmnb115, 
               s_detail1[1].fmnb116,s_detail2[1].fmnb121,s_detail2[1].fmnb122,s_detail2[1].fmnb123,s_detail2[1].fmnb124, 
               s_detail2[1].fmnb125,s_detail2[1].fmnb126,s_detail3[1].fmnb131,s_detail3[1].fmnb132,s_detail3[1].fmnb133, 
               s_detail3[1].fmnb134,s_detail3[1].fmnb135,s_detail3[1].fmnb136,s_detail4[1].fmnb028,s_detail4[1].fmnb028_desc, 
               s_detail4[1].fmnb029,s_detail4[1].fmnb029_desc,s_detail4[1].fmnb031,s_detail4[1].fmnb005, 
               s_detail4[1].fmnb005_desc,s_detail4[1].fmnb006,s_detail4[1].fmnb006_desc,s_detail4[1].fmnb007, 
               s_detail4[1].fmnb007_desc,s_detail4[1].fmnb008,s_detail4[1].fmnb008_desc,s_detail4[1].fmnb009, 
               s_detail4[1].fmnb009_desc,s_detail4[1].fmnb010,s_detail4[1].fmnb010_desc,s_detail4[1].fmnb011, 
               s_detail4[1].fmnb011_desc,s_detail4[1].fmnb012,s_detail4[1].fmnb012_desc,s_detail4[1].fmnb013, 
               s_detail4[1].fmnb013_desc,s_detail4[1].fmnb014,s_detail4[1].fmnb014_desc,s_detail4[1].fmnb015, 
               s_detail4[1].fmnb015_desc,s_detail4[1].fmnb016,s_detail4[1].fmnb016_desc,s_detail4[1].fmnb017, 
               s_detail4[1].fmnb017_desc
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnbseq
            #add-point:BEFORE FIELD fmnbseq name="construct.b.page1.fmnbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnbseq
            
            #add-point:AFTER FIELD fmnbseq name="construct.a.page1.fmnbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnbseq
            #add-point:ON ACTION controlp INFIELD fmnbseq name="construct.c.page1.fmnbseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmnb030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb030
            #add-point:ON ACTION controlp INFIELD fmnb030 name="construct.c.page1.fmnb030"
            #來源組織
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooef201 = 'Y' AND ooef001 IN ", g_wc_orga  #161006-00005#14  add
            #                      " ooef206 = 'Y' " #150611-00016#5   #161006-00005#14   mark
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO fmnb030
            NEXT FIELD fmnb030
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb030
            #add-point:BEFORE FIELD fmnb030 name="construct.b.page1.fmnb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb030
            
            #add-point:AFTER FIELD fmnb030 name="construct.a.page1.fmnb030"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb033
            #add-point:BEFORE FIELD fmnb033 name="construct.b.page1.fmnb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb033
            
            #add-point:AFTER FIELD fmnb033 name="construct.a.page1.fmnb033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb033
            #add-point:ON ACTION controlp INFIELD fmnb033 name="construct.c.page1.fmnb033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb002
            #add-point:BEFORE FIELD fmnb002 name="construct.b.page1.fmnb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb002
            
            #add-point:AFTER FIELD fmnb002 name="construct.a.page1.fmnb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb002
            #add-point:ON ACTION controlp INFIELD fmnb002 name="construct.c.page1.fmnb002"
            #業務單號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmnb002()
            DISPLAY g_qryparam.return1 TO fmnb002
            NEXT FIELD fmnb002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb003
            #add-point:BEFORE FIELD fmnb003 name="construct.b.page1.fmnb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb003
            
            #add-point:AFTER FIELD fmnb003 name="construct.a.page1.fmnb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb003
            #add-point:ON ACTION controlp INFIELD fmnb003 name="construct.c.page1.fmnb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb004
            #add-point:BEFORE FIELD fmnb004 name="construct.b.page1.fmnb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb004
            
            #add-point:AFTER FIELD fmnb004 name="construct.a.page1.fmnb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb004
            #add-point:ON ACTION controlp INFIELD fmnb004 name="construct.c.page1.fmnb004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb032
            #add-point:BEFORE FIELD fmnb032 name="construct.b.page1.fmnb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb032
            
            #add-point:AFTER FIELD fmnb032 name="construct.a.page1.fmnb032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb032
            #add-point:ON ACTION controlp INFIELD fmnb032 name="construct.c.page1.fmnb032"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmnb100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb100
            #add-point:ON ACTION controlp INFIELD fmnb100 name="construct.c.page1.fmnb100"
            #幣別
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO fmnb100
            NEXT FIELD fmnb100
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb100
            #add-point:BEFORE FIELD fmnb100 name="construct.b.page1.fmnb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb100
            
            #add-point:AFTER FIELD fmnb100 name="construct.a.page1.fmnb100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb101
            #add-point:BEFORE FIELD fmnb101 name="construct.b.page1.fmnb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb101
            
            #add-point:AFTER FIELD fmnb101 name="construct.a.page1.fmnb101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb101
            #add-point:ON ACTION controlp INFIELD fmnb101 name="construct.c.page1.fmnb101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb102
            #add-point:BEFORE FIELD fmnb102 name="construct.b.page1.fmnb102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb102
            
            #add-point:AFTER FIELD fmnb102 name="construct.a.page1.fmnb102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb102
            #add-point:ON ACTION controlp INFIELD fmnb102 name="construct.c.page1.fmnb102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb103
            #add-point:BEFORE FIELD fmnb103 name="construct.b.page1.fmnb103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb103
            
            #add-point:AFTER FIELD fmnb103 name="construct.a.page1.fmnb103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb103
            #add-point:ON ACTION controlp INFIELD fmnb103 name="construct.c.page1.fmnb103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb113
            #add-point:BEFORE FIELD fmnb113 name="construct.b.page1.fmnb113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb113
            
            #add-point:AFTER FIELD fmnb113 name="construct.a.page1.fmnb113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb113
            #add-point:ON ACTION controlp INFIELD fmnb113 name="construct.c.page1.fmnb113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb114
            #add-point:BEFORE FIELD fmnb114 name="construct.b.page1.fmnb114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb114
            
            #add-point:AFTER FIELD fmnb114 name="construct.a.page1.fmnb114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb114
            #add-point:ON ACTION controlp INFIELD fmnb114 name="construct.c.page1.fmnb114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb115
            #add-point:BEFORE FIELD fmnb115 name="construct.b.page1.fmnb115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb115
            
            #add-point:AFTER FIELD fmnb115 name="construct.a.page1.fmnb115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb115
            #add-point:ON ACTION controlp INFIELD fmnb115 name="construct.c.page1.fmnb115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb116
            #add-point:BEFORE FIELD fmnb116 name="construct.b.page1.fmnb116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb116
            
            #add-point:AFTER FIELD fmnb116 name="construct.a.page1.fmnb116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmnb116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb116
            #add-point:ON ACTION controlp INFIELD fmnb116 name="construct.c.page1.fmnb116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb121
            #add-point:BEFORE FIELD fmnb121 name="construct.b.page2.fmnb121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb121
            
            #add-point:AFTER FIELD fmnb121 name="construct.a.page2.fmnb121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmnb121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb121
            #add-point:ON ACTION controlp INFIELD fmnb121 name="construct.c.page2.fmnb121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb122
            #add-point:BEFORE FIELD fmnb122 name="construct.b.page2.fmnb122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb122
            
            #add-point:AFTER FIELD fmnb122 name="construct.a.page2.fmnb122"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmnb122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb122
            #add-point:ON ACTION controlp INFIELD fmnb122 name="construct.c.page2.fmnb122"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb123
            #add-point:BEFORE FIELD fmnb123 name="construct.b.page2.fmnb123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb123
            
            #add-point:AFTER FIELD fmnb123 name="construct.a.page2.fmnb123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmnb123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb123
            #add-point:ON ACTION controlp INFIELD fmnb123 name="construct.c.page2.fmnb123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb124
            #add-point:BEFORE FIELD fmnb124 name="construct.b.page2.fmnb124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb124
            
            #add-point:AFTER FIELD fmnb124 name="construct.a.page2.fmnb124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmnb124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb124
            #add-point:ON ACTION controlp INFIELD fmnb124 name="construct.c.page2.fmnb124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb125
            #add-point:BEFORE FIELD fmnb125 name="construct.b.page2.fmnb125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb125
            
            #add-point:AFTER FIELD fmnb125 name="construct.a.page2.fmnb125"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmnb125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb125
            #add-point:ON ACTION controlp INFIELD fmnb125 name="construct.c.page2.fmnb125"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb126
            #add-point:BEFORE FIELD fmnb126 name="construct.b.page2.fmnb126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb126
            
            #add-point:AFTER FIELD fmnb126 name="construct.a.page2.fmnb126"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmnb126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb126
            #add-point:ON ACTION controlp INFIELD fmnb126 name="construct.c.page2.fmnb126"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb131
            #add-point:BEFORE FIELD fmnb131 name="construct.b.page3.fmnb131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb131
            
            #add-point:AFTER FIELD fmnb131 name="construct.a.page3.fmnb131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmnb131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb131
            #add-point:ON ACTION controlp INFIELD fmnb131 name="construct.c.page3.fmnb131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb132
            #add-point:BEFORE FIELD fmnb132 name="construct.b.page3.fmnb132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb132
            
            #add-point:AFTER FIELD fmnb132 name="construct.a.page3.fmnb132"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmnb132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb132
            #add-point:ON ACTION controlp INFIELD fmnb132 name="construct.c.page3.fmnb132"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb133
            #add-point:BEFORE FIELD fmnb133 name="construct.b.page3.fmnb133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb133
            
            #add-point:AFTER FIELD fmnb133 name="construct.a.page3.fmnb133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmnb133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb133
            #add-point:ON ACTION controlp INFIELD fmnb133 name="construct.c.page3.fmnb133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb134
            #add-point:BEFORE FIELD fmnb134 name="construct.b.page3.fmnb134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb134
            
            #add-point:AFTER FIELD fmnb134 name="construct.a.page3.fmnb134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmnb134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb134
            #add-point:ON ACTION controlp INFIELD fmnb134 name="construct.c.page3.fmnb134"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb135
            #add-point:BEFORE FIELD fmnb135 name="construct.b.page3.fmnb135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb135
            
            #add-point:AFTER FIELD fmnb135 name="construct.a.page3.fmnb135"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmnb135
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb135
            #add-point:ON ACTION controlp INFIELD fmnb135 name="construct.c.page3.fmnb135"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb136
            #add-point:BEFORE FIELD fmnb136 name="construct.b.page3.fmnb136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb136
            
            #add-point:AFTER FIELD fmnb136 name="construct.a.page3.fmnb136"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmnb136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb136
            #add-point:ON ACTION controlp INFIELD fmnb136 name="construct.c.page3.fmnb136"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb028
            #add-point:BEFORE FIELD fmnb028 name="construct.b.page4.fmnb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb028
            
            #add-point:AFTER FIELD fmnb028 name="construct.a.page4.fmnb028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb028
            #add-point:ON ACTION controlp INFIELD fmnb028 name="construct.c.page4.fmnb028"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb028_desc
            #add-point:ON ACTION controlp INFIELD fmnb028_desc name="construct.c.page4.fmnb028_desc"
            #重評價會計科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "  #glac003(科目類型)
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO fmnb028
            DISPLAY g_qryparam.return1 TO fmnb028_desc
            NEXT FIELD fmnb028_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb028_desc
            #add-point:BEFORE FIELD fmnb028_desc name="construct.b.page4.fmnb028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb028_desc
            
            #add-point:AFTER FIELD fmnb028_desc name="construct.a.page4.fmnb028_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb029
            #add-point:BEFORE FIELD fmnb029 name="construct.b.page4.fmnb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb029
            
            #add-point:AFTER FIELD fmnb029 name="construct.a.page4.fmnb029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb029
            #add-point:ON ACTION controlp INFIELD fmnb029 name="construct.c.page4.fmnb029"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb029_desc
            #add-point:ON ACTION controlp INFIELD fmnb029_desc name="construct.c.page4.fmnb029_desc"
            #對方科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "  #glac003(科目類型)
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO fmnb029
            DISPLAY g_qryparam.return1 TO fmnb029_desc
            NEXT FIELD fmnb029_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb029_desc
            #add-point:BEFORE FIELD fmnb029_desc name="construct.b.page4.fmnb029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb029_desc
            
            #add-point:AFTER FIELD fmnb029_desc name="construct.a.page4.fmnb029_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb031
            #add-point:BEFORE FIELD fmnb031 name="construct.b.page4.fmnb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb031
            
            #add-point:AFTER FIELD fmnb031 name="construct.a.page4.fmnb031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb031
            #add-point:ON ACTION controlp INFIELD fmnb031 name="construct.c.page4.fmnb031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb005
            #add-point:BEFORE FIELD fmnb005 name="construct.b.page4.fmnb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb005
            
            #add-point:AFTER FIELD fmnb005 name="construct.a.page4.fmnb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb005
            #add-point:ON ACTION controlp INFIELD fmnb005 name="construct.c.page4.fmnb005"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb005_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb005_desc
            #add-point:ON ACTION controlp INFIELD fmnb005_desc name="construct.c.page4.fmnb005_desc"
            #交易客商
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()        #160913-00017#2  ADD 
           # CALL q_pmaa001()      #160913-00017#2 mark          #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmnb005
            DISPLAY g_qryparam.return1 TO fmnb005_desc
            NEXT FIELD fmnb005_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb005_desc
            #add-point:BEFORE FIELD fmnb005_desc name="construct.b.page4.fmnb005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb005_desc
            
            #add-point:AFTER FIELD fmnb005_desc name="construct.a.page4.fmnb005_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb006
            #add-point:BEFORE FIELD fmnb006 name="construct.b.page4.fmnb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb006
            
            #add-point:AFTER FIELD fmnb006 name="construct.a.page4.fmnb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb006
            #add-point:ON ACTION controlp INFIELD fmnb006 name="construct.c.page4.fmnb006"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb006_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb006_desc
            #add-point:ON ACTION controlp INFIELD fmnb006_desc name="construct.c.page4.fmnb006_desc"
            #帳款客戶
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmac002_1()
            DISPLAY g_qryparam.return1 TO fmnb006
            DISPLAY g_qryparam.return1 TO fmnb006_desc
            NEXT FIELD fmnb006_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb006_desc
            #add-point:BEFORE FIELD fmnb006_desc name="construct.b.page4.fmnb006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb006_desc
            
            #add-point:AFTER FIELD fmnb006_desc name="construct.a.page4.fmnb006_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb007
            #add-point:BEFORE FIELD fmnb007 name="construct.b.page4.fmnb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb007
            
            #add-point:AFTER FIELD fmnb007 name="construct.a.page4.fmnb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb007
            #add-point:ON ACTION controlp INFIELD fmnb007 name="construct.c.page4.fmnb007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb007_desc
            #add-point:ON ACTION controlp INFIELD fmnb007_desc name="construct.c.page4.fmnb007_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO fmnb007
            DISPLAY g_qryparam.return1 TO fmnb007_desc
            NEXT FIELD fmnb007_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb007_desc
            #add-point:BEFORE FIELD fmnb007_desc name="construct.b.page4.fmnb007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb007_desc
            
            #add-point:AFTER FIELD fmnb007_desc name="construct.a.page4.fmnb007_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb008
            #add-point:BEFORE FIELD fmnb008 name="construct.b.page4.fmnb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb008
            
            #add-point:AFTER FIELD fmnb008 name="construct.a.page4.fmnb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb008
            #add-point:ON ACTION controlp INFIELD fmnb008 name="construct.c.page4.fmnb008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb008_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb008_desc
            #add-point:ON ACTION controlp INFIELD fmnb008_desc name="construct.c.page4.fmnb008_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO fmnb008
            DISPLAY g_qryparam.return1 TO fmnb008_desc
            NEXT FIELD fmnb008_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb008_desc
            #add-point:BEFORE FIELD fmnb008_desc name="construct.b.page4.fmnb008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb008_desc
            
            #add-point:AFTER FIELD fmnb008_desc name="construct.a.page4.fmnb008_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb009
            #add-point:BEFORE FIELD fmnb009 name="construct.b.page4.fmnb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb009
            
            #add-point:AFTER FIELD fmnb009 name="construct.a.page4.fmnb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb009
            #add-point:ON ACTION controlp INFIELD fmnb009 name="construct.c.page4.fmnb009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb009_desc
            #add-point:ON ACTION controlp INFIELD fmnb009_desc name="construct.c.page4.fmnb009_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO fmnb009
            DISPLAY g_qryparam.return1 TO fmnb009_desc
            NEXT FIELD fmnb009_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb009_desc
            #add-point:BEFORE FIELD fmnb009_desc name="construct.b.page4.fmnb009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb009_desc
            
            #add-point:AFTER FIELD fmnb009_desc name="construct.a.page4.fmnb009_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb010
            #add-point:BEFORE FIELD fmnb010 name="construct.b.page4.fmnb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb010
            
            #add-point:AFTER FIELD fmnb010 name="construct.a.page4.fmnb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb010
            #add-point:ON ACTION controlp INFIELD fmnb010 name="construct.c.page4.fmnb010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb010_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb010_desc
            #add-point:ON ACTION controlp INFIELD fmnb010_desc name="construct.c.page4.fmnb010_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO fmnb010
            DISPLAY g_qryparam.return1 TO fmnb010_desc
            NEXT FIELD fmnb010_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb010_desc
            #add-point:BEFORE FIELD fmnb010_desc name="construct.b.page4.fmnb010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb010_desc
            
            #add-point:AFTER FIELD fmnb010_desc name="construct.a.page4.fmnb010_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb011
            #add-point:BEFORE FIELD fmnb011 name="construct.b.page4.fmnb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb011
            
            #add-point:AFTER FIELD fmnb011 name="construct.a.page4.fmnb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb011
            #add-point:ON ACTION controlp INFIELD fmnb011 name="construct.c.page4.fmnb011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb011_desc
            #add-point:ON ACTION controlp INFIELD fmnb011_desc name="construct.c.page4.fmnb011_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO fmnb011
            DISPLAY g_qryparam.return1 TO fmnb011_desc
            NEXT FIELD fmnb011_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb011_desc
            #add-point:BEFORE FIELD fmnb011_desc name="construct.b.page4.fmnb011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb011_desc
            
            #add-point:AFTER FIELD fmnb011_desc name="construct.a.page4.fmnb011_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb012
            #add-point:BEFORE FIELD fmnb012 name="construct.b.page4.fmnb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb012
            
            #add-point:AFTER FIELD fmnb012 name="construct.a.page4.fmnb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb012
            #add-point:ON ACTION controlp INFIELD fmnb012 name="construct.c.page4.fmnb012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb012_desc
            #add-point:ON ACTION controlp INFIELD fmnb012_desc name="construct.c.page4.fmnb012_desc"
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO fmnb012
            DISPLAY g_qryparam.return1 TO fmnb012_desc
            NEXT FIELD fmnb012_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb012_desc
            #add-point:BEFORE FIELD fmnb012_desc name="construct.b.page4.fmnb012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb012_desc
            
            #add-point:AFTER FIELD fmnb012_desc name="construct.a.page4.fmnb012_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb013
            #add-point:BEFORE FIELD fmnb013 name="construct.b.page4.fmnb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb013
            
            #add-point:AFTER FIELD fmnb013 name="construct.a.page4.fmnb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb013
            #add-point:ON ACTION controlp INFIELD fmnb013 name="construct.c.page4.fmnb013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb013_desc
            #add-point:ON ACTION controlp INFIELD fmnb013_desc name="construct.c.page4.fmnb013_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO fmnb013
            DISPLAY g_qryparam.return1 TO fmnb013_desc
            NEXT FIELD fmnb013_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb013_desc
            #add-point:BEFORE FIELD fmnb013_desc name="construct.b.page4.fmnb013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb013_desc
            
            #add-point:AFTER FIELD fmnb013_desc name="construct.a.page4.fmnb013_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb014
            #add-point:BEFORE FIELD fmnb014 name="construct.b.page4.fmnb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb014
            
            #add-point:AFTER FIELD fmnb014 name="construct.a.page4.fmnb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb014
            #add-point:ON ACTION controlp INFIELD fmnb014 name="construct.c.page4.fmnb014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb014_desc
            #add-point:ON ACTION controlp INFIELD fmnb014_desc name="construct.c.page4.fmnb014_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO fmnb014
            DISPLAY g_qryparam.return1 TO fmnb014_desc
            NEXT FIELD fmnb014_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb014_desc
            #add-point:BEFORE FIELD fmnb014_desc name="construct.b.page4.fmnb014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb014_desc
            
            #add-point:AFTER FIELD fmnb014_desc name="construct.a.page4.fmnb014_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb015
            #add-point:BEFORE FIELD fmnb015 name="construct.b.page4.fmnb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb015
            
            #add-point:AFTER FIELD fmnb015 name="construct.a.page4.fmnb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb015
            #add-point:ON ACTION controlp INFIELD fmnb015 name="construct.c.page4.fmnb015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb015_desc
            #add-point:BEFORE FIELD fmnb015_desc name="construct.b.page4.fmnb015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb015_desc
            
            #add-point:AFTER FIELD fmnb015_desc name="construct.a.page4.fmnb015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb015_desc
            #add-point:ON ACTION controlp INFIELD fmnb015_desc name="construct.c.page4.fmnb015_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb016
            #add-point:BEFORE FIELD fmnb016 name="construct.b.page4.fmnb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb016
            
            #add-point:AFTER FIELD fmnb016 name="construct.a.page4.fmnb016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb016
            #add-point:ON ACTION controlp INFIELD fmnb016 name="construct.c.page4.fmnb016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb016_desc
            #add-point:ON ACTION controlp INFIELD fmnb016_desc name="construct.c.page4.fmnb016_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO fmnb016
            DISPLAY g_qryparam.return1 TO fmnb016_desc
            NEXT FIELD fmnb016_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb016_desc
            #add-point:BEFORE FIELD fmnb016_desc name="construct.b.page4.fmnb016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb016_desc
            
            #add-point:AFTER FIELD fmnb016_desc name="construct.a.page4.fmnb016_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb017
            #add-point:BEFORE FIELD fmnb017 name="construct.b.page4.fmnb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb017
            
            #add-point:AFTER FIELD fmnb017 name="construct.a.page4.fmnb017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmnb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb017
            #add-point:ON ACTION controlp INFIELD fmnb017 name="construct.c.page4.fmnb017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmnb017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb017_desc
            #add-point:ON ACTION controlp INFIELD fmnb017_desc name="construct.c.page4.fmnb017_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO fmnb017
            DISPLAY g_qryparam.return1 TO fmnb017_desc
            NEXT FIELD fmnb017_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb017_desc
            #add-point:BEFORE FIELD fmnb017_desc name="construct.b.page4.fmnb017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb017_desc
            
            #add-point:AFTER FIELD fmnb017_desc name="construct.a.page4.fmnb017_desc"
            
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
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "fmna_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fmnb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
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
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   #161104-00046#21 --s add
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#21 --s add
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt570.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION afmt570_filter()
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
      CONSTRUCT g_wc_filter ON fmnasite,fmna001,fmnacomp,fmnadocno,fmnadocdt,fmna006,fmna004,fmna002, 
          fmna003,fmna005
                          FROM s_browse[1].b_fmnasite,s_browse[1].b_fmna001,s_browse[1].b_fmnacomp,s_browse[1].b_fmnadocno, 
                              s_browse[1].b_fmnadocdt,s_browse[1].b_fmna006,s_browse[1].b_fmna004,s_browse[1].b_fmna002, 
                              s_browse[1].b_fmna003,s_browse[1].b_fmna005
 
         BEFORE CONSTRUCT
               DISPLAY afmt570_filter_parser('fmnasite') TO s_browse[1].b_fmnasite
            DISPLAY afmt570_filter_parser('fmna001') TO s_browse[1].b_fmna001
            DISPLAY afmt570_filter_parser('fmnacomp') TO s_browse[1].b_fmnacomp
            DISPLAY afmt570_filter_parser('fmnadocno') TO s_browse[1].b_fmnadocno
            DISPLAY afmt570_filter_parser('fmnadocdt') TO s_browse[1].b_fmnadocdt
            DISPLAY afmt570_filter_parser('fmna006') TO s_browse[1].b_fmna006
            DISPLAY afmt570_filter_parser('fmna004') TO s_browse[1].b_fmna004
            DISPLAY afmt570_filter_parser('fmna002') TO s_browse[1].b_fmna002
            DISPLAY afmt570_filter_parser('fmna003') TO s_browse[1].b_fmna003
            DISPLAY afmt570_filter_parser('fmna005') TO s_browse[1].b_fmna005
      
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
 
      CALL afmt570_filter_show('fmnasite')
   CALL afmt570_filter_show('fmna001')
   CALL afmt570_filter_show('fmnacomp')
   CALL afmt570_filter_show('fmnadocno')
   CALL afmt570_filter_show('fmnadocdt')
   CALL afmt570_filter_show('fmna006')
   CALL afmt570_filter_show('fmna004')
   CALL afmt570_filter_show('fmna002')
   CALL afmt570_filter_show('fmna003')
   CALL afmt570_filter_show('fmna005')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt570.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION afmt570_filter_parser(ps_field)
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
 
{<section id="afmt570.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION afmt570_filter_show(ps_field)
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
   LET ls_condition = afmt570_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmt570.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt570_query()
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
   CALL g_fmnb_d.clear()
   CALL g_fmnb2_d.clear()
   CALL g_fmnb3_d.clear()
   CALL g_fmnb4_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afmt570_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt570_browser_fill("")
      CALL afmt570_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL afmt570_filter_show('fmnasite')
   CALL afmt570_filter_show('fmna001')
   CALL afmt570_filter_show('fmnacomp')
   CALL afmt570_filter_show('fmnadocno')
   CALL afmt570_filter_show('fmnadocdt')
   CALL afmt570_filter_show('fmna006')
   CALL afmt570_filter_show('fmna004')
   CALL afmt570_filter_show('fmna002')
   CALL afmt570_filter_show('fmna003')
   CALL afmt570_filter_show('fmna005')
   CALL afmt570_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afmt570_fetch("F") 
      #顯示單身筆數
      CALL afmt570_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt570.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt570_fetch(p_flag)
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
   
   LET g_fmna_m.fmnadocno = g_browser[g_current_idx].b_fmnadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afmt570_master_referesh USING g_fmna_m.fmnadocno INTO g_fmna_m.fmnasite,g_fmna_m.fmna001, 
       g_fmna_m.fmnacomp,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt,g_fmna_m.fmna006,g_fmna_m.fmna004,g_fmna_m.fmna002, 
       g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus,g_fmna_m.fmnaownid,g_fmna_m.fmnaowndp,g_fmna_m.fmnacrtid, 
       g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid, 
       g_fmna_m.fmnacnfdt,g_fmna_m.fmnapstid,g_fmna_m.fmnapstdt,g_fmna_m.fmnaownid_desc,g_fmna_m.fmnaowndp_desc, 
       g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp_desc,g_fmna_m.fmnamodid_desc,g_fmna_m.fmnacnfid_desc, 
       g_fmna_m.fmnapstid_desc
   
   #遮罩相關處理
   LET g_fmna_m_mask_o.* =  g_fmna_m.*
   CALL afmt570_fmna_t_mask()
   LET g_fmna_m_mask_n.* =  g_fmna_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt570_set_act_visible()   
   CALL afmt570_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fmna_m_t.* = g_fmna_m.*
   LET g_fmna_m_o.* = g_fmna_m.*
   
   LET g_data_owner = g_fmna_m.fmnaownid      
   LET g_data_dept  = g_fmna_m.fmnaowndp
   
   #重新顯示   
   CALL afmt570_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt570.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt570_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fmnb_d.clear()   
   CALL g_fmnb2_d.clear()  
   CALL g_fmnb3_d.clear()  
   CALL g_fmnb4_d.clear()  
 
 
   INITIALIZE g_fmna_m.* TO NULL             #DEFAULT 設定
   
   LET g_fmnadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmna_m.fmnaownid = g_user
      LET g_fmna_m.fmnaowndp = g_dept
      LET g_fmna_m.fmnacrtid = g_user
      LET g_fmna_m.fmnacrtdp = g_dept 
      LET g_fmna_m.fmnacrtdt = cl_get_current()
      LET g_fmna_m.fmnamodid = g_user
      LET g_fmna_m.fmnamoddt = cl_get_current()
      LET g_fmna_m.fmnastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_fmna_m.fmnadocdt = g_today
      LET g_fmna_m.fmna002 = YEAR(g_today)
      LET g_fmna_m.fmna003 = MONTH(g_today)
      
      CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,g_fmna_m.fmnasite,g_fmna_m.fmna001,g_fmna_m.fmnacomp
      CALL s_desc_get_department_desc(g_fmna_m.fmnasite) RETURNING g_fmna_m.fmnasite_desc
      #設定帳別相關預設值
      IF NOT cl_null(g_fmna_m.fmna001) THEN
         CALL s_desc_get_ld_desc(g_fmna_m.fmna001)  RETURNING g_fmna_m.fmna001_desc
         CALL afmt570_set_ld_info(g_fmna_m.fmna001) RETURNING g_fmna_m.fmnacomp
         CALL s_desc_get_department_desc(g_fmna_m.fmnacomp) RETURNING g_fmna_m.fmnacomp_desc
      END IF
      
      DISPLAY BY NAME g_fmna_m.fmnasite,g_fmna_m.fmnasite_desc,g_fmna_m.fmna001,g_fmna_m.fmna001_desc,
                      g_fmna_m.fmnacomp,g_fmna_m.fmnacomp_desc,g_fmna_m.fmnadocdt,g_fmna_m.fmna002,
                      g_fmna_m.fmna003
      
      LET g_fmna_m_t.* = g_fmna_m.*    #設定預設值後
      LET g_fmna_m_o.* = g_fmna_m.*    #舊值備份
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_fmna_m_t.* = g_fmna_m.*
      LET g_fmna_m_o.* = g_fmna_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmna_m.fmnastus 
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
 
 
 
    
      CALL afmt570_input("a")
      
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
         INITIALIZE g_fmna_m.* TO NULL
         INITIALIZE g_fmnb_d TO NULL
         INITIALIZE g_fmnb2_d TO NULL
         INITIALIZE g_fmnb3_d TO NULL
         INITIALIZE g_fmnb4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afmt570_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fmnb_d.clear()
      #CALL g_fmnb2_d.clear()
      #CALL g_fmnb3_d.clear()
      #CALL g_fmnb4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt570_set_act_visible()   
   CALL afmt570_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmnadocno_t = g_fmna_m.fmnadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmnaent = " ||g_enterprise|| " AND",
                      " fmnadocno = '", g_fmna_m.fmnadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt570_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afmt570_cl
   
   CALL afmt570_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt570_master_referesh USING g_fmna_m.fmnadocno INTO g_fmna_m.fmnasite,g_fmna_m.fmna001, 
       g_fmna_m.fmnacomp,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt,g_fmna_m.fmna006,g_fmna_m.fmna004,g_fmna_m.fmna002, 
       g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus,g_fmna_m.fmnaownid,g_fmna_m.fmnaowndp,g_fmna_m.fmnacrtid, 
       g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid, 
       g_fmna_m.fmnacnfdt,g_fmna_m.fmnapstid,g_fmna_m.fmnapstdt,g_fmna_m.fmnaownid_desc,g_fmna_m.fmnaowndp_desc, 
       g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp_desc,g_fmna_m.fmnamodid_desc,g_fmna_m.fmnacnfid_desc, 
       g_fmna_m.fmnapstid_desc
   
   
   #遮罩相關處理
   LET g_fmna_m_mask_o.* =  g_fmna_m.*
   CALL afmt570_fmna_t_mask()
   LET g_fmna_m_mask_n.* =  g_fmna_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmna_m.fmnasite,g_fmna_m.fmnasite_desc,g_fmna_m.fmna001,g_fmna_m.fmna001_desc,g_fmna_m.fmnacomp, 
       g_fmna_m.fmnacomp_desc,g_fmna_m.fmnadocno,g_fmna_m.fmnadocno_desc,g_fmna_m.fmnadocdt,g_fmna_m.fmna006, 
       g_fmna_m.fmna006_desc,g_fmna_m.fmna004,g_fmna_m.fmna002,g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus, 
       g_fmna_m.fmnaownid,g_fmna_m.fmnaownid_desc,g_fmna_m.fmnaowndp,g_fmna_m.fmnaowndp_desc,g_fmna_m.fmnacrtid, 
       g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdp_desc,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid, 
       g_fmna_m.fmnamodid_desc,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid,g_fmna_m.fmnacnfid_desc,g_fmna_m.fmnacnfdt, 
       g_fmna_m.fmnapstid,g_fmna_m.fmnapstid_desc,g_fmna_m.fmnapstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_fmna_m.fmnaownid      
   LET g_data_dept  = g_fmna_m.fmnaowndp
   
   #功能已完成,通報訊息中心
   CALL afmt570_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt570_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fmna_m_t.* = g_fmna_m.*
   LET g_fmna_m_o.* = g_fmna_m.*
   
   IF g_fmna_m.fmnadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_fmnadocno_t = g_fmna_m.fmnadocno
 
   CALL s_transaction_begin()
   
   OPEN afmt570_cl USING g_enterprise,g_fmna_m.fmnadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt570_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt570_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt570_master_referesh USING g_fmna_m.fmnadocno INTO g_fmna_m.fmnasite,g_fmna_m.fmna001, 
       g_fmna_m.fmnacomp,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt,g_fmna_m.fmna006,g_fmna_m.fmna004,g_fmna_m.fmna002, 
       g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus,g_fmna_m.fmnaownid,g_fmna_m.fmnaowndp,g_fmna_m.fmnacrtid, 
       g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid, 
       g_fmna_m.fmnacnfdt,g_fmna_m.fmnapstid,g_fmna_m.fmnapstdt,g_fmna_m.fmnaownid_desc,g_fmna_m.fmnaowndp_desc, 
       g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp_desc,g_fmna_m.fmnamodid_desc,g_fmna_m.fmnacnfid_desc, 
       g_fmna_m.fmnapstid_desc
   
   #檢查是否允許此動作
   IF NOT afmt570_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmna_m_mask_o.* =  g_fmna_m.*
   CALL afmt570_fmna_t_mask()
   LET g_fmna_m_mask_n.* =  g_fmna_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL afmt570_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_fmnadocno_t = g_fmna_m.fmnadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_fmna_m.fmnamodid = g_user 
LET g_fmna_m.fmnamoddt = cl_get_current()
LET g_fmna_m.fmnamodid_desc = cl_get_username(g_fmna_m.fmnamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_fmna_m.fmnastus MATCHES "[DR]" THEN
         LET g_fmna_m.fmnastus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afmt570_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE fmna_t SET (fmnamodid,fmnamoddt) = (g_fmna_m.fmnamodid,g_fmna_m.fmnamoddt)
          WHERE fmnaent = g_enterprise AND fmnadocno = g_fmnadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_fmna_m.* = g_fmna_m_t.*
            CALL afmt570_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_fmna_m.fmnadocno != g_fmna_m_t.fmnadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE fmnb_t SET fmnbdocno = g_fmna_m.fmnadocno
 
          WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmna_m_t.fmnadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmnb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt570_set_act_visible()   
   CALL afmt570_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmnaent = " ||g_enterprise|| " AND",
                      " fmnadocno = '", g_fmna_m.fmnadocno, "' "
 
   #填到對應位置
   CALL afmt570_browser_fill("")
 
   CLOSE afmt570_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt570_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afmt570.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt570_input(p_cmd)
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
   DEFINE  l_glae009             LIKE glae_t.glae009    #自由核算項使用
   #ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #ADD BY XZG20151203 e

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
   DISPLAY BY NAME g_fmna_m.fmnasite,g_fmna_m.fmnasite_desc,g_fmna_m.fmna001,g_fmna_m.fmna001_desc,g_fmna_m.fmnacomp, 
       g_fmna_m.fmnacomp_desc,g_fmna_m.fmnadocno,g_fmna_m.fmnadocno_desc,g_fmna_m.fmnadocdt,g_fmna_m.fmna006, 
       g_fmna_m.fmna006_desc,g_fmna_m.fmna004,g_fmna_m.fmna002,g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus, 
       g_fmna_m.fmnaownid,g_fmna_m.fmnaownid_desc,g_fmna_m.fmnaowndp,g_fmna_m.fmnaowndp_desc,g_fmna_m.fmnacrtid, 
       g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdp_desc,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid, 
       g_fmna_m.fmnamodid_desc,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid,g_fmna_m.fmnacnfid_desc,g_fmna_m.fmnacnfdt, 
       g_fmna_m.fmnapstid,g_fmna_m.fmnapstid_desc,g_fmna_m.fmnapstdt
   
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
   LET g_forupd_sql = "SELECT fmnbseq,fmnb030,fmnb033,fmnb002,fmnb003,fmnb004,fmnb032,fmnb100,fmnb101, 
       fmnb102,fmnb103,fmnb113,fmnb114,fmnb115,fmnb116,fmnbseq,fmnb121,fmnb122,fmnb123,fmnb124,fmnb125, 
       fmnb126,fmnbseq,fmnb131,fmnb132,fmnb133,fmnb134,fmnb135,fmnb136,fmnbseq,fmnb028,fmnb029,fmnb031, 
       fmnb005,fmnb006,fmnb007,fmnb008,fmnb009,fmnb010,fmnb011,fmnb012,fmnb013,fmnb014,fmnb015,fmnb016, 
       fmnb017,fmnb018,fmnb019,fmnb020,fmnb021,fmnb022,fmnb023,fmnb024,fmnb025,fmnb026,fmnb027 FROM  
       fmnb_t WHERE fmnbent=? AND fmnbdocno=? AND fmnbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt570_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afmt570_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt570_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fmna_m.fmnastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afmt570.input.head" >}
      #單頭段
      INPUT BY NAME g_fmna_m.fmnastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afmt570_cl USING g_enterprise,g_fmna_m.fmnadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt570_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt570_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afmt570_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL afmt570_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnastus
            #add-point:BEFORE FIELD fmnastus name="input.b.fmnastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnastus
            
            #add-point:AFTER FIELD fmnastus name="input.a.fmnastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnastus
            #add-point:ON CHANGE fmnastus name="input.g.fmnastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmnastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnastus
            #add-point:ON ACTION controlp INFIELD fmnastus name="input.c.fmnastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_fmna_m.fmnadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #新增前才取單號
               CALL s_aooi200_fin_gen_docno(g_fmna_m.fmna001,'','',g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt,g_prog)
                    RETURNING g_sub_success,g_fmna_m.fmnadocno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_fmna_m.fmnadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD fmnadocno
               END IF
               DISPLAY BY NAME g_fmna_m.fmnadocno
               #end add-point
               
               INSERT INTO fmna_t (fmnaent,fmnasite,fmna001,fmnacomp,fmnadocno,fmnadocdt,fmna006,fmna004, 
                   fmna002,fmna003,fmna005,fmnastus,fmnaownid,fmnaowndp,fmnacrtid,fmnacrtdp,fmnacrtdt, 
                   fmnamodid,fmnamoddt,fmnacnfid,fmnacnfdt,fmnapstid,fmnapstdt)
               VALUES (g_enterprise,g_fmna_m.fmnasite,g_fmna_m.fmna001,g_fmna_m.fmnacomp,g_fmna_m.fmnadocno, 
                   g_fmna_m.fmnadocdt,g_fmna_m.fmna006,g_fmna_m.fmna004,g_fmna_m.fmna002,g_fmna_m.fmna003, 
                   g_fmna_m.fmna005,g_fmna_m.fmnastus,g_fmna_m.fmnaownid,g_fmna_m.fmnaowndp,g_fmna_m.fmnacrtid, 
                   g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid, 
                   g_fmna_m.fmnacnfdt,g_fmna_m.fmnapstid,g_fmna_m.fmnapstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_fmna_m:",SQLERRMESSAGE 
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
                  CALL afmt570_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afmt570_b_fill()
                  CALL afmt570_b_fill2('0')
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
               CALL afmt570_fmna_t_mask_restore('restore_mask_o')
               
               UPDATE fmna_t SET (fmnasite,fmna001,fmnacomp,fmnadocno,fmnadocdt,fmna006,fmna004,fmna002, 
                   fmna003,fmna005,fmnastus,fmnaownid,fmnaowndp,fmnacrtid,fmnacrtdp,fmnacrtdt,fmnamodid, 
                   fmnamoddt,fmnacnfid,fmnacnfdt,fmnapstid,fmnapstdt) = (g_fmna_m.fmnasite,g_fmna_m.fmna001, 
                   g_fmna_m.fmnacomp,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt,g_fmna_m.fmna006,g_fmna_m.fmna004, 
                   g_fmna_m.fmna002,g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus,g_fmna_m.fmnaownid, 
                   g_fmna_m.fmnaowndp,g_fmna_m.fmnacrtid,g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid, 
                   g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid,g_fmna_m.fmnacnfdt,g_fmna_m.fmnapstid,g_fmna_m.fmnapstdt) 
 
                WHERE fmnaent = g_enterprise AND fmnadocno = g_fmnadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fmna_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afmt570_fmna_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_fmna_m_t)
               LET g_log2 = util.JSON.stringify(g_fmna_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_fmnadocno_t = g_fmna_m.fmnadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afmt570.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fmnb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #僅開放"其他訊息"頁籤修改
            NEXT FIELD fmnb028_desc
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmnb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt570_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','3','4',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fmnb_d.getLength()
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
            OPEN afmt570_cl USING g_enterprise,g_fmna_m.fmnadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt570_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt570_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmnb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmnb_d[l_ac].fmnbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fmnb_d_t.* = g_fmnb_d[l_ac].*  #BACKUP
               LET g_fmnb_d_o.* = g_fmnb_d[l_ac].*  #BACKUP
               CALL afmt570_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afmt570_set_no_entry_b(l_cmd)
               IF NOT afmt570_lock_b("fmnb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt570_bcl INTO g_fmnb_d[l_ac].fmnbseq,g_fmnb_d[l_ac].fmnb030,g_fmnb_d[l_ac].fmnb033, 
                      g_fmnb_d[l_ac].fmnb002,g_fmnb_d[l_ac].fmnb003,g_fmnb_d[l_ac].fmnb004,g_fmnb_d[l_ac].fmnb032, 
                      g_fmnb_d[l_ac].fmnb100,g_fmnb_d[l_ac].fmnb101,g_fmnb_d[l_ac].fmnb102,g_fmnb_d[l_ac].fmnb103, 
                      g_fmnb_d[l_ac].fmnb113,g_fmnb_d[l_ac].fmnb114,g_fmnb_d[l_ac].fmnb115,g_fmnb_d[l_ac].fmnb116, 
                      g_fmnb2_d[l_ac].fmnbseq,g_fmnb2_d[l_ac].fmnb121,g_fmnb2_d[l_ac].fmnb122,g_fmnb2_d[l_ac].fmnb123, 
                      g_fmnb2_d[l_ac].fmnb124,g_fmnb2_d[l_ac].fmnb125,g_fmnb2_d[l_ac].fmnb126,g_fmnb3_d[l_ac].fmnbseq, 
                      g_fmnb3_d[l_ac].fmnb131,g_fmnb3_d[l_ac].fmnb132,g_fmnb3_d[l_ac].fmnb133,g_fmnb3_d[l_ac].fmnb134, 
                      g_fmnb3_d[l_ac].fmnb135,g_fmnb3_d[l_ac].fmnb136,g_fmnb4_d[l_ac].fmnbseq,g_fmnb4_d[l_ac].fmnb028, 
                      g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb031,g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb006, 
                      g_fmnb4_d[l_ac].fmnb007,g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb009,g_fmnb4_d[l_ac].fmnb010, 
                      g_fmnb4_d[l_ac].fmnb011,g_fmnb4_d[l_ac].fmnb012,g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014, 
                      g_fmnb4_d[l_ac].fmnb015,g_fmnb4_d[l_ac].fmnb016,g_fmnb4_d[l_ac].fmnb017,g_fmnb4_d[l_ac].fmnb018, 
                      g_fmnb4_d[l_ac].fmnb019,g_fmnb4_d[l_ac].fmnb020,g_fmnb4_d[l_ac].fmnb021,g_fmnb4_d[l_ac].fmnb022, 
                      g_fmnb4_d[l_ac].fmnb023,g_fmnb4_d[l_ac].fmnb024,g_fmnb4_d[l_ac].fmnb025,g_fmnb4_d[l_ac].fmnb026, 
                      g_fmnb4_d[l_ac].fmnb027
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmnb_d_t.fmnbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmnb_d_mask_o[l_ac].* =  g_fmnb_d[l_ac].*
                  CALL afmt570_fmnb_t_mask()
                  LET g_fmnb_d_mask_n[l_ac].* =  g_fmnb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt570_show()
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
            INITIALIZE g_fmnb_d[l_ac].* TO NULL 
            INITIALIZE g_fmnb_d_t.* TO NULL 
            INITIALIZE g_fmnb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_fmnb_d[l_ac].fmnb101 = "0"
      LET g_fmnb_d[l_ac].fmnb102 = "0"
      LET g_fmnb_d[l_ac].fmnb103 = "0"
      LET g_fmnb_d[l_ac].fmnb113 = "0"
      LET g_fmnb_d[l_ac].fmnb114 = "0"
      LET g_fmnb_d[l_ac].fmnb115 = "0"
      LET g_fmnb_d[l_ac].fmnb116 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_fmnb2_d[l_ac].fmnb121 = "0"
            LET g_fmnb2_d[l_ac].fmnb122 = "0"
            LET g_fmnb2_d[l_ac].fmnb123 = "0"
            LET g_fmnb2_d[l_ac].fmnb124 = "0"
            LET g_fmnb2_d[l_ac].fmnb125 = "0"
            LET g_fmnb2_d[l_ac].fmnb126 = "0"
            
            LET g_fmnb3_d[l_ac].fmnb131 = "0"
            LET g_fmnb3_d[l_ac].fmnb132 = "0"
            LET g_fmnb3_d[l_ac].fmnb133 = "0"
            LET g_fmnb3_d[l_ac].fmnb134 = "0"
            LET g_fmnb3_d[l_ac].fmnb135 = "0"
            LET g_fmnb3_d[l_ac].fmnb136 = "0"
            #end add-point
            LET g_fmnb_d_t.* = g_fmnb_d[l_ac].*     #新輸入資料
            LET g_fmnb_d_o.* = g_fmnb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt570_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt570_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmnb_d[li_reproduce_target].* = g_fmnb_d[li_reproduce].*
               LET g_fmnb2_d[li_reproduce_target].* = g_fmnb2_d[li_reproduce].*
               LET g_fmnb3_d[li_reproduce_target].* = g_fmnb3_d[li_reproduce].*
               LET g_fmnb4_d[li_reproduce_target].* = g_fmnb4_d[li_reproduce].*
 
               LET g_fmnb_d[li_reproduce_target].fmnbseq = NULL
 
            END IF
            
 
 
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            #項次
            SELECT MAX(fmnbseq)+1 INTO g_fmnb_d[l_ac].fmnbseq FROM fmnb_t
             WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmna_m.fmnadocno
            IF cl_null(g_fmnb_d[l_ac].fmnbseq) OR g_fmnb_d[l_ac].fmnbseq = 0 THEN
               LET g_fmnb_d[l_ac].fmnbseq = 1
            END IF
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
            SELECT COUNT(1) INTO l_count FROM fmnb_t 
             WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmna_m.fmnadocno
 
               AND fmnbseq = g_fmnb_d[l_ac].fmnbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmna_m.fmnadocno
               LET gs_keys[2] = g_fmnb_d[g_detail_idx].fmnbseq
               CALL afmt570_insert_b('fmnb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_fmnb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt570_b_fill()
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
               LET gs_keys[01] = g_fmna_m.fmnadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_fmnb_d_t.fmnbseq
 
            
               #刪除同層單身
               IF NOT afmt570_delete_b('fmnb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt570_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt570_key_delete_b(gs_keys,'fmnb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt570_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt570_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_fmnb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmnb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnbseq
            #add-point:BEFORE FIELD fmnbseq name="input.b.page1.fmnbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnbseq
            
            #add-point:AFTER FIELD fmnbseq name="input.a.page1.fmnbseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmna_m.fmnadocno IS NOT NULL AND g_fmnb_d[g_detail_idx].fmnbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmna_m.fmnadocno != g_fmnadocno_t OR g_fmnb_d[g_detail_idx].fmnbseq != g_fmnb_d_t.fmnbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmnb_t WHERE "||"fmnbent = '" ||g_enterprise|| "' AND "||"fmnbdocno = '"||g_fmna_m.fmnadocno ||"' AND "|| "fmnbseq = '"||g_fmnb_d[g_detail_idx].fmnbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnbseq
            #add-point:ON CHANGE fmnbseq name="input.g.page1.fmnbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb030
            #add-point:BEFORE FIELD fmnb030 name="input.b.page1.fmnb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb030
            
            #add-point:AFTER FIELD fmnb030 name="input.a.page1.fmnb030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb030
            #add-point:ON CHANGE fmnb030 name="input.g.page1.fmnb030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb033
            #add-point:BEFORE FIELD fmnb033 name="input.b.page1.fmnb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb033
            
            #add-point:AFTER FIELD fmnb033 name="input.a.page1.fmnb033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb033
            #add-point:ON CHANGE fmnb033 name="input.g.page1.fmnb033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb002
            #add-point:BEFORE FIELD fmnb002 name="input.b.page1.fmnb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb002
            
            #add-point:AFTER FIELD fmnb002 name="input.a.page1.fmnb002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb002
            #add-point:ON CHANGE fmnb002 name="input.g.page1.fmnb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb003
            #add-point:BEFORE FIELD fmnb003 name="input.b.page1.fmnb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb003
            
            #add-point:AFTER FIELD fmnb003 name="input.a.page1.fmnb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb003
            #add-point:ON CHANGE fmnb003 name="input.g.page1.fmnb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb004
            #add-point:BEFORE FIELD fmnb004 name="input.b.page1.fmnb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb004
            
            #add-point:AFTER FIELD fmnb004 name="input.a.page1.fmnb004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb004
            #add-point:ON CHANGE fmnb004 name="input.g.page1.fmnb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb032
            #add-point:BEFORE FIELD fmnb032 name="input.b.page1.fmnb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb032
            
            #add-point:AFTER FIELD fmnb032 name="input.a.page1.fmnb032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb032
            #add-point:ON CHANGE fmnb032 name="input.g.page1.fmnb032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb100
            #add-point:BEFORE FIELD fmnb100 name="input.b.page1.fmnb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb100
            
            #add-point:AFTER FIELD fmnb100 name="input.a.page1.fmnb100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb100
            #add-point:ON CHANGE fmnb100 name="input.g.page1.fmnb100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb101
            #add-point:BEFORE FIELD fmnb101 name="input.b.page1.fmnb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb101
            
            #add-point:AFTER FIELD fmnb101 name="input.a.page1.fmnb101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb101
            #add-point:ON CHANGE fmnb101 name="input.g.page1.fmnb101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb102
            #add-point:BEFORE FIELD fmnb102 name="input.b.page1.fmnb102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb102
            
            #add-point:AFTER FIELD fmnb102 name="input.a.page1.fmnb102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb102
            #add-point:ON CHANGE fmnb102 name="input.g.page1.fmnb102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb103
            #add-point:BEFORE FIELD fmnb103 name="input.b.page1.fmnb103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb103
            
            #add-point:AFTER FIELD fmnb103 name="input.a.page1.fmnb103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb103
            #add-point:ON CHANGE fmnb103 name="input.g.page1.fmnb103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb113
            #add-point:BEFORE FIELD fmnb113 name="input.b.page1.fmnb113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb113
            
            #add-point:AFTER FIELD fmnb113 name="input.a.page1.fmnb113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb113
            #add-point:ON CHANGE fmnb113 name="input.g.page1.fmnb113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb114
            #add-point:BEFORE FIELD fmnb114 name="input.b.page1.fmnb114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb114
            
            #add-point:AFTER FIELD fmnb114 name="input.a.page1.fmnb114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb114
            #add-point:ON CHANGE fmnb114 name="input.g.page1.fmnb114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb115
            #add-point:BEFORE FIELD fmnb115 name="input.b.page1.fmnb115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb115
            
            #add-point:AFTER FIELD fmnb115 name="input.a.page1.fmnb115"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb115
            #add-point:ON CHANGE fmnb115 name="input.g.page1.fmnb115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb116
            #add-point:BEFORE FIELD fmnb116 name="input.b.page1.fmnb116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb116
            
            #add-point:AFTER FIELD fmnb116 name="input.a.page1.fmnb116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb116
            #add-point:ON CHANGE fmnb116 name="input.g.page1.fmnb116"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fmnbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnbseq
            #add-point:ON ACTION controlp INFIELD fmnbseq name="input.c.page1.fmnbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb030
            #add-point:ON ACTION controlp INFIELD fmnb030 name="input.c.page1.fmnb030"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb033
            #add-point:ON ACTION controlp INFIELD fmnb033 name="input.c.page1.fmnb033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb002
            #add-point:ON ACTION controlp INFIELD fmnb002 name="input.c.page1.fmnb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb003
            #add-point:ON ACTION controlp INFIELD fmnb003 name="input.c.page1.fmnb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb004
            #add-point:ON ACTION controlp INFIELD fmnb004 name="input.c.page1.fmnb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb032
            #add-point:ON ACTION controlp INFIELD fmnb032 name="input.c.page1.fmnb032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb100
            #add-point:ON ACTION controlp INFIELD fmnb100 name="input.c.page1.fmnb100"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb101
            #add-point:ON ACTION controlp INFIELD fmnb101 name="input.c.page1.fmnb101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb102
            #add-point:ON ACTION controlp INFIELD fmnb102 name="input.c.page1.fmnb102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb103
            #add-point:ON ACTION controlp INFIELD fmnb103 name="input.c.page1.fmnb103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb113
            #add-point:ON ACTION controlp INFIELD fmnb113 name="input.c.page1.fmnb113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb114
            #add-point:ON ACTION controlp INFIELD fmnb114 name="input.c.page1.fmnb114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb115
            #add-point:ON ACTION controlp INFIELD fmnb115 name="input.c.page1.fmnb115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmnb116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb116
            #add-point:ON ACTION controlp INFIELD fmnb116 name="input.c.page1.fmnb116"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmnb_d[l_ac].* = g_fmnb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt570_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fmnb_d[l_ac].fmnbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fmnb_d[l_ac].* = g_fmnb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afmt570_fmnb_t_mask_restore('restore_mask_o')
      
               UPDATE fmnb_t SET (fmnbdocno,fmnbseq,fmnb030,fmnb033,fmnb002,fmnb003,fmnb004,fmnb032, 
                   fmnb100,fmnb101,fmnb102,fmnb103,fmnb113,fmnb114,fmnb115,fmnb116,fmnb121,fmnb122,fmnb123, 
                   fmnb124,fmnb125,fmnb126,fmnb131,fmnb132,fmnb133,fmnb134,fmnb135,fmnb136,fmnb028,fmnb029, 
                   fmnb031,fmnb005,fmnb006,fmnb007,fmnb008,fmnb009,fmnb010,fmnb011,fmnb012,fmnb013,fmnb014, 
                   fmnb015,fmnb016,fmnb017,fmnb018,fmnb019,fmnb020,fmnb021,fmnb022,fmnb023,fmnb024,fmnb025, 
                   fmnb026,fmnb027) = (g_fmna_m.fmnadocno,g_fmnb_d[l_ac].fmnbseq,g_fmnb_d[l_ac].fmnb030, 
                   g_fmnb_d[l_ac].fmnb033,g_fmnb_d[l_ac].fmnb002,g_fmnb_d[l_ac].fmnb003,g_fmnb_d[l_ac].fmnb004, 
                   g_fmnb_d[l_ac].fmnb032,g_fmnb_d[l_ac].fmnb100,g_fmnb_d[l_ac].fmnb101,g_fmnb_d[l_ac].fmnb102, 
                   g_fmnb_d[l_ac].fmnb103,g_fmnb_d[l_ac].fmnb113,g_fmnb_d[l_ac].fmnb114,g_fmnb_d[l_ac].fmnb115, 
                   g_fmnb_d[l_ac].fmnb116,g_fmnb2_d[l_ac].fmnb121,g_fmnb2_d[l_ac].fmnb122,g_fmnb2_d[l_ac].fmnb123, 
                   g_fmnb2_d[l_ac].fmnb124,g_fmnb2_d[l_ac].fmnb125,g_fmnb2_d[l_ac].fmnb126,g_fmnb3_d[l_ac].fmnb131, 
                   g_fmnb3_d[l_ac].fmnb132,g_fmnb3_d[l_ac].fmnb133,g_fmnb3_d[l_ac].fmnb134,g_fmnb3_d[l_ac].fmnb135, 
                   g_fmnb3_d[l_ac].fmnb136,g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb031, 
                   g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb006,g_fmnb4_d[l_ac].fmnb007,g_fmnb4_d[l_ac].fmnb008, 
                   g_fmnb4_d[l_ac].fmnb009,g_fmnb4_d[l_ac].fmnb010,g_fmnb4_d[l_ac].fmnb011,g_fmnb4_d[l_ac].fmnb012, 
                   g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014,g_fmnb4_d[l_ac].fmnb015,g_fmnb4_d[l_ac].fmnb016, 
                   g_fmnb4_d[l_ac].fmnb017,g_fmnb4_d[l_ac].fmnb018,g_fmnb4_d[l_ac].fmnb019,g_fmnb4_d[l_ac].fmnb020, 
                   g_fmnb4_d[l_ac].fmnb021,g_fmnb4_d[l_ac].fmnb022,g_fmnb4_d[l_ac].fmnb023,g_fmnb4_d[l_ac].fmnb024, 
                   g_fmnb4_d[l_ac].fmnb025,g_fmnb4_d[l_ac].fmnb026,g_fmnb4_d[l_ac].fmnb027)
                WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmna_m.fmnadocno 
 
                  AND fmnbseq = g_fmnb_d_t.fmnbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmnb_d[l_ac].* = g_fmnb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmnb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmnb_d[l_ac].* = g_fmnb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmna_m.fmnadocno
               LET gs_keys_bak[1] = g_fmnadocno_t
               LET gs_keys[2] = g_fmnb_d[g_detail_idx].fmnbseq
               LET gs_keys_bak[2] = g_fmnb_d_t.fmnbseq
               CALL afmt570_update_b('fmnb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afmt570_fmnb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fmnb_d[g_detail_idx].fmnbseq = g_fmnb_d_t.fmnbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_fmna_m.fmnadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fmnb_d_t.fmnbseq
 
                  CALL afmt570_key_update_b(gs_keys,'fmnb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmna_m),util.JSON.stringify(g_fmnb_d_t)
               LET g_log2 = util.JSON.stringify(g_fmna_m),util.JSON.stringify(g_fmnb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afmt570_unlock_b("fmnb_t","'1'")
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
               LET g_fmnb_d[li_reproduce_target].* = g_fmnb_d[li_reproduce].*
               LET g_fmnb2_d[li_reproduce_target].* = g_fmnb2_d[li_reproduce].*
               LET g_fmnb3_d[li_reproduce_target].* = g_fmnb3_d[li_reproduce].*
               LET g_fmnb4_d[li_reproduce_target].* = g_fmnb4_d[li_reproduce].*
 
               LET g_fmnb_d[li_reproduce_target].fmnbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmnb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmnb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_fmnb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            #僅開放"其他訊息"頁籤修改
            NEXT FIELD fmnb028_desc
            #end add-point
            
            CALL afmt570_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmnb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmnb2_d[l_ac].* TO NULL 
            INITIALIZE g_fmnb2_d_t.* TO NULL 
            INITIALIZE g_fmnb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_fmnb2_d[l_ac].fmnb121 = "0"
      LET g_fmnb2_d[l_ac].fmnb122 = "0"
      LET g_fmnb2_d[l_ac].fmnb123 = "0"
      LET g_fmnb2_d[l_ac].fmnb124 = "0"
      LET g_fmnb2_d[l_ac].fmnb125 = "0"
      LET g_fmnb2_d[l_ac].fmnb126 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_fmnb2_d_t.* = g_fmnb2_d[l_ac].*     #新輸入資料
            LET g_fmnb2_d_o.* = g_fmnb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt570_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt570_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmnb_d[li_reproduce_target].* = g_fmnb_d[li_reproduce].*
               LET g_fmnb2_d[li_reproduce_target].* = g_fmnb2_d[li_reproduce].*
               LET g_fmnb3_d[li_reproduce_target].* = g_fmnb3_d[li_reproduce].*
               LET g_fmnb4_d[li_reproduce_target].* = g_fmnb4_d[li_reproduce].*
 
               LET g_fmnb2_d[li_reproduce_target].fmnbseq = NULL
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
            OPEN afmt570_cl USING g_enterprise,g_fmna_m.fmnadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt570_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt570_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmnb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmnb2_d[l_ac].fmnbseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmnb2_d_t.* = g_fmnb2_d[l_ac].*  #BACKUP
               LET g_fmnb2_d_o.* = g_fmnb2_d[l_ac].*  #BACKUP
               CALL afmt570_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL afmt570_set_no_entry_b(l_cmd)
               IF NOT afmt570_lock_b("fmnb_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt570_bcl INTO g_fmnb_d[l_ac].fmnbseq,g_fmnb_d[l_ac].fmnb030,g_fmnb_d[l_ac].fmnb033, 
                      g_fmnb_d[l_ac].fmnb002,g_fmnb_d[l_ac].fmnb003,g_fmnb_d[l_ac].fmnb004,g_fmnb_d[l_ac].fmnb032, 
                      g_fmnb_d[l_ac].fmnb100,g_fmnb_d[l_ac].fmnb101,g_fmnb_d[l_ac].fmnb102,g_fmnb_d[l_ac].fmnb103, 
                      g_fmnb_d[l_ac].fmnb113,g_fmnb_d[l_ac].fmnb114,g_fmnb_d[l_ac].fmnb115,g_fmnb_d[l_ac].fmnb116, 
                      g_fmnb2_d[l_ac].fmnbseq,g_fmnb2_d[l_ac].fmnb121,g_fmnb2_d[l_ac].fmnb122,g_fmnb2_d[l_ac].fmnb123, 
                      g_fmnb2_d[l_ac].fmnb124,g_fmnb2_d[l_ac].fmnb125,g_fmnb2_d[l_ac].fmnb126,g_fmnb3_d[l_ac].fmnbseq, 
                      g_fmnb3_d[l_ac].fmnb131,g_fmnb3_d[l_ac].fmnb132,g_fmnb3_d[l_ac].fmnb133,g_fmnb3_d[l_ac].fmnb134, 
                      g_fmnb3_d[l_ac].fmnb135,g_fmnb3_d[l_ac].fmnb136,g_fmnb4_d[l_ac].fmnbseq,g_fmnb4_d[l_ac].fmnb028, 
                      g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb031,g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb006, 
                      g_fmnb4_d[l_ac].fmnb007,g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb009,g_fmnb4_d[l_ac].fmnb010, 
                      g_fmnb4_d[l_ac].fmnb011,g_fmnb4_d[l_ac].fmnb012,g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014, 
                      g_fmnb4_d[l_ac].fmnb015,g_fmnb4_d[l_ac].fmnb016,g_fmnb4_d[l_ac].fmnb017,g_fmnb4_d[l_ac].fmnb018, 
                      g_fmnb4_d[l_ac].fmnb019,g_fmnb4_d[l_ac].fmnb020,g_fmnb4_d[l_ac].fmnb021,g_fmnb4_d[l_ac].fmnb022, 
                      g_fmnb4_d[l_ac].fmnb023,g_fmnb4_d[l_ac].fmnb024,g_fmnb4_d[l_ac].fmnb025,g_fmnb4_d[l_ac].fmnb026, 
                      g_fmnb4_d[l_ac].fmnb027
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmnb2_d_mask_o[l_ac].* =  g_fmnb2_d[l_ac].*
                  CALL afmt570_fmnb_t_mask()
                  LET g_fmnb2_d_mask_n[l_ac].* =  g_fmnb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt570_show()
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
               LET gs_keys[01] = g_fmna_m.fmnadocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmnb2_d_t.fmnbseq
            
               #刪除同層單身
               IF NOT afmt570_delete_b('fmnb_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt570_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt570_key_delete_b(gs_keys,'fmnb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt570_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt570_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_fmnb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmnb2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM fmnb_t 
             WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmna_m.fmnadocno
               AND fmnbseq = g_fmnb2_d[l_ac].fmnbseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmna_m.fmnadocno
               LET gs_keys[2] = g_fmnb2_d[g_detail_idx].fmnbseq
               CALL afmt570_insert_b('fmnb_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmnb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt570_b_fill()
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
               LET g_fmnb2_d[l_ac].* = g_fmnb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt570_bcl
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
               LET g_fmnb2_d[l_ac].* = g_fmnb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL afmt570_fmnb_t_mask_restore('restore_mask_o')
                              
               UPDATE fmnb_t SET (fmnbdocno,fmnbseq,fmnb030,fmnb033,fmnb002,fmnb003,fmnb004,fmnb032, 
                   fmnb100,fmnb101,fmnb102,fmnb103,fmnb113,fmnb114,fmnb115,fmnb116,fmnb121,fmnb122,fmnb123, 
                   fmnb124,fmnb125,fmnb126,fmnb131,fmnb132,fmnb133,fmnb134,fmnb135,fmnb136,fmnb028,fmnb029, 
                   fmnb031,fmnb005,fmnb006,fmnb007,fmnb008,fmnb009,fmnb010,fmnb011,fmnb012,fmnb013,fmnb014, 
                   fmnb015,fmnb016,fmnb017,fmnb018,fmnb019,fmnb020,fmnb021,fmnb022,fmnb023,fmnb024,fmnb025, 
                   fmnb026,fmnb027) = (g_fmna_m.fmnadocno,g_fmnb_d[l_ac].fmnbseq,g_fmnb_d[l_ac].fmnb030, 
                   g_fmnb_d[l_ac].fmnb033,g_fmnb_d[l_ac].fmnb002,g_fmnb_d[l_ac].fmnb003,g_fmnb_d[l_ac].fmnb004, 
                   g_fmnb_d[l_ac].fmnb032,g_fmnb_d[l_ac].fmnb100,g_fmnb_d[l_ac].fmnb101,g_fmnb_d[l_ac].fmnb102, 
                   g_fmnb_d[l_ac].fmnb103,g_fmnb_d[l_ac].fmnb113,g_fmnb_d[l_ac].fmnb114,g_fmnb_d[l_ac].fmnb115, 
                   g_fmnb_d[l_ac].fmnb116,g_fmnb2_d[l_ac].fmnb121,g_fmnb2_d[l_ac].fmnb122,g_fmnb2_d[l_ac].fmnb123, 
                   g_fmnb2_d[l_ac].fmnb124,g_fmnb2_d[l_ac].fmnb125,g_fmnb2_d[l_ac].fmnb126,g_fmnb3_d[l_ac].fmnb131, 
                   g_fmnb3_d[l_ac].fmnb132,g_fmnb3_d[l_ac].fmnb133,g_fmnb3_d[l_ac].fmnb134,g_fmnb3_d[l_ac].fmnb135, 
                   g_fmnb3_d[l_ac].fmnb136,g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb031, 
                   g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb006,g_fmnb4_d[l_ac].fmnb007,g_fmnb4_d[l_ac].fmnb008, 
                   g_fmnb4_d[l_ac].fmnb009,g_fmnb4_d[l_ac].fmnb010,g_fmnb4_d[l_ac].fmnb011,g_fmnb4_d[l_ac].fmnb012, 
                   g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014,g_fmnb4_d[l_ac].fmnb015,g_fmnb4_d[l_ac].fmnb016, 
                   g_fmnb4_d[l_ac].fmnb017,g_fmnb4_d[l_ac].fmnb018,g_fmnb4_d[l_ac].fmnb019,g_fmnb4_d[l_ac].fmnb020, 
                   g_fmnb4_d[l_ac].fmnb021,g_fmnb4_d[l_ac].fmnb022,g_fmnb4_d[l_ac].fmnb023,g_fmnb4_d[l_ac].fmnb024, 
                   g_fmnb4_d[l_ac].fmnb025,g_fmnb4_d[l_ac].fmnb026,g_fmnb4_d[l_ac].fmnb027) #自訂欄位頁簽 
 
                WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmna_m.fmnadocno
                  AND fmnbseq = g_fmnb2_d_t.fmnbseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmnb2_d[l_ac].* = g_fmnb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmnb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmnb2_d[l_ac].* = g_fmnb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmna_m.fmnadocno
               LET gs_keys_bak[1] = g_fmnadocno_t
               LET gs_keys[2] = g_fmnb2_d[g_detail_idx].fmnbseq
               LET gs_keys_bak[2] = g_fmnb2_d_t.fmnbseq
               CALL afmt570_update_b('fmnb_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt570_fmnb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmnb2_d[g_detail_idx].fmnbseq = g_fmnb2_d_t.fmnbseq 
                  ) THEN
                  LET gs_keys[01] = g_fmna_m.fmnadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmnb2_d_t.fmnbseq
                  CALL afmt570_key_update_b(gs_keys,'fmnb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmna_m),util.JSON.stringify(g_fmnb2_d_t)
               LET g_log2 = util.JSON.stringify(g_fmna_m),util.JSON.stringify(g_fmnb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb121
            #add-point:BEFORE FIELD fmnb121 name="input.b.page2.fmnb121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb121
            
            #add-point:AFTER FIELD fmnb121 name="input.a.page2.fmnb121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb121
            #add-point:ON CHANGE fmnb121 name="input.g.page2.fmnb121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb122
            #add-point:BEFORE FIELD fmnb122 name="input.b.page2.fmnb122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb122
            
            #add-point:AFTER FIELD fmnb122 name="input.a.page2.fmnb122"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb122
            #add-point:ON CHANGE fmnb122 name="input.g.page2.fmnb122"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb123
            #add-point:BEFORE FIELD fmnb123 name="input.b.page2.fmnb123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb123
            
            #add-point:AFTER FIELD fmnb123 name="input.a.page2.fmnb123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb123
            #add-point:ON CHANGE fmnb123 name="input.g.page2.fmnb123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb124
            #add-point:BEFORE FIELD fmnb124 name="input.b.page2.fmnb124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb124
            
            #add-point:AFTER FIELD fmnb124 name="input.a.page2.fmnb124"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb124
            #add-point:ON CHANGE fmnb124 name="input.g.page2.fmnb124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb125
            #add-point:BEFORE FIELD fmnb125 name="input.b.page2.fmnb125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb125
            
            #add-point:AFTER FIELD fmnb125 name="input.a.page2.fmnb125"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb125
            #add-point:ON CHANGE fmnb125 name="input.g.page2.fmnb125"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb126
            #add-point:BEFORE FIELD fmnb126 name="input.b.page2.fmnb126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb126
            
            #add-point:AFTER FIELD fmnb126 name="input.a.page2.fmnb126"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb126
            #add-point:ON CHANGE fmnb126 name="input.g.page2.fmnb126"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.fmnb121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb121
            #add-point:ON ACTION controlp INFIELD fmnb121 name="input.c.page2.fmnb121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmnb122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb122
            #add-point:ON ACTION controlp INFIELD fmnb122 name="input.c.page2.fmnb122"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmnb123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb123
            #add-point:ON ACTION controlp INFIELD fmnb123 name="input.c.page2.fmnb123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmnb124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb124
            #add-point:ON ACTION controlp INFIELD fmnb124 name="input.c.page2.fmnb124"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmnb125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb125
            #add-point:ON ACTION controlp INFIELD fmnb125 name="input.c.page2.fmnb125"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmnb126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb126
            #add-point:ON ACTION controlp INFIELD fmnb126 name="input.c.page2.fmnb126"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmnb2_d[l_ac].* = g_fmnb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt570_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt570_unlock_b("fmnb_t","'2'")
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
               LET g_fmnb_d[li_reproduce_target].* = g_fmnb_d[li_reproduce].*
               LET g_fmnb2_d[li_reproduce_target].* = g_fmnb2_d[li_reproduce].*
               LET g_fmnb3_d[li_reproduce_target].* = g_fmnb3_d[li_reproduce].*
               LET g_fmnb4_d[li_reproduce_target].* = g_fmnb4_d[li_reproduce].*
 
               LET g_fmnb2_d[li_reproduce_target].fmnbseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmnb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmnb2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_fmnb3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            #僅開放"其他訊息"頁籤修改
            NEXT FIELD fmnb028_desc
            #end add-point
            
            CALL afmt570_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmnb3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmnb3_d[l_ac].* TO NULL 
            INITIALIZE g_fmnb3_d_t.* TO NULL 
            INITIALIZE g_fmnb3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_fmnb3_d[l_ac].fmnb131 = "0"
      LET g_fmnb3_d[l_ac].fmnb132 = "0"
      LET g_fmnb3_d[l_ac].fmnb133 = "0"
      LET g_fmnb3_d[l_ac].fmnb134 = "0"
      LET g_fmnb3_d[l_ac].fmnb135 = "0"
      LET g_fmnb3_d[l_ac].fmnb136 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_fmnb3_d_t.* = g_fmnb3_d[l_ac].*     #新輸入資料
            LET g_fmnb3_d_o.* = g_fmnb3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt570_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt570_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmnb_d[li_reproduce_target].* = g_fmnb_d[li_reproduce].*
               LET g_fmnb2_d[li_reproduce_target].* = g_fmnb2_d[li_reproduce].*
               LET g_fmnb3_d[li_reproduce_target].* = g_fmnb3_d[li_reproduce].*
               LET g_fmnb4_d[li_reproduce_target].* = g_fmnb4_d[li_reproduce].*
 
               LET g_fmnb3_d[li_reproduce_target].fmnbseq = NULL
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
            OPEN afmt570_cl USING g_enterprise,g_fmna_m.fmnadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt570_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt570_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmnb3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmnb3_d[l_ac].fmnbseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmnb3_d_t.* = g_fmnb3_d[l_ac].*  #BACKUP
               LET g_fmnb3_d_o.* = g_fmnb3_d[l_ac].*  #BACKUP
               CALL afmt570_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL afmt570_set_no_entry_b(l_cmd)
               IF NOT afmt570_lock_b("fmnb_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt570_bcl INTO g_fmnb_d[l_ac].fmnbseq,g_fmnb_d[l_ac].fmnb030,g_fmnb_d[l_ac].fmnb033, 
                      g_fmnb_d[l_ac].fmnb002,g_fmnb_d[l_ac].fmnb003,g_fmnb_d[l_ac].fmnb004,g_fmnb_d[l_ac].fmnb032, 
                      g_fmnb_d[l_ac].fmnb100,g_fmnb_d[l_ac].fmnb101,g_fmnb_d[l_ac].fmnb102,g_fmnb_d[l_ac].fmnb103, 
                      g_fmnb_d[l_ac].fmnb113,g_fmnb_d[l_ac].fmnb114,g_fmnb_d[l_ac].fmnb115,g_fmnb_d[l_ac].fmnb116, 
                      g_fmnb2_d[l_ac].fmnbseq,g_fmnb2_d[l_ac].fmnb121,g_fmnb2_d[l_ac].fmnb122,g_fmnb2_d[l_ac].fmnb123, 
                      g_fmnb2_d[l_ac].fmnb124,g_fmnb2_d[l_ac].fmnb125,g_fmnb2_d[l_ac].fmnb126,g_fmnb3_d[l_ac].fmnbseq, 
                      g_fmnb3_d[l_ac].fmnb131,g_fmnb3_d[l_ac].fmnb132,g_fmnb3_d[l_ac].fmnb133,g_fmnb3_d[l_ac].fmnb134, 
                      g_fmnb3_d[l_ac].fmnb135,g_fmnb3_d[l_ac].fmnb136,g_fmnb4_d[l_ac].fmnbseq,g_fmnb4_d[l_ac].fmnb028, 
                      g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb031,g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb006, 
                      g_fmnb4_d[l_ac].fmnb007,g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb009,g_fmnb4_d[l_ac].fmnb010, 
                      g_fmnb4_d[l_ac].fmnb011,g_fmnb4_d[l_ac].fmnb012,g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014, 
                      g_fmnb4_d[l_ac].fmnb015,g_fmnb4_d[l_ac].fmnb016,g_fmnb4_d[l_ac].fmnb017,g_fmnb4_d[l_ac].fmnb018, 
                      g_fmnb4_d[l_ac].fmnb019,g_fmnb4_d[l_ac].fmnb020,g_fmnb4_d[l_ac].fmnb021,g_fmnb4_d[l_ac].fmnb022, 
                      g_fmnb4_d[l_ac].fmnb023,g_fmnb4_d[l_ac].fmnb024,g_fmnb4_d[l_ac].fmnb025,g_fmnb4_d[l_ac].fmnb026, 
                      g_fmnb4_d[l_ac].fmnb027
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmnb3_d_mask_o[l_ac].* =  g_fmnb3_d[l_ac].*
                  CALL afmt570_fmnb_t_mask()
                  LET g_fmnb3_d_mask_n[l_ac].* =  g_fmnb3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt570_show()
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
               LET gs_keys[01] = g_fmna_m.fmnadocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmnb3_d_t.fmnbseq
            
               #刪除同層單身
               IF NOT afmt570_delete_b('fmnb_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt570_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt570_key_delete_b(gs_keys,'fmnb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt570_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt570_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_fmnb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmnb3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM fmnb_t 
             WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmna_m.fmnadocno
               AND fmnbseq = g_fmnb3_d[l_ac].fmnbseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmna_m.fmnadocno
               LET gs_keys[2] = g_fmnb3_d[g_detail_idx].fmnbseq
               CALL afmt570_insert_b('fmnb_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmnb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt570_b_fill()
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
               LET g_fmnb3_d[l_ac].* = g_fmnb3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt570_bcl
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
               LET g_fmnb3_d[l_ac].* = g_fmnb3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL afmt570_fmnb_t_mask_restore('restore_mask_o')
                              
               UPDATE fmnb_t SET (fmnbdocno,fmnbseq,fmnb030,fmnb033,fmnb002,fmnb003,fmnb004,fmnb032, 
                   fmnb100,fmnb101,fmnb102,fmnb103,fmnb113,fmnb114,fmnb115,fmnb116,fmnb121,fmnb122,fmnb123, 
                   fmnb124,fmnb125,fmnb126,fmnb131,fmnb132,fmnb133,fmnb134,fmnb135,fmnb136,fmnb028,fmnb029, 
                   fmnb031,fmnb005,fmnb006,fmnb007,fmnb008,fmnb009,fmnb010,fmnb011,fmnb012,fmnb013,fmnb014, 
                   fmnb015,fmnb016,fmnb017,fmnb018,fmnb019,fmnb020,fmnb021,fmnb022,fmnb023,fmnb024,fmnb025, 
                   fmnb026,fmnb027) = (g_fmna_m.fmnadocno,g_fmnb_d[l_ac].fmnbseq,g_fmnb_d[l_ac].fmnb030, 
                   g_fmnb_d[l_ac].fmnb033,g_fmnb_d[l_ac].fmnb002,g_fmnb_d[l_ac].fmnb003,g_fmnb_d[l_ac].fmnb004, 
                   g_fmnb_d[l_ac].fmnb032,g_fmnb_d[l_ac].fmnb100,g_fmnb_d[l_ac].fmnb101,g_fmnb_d[l_ac].fmnb102, 
                   g_fmnb_d[l_ac].fmnb103,g_fmnb_d[l_ac].fmnb113,g_fmnb_d[l_ac].fmnb114,g_fmnb_d[l_ac].fmnb115, 
                   g_fmnb_d[l_ac].fmnb116,g_fmnb2_d[l_ac].fmnb121,g_fmnb2_d[l_ac].fmnb122,g_fmnb2_d[l_ac].fmnb123, 
                   g_fmnb2_d[l_ac].fmnb124,g_fmnb2_d[l_ac].fmnb125,g_fmnb2_d[l_ac].fmnb126,g_fmnb3_d[l_ac].fmnb131, 
                   g_fmnb3_d[l_ac].fmnb132,g_fmnb3_d[l_ac].fmnb133,g_fmnb3_d[l_ac].fmnb134,g_fmnb3_d[l_ac].fmnb135, 
                   g_fmnb3_d[l_ac].fmnb136,g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb031, 
                   g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb006,g_fmnb4_d[l_ac].fmnb007,g_fmnb4_d[l_ac].fmnb008, 
                   g_fmnb4_d[l_ac].fmnb009,g_fmnb4_d[l_ac].fmnb010,g_fmnb4_d[l_ac].fmnb011,g_fmnb4_d[l_ac].fmnb012, 
                   g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014,g_fmnb4_d[l_ac].fmnb015,g_fmnb4_d[l_ac].fmnb016, 
                   g_fmnb4_d[l_ac].fmnb017,g_fmnb4_d[l_ac].fmnb018,g_fmnb4_d[l_ac].fmnb019,g_fmnb4_d[l_ac].fmnb020, 
                   g_fmnb4_d[l_ac].fmnb021,g_fmnb4_d[l_ac].fmnb022,g_fmnb4_d[l_ac].fmnb023,g_fmnb4_d[l_ac].fmnb024, 
                   g_fmnb4_d[l_ac].fmnb025,g_fmnb4_d[l_ac].fmnb026,g_fmnb4_d[l_ac].fmnb027) #自訂欄位頁簽 
 
                WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmna_m.fmnadocno
                  AND fmnbseq = g_fmnb3_d_t.fmnbseq #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmnb3_d[l_ac].* = g_fmnb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmnb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmnb3_d[l_ac].* = g_fmnb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmna_m.fmnadocno
               LET gs_keys_bak[1] = g_fmnadocno_t
               LET gs_keys[2] = g_fmnb3_d[g_detail_idx].fmnbseq
               LET gs_keys_bak[2] = g_fmnb3_d_t.fmnbseq
               CALL afmt570_update_b('fmnb_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt570_fmnb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmnb3_d[g_detail_idx].fmnbseq = g_fmnb3_d_t.fmnbseq 
                  ) THEN
                  LET gs_keys[01] = g_fmna_m.fmnadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmnb3_d_t.fmnbseq
                  CALL afmt570_key_update_b(gs_keys,'fmnb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmna_m),util.JSON.stringify(g_fmnb3_d_t)
               LET g_log2 = util.JSON.stringify(g_fmna_m),util.JSON.stringify(g_fmnb3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb131
            #add-point:BEFORE FIELD fmnb131 name="input.b.page3.fmnb131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb131
            
            #add-point:AFTER FIELD fmnb131 name="input.a.page3.fmnb131"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb131
            #add-point:ON CHANGE fmnb131 name="input.g.page3.fmnb131"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb132
            #add-point:BEFORE FIELD fmnb132 name="input.b.page3.fmnb132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb132
            
            #add-point:AFTER FIELD fmnb132 name="input.a.page3.fmnb132"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb132
            #add-point:ON CHANGE fmnb132 name="input.g.page3.fmnb132"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb133
            #add-point:BEFORE FIELD fmnb133 name="input.b.page3.fmnb133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb133
            
            #add-point:AFTER FIELD fmnb133 name="input.a.page3.fmnb133"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb133
            #add-point:ON CHANGE fmnb133 name="input.g.page3.fmnb133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb134
            #add-point:BEFORE FIELD fmnb134 name="input.b.page3.fmnb134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb134
            
            #add-point:AFTER FIELD fmnb134 name="input.a.page3.fmnb134"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb134
            #add-point:ON CHANGE fmnb134 name="input.g.page3.fmnb134"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb135
            #add-point:BEFORE FIELD fmnb135 name="input.b.page3.fmnb135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb135
            
            #add-point:AFTER FIELD fmnb135 name="input.a.page3.fmnb135"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb135
            #add-point:ON CHANGE fmnb135 name="input.g.page3.fmnb135"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb136
            #add-point:BEFORE FIELD fmnb136 name="input.b.page3.fmnb136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb136
            
            #add-point:AFTER FIELD fmnb136 name="input.a.page3.fmnb136"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb136
            #add-point:ON CHANGE fmnb136 name="input.g.page3.fmnb136"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.fmnb131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb131
            #add-point:ON ACTION controlp INFIELD fmnb131 name="input.c.page3.fmnb131"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmnb132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb132
            #add-point:ON ACTION controlp INFIELD fmnb132 name="input.c.page3.fmnb132"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmnb133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb133
            #add-point:ON ACTION controlp INFIELD fmnb133 name="input.c.page3.fmnb133"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmnb134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb134
            #add-point:ON ACTION controlp INFIELD fmnb134 name="input.c.page3.fmnb134"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmnb135
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb135
            #add-point:ON ACTION controlp INFIELD fmnb135 name="input.c.page3.fmnb135"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmnb136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb136
            #add-point:ON ACTION controlp INFIELD fmnb136 name="input.c.page3.fmnb136"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmnb3_d[l_ac].* = g_fmnb3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt570_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt570_unlock_b("fmnb_t","'3'")
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
               LET g_fmnb_d[li_reproduce_target].* = g_fmnb_d[li_reproduce].*
               LET g_fmnb2_d[li_reproduce_target].* = g_fmnb2_d[li_reproduce].*
               LET g_fmnb3_d[li_reproduce_target].* = g_fmnb3_d[li_reproduce].*
               LET g_fmnb4_d[li_reproduce_target].* = g_fmnb4_d[li_reproduce].*
 
               LET g_fmnb3_d[li_reproduce_target].fmnbseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmnb3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmnb3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_fmnb4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            
            CALL afmt570_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmnb4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmnb4_d[l_ac].* TO NULL 
            INITIALIZE g_fmnb4_d_t.* TO NULL 
            INITIALIZE g_fmnb4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_fmnb4_d_t.* = g_fmnb4_d[l_ac].*     #新輸入資料
            LET g_fmnb4_d_o.* = g_fmnb4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt570_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt570_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmnb_d[li_reproduce_target].* = g_fmnb_d[li_reproduce].*
               LET g_fmnb2_d[li_reproduce_target].* = g_fmnb2_d[li_reproduce].*
               LET g_fmnb3_d[li_reproduce_target].* = g_fmnb3_d[li_reproduce].*
               LET g_fmnb4_d[li_reproduce_target].* = g_fmnb4_d[li_reproduce].*
 
               LET g_fmnb4_d[li_reproduce_target].fmnbseq = NULL
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
            OPEN afmt570_cl USING g_enterprise,g_fmna_m.fmnadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt570_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt570_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmnb4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmnb4_d[l_ac].fmnbseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmnb4_d_t.* = g_fmnb4_d[l_ac].*  #BACKUP
               LET g_fmnb4_d_o.* = g_fmnb4_d[l_ac].*  #BACKUP
               CALL afmt570_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL afmt570_set_no_entry_b(l_cmd)
               IF NOT afmt570_lock_b("fmnb_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt570_bcl INTO g_fmnb_d[l_ac].fmnbseq,g_fmnb_d[l_ac].fmnb030,g_fmnb_d[l_ac].fmnb033, 
                      g_fmnb_d[l_ac].fmnb002,g_fmnb_d[l_ac].fmnb003,g_fmnb_d[l_ac].fmnb004,g_fmnb_d[l_ac].fmnb032, 
                      g_fmnb_d[l_ac].fmnb100,g_fmnb_d[l_ac].fmnb101,g_fmnb_d[l_ac].fmnb102,g_fmnb_d[l_ac].fmnb103, 
                      g_fmnb_d[l_ac].fmnb113,g_fmnb_d[l_ac].fmnb114,g_fmnb_d[l_ac].fmnb115,g_fmnb_d[l_ac].fmnb116, 
                      g_fmnb2_d[l_ac].fmnbseq,g_fmnb2_d[l_ac].fmnb121,g_fmnb2_d[l_ac].fmnb122,g_fmnb2_d[l_ac].fmnb123, 
                      g_fmnb2_d[l_ac].fmnb124,g_fmnb2_d[l_ac].fmnb125,g_fmnb2_d[l_ac].fmnb126,g_fmnb3_d[l_ac].fmnbseq, 
                      g_fmnb3_d[l_ac].fmnb131,g_fmnb3_d[l_ac].fmnb132,g_fmnb3_d[l_ac].fmnb133,g_fmnb3_d[l_ac].fmnb134, 
                      g_fmnb3_d[l_ac].fmnb135,g_fmnb3_d[l_ac].fmnb136,g_fmnb4_d[l_ac].fmnbseq,g_fmnb4_d[l_ac].fmnb028, 
                      g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb031,g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb006, 
                      g_fmnb4_d[l_ac].fmnb007,g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb009,g_fmnb4_d[l_ac].fmnb010, 
                      g_fmnb4_d[l_ac].fmnb011,g_fmnb4_d[l_ac].fmnb012,g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014, 
                      g_fmnb4_d[l_ac].fmnb015,g_fmnb4_d[l_ac].fmnb016,g_fmnb4_d[l_ac].fmnb017,g_fmnb4_d[l_ac].fmnb018, 
                      g_fmnb4_d[l_ac].fmnb019,g_fmnb4_d[l_ac].fmnb020,g_fmnb4_d[l_ac].fmnb021,g_fmnb4_d[l_ac].fmnb022, 
                      g_fmnb4_d[l_ac].fmnb023,g_fmnb4_d[l_ac].fmnb024,g_fmnb4_d[l_ac].fmnb025,g_fmnb4_d[l_ac].fmnb026, 
                      g_fmnb4_d[l_ac].fmnb027
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmnb4_d_mask_o[l_ac].* =  g_fmnb4_d[l_ac].*
                  CALL afmt570_fmnb_t_mask()
                  LET g_fmnb4_d_mask_n[l_ac].* =  g_fmnb4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt570_show()
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
               LET gs_keys[01] = g_fmna_m.fmnadocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmnb4_d_t.fmnbseq
            
               #刪除同層單身
               IF NOT afmt570_delete_b('fmnb_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt570_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt570_key_delete_b(gs_keys,'fmnb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt570_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt570_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_fmnb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmnb4_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM fmnb_t 
             WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmna_m.fmnadocno
               AND fmnbseq = g_fmnb4_d[l_ac].fmnbseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmna_m.fmnadocno
               LET gs_keys[2] = g_fmnb4_d[g_detail_idx].fmnbseq
               CALL afmt570_insert_b('fmnb_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmnb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt570_b_fill()
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
               LET g_fmnb4_d[l_ac].* = g_fmnb4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt570_bcl
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
               LET g_fmnb4_d[l_ac].* = g_fmnb4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL afmt570_fmnb_t_mask_restore('restore_mask_o')
                              
               UPDATE fmnb_t SET (fmnbdocno,fmnbseq,fmnb030,fmnb033,fmnb002,fmnb003,fmnb004,fmnb032, 
                   fmnb100,fmnb101,fmnb102,fmnb103,fmnb113,fmnb114,fmnb115,fmnb116,fmnb121,fmnb122,fmnb123, 
                   fmnb124,fmnb125,fmnb126,fmnb131,fmnb132,fmnb133,fmnb134,fmnb135,fmnb136,fmnb028,fmnb029, 
                   fmnb031,fmnb005,fmnb006,fmnb007,fmnb008,fmnb009,fmnb010,fmnb011,fmnb012,fmnb013,fmnb014, 
                   fmnb015,fmnb016,fmnb017,fmnb018,fmnb019,fmnb020,fmnb021,fmnb022,fmnb023,fmnb024,fmnb025, 
                   fmnb026,fmnb027) = (g_fmna_m.fmnadocno,g_fmnb_d[l_ac].fmnbseq,g_fmnb_d[l_ac].fmnb030, 
                   g_fmnb_d[l_ac].fmnb033,g_fmnb_d[l_ac].fmnb002,g_fmnb_d[l_ac].fmnb003,g_fmnb_d[l_ac].fmnb004, 
                   g_fmnb_d[l_ac].fmnb032,g_fmnb_d[l_ac].fmnb100,g_fmnb_d[l_ac].fmnb101,g_fmnb_d[l_ac].fmnb102, 
                   g_fmnb_d[l_ac].fmnb103,g_fmnb_d[l_ac].fmnb113,g_fmnb_d[l_ac].fmnb114,g_fmnb_d[l_ac].fmnb115, 
                   g_fmnb_d[l_ac].fmnb116,g_fmnb2_d[l_ac].fmnb121,g_fmnb2_d[l_ac].fmnb122,g_fmnb2_d[l_ac].fmnb123, 
                   g_fmnb2_d[l_ac].fmnb124,g_fmnb2_d[l_ac].fmnb125,g_fmnb2_d[l_ac].fmnb126,g_fmnb3_d[l_ac].fmnb131, 
                   g_fmnb3_d[l_ac].fmnb132,g_fmnb3_d[l_ac].fmnb133,g_fmnb3_d[l_ac].fmnb134,g_fmnb3_d[l_ac].fmnb135, 
                   g_fmnb3_d[l_ac].fmnb136,g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb031, 
                   g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb006,g_fmnb4_d[l_ac].fmnb007,g_fmnb4_d[l_ac].fmnb008, 
                   g_fmnb4_d[l_ac].fmnb009,g_fmnb4_d[l_ac].fmnb010,g_fmnb4_d[l_ac].fmnb011,g_fmnb4_d[l_ac].fmnb012, 
                   g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014,g_fmnb4_d[l_ac].fmnb015,g_fmnb4_d[l_ac].fmnb016, 
                   g_fmnb4_d[l_ac].fmnb017,g_fmnb4_d[l_ac].fmnb018,g_fmnb4_d[l_ac].fmnb019,g_fmnb4_d[l_ac].fmnb020, 
                   g_fmnb4_d[l_ac].fmnb021,g_fmnb4_d[l_ac].fmnb022,g_fmnb4_d[l_ac].fmnb023,g_fmnb4_d[l_ac].fmnb024, 
                   g_fmnb4_d[l_ac].fmnb025,g_fmnb4_d[l_ac].fmnb026,g_fmnb4_d[l_ac].fmnb027) #自訂欄位頁簽 
 
                WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmna_m.fmnadocno
                  AND fmnbseq = g_fmnb4_d_t.fmnbseq #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmnb4_d[l_ac].* = g_fmnb4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmnb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmnb4_d[l_ac].* = g_fmnb4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmna_m.fmnadocno
               LET gs_keys_bak[1] = g_fmnadocno_t
               LET gs_keys[2] = g_fmnb4_d[g_detail_idx].fmnbseq
               LET gs_keys_bak[2] = g_fmnb4_d_t.fmnbseq
               CALL afmt570_update_b('fmnb_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt570_fmnb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmnb4_d[g_detail_idx].fmnbseq = g_fmnb4_d_t.fmnbseq 
                  ) THEN
                  LET gs_keys[01] = g_fmna_m.fmnadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmnb4_d_t.fmnbseq
                  CALL afmt570_key_update_b(gs_keys,'fmnb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmna_m),util.JSON.stringify(g_fmnb4_d_t)
               LET g_log2 = util.JSON.stringify(g_fmna_m),util.JSON.stringify(g_fmnb4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb028
            #add-point:BEFORE FIELD fmnb028 name="input.b.page4.fmnb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb028
            
            #add-point:AFTER FIELD fmnb028 name="input.a.page4.fmnb028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb028
            #add-point:ON CHANGE fmnb028 name="input.g.page4.fmnb028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb028_desc
            #add-point:BEFORE FIELD fmnb028_desc name="input.b.page4.fmnb028_desc"
            LET g_fmnb4_d[l_ac].fmnb028_desc = g_fmnb4_d[l_ac].fmnb028
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb028_desc
            
            #add-point:AFTER FIELD fmnb028_desc name="input.a.page4.fmnb028_desc"
            #重評價科目
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb028_desc) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511203
            LET l_sql = ""
            IF  s_aglt310_getlike_lc_subject(g_fmna_m.fmna001,g_fmnb4_d[l_ac].fmnb028_desc,l_sql) THEN
               INITIALIZE g_qryparam.* TO NULL
               SELECT glaa004 INTO l_glaa004
                FROM glaa_t
               WHERE glaaent = g_enterprise
                 AND glaald = g_fmna_m.fmna001
              LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = 'FALSE'
              LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb028_desc
              
              LET g_qryparam.arg1 = l_glaa004
              LET g_qryparam.arg2 = g_fmnb4_d[l_ac].fmnb028_desc
              LET g_qryparam.arg3 = g_fmna_m.fmna001
              LET g_qryparam.arg4 = "1 "
              CALL q_glac002_6()
              LET g_fmnb4_d[l_ac].fmnb028 = g_qryparam.return1
              LET g_fmnb4_d[l_ac].fmnb028_desc = g_qryparam.return1
              DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb028_desc
            END IF
             IF  NOT s_aglt310_lc_subject(g_fmna_m.fmna001,g_fmnb4_d[l_ac].fmnb028_desc,'N') THEN
                LET g_fmnb4_d[l_ac].fmnb028      = g_fmnb4_d_t.fmnb028
                      LET g_fmnb4_d[l_ac].fmnb028_desc = g_fmnb4_d_t.fmnb028_desc
                      DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb028_desc
                      NEXT FIELD CURRENT
             END IF
 #  150916-00015#1 END
               IF ( g_fmnb4_d[l_ac].fmnb028_desc != g_fmnb4_d_t.fmnb028_desc OR g_fmnb4_d_t.fmnb028_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb028 = g_fmnb4_d[l_ac].fmnb028_desc
                  IF (g_fmnb4_d[l_ac].fmnb028 != g_fmnb4_d_t.fmnb028 OR g_fmnb4_d_t.fmnb028 IS NULL) THEN
                     CALL s_aap_glac002_chk(g_fmnb4_d[l_ac].fmnb028,g_fmna_m.fmna001) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#27 --s add
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                        #160321-00016#27 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_fmnb4_d[l_ac].fmnb028      = g_fmnb4_d_t.fmnb028
                        LET g_fmnb4_d[l_ac].fmnb028_desc = g_fmnb4_d_t.fmnb028_desc
                        DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb028_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb028 = ''
            END IF
            LET g_fmnb4_d_t.fmnb028_desc = g_fmnb4_d[l_ac].fmnb028_desc
            LET g_fmnb4_d[l_ac].fmnb028_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb028,s_desc_get_account_desc(g_fmna_m.fmna001,g_fmnb4_d[l_ac].fmnb028))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb028_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb028_desc
            #add-point:ON CHANGE fmnb028_desc name="input.g.page4.fmnb028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb029
            #add-point:BEFORE FIELD fmnb029 name="input.b.page4.fmnb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb029
            
            #add-point:AFTER FIELD fmnb029 name="input.a.page4.fmnb029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb029
            #add-point:ON CHANGE fmnb029 name="input.g.page4.fmnb029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb029_desc
            #add-point:BEFORE FIELD fmnb029_desc name="input.b.page4.fmnb029_desc"
            LET g_fmnb4_d[l_ac].fmnb029_desc = g_fmnb4_d[l_ac].fmnb029
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb029_desc
            
            #add-point:AFTER FIELD fmnb029_desc name="input.a.page4.fmnb029_desc"
            #對方科目
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb029_desc) THEN
                #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511203
           #  LET l_sql = ""
           #  IF  s_aglt310_getlike_lc_subject(g_fmna_m.fmna001,g_fmnb4_d[l_ac].fmnb029_desc,l_sql) THEN
           #     INITIALIZE g_qryparam.* TO NULL
           #     SELECT glaa004 INTO l_glaa004
           #      FROM glaa_t
           #     WHERE glaaent = g_enterprise
           #       AND glaald = g_fmna_m.fmna001
           #    LET g_qryparam.state = 'i'
           #    LET g_qryparam.reqry = 'FALSE'
           #    LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb029_desc
           #    
           #    LET g_qryparam.arg1 = l_glaa004
           #    LET g_qryparam.arg2 = g_fmnb4_d[l_ac].fmnb029_desc
           #    LET g_qryparam.arg3 = g_fmna_m.fmna001
           #    LET g_qryparam.arg4 = "1 "
           #    CALL q_glac002_6()
           #   LET g_fmnb4_d[l_ac].fmnb029 = g_qryparam.return1
           #   LET g_fmnb4_d[l_ac].fmnb029_desc = g_qryparam.return1
           #   DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb029_desc
           #  END IF
           #   IF NOT s_aglt310_lc_subject(g_fmna_m.fmna001,g_fmnb4_d[l_ac].fmnb029_desc,'N') THEN
           #       LET g_fmnb4_d[l_ac].fmnb029      = g_fmnb4_d_t.fmnb029
           #       LET g_fmnb4_d[l_ac].fmnb029_desc = g_fmnb4_d_t.fmnb029_desc
           #       DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb029_desc
           #       NEXT FIELD CURRENT
           #   END IF
 #  150916-00015#1 END
               IF ( g_fmnb4_d[l_ac].fmnb029_desc != g_fmnb4_d_t.fmnb029_desc OR g_fmnb4_d_t.fmnb029_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb029 = g_fmnb4_d[l_ac].fmnb029_desc
                  IF (g_fmnb4_d[l_ac].fmnb029 != g_fmnb4_d_t.fmnb029 OR g_fmnb4_d_t.fmnb029 IS NULL) THEN
                     CALL s_aap_glac002_chk(g_fmnb4_d[l_ac].fmnb029,g_fmna_m.fmna001) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#27 --s add
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                        #160321-00016#27 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_fmnb4_d[l_ac].fmnb029      = g_fmnb4_d_t.fmnb029
                        LET g_fmnb4_d[l_ac].fmnb029_desc = g_fmnb4_d_t.fmnb029_desc
                        DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb029_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb029 = ''
            END IF
            LET g_fmnb4_d_t.fmnb029_desc = g_fmnb4_d[l_ac].fmnb029_desc
            LET g_fmnb4_d[l_ac].fmnb029_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb029,s_desc_get_account_desc(g_fmna_m.fmna001,g_fmnb4_d[l_ac].fmnb029))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb029_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb029_desc
            #add-point:ON CHANGE fmnb029_desc name="input.g.page4.fmnb029_desc"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb031
            #add-point:BEFORE FIELD fmnb031 name="input.b.page4.fmnb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb031
            
            #add-point:AFTER FIELD fmnb031 name="input.a.page4.fmnb031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb031
            #add-point:ON CHANGE fmnb031 name="input.g.page4.fmnb031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb005
            #add-point:BEFORE FIELD fmnb005 name="input.b.page4.fmnb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb005
            
            #add-point:AFTER FIELD fmnb005 name="input.a.page4.fmnb005"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb005
            #add-point:ON CHANGE fmnb005 name="input.g.page4.fmnb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb005_desc
            #add-point:BEFORE FIELD fmnb005_desc name="input.b.page4.fmnb005_desc"
            LET g_fmnb4_d[l_ac].fmnb005_desc = g_fmnb4_d[l_ac].fmnb005
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb005_desc
            
            #add-point:AFTER FIELD fmnb005_desc name="input.a.page4.fmnb005_desc"
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb005_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb005_desc != g_fmnb4_d_t.fmnb005_desc OR g_fmnb4_d_t.fmnb005_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb005 = g_fmnb4_d[l_ac].fmnb005_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb005 != g_fmnb4_d_t.fmnb005 OR g_fmnb4_d_t.fmnb005 IS NULL) THEN
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_fmnb4_d[l_ac].fmnb005
                        LET g_chkparam.arg2 = ' '
                        LET g_errshow = TRUE   #160318-00025#50
                        LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"    #160318-00025#50
                        IF NOT cl_chk_exist("v_pmaa001_7") THEN
                           LET g_fmnb4_d[l_ac].fmnb005      = g_fmnb4_d_t.fmnb005
                           LET g_fmnb4_d[l_ac].fmnb005_desc = g_fmnb4_d_t.fmnb005_desc
                           LET g_fmnb4_d[l_ac].fmnb005_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb005,s_desc_get_trading_partner_abbr_desc(g_fmnb4_d[l_ac].fmnb005))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb005_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb005 = ''
            END IF
            LET g_fmnb4_d_t.fmnb005_desc = g_fmnb4_d[l_ac].fmnb005_desc
            LET g_fmnb4_d[l_ac].fmnb005_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb005,s_desc_get_trading_partner_abbr_desc(g_fmnb4_d[l_ac].fmnb005))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb005_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb005_desc
            #add-point:ON CHANGE fmnb005_desc name="input.g.page4.fmnb005_desc"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb006
            #add-point:BEFORE FIELD fmnb006 name="input.b.page4.fmnb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb006
            
            #add-point:AFTER FIELD fmnb006 name="input.a.page4.fmnb006"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb006
            #add-point:ON CHANGE fmnb006 name="input.g.page4.fmnb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb006_desc
            #add-point:BEFORE FIELD fmnb006_desc name="input.b.page4.fmnb006_desc"
            LET g_fmnb4_d[l_ac].fmnb006_desc = g_fmnb4_d[l_ac].fmnb006
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb006_desc
            
            #add-point:AFTER FIELD fmnb006_desc name="input.a.page4.fmnb006_desc"
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb006_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb006_desc != g_fmnb4_d_t.fmnb006_desc OR g_fmnb4_d_t.fmnb006_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb006 = g_fmnb4_d[l_ac].fmnb006_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb006 != g_fmnb4_d_t.fmnb006 OR g_fmnb4_d_t.fmnb006 IS NULL) THEN
                        #資料存在性、有效性檢查
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_fmnb4_d[l_ac].fmnb006
                        LET g_chkparam.arg2 = ' '
                        LET g_errshow = TRUE   #160318-00025#50
                        LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"    #160318-00025#50
                        IF NOT cl_chk_exist("v_pmaa001_7") THEN
                           LET g_fmnb4_d[l_ac].fmnb006      = g_fmnb4_d_t.fmnb006
                           LET g_fmnb4_d[l_ac].fmnb006_desc = g_fmnb4_d_t.fmnb006_desc
                           LET g_fmnb4_d[l_ac].fmnb006_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb006,s_desc_get_trading_partner_abbr_desc(g_fmnb4_d[l_ac].fmnb006))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb006,g_fmnb4_d[l_ac].fmnb006_desc
                           NEXT FIELD CURRENT
                        END IF
                        #資料邏輯正確性檢查
                        IF g_fmnb4_d[l_ac].fmnb005 != g_fmnb4_d[l_ac].fmnb006 THEN
                           INITIALIZE g_chkparam.* TO NULL
                           LET g_chkparam.arg1 = g_fmnb4_d[l_ac].fmnb005
                           LET g_chkparam.arg2 = g_fmnb4_d[l_ac].fmnb006
                           LET g_errshow = TRUE   #160318-00025#50
                           LET g_chkparam.err_str[1] = "axr-00049:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"    #160318-00025#50
                           IF NOT cl_chk_exist("v_pmac002_4") THEN
                              LET g_fmnb4_d[l_ac].fmnb006      = g_fmnb4_d_t.fmnb006
                              LET g_fmnb4_d[l_ac].fmnb006_desc = g_fmnb4_d_t.fmnb006_desc
                              LET g_fmnb4_d[l_ac].fmnb006_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb006,s_desc_get_trading_partner_abbr_desc(g_fmnb4_d[l_ac].fmnb006))
                              DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb006,g_fmnb4_d[l_ac].fmnb006_desc
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb006 = ''
            END IF
            LET g_fmnb4_d_t.fmnb006_desc = g_fmnb4_d[l_ac].fmnb006_desc
            LET g_fmnb4_d[l_ac].fmnb006_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb006,s_desc_get_trading_partner_abbr_desc(g_fmnb4_d[l_ac].fmnb006))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb006,g_fmnb4_d[l_ac].fmnb006_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb006_desc
            #add-point:ON CHANGE fmnb006_desc name="input.g.page4.fmnb006_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb007
            #add-point:BEFORE FIELD fmnb007 name="input.b.page4.fmnb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb007
            
            #add-point:AFTER FIELD fmnb007 name="input.a.page4.fmnb007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb007
            #add-point:ON CHANGE fmnb007 name="input.g.page4.fmnb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb007_desc
            #add-point:BEFORE FIELD fmnb007_desc name="input.b.page4.fmnb007_desc"
            LET g_fmnb4_d[l_ac].fmnb007_desc = g_fmnb4_d[l_ac].fmnb007
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb007_desc
            
            #add-point:AFTER FIELD fmnb007_desc name="input.a.page4.fmnb007_desc"
            #部門
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb007_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb007_desc != g_fmnb4_d_t.fmnb007_desc OR g_fmnb4_d_t.fmnb007_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb007 = g_fmnb4_d[l_ac].fmnb007_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb007 != g_fmnb4_d_t.fmnb007 OR g_fmnb4_d_t.fmnb007 IS NULL) THEN
                        CALL s_department_chk(g_fmnb4_d[l_ac].fmnb007_desc,g_fmna_m.fmnadocdt) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_fmnb4_d[l_ac].fmnb007 = g_fmnb4_d_t.fmnb007
                           LET g_fmnb4_d[l_ac].fmnb007_desc = g_fmnb4_d_t.fmnb007_desc
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb007 ,g_fmnb4_d[l_ac].fmnb007_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  #取責任中心
                  CALL s_department_get_respon_center(g_fmnb4_d[l_ac].fmnb007,g_fmna_m.fmnadocdt)
                       RETURNING g_sub_success,g_errno,g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb008_desc
                  LET g_fmnb4_d[l_ac].fmnb008_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb008_desc)
                  LET g_fmnb4_d_t.fmnb008_desc = g_fmnb4_d[l_ac].fmnb008_desc
                  DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb008_desc
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb007 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb007_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb007,s_desc_get_department_desc(g_fmnb4_d[l_ac].fmnb007))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb007 ,g_fmnb4_d[l_ac].fmnb007_desc
            LET g_fmnb4_d_t.fmnb007_desc = g_fmnb4_d[l_ac].fmnb007_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb007_desc
            #add-point:ON CHANGE fmnb007_desc name="input.g.page4.fmnb007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb008
            #add-point:BEFORE FIELD fmnb008 name="input.b.page4.fmnb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb008
            
            #add-point:AFTER FIELD fmnb008 name="input.a.page4.fmnb008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb008
            #add-point:ON CHANGE fmnb008 name="input.g.page4.fmnb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb008_desc
            #add-point:BEFORE FIELD fmnb008_desc name="input.b.page4.fmnb008_desc"
            LET g_fmnb4_d[l_ac].fmnb008_desc = g_fmnb4_d[l_ac].fmnb008
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb008_desc
            
            #add-point:AFTER FIELD fmnb008_desc name="input.a.page4.fmnb008_desc"
            #責任中心
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb008_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb008_desc != g_fmnb4_d_t.fmnb008_desc OR g_fmnb4_d_t.fmnb008_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb008 = g_fmnb4_d[l_ac].fmnb008_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb008 != g_fmnb4_d_t.fmnb008 OR g_fmnb4_d_t.fmnb008 IS NULL) THEN
                        CALL s_voucher_glaq019_chk(g_fmnb4_d[l_ac].fmnb008_desc,g_fmna_m.fmnadocdt)
                        IF NOT cl_null(g_errno) THEN
                           LET g_fmnb4_d[l_ac].fmnb008 = g_fmnb4_d_t.fmnb008
                           LET g_fmnb4_d[l_ac].fmnb008_desc = g_fmnb4_d_t.fmnb008_desc
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb008_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb008 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb008_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb008,s_desc_get_department_desc(g_fmnb4_d[l_ac].fmnb008))         
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb008 ,g_fmnb4_d[l_ac].fmnb008_desc
            LET g_fmnb4_d_t.fmnb008_desc = g_fmnb4_d[l_ac].fmnb008_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb008_desc
            #add-point:ON CHANGE fmnb008_desc name="input.g.page4.fmnb008_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb009
            #add-point:BEFORE FIELD fmnb009 name="input.b.page4.fmnb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb009
            
            #add-point:AFTER FIELD fmnb009 name="input.a.page4.fmnb009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb009
            #add-point:ON CHANGE fmnb009 name="input.g.page4.fmnb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb009_desc
            #add-point:BEFORE FIELD fmnb009_desc name="input.b.page4.fmnb009_desc"
            LET g_fmnb4_d[l_ac].fmnb009_desc = g_fmnb4_d[l_ac].fmnb009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb009_desc
            
            #add-point:AFTER FIELD fmnb009_desc name="input.a.page4.fmnb009_desc"
            #區域
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb009_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb009_desc != g_fmnb4_d_t.fmnb009_desc OR g_fmnb4_d_t.fmnb009_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb009 = g_fmnb4_d[l_ac].fmnb009_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb009 != g_fmnb4_d_t.fmnb009 OR g_fmnb4_d_t.fmnb009 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('287',g_fmnb4_d[l_ac].fmnb009) THEN
                           LET g_fmnb4_d[l_ac].fmnb009 = g_fmnb4_d_t.fmnb009
                           LET g_fmnb4_d[l_ac].fmnb009_desc = g_fmnb4_d_t.fmnb009_desc
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb009 ,g_fmnb4_d[l_ac].fmnb009_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            LET g_fmnb4_d[l_ac].fmnb009_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb009,s_desc_get_acc_desc('287',g_fmnb4_d[l_ac].fmnb009))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb009 ,g_fmnb4_d[l_ac].fmnb009_desc
            LET g_fmnb4_d_t.fmnb009_desc = g_fmnb4_d[l_ac].fmnb009_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb009_desc
            #add-point:ON CHANGE fmnb009_desc name="input.g.page4.fmnb009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb010
            #add-point:BEFORE FIELD fmnb010 name="input.b.page4.fmnb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb010
            
            #add-point:AFTER FIELD fmnb010 name="input.a.page4.fmnb010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb010
            #add-point:ON CHANGE fmnb010 name="input.g.page4.fmnb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb010_desc
            #add-point:BEFORE FIELD fmnb010_desc name="input.b.page4.fmnb010_desc"
            LET g_fmnb4_d[l_ac].fmnb010_desc = g_fmnb4_d[l_ac].fmnb010
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb010_desc
            
            #add-point:AFTER FIELD fmnb010_desc name="input.a.page4.fmnb010_desc"
            #客群
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb010_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb010_desc != g_fmnb4_d_t.fmnb010_desc OR g_fmnb4_d_t.fmnb010_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb010 = g_fmnb4_d[l_ac].fmnb010_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb010 != g_fmnb4_d_t.fmnb010 OR g_fmnb4_d_t.fmnb010 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('281',g_fmnb4_d[l_ac].fmnb010) THEN
                           LET g_fmnb4_d[l_ac].fmnb010 = g_fmnb4_d_t.fmnb010
                           LET g_fmnb4_d[l_ac].fmnb010_desc = g_fmnb4_d_t.fmnb010_desc
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb010 ,g_fmnb4_d[l_ac].fmnb010_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb010 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb010_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb010,s_desc_get_acc_desc('281',g_fmnb4_d[l_ac].fmnb010))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb010 ,g_fmnb4_d[l_ac].fmnb010_desc
            LET g_fmnb4_d_t.fmnb010_desc = g_fmnb4_d[l_ac].fmnb010_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb010_desc
            #add-point:ON CHANGE fmnb010_desc name="input.g.page4.fmnb010_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb011
            #add-point:BEFORE FIELD fmnb011 name="input.b.page4.fmnb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb011
            
            #add-point:AFTER FIELD fmnb011 name="input.a.page4.fmnb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb011
            #add-point:ON CHANGE fmnb011 name="input.g.page4.fmnb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb011_desc
            #add-point:BEFORE FIELD fmnb011_desc name="input.b.page4.fmnb011_desc"
            LET g_fmnb4_d[l_ac].fmnb011_desc = g_fmnb4_d[l_ac].fmnb011
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb011_desc
            
            #add-point:AFTER FIELD fmnb011_desc name="input.a.page4.fmnb011_desc"
            #產品類別
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb011_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb011_desc != g_fmnb4_d_t.fmnb011_desc OR g_fmnb4_d_t.fmnb011_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb011 = g_fmnb4_d[l_ac].fmnb011_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb011 != g_fmnb4_d_t.fmnb011 OR g_fmnb4_d_t.fmnb011 IS NULL) THEN
                        CALL s_voucher_glaq024_chk(g_fmnb4_d[l_ac].fmnb011) 
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'arti202'
                           LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                           LET g_errparam.exeprog = 'arti202'
                           #160321-00016#27 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb011 = g_fmnb4_d_t.fmnb011
                           LET g_fmnb4_d[l_ac].fmnb011_desc = g_fmnb4_d_t.fmnb011_desc
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb011 ,g_fmnb4_d[l_ac].fmnb011_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb011 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb011_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb011,s_desc_get_rtaxl003_desc(g_fmnb4_d[l_ac].fmnb011))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb011 ,g_fmnb4_d[l_ac].fmnb011_desc
            LET g_fmnb4_d_t.fmnb011_desc = g_fmnb4_d[l_ac].fmnb011_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb011_desc
            #add-point:ON CHANGE fmnb011_desc name="input.g.page4.fmnb011_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb012
            #add-point:BEFORE FIELD fmnb012 name="input.b.page4.fmnb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb012
            
            #add-point:AFTER FIELD fmnb012 name="input.a.page4.fmnb012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb012
            #add-point:ON CHANGE fmnb012 name="input.g.page4.fmnb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb012_desc
            #add-point:BEFORE FIELD fmnb012_desc name="input.b.page4.fmnb012_desc"
            LET g_fmnb4_d[l_ac].fmnb012_desc = g_fmnb4_d[l_ac].fmnb012
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb012_desc
            
            #add-point:AFTER FIELD fmnb012_desc name="input.a.page4.fmnb012_desc"
            #人員
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb012_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb012_desc != g_fmnb4_d_t.fmnb012_desc OR g_fmnb4_d_t.fmnb012_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb012 = g_fmnb4_d[l_ac].fmnb012_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb012 != g_fmnb4_d_t.fmnb012 OR g_fmnb4_d_t.fmnb012 IS NULL) THEN
                        CALL s_employee_chk(g_fmnb4_d[l_ac].fmnb012_desc) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_fmnb4_d[l_ac].fmnb012 = g_fmnb4_d_t.fmnb012
                           LET g_fmnb4_d[l_ac].fmnb012_desc = g_fmnb4_d_t.fmnb012_desc
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb012,g_fmnb4_d[l_ac].fmnb012_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb012 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb012_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb012,s_desc_get_person_desc(g_fmnb4_d[l_ac].fmnb012))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb012,g_fmnb4_d[l_ac].fmnb012_desc
            LET g_fmnb4_d_t.fmnb012_desc = g_fmnb4_d[l_ac].fmnb012_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb012_desc
            #add-point:ON CHANGE fmnb012_desc name="input.g.page4.fmnb012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb013
            #add-point:BEFORE FIELD fmnb013 name="input.b.page4.fmnb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb013
            
            #add-point:AFTER FIELD fmnb013 name="input.a.page4.fmnb013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb013
            #add-point:ON CHANGE fmnb013 name="input.g.page4.fmnb013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb013_desc
            #add-point:BEFORE FIELD fmnb013_desc name="input.b.page4.fmnb013_desc"
            LET g_fmnb4_d[l_ac].fmnb013_desc = g_fmnb4_d[l_ac].fmnb013
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb013_desc
            
            #add-point:AFTER FIELD fmnb013_desc name="input.a.page4.fmnb013_desc"
            #專案代號
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb013_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb013_desc != g_fmnb4_d_t.fmnb013_desc OR g_fmnb4_d_t.fmnb013_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb013 = g_fmnb4_d[l_ac].fmnb013_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb013 != g_fmnb4_d_t.fmnb013 OR g_fmnb4_d_t.fmnb013 IS NULL) THEN
                        CALL s_aap_project_chk( g_fmnb4_d[l_ac].fmnb013) RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'apjm200'
                           LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                           LET g_errparam.exeprog = 'apjm200'
                           #160321-00016#27 --e add
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb013      = g_fmnb4_d_t.fmnb013
                           LET g_fmnb4_d[l_ac].fmnb013_desc = g_fmnb4_d_t.fmnb013_desc
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb013_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb013 = ''                 
            END IF
            LET g_fmnb4_d[l_ac].fmnb013_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb013,s_desc_get_project_desc(g_fmnb4_d[l_ac].fmnb013))
            LET g_fmnb4_d_t.fmnb013 = g_fmnb4_d[l_ac].fmnb013_desc
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb013_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb013_desc
            #add-point:ON CHANGE fmnb013_desc name="input.g.page4.fmnb013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb014
            #add-point:BEFORE FIELD fmnb014 name="input.b.page4.fmnb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb014
            
            #add-point:AFTER FIELD fmnb014 name="input.a.page4.fmnb014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb014
            #add-point:ON CHANGE fmnb014 name="input.g.page4.fmnb014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb014_desc
            #add-point:BEFORE FIELD fmnb014_desc name="input.b.page4.fmnb014_desc"
            LET g_fmnb4_d[l_ac].fmnb014_desc = g_fmnb4_d[l_ac].fmnb014
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb014_desc
            
            #add-point:AFTER FIELD fmnb014_desc name="input.a.page4.fmnb014_desc"
            #WBS
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb014_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb014_desc != g_fmnb4_d_t.fmnb014_desc OR g_fmnb4_d_t.fmnb014_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb014 = g_fmnb4_d[l_ac].fmnb014_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb014 != g_fmnb4_d_t.fmnb014 OR g_fmnb4_d_t.fmnb014 IS NULL) THEN
                        CALL s_voucher_glaq028_chk(g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014)
                        IF NOT cl_null(g_errno) THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb014      = g_fmnb4_d_t.fmnb014
                           LET g_fmnb4_d[l_ac].fmnb014_desc = g_fmnb4_d_t.fmnb014_desc
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb014,g_fmnb4_d[l_ac].fmnb014_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb014 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb014_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb014,s_desc_get_pjbbl004_desc(g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014))
            LET g_fmnb4_d_t.fmnb014 = g_fmnb4_d[l_ac].fmnb014_desc
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb014,g_fmnb4_d[l_ac].fmnb014_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb014_desc
            #add-point:ON CHANGE fmnb014_desc name="input.g.page4.fmnb014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb015
            #add-point:BEFORE FIELD fmnb015 name="input.b.page4.fmnb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb015
            
            #add-point:AFTER FIELD fmnb015 name="input.a.page4.fmnb015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb015
            #add-point:ON CHANGE fmnb015 name="input.g.page4.fmnb015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb015_desc
            #add-point:BEFORE FIELD fmnb015_desc name="input.b.page4.fmnb015_desc"
            LET g_fmnb4_d[l_ac].fmnb015_desc = g_fmnb4_d[l_ac].fmnb015
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb015_desc
            
            #add-point:AFTER FIELD fmnb015_desc name="input.a.page4.fmnb015_desc"
            #經營方式
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb015_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb015_desc != g_fmnb4_d_t.fmnb015_desc OR g_fmnb4_d_t.fmnb015_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb015 = g_fmnb4_d[l_ac].fmnb015_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb015 != g_fmnb4_d_t.fmnb015 OR g_fmnb4_d_t.fmnb015 IS NULL) THEN
                        CALL s_voucher_glaq051_chk(g_fmnb4_d[l_ac].fmnb015) 
                        IF NOT g_sub_success THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb015      = g_fmnb4_d_t.fmnb015
                           LET g_fmnb4_d[l_ac].fmnb015_desc = g_fmnb4_d_t.fmnb015_desc
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb015,g_fmnb4_d[l_ac].fmnb015_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb015 = ''
            END IF
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb015 ,g_fmnb4_d[l_ac].fmnb015_desc
            LET g_fmnb4_d_t.fmnb015_desc = g_fmnb4_d[l_ac].fmnb015_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb015_desc
            #add-point:ON CHANGE fmnb015_desc name="input.g.page4.fmnb015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb016
            #add-point:BEFORE FIELD fmnb016 name="input.b.page4.fmnb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb016
            
            #add-point:AFTER FIELD fmnb016 name="input.a.page4.fmnb016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb016
            #add-point:ON CHANGE fmnb016 name="input.g.page4.fmnb016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb016_desc
            #add-point:BEFORE FIELD fmnb016_desc name="input.b.page4.fmnb016_desc"
            LET g_fmnb4_d[l_ac].fmnb016_desc = g_fmnb4_d[l_ac].fmnb016
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb016_desc
            
            #add-point:AFTER FIELD fmnb016_desc name="input.a.page4.fmnb016_desc"
            #渠道
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb016_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb016_desc != g_fmnb4_d_t.fmnb016_desc OR g_fmnb4_d_t.fmnb016_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb016 = g_fmnb4_d[l_ac].fmnb016_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     CALL s_voucher_glaq052_chk(g_fmnb4_d[l_ac].fmnb016)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_fmnb4_d[l_ac].fmnb016 = g_fmnb4_d_t.fmnb016
                        LET g_fmnb4_d[l_ac].fmnb016_desc = g_fmnb4_d_t.fmnb016_desc
                        DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb016,g_fmnb4_d[l_ac].fmnb016_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb016 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb016_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb016,s_desc_get_oojdl003_desc(g_fmnb4_d[l_ac].fmnb016))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb016,g_fmnb4_d[l_ac].fmnb016_desc
            LET g_fmnb4_d_t.fmnb016_desc = g_fmnb4_d[l_ac].fmnb016_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb016_desc
            #add-point:ON CHANGE fmnb016_desc name="input.g.page4.fmnb016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb017
            #add-point:BEFORE FIELD fmnb017 name="input.b.page4.fmnb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb017
            
            #add-point:AFTER FIELD fmnb017 name="input.a.page4.fmnb017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb017
            #add-point:ON CHANGE fmnb017 name="input.g.page4.fmnb017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb017_desc
            #add-point:BEFORE FIELD fmnb017_desc name="input.b.page4.fmnb017_desc"
            LET g_fmnb4_d[l_ac].fmnb017_desc = g_fmnb4_d[l_ac].fmnb017
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb017_desc
            
            #add-point:AFTER FIELD fmnb017_desc name="input.a.page4.fmnb017_desc"
            #品牌
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb017_desc) THEN
               IF ( g_fmnb4_d[l_ac].fmnb017_desc != g_fmnb4_d_t.fmnb017_desc OR g_fmnb4_d_t.fmnb017_desc IS NULL ) THEN
                  LET g_fmnb4_d[l_ac].fmnb017 = g_fmnb4_d[l_ac].fmnb017_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF NOT s_azzi650_chk_exist('2002',g_fmnb4_d[l_ac].fmnb017) THEN
                        LET g_fmnb4_d[l_ac].fmnb017      = g_fmnb4_d_t.fmnb017
                        LET g_fmnb4_d[l_ac].fmnb017_desc = g_fmnb4_d_t.fmnb017_desc
                        DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb017 ,g_fmnb4_d[l_ac].fmnb017_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb017 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb017_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb017,s_desc_get_acc_desc('2002',g_fmnb4_d[l_ac].fmnb017))      
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb017 ,g_fmnb4_d[l_ac].fmnb017_desc
            LET g_fmnb4_d_t.fmnb017_desc = g_fmnb4_d[l_ac].fmnb017_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb017_desc
            #add-point:ON CHANGE fmnb017_desc name="input.g.page4.fmnb017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb018
            #add-point:BEFORE FIELD fmnb018 name="input.b.page4.fmnb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb018
            
            #add-point:AFTER FIELD fmnb018 name="input.a.page4.fmnb018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb018
            #add-point:ON CHANGE fmnb018 name="input.g.page4.fmnb018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb018_desc
            #add-point:BEFORE FIELD fmnb018_desc name="input.b.page4.fmnb018_desc"
            #自由核算項一
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_fmnb4_d[l_ac].fmnb018_desc = g_fmnb4_d[l_ac].fmnb018
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb018_desc
            
            #add-point:AFTER FIELD fmnb018_desc name="input.a.page4.fmnb018_desc"
            #自由核算項一
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb018_desc) THEN
               IF (g_fmnb4_d[l_ac].fmnb018_desc != g_fmnb4_d_t.fmnb018_desc OR g_fmnb4_d_t.fmnb018_desc IS NULL) THEN
                  LET g_fmnb4_d[l_ac].fmnb018 = g_fmnb4_d[l_ac].fmnb018_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb018 != g_fmnb4_d_t.fmnb018 OR g_fmnb4_d_t.fmnb018 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_fmnb4_d[l_ac].fmnb018,g_glad.glad0172) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#27 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb018 = g_fmnb4_d_t.fmnb018
                           LET g_fmnb4_d[l_ac].fmnb018_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb018,s_fin_get_accting_desc(g_glad.glad0171,g_fmnb4_d[l_ac].fmnb018))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb018_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb018 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb018_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb018,s_fin_get_accting_desc(g_glad.glad0171,g_fmnb4_d[l_ac].fmnb018))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb018_desc
            LET g_fmnb4_d_t.fmnb018_desc = g_fmnb4_d[l_ac].fmnb018_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb018_desc
            #add-point:ON CHANGE fmnb018_desc name="input.g.page4.fmnb018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb019
            #add-point:BEFORE FIELD fmnb019 name="input.b.page4.fmnb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb019
            
            #add-point:AFTER FIELD fmnb019 name="input.a.page4.fmnb019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb019
            #add-point:ON CHANGE fmnb019 name="input.g.page4.fmnb019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb019_desc
            #add-point:BEFORE FIELD fmnb019_desc name="input.b.page4.fmnb019_desc"
            #自由核算項二
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_fmnb4_d[l_ac].fmnb019_desc = g_fmnb4_d[l_ac].fmnb019
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb019_desc
            
            #add-point:AFTER FIELD fmnb019_desc name="input.a.page4.fmnb019_desc"
            #自由核算項二
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb019_desc) THEN
               IF (g_fmnb4_d[l_ac].fmnb019_desc != g_fmnb4_d_t.fmnb019_desc OR g_fmnb4_d_t.fmnb019_desc IS NULL) THEN
                  LET g_fmnb4_d[l_ac].fmnb019 = g_fmnb4_d[l_ac].fmnb019_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb019 != g_fmnb4_d_t.fmnb019 OR g_fmnb4_d_t.fmnb019 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_fmnb4_d[l_ac].fmnb019,g_glad.glad0182) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#27 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb019 = g_fmnb4_d_t.fmnb019
                           LET g_fmnb4_d[l_ac].fmnb019_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb019,s_fin_get_accting_desc(g_glad.glad0181,g_fmnb4_d[l_ac].fmnb019))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb019_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb019 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb019_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb019,s_fin_get_accting_desc(g_glad.glad0181,g_fmnb4_d[l_ac].fmnb019))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb019_desc 
            LET g_fmnb4_d_t.fmnb019_desc = g_fmnb4_d[l_ac].fmnb019_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb019_desc
            #add-point:ON CHANGE fmnb019_desc name="input.g.page4.fmnb019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb020
            #add-point:BEFORE FIELD fmnb020 name="input.b.page4.fmnb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb020
            
            #add-point:AFTER FIELD fmnb020 name="input.a.page4.fmnb020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb020
            #add-point:ON CHANGE fmnb020 name="input.g.page4.fmnb020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb020_desc
            #add-point:BEFORE FIELD fmnb020_desc name="input.b.page4.fmnb020_desc"
            #自由核算項三
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_fmnb4_d[l_ac].fmnb020_desc = g_fmnb4_d[l_ac].fmnb020
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb020_desc
            
            #add-point:AFTER FIELD fmnb020_desc name="input.a.page4.fmnb020_desc"
            #自由核算項三
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb020_desc) THEN
               IF (g_fmnb4_d[l_ac].fmnb020_desc != g_fmnb4_d_t.fmnb020_desc OR g_fmnb4_d_t.fmnb020_desc IS NULL) THEN
                  LET g_fmnb4_d[l_ac].fmnb020 = g_fmnb4_d[l_ac].fmnb020_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb020 != g_fmnb4_d_t.fmnb020 OR g_fmnb4_d_t.fmnb020 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_fmnb4_d[l_ac].fmnb020,g_glad.glad0192) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#27 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb020 = g_fmnb4_d_t.fmnb020
                           LET g_fmnb4_d[l_ac].fmnb020_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb020,s_fin_get_accting_desc(g_glad.glad0191,g_fmnb4_d[l_ac].fmnb020))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb020_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb020 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb020_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb020,s_fin_get_accting_desc(g_glad.glad0191,g_fmnb4_d[l_ac].fmnb020))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb020_desc 
            LET g_fmnb4_d_t.fmnb020_desc = g_fmnb4_d[l_ac].fmnb020_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb020_desc
            #add-point:ON CHANGE fmnb020_desc name="input.g.page4.fmnb020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb021
            #add-point:BEFORE FIELD fmnb021 name="input.b.page4.fmnb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb021
            
            #add-point:AFTER FIELD fmnb021 name="input.a.page4.fmnb021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb021
            #add-point:ON CHANGE fmnb021 name="input.g.page4.fmnb021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb021_desc
            #add-point:BEFORE FIELD fmnb021_desc name="input.b.page4.fmnb021_desc"
            #自由核算項四
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_fmnb4_d[l_ac].fmnb021_desc = g_fmnb4_d[l_ac].fmnb021
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb021_desc
            
            #add-point:AFTER FIELD fmnb021_desc name="input.a.page4.fmnb021_desc"
            #自由核算項四
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb021_desc) THEN
               IF (g_fmnb4_d[l_ac].fmnb021_desc != g_fmnb4_d_t.fmnb021_desc OR g_fmnb4_d_t.fmnb021_desc IS NULL) THEN
                  LET g_fmnb4_d[l_ac].fmnb021 = g_fmnb4_d[l_ac].fmnb021_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb021 != g_fmnb4_d_t.fmnb021 OR g_fmnb4_d_t.fmnb021 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_fmnb4_d[l_ac].fmnb021,g_glad.glad0202) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#27 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb021 = g_fmnb4_d_t.fmnb021
                           LET g_fmnb4_d[l_ac].fmnb021_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb021,s_fin_get_accting_desc(g_glad.glad0201,g_fmnb4_d[l_ac].fmnb021))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb021_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb021 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb021_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb021,s_fin_get_accting_desc(g_glad.glad0201,g_fmnb4_d[l_ac].fmnb021))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb021_desc 
            LET g_fmnb4_d_t.fmnb021_desc = g_fmnb4_d[l_ac].fmnb021_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb021_desc
            #add-point:ON CHANGE fmnb021_desc name="input.g.page4.fmnb021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb022
            #add-point:BEFORE FIELD fmnb022 name="input.b.page4.fmnb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb022
            
            #add-point:AFTER FIELD fmnb022 name="input.a.page4.fmnb022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb022
            #add-point:ON CHANGE fmnb022 name="input.g.page4.fmnb022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb022_desc
            #add-point:BEFORE FIELD fmnb022_desc name="input.b.page4.fmnb022_desc"
            #自由核算項五
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_fmnb4_d[l_ac].fmnb022_desc = g_fmnb4_d[l_ac].fmnb022
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb022_desc
            
            #add-point:AFTER FIELD fmnb022_desc name="input.a.page4.fmnb022_desc"
            #自由核算項五
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb022_desc) THEN
               IF (g_fmnb4_d[l_ac].fmnb022_desc != g_fmnb4_d_t.fmnb022_desc OR g_fmnb4_d_t.fmnb022_desc IS NULL) THEN
                  LET g_fmnb4_d[l_ac].fmnb022 = g_fmnb4_d[l_ac].fmnb022_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb022 != g_fmnb4_d_t.fmnb022 OR g_fmnb4_d_t.fmnb022 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_fmnb4_d[l_ac].fmnb022,g_glad.glad0212) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#27 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb022 = g_fmnb4_d_t.fmnb022
                           LET g_fmnb4_d[l_ac].fmnb022_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb022,s_fin_get_accting_desc(g_glad.glad0211,g_fmnb4_d[l_ac].fmnb022))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb022_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb022 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb022_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb022,s_fin_get_accting_desc(g_glad.glad0211,g_fmnb4_d[l_ac].fmnb022))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb022_desc
            LET g_fmnb4_d_t.fmnb022_desc = g_fmnb4_d[l_ac].fmnb022_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb022_desc
            #add-point:ON CHANGE fmnb022_desc name="input.g.page4.fmnb022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb023
            #add-point:BEFORE FIELD fmnb023 name="input.b.page4.fmnb023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb023
            
            #add-point:AFTER FIELD fmnb023 name="input.a.page4.fmnb023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb023
            #add-point:ON CHANGE fmnb023 name="input.g.page4.fmnb023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb023_desc
            #add-point:BEFORE FIELD fmnb023_desc name="input.b.page4.fmnb023_desc"
            #自由核算項六
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_fmnb4_d[l_ac].fmnb023_desc = g_fmnb4_d[l_ac].fmnb023
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb023_desc
            
            #add-point:AFTER FIELD fmnb023_desc name="input.a.page4.fmnb023_desc"
            #自由核算項六
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb023_desc) THEN
               IF (g_fmnb4_d[l_ac].fmnb023_desc != g_fmnb4_d_t.fmnb023_desc OR g_fmnb4_d_t.fmnb023_desc IS NULL) THEN
                  LET g_fmnb4_d[l_ac].fmnb023 = g_fmnb4_d[l_ac].fmnb023_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb023 != g_fmnb4_d_t.fmnb023 OR g_fmnb4_d_t.fmnb023 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_fmnb4_d[l_ac].fmnb023,g_glad.glad0222) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#27 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb023 = g_fmnb4_d_t.fmnb023
                           LET g_fmnb4_d[l_ac].fmnb023_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb023,s_fin_get_accting_desc(g_glad.glad0221,g_fmnb4_d[l_ac].fmnb023))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb023_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb023 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb023_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb023,s_fin_get_accting_desc(g_glad.glad0221,g_fmnb4_d[l_ac].fmnb023))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb023_desc 
            LET g_fmnb4_d_t.fmnb023_desc = g_fmnb4_d[l_ac].fmnb023_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb023_desc
            #add-point:ON CHANGE fmnb023_desc name="input.g.page4.fmnb023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb024
            #add-point:BEFORE FIELD fmnb024 name="input.b.page4.fmnb024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb024
            
            #add-point:AFTER FIELD fmnb024 name="input.a.page4.fmnb024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb024
            #add-point:ON CHANGE fmnb024 name="input.g.page4.fmnb024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb024_desc
            #add-point:BEFORE FIELD fmnb024_desc name="input.b.page4.fmnb024_desc"
            #自由核算項七
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_fmnb4_d[l_ac].fmnb024_desc = g_fmnb4_d[l_ac].fmnb024
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb024_desc
            
            #add-point:AFTER FIELD fmnb024_desc name="input.a.page4.fmnb024_desc"
            #自由核算項七
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb024_desc) THEN
               IF (g_fmnb4_d[l_ac].fmnb024_desc != g_fmnb4_d_t.fmnb024_desc OR g_fmnb4_d_t.fmnb024_desc IS NULL) THEN
                  LET g_fmnb4_d[l_ac].fmnb024 = g_fmnb4_d[l_ac].fmnb024_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb024 != g_fmnb4_d_t.fmnb024 OR g_fmnb4_d_t.fmnb024 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0231,g_fmnb4_d[l_ac].fmnb024,g_glad.glad0232) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#27 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb024 = g_fmnb4_d_t.fmnb024
                           LET g_fmnb4_d[l_ac].fmnb024_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb024,s_fin_get_accting_desc(g_glad.glad0231,g_fmnb4_d[l_ac].fmnb024))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb024_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb024 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb024_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb024,s_fin_get_accting_desc(g_glad.glad0231,g_fmnb4_d[l_ac].fmnb024))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb024_desc 
            LET g_fmnb4_d_t.fmnb024_desc = g_fmnb4_d[l_ac].fmnb024_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb024_desc
            #add-point:ON CHANGE fmnb024_desc name="input.g.page4.fmnb024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb025
            #add-point:BEFORE FIELD fmnb025 name="input.b.page4.fmnb025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb025
            
            #add-point:AFTER FIELD fmnb025 name="input.a.page4.fmnb025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb025
            #add-point:ON CHANGE fmnb025 name="input.g.page4.fmnb025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb025_desc
            #add-point:BEFORE FIELD fmnb025_desc name="input.b.page4.fmnb025_desc"
            #自由核算項八
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_fmnb4_d[l_ac].fmnb025_desc = g_fmnb4_d[l_ac].fmnb025
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb025_desc
            
            #add-point:AFTER FIELD fmnb025_desc name="input.a.page4.fmnb025_desc"
            #自由核算項八
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb025_desc) THEN
               IF (g_fmnb4_d[l_ac].fmnb025_desc != g_fmnb4_d_t.fmnb025_desc OR g_fmnb4_d_t.fmnb025_desc IS NULL) THEN
                  LET g_fmnb4_d[l_ac].fmnb025 = g_fmnb4_d[l_ac].fmnb025_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb025 != g_fmnb4_d_t.fmnb025 OR g_fmnb4_d_t.fmnb025 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_fmnb4_d[l_ac].fmnb025,g_glad.glad0242) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#27 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb025 = g_fmnb4_d_t.fmnb025
                           LET g_fmnb4_d[l_ac].fmnb025_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb025,s_fin_get_accting_desc(g_glad.glad0241,g_fmnb4_d[l_ac].fmnb025))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb025_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb025 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb025_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb025,s_fin_get_accting_desc(g_glad.glad0241,g_fmnb4_d[l_ac].fmnb025))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb025_desc
            LET g_fmnb4_d_t.fmnb025_desc = g_fmnb4_d[l_ac].fmnb025_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb025_desc
            #add-point:ON CHANGE fmnb025_desc name="input.g.page4.fmnb025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb026
            #add-point:BEFORE FIELD fmnb026 name="input.b.page4.fmnb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb026
            
            #add-point:AFTER FIELD fmnb026 name="input.a.page4.fmnb026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb026
            #add-point:ON CHANGE fmnb026 name="input.g.page4.fmnb026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb026_desc
            #add-point:BEFORE FIELD fmnb026_desc name="input.b.page4.fmnb026_desc"
            #自由核算項九
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_fmnb4_d[l_ac].fmnb026_desc = g_fmnb4_d[l_ac].fmnb026
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb026_desc
            
            #add-point:AFTER FIELD fmnb026_desc name="input.a.page4.fmnb026_desc"
            #自由核算項九
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb026_desc) THEN
               IF (g_fmnb4_d[l_ac].fmnb026_desc != g_fmnb4_d_t.fmnb026_desc OR g_fmnb4_d_t.fmnb026_desc IS NULL) THEN
                  LET g_fmnb4_d[l_ac].fmnb026 = g_fmnb4_d[l_ac].fmnb026_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb026 != g_fmnb4_d_t.fmnb026 OR g_fmnb4_d_t.fmnb026 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_fmnb4_d[l_ac].fmnb026,g_glad.glad0252) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#27 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb026 = g_fmnb4_d_t.fmnb026
                           LET g_fmnb4_d[l_ac].fmnb026_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb026,s_fin_get_accting_desc(g_glad.glad0251,g_fmnb4_d[l_ac].fmnb026))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb026_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb026 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb026_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb026,s_fin_get_accting_desc(g_glad.glad0251,g_fmnb4_d[l_ac].fmnb026))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb026_desc
            LET g_fmnb4_d_t.fmnb026_desc = g_fmnb4_d[l_ac].fmnb026_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb026_desc
            #add-point:ON CHANGE fmnb026_desc name="input.g.page4.fmnb026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb027
            #add-point:BEFORE FIELD fmnb027 name="input.b.page4.fmnb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb027
            
            #add-point:AFTER FIELD fmnb027 name="input.a.page4.fmnb027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb027
            #add-point:ON CHANGE fmnb027 name="input.g.page4.fmnb027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmnb027_desc
            #add-point:BEFORE FIELD fmnb027_desc name="input.b.page4.fmnb027_desc"
            #自由核算項十
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_fmnb4_d[l_ac].fmnb027_desc = g_fmnb4_d[l_ac].fmnb027
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmnb027_desc
            
            #add-point:AFTER FIELD fmnb027_desc name="input.a.page4.fmnb027_desc"
            #自由核算項十
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb027_desc) THEN
               IF (g_fmnb4_d[l_ac].fmnb027_desc != g_fmnb4_d_t.fmnb027_desc OR g_fmnb4_d_t.fmnb027_desc IS NULL) THEN
                  LET g_fmnb4_d[l_ac].fmnb027 = g_fmnb4_d[l_ac].fmnb027_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmnb4_d[l_ac].fmnb027 != g_fmnb4_d_t.fmnb027 OR g_fmnb4_d_t.fmnb027 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_fmnb4_d[l_ac].fmnb027,g_glad.glad0262) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#27 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#27 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_fmnb4_d[l_ac].fmnb027 = g_fmnb4_d_t.fmnb027
                           LET g_fmnb4_d[l_ac].fmnb027_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb027,s_fin_get_accting_desc(g_glad.glad0261,g_fmnb4_d[l_ac].fmnb027))
                           DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb027_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmnb4_d[l_ac].fmnb027 = ''
            END IF
            LET g_fmnb4_d[l_ac].fmnb027_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb027,s_fin_get_accting_desc(g_glad.glad0261,g_fmnb4_d[l_ac].fmnb027))
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb027_desc
            LET g_fmnb4_d_t.fmnb027_desc = g_fmnb4_d[l_ac].fmnb027_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmnb027_desc
            #add-point:ON CHANGE fmnb027_desc name="input.g.page4.fmnb027_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.fmnb028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb028
            #add-point:ON ACTION controlp INFIELD fmnb028 name="input.c.page4.fmnb028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb028_desc
            #add-point:ON ACTION controlp INFIELD fmnb028_desc name="input.c.page4.fmnb028_desc"
            #重評價會計科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb028
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fmna_m.fmna001,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_fmnb4_d[l_ac].fmnb028 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb028_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb028_desc
            NEXT FIELD fmnb028_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb029
            #add-point:ON ACTION controlp INFIELD fmnb029 name="input.c.page4.fmnb029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb029_desc
            #add-point:ON ACTION controlp INFIELD fmnb029_desc name="input.c.page4.fmnb029_desc"
            #對方科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb029
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fmna_m.fmna001,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_fmnb4_d[l_ac].fmnb029 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb029_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb029_desc
            NEXT FIELD fmnb029_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb031
            #add-point:ON ACTION controlp INFIELD fmnb031 name="input.c.page4.fmnb031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb005
            #add-point:ON ACTION controlp INFIELD fmnb005 name="input.c.page4.fmnb005"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb005_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb005_desc
            #add-point:ON ACTION controlp INFIELD fmnb005_desc name="input.c.page4.fmnb005_desc"
            #交易客商
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb005
            LET g_qryparam.where = "pmaa002 IN ('2','3')"
            CALL q_pmaa001_25()        #160913-00017#2  ADD 
           # CALL q_pmaa001()      #160913-00017#2 mark          #呼叫開窗
            LET g_fmnb4_d[l_ac].fmnb005 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb005_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb005_desc
            NEXT FIELD fmnb005_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb006
            #add-point:ON ACTION controlp INFIELD fmnb006 name="input.c.page4.fmnb006"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb006_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb006_desc
            #add-point:ON ACTION controlp INFIELD fmnb006_desc name="input.c.page4.fmnb006_desc"
            #帳款客戶
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb006
            LET g_qryparam.arg1 = g_fmnb4_d[l_ac].fmnb005
            LET g_qryparam.arg2 = "1"
            CALL q_pmac002_1()
            LET g_fmnb4_d[l_ac].fmnb006 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb006_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb006,g_fmnb4_d[l_ac].fmnb006_desc
            NEXT FIELD fmnb006
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb007
            #add-point:ON ACTION controlp INFIELD fmnb007 name="input.c.page4.fmnb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb007_desc
            #add-point:ON ACTION controlp INFIELD fmnb007_desc name="input.c.page4.fmnb007_desc"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb007
            LET g_qryparam.arg1 = g_fmna_m.fmnadocdt    #應以單據日期
            CALL q_ooeg001_4()
            LET g_fmnb4_d[l_ac].fmnb007 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb007_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb007,g_fmnb4_d[l_ac].fmnb007_desc
            NEXT FIELD fmnb007_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb008
            #add-point:ON ACTION controlp INFIELD fmnb008 name="input.c.page4.fmnb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb008_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb008_desc
            #add-point:ON ACTION controlp INFIELD fmnb008_desc name="input.c.page4.fmnb008_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 =  g_fmnb4_d[l_ac].fmnb008
            LET g_qryparam.arg1 = g_fmna_m.fmnadocdt
            CALL q_ooeg001_5()
            LET g_fmnb4_d[l_ac].fmnb008 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb008_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb008_desc
            NEXT FIELD fmnb008_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb009
            #add-point:ON ACTION controlp INFIELD fmnb009 name="input.c.page4.fmnb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb009_desc
            #add-point:ON ACTION controlp INFIELD fmnb009_desc name="input.c.page4.fmnb009_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb009
            CALL q_oocq002_287()
            LET g_fmnb4_d[l_ac].fmnb009 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb009_desc = g_qryparam.return1
            DISPLAY BY NAME  g_fmnb4_d[l_ac].fmnb009,g_fmnb4_d[l_ac].fmnb009_desc
            NEXT FIELD fmnb009_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb010
            #add-point:ON ACTION controlp INFIELD fmnb010 name="input.c.page4.fmnb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb010_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb010_desc
            #add-point:ON ACTION controlp INFIELD fmnb010_desc name="input.c.page4.fmnb010_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb010
            CALL q_oocq002_281()
            LET g_fmnb4_d[l_ac].fmnb010 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb010_desc = g_qryparam.return1
            DISPLAY BY NAME  g_fmnb4_d[l_ac].fmnb010,g_fmnb4_d[l_ac].fmnb010_desc
            NEXT FIELD fmnb010_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb011
            #add-point:ON ACTION controlp INFIELD fmnb011 name="input.c.page4.fmnb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb011_desc
            #add-point:ON ACTION controlp INFIELD fmnb011_desc name="input.c.page4.fmnb011_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb011
            CALL q_rtax001()
            LET g_fmnb4_d[l_ac].fmnb011 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb011_desc = g_qryparam.return1
            DISPLAY BY NAME  g_fmnb4_d[l_ac].fmnb011,g_fmnb4_d[l_ac].fmnb011_desc
            NEXT FIELD fmnb011_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb012
            #add-point:ON ACTION controlp INFIELD fmnb012 name="input.c.page4.fmnb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb012_desc
            #add-point:ON ACTION controlp INFIELD fmnb012_desc name="input.c.page4.fmnb012_desc"
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb012
            CALL q_ooag001_8()
            LET g_fmnb4_d[l_ac].fmnb012 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb012_desc = g_qryparam.return1 
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb012,g_fmnb4_d[l_ac].fmnb012_desc
            NEXT FIELD fmnb012_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb013
            #add-point:ON ACTION controlp INFIELD fmnb013 name="input.c.page4.fmnb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb013_desc
            #add-point:ON ACTION controlp INFIELD fmnb013_desc name="input.c.page4.fmnb013_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb013
            CALL q_pjba001()
            LET g_fmnb4_d[l_ac].fmnb013 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb013_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb013_desc
            NEXT FIELD fmnb013_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb014
            #add-point:ON ACTION controlp INFIELD fmnb014 name="input.c.page4.fmnb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb014_desc
            #add-point:ON ACTION controlp INFIELD fmnb014_desc name="input.c.page4.fmnb014_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb014
            #150302 add---
            IF NOT cl_null(g_fmnb4_d[l_ac].fmnb013) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_fmnb4_d[l_ac].fmnb013,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            #150302 add end ---
            CALL q_pjbb002()
            LET g_fmnb4_d[l_ac].fmnb014 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb014_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb014,g_fmnb4_d[l_ac].fmnb014_desc
            NEXT FIELD fmnb014_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb015
            #add-point:ON ACTION controlp INFIELD fmnb015 name="input.c.page4.fmnb015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb015_desc
            #add-point:ON ACTION controlp INFIELD fmnb015_desc name="input.c.page4.fmnb015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb016
            #add-point:ON ACTION controlp INFIELD fmnb016 name="input.c.page4.fmnb016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb016_desc
            #add-point:ON ACTION controlp INFIELD fmnb016_desc name="input.c.page4.fmnb016_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb016
            CALL q_oojd001_2()
            LET g_fmnb4_d[l_ac].fmnb016 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb016_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb016,g_fmnb4_d[l_ac].fmnb016_desc
            NEXT FIELD fmnb016_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb017
            #add-point:ON ACTION controlp INFIELD fmnb017 name="input.c.page4.fmnb017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb017_desc
            #add-point:ON ACTION controlp INFIELD fmnb017_desc name="input.c.page4.fmnb017_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb017
            CALL q_oocq002_2002()
            LET g_fmnb4_d[l_ac].fmnb017 = g_qryparam.return1
            LET g_fmnb4_d[l_ac].fmnb017_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb017,g_fmnb4_d[l_ac].fmnb017_desc
            NEXT FIELD fmnb017_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb018
            #add-point:ON ACTION controlp INFIELD fmnb018 name="input.c.page4.fmnb018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb018_desc
            #add-point:ON ACTION controlp INFIELD fmnb018_desc name="input.c.page4.fmnb018_desc"
            #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb018
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmnb4_d[l_ac].fmnb018 = g_qryparam.return1
               LET g_fmnb4_d[l_ac].fmnb018_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb018,g_fmnb4_d[l_ac].fmnb018_desc
               NEXT FIELD fmnb018_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb019
            #add-point:ON ACTION controlp INFIELD fmnb019 name="input.c.page4.fmnb019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb019_desc
            #add-point:ON ACTION controlp INFIELD fmnb019_desc name="input.c.page4.fmnb019_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb019
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)
               LET g_fmnb4_d[l_ac].fmnb019 = g_qryparam.return1
               LET g_fmnb4_d[l_ac].fmnb019_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb019,g_fmnb4_d[l_ac].fmnb019_desc
               NEXT FIELD fmnb019_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb020
            #add-point:ON ACTION controlp INFIELD fmnb020 name="input.c.page4.fmnb020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb020_desc
            #add-point:ON ACTION controlp INFIELD fmnb020_desc name="input.c.page4.fmnb020_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb020
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmnb4_d[l_ac].fmnb020 = g_qryparam.return1
               LET g_fmnb4_d[l_ac].fmnb020_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb020,g_fmnb4_d[l_ac].fmnb020_desc
               NEXT FIELD fmnb020_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb021
            #add-point:ON ACTION controlp INFIELD fmnb021 name="input.c.page4.fmnb021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb021_desc
            #add-point:ON ACTION controlp INFIELD fmnb021_desc name="input.c.page4.fmnb021_desc"
            #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb021
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmnb4_d[l_ac].fmnb021 = g_qryparam.return1
               LET g_fmnb4_d[l_ac].fmnb021_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb021,g_fmnb4_d[l_ac].fmnb021_desc
               NEXT FIELD fmnb021_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb022
            #add-point:ON ACTION controlp INFIELD fmnb022 name="input.c.page4.fmnb022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb022_desc
            #add-point:ON ACTION controlp INFIELD fmnb022_desc name="input.c.page4.fmnb022_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb022
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmnb4_d[l_ac].fmnb022 = g_qryparam.return1
               LET g_fmnb4_d[l_ac].fmnb022_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb022,g_fmnb4_d[l_ac].fmnb022_desc
               NEXT FIELD fmnb022_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb023
            #add-point:ON ACTION controlp INFIELD fmnb023 name="input.c.page4.fmnb023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb023_desc
            #add-point:ON ACTION controlp INFIELD fmnb023_desc name="input.c.page4.fmnb023_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb023
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmnb4_d[l_ac].fmnb023 = g_qryparam.return1
               LET g_fmnb4_d[l_ac].fmnb023_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb023,g_fmnb4_d[l_ac].fmnb023_desc 
               NEXT FIELD fmnb023_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb024
            #add-point:ON ACTION controlp INFIELD fmnb024 name="input.c.page4.fmnb024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb024_desc
            #add-point:ON ACTION controlp INFIELD fmnb024_desc name="input.c.page4.fmnb024_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb024
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmnb4_d[l_ac].fmnb024 = g_qryparam.return1
               LET g_fmnb4_d[l_ac].fmnb024_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb024,g_fmnb4_d[l_ac].fmnb024_desc
               NEXT FIELD fmnb024_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb025
            #add-point:ON ACTION controlp INFIELD fmnb025 name="input.c.page4.fmnb025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb025_desc
            #add-point:ON ACTION controlp INFIELD fmnb025_desc name="input.c.page4.fmnb025_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb025
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmnb4_d[l_ac].fmnb025 = g_qryparam.return1
               LET g_fmnb4_d[l_ac].fmnb025_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb025,g_fmnb4_d[l_ac].fmnb025_desc
               NEXT FIELD fmnb025_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb026
            #add-point:ON ACTION controlp INFIELD fmnb026 name="input.c.page4.fmnb026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb026_desc
            #add-point:ON ACTION controlp INFIELD fmnb026_desc name="input.c.page4.fmnb026_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb026
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmnb4_d[l_ac].fmnb026 = g_qryparam.return1
               LET g_fmnb4_d[l_ac].fmnb026_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb026,g_fmnb4_d[l_ac].fmnb026_desc
               NEXT FIELD fmnb026_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb027
            #add-point:ON ACTION controlp INFIELD fmnb027 name="input.c.page4.fmnb027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmnb027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmnb027_desc
            #add-point:ON ACTION controlp INFIELD fmnb027_desc name="input.c.page4.fmnb027_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmnb4_d[l_ac].fmnb027
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmnb4_d[l_ac].fmnb027 = g_qryparam.return1
               LET g_fmnb4_d[l_ac].fmnb027_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmnb4_d[l_ac].fmnb027,g_fmnb4_d[l_ac].fmnb027_desc
               NEXT FIELD fmnb027_desc
            END IF
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmnb4_d[l_ac].* = g_fmnb4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt570_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt570_unlock_b("fmnb_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            IF g_glaa.glaa121 = 'Y' THEN
               CALL s_transaction_begin()
               CALL s_pre_voucher_ins('FM','M10',g_fmna_m.fmna001,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt,'3')
                    RETURNING g_sub_success
               IF g_sub_success THEN 
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
               END IF
            END IF
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmnb_d[li_reproduce_target].* = g_fmnb_d[li_reproduce].*
               LET g_fmnb2_d[li_reproduce_target].* = g_fmnb2_d[li_reproduce].*
               LET g_fmnb3_d[li_reproduce_target].* = g_fmnb3_d[li_reproduce].*
               LET g_fmnb4_d[li_reproduce_target].* = g_fmnb4_d[li_reproduce].*
 
               LET g_fmnb4_d[li_reproduce_target].fmnbseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmnb4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmnb4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="afmt570.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2','3','4',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue(""))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD fmnadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fmnbseq
               WHEN "s_detail2"
                  NEXT FIELD fmnbseq_2
               WHEN "s_detail3"
                  NEXT FIELD fmnbseq_3
               WHEN "s_detail4"
                  NEXT FIELD fmnbseq_4
 
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
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afmt570.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afmt570_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afmt570_b_fill() #單身填充
      CALL afmt570_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt570_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   LET g_fmna_m.fmnasite_desc = s_desc_get_department_desc(g_fmna_m.fmnasite)   #帳務中心
   LET g_fmna_m.fmna001_desc  = s_desc_get_ld_desc(g_fmna_m.fmna001)            #帳套
   CALL afmt570_set_ld_info(g_fmna_m.fmna001) RETURNING g_fmna_m.fmnacomp
   LET g_fmna_m.fmnacomp_desc = s_desc_get_department_desc(g_fmna_m.fmnacomp)   #法人
   LET g_fmna_m.fmnadocno_desc= s_aooi200_fin_get_slip_desc(g_fmna_m.fmnadocno) #單別
   LET g_fmna_m.fmna006_desc  = s_desc_get_person_desc(g_fmna_m.fmna006)        #帳務人員
   #end add-point
   
   #遮罩相關處理
   LET g_fmna_m_mask_o.* =  g_fmna_m.*
   CALL afmt570_fmna_t_mask()
   LET g_fmna_m_mask_n.* =  g_fmna_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmna_m.fmnasite,g_fmna_m.fmnasite_desc,g_fmna_m.fmna001,g_fmna_m.fmna001_desc,g_fmna_m.fmnacomp, 
       g_fmna_m.fmnacomp_desc,g_fmna_m.fmnadocno,g_fmna_m.fmnadocno_desc,g_fmna_m.fmnadocdt,g_fmna_m.fmna006, 
       g_fmna_m.fmna006_desc,g_fmna_m.fmna004,g_fmna_m.fmna002,g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus, 
       g_fmna_m.fmnaownid,g_fmna_m.fmnaownid_desc,g_fmna_m.fmnaowndp,g_fmna_m.fmnaowndp_desc,g_fmna_m.fmnacrtid, 
       g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdp_desc,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid, 
       g_fmna_m.fmnamodid_desc,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid,g_fmna_m.fmnacnfid_desc,g_fmna_m.fmnacnfdt, 
       g_fmna_m.fmnapstid,g_fmna_m.fmnapstid_desc,g_fmna_m.fmnapstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmna_m.fmnastus 
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
   FOR l_ac = 1 TO g_fmnb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_fmnb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fmnb3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fmnb4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afmt570_detail_show()
 
   #add-point:show段之後 name="show.after"
 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afmt570_detail_show()
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
 
{<section id="afmt570.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt570_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fmna_t.fmnadocno 
   DEFINE l_oldno     LIKE fmna_t.fmnadocno 
 
   DEFINE l_master    RECORD LIKE fmna_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fmnb_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_fmna_m.fmnadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_fmnadocno_t = g_fmna_m.fmnadocno
 
    
   LET g_fmna_m.fmnadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmna_m.fmnaownid = g_user
      LET g_fmna_m.fmnaowndp = g_dept
      LET g_fmna_m.fmnacrtid = g_user
      LET g_fmna_m.fmnacrtdp = g_dept 
      LET g_fmna_m.fmnacrtdt = cl_get_current()
      LET g_fmna_m.fmnamodid = g_user
      LET g_fmna_m.fmnamoddt = cl_get_current()
      LET g_fmna_m.fmnastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmna_m.fmnastus 
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
      LET g_fmna_m.fmnadocno_desc = ''
   DISPLAY BY NAME g_fmna_m.fmnadocno_desc
 
   
   CALL afmt570_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fmna_m.* TO NULL
      INITIALIZE g_fmnb_d TO NULL
      INITIALIZE g_fmnb2_d TO NULL
      INITIALIZE g_fmnb3_d TO NULL
      INITIALIZE g_fmnb4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afmt570_show()
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
   CALL afmt570_set_act_visible()   
   CALL afmt570_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmnadocno_t = g_fmna_m.fmnadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmnaent = " ||g_enterprise|| " AND",
                      " fmnadocno = '", g_fmna_m.fmnadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt570_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afmt570_idx_chk()
   
   LET g_data_owner = g_fmna_m.fmnaownid      
   LET g_data_dept  = g_fmna_m.fmnaowndp
   
   #功能已完成,通報訊息中心
   CALL afmt570_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt570.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afmt570_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fmnb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afmt570_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmnb_t
    WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmnadocno_t
 
    INTO TEMP afmt570_detail
 
   #將key修正為調整後   
   UPDATE afmt570_detail 
      #更新key欄位
      SET fmnbdocno = g_fmna_m.fmnadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fmnb_t SELECT * FROM afmt570_detail
   
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
   DROP TABLE afmt570_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fmnadocno_t = g_fmna_m.fmnadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afmt570_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_cnt                 LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_fmna_m.fmnadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afmt570_cl USING g_enterprise,g_fmna_m.fmnadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt570_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt570_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt570_master_referesh USING g_fmna_m.fmnadocno INTO g_fmna_m.fmnasite,g_fmna_m.fmna001, 
       g_fmna_m.fmnacomp,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt,g_fmna_m.fmna006,g_fmna_m.fmna004,g_fmna_m.fmna002, 
       g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus,g_fmna_m.fmnaownid,g_fmna_m.fmnaowndp,g_fmna_m.fmnacrtid, 
       g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid, 
       g_fmna_m.fmnacnfdt,g_fmna_m.fmnapstid,g_fmna_m.fmnapstdt,g_fmna_m.fmnaownid_desc,g_fmna_m.fmnaowndp_desc, 
       g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp_desc,g_fmna_m.fmnamodid_desc,g_fmna_m.fmnacnfid_desc, 
       g_fmna_m.fmnapstid_desc
   
   
   #檢查是否允許此動作
   IF NOT afmt570_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmna_m_mask_o.* =  g_fmna_m.*
   CALL afmt570_fmna_t_mask()
   LET g_fmna_m_mask_n.* =  g_fmna_m.*
   
   CALL afmt570_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt570_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_fmnadocno_t = g_fmna_m.fmnadocno
 
 
      DELETE FROM fmna_t
       WHERE fmnaent = g_enterprise AND fmnadocno = g_fmna_m.fmnadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_fmna_m.fmnadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
       IF NOT s_aooi200_fin_del_docno(g_fmna_m.fmna001,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #刪除底稿
      IF g_glaa.glaa121 = 'Y' THEN
         CALL s_pre_voucher_del('FM','M10',g_fmna_m.fmna001,g_fmna_m.fmnadocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_fmna_m.fmnadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = FALSE
            CALL cl_err()
         END IF
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM fmnb_t
       WHERE fmnbent = g_enterprise AND fmnbdocno = g_fmna_m.fmnadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fmna_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afmt570_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fmnb_d.clear() 
      CALL g_fmnb2_d.clear()       
      CALL g_fmnb3_d.clear()       
      CALL g_fmnb4_d.clear()       
 
     
      CALL afmt570_ui_browser_refresh()  
      #CALL afmt570_ui_headershow()  
      #CALL afmt570_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afmt570_browser_fill("")
         CALL afmt570_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afmt570_cl
 
   #功能已完成,通報訊息中心
   CALL afmt570_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afmt570.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmt570_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #160129-00015#11 add(S)
   #多語言SQL
   DEFINE l_get_sql   RECORD
          fmnb028     STRING,
          fmnb029     STRING,
          fmnb005     STRING,
          fmnb006     STRING,
          fmnb007     STRING,
          fmnb008     STRING,
          fmnb009     STRING,
          fmnb010     STRING,
          fmnb011     STRING,
          fmnb012     STRING,
          fmnb013     STRING,
          fmnb014     STRING,
          fmnb016     STRING,
          fmnb017     STRING
                      END RECORD
   #160129-00015#11 add(E)
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fmnb_d.clear()
   CALL g_fmnb2_d.clear()
   CALL g_fmnb3_d.clear()
   CALL g_fmnb4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
   
   #判斷是否填充
   IF afmt570_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmnbseq,fmnb030,fmnb033,fmnb002,fmnb003,fmnb004,fmnb032,fmnb100, 
             fmnb101,fmnb102,fmnb103,fmnb113,fmnb114,fmnb115,fmnb116,fmnbseq,fmnb121,fmnb122,fmnb123, 
             fmnb124,fmnb125,fmnb126,fmnbseq,fmnb131,fmnb132,fmnb133,fmnb134,fmnb135,fmnb136,fmnbseq, 
             fmnb028,fmnb029,fmnb031,fmnb005,fmnb006,fmnb007,fmnb008,fmnb009,fmnb010,fmnb011,fmnb012, 
             fmnb013,fmnb014,fmnb015,fmnb016,fmnb017,fmnb018,fmnb019,fmnb020,fmnb021,fmnb022,fmnb023, 
             fmnb024,fmnb025,fmnb026,fmnb027  FROM fmnb_t",   
                     " INNER JOIN fmna_t ON fmnaent = " ||g_enterprise|| " AND fmnadocno = fmnbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE fmnbent=? AND fmnbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmnb_t.fmnbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt570_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afmt570_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fmna_m.fmnadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fmna_m.fmnadocno INTO g_fmnb_d[l_ac].fmnbseq,g_fmnb_d[l_ac].fmnb030, 
          g_fmnb_d[l_ac].fmnb033,g_fmnb_d[l_ac].fmnb002,g_fmnb_d[l_ac].fmnb003,g_fmnb_d[l_ac].fmnb004, 
          g_fmnb_d[l_ac].fmnb032,g_fmnb_d[l_ac].fmnb100,g_fmnb_d[l_ac].fmnb101,g_fmnb_d[l_ac].fmnb102, 
          g_fmnb_d[l_ac].fmnb103,g_fmnb_d[l_ac].fmnb113,g_fmnb_d[l_ac].fmnb114,g_fmnb_d[l_ac].fmnb115, 
          g_fmnb_d[l_ac].fmnb116,g_fmnb2_d[l_ac].fmnbseq,g_fmnb2_d[l_ac].fmnb121,g_fmnb2_d[l_ac].fmnb122, 
          g_fmnb2_d[l_ac].fmnb123,g_fmnb2_d[l_ac].fmnb124,g_fmnb2_d[l_ac].fmnb125,g_fmnb2_d[l_ac].fmnb126, 
          g_fmnb3_d[l_ac].fmnbseq,g_fmnb3_d[l_ac].fmnb131,g_fmnb3_d[l_ac].fmnb132,g_fmnb3_d[l_ac].fmnb133, 
          g_fmnb3_d[l_ac].fmnb134,g_fmnb3_d[l_ac].fmnb135,g_fmnb3_d[l_ac].fmnb136,g_fmnb4_d[l_ac].fmnbseq, 
          g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb031,g_fmnb4_d[l_ac].fmnb005, 
          g_fmnb4_d[l_ac].fmnb006,g_fmnb4_d[l_ac].fmnb007,g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb009, 
          g_fmnb4_d[l_ac].fmnb010,g_fmnb4_d[l_ac].fmnb011,g_fmnb4_d[l_ac].fmnb012,g_fmnb4_d[l_ac].fmnb013, 
          g_fmnb4_d[l_ac].fmnb014,g_fmnb4_d[l_ac].fmnb015,g_fmnb4_d[l_ac].fmnb016,g_fmnb4_d[l_ac].fmnb017, 
          g_fmnb4_d[l_ac].fmnb018,g_fmnb4_d[l_ac].fmnb019,g_fmnb4_d[l_ac].fmnb020,g_fmnb4_d[l_ac].fmnb021, 
          g_fmnb4_d[l_ac].fmnb022,g_fmnb4_d[l_ac].fmnb023,g_fmnb4_d[l_ac].fmnb024,g_fmnb4_d[l_ac].fmnb025, 
          g_fmnb4_d[l_ac].fmnb026,g_fmnb4_d[l_ac].fmnb027   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #固定核算項
         #重評價會計科目
         LET g_fmnb4_d[l_ac].fmnb028_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb028,s_desc_get_account_desc(g_fmna_m.fmna001,g_fmnb4_d[l_ac].fmnb028))
         #對方科目
         LET g_fmnb4_d[l_ac].fmnb029_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb029,s_desc_get_account_desc(g_fmna_m.fmna001,g_fmnb4_d[l_ac].fmnb029))
         #交易客商
         LET g_fmnb4_d[l_ac].fmnb005_desc  = s_desc_show1(g_fmnb4_d[l_ac].fmnb005,s_desc_get_trading_partner_abbr_desc(g_fmnb4_d[l_ac].fmnb005))
         #帳款客戶
         LET g_fmnb4_d[l_ac].fmnb006_desc  = s_desc_show1(g_fmnb4_d[l_ac].fmnb006,s_desc_get_trading_partner_abbr_desc(g_fmnb4_d[l_ac].fmnb006))

         LET g_fmnb4_d[l_ac].fmnb007_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb007,s_desc_get_department_desc(g_fmnb4_d[l_ac].fmnb007))
         LET g_fmnb4_d[l_ac].fmnb008_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb008,s_desc_get_department_desc(g_fmnb4_d[l_ac].fmnb008))
         LET g_fmnb4_d[l_ac].fmnb009_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb009,s_desc_get_acc_desc('287',g_fmnb4_d[l_ac].fmnb009))
         LET g_fmnb4_d[l_ac].fmnb010_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb010,s_desc_get_acc_desc('281',g_fmnb4_d[l_ac].fmnb010))
         LET g_fmnb4_d[l_ac].fmnb011_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb011,s_desc_get_rtaxl003_desc(g_fmnb4_d[l_ac].fmnb011))
         LET g_fmnb4_d[l_ac].fmnb012_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb012,s_desc_get_person_desc(g_fmnb4_d[l_ac].fmnb012))
         LET g_fmnb4_d[l_ac].fmnb013_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb013,s_desc_get_project_desc(g_fmnb4_d[l_ac].fmnb013))
         LET g_fmnb4_d[l_ac].fmnb014_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb014,s_desc_get_pjbbl004_desc(g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014))
         LET g_fmnb4_d[l_ac].fmnb015_desc = g_fmnb4_d[l_ac].fmnb015
         LET g_fmnb4_d[l_ac].fmnb016_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb016,s_desc_get_oojdl003_desc(g_fmnb4_d[l_ac].fmnb016))
         LET g_fmnb4_d[l_ac].fmnb017_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb017,s_desc_get_acc_desc('2002',g_fmnb4_d[l_ac].fmnb017))

         #自由核算項
         CALL s_fin_sel_glad(g_fmna_m.fmna001,g_fmnb4_d[l_ac].fmnb028,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
              RETURNING g_errno,g_glad.*
         IF NOT cl_null(g_fmnb4_d[l_ac].fmnb018) THEN
            LET g_fmnb4_d[l_ac].fmnb018_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb018,s_fin_get_accting_desc(g_glad.glad0171,g_fmnb4_d[l_ac].fmnb018))
         END IF
         IF NOT cl_null(g_fmnb4_d[l_ac].fmnb019) THEN
            LET g_fmnb4_d[l_ac].fmnb019_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb019,s_fin_get_accting_desc(g_glad.glad0181,g_fmnb4_d[l_ac].fmnb019))
         END IF
         IF NOT cl_null(g_fmnb4_d[l_ac].fmnb020) THEN
            LET g_fmnb4_d[l_ac].fmnb020_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb020,s_fin_get_accting_desc(g_glad.glad0191,g_fmnb4_d[l_ac].fmnb020))
         END IF
         IF NOT cl_null(g_fmnb4_d[l_ac].fmnb021) THEN
            LET g_fmnb4_d[l_ac].fmnb021_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb021,s_fin_get_accting_desc(g_glad.glad0201,g_fmnb4_d[l_ac].fmnb021))
         END IF
         IF NOT cl_null(g_fmnb4_d[l_ac].fmnb022) THEN
            LET g_fmnb4_d[l_ac].fmnb022_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb022,s_fin_get_accting_desc(g_glad.glad0211,g_fmnb4_d[l_ac].fmnb022))
         END IF
         IF NOT cl_null(g_fmnb4_d[l_ac].fmnb023) THEN
            LET g_fmnb4_d[l_ac].fmnb023_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb023,s_fin_get_accting_desc(g_glad.glad0221,g_fmnb4_d[l_ac].fmnb023))
         END IF
         IF NOT cl_null(g_fmnb4_d[l_ac].fmnb024) THEN
            LET g_fmnb4_d[l_ac].fmnb024_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb024,s_fin_get_accting_desc(g_glad.glad0231,g_fmnb4_d[l_ac].fmnb024))
         END IF
         IF NOT cl_null(g_fmnb4_d[l_ac].fmnb025) THEN
            LET g_fmnb4_d[l_ac].fmnb025_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb025,s_fin_get_accting_desc(g_glad.glad0241,g_fmnb4_d[l_ac].fmnb025))
         END IF
         IF NOT cl_null(g_fmnb4_d[l_ac].fmnb026) THEN
            LET g_fmnb4_d[l_ac].fmnb026_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb026,s_fin_get_accting_desc(g_glad.glad0251,g_fmnb4_d[l_ac].fmnb026))
         END IF
         IF NOT cl_null(g_fmnb4_d[l_ac].fmnb027) THEN
            LET g_fmnb4_d[l_ac].fmnb027_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb027,s_fin_get_accting_desc(g_glad.glad0261,g_fmnb4_d[l_ac].fmnb027))
         END IF
         #151217-00011#1--s
         #取得投資購買單號摘要顯示
         SELECT fmmj027 INTO g_fmnb_d[l_ac].l_fmmj027
           FROM fmmj_t
          WHERE fmmjent   = g_enterprise
            AND fmmjdocno = g_fmnb_d[l_ac].fmnb033
         #151217-00011#1--e
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
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   #160129-00015#11 add(S)
   
   #重評價會計科目
   CALL s_fin_get_account_sql('ta1','ta2','fmnbent','fmna001','fmnb028') RETURNING l_get_sql.fmnb028
   #對方科目
   CALL s_fin_get_account_sql('ta3','ta4','fmnbent','fmna001','fmnb029') RETURNING l_get_sql.fmnb029
   #帳款對象
   CALL s_fin_get_trading_partner_abbr_sql('ta5','fmnbent','fmnb005') RETURNING l_get_sql.fmnb005
   #收款對象
   CALL s_fin_get_trading_partner_abbr_sql('ta6','fmnbent','fmnb006') RETURNING l_get_sql.fmnb006
   #部門
   CALL s_fin_get_department_sql('ta7','fmnbent','fmnb007') RETURNING l_get_sql.fmnb007
   #利潤中心
   CALL s_fin_get_department_sql('ta8','fmnbent','fmnb008') RETURNING l_get_sql.fmnb008
   #區域
   CALL s_fin_get_acc_sql('ta9','fmnbent','287','fmnb009') RETURNING l_get_sql.fmnb009
   #客群
   CALL s_fin_get_acc_sql('ta10','fmnbent','281','fmnb010') RETURNING l_get_sql.fmnb010
   #產品類別
   CALL s_fin_get_rtaxl003_sql('ta11','fmnbent','fmnb011') RETURNING l_get_sql.fmnb011
   #人員
   CALL s_fin_get_person_sql('ta12','fmnbent','fmnb012') RETURNING l_get_sql.fmnb012
   #專案代號
   CALL s_fin_get_project_sql('ta13','fmnbent','fmnb013') RETURNING l_get_sql.fmnb013
   #WBS編號
   CALL s_fin_get_wbs_sql('ta14','fmnbent','fmnb013','fmnb014') RETURNING l_get_sql.fmnb014
   #渠道
   CALL s_fin_get_oojdl003_sql('ta15','fmnbent','fmnb016') RETURNING l_get_sql.fmnb016
   #品牌
   CALL s_fin_get_acc_sql('ta16','fmnbent','2002','fmnb016') RETURNING l_get_sql.fmnb017
   
   LET g_sql = "SELECT  DISTINCT fmnbseq,fmnb030,fmnb033,fmnb002,fmnb003,fmnb004,fmnb032,fmnb100,", 
               "                 fmnb101,fmnb102,fmnb103,fmnb113,fmnb114,fmnb115,fmnb116,fmnbseq,fmnb121,fmnb122,fmnb123,",
               "                 fmnb124,fmnb125,fmnb126,fmnbseq,fmnb131,fmnb132,fmnb133,fmnb134,fmnb135,fmnb136,fmnbseq,", 
               "                 fmnb028,fmnb029,fmnb031,fmnb005,fmnb006,fmnb007,fmnb008,fmnb009,fmnb010,fmnb011,fmnb012,", 
               "                 fmnb013,fmnb014,fmnb015,fmnb016,fmnb017,fmnb018,fmnb019,fmnb020,fmnb021,fmnb022,fmnb023,", 
               "                 fmnb024,fmnb025,fmnb026,fmnb027,",
   			                     l_get_sql.fmnb028,",",l_get_sql.fmnb029,",",l_get_sql.fmnb005,",",l_get_sql.fmnb006,",",
   							         l_get_sql.fmnb007,",",l_get_sql.fmnb008,",",l_get_sql.fmnb009,",",l_get_sql.fmnb010,",",
   							         l_get_sql.fmnb011,",",l_get_sql.fmnb012,",",l_get_sql.fmnb013,",",l_get_sql.fmnb014,",",
   							         l_get_sql.fmnb016,",",l_get_sql.fmnb017,
   			   "  FROM fmnb_t",   
               " INNER JOIN fmna_t ON fmnadocno = fmnbdocno ",
               " WHERE fmnbent=? AND fmnbdocno=?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
   END IF
   
   #子單身的WC     
   
   LET g_sql = g_sql, " ORDER BY fmnb_t.fmnbseq"
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afmt570_pb1 FROM g_sql
   DECLARE b_fill_cs1 CURSOR FOR afmt570_pb1
         
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN b_fill_cs1 USING g_enterprise,g_fmna_m.fmnadocno
                                            
   FOREACH b_fill_cs1 INTO g_fmnb_d[l_ac].fmnbseq, g_fmnb_d[l_ac].fmnb030, g_fmnb_d[l_ac].fmnb033, g_fmnb_d[l_ac].fmnb002, 
                           g_fmnb_d[l_ac].fmnb003, g_fmnb_d[l_ac].fmnb004, g_fmnb_d[l_ac].fmnb032, g_fmnb_d[l_ac].fmnb100, 
                           g_fmnb_d[l_ac].fmnb101, g_fmnb_d[l_ac].fmnb102, g_fmnb_d[l_ac].fmnb103, g_fmnb_d[l_ac].fmnb113, 
                           g_fmnb_d[l_ac].fmnb114, g_fmnb_d[l_ac].fmnb115, g_fmnb_d[l_ac].fmnb116, g_fmnb2_d[l_ac].fmnbseq, 
                           g_fmnb2_d[l_ac].fmnb121,g_fmnb2_d[l_ac].fmnb122,g_fmnb2_d[l_ac].fmnb123,g_fmnb2_d[l_ac].fmnb124, 
                           g_fmnb2_d[l_ac].fmnb125,g_fmnb2_d[l_ac].fmnb126,g_fmnb3_d[l_ac].fmnbseq,g_fmnb3_d[l_ac].fmnb131, 
                           g_fmnb3_d[l_ac].fmnb132,g_fmnb3_d[l_ac].fmnb133,g_fmnb3_d[l_ac].fmnb134,g_fmnb3_d[l_ac].fmnb135, 
                           g_fmnb3_d[l_ac].fmnb136,g_fmnb4_d[l_ac].fmnbseq,g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb029, 
                           g_fmnb4_d[l_ac].fmnb031,g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb006,g_fmnb4_d[l_ac].fmnb007, 
                           g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb009,g_fmnb4_d[l_ac].fmnb010,g_fmnb4_d[l_ac].fmnb011, 
                           g_fmnb4_d[l_ac].fmnb012,g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb014,g_fmnb4_d[l_ac].fmnb015, 
                           g_fmnb4_d[l_ac].fmnb016,g_fmnb4_d[l_ac].fmnb017,g_fmnb4_d[l_ac].fmnb018,g_fmnb4_d[l_ac].fmnb019, 
                           g_fmnb4_d[l_ac].fmnb020,g_fmnb4_d[l_ac].fmnb021,g_fmnb4_d[l_ac].fmnb022,g_fmnb4_d[l_ac].fmnb023, 
                           g_fmnb4_d[l_ac].fmnb024,g_fmnb4_d[l_ac].fmnb025,g_fmnb4_d[l_ac].fmnb026,g_fmnb4_d[l_ac].fmnb027,
                           g_fmnb4_d[l_ac].fmnb028_desc,g_fmnb4_d[l_ac].fmnb029_desc,g_fmnb4_d[l_ac].fmnb005_desc,
   						      g_fmnb4_d[l_ac].fmnb006_desc,g_fmnb4_d[l_ac].fmnb007_desc,g_fmnb4_d[l_ac].fmnb008_desc,
   						      g_fmnb4_d[l_ac].fmnb009_desc,g_fmnb4_d[l_ac].fmnb010_desc,g_fmnb4_d[l_ac].fmnb011_desc,
   						      g_fmnb4_d[l_ac].fmnb012_desc,g_fmnb4_d[l_ac].fmnb013_desc,g_fmnb4_d[l_ac].fmnb014_desc,
   						      g_fmnb4_d[l_ac].fmnb016_desc,g_fmnb4_d[l_ac].fmnb017_desc
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #固定核算項
      #重評價會計科目
      LET g_fmnb4_d[l_ac].fmnb028_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb028,g_fmnb4_d[l_ac].fmnb028_desc)
      #對方科目
      LET g_fmnb4_d[l_ac].fmnb029_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb029,g_fmnb4_d[l_ac].fmnb029_desc)
      #交易客商
      LET g_fmnb4_d[l_ac].fmnb005_desc  = s_desc_show1(g_fmnb4_d[l_ac].fmnb005,g_fmnb4_d[l_ac].fmnb005_desc)
      #帳款客戶
      LET g_fmnb4_d[l_ac].fmnb006_desc  = s_desc_show1(g_fmnb4_d[l_ac].fmnb006,g_fmnb4_d[l_ac].fmnb006_desc)
   
      LET g_fmnb4_d[l_ac].fmnb007_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb007,g_fmnb4_d[l_ac].fmnb007_desc)
      LET g_fmnb4_d[l_ac].fmnb008_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb008,g_fmnb4_d[l_ac].fmnb008_desc)
      LET g_fmnb4_d[l_ac].fmnb009_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb009,g_fmnb4_d[l_ac].fmnb009_desc)
      LET g_fmnb4_d[l_ac].fmnb010_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb010,g_fmnb4_d[l_ac].fmnb010_desc)
      LET g_fmnb4_d[l_ac].fmnb011_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb011,g_fmnb4_d[l_ac].fmnb011_desc)
      LET g_fmnb4_d[l_ac].fmnb012_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb012,g_fmnb4_d[l_ac].fmnb012_desc)
      LET g_fmnb4_d[l_ac].fmnb013_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb013,g_fmnb4_d[l_ac].fmnb013_desc)
      LET g_fmnb4_d[l_ac].fmnb014_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb014,g_fmnb4_d[l_ac].fmnb014_desc)
      LET g_fmnb4_d[l_ac].fmnb015_desc = g_fmnb4_d[l_ac].fmnb015
      LET g_fmnb4_d[l_ac].fmnb016_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb016,g_fmnb4_d[l_ac].fmnb016_desc)
      LET g_fmnb4_d[l_ac].fmnb017_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb017,g_fmnb4_d[l_ac].fmnb017_desc)
   
      #自由核算項
      CALL s_fin_sel_glad(g_fmna_m.fmna001,g_fmnb4_d[l_ac].fmnb028,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
           RETURNING g_errno,g_glad.*
      IF NOT cl_null(g_fmnb4_d[l_ac].fmnb018) THEN
         LET g_fmnb4_d[l_ac].fmnb018_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb018,s_fin_get_accting_desc(g_glad.glad0171,g_fmnb4_d[l_ac].fmnb018))
      END IF
      IF NOT cl_null(g_fmnb4_d[l_ac].fmnb019) THEN
         LET g_fmnb4_d[l_ac].fmnb019_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb019,s_fin_get_accting_desc(g_glad.glad0181,g_fmnb4_d[l_ac].fmnb019))
      END IF
      IF NOT cl_null(g_fmnb4_d[l_ac].fmnb020) THEN
         LET g_fmnb4_d[l_ac].fmnb020_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb020,s_fin_get_accting_desc(g_glad.glad0191,g_fmnb4_d[l_ac].fmnb020))
      END IF
      IF NOT cl_null(g_fmnb4_d[l_ac].fmnb021) THEN
         LET g_fmnb4_d[l_ac].fmnb021_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb021,s_fin_get_accting_desc(g_glad.glad0201,g_fmnb4_d[l_ac].fmnb021))
      END IF
      IF NOT cl_null(g_fmnb4_d[l_ac].fmnb022) THEN
         LET g_fmnb4_d[l_ac].fmnb022_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb022,s_fin_get_accting_desc(g_glad.glad0211,g_fmnb4_d[l_ac].fmnb022))
      END IF
      IF NOT cl_null(g_fmnb4_d[l_ac].fmnb023) THEN
         LET g_fmnb4_d[l_ac].fmnb023_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb023,s_fin_get_accting_desc(g_glad.glad0221,g_fmnb4_d[l_ac].fmnb023))
      END IF
      IF NOT cl_null(g_fmnb4_d[l_ac].fmnb024) THEN
         LET g_fmnb4_d[l_ac].fmnb024_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb024,s_fin_get_accting_desc(g_glad.glad0231,g_fmnb4_d[l_ac].fmnb024))
      END IF
      IF NOT cl_null(g_fmnb4_d[l_ac].fmnb025) THEN
         LET g_fmnb4_d[l_ac].fmnb025_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb025,s_fin_get_accting_desc(g_glad.glad0241,g_fmnb4_d[l_ac].fmnb025))
      END IF
      IF NOT cl_null(g_fmnb4_d[l_ac].fmnb026) THEN
         LET g_fmnb4_d[l_ac].fmnb026_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb026,s_fin_get_accting_desc(g_glad.glad0251,g_fmnb4_d[l_ac].fmnb026))
      END IF
      IF NOT cl_null(g_fmnb4_d[l_ac].fmnb027) THEN
         LET g_fmnb4_d[l_ac].fmnb027_desc = s_desc_show1(g_fmnb4_d[l_ac].fmnb027,s_fin_get_accting_desc(g_glad.glad0261,g_fmnb4_d[l_ac].fmnb027))
      END IF
   
      SELECT fmmj027 INTO g_fmnb_d[l_ac].l_fmmj027
        FROM fmmj_t
       WHERE fmmjent   = g_enterprise
         AND fmmjdocno = g_fmnb_d[l_ac].fmnb033
   
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
   END FOREACH
   LET g_error_show = 0
   #160129-00015#11 add(E)
   #end add-point
   
   CALL g_fmnb_d.deleteElement(g_fmnb_d.getLength())
   CALL g_fmnb2_d.deleteElement(g_fmnb2_d.getLength())
   CALL g_fmnb3_d.deleteElement(g_fmnb3_d.getLength())
   CALL g_fmnb4_d.deleteElement(g_fmnb4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afmt570_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fmnb_d.getLength()
      LET g_fmnb_d_mask_o[l_ac].* =  g_fmnb_d[l_ac].*
      CALL afmt570_fmnb_t_mask()
      LET g_fmnb_d_mask_n[l_ac].* =  g_fmnb_d[l_ac].*
   END FOR
   
   LET g_fmnb2_d_mask_o.* =  g_fmnb2_d.*
   FOR l_ac = 1 TO g_fmnb2_d.getLength()
      LET g_fmnb2_d_mask_o[l_ac].* =  g_fmnb2_d[l_ac].*
      CALL afmt570_fmnb_t_mask()
      LET g_fmnb2_d_mask_n[l_ac].* =  g_fmnb2_d[l_ac].*
   END FOR
   LET g_fmnb3_d_mask_o.* =  g_fmnb3_d.*
   FOR l_ac = 1 TO g_fmnb3_d.getLength()
      LET g_fmnb3_d_mask_o[l_ac].* =  g_fmnb3_d[l_ac].*
      CALL afmt570_fmnb_t_mask()
      LET g_fmnb3_d_mask_n[l_ac].* =  g_fmnb3_d[l_ac].*
   END FOR
   LET g_fmnb4_d_mask_o.* =  g_fmnb4_d.*
   FOR l_ac = 1 TO g_fmnb4_d.getLength()
      LET g_fmnb4_d_mask_o[l_ac].* =  g_fmnb4_d[l_ac].*
      CALL afmt570_fmnb_t_mask()
      LET g_fmnb4_d_mask_n[l_ac].* =  g_fmnb4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt570.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afmt570_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2','3','4',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM fmnb_t
       WHERE fmnbent = g_enterprise AND
         fmnbdocno = ps_keys_bak[1] AND fmnbseq = ps_keys_bak[2]
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
         CALL g_fmnb_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_fmnb2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_fmnb3_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'4'" THEN 
         CALL g_fmnb4_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afmt570_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','2','3','4',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO fmnb_t
                  (fmnbent,
                   fmnbdocno,
                   fmnbseq
                   ,fmnb030,fmnb033,fmnb002,fmnb003,fmnb004,fmnb032,fmnb100,fmnb101,fmnb102,fmnb103,fmnb113,fmnb114,fmnb115,fmnb116,fmnb121,fmnb122,fmnb123,fmnb124,fmnb125,fmnb126,fmnb131,fmnb132,fmnb133,fmnb134,fmnb135,fmnb136,fmnb028,fmnb029,fmnb031,fmnb005,fmnb006,fmnb007,fmnb008,fmnb009,fmnb010,fmnb011,fmnb012,fmnb013,fmnb014,fmnb015,fmnb016,fmnb017,fmnb018,fmnb019,fmnb020,fmnb021,fmnb022,fmnb023,fmnb024,fmnb025,fmnb026,fmnb027) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_fmnb_d[g_detail_idx].fmnb030,g_fmnb_d[g_detail_idx].fmnb033,g_fmnb_d[g_detail_idx].fmnb002, 
                       g_fmnb_d[g_detail_idx].fmnb003,g_fmnb_d[g_detail_idx].fmnb004,g_fmnb_d[g_detail_idx].fmnb032, 
                       g_fmnb_d[g_detail_idx].fmnb100,g_fmnb_d[g_detail_idx].fmnb101,g_fmnb_d[g_detail_idx].fmnb102, 
                       g_fmnb_d[g_detail_idx].fmnb103,g_fmnb_d[g_detail_idx].fmnb113,g_fmnb_d[g_detail_idx].fmnb114, 
                       g_fmnb_d[g_detail_idx].fmnb115,g_fmnb_d[g_detail_idx].fmnb116,g_fmnb2_d[g_detail_idx].fmnb121, 
                       g_fmnb2_d[g_detail_idx].fmnb122,g_fmnb2_d[g_detail_idx].fmnb123,g_fmnb2_d[g_detail_idx].fmnb124, 
                       g_fmnb2_d[g_detail_idx].fmnb125,g_fmnb2_d[g_detail_idx].fmnb126,g_fmnb3_d[g_detail_idx].fmnb131, 
                       g_fmnb3_d[g_detail_idx].fmnb132,g_fmnb3_d[g_detail_idx].fmnb133,g_fmnb3_d[g_detail_idx].fmnb134, 
                       g_fmnb3_d[g_detail_idx].fmnb135,g_fmnb3_d[g_detail_idx].fmnb136,g_fmnb4_d[g_detail_idx].fmnb028, 
                       g_fmnb4_d[g_detail_idx].fmnb029,g_fmnb4_d[g_detail_idx].fmnb031,g_fmnb4_d[g_detail_idx].fmnb005, 
                       g_fmnb4_d[g_detail_idx].fmnb006,g_fmnb4_d[g_detail_idx].fmnb007,g_fmnb4_d[g_detail_idx].fmnb008, 
                       g_fmnb4_d[g_detail_idx].fmnb009,g_fmnb4_d[g_detail_idx].fmnb010,g_fmnb4_d[g_detail_idx].fmnb011, 
                       g_fmnb4_d[g_detail_idx].fmnb012,g_fmnb4_d[g_detail_idx].fmnb013,g_fmnb4_d[g_detail_idx].fmnb014, 
                       g_fmnb4_d[g_detail_idx].fmnb015,g_fmnb4_d[g_detail_idx].fmnb016,g_fmnb4_d[g_detail_idx].fmnb017, 
                       g_fmnb4_d[g_detail_idx].fmnb018,g_fmnb4_d[g_detail_idx].fmnb019,g_fmnb4_d[g_detail_idx].fmnb020, 
                       g_fmnb4_d[g_detail_idx].fmnb021,g_fmnb4_d[g_detail_idx].fmnb022,g_fmnb4_d[g_detail_idx].fmnb023, 
                       g_fmnb4_d[g_detail_idx].fmnb024,g_fmnb4_d[g_detail_idx].fmnb025,g_fmnb4_d[g_detail_idx].fmnb026, 
                       g_fmnb4_d[g_detail_idx].fmnb027)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fmnb_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_fmnb2_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_fmnb3_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'4'" THEN 
         CALL g_fmnb4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afmt570_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2','3','4',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmnb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afmt570_fmnb_t_mask_restore('restore_mask_o')
               
      UPDATE fmnb_t 
         SET (fmnbdocno,
              fmnbseq
              ,fmnb030,fmnb033,fmnb002,fmnb003,fmnb004,fmnb032,fmnb100,fmnb101,fmnb102,fmnb103,fmnb113,fmnb114,fmnb115,fmnb116,fmnb121,fmnb122,fmnb123,fmnb124,fmnb125,fmnb126,fmnb131,fmnb132,fmnb133,fmnb134,fmnb135,fmnb136,fmnb028,fmnb029,fmnb031,fmnb005,fmnb006,fmnb007,fmnb008,fmnb009,fmnb010,fmnb011,fmnb012,fmnb013,fmnb014,fmnb015,fmnb016,fmnb017,fmnb018,fmnb019,fmnb020,fmnb021,fmnb022,fmnb023,fmnb024,fmnb025,fmnb026,fmnb027) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_fmnb_d[g_detail_idx].fmnb030,g_fmnb_d[g_detail_idx].fmnb033,g_fmnb_d[g_detail_idx].fmnb002, 
                  g_fmnb_d[g_detail_idx].fmnb003,g_fmnb_d[g_detail_idx].fmnb004,g_fmnb_d[g_detail_idx].fmnb032, 
                  g_fmnb_d[g_detail_idx].fmnb100,g_fmnb_d[g_detail_idx].fmnb101,g_fmnb_d[g_detail_idx].fmnb102, 
                  g_fmnb_d[g_detail_idx].fmnb103,g_fmnb_d[g_detail_idx].fmnb113,g_fmnb_d[g_detail_idx].fmnb114, 
                  g_fmnb_d[g_detail_idx].fmnb115,g_fmnb_d[g_detail_idx].fmnb116,g_fmnb2_d[g_detail_idx].fmnb121, 
                  g_fmnb2_d[g_detail_idx].fmnb122,g_fmnb2_d[g_detail_idx].fmnb123,g_fmnb2_d[g_detail_idx].fmnb124, 
                  g_fmnb2_d[g_detail_idx].fmnb125,g_fmnb2_d[g_detail_idx].fmnb126,g_fmnb3_d[g_detail_idx].fmnb131, 
                  g_fmnb3_d[g_detail_idx].fmnb132,g_fmnb3_d[g_detail_idx].fmnb133,g_fmnb3_d[g_detail_idx].fmnb134, 
                  g_fmnb3_d[g_detail_idx].fmnb135,g_fmnb3_d[g_detail_idx].fmnb136,g_fmnb4_d[g_detail_idx].fmnb028, 
                  g_fmnb4_d[g_detail_idx].fmnb029,g_fmnb4_d[g_detail_idx].fmnb031,g_fmnb4_d[g_detail_idx].fmnb005, 
                  g_fmnb4_d[g_detail_idx].fmnb006,g_fmnb4_d[g_detail_idx].fmnb007,g_fmnb4_d[g_detail_idx].fmnb008, 
                  g_fmnb4_d[g_detail_idx].fmnb009,g_fmnb4_d[g_detail_idx].fmnb010,g_fmnb4_d[g_detail_idx].fmnb011, 
                  g_fmnb4_d[g_detail_idx].fmnb012,g_fmnb4_d[g_detail_idx].fmnb013,g_fmnb4_d[g_detail_idx].fmnb014, 
                  g_fmnb4_d[g_detail_idx].fmnb015,g_fmnb4_d[g_detail_idx].fmnb016,g_fmnb4_d[g_detail_idx].fmnb017, 
                  g_fmnb4_d[g_detail_idx].fmnb018,g_fmnb4_d[g_detail_idx].fmnb019,g_fmnb4_d[g_detail_idx].fmnb020, 
                  g_fmnb4_d[g_detail_idx].fmnb021,g_fmnb4_d[g_detail_idx].fmnb022,g_fmnb4_d[g_detail_idx].fmnb023, 
                  g_fmnb4_d[g_detail_idx].fmnb024,g_fmnb4_d[g_detail_idx].fmnb025,g_fmnb4_d[g_detail_idx].fmnb026, 
                  g_fmnb4_d[g_detail_idx].fmnb027) 
         WHERE fmnbent = g_enterprise AND fmnbdocno = ps_keys_bak[1] AND fmnbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmnb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmnb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt570_fmnb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afmt570_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt570.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afmt570_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt570.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afmt570_lock_b(ps_table,ps_page)
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
   #CALL afmt570_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2','3','4',"
   #僅鎖定自身table
   LET ls_group = "fmnb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afmt570_bcl USING g_enterprise,
                                       g_fmna_m.fmnadocno,g_fmnb_d[g_detail_idx].fmnbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt570_bcl:",SQLERRMESSAGE 
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
 
{<section id="afmt570.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afmt570_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2','3','4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt570_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afmt570.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt570_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("fmnadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fmnadocno",TRUE)
      CALL cl_set_comp_entry("fmnadocdt",TRUE)
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
 
{<section id="afmt570.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt570_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
  
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmnadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("fmnadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("fmnadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
  
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt570.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afmt570_set_entry_b(p_cmd)
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
 
{<section id="afmt570.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afmt570_set_no_entry_b(p_cmd)
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
 
{<section id="afmt570.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt570_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt570_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_fmna_m.fmnastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afmt570_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afmt570_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt570_default_search()
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
      LET ls_wc = ls_wc, " fmnadocno = '", g_argv[01], "' AND "
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
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "fmna_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fmnb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
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
 
{<section id="afmt570.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afmt570_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fmna_m.fmnadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afmt570_cl USING g_enterprise,g_fmna_m.fmnadocno
   IF STATUS THEN
      CLOSE afmt570_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt570_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afmt570_master_referesh USING g_fmna_m.fmnadocno INTO g_fmna_m.fmnasite,g_fmna_m.fmna001, 
       g_fmna_m.fmnacomp,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt,g_fmna_m.fmna006,g_fmna_m.fmna004,g_fmna_m.fmna002, 
       g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus,g_fmna_m.fmnaownid,g_fmna_m.fmnaowndp,g_fmna_m.fmnacrtid, 
       g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid, 
       g_fmna_m.fmnacnfdt,g_fmna_m.fmnapstid,g_fmna_m.fmnapstdt,g_fmna_m.fmnaownid_desc,g_fmna_m.fmnaowndp_desc, 
       g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp_desc,g_fmna_m.fmnamodid_desc,g_fmna_m.fmnacnfid_desc, 
       g_fmna_m.fmnapstid_desc
   
 
   #檢查是否允許此動作
   IF NOT afmt570_action_chk() THEN
      CLOSE afmt570_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmna_m.fmnasite,g_fmna_m.fmnasite_desc,g_fmna_m.fmna001,g_fmna_m.fmna001_desc,g_fmna_m.fmnacomp, 
       g_fmna_m.fmnacomp_desc,g_fmna_m.fmnadocno,g_fmna_m.fmnadocno_desc,g_fmna_m.fmnadocdt,g_fmna_m.fmna006, 
       g_fmna_m.fmna006_desc,g_fmna_m.fmna004,g_fmna_m.fmna002,g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus, 
       g_fmna_m.fmnaownid,g_fmna_m.fmnaownid_desc,g_fmna_m.fmnaowndp,g_fmna_m.fmnaowndp_desc,g_fmna_m.fmnacrtid, 
       g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdp_desc,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid, 
       g_fmna_m.fmnamodid_desc,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid,g_fmna_m.fmnacnfid_desc,g_fmna_m.fmnacnfdt, 
       g_fmna_m.fmnapstid,g_fmna_m.fmnapstid_desc,g_fmna_m.fmnapstdt
 
   CASE g_fmna_m.fmnastus
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
         CASE g_fmna_m.fmnastus
            
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
     
      CASE g_fmna_m.fmnastus
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
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            CALL s_transaction_end('N','0')           #150401-00001#13
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         WHEN "W" #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)  
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"  #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed ",TRUE)  
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT afmt570_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt570_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afmt570_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt570_cl
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
      g_fmna_m.fmnastus = lc_state OR cl_null(lc_state) THEN
      CLOSE afmt570_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      IF g_fmna_m.fmnastus = 'N' THEN
         CALL cl_err_collect_init()
         CALL s_afmt570_conf_chk(g_fmna_m.fmnadocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')           #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')        #150401-00001#13
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_afmt570_conf_upd(g_fmna_m.fmnadocno) RETURNING g_sub_success
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
      CALL cl_err_collect_init()
      CALL s_afmt570_unconf_chk(g_fmna_m.fmnadocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')           #150401-00001#13
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')        #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_afmt570_unconf_upd(g_fmna_m.fmnadocno) RETURNING g_sub_success
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
      CALL cl_err_collect_init()
      CALL s_afmt570_void_chk(g_fmna_m.fmnadocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')           #150401-00001#13
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN   #是否執行取消作廢？
            CALL s_transaction_end('N','0')        #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_afmt570_void_upd(g_fmna_m.fmnadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL cl_err_collect_show()
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_fmna_m.fmnamodid = g_user
   LET g_fmna_m.fmnamoddt = cl_get_current()
   LET g_fmna_m.fmnastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fmna_t 
      SET (fmnastus,fmnamodid,fmnamoddt) 
        = (g_fmna_m.fmnastus,g_fmna_m.fmnamodid,g_fmna_m.fmnamoddt)     
    WHERE fmnaent = g_enterprise AND fmnadocno = g_fmna_m.fmnadocno
 
    
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
      EXECUTE afmt570_master_referesh USING g_fmna_m.fmnadocno INTO g_fmna_m.fmnasite,g_fmna_m.fmna001, 
          g_fmna_m.fmnacomp,g_fmna_m.fmnadocno,g_fmna_m.fmnadocdt,g_fmna_m.fmna006,g_fmna_m.fmna004, 
          g_fmna_m.fmna002,g_fmna_m.fmna003,g_fmna_m.fmna005,g_fmna_m.fmnastus,g_fmna_m.fmnaownid,g_fmna_m.fmnaowndp, 
          g_fmna_m.fmnacrtid,g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid,g_fmna_m.fmnamoddt, 
          g_fmna_m.fmnacnfid,g_fmna_m.fmnacnfdt,g_fmna_m.fmnapstid,g_fmna_m.fmnapstdt,g_fmna_m.fmnaownid_desc, 
          g_fmna_m.fmnaowndp_desc,g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp_desc,g_fmna_m.fmnamodid_desc, 
          g_fmna_m.fmnacnfid_desc,g_fmna_m.fmnapstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fmna_m.fmnasite,g_fmna_m.fmnasite_desc,g_fmna_m.fmna001,g_fmna_m.fmna001_desc, 
          g_fmna_m.fmnacomp,g_fmna_m.fmnacomp_desc,g_fmna_m.fmnadocno,g_fmna_m.fmnadocno_desc,g_fmna_m.fmnadocdt, 
          g_fmna_m.fmna006,g_fmna_m.fmna006_desc,g_fmna_m.fmna004,g_fmna_m.fmna002,g_fmna_m.fmna003, 
          g_fmna_m.fmna005,g_fmna_m.fmnastus,g_fmna_m.fmnaownid,g_fmna_m.fmnaownid_desc,g_fmna_m.fmnaowndp, 
          g_fmna_m.fmnaowndp_desc,g_fmna_m.fmnacrtid,g_fmna_m.fmnacrtid_desc,g_fmna_m.fmnacrtdp,g_fmna_m.fmnacrtdp_desc, 
          g_fmna_m.fmnacrtdt,g_fmna_m.fmnamodid,g_fmna_m.fmnamodid_desc,g_fmna_m.fmnamoddt,g_fmna_m.fmnacnfid, 
          g_fmna_m.fmnacnfid_desc,g_fmna_m.fmnacnfdt,g_fmna_m.fmnapstid,g_fmna_m.fmnapstid_desc,g_fmna_m.fmnapstdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afmt570_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt570_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt570.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afmt570_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fmnb_d.getLength() THEN
         LET g_detail_idx = g_fmnb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmnb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmnb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_fmnb2_d.getLength() THEN
         LET g_detail_idx = g_fmnb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmnb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmnb2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_fmnb3_d.getLength() THEN
         LET g_detail_idx = g_fmnb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmnb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmnb3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_fmnb4_d.getLength() THEN
         LET g_detail_idx = g_fmnb4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmnb4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmnb4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmt570_b_fill2(pi_idx)
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
   
   CALL afmt570_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afmt570_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   RETURN FALSE   #160129-00015#11  #用自己寫的b_fill段
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt570.status_show" >}
PRIVATE FUNCTION afmt570_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt570.mask_functions" >}
&include "erp/afm/afmt570_mask.4gl"
 
{</section>}
 
{<section id="afmt570.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afmt570_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL afmt570_show()
   CALL afmt570_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #151013-00016#11 151106 by sakura add(S)
   IF NOT s_afmt570_unconf_chk(g_fmna_m.fmnadocno) THEN
      CLOSE afmt570_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #151013-00016#11 151106 by sakura add(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fmna_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fmnb_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_fmnb2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_fmnb3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_fmnb4_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   #確認前檢核段
   IF NOT s_afmt570_conf_chk(g_fmna_m.fmnadocno) THEN
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL afmt570_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afmt570_ui_headershow()
   CALL afmt570_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afmt570_draw_out()
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
   CALL afmt570_ui_headershow()  
   CALL afmt570_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afmt570.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt570_set_pk_array()
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
   LET g_pk_array[1].values = g_fmna_m.fmnadocno
   LET g_pk_array[1].column = 'fmnadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt570.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afmt570.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt570_msgcentre_notify(lc_state)
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
   CALL afmt570_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmna_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt570.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmt570_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#13 2016/08/23 By 07900 --add -s-
   SELECT fmnastus INTO g_fmna_m.fmnastus
     FROM fmna_t
    WHERE fmnaent = g_enterprise
      AND fmnadocno = g_fmna_m.fmnadocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_fmna_m.fmnastus
       
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
        LET g_errparam.extend = g_fmna_m.fmnadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afmt570_set_act_visible()
        CALL afmt570_set_act_no_visible()
        CALL afmt570_show()
        RETURN FALSE
     END IF
   END IF
   
   
   #160818-00017#13 2016/08/23 By 07900 --add -e-
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt570.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得帳套後的預設資料
# Memo...........:
# Usage..........: CALL afmt570_set_ld_info(p_ld)
# Input parameter: p_ld        帳套
# Return code....: comp        法人
# Date & Author..: 2015/05/04 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt570_set_ld_info(p_ld)
DEFINE p_ld        LIKE apca_t.apcald

   CALL s_ld_sel_glaa(p_ld,'glaacomp|glaa004|glaa015|glaa019|glaa024|glaa102|glaa121')
        RETURNING g_sub_success,g_glaa.*

   
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_fmna_m.fmnasite,g_fmna_m.fmnadocdt,'1')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_fmnasite
   CALL s_fin_get_wc_str(g_wc_fmnasite) RETURNING g_wc_fmnasite
   CALL s_fin_account_center_ld_str() RETURNING g_wc_fmna001
   CALL s_fin_get_wc_str(g_wc_fmna001) RETURNING g_wc_fmna001
   
   
   IF g_glaa.glaa015 = 'N' AND  g_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('page_3,page_4',FALSE)   #本位幣頁籤隱藏
   ELSE
      #本幣二
      IF g_glaa.glaa015 = 'Y' THEN
         CALL cl_set_comp_visible('page_3',TRUE)
      ELSE
         CALL cl_set_comp_visible('page_3',FALSE)
      END IF

      #本幣三
      IF g_glaa.glaa019 = 'Y' THEN
         CALL cl_set_comp_visible('page_4',TRUE)
      ELSE
         CALL cl_set_comp_visible('page_4',FALSE)
      END IF
   END IF

   #是否啟用分錄底稿
   IF g_glaa.glaa121 = 'Y' THEN
      CALL cl_set_act_visible("open_pre", TRUE)
   ELSE
      CALL cl_set_act_visible("open_pre", FALSE)
   END IF
   
   RETURN g_glaa.glaacomp
END FUNCTION

 
{</section>}
 
