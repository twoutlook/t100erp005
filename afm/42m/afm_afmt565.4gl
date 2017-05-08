#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt565.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2015-12-09 19:34:11), PR版次:0011(2017-01-20 05:46:08)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: afmt565
#+ Description: 計提投資收益帳務單
#+ Creator....: 04152(2015-05-20 10:20:22)
#+ Modifier...: 02159 -SD/PR- 08729
 
{</section>}
 
{<section id="afmt565.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150401-00001#13 2015/07/21 By RayHuang statechange段問題修正
#151029-00012#11 2015/11/01 By Reanna   1.由afmt560帶入，匯率及金額可修改/2.程式雙按單身會當出
#150916-00015#1  2015/12/07 By Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#151126-00013#6  2015/12/09 By sakura   加單頭傳票編號串查
#160129-00015#10 2016/02/24 By sakura   效率改善
#160321-00016#27 2016/03/24 By Jessy    修正azzi920重複定義之錯誤訊息\
#160318-00025#49 2016/04/26 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息
#160620-00010#2  2016/06/21 By 01531    拋轉傳票時，傳票憑證日期應該預設單據的財務日期，而非系統日期
#160818-00017#13 2016/08/23 By 07900    删除修改未重新判断状态码
#160913-00017#2  2016/09/21 By 07900    AFM模组调整交易客商开窗
#161006-00005#13 2016/10/19 By 08732    組織類型與職能開窗調整
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
PRIVATE type type_g_fmmu_m        RECORD
       fmmusite LIKE fmmu_t.fmmusite, 
   fmmusite_desc LIKE type_t.chr80, 
   fmmu001 LIKE fmmu_t.fmmu001, 
   fmmu001_desc LIKE type_t.chr80, 
   l_comp LIKE type_t.chr500, 
   comp_desc LIKE type_t.chr80, 
   fmmudocno LIKE fmmu_t.fmmudocno, 
   fmmudocno_desc LIKE type_t.chr80, 
   fmmudocdt LIKE fmmu_t.fmmudocdt, 
   fmmu002 LIKE fmmu_t.fmmu002, 
   fmmu003 LIKE fmmu_t.fmmu003, 
   fmmu004 LIKE fmmu_t.fmmu004, 
   fmmustus LIKE fmmu_t.fmmustus, 
   fmmuownid LIKE fmmu_t.fmmuownid, 
   fmmuownid_desc LIKE type_t.chr80, 
   fmmuowndp LIKE fmmu_t.fmmuowndp, 
   fmmuowndp_desc LIKE type_t.chr80, 
   fmmucrtid LIKE fmmu_t.fmmucrtid, 
   fmmucrtid_desc LIKE type_t.chr80, 
   fmmucrtdp LIKE fmmu_t.fmmucrtdp, 
   fmmucrtdp_desc LIKE type_t.chr80, 
   fmmucrtdt LIKE fmmu_t.fmmucrtdt, 
   fmmumodid LIKE fmmu_t.fmmumodid, 
   fmmumodid_desc LIKE type_t.chr80, 
   fmmumoddt LIKE fmmu_t.fmmumoddt, 
   fmmucnfid LIKE fmmu_t.fmmucnfid, 
   fmmucnfid_desc LIKE type_t.chr80, 
   fmmucnfdt LIKE fmmu_t.fmmucnfdt, 
   fmmupstid LIKE fmmu_t.fmmupstid, 
   fmmupstid_desc LIKE type_t.chr80, 
   fmmupstdt LIKE fmmu_t.fmmupstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fmng_d        RECORD
       fmngseq LIKE fmng_t.fmngseq, 
   fmng001 LIKE fmng_t.fmng001, 
   fmng002 LIKE fmng_t.fmng002, 
   fmng003 LIKE fmng_t.fmng003, 
   fmng004 LIKE fmng_t.fmng004, 
   l_fmmt005 LIKE type_t.dat, 
   l_fmmt006 LIKE type_t.dat, 
   l_fmmt007 LIKE type_t.num5, 
   l_fmmt008 LIKE type_t.num26_10, 
   l_fmmt009 LIKE type_t.chr1, 
   fmng005 LIKE fmng_t.fmng005, 
   fmng006 LIKE fmng_t.fmng006, 
   fmng007 LIKE fmng_t.fmng007, 
   fmng008 LIKE fmng_t.fmng008, 
   fmng009 LIKE fmng_t.fmng009, 
   fmng010 LIKE fmng_t.fmng010, 
   fmng011 LIKE fmng_t.fmng011
       END RECORD
PRIVATE TYPE type_g_fmng2_d RECORD
       fmngseq LIKE fmng_t.fmngseq, 
   fmng012 LIKE fmng_t.fmng012, 
   fmng013 LIKE fmng_t.fmng013, 
   fmng014 LIKE fmng_t.fmng014, 
   fmng015 LIKE fmng_t.fmng015
       END RECORD
PRIVATE TYPE type_g_fmng3_d RECORD
       fmngseq LIKE fmng_t.fmngseq, 
   fmng016 LIKE fmng_t.fmng016, 
   fmng017 LIKE fmng_t.fmng017, 
   fmng018 LIKE fmng_t.fmng018, 
   fmng019 LIKE fmng_t.fmng019
       END RECORD
PRIVATE TYPE type_g_fmng4_d RECORD
       fmngseq LIKE fmng_t.fmngseq, 
   fmng020 LIKE fmng_t.fmng020, 
   fmng020_desc LIKE type_t.chr500, 
   fmng021 LIKE fmng_t.fmng021, 
   fmng021_desc LIKE type_t.chr500, 
   fmng022 LIKE fmng_t.fmng022, 
   fmng022_desc LIKE type_t.chr500, 
   fmng046 LIKE fmng_t.fmng046, 
   fmng023 LIKE fmng_t.fmng023, 
   fmng023_desc LIKE type_t.chr500, 
   fmng024 LIKE fmng_t.fmng024, 
   fmng024_desc LIKE type_t.chr500, 
   fmng025 LIKE fmng_t.fmng025, 
   fmng025_desc LIKE type_t.chr500, 
   fmng026 LIKE fmng_t.fmng026, 
   fmng026_desc LIKE type_t.chr500, 
   fmng027 LIKE fmng_t.fmng027, 
   fmng027_desc LIKE type_t.chr500, 
   fmng028 LIKE fmng_t.fmng028, 
   fmng028_desc LIKE type_t.chr500, 
   fmng029 LIKE fmng_t.fmng029, 
   fmng029_desc LIKE type_t.chr500, 
   fmng030 LIKE fmng_t.fmng030, 
   fmng030_desc LIKE type_t.chr500, 
   fmng031 LIKE fmng_t.fmng031, 
   fmng031_desc LIKE type_t.chr500, 
   fmng032 LIKE fmng_t.fmng032, 
   fmng032_desc LIKE type_t.chr500, 
   fmng033 LIKE fmng_t.fmng033, 
   fmng033_desc LIKE type_t.chr500, 
   fmng034 LIKE fmng_t.fmng034, 
   fmng034_desc LIKE type_t.chr500, 
   fmng035 LIKE fmng_t.fmng035, 
   fmng035_desc LIKE type_t.chr500, 
   fmng036 LIKE fmng_t.fmng036, 
   fmng036_desc LIKE type_t.chr500, 
   fmng037 LIKE fmng_t.fmng037, 
   fmng037_desc LIKE type_t.chr500, 
   fmng038 LIKE fmng_t.fmng038, 
   fmng038_desc LIKE type_t.chr500, 
   fmng039 LIKE fmng_t.fmng039, 
   fmng039_desc LIKE type_t.chr500, 
   fmng040 LIKE fmng_t.fmng040, 
   fmng040_desc LIKE type_t.chr500, 
   fmng041 LIKE fmng_t.fmng041, 
   fmng041_desc LIKE type_t.chr500, 
   fmng042 LIKE fmng_t.fmng042, 
   fmng042_desc LIKE type_t.chr500, 
   fmng043 LIKE fmng_t.fmng043, 
   fmng043_desc LIKE type_t.chr500, 
   fmng044 LIKE fmng_t.fmng044, 
   fmng044_desc LIKE type_t.chr500, 
   fmng045 LIKE fmng_t.fmng045, 
   fmng045_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fmmusite LIKE fmmu_t.fmmusite,
      b_fmmu001 LIKE fmmu_t.fmmu001,
      b_fmmudocno LIKE fmmu_t.fmmudocno,
      b_fmmudocdt LIKE fmmu_t.fmmudocdt,
      b_fmmu002 LIKE fmmu_t.fmmu002,
      b_fmmu003 LIKE fmmu_t.fmmu003,
      b_fmmu004 LIKE fmmu_t.fmmu004
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa                RECORD
                             glaacomp  LIKE glaa_t.glaacomp,
                             glaa001   LIKE glaa_t.glaa001,
                             glaa004   LIKE glaa_t.glaa004,
                             glaa015   LIKE glaa_t.glaa015,
                             glaa016   LIKE glaa_t.glaa016,
                             glaa019   LIKE glaa_t.glaa019,
                             glaa020   LIKE glaa_t.glaa020,
                             glaa024   LIKE glaa_t.glaa024,
                             glaa102   LIKE glaa_t.glaa102,
                             glaa121   LIKE glaa_t.glaa121
                         END RECORD
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
DEFINE g_wc_fmmusite         STRING
DEFINE g_wc_fmmu001          STRING
DEFINE g_wc_cs_comp          STRING   #161006-00005#13   add
#161104-00046#21 --s add
DEFINE g_user_dept_wc        STRING     
DEFINE g_user_dept_wc_q      STRING    
#161104-00046#21 --e add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_fmmu_m          type_g_fmmu_m
DEFINE g_fmmu_m_t        type_g_fmmu_m
DEFINE g_fmmu_m_o        type_g_fmmu_m
DEFINE g_fmmu_m_mask_o   type_g_fmmu_m #轉換遮罩前資料
DEFINE g_fmmu_m_mask_n   type_g_fmmu_m #轉換遮罩後資料
 
   DEFINE g_fmmudocno_t LIKE fmmu_t.fmmudocno
 
 
DEFINE g_fmng_d          DYNAMIC ARRAY OF type_g_fmng_d
DEFINE g_fmng_d_t        type_g_fmng_d
DEFINE g_fmng_d_o        type_g_fmng_d
DEFINE g_fmng_d_mask_o   DYNAMIC ARRAY OF type_g_fmng_d #轉換遮罩前資料
DEFINE g_fmng_d_mask_n   DYNAMIC ARRAY OF type_g_fmng_d #轉換遮罩後資料
DEFINE g_fmng2_d          DYNAMIC ARRAY OF type_g_fmng2_d
DEFINE g_fmng2_d_t        type_g_fmng2_d
DEFINE g_fmng2_d_o        type_g_fmng2_d
DEFINE g_fmng2_d_mask_o   DYNAMIC ARRAY OF type_g_fmng2_d #轉換遮罩前資料
DEFINE g_fmng2_d_mask_n   DYNAMIC ARRAY OF type_g_fmng2_d #轉換遮罩後資料
DEFINE g_fmng3_d          DYNAMIC ARRAY OF type_g_fmng3_d
DEFINE g_fmng3_d_t        type_g_fmng3_d
DEFINE g_fmng3_d_o        type_g_fmng3_d
DEFINE g_fmng3_d_mask_o   DYNAMIC ARRAY OF type_g_fmng3_d #轉換遮罩前資料
DEFINE g_fmng3_d_mask_n   DYNAMIC ARRAY OF type_g_fmng3_d #轉換遮罩後資料
DEFINE g_fmng4_d          DYNAMIC ARRAY OF type_g_fmng4_d
DEFINE g_fmng4_d_t        type_g_fmng4_d
DEFINE g_fmng4_d_o        type_g_fmng4_d
DEFINE g_fmng4_d_mask_o   DYNAMIC ARRAY OF type_g_fmng4_d #轉換遮罩前資料
DEFINE g_fmng4_d_mask_n   DYNAMIC ARRAY OF type_g_fmng4_d #轉換遮罩後資料
 
 
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
 
{<section id="afmt565.main" >}
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
   CALL s_fin_get_user_dept_control('','fmmu001','fmmuent','fmmudocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   #161104-00046#21 --e add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmmusite,'',fmmu001,'','','',fmmudocno,'',fmmudocdt,fmmu002,fmmu003,fmmu004, 
       fmmustus,fmmuownid,'',fmmuowndp,'',fmmucrtid,'',fmmucrtdp,'',fmmucrtdt,fmmumodid,'',fmmumoddt, 
       fmmucnfid,'',fmmucnfdt,fmmupstid,'',fmmupstdt", 
                      " FROM fmmu_t",
                      " WHERE fmmuent= ? AND fmmudocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt565_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmmusite,t0.fmmu001,t0.fmmudocno,t0.fmmudocdt,t0.fmmu002,t0.fmmu003, 
       t0.fmmu004,t0.fmmustus,t0.fmmuownid,t0.fmmuowndp,t0.fmmucrtid,t0.fmmucrtdp,t0.fmmucrtdt,t0.fmmumodid, 
       t0.fmmumoddt,t0.fmmucnfid,t0.fmmucnfdt,t0.fmmupstid,t0.fmmupstdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011 ,t6.ooag011 ,t7.ooag011",
               " FROM fmmu_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.fmmuownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.fmmuowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.fmmucrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.fmmucrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.fmmumodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fmmucnfid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.fmmupstid  ",
 
               " WHERE t0.fmmuent = " ||g_enterprise|| " AND t0.fmmudocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmt565_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmt565 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmt565_init()   
 
      #進入選單 Menu (="N")
      CALL afmt565_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmt565
      
   END IF 
   
   CLOSE afmt565_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmt565.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt565_init()
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
      CALL cl_set_combo_scc_part('fmmustus','13','Y,X,A,D,R,W,N')
 
      CALL cl_set_combo_scc('fmng033','6013') 
 
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
   #計息方式
   CALL cl_set_combo_scc('l_fmmt009','8801')
   #經營方式
   CALL cl_set_combo_scc('fmng033_desc','6013')
   
   #161006-00005#13   add---s
   CALL s_fin_azzi800_sons_query(g_today) 
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   #161006-00005#13   add---e
   #end add-point
   
   #初始化搜尋條件
   CALL afmt565_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afmt565.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afmt565_ui_dialog()
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
   DEFINE r_docno     LIKE fmmu_t.fmmudocno
   DEFINE l_wc        STRING
   DEFINE l_slip      LIKE glap_t.glapdocno
   DEFINE l_date      LIKE glap_t.glapdocdt
   DEFINE l_glap001   LIKE glap_t.glap001    #傳票性質
   DEFINE l_glapdocdt LIKE glap_t.glapdocdt
   DEFINE l_stus      LIKE glap_t.glapstus
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
         INITIALIZE g_fmmu_m.* TO NULL
         CALL g_fmng_d.clear()
         CALL g_fmng2_d.clear()
         CALL g_fmng3_d.clear()
         CALL g_fmng4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmt565_init()
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
               
               CALL afmt565_fetch('') # reload data
               LET l_ac = 1
               CALL afmt565_ui_detailshow() #Setting the current row 
         
               CALL afmt565_idx_chk()
               #NEXT FIELD fmngseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_fmng_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt565_idx_chk()
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
               CALL afmt565_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_fmng2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt565_idx_chk()
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
               CALL afmt565_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fmng3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt565_idx_chk()
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
               CALL afmt565_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fmng4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt565_idx_chk()
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
               CALL afmt565_idx_chk()
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
            CALL afmt565_browser_fill("")
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
               CALL afmt565_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afmt565_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afmt565_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL afmt565_set_act_visible()
            CALL afmt565_set_act_no_visible()
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afmt565_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afmt565_set_act_visible()   
            CALL afmt565_set_act_no_visible()
            IF NOT (g_fmmu_m.fmmudocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fmmuent = " ||g_enterprise|| " AND",
                                  " fmmudocno = '", g_fmmu_m.fmmudocno, "' "
 
               #填到對應位置
               CALL afmt565_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "fmmu_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmng_t" 
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
               CALL afmt565_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "fmmu_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmng_t" 
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
                  CALL afmt565_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt565_fetch("F")
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
               CALL afmt565_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afmt565_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt565_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afmt565_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt565_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afmt565_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt565_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afmt565_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt565_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afmt565_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt565_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_fmng_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fmng2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_fmng3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_fmng4_d)
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
               NEXT FIELD fmngseq
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
               CALL afmt565_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afmt565_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapp330
            LET g_action_choice="open_aapp330"
            IF cl_auth_chk_act("open_aapp330") THEN
               
               #add-point:ON ACTION open_aapp330 name="menu.open_aapp330"
               IF g_fmmu_m.fmmudocno IS NULL THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = "" 
                 LET g_errparam.code   = "std-00003" 
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 CONTINUE DIALOG
               END IF
               
               #未確認單據不可拋轉
               IF g_fmmu_m.fmmustus = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00185'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               #無傳票號碼才可拋轉
               IF cl_null(g_fmmu_m.fmmu004) THEN
                  
                  #產生單別/日期
                  #CALL axrp330_01(g_fmmu_m.fmmu001) RETURNING l_slip,l_date                        #160620-00010#2 mark
                  CALL axrp330_01(g_fmmu_m.fmmu001,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmudocno) RETURNING l_slip,l_date      #160620-00010#2 add  #161213-00023#4 add  g_fmmu_m.fmmudocno
                  
                  #若取消產生時，就不往下走拋轉了
                  IF cl_null(l_slip) THEN
                     CONTINUE DIALOG
                  END IF

                  CALL s_transaction_begin()

                  CALL cl_err_collect_init()
                  IF g_glaa.glaa121 = 'Y' THEN 
                     LET l_wc =" glgbdocno = '",g_fmmu_m.fmmudocno,"' "
                     CALL s_pre_voucher_ins_glap('FM','M40',g_fmmu_m.fmmu001,l_date,l_slip,'1',l_wc) 
                          RETURNING g_sub_success,g_fmmu_m.fmmu004,g_fmmu_m.fmmu004
                  ELSE
                     LET l_wc =" fmmudocno = '",g_fmmu_m.fmmudocno,"' "
                     CALL s_voucher_gen_fm('7',g_fmmu_m.fmmu001,l_date,l_slip,'0',l_wc,'N','afmt565')
                          RETURNING g_sub_success,g_fmmu_m.fmmu004,g_fmmu_m.fmmu004
                  END IF
                  CALL cl_err_collect_show()

                  IF g_sub_success THEN
                     UPDATE glga_t SET glga007 = g_fmmu_m.fmmu004
                      WHERE glgaent = g_enterprise AND glgald = g_fmmu_m.fmmu001
                        AND glgadocno=g_fmmu_m.fmmudocno AND glga100 = 'FM' AND glga101 = 'M40'
                     CALL s_transaction_end('Y','0')
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'adz-00217'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  ELSE
                     IF cl_null(g_fmmu_m.fmmu004) THEN 
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
                  SELECT fmmu004 INTO g_fmmu_m.fmmu004
                    FROM fmmu_t
                   WHERE fmmuent = g_enterprise
                     AND fmmudocno = g_fmmu_m.fmmudocno
                  DISPLAY BY NAME g_fmmu_m.fmmu004
               ELSE
                  LET l_glap001 = ''
                  SELECT glap001 INTO l_glap001
                    FROM glap_t
                   WHERE glapent = g_enterprise AND glapld = g_fmmu_m.fmmu001
                     AND glapdocno = g_fmmu_m.fmmu004
                  IF NOT l_glap001 MATCHES '[1235]' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00029'
                     LET g_errparam.extend = g_fmmu_m.fmmudocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  ELSE
                     LET la_param.prog = 'aglt310'
                     LET la_param.param[1] = g_fmmu_m.fmmu001
                     LET la_param.param[2] = g_fmmu_m.fmmu004
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
               IF NOT cl_null(g_fmmu_m.fmmudocno) AND g_fmmu_m.fmmustus = 'N' THEN
                  CALL s_transaction_begin()
                  CALL s_pre_voucher_ins('FM','M40',g_fmmu_m.fmmu001,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt,'7')
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
               IF g_glaa.glaa121 = 'Y' THEN
                  CALL s_pre_voucher('FM','M40',g_fmmu_m.fmmu001,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt)
               ELSE
                  CALL axrt300_13('FM',g_fmmu_m.fmmu001,g_fmmu_m.fmmudocno,'afmt565')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt565_01
            LET g_action_choice="open_afmt565_01"
            IF cl_auth_chk_act("open_afmt565_01") THEN
               
               #add-point:ON ACTION open_afmt565_01 name="menu.open_afmt565_01"
               CALL s_transaction_begin()
               LET r_docno = ''
               CALL afmt565_01('','1')RETURNING g_sub_success,r_docno
               IF g_sub_success THEN
                  CALL s_transaction_end('Y',0)
                  IF NOT cl_null(r_docno) THEN
                     LET g_fmmu_m.fmmudocno = r_docno
                     #把產生的那張顯示出來
                     LET g_wc = " fmmuent = ",g_enterprise," AND fmmudocno = '",g_fmmu_m.fmmudocno,"' "
                     CALL afmt565_browser_fill("F")
                     CALL afmt565_fetch("F")
                     CALL afmt565_idx_chk()
                     #顯示成功訊息
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'axm-00088'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #產生底稿
                     IF g_glaa.glaa121 = 'Y' THEN
                        CALL s_transaction_begin()
                        CALL s_pre_voucher_ins('FM','M40',g_fmmu_m.fmmu001,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt,'7')
                             RETURNING g_sub_success
                        IF g_sub_success THEN
                           CALL s_transaction_end('Y','0')
                        ELSE
                           CALL s_transaction_end('N','0')
                        END IF
                     END IF
                  END IF
               ELSE
                  CALL s_transaction_end('N',0)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmt565_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_reback
            LET g_action_choice="open_reback"
            IF cl_auth_chk_act("open_reback") THEN
               
               #add-point:ON ACTION open_reback name="menu.open_reback"
               CALL s_transaction_begin()
               #傳票還原
               IF g_fmmu_m.fmmudocno IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "std-00003"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #無傳票 不可還原
               IF g_fmmu_m.fmmu004 IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "anm-00186"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #傳票還原單據日期不可小於等於過帳日期
               CALL s_afm_close_day_chk(g_fmmu_m.fmmu001,g_fmmu_m.fmmu004) RETURNING g_sub_success,g_errno
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
                     AND glapdocno = g_fmmu_m.fmmu004
                  
                 #IF l_stus = 'Y' THEN
                  IF l_stus NOT MATCHES '[N]' THEN    #151223 by Reanna 未確認才能還原
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
                     CALL s_pre_voucher_delete_glax(g_fmmu_m.fmmu001,g_fmmu_m.fmmu004,'',l_scom0002) RETURNING l_success
                     IF l_success = FALSE THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                     
                     IF l_scom0002 = 'Y' THEN
                        #凭证作废处理
                        UPDATE glap_t SET glapstus = 'X'
                         WHERE glapent = g_enterprise
                           AND glapld = g_fmmu_m.fmmu001
                           AND glapdocno = g_fmmu_m.fmmu004
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
                           AND glapld = g_fmmu_m.fmmu001
                           AND glapdocno = g_fmmu_m.fmmu004
                        #刪除單頭
                        DELETE FROM glap_t
                         WHERE glapent   = g_enterprise
                           AND glapld = g_fmmu_m.fmmu001
                           AND glapdocno = g_fmmu_m.fmmu004
                        #刪除單身
                        DELETE FROM glaq_t
                         WHERE glaqent = g_enterprise
                           AND glaqld = g_fmmu_m.fmmu001
                           AND glaqdocno = g_fmmu_m.fmmu004
                        #170103-00019#22 mark ------
                        ##更新月結這邊的傳票號碼要給空
                        #UPDATE fmmu_t SET fmmu004 = ''
                        # WHERE fmmuent = g_enterprise
                        #   AND fmmudocno = g_fmmu_m.fmmudocno
                        #170103-00019#22 mark end---
                        #更新最大號
                        LET g_prog = 'aglt310'
                        IF NOT s_aooi200_fin_del_docno(g_fmmu_m.fmmu001,g_fmmu_m.fmmu004,l_glapdocdt) THEN
                           CALL s_transaction_end('N','0')
                           CONTINUE DIALOG
                        END IF
                        LET g_prog = 'afmt570'
                        #170103-00019#22 mark ------
                        #LET g_fmmu_m.fmmu004 = ''
                        #DISPLAY BY NAME g_fmmu_m.fmmu004
                        #170103-00019#22 mark end---
                        #分錄底稿
                        UPDATE glga_t SET glga007 = ''
                         WHERE glgaent = g_enterprise AND glgald = g_fmmu_m.fmmu001
                           AND glgadocno=g_fmmu_m.fmmudocno AND glga100 = 'FM' AND glga101 = 'M40'
   
                     #170103-00019#22 add ------  
                     END IF
                     #更新月結這邊的傳票號碼要給空
                     UPDATE fmmu_t SET fmmu004 = ''
                      WHERE fmmuent = g_enterprise
                        AND fmmudocno = g_fmmu_m.fmmudocno
                     LET g_fmmu_m.fmmu004 = ''
                     DISPLAY BY NAME g_fmmu_m.fmmu004
                     #170103-00019#22 add end---
                     
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt565_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt565_02
            LET g_action_choice="open_afmt565_02"
            IF cl_auth_chk_act("open_afmt565_02") THEN
               
               #add-point:ON ACTION open_afmt565_02 name="menu.open_afmt565_02"
               IF NOT cl_null(g_fmmu_m.fmmudocno) THEN
                  CALL s_transaction_begin()
                  LET r_docno = ''
                  CALL afmt565_01(g_fmmu_m.fmmudocno,'2')RETURNING g_sub_success,r_docno
                  IF g_sub_success THEN
                     CALL s_transaction_end('Y',0)
                     LET g_fmmu_m.fmmudocno = r_docno
                     CALL afmt565_b_fill()
                     IF g_glaa.glaa121 = 'Y' THEN
                        CALL s_transaction_begin()
                        CALL s_pre_voucher_ins('FM','M40',g_fmmu_m.fmmu001,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt,'7')
                             RETURNING g_sub_success
                        IF g_sub_success THEN
                           CALL s_transaction_end('Y','0')
                        ELSE
                           CALL s_transaction_end('N','0')
                        END IF
                     END IF
                  ELSE
                     CALL s_transaction_end('N',0)
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fmmu004
            LET g_action_choice="prog_fmmu004"
            IF cl_auth_chk_act("prog_fmmu004") THEN
               
               #add-point:ON ACTION prog_fmmu004 name="menu.prog_fmmu004"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               #151126-00013#6(S)
               INITIALIZE la_param.* TO NULL
               IF NOT cl_null(g_fmmu_m.fmmu004) THEN
                  LET l_glap001 = ''
                  SELECT glap001 INTO l_glap001 
                    FROM glap_t 
                   WHERE glapent = g_enterprise
                     AND glapdocno = g_fmmu_m.fmmu004  
                     AND glapld = g_fmmu_m.fmmu001               
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
                  LET la_param.param[1] = g_fmmu_m.fmmu001
                  LET la_param.param[2] = g_fmmu_m.fmmu004
                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #151126-00013#6(E)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt565_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt565_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt565_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmmu_m.fmmudocdt)
 
 
 
         
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
 
{<section id="afmt565.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afmt565_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT fmmudocno ",
                      " FROM fmmu_t ",
                      " ",
                      " LEFT JOIN fmng_t ON fmngent = fmmuent AND fmmudocno = fmngdocno ", "  ",
                      #add-point:browser_fill段sql(fmng_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE fmmuent = " ||g_enterprise|| " AND fmngent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fmmu_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fmmudocno ",
                      " FROM fmmu_t ", 
                      "  ",
                      "  ",
                      " WHERE fmmuent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fmmu_t")
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
      INITIALIZE g_fmmu_m.* TO NULL
      CALL g_fmng_d.clear()        
      CALL g_fmng2_d.clear() 
      CALL g_fmng3_d.clear() 
      CALL g_fmng4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fmmusite,t0.fmmu001,t0.fmmudocno,t0.fmmudocdt,t0.fmmu002,t0.fmmu003,t0.fmmu004 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmmustus,t0.fmmusite,t0.fmmu001,t0.fmmudocno,t0.fmmudocdt,t0.fmmu002, 
          t0.fmmu003,t0.fmmu004 ",
                  " FROM fmmu_t t0",
                  "  ",
                  "  LEFT JOIN fmng_t ON fmngent = fmmuent AND fmmudocno = fmngdocno ", "  ", 
                  #add-point:browser_fill段sql(fmng_t1) name="browser_fill.join.fmng_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.fmmuent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("fmmu_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmmustus,t0.fmmusite,t0.fmmu001,t0.fmmudocno,t0.fmmudocdt,t0.fmmu002, 
          t0.fmmu003,t0.fmmu004 ",
                  " FROM fmmu_t t0",
                  "  ",
                  
                  " WHERE t0.fmmuent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("fmmu_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY fmmudocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmmu_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmmusite,g_browser[g_cnt].b_fmmu001, 
          g_browser[g_cnt].b_fmmudocno,g_browser[g_cnt].b_fmmudocdt,g_browser[g_cnt].b_fmmu002,g_browser[g_cnt].b_fmmu003, 
          g_browser[g_cnt].b_fmmu004
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
         CALL afmt565_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_fmmudocno) THEN
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
 
{<section id="afmt565.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afmt565_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fmmu_m.fmmudocno = g_browser[g_current_idx].b_fmmudocno   
 
   EXECUTE afmt565_master_referesh USING g_fmmu_m.fmmudocno INTO g_fmmu_m.fmmusite,g_fmmu_m.fmmu001, 
       g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmu002,g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus, 
       g_fmmu_m.fmmuownid,g_fmmu_m.fmmuowndp,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtdp,g_fmmu_m.fmmucrtdt, 
       g_fmmu_m.fmmumodid,g_fmmu_m.fmmumoddt,g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid, 
       g_fmmu_m.fmmupstdt,g_fmmu_m.fmmuownid_desc,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid_desc,g_fmmu_m.fmmucrtdp_desc, 
       g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmupstid_desc
   
   CALL afmt565_fmmu_t_mask()
   CALL afmt565_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afmt565.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afmt565_ui_detailshow()
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
 
{<section id="afmt565.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt565_ui_browser_refresh()
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
      IF g_browser[l_i].b_fmmudocno = g_fmmu_m.fmmudocno 
 
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
 
{<section id="afmt565.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt565_construct()
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
   INITIALIZE g_fmmu_m.* TO NULL
   CALL g_fmng_d.clear()        
   CALL g_fmng2_d.clear() 
   CALL g_fmng3_d.clear() 
   CALL g_fmng4_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON fmmusite,fmmu001,l_comp,fmmudocno,fmmudocdt,fmmu002,fmmu003,fmmu004, 
          fmmustus,fmmuownid,fmmuowndp,fmmucrtid,fmmucrtdp,fmmucrtdt,fmmumodid,fmmumoddt,fmmucnfid,fmmucnfdt, 
          fmmupstid,fmmupstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmmucrtdt>>----
         AFTER FIELD fmmucrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmmumoddt>>----
         AFTER FIELD fmmumoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmmucnfdt>>----
         AFTER FIELD fmmucnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmmupstdt>>----
         AFTER FIELD fmmupstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.fmmusite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmusite
            #add-point:ON ACTION controlp INFIELD fmmusite name="construct.c.fmmusite"
            #帳務中心
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef204 = 'Y' "   #161006-00005#13   mark 
            #CALL q_ooef001()     #161006-00005#13   mark                    
            CALL q_ooef001_46()   #161006-00005#13   add
            DISPLAY g_qryparam.return1 TO fmmusite
            NEXT FIELD fmmusite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmusite
            #add-point:BEFORE FIELD fmmusite name="construct.b.fmmusite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmusite
            
            #add-point:AFTER FIELD fmmusite name="construct.a.fmmusite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmu001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmu001
            #add-point:ON ACTION controlp INFIELD fmmu001 name="construct.c.fmmu001"
            #帳套
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO fmmu001
            NEXT FIELD fmmu001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmu001
            #add-point:BEFORE FIELD fmmu001 name="construct.b.fmmu001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmu001
            
            #add-point:AFTER FIELD fmmu001 name="construct.a.fmmu001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_comp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_comp
            #add-point:ON ACTION controlp INFIELD l_comp name="construct.c.l_comp"
            #歸屬法人
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' ",
                                   " AND ooef001 IN ",g_wc_cs_comp   #161006-0005#13   add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO l_comp
            NEXT FIELD l_comp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_comp
            #add-point:BEFORE FIELD l_comp name="construct.b.l_comp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_comp
            
            #add-point:AFTER FIELD l_comp name="construct.a.l_comp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmudocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmudocno
            #add-point:ON ACTION controlp INFIELD fmmudocno name="construct.c.fmmudocno"
            #單據編號
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
            CALL q_fmmudocno()
            DISPLAY g_qryparam.return1 TO fmmudocno
            NEXT FIELD fmmudocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmudocno
            #add-point:BEFORE FIELD fmmudocno name="construct.b.fmmudocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmudocno
            
            #add-point:AFTER FIELD fmmudocno name="construct.a.fmmudocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmudocdt
            #add-point:BEFORE FIELD fmmudocdt name="construct.b.fmmudocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmudocdt
            
            #add-point:AFTER FIELD fmmudocdt name="construct.a.fmmudocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmudocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmudocdt
            #add-point:ON ACTION controlp INFIELD fmmudocdt name="construct.c.fmmudocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmu002
            #add-point:BEFORE FIELD fmmu002 name="construct.b.fmmu002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmu002
            
            #add-point:AFTER FIELD fmmu002 name="construct.a.fmmu002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmu002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmu002
            #add-point:ON ACTION controlp INFIELD fmmu002 name="construct.c.fmmu002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmu003
            #add-point:BEFORE FIELD fmmu003 name="construct.b.fmmu003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmu003
            
            #add-point:AFTER FIELD fmmu003 name="construct.a.fmmu003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmu003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmu003
            #add-point:ON ACTION controlp INFIELD fmmu003 name="construct.c.fmmu003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmu004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmu004
            #add-point:ON ACTION controlp INFIELD fmmu004 name="construct.c.fmmu004"
            #傳票編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmmu004()
            DISPLAY g_qryparam.return1 TO fmmu004
            NEXT FIELD fmmu004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmu004
            #add-point:BEFORE FIELD fmmu004 name="construct.b.fmmu004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmu004
            
            #add-point:AFTER FIELD fmmu004 name="construct.a.fmmu004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmustus
            #add-point:BEFORE FIELD fmmustus name="construct.b.fmmustus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmustus
            
            #add-point:AFTER FIELD fmmustus name="construct.a.fmmustus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmustus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmustus
            #add-point:ON ACTION controlp INFIELD fmmustus name="construct.c.fmmustus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmuownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmuownid
            #add-point:ON ACTION controlp INFIELD fmmuownid name="construct.c.fmmuownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmuownid  #顯示到畫面上
            NEXT FIELD fmmuownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmuownid
            #add-point:BEFORE FIELD fmmuownid name="construct.b.fmmuownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmuownid
            
            #add-point:AFTER FIELD fmmuownid name="construct.a.fmmuownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmuowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmuowndp
            #add-point:ON ACTION controlp INFIELD fmmuowndp name="construct.c.fmmuowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmuowndp  #顯示到畫面上
            NEXT FIELD fmmuowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmuowndp
            #add-point:BEFORE FIELD fmmuowndp name="construct.b.fmmuowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmuowndp
            
            #add-point:AFTER FIELD fmmuowndp name="construct.a.fmmuowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmucrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmucrtid
            #add-point:ON ACTION controlp INFIELD fmmucrtid name="construct.c.fmmucrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmucrtid  #顯示到畫面上
            NEXT FIELD fmmucrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmucrtid
            #add-point:BEFORE FIELD fmmucrtid name="construct.b.fmmucrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmucrtid
            
            #add-point:AFTER FIELD fmmucrtid name="construct.a.fmmucrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmucrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmucrtdp
            #add-point:ON ACTION controlp INFIELD fmmucrtdp name="construct.c.fmmucrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmucrtdp  #顯示到畫面上
            NEXT FIELD fmmucrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmucrtdp
            #add-point:BEFORE FIELD fmmucrtdp name="construct.b.fmmucrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmucrtdp
            
            #add-point:AFTER FIELD fmmucrtdp name="construct.a.fmmucrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmucrtdt
            #add-point:BEFORE FIELD fmmucrtdt name="construct.b.fmmucrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmumodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmumodid
            #add-point:ON ACTION controlp INFIELD fmmumodid name="construct.c.fmmumodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmumodid  #顯示到畫面上
            NEXT FIELD fmmumodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmumodid
            #add-point:BEFORE FIELD fmmumodid name="construct.b.fmmumodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmumodid
            
            #add-point:AFTER FIELD fmmumodid name="construct.a.fmmumodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmumoddt
            #add-point:BEFORE FIELD fmmumoddt name="construct.b.fmmumoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmucnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmucnfid
            #add-point:ON ACTION controlp INFIELD fmmucnfid name="construct.c.fmmucnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmucnfid  #顯示到畫面上
            NEXT FIELD fmmucnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmucnfid
            #add-point:BEFORE FIELD fmmucnfid name="construct.b.fmmucnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmucnfid
            
            #add-point:AFTER FIELD fmmucnfid name="construct.a.fmmucnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmucnfdt
            #add-point:BEFORE FIELD fmmucnfdt name="construct.b.fmmucnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmupstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmupstid
            #add-point:ON ACTION controlp INFIELD fmmupstid name="construct.c.fmmupstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmupstid  #顯示到畫面上
            NEXT FIELD fmmupstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmupstid
            #add-point:BEFORE FIELD fmmupstid name="construct.b.fmmupstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmupstid
            
            #add-point:AFTER FIELD fmmupstid name="construct.a.fmmupstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmupstdt
            #add-point:BEFORE FIELD fmmupstdt name="construct.b.fmmupstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON fmngseq,fmng001,fmng002,fmng003,fmng004,l_fmmt005,l_fmmt006,l_fmmt007, 
          l_fmmt008,l_fmmt009,fmng005,fmng006,fmng007,fmng008,fmng009,fmng010,fmng011,fmng012,fmng013, 
          fmng014,fmng015,fmng016,fmng017,fmng018,fmng019,fmng020,fmng020_desc,fmng021,fmng021_desc, 
          fmng022,fmng022_desc,fmng046,fmng023,fmng023_desc,fmng024,fmng024_desc,fmng025,fmng025_desc, 
          fmng026,fmng026_desc,fmng027,fmng027_desc,fmng028,fmng028_desc,fmng029,fmng029_desc,fmng030, 
          fmng030_desc,fmng031,fmng031_desc,fmng032,fmng032_desc,fmng033,fmng033_desc,fmng034,fmng034_desc, 
          fmng035,fmng035_desc,fmng036,fmng036_desc,fmng037,fmng037_desc,fmng038,fmng038_desc,fmng039, 
          fmng039_desc,fmng040,fmng040_desc,fmng041,fmng041_desc,fmng042,fmng042_desc,fmng043,fmng043_desc, 
          fmng044,fmng044_desc,fmng045,fmng045_desc
           FROM s_detail1[1].fmngseq,s_detail1[1].fmng001,s_detail1[1].fmng002,s_detail1[1].fmng003, 
               s_detail1[1].fmng004,s_detail1[1].l_fmmt005,s_detail1[1].l_fmmt006,s_detail1[1].l_fmmt007, 
               s_detail1[1].l_fmmt008,s_detail1[1].l_fmmt009,s_detail1[1].fmng005,s_detail1[1].fmng006, 
               s_detail1[1].fmng007,s_detail1[1].fmng008,s_detail1[1].fmng009,s_detail1[1].fmng010,s_detail1[1].fmng011, 
               s_detail2[1].fmng012,s_detail2[1].fmng013,s_detail2[1].fmng014,s_detail2[1].fmng015,s_detail3[1].fmng016, 
               s_detail3[1].fmng017,s_detail3[1].fmng018,s_detail3[1].fmng019,s_detail4[1].fmng020,s_detail4[1].fmng020_desc, 
               s_detail4[1].fmng021,s_detail4[1].fmng021_desc,s_detail4[1].fmng022,s_detail4[1].fmng022_desc, 
               s_detail4[1].fmng046,s_detail4[1].fmng023,s_detail4[1].fmng023_desc,s_detail4[1].fmng024, 
               s_detail4[1].fmng024_desc,s_detail4[1].fmng025,s_detail4[1].fmng025_desc,s_detail4[1].fmng026, 
               s_detail4[1].fmng026_desc,s_detail4[1].fmng027,s_detail4[1].fmng027_desc,s_detail4[1].fmng028, 
               s_detail4[1].fmng028_desc,s_detail4[1].fmng029,s_detail4[1].fmng029_desc,s_detail4[1].fmng030, 
               s_detail4[1].fmng030_desc,s_detail4[1].fmng031,s_detail4[1].fmng031_desc,s_detail4[1].fmng032, 
               s_detail4[1].fmng032_desc,s_detail4[1].fmng033,s_detail4[1].fmng033_desc,s_detail4[1].fmng034, 
               s_detail4[1].fmng034_desc,s_detail4[1].fmng035,s_detail4[1].fmng035_desc,s_detail4[1].fmng036, 
               s_detail4[1].fmng036_desc,s_detail4[1].fmng037,s_detail4[1].fmng037_desc,s_detail4[1].fmng038, 
               s_detail4[1].fmng038_desc,s_detail4[1].fmng039,s_detail4[1].fmng039_desc,s_detail4[1].fmng040, 
               s_detail4[1].fmng040_desc,s_detail4[1].fmng041,s_detail4[1].fmng041_desc,s_detail4[1].fmng042, 
               s_detail4[1].fmng042_desc,s_detail4[1].fmng043,s_detail4[1].fmng043_desc,s_detail4[1].fmng044, 
               s_detail4[1].fmng044_desc,s_detail4[1].fmng045,s_detail4[1].fmng045_desc
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmngseq
            #add-point:BEFORE FIELD fmngseq name="construct.b.page1.fmngseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmngseq
            
            #add-point:AFTER FIELD fmngseq name="construct.a.page1.fmngseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmngseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmngseq
            #add-point:ON ACTION controlp INFIELD fmngseq name="construct.c.page1.fmngseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng001
            #add-point:BEFORE FIELD fmng001 name="construct.b.page1.fmng001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng001
            
            #add-point:AFTER FIELD fmng001 name="construct.a.page1.fmng001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmng001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng001
            #add-point:ON ACTION controlp INFIELD fmng001 name="construct.c.page1.fmng001"
            #投資組織
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef206 = 'Y' " #150611-00016#5    #161006-00005#13---mark
            #CALL q_ooef001()     #161006-00005#13   mark
            CALL q_ooef001_33()   #161006-000005#13   add
            DISPLAY g_qryparam.return1 TO fmng001
            NEXT FIELD fmng001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng002
            #add-point:BEFORE FIELD fmng002 name="construct.b.page1.fmng002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng002
            
            #add-point:AFTER FIELD fmng002 name="construct.a.page1.fmng002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmng002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng002
            #add-point:ON ACTION controlp INFIELD fmng002 name="construct.c.page1.fmng002"
            #投資單號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmng002()
            DISPLAY g_qryparam.return1 TO fmng002
            NEXT FIELD fmng002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng003
            #add-point:BEFORE FIELD fmng003 name="construct.b.page1.fmng003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng003
            
            #add-point:AFTER FIELD fmng003 name="construct.a.page1.fmng003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmng003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng003
            #add-point:ON ACTION controlp INFIELD fmng003 name="construct.c.page1.fmng003"
            #幣別
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO fmng003
            NEXT FIELD fmng003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng004
            #add-point:BEFORE FIELD fmng004 name="construct.b.page1.fmng004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng004
            
            #add-point:AFTER FIELD fmng004 name="construct.a.page1.fmng004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmng004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng004
            #add-point:ON ACTION controlp INFIELD fmng004 name="construct.c.page1.fmng004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmt005
            #add-point:BEFORE FIELD l_fmmt005 name="construct.b.page1.l_fmmt005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmt005
            
            #add-point:AFTER FIELD l_fmmt005 name="construct.a.page1.l_fmmt005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fmmt005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmt005
            #add-point:ON ACTION controlp INFIELD l_fmmt005 name="construct.c.page1.l_fmmt005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmt006
            #add-point:BEFORE FIELD l_fmmt006 name="construct.b.page1.l_fmmt006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmt006
            
            #add-point:AFTER FIELD l_fmmt006 name="construct.a.page1.l_fmmt006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fmmt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmt006
            #add-point:ON ACTION controlp INFIELD l_fmmt006 name="construct.c.page1.l_fmmt006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmt007
            #add-point:BEFORE FIELD l_fmmt007 name="construct.b.page1.l_fmmt007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmt007
            
            #add-point:AFTER FIELD l_fmmt007 name="construct.a.page1.l_fmmt007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fmmt007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmt007
            #add-point:ON ACTION controlp INFIELD l_fmmt007 name="construct.c.page1.l_fmmt007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmt008
            #add-point:BEFORE FIELD l_fmmt008 name="construct.b.page1.l_fmmt008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmt008
            
            #add-point:AFTER FIELD l_fmmt008 name="construct.a.page1.l_fmmt008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fmmt008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmt008
            #add-point:ON ACTION controlp INFIELD l_fmmt008 name="construct.c.page1.l_fmmt008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmt009
            #add-point:BEFORE FIELD l_fmmt009 name="construct.b.page1.l_fmmt009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmt009
            
            #add-point:AFTER FIELD l_fmmt009 name="construct.a.page1.l_fmmt009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fmmt009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmt009
            #add-point:ON ACTION controlp INFIELD l_fmmt009 name="construct.c.page1.l_fmmt009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng005
            #add-point:BEFORE FIELD fmng005 name="construct.b.page1.fmng005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng005
            
            #add-point:AFTER FIELD fmng005 name="construct.a.page1.fmng005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmng005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng005
            #add-point:ON ACTION controlp INFIELD fmng005 name="construct.c.page1.fmng005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng006
            #add-point:BEFORE FIELD fmng006 name="construct.b.page1.fmng006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng006
            
            #add-point:AFTER FIELD fmng006 name="construct.a.page1.fmng006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmng006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng006
            #add-point:ON ACTION controlp INFIELD fmng006 name="construct.c.page1.fmng006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng007
            #add-point:BEFORE FIELD fmng007 name="construct.b.page1.fmng007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng007
            
            #add-point:AFTER FIELD fmng007 name="construct.a.page1.fmng007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmng007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng007
            #add-point:ON ACTION controlp INFIELD fmng007 name="construct.c.page1.fmng007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng008
            #add-point:BEFORE FIELD fmng008 name="construct.b.page1.fmng008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng008
            
            #add-point:AFTER FIELD fmng008 name="construct.a.page1.fmng008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmng008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng008
            #add-point:ON ACTION controlp INFIELD fmng008 name="construct.c.page1.fmng008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng009
            #add-point:BEFORE FIELD fmng009 name="construct.b.page1.fmng009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng009
            
            #add-point:AFTER FIELD fmng009 name="construct.a.page1.fmng009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmng009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng009
            #add-point:ON ACTION controlp INFIELD fmng009 name="construct.c.page1.fmng009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng010
            #add-point:BEFORE FIELD fmng010 name="construct.b.page1.fmng010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng010
            
            #add-point:AFTER FIELD fmng010 name="construct.a.page1.fmng010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmng010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng010
            #add-point:ON ACTION controlp INFIELD fmng010 name="construct.c.page1.fmng010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng011
            #add-point:BEFORE FIELD fmng011 name="construct.b.page1.fmng011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng011
            
            #add-point:AFTER FIELD fmng011 name="construct.a.page1.fmng011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmng011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng011
            #add-point:ON ACTION controlp INFIELD fmng011 name="construct.c.page1.fmng011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng012
            #add-point:BEFORE FIELD fmng012 name="construct.b.page2.fmng012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng012
            
            #add-point:AFTER FIELD fmng012 name="construct.a.page2.fmng012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmng012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng012
            #add-point:ON ACTION controlp INFIELD fmng012 name="construct.c.page2.fmng012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng013
            #add-point:BEFORE FIELD fmng013 name="construct.b.page2.fmng013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng013
            
            #add-point:AFTER FIELD fmng013 name="construct.a.page2.fmng013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmng013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng013
            #add-point:ON ACTION controlp INFIELD fmng013 name="construct.c.page2.fmng013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng014
            #add-point:BEFORE FIELD fmng014 name="construct.b.page2.fmng014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng014
            
            #add-point:AFTER FIELD fmng014 name="construct.a.page2.fmng014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmng014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng014
            #add-point:ON ACTION controlp INFIELD fmng014 name="construct.c.page2.fmng014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng015
            #add-point:BEFORE FIELD fmng015 name="construct.b.page2.fmng015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng015
            
            #add-point:AFTER FIELD fmng015 name="construct.a.page2.fmng015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmng015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng015
            #add-point:ON ACTION controlp INFIELD fmng015 name="construct.c.page2.fmng015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng016
            #add-point:BEFORE FIELD fmng016 name="construct.b.page3.fmng016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng016
            
            #add-point:AFTER FIELD fmng016 name="construct.a.page3.fmng016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmng016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng016
            #add-point:ON ACTION controlp INFIELD fmng016 name="construct.c.page3.fmng016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng017
            #add-point:BEFORE FIELD fmng017 name="construct.b.page3.fmng017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng017
            
            #add-point:AFTER FIELD fmng017 name="construct.a.page3.fmng017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmng017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng017
            #add-point:ON ACTION controlp INFIELD fmng017 name="construct.c.page3.fmng017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng018
            #add-point:BEFORE FIELD fmng018 name="construct.b.page3.fmng018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng018
            
            #add-point:AFTER FIELD fmng018 name="construct.a.page3.fmng018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmng018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng018
            #add-point:ON ACTION controlp INFIELD fmng018 name="construct.c.page3.fmng018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng019
            #add-point:BEFORE FIELD fmng019 name="construct.b.page3.fmng019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng019
            
            #add-point:AFTER FIELD fmng019 name="construct.a.page3.fmng019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmng019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng019
            #add-point:ON ACTION controlp INFIELD fmng019 name="construct.c.page3.fmng019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng020
            #add-point:BEFORE FIELD fmng020 name="construct.b.page4.fmng020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng020
            
            #add-point:AFTER FIELD fmng020 name="construct.a.page4.fmng020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng020
            #add-point:ON ACTION controlp INFIELD fmng020 name="construct.c.page4.fmng020"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng020_desc
            #add-point:ON ACTION controlp INFIELD fmng020_desc name="construct.c.page4.fmng020_desc"
            #應收股利/利息科目DR
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "  #glac003(科目類型)
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO fmng020
            DISPLAY g_qryparam.return1 TO fmng020_desc
            NEXT FIELD fmng020_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng020_desc
            #add-point:BEFORE FIELD fmng020_desc name="construct.b.page4.fmng020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng020_desc
            
            #add-point:AFTER FIELD fmng020_desc name="construct.a.page4.fmng020_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng021
            #add-point:BEFORE FIELD fmng021 name="construct.b.page4.fmng021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng021
            
            #add-point:AFTER FIELD fmng021 name="construct.a.page4.fmng021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng021
            #add-point:ON ACTION controlp INFIELD fmng021 name="construct.c.page4.fmng021"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng021_desc
            #add-point:ON ACTION controlp INFIELD fmng021_desc name="construct.c.page4.fmng021_desc"
            #利息調整科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "  #glac003(科目類型)
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO fmng021
            DISPLAY g_qryparam.return1 TO fmng021_desc
            NEXT FIELD fmng021_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng021_desc
            #add-point:BEFORE FIELD fmng021_desc name="construct.b.page4.fmng021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng021_desc
            
            #add-point:AFTER FIELD fmng021_desc name="construct.a.page4.fmng021_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng022
            #add-point:BEFORE FIELD fmng022 name="construct.b.page4.fmng022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng022
            
            #add-point:AFTER FIELD fmng022 name="construct.a.page4.fmng022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng022
            #add-point:ON ACTION controlp INFIELD fmng022 name="construct.c.page4.fmng022"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng022_desc
            #add-point:ON ACTION controlp INFIELD fmng022_desc name="construct.c.page4.fmng022_desc"
            #投資收益科目CR
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "  #glac003(科目類型)
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO fmng022
            DISPLAY g_qryparam.return1 TO fmng022_desc
            NEXT FIELD fmng022_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng022_desc
            #add-point:BEFORE FIELD fmng022_desc name="construct.b.page4.fmng022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng022_desc
            
            #add-point:AFTER FIELD fmng022_desc name="construct.a.page4.fmng022_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng046
            #add-point:BEFORE FIELD fmng046 name="construct.b.page4.fmng046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng046
            
            #add-point:AFTER FIELD fmng046 name="construct.a.page4.fmng046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng046
            #add-point:ON ACTION controlp INFIELD fmng046 name="construct.c.page4.fmng046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng023
            #add-point:BEFORE FIELD fmng023 name="construct.b.page4.fmng023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng023
            
            #add-point:AFTER FIELD fmng023 name="construct.a.page4.fmng023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng023
            #add-point:ON ACTION controlp INFIELD fmng023 name="construct.c.page4.fmng023"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng023_desc
            #add-point:ON ACTION controlp INFIELD fmng023_desc name="construct.c.page4.fmng023_desc"
            #交易客商
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
             CALL q_pmaa001_25()        #160913-00017#2  ADD 
           # CALL q_pmaa001()      #160913-00017#2 mark          #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmng023
            DISPLAY g_qryparam.return1 TO fmng023_desc
            NEXT FIELD fmng023_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng023_desc
            #add-point:BEFORE FIELD fmng023_desc name="construct.b.page4.fmng023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng023_desc
            
            #add-point:AFTER FIELD fmng023_desc name="construct.a.page4.fmng023_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng024
            #add-point:BEFORE FIELD fmng024 name="construct.b.page4.fmng024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng024
            
            #add-point:AFTER FIELD fmng024 name="construct.a.page4.fmng024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng024
            #add-point:ON ACTION controlp INFIELD fmng024 name="construct.c.page4.fmng024"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng024_desc
            #add-point:ON ACTION controlp INFIELD fmng024_desc name="construct.c.page4.fmng024_desc"
            #帳款客戶
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmac002_1()
            DISPLAY g_qryparam.return1 TO fmng024
            DISPLAY g_qryparam.return1 TO fmng024_desc
            NEXT FIELD fmng024_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng024_desc
            #add-point:BEFORE FIELD fmng024_desc name="construct.b.page4.fmng024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng024_desc
            
            #add-point:AFTER FIELD fmng024_desc name="construct.a.page4.fmng024_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng025
            #add-point:BEFORE FIELD fmng025 name="construct.b.page4.fmng025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng025
            
            #add-point:AFTER FIELD fmng025 name="construct.a.page4.fmng025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng025
            #add-point:ON ACTION controlp INFIELD fmng025 name="construct.c.page4.fmng025"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng025_desc
            #add-point:ON ACTION controlp INFIELD fmng025_desc name="construct.c.page4.fmng025_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO fmng025
            DISPLAY g_qryparam.return1 TO fmng025_desc
            NEXT FIELD fmng025_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng025_desc
            #add-point:BEFORE FIELD fmng025_desc name="construct.b.page4.fmng025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng025_desc
            
            #add-point:AFTER FIELD fmng025_desc name="construct.a.page4.fmng025_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng026
            #add-point:BEFORE FIELD fmng026 name="construct.b.page4.fmng026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng026
            
            #add-point:AFTER FIELD fmng026 name="construct.a.page4.fmng026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng026
            #add-point:ON ACTION controlp INFIELD fmng026 name="construct.c.page4.fmng026"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng026_desc
            #add-point:ON ACTION controlp INFIELD fmng026_desc name="construct.c.page4.fmng026_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO fmng026
            DISPLAY g_qryparam.return1 TO fmng026_desc
            NEXT FIELD fmng026_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng026_desc
            #add-point:BEFORE FIELD fmng026_desc name="construct.b.page4.fmng026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng026_desc
            
            #add-point:AFTER FIELD fmng026_desc name="construct.a.page4.fmng026_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng027
            #add-point:BEFORE FIELD fmng027 name="construct.b.page4.fmng027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng027
            
            #add-point:AFTER FIELD fmng027 name="construct.a.page4.fmng027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng027
            #add-point:ON ACTION controlp INFIELD fmng027 name="construct.c.page4.fmng027"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng027_desc
            #add-point:ON ACTION controlp INFIELD fmng027_desc name="construct.c.page4.fmng027_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO fmng027
            DISPLAY g_qryparam.return1 TO fmng027_desc
            NEXT FIELD fmng027_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng027_desc
            #add-point:BEFORE FIELD fmng027_desc name="construct.b.page4.fmng027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng027_desc
            
            #add-point:AFTER FIELD fmng027_desc name="construct.a.page4.fmng027_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng028
            #add-point:BEFORE FIELD fmng028 name="construct.b.page4.fmng028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng028
            
            #add-point:AFTER FIELD fmng028 name="construct.a.page4.fmng028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng028
            #add-point:ON ACTION controlp INFIELD fmng028 name="construct.c.page4.fmng028"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng028_desc
            #add-point:ON ACTION controlp INFIELD fmng028_desc name="construct.c.page4.fmng028_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO fmng028
            DISPLAY g_qryparam.return1 TO fmng028_desc
            NEXT FIELD fmng028_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng028_desc
            #add-point:BEFORE FIELD fmng028_desc name="construct.b.page4.fmng028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng028_desc
            
            #add-point:AFTER FIELD fmng028_desc name="construct.a.page4.fmng028_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng029
            #add-point:BEFORE FIELD fmng029 name="construct.b.page4.fmng029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng029
            
            #add-point:AFTER FIELD fmng029 name="construct.a.page4.fmng029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng029
            #add-point:ON ACTION controlp INFIELD fmng029 name="construct.c.page4.fmng029"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng029_desc
            #add-point:ON ACTION controlp INFIELD fmng029_desc name="construct.c.page4.fmng029_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO fmng029
            DISPLAY g_qryparam.return1 TO fmng029_desc
            NEXT FIELD fmng029_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng029_desc
            #add-point:BEFORE FIELD fmng029_desc name="construct.b.page4.fmng029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng029_desc
            
            #add-point:AFTER FIELD fmng029_desc name="construct.a.page4.fmng029_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng030
            #add-point:BEFORE FIELD fmng030 name="construct.b.page4.fmng030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng030
            
            #add-point:AFTER FIELD fmng030 name="construct.a.page4.fmng030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng030
            #add-point:ON ACTION controlp INFIELD fmng030 name="construct.c.page4.fmng030"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng030_desc
            #add-point:ON ACTION controlp INFIELD fmng030_desc name="construct.c.page4.fmng030_desc"
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO fmng030
            DISPLAY g_qryparam.return1 TO fmng030_desc
            NEXT FIELD fmng030_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng030_desc
            #add-point:BEFORE FIELD fmng030_desc name="construct.b.page4.fmng030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng030_desc
            
            #add-point:AFTER FIELD fmng030_desc name="construct.a.page4.fmng030_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng031
            #add-point:BEFORE FIELD fmng031 name="construct.b.page4.fmng031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng031
            
            #add-point:AFTER FIELD fmng031 name="construct.a.page4.fmng031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng031
            #add-point:ON ACTION controlp INFIELD fmng031 name="construct.c.page4.fmng031"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng031_desc
            #add-point:ON ACTION controlp INFIELD fmng031_desc name="construct.c.page4.fmng031_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO fmng031
            DISPLAY g_qryparam.return1 TO fmng031_desc
            NEXT FIELD fmng031_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng031_desc
            #add-point:BEFORE FIELD fmng031_desc name="construct.b.page4.fmng031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng031_desc
            
            #add-point:AFTER FIELD fmng031_desc name="construct.a.page4.fmng031_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng032
            #add-point:BEFORE FIELD fmng032 name="construct.b.page4.fmng032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng032
            
            #add-point:AFTER FIELD fmng032 name="construct.a.page4.fmng032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng032
            #add-point:ON ACTION controlp INFIELD fmng032 name="construct.c.page4.fmng032"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng032_desc
            #add-point:ON ACTION controlp INFIELD fmng032_desc name="construct.c.page4.fmng032_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO fmng032
            DISPLAY g_qryparam.return1 TO fmng032_desc
            NEXT FIELD fmng032_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng032_desc
            #add-point:BEFORE FIELD fmng032_desc name="construct.b.page4.fmng032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng032_desc
            
            #add-point:AFTER FIELD fmng032_desc name="construct.a.page4.fmng032_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng033
            #add-point:BEFORE FIELD fmng033 name="construct.b.page4.fmng033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng033
            
            #add-point:AFTER FIELD fmng033 name="construct.a.page4.fmng033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng033
            #add-point:ON ACTION controlp INFIELD fmng033 name="construct.c.page4.fmng033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng033_desc
            #add-point:BEFORE FIELD fmng033_desc name="construct.b.page4.fmng033_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng033_desc
            
            #add-point:AFTER FIELD fmng033_desc name="construct.a.page4.fmng033_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng033_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng033_desc
            #add-point:ON ACTION controlp INFIELD fmng033_desc name="construct.c.page4.fmng033_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng034
            #add-point:BEFORE FIELD fmng034 name="construct.b.page4.fmng034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng034
            
            #add-point:AFTER FIELD fmng034 name="construct.a.page4.fmng034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng034
            #add-point:ON ACTION controlp INFIELD fmng034 name="construct.c.page4.fmng034"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng034_desc
            #add-point:ON ACTION controlp INFIELD fmng034_desc name="construct.c.page4.fmng034_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO fmng034
            DISPLAY g_qryparam.return1 TO fmng034_desc
            NEXT FIELD fmng034_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng034_desc
            #add-point:BEFORE FIELD fmng034_desc name="construct.b.page4.fmng034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng034_desc
            
            #add-point:AFTER FIELD fmng034_desc name="construct.a.page4.fmng034_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng035
            #add-point:BEFORE FIELD fmng035 name="construct.b.page4.fmng035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng035
            
            #add-point:AFTER FIELD fmng035 name="construct.a.page4.fmng035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng035
            #add-point:ON ACTION controlp INFIELD fmng035 name="construct.c.page4.fmng035"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fmng035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng035_desc
            #add-point:ON ACTION controlp INFIELD fmng035_desc name="construct.c.page4.fmng035_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO fmng035
            DISPLAY g_qryparam.return1 TO fmng035_desc
            NEXT FIELD fmng035_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng035_desc
            #add-point:BEFORE FIELD fmng035_desc name="construct.b.page4.fmng035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng035_desc
            
            #add-point:AFTER FIELD fmng035_desc name="construct.a.page4.fmng035_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng036
            #add-point:BEFORE FIELD fmng036 name="construct.b.page4.fmng036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng036
            
            #add-point:AFTER FIELD fmng036 name="construct.a.page4.fmng036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng036
            #add-point:ON ACTION controlp INFIELD fmng036 name="construct.c.page4.fmng036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng036_desc
            #add-point:BEFORE FIELD fmng036_desc name="construct.b.page4.fmng036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng036_desc
            
            #add-point:AFTER FIELD fmng036_desc name="construct.a.page4.fmng036_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng036_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng036_desc
            #add-point:ON ACTION controlp INFIELD fmng036_desc name="construct.c.page4.fmng036_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng037
            #add-point:BEFORE FIELD fmng037 name="construct.b.page4.fmng037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng037
            
            #add-point:AFTER FIELD fmng037 name="construct.a.page4.fmng037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng037
            #add-point:ON ACTION controlp INFIELD fmng037 name="construct.c.page4.fmng037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng037_desc
            #add-point:BEFORE FIELD fmng037_desc name="construct.b.page4.fmng037_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng037_desc
            
            #add-point:AFTER FIELD fmng037_desc name="construct.a.page4.fmng037_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng037_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng037_desc
            #add-point:ON ACTION controlp INFIELD fmng037_desc name="construct.c.page4.fmng037_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng038
            #add-point:BEFORE FIELD fmng038 name="construct.b.page4.fmng038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng038
            
            #add-point:AFTER FIELD fmng038 name="construct.a.page4.fmng038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng038
            #add-point:ON ACTION controlp INFIELD fmng038 name="construct.c.page4.fmng038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng038_desc
            #add-point:BEFORE FIELD fmng038_desc name="construct.b.page4.fmng038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng038_desc
            
            #add-point:AFTER FIELD fmng038_desc name="construct.a.page4.fmng038_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng038_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng038_desc
            #add-point:ON ACTION controlp INFIELD fmng038_desc name="construct.c.page4.fmng038_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng039
            #add-point:BEFORE FIELD fmng039 name="construct.b.page4.fmng039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng039
            
            #add-point:AFTER FIELD fmng039 name="construct.a.page4.fmng039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng039
            #add-point:ON ACTION controlp INFIELD fmng039 name="construct.c.page4.fmng039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng039_desc
            #add-point:BEFORE FIELD fmng039_desc name="construct.b.page4.fmng039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng039_desc
            
            #add-point:AFTER FIELD fmng039_desc name="construct.a.page4.fmng039_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng039_desc
            #add-point:ON ACTION controlp INFIELD fmng039_desc name="construct.c.page4.fmng039_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng040
            #add-point:BEFORE FIELD fmng040 name="construct.b.page4.fmng040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng040
            
            #add-point:AFTER FIELD fmng040 name="construct.a.page4.fmng040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng040
            #add-point:ON ACTION controlp INFIELD fmng040 name="construct.c.page4.fmng040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng040_desc
            #add-point:BEFORE FIELD fmng040_desc name="construct.b.page4.fmng040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng040_desc
            
            #add-point:AFTER FIELD fmng040_desc name="construct.a.page4.fmng040_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng040_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng040_desc
            #add-point:ON ACTION controlp INFIELD fmng040_desc name="construct.c.page4.fmng040_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng041
            #add-point:BEFORE FIELD fmng041 name="construct.b.page4.fmng041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng041
            
            #add-point:AFTER FIELD fmng041 name="construct.a.page4.fmng041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng041
            #add-point:ON ACTION controlp INFIELD fmng041 name="construct.c.page4.fmng041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng041_desc
            #add-point:BEFORE FIELD fmng041_desc name="construct.b.page4.fmng041_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng041_desc
            
            #add-point:AFTER FIELD fmng041_desc name="construct.a.page4.fmng041_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng041_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng041_desc
            #add-point:ON ACTION controlp INFIELD fmng041_desc name="construct.c.page4.fmng041_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng042
            #add-point:BEFORE FIELD fmng042 name="construct.b.page4.fmng042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng042
            
            #add-point:AFTER FIELD fmng042 name="construct.a.page4.fmng042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng042
            #add-point:ON ACTION controlp INFIELD fmng042 name="construct.c.page4.fmng042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng042_desc
            #add-point:BEFORE FIELD fmng042_desc name="construct.b.page4.fmng042_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng042_desc
            
            #add-point:AFTER FIELD fmng042_desc name="construct.a.page4.fmng042_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng042_desc
            #add-point:ON ACTION controlp INFIELD fmng042_desc name="construct.c.page4.fmng042_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng043
            #add-point:BEFORE FIELD fmng043 name="construct.b.page4.fmng043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng043
            
            #add-point:AFTER FIELD fmng043 name="construct.a.page4.fmng043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng043
            #add-point:ON ACTION controlp INFIELD fmng043 name="construct.c.page4.fmng043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng043_desc
            #add-point:BEFORE FIELD fmng043_desc name="construct.b.page4.fmng043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng043_desc
            
            #add-point:AFTER FIELD fmng043_desc name="construct.a.page4.fmng043_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng043_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng043_desc
            #add-point:ON ACTION controlp INFIELD fmng043_desc name="construct.c.page4.fmng043_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng044
            #add-point:BEFORE FIELD fmng044 name="construct.b.page4.fmng044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng044
            
            #add-point:AFTER FIELD fmng044 name="construct.a.page4.fmng044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng044
            #add-point:ON ACTION controlp INFIELD fmng044 name="construct.c.page4.fmng044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng044_desc
            #add-point:BEFORE FIELD fmng044_desc name="construct.b.page4.fmng044_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng044_desc
            
            #add-point:AFTER FIELD fmng044_desc name="construct.a.page4.fmng044_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng044_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng044_desc
            #add-point:ON ACTION controlp INFIELD fmng044_desc name="construct.c.page4.fmng044_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng045
            #add-point:BEFORE FIELD fmng045 name="construct.b.page4.fmng045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng045
            
            #add-point:AFTER FIELD fmng045 name="construct.a.page4.fmng045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng045
            #add-point:ON ACTION controlp INFIELD fmng045 name="construct.c.page4.fmng045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng045_desc
            #add-point:BEFORE FIELD fmng045_desc name="construct.b.page4.fmng045_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng045_desc
            
            #add-point:AFTER FIELD fmng045_desc name="construct.a.page4.fmng045_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fmng045_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng045_desc
            #add-point:ON ACTION controlp INFIELD fmng045_desc name="construct.c.page4.fmng045_desc"
            
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
                  WHEN la_wc[li_idx].tableid = "fmmu_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fmng_t" 
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
   LET g_wc2 = cl_replace_str(g_wc2,'_desc',' ')
   LET g_wc2_table1 = cl_replace_str(g_wc2_table1,'_desc',' ')
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
 
{<section id="afmt565.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION afmt565_filter()
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
      CONSTRUCT g_wc_filter ON fmmusite,fmmu001,fmmudocno,fmmudocdt,fmmu002,fmmu003,fmmu004
                          FROM s_browse[1].b_fmmusite,s_browse[1].b_fmmu001,s_browse[1].b_fmmudocno, 
                              s_browse[1].b_fmmudocdt,s_browse[1].b_fmmu002,s_browse[1].b_fmmu003,s_browse[1].b_fmmu004 
 
 
         BEFORE CONSTRUCT
               DISPLAY afmt565_filter_parser('fmmusite') TO s_browse[1].b_fmmusite
            DISPLAY afmt565_filter_parser('fmmu001') TO s_browse[1].b_fmmu001
            DISPLAY afmt565_filter_parser('fmmudocno') TO s_browse[1].b_fmmudocno
            DISPLAY afmt565_filter_parser('fmmudocdt') TO s_browse[1].b_fmmudocdt
            DISPLAY afmt565_filter_parser('fmmu002') TO s_browse[1].b_fmmu002
            DISPLAY afmt565_filter_parser('fmmu003') TO s_browse[1].b_fmmu003
            DISPLAY afmt565_filter_parser('fmmu004') TO s_browse[1].b_fmmu004
      
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
 
      CALL afmt565_filter_show('fmmusite')
   CALL afmt565_filter_show('fmmu001')
   CALL afmt565_filter_show('fmmudocno')
   CALL afmt565_filter_show('fmmudocdt')
   CALL afmt565_filter_show('fmmu002')
   CALL afmt565_filter_show('fmmu003')
   CALL afmt565_filter_show('fmmu004')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt565.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION afmt565_filter_parser(ps_field)
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
 
{<section id="afmt565.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION afmt565_filter_show(ps_field)
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
   LET ls_condition = afmt565_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmt565.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt565_query()
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
   CALL g_fmng_d.clear()
   CALL g_fmng2_d.clear()
   CALL g_fmng3_d.clear()
   CALL g_fmng4_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afmt565_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt565_browser_fill("")
      CALL afmt565_fetch("")
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
      CALL afmt565_filter_show('fmmusite')
   CALL afmt565_filter_show('fmmu001')
   CALL afmt565_filter_show('fmmudocno')
   CALL afmt565_filter_show('fmmudocdt')
   CALL afmt565_filter_show('fmmu002')
   CALL afmt565_filter_show('fmmu003')
   CALL afmt565_filter_show('fmmu004')
   CALL afmt565_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afmt565_fetch("F") 
      #顯示單身筆數
      CALL afmt565_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt565.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt565_fetch(p_flag)
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
   
   LET g_fmmu_m.fmmudocno = g_browser[g_current_idx].b_fmmudocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afmt565_master_referesh USING g_fmmu_m.fmmudocno INTO g_fmmu_m.fmmusite,g_fmmu_m.fmmu001, 
       g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmu002,g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus, 
       g_fmmu_m.fmmuownid,g_fmmu_m.fmmuowndp,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtdp,g_fmmu_m.fmmucrtdt, 
       g_fmmu_m.fmmumodid,g_fmmu_m.fmmumoddt,g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid, 
       g_fmmu_m.fmmupstdt,g_fmmu_m.fmmuownid_desc,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid_desc,g_fmmu_m.fmmucrtdp_desc, 
       g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmupstid_desc
   
   #遮罩相關處理
   LET g_fmmu_m_mask_o.* =  g_fmmu_m.*
   CALL afmt565_fmmu_t_mask()
   LET g_fmmu_m_mask_n.* =  g_fmmu_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt565_set_act_visible()   
   CALL afmt565_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fmmu_m_t.* = g_fmmu_m.*
   LET g_fmmu_m_o.* = g_fmmu_m.*
   
   LET g_data_owner = g_fmmu_m.fmmuownid      
   LET g_data_dept  = g_fmmu_m.fmmuowndp
   
   #重新顯示   
   CALL afmt565_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt565.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt565_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fmng_d.clear()   
   CALL g_fmng2_d.clear()  
   CALL g_fmng3_d.clear()  
   CALL g_fmng4_d.clear()  
 
 
   INITIALIZE g_fmmu_m.* TO NULL             #DEFAULT 設定
   
   LET g_fmmudocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmmu_m.fmmuownid = g_user
      LET g_fmmu_m.fmmuowndp = g_dept
      LET g_fmmu_m.fmmucrtid = g_user
      LET g_fmmu_m.fmmucrtdp = g_dept 
      LET g_fmmu_m.fmmucrtdt = cl_get_current()
      LET g_fmmu_m.fmmumodid = g_user
      LET g_fmmu_m.fmmumoddt = cl_get_current()
      LET g_fmmu_m.fmmustus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_fmmu_m_t.* = g_fmmu_m.*
      LET g_fmmu_m_o.* = g_fmmu_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmu_m.fmmustus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         
      END CASE
 
 
 
    
      CALL afmt565_input("a")
      
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
         INITIALIZE g_fmmu_m.* TO NULL
         INITIALIZE g_fmng_d TO NULL
         INITIALIZE g_fmng2_d TO NULL
         INITIALIZE g_fmng3_d TO NULL
         INITIALIZE g_fmng4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afmt565_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fmng_d.clear()
      #CALL g_fmng2_d.clear()
      #CALL g_fmng3_d.clear()
      #CALL g_fmng4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt565_set_act_visible()   
   CALL afmt565_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmmudocno_t = g_fmmu_m.fmmudocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmmuent = " ||g_enterprise|| " AND",
                      " fmmudocno = '", g_fmmu_m.fmmudocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt565_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afmt565_cl
   
   CALL afmt565_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt565_master_referesh USING g_fmmu_m.fmmudocno INTO g_fmmu_m.fmmusite,g_fmmu_m.fmmu001, 
       g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmu002,g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus, 
       g_fmmu_m.fmmuownid,g_fmmu_m.fmmuowndp,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtdp,g_fmmu_m.fmmucrtdt, 
       g_fmmu_m.fmmumodid,g_fmmu_m.fmmumoddt,g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid, 
       g_fmmu_m.fmmupstdt,g_fmmu_m.fmmuownid_desc,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid_desc,g_fmmu_m.fmmucrtdp_desc, 
       g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmupstid_desc
   
   
   #遮罩相關處理
   LET g_fmmu_m_mask_o.* =  g_fmmu_m.*
   CALL afmt565_fmmu_t_mask()
   LET g_fmmu_m_mask_n.* =  g_fmmu_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmmu_m.fmmusite,g_fmmu_m.fmmusite_desc,g_fmmu_m.fmmu001,g_fmmu_m.fmmu001_desc,g_fmmu_m.l_comp, 
       g_fmmu_m.comp_desc,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocno_desc,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmu002, 
       g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus,g_fmmu_m.fmmuownid,g_fmmu_m.fmmuownid_desc, 
       g_fmmu_m.fmmuowndp,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtid_desc,g_fmmu_m.fmmucrtdp, 
       g_fmmu_m.fmmucrtdp_desc,g_fmmu_m.fmmucrtdt,g_fmmu_m.fmmumodid,g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmumoddt, 
       g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid,g_fmmu_m.fmmupstid_desc, 
       g_fmmu_m.fmmupstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_fmmu_m.fmmuownid      
   LET g_data_dept  = g_fmmu_m.fmmuowndp
   
   #功能已完成,通報訊息中心
   CALL afmt565_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt565_modify()
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
   LET g_fmmu_m_t.* = g_fmmu_m.*
   LET g_fmmu_m_o.* = g_fmmu_m.*
   
   IF g_fmmu_m.fmmudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_fmmudocno_t = g_fmmu_m.fmmudocno
 
   CALL s_transaction_begin()
   
   OPEN afmt565_cl USING g_enterprise,g_fmmu_m.fmmudocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt565_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt565_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt565_master_referesh USING g_fmmu_m.fmmudocno INTO g_fmmu_m.fmmusite,g_fmmu_m.fmmu001, 
       g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmu002,g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus, 
       g_fmmu_m.fmmuownid,g_fmmu_m.fmmuowndp,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtdp,g_fmmu_m.fmmucrtdt, 
       g_fmmu_m.fmmumodid,g_fmmu_m.fmmumoddt,g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid, 
       g_fmmu_m.fmmupstdt,g_fmmu_m.fmmuownid_desc,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid_desc,g_fmmu_m.fmmucrtdp_desc, 
       g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmupstid_desc
   
   #檢查是否允許此動作
   IF NOT afmt565_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmmu_m_mask_o.* =  g_fmmu_m.*
   CALL afmt565_fmmu_t_mask()
   LET g_fmmu_m_mask_n.* =  g_fmmu_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL afmt565_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_fmmudocno_t = g_fmmu_m.fmmudocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_fmmu_m.fmmumodid = g_user 
LET g_fmmu_m.fmmumoddt = cl_get_current()
LET g_fmmu_m.fmmumodid_desc = cl_get_username(g_fmmu_m.fmmumodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_fmmu_m.fmmustus MATCHES "[DR]" THEN
         LET g_fmmu_m.fmmustus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afmt565_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE fmmu_t SET (fmmumodid,fmmumoddt) = (g_fmmu_m.fmmumodid,g_fmmu_m.fmmumoddt)
          WHERE fmmuent = g_enterprise AND fmmudocno = g_fmmudocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_fmmu_m.* = g_fmmu_m_t.*
            CALL afmt565_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_fmmu_m.fmmudocno != g_fmmu_m_t.fmmudocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE fmng_t SET fmngdocno = g_fmmu_m.fmmudocno
 
          WHERE fmngent = g_enterprise AND fmngdocno = g_fmmu_m_t.fmmudocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmng_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
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
   CALL afmt565_set_act_visible()   
   CALL afmt565_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmmuent = " ||g_enterprise|| " AND",
                      " fmmudocno = '", g_fmmu_m.fmmudocno, "' "
 
   #填到對應位置
   CALL afmt565_browser_fill("")
 
   CLOSE afmt565_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt565_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afmt565.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt565_input(p_cmd)
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
   DISPLAY BY NAME g_fmmu_m.fmmusite,g_fmmu_m.fmmusite_desc,g_fmmu_m.fmmu001,g_fmmu_m.fmmu001_desc,g_fmmu_m.l_comp, 
       g_fmmu_m.comp_desc,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocno_desc,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmu002, 
       g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus,g_fmmu_m.fmmuownid,g_fmmu_m.fmmuownid_desc, 
       g_fmmu_m.fmmuowndp,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtid_desc,g_fmmu_m.fmmucrtdp, 
       g_fmmu_m.fmmucrtdp_desc,g_fmmu_m.fmmucrtdt,g_fmmu_m.fmmumodid,g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmumoddt, 
       g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid,g_fmmu_m.fmmupstid_desc, 
       g_fmmu_m.fmmupstdt
   
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
   LET g_forupd_sql = "SELECT fmngseq,fmng001,fmng002,fmng003,fmng004,fmng005,fmng006,fmng007,fmng008, 
       fmng009,fmng010,fmng011,fmngseq,fmng012,fmng013,fmng014,fmng015,fmngseq,fmng016,fmng017,fmng018, 
       fmng019,fmngseq,fmng020,fmng021,fmng022,fmng046,fmng023,fmng024,fmng025,fmng026,fmng027,fmng028, 
       fmng029,fmng030,fmng031,fmng032,fmng033,fmng034,fmng035,fmng036,fmng037,fmng038,fmng039,fmng040, 
       fmng041,fmng042,fmng043,fmng044,fmng045 FROM fmng_t WHERE fmngent=? AND fmngdocno=? AND fmngseq=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt565_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afmt565_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt565_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fmmu_m.fmmustus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afmt565.input.head" >}
      #單頭段
      INPUT BY NAME g_fmmu_m.fmmustus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afmt565_cl USING g_enterprise,g_fmmu_m.fmmudocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt565_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt565_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afmt565_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL afmt565_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmustus
            #add-point:BEFORE FIELD fmmustus name="input.b.fmmustus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmustus
            
            #add-point:AFTER FIELD fmmustus name="input.a.fmmustus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmustus
            #add-point:ON CHANGE fmmustus name="input.g.fmmustus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmmustus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmustus
            #add-point:ON ACTION controlp INFIELD fmmustus name="input.c.fmmustus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_fmmu_m.fmmudocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO fmmu_t (fmmuent,fmmusite,fmmu001,fmmudocno,fmmudocdt,fmmu002,fmmu003,fmmu004, 
                   fmmustus,fmmuownid,fmmuowndp,fmmucrtid,fmmucrtdp,fmmucrtdt,fmmumodid,fmmumoddt,fmmucnfid, 
                   fmmucnfdt,fmmupstid,fmmupstdt)
               VALUES (g_enterprise,g_fmmu_m.fmmusite,g_fmmu_m.fmmu001,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt, 
                   g_fmmu_m.fmmu002,g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus,g_fmmu_m.fmmuownid, 
                   g_fmmu_m.fmmuowndp,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtdp,g_fmmu_m.fmmucrtdt,g_fmmu_m.fmmumodid, 
                   g_fmmu_m.fmmumoddt,g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid,g_fmmu_m.fmmupstdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_fmmu_m:",SQLERRMESSAGE 
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
                  CALL afmt565_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afmt565_b_fill()
                  CALL afmt565_b_fill2('0')
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
               CALL afmt565_fmmu_t_mask_restore('restore_mask_o')
               
               UPDATE fmmu_t SET (fmmusite,fmmu001,fmmudocno,fmmudocdt,fmmu002,fmmu003,fmmu004,fmmustus, 
                   fmmuownid,fmmuowndp,fmmucrtid,fmmucrtdp,fmmucrtdt,fmmumodid,fmmumoddt,fmmucnfid,fmmucnfdt, 
                   fmmupstid,fmmupstdt) = (g_fmmu_m.fmmusite,g_fmmu_m.fmmu001,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt, 
                   g_fmmu_m.fmmu002,g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus,g_fmmu_m.fmmuownid, 
                   g_fmmu_m.fmmuowndp,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtdp,g_fmmu_m.fmmucrtdt,g_fmmu_m.fmmumodid, 
                   g_fmmu_m.fmmumoddt,g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid,g_fmmu_m.fmmupstdt) 
 
                WHERE fmmuent = g_enterprise AND fmmudocno = g_fmmudocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fmmu_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afmt565_fmmu_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_fmmu_m_t)
               LET g_log2 = util.JSON.stringify(g_fmmu_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_fmmudocno_t = g_fmmu_m.fmmudocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afmt565.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fmng_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #151029-00012#11 mark ------
            ##若使用的幣別跟主帳套一樣，匯率不能修改
            #IF g_fmng_d[l_ac].fmng003 = g_glaa.glaa001 THEN
            #   NEXT FIELD fmng012
            #END IF
            #151029-00012#11 mark end---
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmng_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt565_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','3','4',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fmng_d.getLength()
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
            OPEN afmt565_cl USING g_enterprise,g_fmmu_m.fmmudocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt565_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt565_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmng_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmng_d[l_ac].fmngseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fmng_d_t.* = g_fmng_d[l_ac].*  #BACKUP
               LET g_fmng_d_o.* = g_fmng_d[l_ac].*  #BACKUP
               CALL afmt565_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afmt565_set_no_entry_b(l_cmd)
               IF NOT afmt565_lock_b("fmng_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt565_bcl INTO g_fmng_d[l_ac].fmngseq,g_fmng_d[l_ac].fmng001,g_fmng_d[l_ac].fmng002, 
                      g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng004,g_fmng_d[l_ac].fmng005,g_fmng_d[l_ac].fmng006, 
                      g_fmng_d[l_ac].fmng007,g_fmng_d[l_ac].fmng008,g_fmng_d[l_ac].fmng009,g_fmng_d[l_ac].fmng010, 
                      g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmngseq,g_fmng2_d[l_ac].fmng012,g_fmng2_d[l_ac].fmng013, 
                      g_fmng2_d[l_ac].fmng014,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmngseq,g_fmng3_d[l_ac].fmng016, 
                      g_fmng3_d[l_ac].fmng017,g_fmng3_d[l_ac].fmng018,g_fmng3_d[l_ac].fmng019,g_fmng4_d[l_ac].fmngseq, 
                      g_fmng4_d[l_ac].fmng020,g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng046, 
                      g_fmng4_d[l_ac].fmng023,g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng025,g_fmng4_d[l_ac].fmng026, 
                      g_fmng4_d[l_ac].fmng027,g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng029,g_fmng4_d[l_ac].fmng030, 
                      g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng033,g_fmng4_d[l_ac].fmng034, 
                      g_fmng4_d[l_ac].fmng035,g_fmng4_d[l_ac].fmng036,g_fmng4_d[l_ac].fmng037,g_fmng4_d[l_ac].fmng038, 
                      g_fmng4_d[l_ac].fmng039,g_fmng4_d[l_ac].fmng040,g_fmng4_d[l_ac].fmng041,g_fmng4_d[l_ac].fmng042, 
                      g_fmng4_d[l_ac].fmng043,g_fmng4_d[l_ac].fmng044,g_fmng4_d[l_ac].fmng045
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmng_d_t.fmngseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmng_d_mask_o[l_ac].* =  g_fmng_d[l_ac].*
                  CALL afmt565_fmng_t_mask()
                  LET g_fmng_d_mask_n[l_ac].* =  g_fmng_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt565_show()
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
            INITIALIZE g_fmng_d[l_ac].* TO NULL 
            INITIALIZE g_fmng_d_t.* TO NULL 
            INITIALIZE g_fmng_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_fmng_d[l_ac].fmng004 = "0"
      LET g_fmng_d[l_ac].l_fmmt007 = "0"
      LET g_fmng_d[l_ac].l_fmmt008 = "0"
      LET g_fmng_d[l_ac].fmng005 = "0"
      LET g_fmng_d[l_ac].fmng006 = "0"
      LET g_fmng_d[l_ac].fmng007 = "0"
      LET g_fmng_d[l_ac].fmng009 = "0"
      LET g_fmng_d[l_ac].fmng010 = "0"
      LET g_fmng_d[l_ac].fmng011 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_fmng_d_t.* = g_fmng_d[l_ac].*     #新輸入資料
            LET g_fmng_d_o.* = g_fmng_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt565_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt565_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmng_d[li_reproduce_target].* = g_fmng_d[li_reproduce].*
               LET g_fmng2_d[li_reproduce_target].* = g_fmng2_d[li_reproduce].*
               LET g_fmng3_d[li_reproduce_target].* = g_fmng3_d[li_reproduce].*
               LET g_fmng4_d[li_reproduce_target].* = g_fmng4_d[li_reproduce].*
 
               LET g_fmng_d[li_reproduce_target].fmngseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM fmng_t 
             WHERE fmngent = g_enterprise AND fmngdocno = g_fmmu_m.fmmudocno
 
               AND fmngseq = g_fmng_d[l_ac].fmngseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmu_m.fmmudocno
               LET gs_keys[2] = g_fmng_d[g_detail_idx].fmngseq
               CALL afmt565_insert_b('fmng_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_fmng_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt565_b_fill()
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
               LET gs_keys[01] = g_fmmu_m.fmmudocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_fmng_d_t.fmngseq
 
            
               #刪除同層單身
               IF NOT afmt565_delete_b('fmng_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt565_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt565_key_delete_b(gs_keys,'fmng_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt565_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt565_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_fmng_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmng_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmngseq
            #add-point:BEFORE FIELD fmngseq name="input.b.page1.fmngseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmngseq
            
            #add-point:AFTER FIELD fmngseq name="input.a.page1.fmngseq"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmngseq
            #add-point:ON CHANGE fmngseq name="input.g.page1.fmngseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng001
            #add-point:BEFORE FIELD fmng001 name="input.b.page1.fmng001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng001
            
            #add-point:AFTER FIELD fmng001 name="input.a.page1.fmng001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng001
            #add-point:ON CHANGE fmng001 name="input.g.page1.fmng001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng002
            #add-point:BEFORE FIELD fmng002 name="input.b.page1.fmng002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng002
            
            #add-point:AFTER FIELD fmng002 name="input.a.page1.fmng002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng002
            #add-point:ON CHANGE fmng002 name="input.g.page1.fmng002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng005
            #add-point:BEFORE FIELD fmng005 name="input.b.page1.fmng005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng005
            
            #add-point:AFTER FIELD fmng005 name="input.a.page1.fmng005"
            #151029-00012#11 add ------
            #變動本期計提金額
            IF  NOT cl_null(g_fmng_d[l_ac].fmng005) THEN
               IF ( g_fmng_d[l_ac].fmng005 != g_fmng_d_t.fmng005 OR g_fmng_d_t.fmng005 IS NULL ) THEN
                  #取位
                  CALL s_curr_round_ld('1',g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng005,2) RETURNING g_sub_success,g_errno,g_fmng_d[l_ac].fmng005
                  #計算投資收益
                  LET g_fmng_d[l_ac].fmng007 = g_fmng_d[l_ac].fmng005 + g_fmng_d[l_ac].fmng006
                  #推算各本位幣-本期計提金額
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng005)
                       RETURNING g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017
                  #推算各本位幣-利息調整
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng006)
                       RETURNING g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018
                  #推算各本位幣-投資收益
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng007)
                       RETURNING g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
               END IF
               DISPLAY BY NAME g_fmng_d[l_ac].fmng005,g_fmng_d[l_ac].fmng006,g_fmng_d[l_ac].fmng007,
                               g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017,
                               g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018,
                               g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
            END IF
            #151029-00012#11 add end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng005
            #add-point:ON CHANGE fmng005 name="input.g.page1.fmng005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng006
            #add-point:BEFORE FIELD fmng006 name="input.b.page1.fmng006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng006
            
            #add-point:AFTER FIELD fmng006 name="input.a.page1.fmng006"
            #151029-00012#11 add ------
            #變動利息調整
            IF  NOT cl_null(g_fmng_d[l_ac].fmng006) THEN
               IF ( g_fmng_d[l_ac].fmng006 != g_fmng_d_t.fmng006 OR g_fmng_d_t.fmng006 IS NULL ) THEN
                  #取位
                  CALL s_curr_round_ld('1',g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng006,2) RETURNING g_sub_success,g_errno,g_fmng_d[l_ac].fmng006
                  #計算投資收益
                  LET g_fmng_d[l_ac].fmng007 = g_fmng_d[l_ac].fmng005 + g_fmng_d[l_ac].fmng006
                  #推算各本位幣-本期計提金額
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng005)
                       RETURNING g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017
                  #推算各本位幣-利息調整
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng006)
                       RETURNING g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018
                  #推算各本位幣-投資收益
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng007)
                       RETURNING g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
               END IF
               DISPLAY BY NAME g_fmng_d[l_ac].fmng005,g_fmng_d[l_ac].fmng006,g_fmng_d[l_ac].fmng007,
                               g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017,
                               g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018,
                               g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
            END IF
            #151029-00012#11 add end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng006
            #add-point:ON CHANGE fmng006 name="input.g.page1.fmng006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng007
            #add-point:BEFORE FIELD fmng007 name="input.b.page1.fmng007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng007
            
            #add-point:AFTER FIELD fmng007 name="input.a.page1.fmng007"
            #151029-00012#11 add ------
            #變動投資收益
            IF  NOT cl_null(g_fmng_d[l_ac].fmng007) THEN
               IF ( g_fmng_d[l_ac].fmng007 != g_fmng_d_t.fmng007 OR g_fmng_d_t.fmng007 IS NULL ) THEN
                  #取位
                  CALL s_curr_round_ld('1',g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng007,2) RETURNING g_sub_success,g_errno,g_fmng_d[l_ac].fmng007
                  #推算各本位幣-本期計提金額
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng005)
                       RETURNING g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017
                  #推算各本位幣-利息調整
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng006)
                       RETURNING g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018
                  #推算各本位幣-投資收益
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng007)
                       RETURNING g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
               END IF
               DISPLAY BY NAME g_fmng_d[l_ac].fmng005,g_fmng_d[l_ac].fmng006,g_fmng_d[l_ac].fmng007,
                               g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017,
                               g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018,
                               g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
            END IF
            #151029-00012#11 add end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng007
            #add-point:ON CHANGE fmng007 name="input.g.page1.fmng007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng008
            #add-point:BEFORE FIELD fmng008 name="input.b.page1.fmng008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng008
            
            #add-point:AFTER FIELD fmng008 name="input.a.page1.fmng008"
            #變動匯率一之後
            IF  NOT cl_null(g_fmng_d[l_ac].fmng008) THEN
               IF ( g_fmng_d[l_ac].fmng008 != g_fmng_d_t.fmng008 OR g_fmng_d_t.fmng008 IS NULL ) THEN
                  #取位
                  CALL s_curr_round_ld('1',g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng008,3) RETURNING g_sub_success,g_errno,g_fmng_d[l_ac].fmng008
                  #推算各本位幣-本期計提金額
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng005)
                       RETURNING g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017
                  #推算各本位幣-利息調整
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng006)
                       RETURNING g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018
                  #推算各本位幣-投資收益
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng007)
                       RETURNING g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
               END IF
               DISPLAY BY NAME g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017,
                               g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018,
                               g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng008
            #add-point:ON CHANGE fmng008 name="input.g.page1.fmng008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng009
            #add-point:BEFORE FIELD fmng009 name="input.b.page1.fmng009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng009
            
            #add-point:AFTER FIELD fmng009 name="input.a.page1.fmng009"
            #151029-00012#11 add ------
            #變動本期計提金額(本幣一)
            IF  NOT cl_null(g_fmng_d[l_ac].fmng009) THEN
               IF ( g_fmng_d[l_ac].fmng009 != g_fmng_d_t.fmng009 OR g_fmng_d_t.fmng009 IS NULL ) THEN
                  #取位
                  CALL s_curr_round_ld('1',g_fmmu_m.fmmu001,g_glaa.glaa001,g_fmng_d[l_ac].fmng009,2) RETURNING g_sub_success,g_errno,g_fmng_d[l_ac].fmng009
                  #計算投資收益
                  LET g_fmng_d[l_ac].fmng011 = g_fmng_d[l_ac].fmng009 + g_fmng_d[l_ac].fmng010
               END IF
               DISPLAY BY NAME g_fmng_d[l_ac].fmng009,g_fmng_d[l_ac].fmng010,g_fmng_d[l_ac].fmng011
            END IF
            #151029-00012#11 add end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng009
            #add-point:ON CHANGE fmng009 name="input.g.page1.fmng009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng010
            #add-point:BEFORE FIELD fmng010 name="input.b.page1.fmng010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng010
            
            #add-point:AFTER FIELD fmng010 name="input.a.page1.fmng010"
            #151029-00012#11 add ------
            #變動本期計提金額(本幣一)
            IF  NOT cl_null(g_fmng_d[l_ac].fmng010) THEN
               IF ( g_fmng_d[l_ac].fmng010 != g_fmng_d_t.fmng010 OR g_fmng_d_t.fmng010 IS NULL ) THEN
                  #取位
                  CALL s_curr_round_ld('1',g_fmmu_m.fmmu001,g_glaa.glaa001,g_fmng_d[l_ac].fmng010,2) RETURNING g_sub_success,g_errno,g_fmng_d[l_ac].fmng010
                  #計算投資收益
                  LET g_fmng_d[l_ac].fmng011 = g_fmng_d[l_ac].fmng009 + g_fmng_d[l_ac].fmng010
               END IF
               DISPLAY BY NAME g_fmng_d[l_ac].fmng009,g_fmng_d[l_ac].fmng010,g_fmng_d[l_ac].fmng011
            END IF
            #151029-00012#11 add end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng010
            #add-point:ON CHANGE fmng010 name="input.g.page1.fmng010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng011
            #add-point:BEFORE FIELD fmng011 name="input.b.page1.fmng011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng011
            
            #add-point:AFTER FIELD fmng011 name="input.a.page1.fmng011"
            #151029-00012#11 add ------
            #變動本期計提金額(本幣一)
            IF  NOT cl_null(g_fmng_d[l_ac].fmng011) THEN
               IF ( g_fmng_d[l_ac].fmng011 != g_fmng_d_t.fmng011 OR g_fmng_d_t.fmng011 IS NULL ) THEN
                  #取位
                  CALL s_curr_round_ld('1',g_fmmu_m.fmmu001,g_glaa.glaa001,g_fmng_d[l_ac].fmng011,2) RETURNING g_sub_success,g_errno,g_fmng_d[l_ac].fmng011
               END IF
               DISPLAY BY NAME g_fmng_d[l_ac].fmng009,g_fmng_d[l_ac].fmng010,g_fmng_d[l_ac].fmng011
            END IF
            #151029-00012#11 add end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng011
            #add-point:ON CHANGE fmng011 name="input.g.page1.fmng011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fmngseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmngseq
            #add-point:ON ACTION controlp INFIELD fmngseq name="input.c.page1.fmngseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmng001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng001
            #add-point:ON ACTION controlp INFIELD fmng001 name="input.c.page1.fmng001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmng002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng002
            #add-point:ON ACTION controlp INFIELD fmng002 name="input.c.page1.fmng002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmng005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng005
            #add-point:ON ACTION controlp INFIELD fmng005 name="input.c.page1.fmng005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmng006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng006
            #add-point:ON ACTION controlp INFIELD fmng006 name="input.c.page1.fmng006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmng007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng007
            #add-point:ON ACTION controlp INFIELD fmng007 name="input.c.page1.fmng007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmng008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng008
            #add-point:ON ACTION controlp INFIELD fmng008 name="input.c.page1.fmng008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmng009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng009
            #add-point:ON ACTION controlp INFIELD fmng009 name="input.c.page1.fmng009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmng010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng010
            #add-point:ON ACTION controlp INFIELD fmng010 name="input.c.page1.fmng010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmng011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng011
            #add-point:ON ACTION controlp INFIELD fmng011 name="input.c.page1.fmng011"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmng_d[l_ac].* = g_fmng_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt565_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fmng_d[l_ac].fmngseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fmng_d[l_ac].* = g_fmng_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afmt565_fmng_t_mask_restore('restore_mask_o')
      
               UPDATE fmng_t SET (fmngdocno,fmngseq,fmng001,fmng002,fmng003,fmng004,fmng005,fmng006, 
                   fmng007,fmng008,fmng009,fmng010,fmng011,fmng012,fmng013,fmng014,fmng015,fmng016,fmng017, 
                   fmng018,fmng019,fmng020,fmng021,fmng022,fmng046,fmng023,fmng024,fmng025,fmng026,fmng027, 
                   fmng028,fmng029,fmng030,fmng031,fmng032,fmng033,fmng034,fmng035,fmng036,fmng037,fmng038, 
                   fmng039,fmng040,fmng041,fmng042,fmng043,fmng044,fmng045) = (g_fmmu_m.fmmudocno,g_fmng_d[l_ac].fmngseq, 
                   g_fmng_d[l_ac].fmng001,g_fmng_d[l_ac].fmng002,g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng004, 
                   g_fmng_d[l_ac].fmng005,g_fmng_d[l_ac].fmng006,g_fmng_d[l_ac].fmng007,g_fmng_d[l_ac].fmng008, 
                   g_fmng_d[l_ac].fmng009,g_fmng_d[l_ac].fmng010,g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng012, 
                   g_fmng2_d[l_ac].fmng013,g_fmng2_d[l_ac].fmng014,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng016, 
                   g_fmng3_d[l_ac].fmng017,g_fmng3_d[l_ac].fmng018,g_fmng3_d[l_ac].fmng019,g_fmng4_d[l_ac].fmng020, 
                   g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng046,g_fmng4_d[l_ac].fmng023, 
                   g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng025,g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng027, 
                   g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng029,g_fmng4_d[l_ac].fmng030,g_fmng4_d[l_ac].fmng031, 
                   g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng033,g_fmng4_d[l_ac].fmng034,g_fmng4_d[l_ac].fmng035, 
                   g_fmng4_d[l_ac].fmng036,g_fmng4_d[l_ac].fmng037,g_fmng4_d[l_ac].fmng038,g_fmng4_d[l_ac].fmng039, 
                   g_fmng4_d[l_ac].fmng040,g_fmng4_d[l_ac].fmng041,g_fmng4_d[l_ac].fmng042,g_fmng4_d[l_ac].fmng043, 
                   g_fmng4_d[l_ac].fmng044,g_fmng4_d[l_ac].fmng045)
                WHERE fmngent = g_enterprise AND fmngdocno = g_fmmu_m.fmmudocno 
 
                  AND fmngseq = g_fmng_d_t.fmngseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmng_d[l_ac].* = g_fmng_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmng_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmng_d[l_ac].* = g_fmng_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmu_m.fmmudocno
               LET gs_keys_bak[1] = g_fmmudocno_t
               LET gs_keys[2] = g_fmng_d[g_detail_idx].fmngseq
               LET gs_keys_bak[2] = g_fmng_d_t.fmngseq
               CALL afmt565_update_b('fmng_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afmt565_fmng_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fmng_d[g_detail_idx].fmngseq = g_fmng_d_t.fmngseq 
 
                  ) THEN
                  LET gs_keys[01] = g_fmmu_m.fmmudocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fmng_d_t.fmngseq
 
                  CALL afmt565_key_update_b(gs_keys,'fmng_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmmu_m),util.JSON.stringify(g_fmng_d_t)
               LET g_log2 = util.JSON.stringify(g_fmmu_m),util.JSON.stringify(g_fmng_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afmt565_unlock_b("fmng_t","'1'")
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
               LET g_fmng_d[li_reproduce_target].* = g_fmng_d[li_reproduce].*
               LET g_fmng2_d[li_reproduce_target].* = g_fmng2_d[li_reproduce].*
               LET g_fmng3_d[li_reproduce_target].* = g_fmng3_d[li_reproduce].*
               LET g_fmng4_d[li_reproduce_target].* = g_fmng4_d[li_reproduce].*
 
               LET g_fmng_d[li_reproduce_target].fmngseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmng_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmng_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_fmng2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            #若使用的幣別跟主帳套一樣，匯率不能修改
            IF g_fmng_d[l_ac].fmng003 = g_glaa.glaa016 THEN
               NEXT FIELD fmng016
            END IF
            #end add-point
            
            CALL afmt565_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmng2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmng2_d[l_ac].* TO NULL 
            INITIALIZE g_fmng2_d_t.* TO NULL 
            INITIALIZE g_fmng2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_fmng2_d[l_ac].fmng013 = "0"
      LET g_fmng2_d[l_ac].fmng014 = "0"
      LET g_fmng2_d[l_ac].fmng015 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_fmng2_d_t.* = g_fmng2_d[l_ac].*     #新輸入資料
            LET g_fmng2_d_o.* = g_fmng2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt565_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt565_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmng_d[li_reproduce_target].* = g_fmng_d[li_reproduce].*
               LET g_fmng2_d[li_reproduce_target].* = g_fmng2_d[li_reproduce].*
               LET g_fmng3_d[li_reproduce_target].* = g_fmng3_d[li_reproduce].*
               LET g_fmng4_d[li_reproduce_target].* = g_fmng4_d[li_reproduce].*
 
               LET g_fmng2_d[li_reproduce_target].fmngseq = NULL
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
            OPEN afmt565_cl USING g_enterprise,g_fmmu_m.fmmudocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt565_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt565_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmng2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmng2_d[l_ac].fmngseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmng2_d_t.* = g_fmng2_d[l_ac].*  #BACKUP
               LET g_fmng2_d_o.* = g_fmng2_d[l_ac].*  #BACKUP
               CALL afmt565_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL afmt565_set_no_entry_b(l_cmd)
               IF NOT afmt565_lock_b("fmng_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt565_bcl INTO g_fmng_d[l_ac].fmngseq,g_fmng_d[l_ac].fmng001,g_fmng_d[l_ac].fmng002, 
                      g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng004,g_fmng_d[l_ac].fmng005,g_fmng_d[l_ac].fmng006, 
                      g_fmng_d[l_ac].fmng007,g_fmng_d[l_ac].fmng008,g_fmng_d[l_ac].fmng009,g_fmng_d[l_ac].fmng010, 
                      g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmngseq,g_fmng2_d[l_ac].fmng012,g_fmng2_d[l_ac].fmng013, 
                      g_fmng2_d[l_ac].fmng014,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmngseq,g_fmng3_d[l_ac].fmng016, 
                      g_fmng3_d[l_ac].fmng017,g_fmng3_d[l_ac].fmng018,g_fmng3_d[l_ac].fmng019,g_fmng4_d[l_ac].fmngseq, 
                      g_fmng4_d[l_ac].fmng020,g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng046, 
                      g_fmng4_d[l_ac].fmng023,g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng025,g_fmng4_d[l_ac].fmng026, 
                      g_fmng4_d[l_ac].fmng027,g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng029,g_fmng4_d[l_ac].fmng030, 
                      g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng033,g_fmng4_d[l_ac].fmng034, 
                      g_fmng4_d[l_ac].fmng035,g_fmng4_d[l_ac].fmng036,g_fmng4_d[l_ac].fmng037,g_fmng4_d[l_ac].fmng038, 
                      g_fmng4_d[l_ac].fmng039,g_fmng4_d[l_ac].fmng040,g_fmng4_d[l_ac].fmng041,g_fmng4_d[l_ac].fmng042, 
                      g_fmng4_d[l_ac].fmng043,g_fmng4_d[l_ac].fmng044,g_fmng4_d[l_ac].fmng045
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmng2_d_mask_o[l_ac].* =  g_fmng2_d[l_ac].*
                  CALL afmt565_fmng_t_mask()
                  LET g_fmng2_d_mask_n[l_ac].* =  g_fmng2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt565_show()
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
               LET gs_keys[01] = g_fmmu_m.fmmudocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmng2_d_t.fmngseq
            
               #刪除同層單身
               IF NOT afmt565_delete_b('fmng_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt565_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt565_key_delete_b(gs_keys,'fmng_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt565_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt565_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_fmng_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmng2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM fmng_t 
             WHERE fmngent = g_enterprise AND fmngdocno = g_fmmu_m.fmmudocno
               AND fmngseq = g_fmng2_d[l_ac].fmngseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmu_m.fmmudocno
               LET gs_keys[2] = g_fmng2_d[g_detail_idx].fmngseq
               CALL afmt565_insert_b('fmng_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmng_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt565_b_fill()
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
               LET g_fmng2_d[l_ac].* = g_fmng2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt565_bcl
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
               LET g_fmng2_d[l_ac].* = g_fmng2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL afmt565_fmng_t_mask_restore('restore_mask_o')
                              
               UPDATE fmng_t SET (fmngdocno,fmngseq,fmng001,fmng002,fmng003,fmng004,fmng005,fmng006, 
                   fmng007,fmng008,fmng009,fmng010,fmng011,fmng012,fmng013,fmng014,fmng015,fmng016,fmng017, 
                   fmng018,fmng019,fmng020,fmng021,fmng022,fmng046,fmng023,fmng024,fmng025,fmng026,fmng027, 
                   fmng028,fmng029,fmng030,fmng031,fmng032,fmng033,fmng034,fmng035,fmng036,fmng037,fmng038, 
                   fmng039,fmng040,fmng041,fmng042,fmng043,fmng044,fmng045) = (g_fmmu_m.fmmudocno,g_fmng_d[l_ac].fmngseq, 
                   g_fmng_d[l_ac].fmng001,g_fmng_d[l_ac].fmng002,g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng004, 
                   g_fmng_d[l_ac].fmng005,g_fmng_d[l_ac].fmng006,g_fmng_d[l_ac].fmng007,g_fmng_d[l_ac].fmng008, 
                   g_fmng_d[l_ac].fmng009,g_fmng_d[l_ac].fmng010,g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng012, 
                   g_fmng2_d[l_ac].fmng013,g_fmng2_d[l_ac].fmng014,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng016, 
                   g_fmng3_d[l_ac].fmng017,g_fmng3_d[l_ac].fmng018,g_fmng3_d[l_ac].fmng019,g_fmng4_d[l_ac].fmng020, 
                   g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng046,g_fmng4_d[l_ac].fmng023, 
                   g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng025,g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng027, 
                   g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng029,g_fmng4_d[l_ac].fmng030,g_fmng4_d[l_ac].fmng031, 
                   g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng033,g_fmng4_d[l_ac].fmng034,g_fmng4_d[l_ac].fmng035, 
                   g_fmng4_d[l_ac].fmng036,g_fmng4_d[l_ac].fmng037,g_fmng4_d[l_ac].fmng038,g_fmng4_d[l_ac].fmng039, 
                   g_fmng4_d[l_ac].fmng040,g_fmng4_d[l_ac].fmng041,g_fmng4_d[l_ac].fmng042,g_fmng4_d[l_ac].fmng043, 
                   g_fmng4_d[l_ac].fmng044,g_fmng4_d[l_ac].fmng045) #自訂欄位頁簽
                WHERE fmngent = g_enterprise AND fmngdocno = g_fmmu_m.fmmudocno
                  AND fmngseq = g_fmng2_d_t.fmngseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmng2_d[l_ac].* = g_fmng2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmng_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmng2_d[l_ac].* = g_fmng2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmu_m.fmmudocno
               LET gs_keys_bak[1] = g_fmmudocno_t
               LET gs_keys[2] = g_fmng2_d[g_detail_idx].fmngseq
               LET gs_keys_bak[2] = g_fmng2_d_t.fmngseq
               CALL afmt565_update_b('fmng_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt565_fmng_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmng2_d[g_detail_idx].fmngseq = g_fmng2_d_t.fmngseq 
                  ) THEN
                  LET gs_keys[01] = g_fmmu_m.fmmudocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmng2_d_t.fmngseq
                  CALL afmt565_key_update_b(gs_keys,'fmng_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmmu_m),util.JSON.stringify(g_fmng2_d_t)
               LET g_log2 = util.JSON.stringify(g_fmmu_m),util.JSON.stringify(g_fmng2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng012
            #add-point:BEFORE FIELD fmng012 name="input.b.page2.fmng012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng012
            
            #add-point:AFTER FIELD fmng012 name="input.a.page2.fmng012"
            #變動匯率二之後
            IF  NOT cl_null(g_fmng2_d[l_ac].fmng012) THEN
               IF ( g_fmng2_d[l_ac].fmng012 != g_fmng2_d_t.fmng012 OR g_fmng2_d_t.fmng012 IS NULL ) THEN
                  #推算各本位幣-本期計提金額
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng005)
                       RETURNING g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017
                  #推算各本位幣-利息調整
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng006)
                       RETURNING g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018
                  #推算各本位幣-投資收益
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng007)
                       RETURNING g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
               END IF
               DISPLAY BY NAME g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017,
                               g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018,
                               g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng012
            #add-point:ON CHANGE fmng012 name="input.g.page2.fmng012"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.fmng012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng012
            #add-point:ON ACTION controlp INFIELD fmng012 name="input.c.page2.fmng012"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmng2_d[l_ac].* = g_fmng2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt565_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt565_unlock_b("fmng_t","'2'")
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
               LET g_fmng_d[li_reproduce_target].* = g_fmng_d[li_reproduce].*
               LET g_fmng2_d[li_reproduce_target].* = g_fmng2_d[li_reproduce].*
               LET g_fmng3_d[li_reproduce_target].* = g_fmng3_d[li_reproduce].*
               LET g_fmng4_d[li_reproduce_target].* = g_fmng4_d[li_reproduce].*
 
               LET g_fmng2_d[li_reproduce_target].fmngseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmng2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmng2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_fmng3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            #若使用的幣別跟主帳套一樣，匯率不能修改
            IF g_fmng_d[l_ac].fmng003 = g_glaa.glaa020 THEN
               NEXT FIELD fmng020_desc
            END IF
            #end add-point
            
            CALL afmt565_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmng3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmng3_d[l_ac].* TO NULL 
            INITIALIZE g_fmng3_d_t.* TO NULL 
            INITIALIZE g_fmng3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_fmng3_d[l_ac].fmng017 = "0"
      LET g_fmng3_d[l_ac].fmng018 = "0"
      LET g_fmng3_d[l_ac].fmng019 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_fmng3_d_t.* = g_fmng3_d[l_ac].*     #新輸入資料
            LET g_fmng3_d_o.* = g_fmng3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt565_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt565_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmng_d[li_reproduce_target].* = g_fmng_d[li_reproduce].*
               LET g_fmng2_d[li_reproduce_target].* = g_fmng2_d[li_reproduce].*
               LET g_fmng3_d[li_reproduce_target].* = g_fmng3_d[li_reproduce].*
               LET g_fmng4_d[li_reproduce_target].* = g_fmng4_d[li_reproduce].*
 
               LET g_fmng3_d[li_reproduce_target].fmngseq = NULL
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
            OPEN afmt565_cl USING g_enterprise,g_fmmu_m.fmmudocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt565_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt565_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmng3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmng3_d[l_ac].fmngseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmng3_d_t.* = g_fmng3_d[l_ac].*  #BACKUP
               LET g_fmng3_d_o.* = g_fmng3_d[l_ac].*  #BACKUP
               CALL afmt565_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL afmt565_set_no_entry_b(l_cmd)
               IF NOT afmt565_lock_b("fmng_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt565_bcl INTO g_fmng_d[l_ac].fmngseq,g_fmng_d[l_ac].fmng001,g_fmng_d[l_ac].fmng002, 
                      g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng004,g_fmng_d[l_ac].fmng005,g_fmng_d[l_ac].fmng006, 
                      g_fmng_d[l_ac].fmng007,g_fmng_d[l_ac].fmng008,g_fmng_d[l_ac].fmng009,g_fmng_d[l_ac].fmng010, 
                      g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmngseq,g_fmng2_d[l_ac].fmng012,g_fmng2_d[l_ac].fmng013, 
                      g_fmng2_d[l_ac].fmng014,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmngseq,g_fmng3_d[l_ac].fmng016, 
                      g_fmng3_d[l_ac].fmng017,g_fmng3_d[l_ac].fmng018,g_fmng3_d[l_ac].fmng019,g_fmng4_d[l_ac].fmngseq, 
                      g_fmng4_d[l_ac].fmng020,g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng046, 
                      g_fmng4_d[l_ac].fmng023,g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng025,g_fmng4_d[l_ac].fmng026, 
                      g_fmng4_d[l_ac].fmng027,g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng029,g_fmng4_d[l_ac].fmng030, 
                      g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng033,g_fmng4_d[l_ac].fmng034, 
                      g_fmng4_d[l_ac].fmng035,g_fmng4_d[l_ac].fmng036,g_fmng4_d[l_ac].fmng037,g_fmng4_d[l_ac].fmng038, 
                      g_fmng4_d[l_ac].fmng039,g_fmng4_d[l_ac].fmng040,g_fmng4_d[l_ac].fmng041,g_fmng4_d[l_ac].fmng042, 
                      g_fmng4_d[l_ac].fmng043,g_fmng4_d[l_ac].fmng044,g_fmng4_d[l_ac].fmng045
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmng3_d_mask_o[l_ac].* =  g_fmng3_d[l_ac].*
                  CALL afmt565_fmng_t_mask()
                  LET g_fmng3_d_mask_n[l_ac].* =  g_fmng3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt565_show()
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
               LET gs_keys[01] = g_fmmu_m.fmmudocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmng3_d_t.fmngseq
            
               #刪除同層單身
               IF NOT afmt565_delete_b('fmng_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt565_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt565_key_delete_b(gs_keys,'fmng_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt565_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt565_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_fmng_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmng3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM fmng_t 
             WHERE fmngent = g_enterprise AND fmngdocno = g_fmmu_m.fmmudocno
               AND fmngseq = g_fmng3_d[l_ac].fmngseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmu_m.fmmudocno
               LET gs_keys[2] = g_fmng3_d[g_detail_idx].fmngseq
               CALL afmt565_insert_b('fmng_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmng_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt565_b_fill()
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
               LET g_fmng3_d[l_ac].* = g_fmng3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt565_bcl
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
               LET g_fmng3_d[l_ac].* = g_fmng3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL afmt565_fmng_t_mask_restore('restore_mask_o')
                              
               UPDATE fmng_t SET (fmngdocno,fmngseq,fmng001,fmng002,fmng003,fmng004,fmng005,fmng006, 
                   fmng007,fmng008,fmng009,fmng010,fmng011,fmng012,fmng013,fmng014,fmng015,fmng016,fmng017, 
                   fmng018,fmng019,fmng020,fmng021,fmng022,fmng046,fmng023,fmng024,fmng025,fmng026,fmng027, 
                   fmng028,fmng029,fmng030,fmng031,fmng032,fmng033,fmng034,fmng035,fmng036,fmng037,fmng038, 
                   fmng039,fmng040,fmng041,fmng042,fmng043,fmng044,fmng045) = (g_fmmu_m.fmmudocno,g_fmng_d[l_ac].fmngseq, 
                   g_fmng_d[l_ac].fmng001,g_fmng_d[l_ac].fmng002,g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng004, 
                   g_fmng_d[l_ac].fmng005,g_fmng_d[l_ac].fmng006,g_fmng_d[l_ac].fmng007,g_fmng_d[l_ac].fmng008, 
                   g_fmng_d[l_ac].fmng009,g_fmng_d[l_ac].fmng010,g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng012, 
                   g_fmng2_d[l_ac].fmng013,g_fmng2_d[l_ac].fmng014,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng016, 
                   g_fmng3_d[l_ac].fmng017,g_fmng3_d[l_ac].fmng018,g_fmng3_d[l_ac].fmng019,g_fmng4_d[l_ac].fmng020, 
                   g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng046,g_fmng4_d[l_ac].fmng023, 
                   g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng025,g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng027, 
                   g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng029,g_fmng4_d[l_ac].fmng030,g_fmng4_d[l_ac].fmng031, 
                   g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng033,g_fmng4_d[l_ac].fmng034,g_fmng4_d[l_ac].fmng035, 
                   g_fmng4_d[l_ac].fmng036,g_fmng4_d[l_ac].fmng037,g_fmng4_d[l_ac].fmng038,g_fmng4_d[l_ac].fmng039, 
                   g_fmng4_d[l_ac].fmng040,g_fmng4_d[l_ac].fmng041,g_fmng4_d[l_ac].fmng042,g_fmng4_d[l_ac].fmng043, 
                   g_fmng4_d[l_ac].fmng044,g_fmng4_d[l_ac].fmng045) #自訂欄位頁簽
                WHERE fmngent = g_enterprise AND fmngdocno = g_fmmu_m.fmmudocno
                  AND fmngseq = g_fmng3_d_t.fmngseq #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmng3_d[l_ac].* = g_fmng3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmng_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmng3_d[l_ac].* = g_fmng3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmu_m.fmmudocno
               LET gs_keys_bak[1] = g_fmmudocno_t
               LET gs_keys[2] = g_fmng3_d[g_detail_idx].fmngseq
               LET gs_keys_bak[2] = g_fmng3_d_t.fmngseq
               CALL afmt565_update_b('fmng_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt565_fmng_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmng3_d[g_detail_idx].fmngseq = g_fmng3_d_t.fmngseq 
                  ) THEN
                  LET gs_keys[01] = g_fmmu_m.fmmudocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmng3_d_t.fmngseq
                  CALL afmt565_key_update_b(gs_keys,'fmng_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmmu_m),util.JSON.stringify(g_fmng3_d_t)
               LET g_log2 = util.JSON.stringify(g_fmmu_m),util.JSON.stringify(g_fmng3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng016
            #add-point:BEFORE FIELD fmng016 name="input.b.page3.fmng016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng016
            
            #add-point:AFTER FIELD fmng016 name="input.a.page3.fmng016"
            #變動匯率三之後
            IF  NOT cl_null(g_fmng3_d[l_ac].fmng016) THEN
               IF ( g_fmng3_d[l_ac].fmng016 != g_fmng3_d_t.fmng016 OR g_fmng3_d_t.fmng016 IS NULL ) THEN
                  #推算各本位幣-本期計提金額
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng005)
                       RETURNING g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017
                  #推算各本位幣-利息調整
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng006)
                       RETURNING g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018
                  #推算各本位幣-投資收益
                  CALL s_afm_rate_money(g_fmmu_m.fmmu001,g_fmng_d[l_ac].fmng008,g_fmng2_d[l_ac].fmng012,g_fmng3_d[l_ac].fmng016,g_fmng_d[l_ac].fmng007)
                       RETURNING g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
               END IF
               DISPLAY BY NAME g_fmng_d[l_ac].fmng009,g_fmng2_d[l_ac].fmng013,g_fmng3_d[l_ac].fmng017,
                               g_fmng_d[l_ac].fmng010,g_fmng2_d[l_ac].fmng014,g_fmng3_d[l_ac].fmng018,
                               g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng019
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng016
            #add-point:ON CHANGE fmng016 name="input.g.page3.fmng016"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.fmng016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng016
            #add-point:ON ACTION controlp INFIELD fmng016 name="input.c.page3.fmng016"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmng3_d[l_ac].* = g_fmng3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt565_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt565_unlock_b("fmng_t","'3'")
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
               LET g_fmng_d[li_reproduce_target].* = g_fmng_d[li_reproduce].*
               LET g_fmng2_d[li_reproduce_target].* = g_fmng2_d[li_reproduce].*
               LET g_fmng3_d[li_reproduce_target].* = g_fmng3_d[li_reproduce].*
               LET g_fmng4_d[li_reproduce_target].* = g_fmng4_d[li_reproduce].*
 
               LET g_fmng3_d[li_reproduce_target].fmngseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmng3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmng3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_fmng4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            
            CALL afmt565_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmng4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmng4_d[l_ac].* TO NULL 
            INITIALIZE g_fmng4_d_t.* TO NULL 
            INITIALIZE g_fmng4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_fmng4_d_t.* = g_fmng4_d[l_ac].*     #新輸入資料
            LET g_fmng4_d_o.* = g_fmng4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt565_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt565_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmng_d[li_reproduce_target].* = g_fmng_d[li_reproduce].*
               LET g_fmng2_d[li_reproduce_target].* = g_fmng2_d[li_reproduce].*
               LET g_fmng3_d[li_reproduce_target].* = g_fmng3_d[li_reproduce].*
               LET g_fmng4_d[li_reproduce_target].* = g_fmng4_d[li_reproduce].*
 
               LET g_fmng4_d[li_reproduce_target].fmngseq = NULL
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
            OPEN afmt565_cl USING g_enterprise,g_fmmu_m.fmmudocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt565_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt565_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmng4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmng4_d[l_ac].fmngseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmng4_d_t.* = g_fmng4_d[l_ac].*  #BACKUP
               LET g_fmng4_d_o.* = g_fmng4_d[l_ac].*  #BACKUP
               CALL afmt565_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL afmt565_set_no_entry_b(l_cmd)
               IF NOT afmt565_lock_b("fmng_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt565_bcl INTO g_fmng_d[l_ac].fmngseq,g_fmng_d[l_ac].fmng001,g_fmng_d[l_ac].fmng002, 
                      g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng004,g_fmng_d[l_ac].fmng005,g_fmng_d[l_ac].fmng006, 
                      g_fmng_d[l_ac].fmng007,g_fmng_d[l_ac].fmng008,g_fmng_d[l_ac].fmng009,g_fmng_d[l_ac].fmng010, 
                      g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmngseq,g_fmng2_d[l_ac].fmng012,g_fmng2_d[l_ac].fmng013, 
                      g_fmng2_d[l_ac].fmng014,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmngseq,g_fmng3_d[l_ac].fmng016, 
                      g_fmng3_d[l_ac].fmng017,g_fmng3_d[l_ac].fmng018,g_fmng3_d[l_ac].fmng019,g_fmng4_d[l_ac].fmngseq, 
                      g_fmng4_d[l_ac].fmng020,g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng046, 
                      g_fmng4_d[l_ac].fmng023,g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng025,g_fmng4_d[l_ac].fmng026, 
                      g_fmng4_d[l_ac].fmng027,g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng029,g_fmng4_d[l_ac].fmng030, 
                      g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng033,g_fmng4_d[l_ac].fmng034, 
                      g_fmng4_d[l_ac].fmng035,g_fmng4_d[l_ac].fmng036,g_fmng4_d[l_ac].fmng037,g_fmng4_d[l_ac].fmng038, 
                      g_fmng4_d[l_ac].fmng039,g_fmng4_d[l_ac].fmng040,g_fmng4_d[l_ac].fmng041,g_fmng4_d[l_ac].fmng042, 
                      g_fmng4_d[l_ac].fmng043,g_fmng4_d[l_ac].fmng044,g_fmng4_d[l_ac].fmng045
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmng4_d_mask_o[l_ac].* =  g_fmng4_d[l_ac].*
                  CALL afmt565_fmng_t_mask()
                  LET g_fmng4_d_mask_n[l_ac].* =  g_fmng4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt565_show()
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
               LET gs_keys[01] = g_fmmu_m.fmmudocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmng4_d_t.fmngseq
            
               #刪除同層單身
               IF NOT afmt565_delete_b('fmng_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt565_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt565_key_delete_b(gs_keys,'fmng_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt565_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt565_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_fmng_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmng4_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM fmng_t 
             WHERE fmngent = g_enterprise AND fmngdocno = g_fmmu_m.fmmudocno
               AND fmngseq = g_fmng4_d[l_ac].fmngseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmu_m.fmmudocno
               LET gs_keys[2] = g_fmng4_d[g_detail_idx].fmngseq
               CALL afmt565_insert_b('fmng_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmng_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt565_b_fill()
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
               LET g_fmng4_d[l_ac].* = g_fmng4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt565_bcl
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
               LET g_fmng4_d[l_ac].* = g_fmng4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL afmt565_fmng_t_mask_restore('restore_mask_o')
                              
               UPDATE fmng_t SET (fmngdocno,fmngseq,fmng001,fmng002,fmng003,fmng004,fmng005,fmng006, 
                   fmng007,fmng008,fmng009,fmng010,fmng011,fmng012,fmng013,fmng014,fmng015,fmng016,fmng017, 
                   fmng018,fmng019,fmng020,fmng021,fmng022,fmng046,fmng023,fmng024,fmng025,fmng026,fmng027, 
                   fmng028,fmng029,fmng030,fmng031,fmng032,fmng033,fmng034,fmng035,fmng036,fmng037,fmng038, 
                   fmng039,fmng040,fmng041,fmng042,fmng043,fmng044,fmng045) = (g_fmmu_m.fmmudocno,g_fmng_d[l_ac].fmngseq, 
                   g_fmng_d[l_ac].fmng001,g_fmng_d[l_ac].fmng002,g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng004, 
                   g_fmng_d[l_ac].fmng005,g_fmng_d[l_ac].fmng006,g_fmng_d[l_ac].fmng007,g_fmng_d[l_ac].fmng008, 
                   g_fmng_d[l_ac].fmng009,g_fmng_d[l_ac].fmng010,g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmng012, 
                   g_fmng2_d[l_ac].fmng013,g_fmng2_d[l_ac].fmng014,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmng016, 
                   g_fmng3_d[l_ac].fmng017,g_fmng3_d[l_ac].fmng018,g_fmng3_d[l_ac].fmng019,g_fmng4_d[l_ac].fmng020, 
                   g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng046,g_fmng4_d[l_ac].fmng023, 
                   g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng025,g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng027, 
                   g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng029,g_fmng4_d[l_ac].fmng030,g_fmng4_d[l_ac].fmng031, 
                   g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng033,g_fmng4_d[l_ac].fmng034,g_fmng4_d[l_ac].fmng035, 
                   g_fmng4_d[l_ac].fmng036,g_fmng4_d[l_ac].fmng037,g_fmng4_d[l_ac].fmng038,g_fmng4_d[l_ac].fmng039, 
                   g_fmng4_d[l_ac].fmng040,g_fmng4_d[l_ac].fmng041,g_fmng4_d[l_ac].fmng042,g_fmng4_d[l_ac].fmng043, 
                   g_fmng4_d[l_ac].fmng044,g_fmng4_d[l_ac].fmng045) #自訂欄位頁簽
                WHERE fmngent = g_enterprise AND fmngdocno = g_fmmu_m.fmmudocno
                  AND fmngseq = g_fmng4_d_t.fmngseq #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmng4_d[l_ac].* = g_fmng4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmng_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmng4_d[l_ac].* = g_fmng4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmu_m.fmmudocno
               LET gs_keys_bak[1] = g_fmmudocno_t
               LET gs_keys[2] = g_fmng4_d[g_detail_idx].fmngseq
               LET gs_keys_bak[2] = g_fmng4_d_t.fmngseq
               CALL afmt565_update_b('fmng_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt565_fmng_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmng4_d[g_detail_idx].fmngseq = g_fmng4_d_t.fmngseq 
                  ) THEN
                  LET gs_keys[01] = g_fmmu_m.fmmudocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmng4_d_t.fmngseq
                  CALL afmt565_key_update_b(gs_keys,'fmng_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmmu_m),util.JSON.stringify(g_fmng4_d_t)
               LET g_log2 = util.JSON.stringify(g_fmmu_m),util.JSON.stringify(g_fmng4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng020
            #add-point:BEFORE FIELD fmng020 name="input.b.page4.fmng020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng020
            
            #add-point:AFTER FIELD fmng020 name="input.a.page4.fmng020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng020
            #add-point:ON CHANGE fmng020 name="input.g.page4.fmng020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng020_desc
            #add-point:BEFORE FIELD fmng020_desc name="input.b.page4.fmng020_desc"
            LET g_fmng4_d[l_ac].fmng020_desc = g_fmng4_d[l_ac].fmng020
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng020_desc
            
            #add-point:AFTER FIELD fmng020_desc name="input.a.page4.fmng020_desc"
            #應收股利/利息科目DR
            IF NOT cl_null(g_fmng4_d[l_ac].fmng020_desc) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511203
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng020_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald =g_fmmu_m.fmmu001
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng020_desc
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_fmng4_d[l_ac].fmng020_desc
                LET g_qryparam.arg3 = g_fmmu_m.fmmu001
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_fmng4_d[l_ac].fmng020 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng020_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng020,g_fmng4_d[l_ac].fmng020_desc
                
              END IF
              IF  NOT s_aglt310_lc_subject(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng020_desc,'N') THEN
                   LET g_fmng4_d[l_ac].fmng020      = g_fmng4_d_t.fmng020
                        LET g_fmng4_d[l_ac].fmng020_desc = g_fmng4_d_t.fmng020_desc
                        DISPLAY BY NAME g_fmng4_d[l_ac].fmng020,g_fmng4_d[l_ac].fmng020_desc
                        NEXT FIELD CURRENT
              END IF
         #  150916-00015#1 END
               IF ( g_fmng4_d[l_ac].fmng020_desc != g_fmng4_d_t.fmng020_desc OR g_fmng4_d_t.fmng020_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng020 = g_fmng4_d[l_ac].fmng020_desc
                  IF (g_fmng4_d[l_ac].fmng020 != g_fmng4_d_t.fmng020 OR g_fmng4_d_t.fmng020 IS NULL) THEN
                     CALL s_aap_glac002_chk(g_fmng4_d[l_ac].fmng020,g_fmmu_m.fmmu001) RETURNING g_sub_success,g_errno
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
                        LET g_fmng4_d[l_ac].fmng020      = g_fmng4_d_t.fmng020
                        LET g_fmng4_d[l_ac].fmng020_desc = g_fmng4_d_t.fmng020_desc
                        DISPLAY BY NAME g_fmng4_d[l_ac].fmng020,g_fmng4_d[l_ac].fmng020_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng020 = ''
            END IF
            LET g_fmng4_d_t.fmng020_desc = g_fmng4_d[l_ac].fmng020_desc
            LET g_fmng4_d[l_ac].fmng020_desc = s_desc_show1(g_fmng4_d[l_ac].fmng020,s_desc_get_account_desc(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng020))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng020,g_fmng4_d[l_ac].fmng020_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng020_desc
            #add-point:ON CHANGE fmng020_desc name="input.g.page4.fmng020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng021
            #add-point:BEFORE FIELD fmng021 name="input.b.page4.fmng021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng021
            
            #add-point:AFTER FIELD fmng021 name="input.a.page4.fmng021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng021
            #add-point:ON CHANGE fmng021 name="input.g.page4.fmng021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng021_desc
            #add-point:BEFORE FIELD fmng021_desc name="input.b.page4.fmng021_desc"
            LET g_fmng4_d[l_ac].fmng021_desc = g_fmng4_d[l_ac].fmng021
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng021_desc
            
            #add-point:AFTER FIELD fmng021_desc name="input.a.page4.fmng021_desc"
            #利息調整科目
            IF NOT cl_null(g_fmng4_d[l_ac].fmng021_desc) THEN
                #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511203
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng021_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald =g_fmmu_m.fmmu001
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng021_desc
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_fmng4_d[l_ac].fmng021_desc
                LET g_qryparam.arg3 = g_fmmu_m.fmmu001
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               LET g_fmng4_d[l_ac].fmng021 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng021_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng021_desc
              END IF
              IF  NOT s_aglt310_lc_subject(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng021_desc,'N') THEN
                  LET g_fmng4_d[l_ac].fmng021      = g_fmng4_d_t.fmng021
                        LET g_fmng4_d[l_ac].fmng021_desc = g_fmng4_d_t.fmng021_desc
                        DISPLAY BY NAME g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng021_desc
                        NEXT FIELD CURRENT
              END IF
          #  150916-00015#1 END
               IF ( g_fmng4_d[l_ac].fmng021_desc != g_fmng4_d_t.fmng021_desc OR g_fmng4_d_t.fmng021_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng021 = g_fmng4_d[l_ac].fmng021_desc
                  IF (g_fmng4_d[l_ac].fmng021 != g_fmng4_d_t.fmng021 OR g_fmng4_d_t.fmng021 IS NULL) THEN
                     CALL s_aap_glac002_chk(g_fmng4_d[l_ac].fmng021,g_fmmu_m.fmmu001) RETURNING g_sub_success,g_errno
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
                        LET g_fmng4_d[l_ac].fmng021      = g_fmng4_d_t.fmng021
                        LET g_fmng4_d[l_ac].fmng021_desc = g_fmng4_d_t.fmng021_desc
                        DISPLAY BY NAME g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng021_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng021 = ''
            END IF
            LET g_fmng4_d_t.fmng021_desc = g_fmng4_d[l_ac].fmng021_desc
            LET g_fmng4_d[l_ac].fmng021_desc = s_desc_show1(g_fmng4_d[l_ac].fmng021,s_desc_get_account_desc(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng021))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng021_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng021_desc
            #add-point:ON CHANGE fmng021_desc name="input.g.page4.fmng021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng022
            #add-point:BEFORE FIELD fmng022 name="input.b.page4.fmng022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng022
            
            #add-point:AFTER FIELD fmng022 name="input.a.page4.fmng022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng022
            #add-point:ON CHANGE fmng022 name="input.g.page4.fmng022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng022_desc
            #add-point:BEFORE FIELD fmng022_desc name="input.b.page4.fmng022_desc"
            LET g_fmng4_d[l_ac].fmng022_desc = g_fmng4_d[l_ac].fmng022
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng022_desc
            
            #add-point:AFTER FIELD fmng022_desc name="input.a.page4.fmng022_desc"
            #投資收益科目CR
            IF NOT cl_null(g_fmng4_d[l_ac].fmng022_desc) THEN
                #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511203
             LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng022_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald =g_fmmu_m.fmmu001
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng022_desc
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_fmng4_d[l_ac].fmng022_desc
                LET g_qryparam.arg3 = g_fmmu_m.fmmu001
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                 LET g_fmng4_d[l_ac].fmng022 = g_qryparam.return1
                LET g_fmng4_d[l_ac].fmng022_desc = g_qryparam.return1
                DISPLAY BY NAME g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng022_desc
              END IF
               IF NOT s_aglt310_lc_subject(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng022_desc,'N') THEN
                     LET g_fmng4_d[l_ac].fmng022      = g_fmng4_d_t.fmng022
                        LET g_fmng4_d[l_ac].fmng022_desc = g_fmng4_d_t.fmng022_desc
                        DISPLAY BY NAME g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng022_desc
                        NEXT FIELD CURRENT
               END IF
          #  150916-00015#1 END
               IF ( g_fmng4_d[l_ac].fmng022_desc != g_fmng4_d_t.fmng022_desc OR g_fmng4_d_t.fmng022_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng022 = g_fmng4_d[l_ac].fmng022_desc
                  IF (g_fmng4_d[l_ac].fmng022 != g_fmng4_d_t.fmng022 OR g_fmng4_d_t.fmng022 IS NULL) THEN
                     CALL s_aap_glac002_chk(g_fmng4_d[l_ac].fmng022,g_fmmu_m.fmmu001) RETURNING g_sub_success,g_errno
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
                        LET g_fmng4_d[l_ac].fmng022      = g_fmng4_d_t.fmng022
                        LET g_fmng4_d[l_ac].fmng022_desc = g_fmng4_d_t.fmng022_desc
                        DISPLAY BY NAME g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng022_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng022 = ''
            END IF
            LET g_fmng4_d_t.fmng022_desc = g_fmng4_d[l_ac].fmng022_desc
            LET g_fmng4_d[l_ac].fmng022_desc = s_desc_show1(g_fmng4_d[l_ac].fmng022,s_desc_get_account_desc(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng022))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng022_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng022_desc
            #add-point:ON CHANGE fmng022_desc name="input.g.page4.fmng022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng046
            #add-point:BEFORE FIELD fmng046 name="input.b.page4.fmng046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng046
            
            #add-point:AFTER FIELD fmng046 name="input.a.page4.fmng046"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng046
            #add-point:ON CHANGE fmng046 name="input.g.page4.fmng046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng023
            #add-point:BEFORE FIELD fmng023 name="input.b.page4.fmng023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng023
            
            #add-point:AFTER FIELD fmng023 name="input.a.page4.fmng023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng023
            #add-point:ON CHANGE fmng023 name="input.g.page4.fmng023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng023_desc
            #add-point:BEFORE FIELD fmng023_desc name="input.b.page4.fmng023_desc"
            LET g_fmng4_d[l_ac].fmng023_desc = g_fmng4_d[l_ac].fmng023
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng023_desc
            
            #add-point:AFTER FIELD fmng023_desc name="input.a.page4.fmng023_desc"
            #帳款客戶
            IF NOT cl_null(g_fmng4_d[l_ac].fmng023_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng023_desc != g_fmng4_d_t.fmng023_desc OR g_fmng4_d_t.fmng023_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng023 = g_fmng4_d[l_ac].fmng023_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng023 != g_fmng4_d_t.fmng023 OR g_fmng4_d_t.fmng023 IS NULL) THEN
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_fmng4_d[l_ac].fmng023
                        LET g_chkparam.arg2 = ' '
                        IF NOT cl_chk_exist("v_pmaa001_7") THEN  
                           LET g_fmng4_d[l_ac].fmng023      = g_fmng4_d_t.fmng023
                           LET g_fmng4_d[l_ac].fmng023_desc = g_fmng4_d_t.fmng023_desc
                           LET g_fmng4_d[l_ac].fmng023_desc = s_desc_show1(g_fmng4_d[l_ac].fmng023,s_desc_get_trading_partner_abbr_desc(g_fmng4_d[l_ac].fmng023))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng023,g_fmng4_d[l_ac].fmng023_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng023 = ''
            END IF
            LET g_fmng4_d_t.fmng023_desc = g_fmng4_d[l_ac].fmng023_desc
            LET g_fmng4_d[l_ac].fmng023_desc = s_desc_show1(g_fmng4_d[l_ac].fmng023,s_desc_get_trading_partner_abbr_desc(g_fmng4_d[l_ac].fmng023))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng023,g_fmng4_d[l_ac].fmng023_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng023_desc
            #add-point:ON CHANGE fmng023_desc name="input.g.page4.fmng023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng024
            #add-point:BEFORE FIELD fmng024 name="input.b.page4.fmng024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng024
            
            #add-point:AFTER FIELD fmng024 name="input.a.page4.fmng024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng024
            #add-point:ON CHANGE fmng024 name="input.g.page4.fmng024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng024_desc
            #add-point:BEFORE FIELD fmng024_desc name="input.b.page4.fmng024_desc"
            LET g_fmng4_d[l_ac].fmng024_desc = g_fmng4_d[l_ac].fmng024
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng024_desc
            
            #add-point:AFTER FIELD fmng024_desc name="input.a.page4.fmng024_desc"
            IF NOT cl_null(g_fmng4_d[l_ac].fmng024_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng024_desc != g_fmng4_d_t.fmng024_desc OR g_fmng4_d_t.fmng024_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng024 = g_fmng4_d[l_ac].fmng024_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng024 != g_fmng4_d_t.fmng024 OR g_fmng4_d_t.fmng024 IS NULL) THEN
                        #資料存在性、有效性檢查
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_fmng4_d[l_ac].fmng024
                        LET g_chkparam.arg2 = ' '
                        IF NOT cl_chk_exist("v_pmaa001_7") THEN
                           LET g_fmng4_d[l_ac].fmng024      = g_fmng4_d_t.fmng024
                           LET g_fmng4_d[l_ac].fmng024_desc = g_fmng4_d_t.fmng024_desc
                           LET g_fmng4_d[l_ac].fmng024_desc = s_desc_show1(g_fmng4_d[l_ac].fmng024,s_desc_get_trading_partner_abbr_desc(g_fmng4_d[l_ac].fmng024))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng024_desc
                           NEXT FIELD CURRENT
                        END IF
                        #資料邏輯正確性檢查
                        IF g_fmng4_d[l_ac].fmng023 != g_fmng4_d[l_ac].fmng024 THEN
                           INITIALIZE g_chkparam.* TO NULL
                           LET g_chkparam.arg1 = g_fmng4_d[l_ac].fmng023
                           LET g_chkparam.arg2 = g_fmng4_d[l_ac].fmng024
                           LET g_errshow = TRUE   #160318-00025#49
                           LET g_chkparam.err_str[1] = "axr-00049:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"    #160318-00025#49
                           IF NOT cl_chk_exist("v_pmac002_4") THEN
                              LET g_fmng4_d[l_ac].fmng024      = g_fmng4_d_t.fmng024
                              LET g_fmng4_d[l_ac].fmng024_desc = g_fmng4_d_t.fmng024_desc
                              LET g_fmng4_d[l_ac].fmng024_desc = s_desc_show1(g_fmng4_d[l_ac].fmng024,s_desc_get_trading_partner_abbr_desc(g_fmng4_d[l_ac].fmng024))
                              DISPLAY BY NAME g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng024_desc
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng024 = ''
            END IF
            LET g_fmng4_d_t.fmng024_desc = g_fmng4_d[l_ac].fmng024_desc
            LET g_fmng4_d[l_ac].fmng024_desc = s_desc_show1(g_fmng4_d[l_ac].fmng024,s_desc_get_trading_partner_abbr_desc(g_fmng4_d[l_ac].fmng024))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng024_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng024_desc
            #add-point:ON CHANGE fmng024_desc name="input.g.page4.fmng024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng025
            #add-point:BEFORE FIELD fmng025 name="input.b.page4.fmng025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng025
            
            #add-point:AFTER FIELD fmng025 name="input.a.page4.fmng025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng025
            #add-point:ON CHANGE fmng025 name="input.g.page4.fmng025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng025_desc
            #add-point:BEFORE FIELD fmng025_desc name="input.b.page4.fmng025_desc"
            LET g_fmng4_d[l_ac].fmng025_desc = g_fmng4_d[l_ac].fmng025
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng025_desc
            
            #add-point:AFTER FIELD fmng025_desc name="input.a.page4.fmng025_desc"
            #部門
            IF NOT cl_null(g_fmng4_d[l_ac].fmng025_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng025_desc != g_fmng4_d_t.fmng025_desc OR g_fmng4_d_t.fmng025_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng025 = g_fmng4_d[l_ac].fmng025_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng025 != g_fmng4_d_t.fmng025 OR g_fmng4_d_t.fmng025 IS NULL) THEN
                        CALL s_department_chk(g_fmng4_d[l_ac].fmng025_desc,g_fmmu_m.fmmudocdt) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_fmng4_d[l_ac].fmng025 = g_fmng4_d_t.fmng025
                           LET g_fmng4_d[l_ac].fmng025_desc = g_fmng4_d_t.fmng025_desc
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng025 ,g_fmng4_d[l_ac].fmng025_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  #取責任中心
                  CALL s_department_get_respon_center(g_fmng4_d[l_ac].fmng025,g_fmmu_m.fmmudocdt)
                       RETURNING g_sub_success,g_errno,g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng026_desc
                  LET g_fmng4_d[l_ac].fmng026_desc = s_desc_show1(g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng026_desc)
                  LET g_fmng4_d_t.fmng026_desc = g_fmng4_d[l_ac].fmng026_desc
                  DISPLAY BY NAME g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng026_desc
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng025 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng025_desc = s_desc_show1(g_fmng4_d[l_ac].fmng025,s_desc_get_department_desc(g_fmng4_d[l_ac].fmng025))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng025 ,g_fmng4_d[l_ac].fmng025_desc
            LET g_fmng4_d_t.fmng025_desc = g_fmng4_d[l_ac].fmng025_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng025_desc
            #add-point:ON CHANGE fmng025_desc name="input.g.page4.fmng025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng026
            #add-point:BEFORE FIELD fmng026 name="input.b.page4.fmng026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng026
            
            #add-point:AFTER FIELD fmng026 name="input.a.page4.fmng026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng026
            #add-point:ON CHANGE fmng026 name="input.g.page4.fmng026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng026_desc
            #add-point:BEFORE FIELD fmng026_desc name="input.b.page4.fmng026_desc"
            LET g_fmng4_d[l_ac].fmng026_desc = g_fmng4_d[l_ac].fmng026
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng026_desc
            
            #add-point:AFTER FIELD fmng026_desc name="input.a.page4.fmng026_desc"
            #責任中心
            IF NOT cl_null(g_fmng4_d[l_ac].fmng026_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng026_desc != g_fmng4_d_t.fmng026_desc OR g_fmng4_d_t.fmng026_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng026 = g_fmng4_d[l_ac].fmng026_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng026 != g_fmng4_d_t.fmng026 OR g_fmng4_d_t.fmng026 IS NULL) THEN
                        CALL s_voucher_glaq019_chk(g_fmng4_d[l_ac].fmng026_desc,g_fmmu_m.fmmudocdt)
                        IF NOT cl_null(g_errno) THEN
                           LET g_fmng4_d[l_ac].fmng026 = g_fmng4_d_t.fmng026
                           LET g_fmng4_d[l_ac].fmng026_desc = g_fmng4_d_t.fmng026_desc
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng026_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng026 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng026_desc = s_desc_show1(g_fmng4_d[l_ac].fmng026,s_desc_get_department_desc(g_fmng4_d[l_ac].fmng026))         
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng026 ,g_fmng4_d[l_ac].fmng026_desc
            LET g_fmng4_d_t.fmng026_desc = g_fmng4_d[l_ac].fmng026_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng026_desc
            #add-point:ON CHANGE fmng026_desc name="input.g.page4.fmng026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng027
            #add-point:BEFORE FIELD fmng027 name="input.b.page4.fmng027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng027
            
            #add-point:AFTER FIELD fmng027 name="input.a.page4.fmng027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng027
            #add-point:ON CHANGE fmng027 name="input.g.page4.fmng027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng027_desc
            #add-point:BEFORE FIELD fmng027_desc name="input.b.page4.fmng027_desc"
            LET g_fmng4_d[l_ac].fmng027_desc = g_fmng4_d[l_ac].fmng027
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng027_desc
            
            #add-point:AFTER FIELD fmng027_desc name="input.a.page4.fmng027_desc"
            #區域
            IF NOT cl_null(g_fmng4_d[l_ac].fmng027_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng027_desc != g_fmng4_d_t.fmng027_desc OR g_fmng4_d_t.fmng027_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng027 = g_fmng4_d[l_ac].fmng027_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng027 != g_fmng4_d_t.fmng027 OR g_fmng4_d_t.fmng027 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('287',g_fmng4_d[l_ac].fmng027) THEN
                           LET g_fmng4_d[l_ac].fmng027 = g_fmng4_d_t.fmng027
                           LET g_fmng4_d[l_ac].fmng027_desc = g_fmng4_d_t.fmng027_desc
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng027 ,g_fmng4_d[l_ac].fmng027_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            LET g_fmng4_d[l_ac].fmng027_desc = s_desc_show1(g_fmng4_d[l_ac].fmng027,s_desc_get_acc_desc('287',g_fmng4_d[l_ac].fmng027))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng027 ,g_fmng4_d[l_ac].fmng027_desc
            LET g_fmng4_d_t.fmng027_desc = g_fmng4_d[l_ac].fmng027_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng027_desc
            #add-point:ON CHANGE fmng027_desc name="input.g.page4.fmng027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng028
            #add-point:BEFORE FIELD fmng028 name="input.b.page4.fmng028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng028
            
            #add-point:AFTER FIELD fmng028 name="input.a.page4.fmng028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng028
            #add-point:ON CHANGE fmng028 name="input.g.page4.fmng028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng028_desc
            #add-point:BEFORE FIELD fmng028_desc name="input.b.page4.fmng028_desc"
            LET g_fmng4_d[l_ac].fmng028_desc = g_fmng4_d[l_ac].fmng028
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng028_desc
            
            #add-point:AFTER FIELD fmng028_desc name="input.a.page4.fmng028_desc"
            #客群
            IF NOT cl_null(g_fmng4_d[l_ac].fmng028_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng028_desc != g_fmng4_d_t.fmng028_desc OR g_fmng4_d_t.fmng028_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng028 = g_fmng4_d[l_ac].fmng028_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng028 != g_fmng4_d_t.fmng028 OR g_fmng4_d_t.fmng028 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('281',g_fmng4_d[l_ac].fmng028) THEN
                           LET g_fmng4_d[l_ac].fmng028 = g_fmng4_d_t.fmng028
                           LET g_fmng4_d[l_ac].fmng028_desc = g_fmng4_d_t.fmng028_desc
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng028 ,g_fmng4_d[l_ac].fmng028_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng028 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng028_desc = s_desc_show1(g_fmng4_d[l_ac].fmng028,s_desc_get_acc_desc('281',g_fmng4_d[l_ac].fmng028))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng028 ,g_fmng4_d[l_ac].fmng028_desc
            LET g_fmng4_d_t.fmng028_desc = g_fmng4_d[l_ac].fmng028_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng028_desc
            #add-point:ON CHANGE fmng028_desc name="input.g.page4.fmng028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng029
            #add-point:BEFORE FIELD fmng029 name="input.b.page4.fmng029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng029
            
            #add-point:AFTER FIELD fmng029 name="input.a.page4.fmng029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng029
            #add-point:ON CHANGE fmng029 name="input.g.page4.fmng029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng029_desc
            #add-point:BEFORE FIELD fmng029_desc name="input.b.page4.fmng029_desc"
            LET g_fmng4_d[l_ac].fmng029_desc = g_fmng4_d[l_ac].fmng029
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng029_desc
            
            #add-point:AFTER FIELD fmng029_desc name="input.a.page4.fmng029_desc"
            #產品類別
            IF NOT cl_null(g_fmng4_d[l_ac].fmng029_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng029_desc != g_fmng4_d_t.fmng029_desc OR g_fmng4_d_t.fmng029_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng029 = g_fmng4_d[l_ac].fmng029_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng029 != g_fmng4_d_t.fmng029 OR g_fmng4_d_t.fmng029 IS NULL) THEN
                        CALL s_voucher_glaq024_chk(g_fmng4_d[l_ac].fmng029) 
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
                           LET g_fmng4_d[l_ac].fmng029 = g_fmng4_d_t.fmng029
                           LET g_fmng4_d[l_ac].fmng029_desc = g_fmng4_d_t.fmng029_desc
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng029 ,g_fmng4_d[l_ac].fmng029_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng029 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng029_desc = s_desc_show1(g_fmng4_d[l_ac].fmng029,s_desc_get_rtaxl003_desc(g_fmng4_d[l_ac].fmng029))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng029 ,g_fmng4_d[l_ac].fmng029_desc
            LET g_fmng4_d_t.fmng029_desc = g_fmng4_d[l_ac].fmng029_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng029_desc
            #add-point:ON CHANGE fmng029_desc name="input.g.page4.fmng029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng030
            #add-point:BEFORE FIELD fmng030 name="input.b.page4.fmng030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng030
            
            #add-point:AFTER FIELD fmng030 name="input.a.page4.fmng030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng030
            #add-point:ON CHANGE fmng030 name="input.g.page4.fmng030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng030_desc
            #add-point:BEFORE FIELD fmng030_desc name="input.b.page4.fmng030_desc"
            LET g_fmng4_d[l_ac].fmng030_desc = g_fmng4_d[l_ac].fmng030
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng030_desc
            
            #add-point:AFTER FIELD fmng030_desc name="input.a.page4.fmng030_desc"
            #人員
            IF NOT cl_null(g_fmng4_d[l_ac].fmng030_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng030_desc != g_fmng4_d_t.fmng030_desc OR g_fmng4_d_t.fmng030_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng030 = g_fmng4_d[l_ac].fmng030_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng030 != g_fmng4_d_t.fmng030 OR g_fmng4_d_t.fmng030 IS NULL) THEN
                        CALL s_employee_chk(g_fmng4_d[l_ac].fmng030_desc) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_fmng4_d[l_ac].fmng030 = g_fmng4_d_t.fmng030
                           LET g_fmng4_d[l_ac].fmng030_desc = g_fmng4_d_t.fmng030_desc
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng030,g_fmng4_d[l_ac].fmng030_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng030 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng030_desc = s_desc_show1(g_fmng4_d[l_ac].fmng030,s_desc_get_person_desc(g_fmng4_d[l_ac].fmng030))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng030,g_fmng4_d[l_ac].fmng030_desc
            LET g_fmng4_d_t.fmng030_desc = g_fmng4_d[l_ac].fmng030_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng030_desc
            #add-point:ON CHANGE fmng030_desc name="input.g.page4.fmng030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng031
            #add-point:BEFORE FIELD fmng031 name="input.b.page4.fmng031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng031
            
            #add-point:AFTER FIELD fmng031 name="input.a.page4.fmng031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng031
            #add-point:ON CHANGE fmng031 name="input.g.page4.fmng031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng031_desc
            #add-point:BEFORE FIELD fmng031_desc name="input.b.page4.fmng031_desc"
            LET g_fmng4_d[l_ac].fmng031_desc = g_fmng4_d[l_ac].fmng031
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng031_desc
            
            #add-point:AFTER FIELD fmng031_desc name="input.a.page4.fmng031_desc"
            #專案代號
            IF NOT cl_null(g_fmng4_d[l_ac].fmng031_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng031_desc != g_fmng4_d_t.fmng031_desc OR g_fmng4_d_t.fmng031_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng031 = g_fmng4_d[l_ac].fmng031_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng031 != g_fmng4_d_t.fmng031 OR g_fmng4_d_t.fmng031 IS NULL) THEN
                        CALL s_aap_project_chk( g_fmng4_d[l_ac].fmng031) RETURNING g_sub_success,g_errno
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
                           LET g_fmng4_d[l_ac].fmng031      = g_fmng4_d_t.fmng031
                           LET g_fmng4_d[l_ac].fmng031_desc = g_fmng4_d_t.fmng031_desc
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng031_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng031 = ''                 
            END IF
            LET g_fmng4_d[l_ac].fmng031_desc = s_desc_show1(g_fmng4_d[l_ac].fmng031,s_desc_get_project_desc(g_fmng4_d[l_ac].fmng031))
            LET g_fmng4_d_t.fmng031 = g_fmng4_d[l_ac].fmng031_desc
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng031_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng031_desc
            #add-point:ON CHANGE fmng031_desc name="input.g.page4.fmng031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng032
            #add-point:BEFORE FIELD fmng032 name="input.b.page4.fmng032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng032
            
            #add-point:AFTER FIELD fmng032 name="input.a.page4.fmng032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng032
            #add-point:ON CHANGE fmng032 name="input.g.page4.fmng032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng032_desc
            #add-point:BEFORE FIELD fmng032_desc name="input.b.page4.fmng032_desc"
            LET g_fmng4_d[l_ac].fmng032_desc = g_fmng4_d[l_ac].fmng032
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng032_desc
            
            #add-point:AFTER FIELD fmng032_desc name="input.a.page4.fmng032_desc"
            #WBS
            IF NOT cl_null(g_fmng4_d[l_ac].fmng032_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng032_desc != g_fmng4_d_t.fmng032_desc OR g_fmng4_d_t.fmng032_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng032 = g_fmng4_d[l_ac].fmng032_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng032 != g_fmng4_d_t.fmng032 OR g_fmng4_d_t.fmng032 IS NULL) THEN
                        CALL s_voucher_glaq028_chk(g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng032)
                        IF NOT cl_null(g_errno) THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_fmng4_d[l_ac].fmng032      = g_fmng4_d_t.fmng032
                           LET g_fmng4_d[l_ac].fmng032_desc = g_fmng4_d_t.fmng032_desc
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng032_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng032 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng032_desc = s_desc_show1(g_fmng4_d[l_ac].fmng032,s_desc_get_pjbbl004_desc(g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng032))
            LET g_fmng4_d_t.fmng032 = g_fmng4_d[l_ac].fmng032_desc
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng032_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng032_desc
            #add-point:ON CHANGE fmng032_desc name="input.g.page4.fmng032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng033
            #add-point:BEFORE FIELD fmng033 name="input.b.page4.fmng033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng033
            
            #add-point:AFTER FIELD fmng033 name="input.a.page4.fmng033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng033
            #add-point:ON CHANGE fmng033 name="input.g.page4.fmng033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng033_desc
            #add-point:BEFORE FIELD fmng033_desc name="input.b.page4.fmng033_desc"
            LET g_fmng4_d[l_ac].fmng033_desc = g_fmng4_d[l_ac].fmng033
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng033_desc
            
            #add-point:AFTER FIELD fmng033_desc name="input.a.page4.fmng033_desc"
            #經營方式
            IF NOT cl_null(g_fmng4_d[l_ac].fmng033_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng033_desc != g_fmng4_d_t.fmng033_desc OR g_fmng4_d_t.fmng033_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng033 = g_fmng4_d[l_ac].fmng033_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng033 != g_fmng4_d_t.fmng033 OR g_fmng4_d_t.fmng033 IS NULL) THEN
                        CALL s_voucher_glaq051_chk(g_fmng4_d[l_ac].fmng033) 
                        IF NOT g_sub_success THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_fmng4_d[l_ac].fmng033      = g_fmng4_d_t.fmng033
                           LET g_fmng4_d[l_ac].fmng033_desc = g_fmng4_d_t.fmng033_desc
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng033,g_fmng4_d[l_ac].fmng033_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng033 = ''
            END IF
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng033 ,g_fmng4_d[l_ac].fmng033_desc
            LET g_fmng4_d_t.fmng033_desc = g_fmng4_d[l_ac].fmng033_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng033_desc
            #add-point:ON CHANGE fmng033_desc name="input.g.page4.fmng033_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng034
            #add-point:BEFORE FIELD fmng034 name="input.b.page4.fmng034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng034
            
            #add-point:AFTER FIELD fmng034 name="input.a.page4.fmng034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng034
            #add-point:ON CHANGE fmng034 name="input.g.page4.fmng034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng034_desc
            #add-point:BEFORE FIELD fmng034_desc name="input.b.page4.fmng034_desc"
            LET g_fmng4_d[l_ac].fmng034_desc = g_fmng4_d[l_ac].fmng034
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng034_desc
            
            #add-point:AFTER FIELD fmng034_desc name="input.a.page4.fmng034_desc"
            #渠道
            IF NOT cl_null(g_fmng4_d[l_ac].fmng034_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng034_desc != g_fmng4_d_t.fmng034_desc OR g_fmng4_d_t.fmng034_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng034 = g_fmng4_d[l_ac].fmng034_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     CALL s_voucher_glaq052_chk(g_fmng4_d[l_ac].fmng034)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_fmng4_d[l_ac].fmng034 = g_fmng4_d_t.fmng034
                        LET g_fmng4_d[l_ac].fmng034_desc = g_fmng4_d_t.fmng034_desc
                        DISPLAY BY NAME g_fmng4_d[l_ac].fmng034,g_fmng4_d[l_ac].fmng034_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng034 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng034_desc = s_desc_show1(g_fmng4_d[l_ac].fmng034,s_desc_get_oojdl003_desc(g_fmng4_d[l_ac].fmng034))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng034,g_fmng4_d[l_ac].fmng034_desc
            LET g_fmng4_d_t.fmng034_desc = g_fmng4_d[l_ac].fmng034_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng034_desc
            #add-point:ON CHANGE fmng034_desc name="input.g.page4.fmng034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng035
            #add-point:BEFORE FIELD fmng035 name="input.b.page4.fmng035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng035
            
            #add-point:AFTER FIELD fmng035 name="input.a.page4.fmng035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng035
            #add-point:ON CHANGE fmng035 name="input.g.page4.fmng035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng035_desc
            #add-point:BEFORE FIELD fmng035_desc name="input.b.page4.fmng035_desc"
            LET g_fmng4_d[l_ac].fmng035_desc = g_fmng4_d[l_ac].fmng035
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng035_desc
            
            #add-point:AFTER FIELD fmng035_desc name="input.a.page4.fmng035_desc"
            #品牌
            IF NOT cl_null(g_fmng4_d[l_ac].fmng035_desc) THEN
               IF ( g_fmng4_d[l_ac].fmng035_desc != g_fmng4_d_t.fmng035_desc OR g_fmng4_d_t.fmng035_desc IS NULL ) THEN
                  LET g_fmng4_d[l_ac].fmng035 = g_fmng4_d[l_ac].fmng035_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF NOT s_azzi650_chk_exist('2002',g_fmng4_d[l_ac].fmng035) THEN
                        LET g_fmng4_d[l_ac].fmng035      = g_fmng4_d_t.fmng035
                        LET g_fmng4_d[l_ac].fmng035_desc = g_fmng4_d_t.fmng035_desc
                        DISPLAY BY NAME g_fmng4_d[l_ac].fmng035 ,g_fmng4_d[l_ac].fmng035_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng035 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng035_desc = s_desc_show1(g_fmng4_d[l_ac].fmng035,s_desc_get_acc_desc('2002',g_fmng4_d[l_ac].fmng035))      
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng035 ,g_fmng4_d[l_ac].fmng035_desc
            LET g_fmng4_d_t.fmng035_desc = g_fmng4_d[l_ac].fmng035_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng035_desc
            #add-point:ON CHANGE fmng035_desc name="input.g.page4.fmng035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng036
            #add-point:BEFORE FIELD fmng036 name="input.b.page4.fmng036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng036
            
            #add-point:AFTER FIELD fmng036 name="input.a.page4.fmng036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng036
            #add-point:ON CHANGE fmng036 name="input.g.page4.fmng036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng036_desc
            #add-point:BEFORE FIELD fmng036_desc name="input.b.page4.fmng036_desc"
            #自由核算項一
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_fmng4_d[l_ac].fmng036_desc = g_fmng4_d[l_ac].fmng036
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng036_desc
            
            #add-point:AFTER FIELD fmng036_desc name="input.a.page4.fmng036_desc"
            #自由核算項一
            IF NOT cl_null(g_fmng4_d[l_ac].fmng036_desc) THEN
               IF (g_fmng4_d[l_ac].fmng036_desc != g_fmng4_d_t.fmng036_desc OR g_fmng4_d_t.fmng036_desc IS NULL) THEN
                  LET g_fmng4_d[l_ac].fmng036 = g_fmng4_d[l_ac].fmng036_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng036 != g_fmng4_d_t.fmng036 OR g_fmng4_d_t.fmng036 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_fmng4_d[l_ac].fmng036,g_glad.glad0172) RETURNING g_errno
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
                           LET g_fmng4_d[l_ac].fmng036 = g_fmng4_d_t.fmng036
                           LET g_fmng4_d[l_ac].fmng036_desc = s_desc_show1(g_fmng4_d[l_ac].fmng036,s_fin_get_accting_desc(g_glad.glad0171,g_fmng4_d[l_ac].fmng036))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng036_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng036 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng036_desc = s_desc_show1(g_fmng4_d[l_ac].fmng036,s_fin_get_accting_desc(g_glad.glad0171,g_fmng4_d[l_ac].fmng036))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng036_desc
            LET g_fmng4_d_t.fmng036_desc = g_fmng4_d[l_ac].fmng036_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng036_desc
            #add-point:ON CHANGE fmng036_desc name="input.g.page4.fmng036_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng037
            #add-point:BEFORE FIELD fmng037 name="input.b.page4.fmng037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng037
            
            #add-point:AFTER FIELD fmng037 name="input.a.page4.fmng037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng037
            #add-point:ON CHANGE fmng037 name="input.g.page4.fmng037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng037_desc
            #add-point:BEFORE FIELD fmng037_desc name="input.b.page4.fmng037_desc"
            #自由核算項二
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_fmng4_d[l_ac].fmng037_desc = g_fmng4_d[l_ac].fmng037
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng037_desc
            
            #add-point:AFTER FIELD fmng037_desc name="input.a.page4.fmng037_desc"
           #自由核算項二
            IF NOT cl_null(g_fmng4_d[l_ac].fmng037_desc) THEN
               IF (g_fmng4_d[l_ac].fmng037_desc != g_fmng4_d_t.fmng037_desc OR g_fmng4_d_t.fmng037_desc IS NULL) THEN
                  LET g_fmng4_d[l_ac].fmng037 = g_fmng4_d[l_ac].fmng037_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng037 != g_fmng4_d_t.fmng037 OR g_fmng4_d_t.fmng037 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_fmng4_d[l_ac].fmng037,g_glad.glad0182) RETURNING g_errno
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
                           LET g_fmng4_d[l_ac].fmng037 = g_fmng4_d_t.fmng037
                           LET g_fmng4_d[l_ac].fmng037_desc = s_desc_show1(g_fmng4_d[l_ac].fmng037,s_fin_get_accting_desc(g_glad.glad0181,g_fmng4_d[l_ac].fmng037))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng037_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng037 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng037_desc = s_desc_show1(g_fmng4_d[l_ac].fmng037,s_fin_get_accting_desc(g_glad.glad0181,g_fmng4_d[l_ac].fmng037))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng037_desc 
            LET g_fmng4_d_t.fmng037_desc = g_fmng4_d[l_ac].fmng037_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng037_desc
            #add-point:ON CHANGE fmng037_desc name="input.g.page4.fmng037_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng038
            #add-point:BEFORE FIELD fmng038 name="input.b.page4.fmng038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng038
            
            #add-point:AFTER FIELD fmng038 name="input.a.page4.fmng038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng038
            #add-point:ON CHANGE fmng038 name="input.g.page4.fmng038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng038_desc
            #add-point:BEFORE FIELD fmng038_desc name="input.b.page4.fmng038_desc"
            #自由核算項三
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_fmng4_d[l_ac].fmng038_desc = g_fmng4_d[l_ac].fmng038
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng038_desc
            
            #add-point:AFTER FIELD fmng038_desc name="input.a.page4.fmng038_desc"
            #自由核算項三
            IF NOT cl_null(g_fmng4_d[l_ac].fmng038_desc) THEN
               IF (g_fmng4_d[l_ac].fmng038_desc != g_fmng4_d_t.fmng038_desc OR g_fmng4_d_t.fmng038_desc IS NULL) THEN
                  LET g_fmng4_d[l_ac].fmng038 = g_fmng4_d[l_ac].fmng038_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng038 != g_fmng4_d_t.fmng038 OR g_fmng4_d_t.fmng038 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_fmng4_d[l_ac].fmng038,g_glad.glad0192) RETURNING g_errno
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
                           LET g_fmng4_d[l_ac].fmng038 = g_fmng4_d_t.fmng038
                           LET g_fmng4_d[l_ac].fmng038_desc = s_desc_show1(g_fmng4_d[l_ac].fmng038,s_fin_get_accting_desc(g_glad.glad0191,g_fmng4_d[l_ac].fmng038))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng038_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng038 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng038_desc = s_desc_show1(g_fmng4_d[l_ac].fmng038,s_fin_get_accting_desc(g_glad.glad0191,g_fmng4_d[l_ac].fmng038))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng038_desc 
            LET g_fmng4_d_t.fmng038_desc = g_fmng4_d[l_ac].fmng038_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng038_desc
            #add-point:ON CHANGE fmng038_desc name="input.g.page4.fmng038_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng039
            #add-point:BEFORE FIELD fmng039 name="input.b.page4.fmng039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng039
            
            #add-point:AFTER FIELD fmng039 name="input.a.page4.fmng039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng039
            #add-point:ON CHANGE fmng039 name="input.g.page4.fmng039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng039_desc
            #add-point:BEFORE FIELD fmng039_desc name="input.b.page4.fmng039_desc"
            #自由核算項四
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_fmng4_d[l_ac].fmng039_desc = g_fmng4_d[l_ac].fmng039
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng039_desc
            
            #add-point:AFTER FIELD fmng039_desc name="input.a.page4.fmng039_desc"
            #自由核算項四
            IF NOT cl_null(g_fmng4_d[l_ac].fmng039_desc) THEN
               IF (g_fmng4_d[l_ac].fmng039_desc != g_fmng4_d_t.fmng039_desc OR g_fmng4_d_t.fmng039_desc IS NULL) THEN
                  LET g_fmng4_d[l_ac].fmng039 = g_fmng4_d[l_ac].fmng039_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng039 != g_fmng4_d_t.fmng039 OR g_fmng4_d_t.fmng039 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_fmng4_d[l_ac].fmng039,g_glad.glad0202) RETURNING g_errno
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
                           LET g_fmng4_d[l_ac].fmng039 = g_fmng4_d_t.fmng039
                           LET g_fmng4_d[l_ac].fmng039_desc = s_desc_show1(g_fmng4_d[l_ac].fmng039,s_fin_get_accting_desc(g_glad.glad0201,g_fmng4_d[l_ac].fmng039))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng039_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng039 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng039_desc = s_desc_show1(g_fmng4_d[l_ac].fmng039,s_fin_get_accting_desc(g_glad.glad0201,g_fmng4_d[l_ac].fmng039))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng039_desc 
            LET g_fmng4_d_t.fmng039_desc = g_fmng4_d[l_ac].fmng039_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng039_desc
            #add-point:ON CHANGE fmng039_desc name="input.g.page4.fmng039_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng040
            #add-point:BEFORE FIELD fmng040 name="input.b.page4.fmng040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng040
            
            #add-point:AFTER FIELD fmng040 name="input.a.page4.fmng040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng040
            #add-point:ON CHANGE fmng040 name="input.g.page4.fmng040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng040_desc
            #add-point:BEFORE FIELD fmng040_desc name="input.b.page4.fmng040_desc"
            #自由核算項五
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_fmng4_d[l_ac].fmng040_desc = g_fmng4_d[l_ac].fmng040
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng040_desc
            
            #add-point:AFTER FIELD fmng040_desc name="input.a.page4.fmng040_desc"
            #自由核算項五
            IF NOT cl_null(g_fmng4_d[l_ac].fmng040_desc) THEN
               IF (g_fmng4_d[l_ac].fmng040_desc != g_fmng4_d_t.fmng040_desc OR g_fmng4_d_t.fmng040_desc IS NULL) THEN
                  LET g_fmng4_d[l_ac].fmng040 = g_fmng4_d[l_ac].fmng040_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng040 != g_fmng4_d_t.fmng040 OR g_fmng4_d_t.fmng040 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_fmng4_d[l_ac].fmng040,g_glad.glad0212) RETURNING g_errno
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
                           LET g_fmng4_d[l_ac].fmng040 = g_fmng4_d_t.fmng040
                           LET g_fmng4_d[l_ac].fmng040_desc = s_desc_show1(g_fmng4_d[l_ac].fmng040,s_fin_get_accting_desc(g_glad.glad0211,g_fmng4_d[l_ac].fmng040))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng040_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng040 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng040_desc = s_desc_show1(g_fmng4_d[l_ac].fmng040,s_fin_get_accting_desc(g_glad.glad0211,g_fmng4_d[l_ac].fmng040))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng040_desc
            LET g_fmng4_d_t.fmng040_desc = g_fmng4_d[l_ac].fmng040_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng040_desc
            #add-point:ON CHANGE fmng040_desc name="input.g.page4.fmng040_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng041
            #add-point:BEFORE FIELD fmng041 name="input.b.page4.fmng041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng041
            
            #add-point:AFTER FIELD fmng041 name="input.a.page4.fmng041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng041
            #add-point:ON CHANGE fmng041 name="input.g.page4.fmng041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng041_desc
            #add-point:BEFORE FIELD fmng041_desc name="input.b.page4.fmng041_desc"
            #自由核算項六
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_fmng4_d[l_ac].fmng041_desc = g_fmng4_d[l_ac].fmng041
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng041_desc
            
            #add-point:AFTER FIELD fmng041_desc name="input.a.page4.fmng041_desc"
            #自由核算項六
            IF NOT cl_null(g_fmng4_d[l_ac].fmng041_desc) THEN
               IF (g_fmng4_d[l_ac].fmng041_desc != g_fmng4_d_t.fmng041_desc OR g_fmng4_d_t.fmng041_desc IS NULL) THEN
                  LET g_fmng4_d[l_ac].fmng041 = g_fmng4_d[l_ac].fmng041_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng041 != g_fmng4_d_t.fmng041 OR g_fmng4_d_t.fmng041 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_fmng4_d[l_ac].fmng041,g_glad.glad0222) RETURNING g_errno
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
                           LET g_fmng4_d[l_ac].fmng041 = g_fmng4_d_t.fmng041
                           LET g_fmng4_d[l_ac].fmng041_desc = s_desc_show1(g_fmng4_d[l_ac].fmng041,s_fin_get_accting_desc(g_glad.glad0221,g_fmng4_d[l_ac].fmng041))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng041_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng041 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng041_desc = s_desc_show1(g_fmng4_d[l_ac].fmng041,s_fin_get_accting_desc(g_glad.glad0221,g_fmng4_d[l_ac].fmng041))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng041_desc 
            LET g_fmng4_d_t.fmng041_desc = g_fmng4_d[l_ac].fmng041_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng041_desc
            #add-point:ON CHANGE fmng041_desc name="input.g.page4.fmng041_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng042
            #add-point:BEFORE FIELD fmng042 name="input.b.page4.fmng042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng042
            
            #add-point:AFTER FIELD fmng042 name="input.a.page4.fmng042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng042
            #add-point:ON CHANGE fmng042 name="input.g.page4.fmng042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng042_desc
            #add-point:BEFORE FIELD fmng042_desc name="input.b.page4.fmng042_desc"
            #自由核算項七
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_fmng4_d[l_ac].fmng042_desc = g_fmng4_d[l_ac].fmng042
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng042_desc
            
            #add-point:AFTER FIELD fmng042_desc name="input.a.page4.fmng042_desc"
            #自由核算項七
            IF NOT cl_null(g_fmng4_d[l_ac].fmng042_desc) THEN
               IF (g_fmng4_d[l_ac].fmng042_desc != g_fmng4_d_t.fmng042_desc OR g_fmng4_d_t.fmng042_desc IS NULL) THEN
                  LET g_fmng4_d[l_ac].fmng042 = g_fmng4_d[l_ac].fmng042_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng042 != g_fmng4_d_t.fmng042 OR g_fmng4_d_t.fmng042 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0231,g_fmng4_d[l_ac].fmng042,g_glad.glad0232) RETURNING g_errno
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
                           LET g_fmng4_d[l_ac].fmng042 = g_fmng4_d_t.fmng042
                           LET g_fmng4_d[l_ac].fmng042_desc = s_desc_show1(g_fmng4_d[l_ac].fmng042,s_fin_get_accting_desc(g_glad.glad0231,g_fmng4_d[l_ac].fmng042))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng042_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng042 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng042_desc = s_desc_show1(g_fmng4_d[l_ac].fmng042,s_fin_get_accting_desc(g_glad.glad0231,g_fmng4_d[l_ac].fmng042))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng042_desc 
            LET g_fmng4_d_t.fmng042_desc = g_fmng4_d[l_ac].fmng042_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng042_desc
            #add-point:ON CHANGE fmng042_desc name="input.g.page4.fmng042_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng043
            #add-point:BEFORE FIELD fmng043 name="input.b.page4.fmng043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng043
            
            #add-point:AFTER FIELD fmng043 name="input.a.page4.fmng043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng043
            #add-point:ON CHANGE fmng043 name="input.g.page4.fmng043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng043_desc
            #add-point:BEFORE FIELD fmng043_desc name="input.b.page4.fmng043_desc"
            #自由核算項八
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_fmng4_d[l_ac].fmng043_desc = g_fmng4_d[l_ac].fmng043
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng043_desc
            
            #add-point:AFTER FIELD fmng043_desc name="input.a.page4.fmng043_desc"
            #自由核算項八
            IF NOT cl_null(g_fmng4_d[l_ac].fmng043_desc) THEN
               IF (g_fmng4_d[l_ac].fmng043_desc != g_fmng4_d_t.fmng043_desc OR g_fmng4_d_t.fmng043_desc IS NULL) THEN
                  LET g_fmng4_d[l_ac].fmng043 = g_fmng4_d[l_ac].fmng043_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng043 != g_fmng4_d_t.fmng043 OR g_fmng4_d_t.fmng043 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_fmng4_d[l_ac].fmng043,g_glad.glad0242) RETURNING g_errno
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
                           LET g_fmng4_d[l_ac].fmng043 = g_fmng4_d_t.fmng043
                           LET g_fmng4_d[l_ac].fmng043_desc = s_desc_show1(g_fmng4_d[l_ac].fmng043,s_fin_get_accting_desc(g_glad.glad0241,g_fmng4_d[l_ac].fmng043))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng043_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng043 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng043_desc = s_desc_show1(g_fmng4_d[l_ac].fmng043,s_fin_get_accting_desc(g_glad.glad0241,g_fmng4_d[l_ac].fmng043))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng043_desc
            LET g_fmng4_d_t.fmng043_desc = g_fmng4_d[l_ac].fmng043_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng043_desc
            #add-point:ON CHANGE fmng043_desc name="input.g.page4.fmng043_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng044
            #add-point:BEFORE FIELD fmng044 name="input.b.page4.fmng044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng044
            
            #add-point:AFTER FIELD fmng044 name="input.a.page4.fmng044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng044
            #add-point:ON CHANGE fmng044 name="input.g.page4.fmng044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng044_desc
            #add-point:BEFORE FIELD fmng044_desc name="input.b.page4.fmng044_desc"
            #自由核算項九
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_fmng4_d[l_ac].fmng044_desc = g_fmng4_d[l_ac].fmng044
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng044_desc
            
            #add-point:AFTER FIELD fmng044_desc name="input.a.page4.fmng044_desc"
            #自由核算項九
            IF NOT cl_null(g_fmng4_d[l_ac].fmng044_desc) THEN
               IF (g_fmng4_d[l_ac].fmng044_desc != g_fmng4_d_t.fmng044_desc OR g_fmng4_d_t.fmng044_desc IS NULL) THEN
                  LET g_fmng4_d[l_ac].fmng044 = g_fmng4_d[l_ac].fmng044_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng044 != g_fmng4_d_t.fmng044 OR g_fmng4_d_t.fmng044 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_fmng4_d[l_ac].fmng044,g_glad.glad0252) RETURNING g_errno
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
                           LET g_fmng4_d[l_ac].fmng044 = g_fmng4_d_t.fmng044
                           LET g_fmng4_d[l_ac].fmng044_desc = s_desc_show1(g_fmng4_d[l_ac].fmng044,s_fin_get_accting_desc(g_glad.glad0251,g_fmng4_d[l_ac].fmng044))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng044_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng044 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng044_desc = s_desc_show1(g_fmng4_d[l_ac].fmng044,s_fin_get_accting_desc(g_glad.glad0251,g_fmng4_d[l_ac].fmng044))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng044_desc
            LET g_fmng4_d_t.fmng044_desc = g_fmng4_d[l_ac].fmng044_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng044_desc
            #add-point:ON CHANGE fmng044_desc name="input.g.page4.fmng044_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng045
            #add-point:BEFORE FIELD fmng045 name="input.b.page4.fmng045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng045
            
            #add-point:AFTER FIELD fmng045 name="input.a.page4.fmng045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng045
            #add-point:ON CHANGE fmng045 name="input.g.page4.fmng045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmng045_desc
            #add-point:BEFORE FIELD fmng045_desc name="input.b.page4.fmng045_desc"
            #自由核算項十
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_fmng4_d[l_ac].fmng045_desc = g_fmng4_d[l_ac].fmng045
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmng045_desc
            
            #add-point:AFTER FIELD fmng045_desc name="input.a.page4.fmng045_desc"
            #自由核算項十
            IF NOT cl_null(g_fmng4_d[l_ac].fmng045_desc) THEN
               IF (g_fmng4_d[l_ac].fmng045_desc != g_fmng4_d_t.fmng045_desc OR g_fmng4_d_t.fmng045_desc IS NULL) THEN
                  LET g_fmng4_d[l_ac].fmng045 = g_fmng4_d[l_ac].fmng045_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmng4_d[l_ac].fmng045 != g_fmng4_d_t.fmng045 OR g_fmng4_d_t.fmng045 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_fmng4_d[l_ac].fmng045,g_glad.glad0262) RETURNING g_errno
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
                           LET g_fmng4_d[l_ac].fmng045 = g_fmng4_d_t.fmng045
                           LET g_fmng4_d[l_ac].fmng045_desc = s_desc_show1(g_fmng4_d[l_ac].fmng045,s_fin_get_accting_desc(g_glad.glad0261,g_fmng4_d[l_ac].fmng045))
                           DISPLAY BY NAME g_fmng4_d[l_ac].fmng045_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmng4_d[l_ac].fmng045 = ''
            END IF
            LET g_fmng4_d[l_ac].fmng045_desc = s_desc_show1(g_fmng4_d[l_ac].fmng045,s_fin_get_accting_desc(g_glad.glad0261,g_fmng4_d[l_ac].fmng045))
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng045_desc
            LET g_fmng4_d_t.fmng045_desc = g_fmng4_d[l_ac].fmng045_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmng045_desc
            #add-point:ON CHANGE fmng045_desc name="input.g.page4.fmng045_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.fmng020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng020
            #add-point:ON ACTION controlp INFIELD fmng020 name="input.c.page4.fmng020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng020_desc
            #add-point:ON ACTION controlp INFIELD fmng020_desc name="input.c.page4.fmng020_desc"
            #應收股利/利息科目DR
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng020
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                 " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fmmu_m.fmmu001,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_fmng4_d[l_ac].fmng020 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng020_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng020,g_fmng4_d[l_ac].fmng020_desc
            NEXT FIELD fmng020_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng021
            #add-point:ON ACTION controlp INFIELD fmng021 name="input.c.page4.fmng021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng021_desc
            #add-point:ON ACTION controlp INFIELD fmng021_desc name="input.c.page4.fmng021_desc"
            #利息調整科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng021
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fmmu_m.fmmu001,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_fmng4_d[l_ac].fmng021 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng021_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng021_desc
            NEXT FIELD fmng021_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng022
            #add-point:ON ACTION controlp INFIELD fmng022 name="input.c.page4.fmng022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng022_desc
            #add-point:ON ACTION controlp INFIELD fmng022_desc name="input.c.page4.fmng022_desc"
            #投資收益科目CR
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng022
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fmmu_m.fmmu001,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_fmng4_d[l_ac].fmng022 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng022_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng022_desc
            NEXT FIELD fmng022_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng046
            #add-point:ON ACTION controlp INFIELD fmng046 name="input.c.page4.fmng046"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng023
            #add-point:ON ACTION controlp INFIELD fmng023 name="input.c.page4.fmng023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng023_desc
            #add-point:ON ACTION controlp INFIELD fmng023_desc name="input.c.page4.fmng023_desc"
            #交易客商
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng023
            LET g_qryparam.where = "pmaa002 IN ('2','3')" 
            CALL q_pmaa001_25()        #160913-00017#2  ADD 
           # CALL q_pmaa001()      #160913-00017#2 mark          #呼叫開窗
            LET g_fmng4_d[l_ac].fmng023 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng023_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng023,g_fmng4_d[l_ac].fmng023_desc
            NEXT FIELD fmng023_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng024
            #add-point:ON ACTION controlp INFIELD fmng024 name="input.c.page4.fmng024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng024_desc
            #add-point:ON ACTION controlp INFIELD fmng024_desc name="input.c.page4.fmng024_desc"
            #帳款客戶
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng024
            LET g_qryparam.arg1 = g_fmng4_d[l_ac].fmng023
            LET g_qryparam.arg2 = "1"
            CALL q_pmac002_1()
            LET g_fmng4_d[l_ac].fmng024 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng024_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng024_desc
            NEXT FIELD fmng024
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng025
            #add-point:ON ACTION controlp INFIELD fmng025 name="input.c.page4.fmng025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng025_desc
            #add-point:ON ACTION controlp INFIELD fmng025_desc name="input.c.page4.fmng025_desc"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng025
            LET g_qryparam.arg1 = g_fmmu_m.fmmudocdt    #應以單據日期
            CALL q_ooeg001_4()
            LET g_fmng4_d[l_ac].fmng025 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng025_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng025,g_fmng4_d[l_ac].fmng025_desc
            NEXT FIELD fmng025_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng026
            #add-point:ON ACTION controlp INFIELD fmng026 name="input.c.page4.fmng026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng026_desc
            #add-point:ON ACTION controlp INFIELD fmng026_desc name="input.c.page4.fmng026_desc"
            #利潤中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 =  g_fmng4_d[l_ac].fmng026
            LET g_qryparam.arg1 = g_fmmu_m.fmmudocdt
            CALL q_ooeg001_5()
            LET g_fmng4_d[l_ac].fmng026 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng026_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng026_desc
            NEXT FIELD fmng026_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng027
            #add-point:ON ACTION controlp INFIELD fmng027 name="input.c.page4.fmng027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng027_desc
            #add-point:ON ACTION controlp INFIELD fmng027_desc name="input.c.page4.fmng027_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng027
            CALL q_oocq002_287()
            LET g_fmng4_d[l_ac].fmng027 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng027_desc = g_qryparam.return1
            DISPLAY BY NAME  g_fmng4_d[l_ac].fmng027,g_fmng4_d[l_ac].fmng027_desc
            NEXT FIELD fmng027_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng028
            #add-point:ON ACTION controlp INFIELD fmng028 name="input.c.page4.fmng028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng028_desc
            #add-point:ON ACTION controlp INFIELD fmng028_desc name="input.c.page4.fmng028_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng028
            CALL q_oocq002_281()
            LET g_fmng4_d[l_ac].fmng028 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng028_desc = g_qryparam.return1
            DISPLAY BY NAME  g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng028_desc
            NEXT FIELD fmng028_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng029
            #add-point:ON ACTION controlp INFIELD fmng029 name="input.c.page4.fmng029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng029_desc
            #add-point:ON ACTION controlp INFIELD fmng029_desc name="input.c.page4.fmng029_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng029
            CALL q_rtax001()
            LET g_fmng4_d[l_ac].fmng029 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng029_desc = g_qryparam.return1
            DISPLAY BY NAME  g_fmng4_d[l_ac].fmng029,g_fmng4_d[l_ac].fmng029_desc
            NEXT FIELD fmng029_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng030
            #add-point:ON ACTION controlp INFIELD fmng030 name="input.c.page4.fmng030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng030_desc
            #add-point:ON ACTION controlp INFIELD fmng030_desc name="input.c.page4.fmng030_desc"
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng030
            CALL q_ooag001_8()
            LET g_fmng4_d[l_ac].fmng030 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng030_desc = g_qryparam.return1 
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng030,g_fmng4_d[l_ac].fmng030_desc
            NEXT FIELD fmng030_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng031
            #add-point:ON ACTION controlp INFIELD fmng031 name="input.c.page4.fmng031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng031_desc
            #add-point:ON ACTION controlp INFIELD fmng031_desc name="input.c.page4.fmng031_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng031
            CALL q_pjba001()
            LET g_fmng4_d[l_ac].fmng031 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng031_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng031_desc
            NEXT FIELD fmng031_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng032
            #add-point:ON ACTION controlp INFIELD fmng032 name="input.c.page4.fmng032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng032_desc
            #add-point:ON ACTION controlp INFIELD fmng032_desc name="input.c.page4.fmng032_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng032
            IF NOT cl_null(g_fmng4_d[l_ac].fmng031) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_fmng4_d[l_ac].fmng031,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            CALL q_pjbb002()
            LET g_fmng4_d[l_ac].fmng032 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng032_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng032_desc
            NEXT FIELD fmng032_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng033
            #add-point:ON ACTION controlp INFIELD fmng033 name="input.c.page4.fmng033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng033_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng033_desc
            #add-point:ON ACTION controlp INFIELD fmng033_desc name="input.c.page4.fmng033_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng034
            #add-point:ON ACTION controlp INFIELD fmng034 name="input.c.page4.fmng034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng034_desc
            #add-point:ON ACTION controlp INFIELD fmng034_desc name="input.c.page4.fmng034_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng034
            CALL q_oojd001_2()
            LET g_fmng4_d[l_ac].fmng034 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng034_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng034,g_fmng4_d[l_ac].fmng034_desc
            NEXT FIELD fmng034_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng035
            #add-point:ON ACTION controlp INFIELD fmng035 name="input.c.page4.fmng035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng035_desc
            #add-point:ON ACTION controlp INFIELD fmng035_desc name="input.c.page4.fmng035_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng035
            CALL q_oocq002_2002()
            LET g_fmng4_d[l_ac].fmng035 = g_qryparam.return1
            LET g_fmng4_d[l_ac].fmng035_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmng4_d[l_ac].fmng035,g_fmng4_d[l_ac].fmng035_desc
            NEXT FIELD fmng035_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng036
            #add-point:ON ACTION controlp INFIELD fmng036 name="input.c.page4.fmng036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng036_desc
            #add-point:ON ACTION controlp INFIELD fmng036_desc name="input.c.page4.fmng036_desc"
            #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng036
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmng4_d[l_ac].fmng036 = g_qryparam.return1
               LET g_fmng4_d[l_ac].fmng036_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmng4_d[l_ac].fmng036,g_fmng4_d[l_ac].fmng036_desc
               NEXT FIELD fmng036_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng037
            #add-point:ON ACTION controlp INFIELD fmng037 name="input.c.page4.fmng037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng037_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng037_desc
            #add-point:ON ACTION controlp INFIELD fmng037_desc name="input.c.page4.fmng037_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng037
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)
               LET g_fmng4_d[l_ac].fmng037 = g_qryparam.return1
               LET g_fmng4_d[l_ac].fmng037_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmng4_d[l_ac].fmng037,g_fmng4_d[l_ac].fmng037_desc
               NEXT FIELD fmng037_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng038
            #add-point:ON ACTION controlp INFIELD fmng038 name="input.c.page4.fmng038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng038_desc
            #add-point:ON ACTION controlp INFIELD fmng038_desc name="input.c.page4.fmng038_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng038
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmng4_d[l_ac].fmng038 = g_qryparam.return1
               LET g_fmng4_d[l_ac].fmng038_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmng4_d[l_ac].fmng038,g_fmng4_d[l_ac].fmng038_desc
               NEXT FIELD fmng038_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng039
            #add-point:ON ACTION controlp INFIELD fmng039 name="input.c.page4.fmng039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng039_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng039_desc
            #add-point:ON ACTION controlp INFIELD fmng039_desc name="input.c.page4.fmng039_desc"
            #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng039
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmng4_d[l_ac].fmng039 = g_qryparam.return1
               LET g_fmng4_d[l_ac].fmng039_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmng4_d[l_ac].fmng039,g_fmng4_d[l_ac].fmng039_desc
               NEXT FIELD fmng039_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng040
            #add-point:ON ACTION controlp INFIELD fmng040 name="input.c.page4.fmng040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng040_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng040_desc
            #add-point:ON ACTION controlp INFIELD fmng040_desc name="input.c.page4.fmng040_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng040
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmng4_d[l_ac].fmng040 = g_qryparam.return1
               LET g_fmng4_d[l_ac].fmng040_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmng4_d[l_ac].fmng040,g_fmng4_d[l_ac].fmng040_desc
               NEXT FIELD fmng040_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng041
            #add-point:ON ACTION controlp INFIELD fmng041 name="input.c.page4.fmng041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng041_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng041_desc
            #add-point:ON ACTION controlp INFIELD fmng041_desc name="input.c.page4.fmng041_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng041
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmng4_d[l_ac].fmng041 = g_qryparam.return1
               LET g_fmng4_d[l_ac].fmng041_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmng4_d[l_ac].fmng041,g_fmng4_d[l_ac].fmng041_desc 
               NEXT FIELD fmng041_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng042
            #add-point:ON ACTION controlp INFIELD fmng042 name="input.c.page4.fmng042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng042_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng042_desc
            #add-point:ON ACTION controlp INFIELD fmng042_desc name="input.c.page4.fmng042_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng042
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmng4_d[l_ac].fmng042 = g_qryparam.return1
               LET g_fmng4_d[l_ac].fmng042_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmng4_d[l_ac].fmng042,g_fmng4_d[l_ac].fmng042_desc
               NEXT FIELD fmng042_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng043
            #add-point:ON ACTION controlp INFIELD fmng043 name="input.c.page4.fmng043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng043_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng043_desc
            #add-point:ON ACTION controlp INFIELD fmng043_desc name="input.c.page4.fmng043_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng043
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmng4_d[l_ac].fmng043 = g_qryparam.return1
               LET g_fmng4_d[l_ac].fmng043_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmng4_d[l_ac].fmng043,g_fmng4_d[l_ac].fmng043_desc
               NEXT FIELD fmng043_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng044
            #add-point:ON ACTION controlp INFIELD fmng044 name="input.c.page4.fmng044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng044_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng044_desc
            #add-point:ON ACTION controlp INFIELD fmng044_desc name="input.c.page4.fmng044_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng044
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmng4_d[l_ac].fmng044 = g_qryparam.return1
               LET g_fmng4_d[l_ac].fmng044_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmng4_d[l_ac].fmng044,g_fmng4_d[l_ac].fmng044_desc
               NEXT FIELD fmng044_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng045
            #add-point:ON ACTION controlp INFIELD fmng045 name="input.c.page4.fmng045"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fmng045_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmng045_desc
            #add-point:ON ACTION controlp INFIELD fmng045_desc name="input.c.page4.fmng045_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmng4_d[l_ac].fmng045
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmng4_d[l_ac].fmng045 = g_qryparam.return1
               LET g_fmng4_d[l_ac].fmng045_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmng4_d[l_ac].fmng045,g_fmng4_d[l_ac].fmng045_desc
               NEXT FIELD fmng045_desc
            END IF
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmng4_d[l_ac].* = g_fmng4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt565_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt565_unlock_b("fmng_t","'4'")
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
               LET g_fmng_d[li_reproduce_target].* = g_fmng_d[li_reproduce].*
               LET g_fmng2_d[li_reproduce_target].* = g_fmng2_d[li_reproduce].*
               LET g_fmng3_d[li_reproduce_target].* = g_fmng3_d[li_reproduce].*
               LET g_fmng4_d[li_reproduce_target].* = g_fmng4_d[li_reproduce].*
 
               LET g_fmng4_d[li_reproduce_target].fmngseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmng4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmng4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="afmt565.input.other" >}
      
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
            NEXT FIELD fmmudocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fmngseq
               WHEN "s_detail2"
                  NEXT FIELD fmngseq_2
               WHEN "s_detail3"
                  NEXT FIELD fmngseq_3
               WHEN "s_detail4"
                  NEXT FIELD fmngseq_4
 
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
   IF NOT INT_FLAG THEN
      IF g_glaa.glaa121 = 'Y' THEN
         CALL s_transaction_begin()
         CALL s_pre_voucher_ins('FM','M40',g_fmmu_m.fmmu001,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt,'7')
              RETURNING g_sub_success
         IF g_sub_success THEN
            CALL s_transaction_end('Y','0')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
      END IF
   END IF
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afmt565.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afmt565_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afmt565_b_fill() #單身填充
      CALL afmt565_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt565_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   LET g_fmmu_m.fmmusite_desc = s_desc_get_department_desc(g_fmmu_m.fmmusite)   #帳務中心
   LET g_fmmu_m.fmmu001_desc  = s_desc_get_ld_desc(g_fmmu_m.fmmu001)            #帳套
   CALL afmt565_set_ld_info(g_fmmu_m.fmmu001) RETURNING g_fmmu_m.l_comp
   LET g_fmmu_m.comp_desc = s_desc_get_department_desc(g_fmmu_m.l_comp)   #法人
   LET g_fmmu_m.fmmudocno_desc= s_aooi200_fin_get_slip_desc(g_fmmu_m.fmmudocno) #單別
   CALL cl_set_act_visible("afmt565_02", TRUE)
   IF cl_null(g_fmmu_m.fmmudocno) THEN
      CALL cl_set_act_visible("afmt565_02", FALSE)
   ENd IF
   #end add-point
   
   #遮罩相關處理
   LET g_fmmu_m_mask_o.* =  g_fmmu_m.*
   CALL afmt565_fmmu_t_mask()
   LET g_fmmu_m_mask_n.* =  g_fmmu_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmmu_m.fmmusite,g_fmmu_m.fmmusite_desc,g_fmmu_m.fmmu001,g_fmmu_m.fmmu001_desc,g_fmmu_m.l_comp, 
       g_fmmu_m.comp_desc,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocno_desc,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmu002, 
       g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus,g_fmmu_m.fmmuownid,g_fmmu_m.fmmuownid_desc, 
       g_fmmu_m.fmmuowndp,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtid_desc,g_fmmu_m.fmmucrtdp, 
       g_fmmu_m.fmmucrtdp_desc,g_fmmu_m.fmmucrtdt,g_fmmu_m.fmmumodid,g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmumoddt, 
       g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid,g_fmmu_m.fmmupstid_desc, 
       g_fmmu_m.fmmupstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmu_m.fmmustus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_fmng_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_fmng2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fmng3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fmng4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afmt565_detail_show()
 
   #add-point:show段之後 name="show.after"
 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afmt565_detail_show()
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
 
{<section id="afmt565.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt565_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fmmu_t.fmmudocno 
   DEFINE l_oldno     LIKE fmmu_t.fmmudocno 
 
   DEFINE l_master    RECORD LIKE fmmu_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fmng_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_fmmu_m.fmmudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_fmmudocno_t = g_fmmu_m.fmmudocno
 
    
   LET g_fmmu_m.fmmudocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmmu_m.fmmuownid = g_user
      LET g_fmmu_m.fmmuowndp = g_dept
      LET g_fmmu_m.fmmucrtid = g_user
      LET g_fmmu_m.fmmucrtdp = g_dept 
      LET g_fmmu_m.fmmucrtdt = cl_get_current()
      LET g_fmmu_m.fmmumodid = g_user
      LET g_fmmu_m.fmmumoddt = cl_get_current()
      LET g_fmmu_m.fmmustus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmu_m.fmmustus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_fmmu_m.fmmudocno_desc = ''
   DISPLAY BY NAME g_fmmu_m.fmmudocno_desc
 
   
   CALL afmt565_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fmmu_m.* TO NULL
      INITIALIZE g_fmng_d TO NULL
      INITIALIZE g_fmng2_d TO NULL
      INITIALIZE g_fmng3_d TO NULL
      INITIALIZE g_fmng4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afmt565_show()
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
   CALL afmt565_set_act_visible()   
   CALL afmt565_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmmudocno_t = g_fmmu_m.fmmudocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmmuent = " ||g_enterprise|| " AND",
                      " fmmudocno = '", g_fmmu_m.fmmudocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt565_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afmt565_idx_chk()
   
   LET g_data_owner = g_fmmu_m.fmmuownid      
   LET g_data_dept  = g_fmmu_m.fmmuowndp
   
   #功能已完成,通報訊息中心
   CALL afmt565_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt565.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afmt565_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fmng_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afmt565_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmng_t
    WHERE fmngent = g_enterprise AND fmngdocno = g_fmmudocno_t
 
    INTO TEMP afmt565_detail
 
   #將key修正為調整後   
   UPDATE afmt565_detail 
      #更新key欄位
      SET fmngdocno = g_fmmu_m.fmmudocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fmng_t SELECT * FROM afmt565_detail
   
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
   DROP TABLE afmt565_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fmmudocno_t = g_fmmu_m.fmmudocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afmt565_delete()
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
   
   IF g_fmmu_m.fmmudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afmt565_cl USING g_enterprise,g_fmmu_m.fmmudocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt565_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt565_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt565_master_referesh USING g_fmmu_m.fmmudocno INTO g_fmmu_m.fmmusite,g_fmmu_m.fmmu001, 
       g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmu002,g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus, 
       g_fmmu_m.fmmuownid,g_fmmu_m.fmmuowndp,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtdp,g_fmmu_m.fmmucrtdt, 
       g_fmmu_m.fmmumodid,g_fmmu_m.fmmumoddt,g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid, 
       g_fmmu_m.fmmupstdt,g_fmmu_m.fmmuownid_desc,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid_desc,g_fmmu_m.fmmucrtdp_desc, 
       g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmupstid_desc
   
   
   #檢查是否允許此動作
   IF NOT afmt565_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmmu_m_mask_o.* =  g_fmmu_m.*
   CALL afmt565_fmmu_t_mask()
   LET g_fmmu_m_mask_n.* =  g_fmmu_m.*
   
   CALL afmt565_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt565_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_fmmudocno_t = g_fmmu_m.fmmudocno
 
 
      DELETE FROM fmmu_t
       WHERE fmmuent = g_enterprise AND fmmudocno = g_fmmu_m.fmmudocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_fmmu_m.fmmudocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_fmmu_m.fmmu001,g_fmmu_m.fmmudocno ,g_fmmu_m.fmmudocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #刪除底稿
      IF g_glaa.glaa121 = 'Y' THEN
         CALL s_pre_voucher_del('FM','M40',g_fmmu_m.fmmu001,g_fmmu_m.fmmudocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_fmmu_m.fmmudocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = FALSE
            CALL cl_err()
         END IF
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM fmng_t
       WHERE fmngent = g_enterprise AND fmngdocno = g_fmmu_m.fmmudocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fmmu_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afmt565_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fmng_d.clear() 
      CALL g_fmng2_d.clear()       
      CALL g_fmng3_d.clear()       
      CALL g_fmng4_d.clear()       
 
     
      CALL afmt565_ui_browser_refresh()  
      #CALL afmt565_ui_headershow()  
      #CALL afmt565_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afmt565_browser_fill("")
         CALL afmt565_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afmt565_cl
 
   #功能已完成,通報訊息中心
   CALL afmt565_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afmt565.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmt565_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #160129-00015#10 add(S)
   #多語言SQL
   DEFINE l_get_sql   RECORD
          fmng020     STRING,
          fmng021     STRING,
          fmng022     STRING,
          fmng023     STRING,
          fmng024     STRING,
          fmng025     STRING,
          fmng026     STRING,
          fmng027     STRING,
          fmng028     STRING,
          fmng029     STRING,
          fmng030     STRING,
          fmng031     STRING,
          fmng032     STRING,
          fmng034     STRING,
          fmng035     STRING
                      END RECORD
   #160129-00015#10 add(E)
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fmng_d.clear()
   CALL g_fmng2_d.clear()
   CALL g_fmng3_d.clear()
   CALL g_fmng4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
   
   #判斷是否填充
   IF afmt565_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmngseq,fmng001,fmng002,fmng003,fmng004,fmng005,fmng006,fmng007, 
             fmng008,fmng009,fmng010,fmng011,fmngseq,fmng012,fmng013,fmng014,fmng015,fmngseq,fmng016, 
             fmng017,fmng018,fmng019,fmngseq,fmng020,fmng021,fmng022,fmng046,fmng023,fmng024,fmng025, 
             fmng026,fmng027,fmng028,fmng029,fmng030,fmng031,fmng032,fmng033,fmng034,fmng035,fmng036, 
             fmng037,fmng038,fmng039,fmng040,fmng041,fmng042,fmng043,fmng044,fmng045  FROM fmng_t",  
               
                     " INNER JOIN fmmu_t ON fmmuent = " ||g_enterprise|| " AND fmmudocno = fmngdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE fmngent=? AND fmngdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
 
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmng_t.fmngseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt565_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afmt565_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fmmu_m.fmmudocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fmmu_m.fmmudocno INTO g_fmng_d[l_ac].fmngseq,g_fmng_d[l_ac].fmng001, 
          g_fmng_d[l_ac].fmng002,g_fmng_d[l_ac].fmng003,g_fmng_d[l_ac].fmng004,g_fmng_d[l_ac].fmng005, 
          g_fmng_d[l_ac].fmng006,g_fmng_d[l_ac].fmng007,g_fmng_d[l_ac].fmng008,g_fmng_d[l_ac].fmng009, 
          g_fmng_d[l_ac].fmng010,g_fmng_d[l_ac].fmng011,g_fmng2_d[l_ac].fmngseq,g_fmng2_d[l_ac].fmng012, 
          g_fmng2_d[l_ac].fmng013,g_fmng2_d[l_ac].fmng014,g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmngseq, 
          g_fmng3_d[l_ac].fmng016,g_fmng3_d[l_ac].fmng017,g_fmng3_d[l_ac].fmng018,g_fmng3_d[l_ac].fmng019, 
          g_fmng4_d[l_ac].fmngseq,g_fmng4_d[l_ac].fmng020,g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng022, 
          g_fmng4_d[l_ac].fmng046,g_fmng4_d[l_ac].fmng023,g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng025, 
          g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng027,g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng029, 
          g_fmng4_d[l_ac].fmng030,g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng033, 
          g_fmng4_d[l_ac].fmng034,g_fmng4_d[l_ac].fmng035,g_fmng4_d[l_ac].fmng036,g_fmng4_d[l_ac].fmng037, 
          g_fmng4_d[l_ac].fmng038,g_fmng4_d[l_ac].fmng039,g_fmng4_d[l_ac].fmng040,g_fmng4_d[l_ac].fmng041, 
          g_fmng4_d[l_ac].fmng042,g_fmng4_d[l_ac].fmng043,g_fmng4_d[l_ac].fmng044,g_fmng4_d[l_ac].fmng045  
            #(ver:78)
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
         #應收股利/利息科目DR
         LET g_fmng4_d[l_ac].fmng020_desc = s_desc_show1(g_fmng4_d[l_ac].fmng020,s_desc_get_account_desc(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng020))
         #對方科目
         LET g_fmng4_d[l_ac].fmng021_desc = s_desc_show1(g_fmng4_d[l_ac].fmng021,s_desc_get_account_desc(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng021))
         #投資收益科目CR
         LET g_fmng4_d[l_ac].fmng022_desc = s_desc_show1(g_fmng4_d[l_ac].fmng022,s_desc_get_account_desc(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng022))
         #交易客商
         LET g_fmng4_d[l_ac].fmng023_desc  = s_desc_show1(g_fmng4_d[l_ac].fmng023,s_desc_get_trading_partner_abbr_desc(g_fmng4_d[l_ac].fmng023))
         #帳款客戶
         LET g_fmng4_d[l_ac].fmng024_desc  = s_desc_show1(g_fmng4_d[l_ac].fmng024,s_desc_get_trading_partner_abbr_desc(g_fmng4_d[l_ac].fmng024))
         
         LET g_fmng4_d[l_ac].fmng025_desc = s_desc_show1(g_fmng4_d[l_ac].fmng025,s_desc_get_department_desc(g_fmng4_d[l_ac].fmng025))
         LET g_fmng4_d[l_ac].fmng026_desc = s_desc_show1(g_fmng4_d[l_ac].fmng026,s_desc_get_department_desc(g_fmng4_d[l_ac].fmng026))
         LET g_fmng4_d[l_ac].fmng027_desc = s_desc_show1(g_fmng4_d[l_ac].fmng027,s_desc_get_acc_desc('287',g_fmng4_d[l_ac].fmng027))
         LET g_fmng4_d[l_ac].fmng028_desc = s_desc_show1(g_fmng4_d[l_ac].fmng028,s_desc_get_acc_desc('281',g_fmng4_d[l_ac].fmng028))
         LET g_fmng4_d[l_ac].fmng029_desc = s_desc_show1(g_fmng4_d[l_ac].fmng029,s_desc_get_rtaxl003_desc(g_fmng4_d[l_ac].fmng029))
         LET g_fmng4_d[l_ac].fmng030_desc = s_desc_show1(g_fmng4_d[l_ac].fmng030,s_desc_get_person_desc(g_fmng4_d[l_ac].fmng030))
         LET g_fmng4_d[l_ac].fmng031_desc = s_desc_show1(g_fmng4_d[l_ac].fmng031,s_desc_get_project_desc(g_fmng4_d[l_ac].fmng031))
         LET g_fmng4_d[l_ac].fmng032_desc = s_desc_show1(g_fmng4_d[l_ac].fmng032,s_desc_get_pjbbl004_desc(g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng032))
         LET g_fmng4_d[l_ac].fmng033_desc = g_fmng4_d[l_ac].fmng033
         LET g_fmng4_d[l_ac].fmng034_desc = s_desc_show1(g_fmng4_d[l_ac].fmng034,s_desc_get_oojdl003_desc(g_fmng4_d[l_ac].fmng034))
         LET g_fmng4_d[l_ac].fmng035_desc = s_desc_show1(g_fmng4_d[l_ac].fmng035,s_desc_get_acc_desc('2002',g_fmng4_d[l_ac].fmng035))

         #自由核算項
         CALL s_fin_sel_glad(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng020,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
              RETURNING g_errno,g_glad.*
         IF NOT cl_null(g_fmng4_d[l_ac].fmng036) THEN
            LET g_fmng4_d[l_ac].fmng036_desc = s_desc_show1(g_fmng4_d[l_ac].fmng036,s_fin_get_accting_desc(g_glad.glad0171,g_fmng4_d[l_ac].fmng036))
         END IF
         IF NOT cl_null(g_fmng4_d[l_ac].fmng037) THEN
            LET g_fmng4_d[l_ac].fmng037_desc = s_desc_show1(g_fmng4_d[l_ac].fmng037,s_fin_get_accting_desc(g_glad.glad0181,g_fmng4_d[l_ac].fmng037))
         END IF
         IF NOT cl_null(g_fmng4_d[l_ac].fmng038) THEN
            LET g_fmng4_d[l_ac].fmng038_desc = s_desc_show1(g_fmng4_d[l_ac].fmng038,s_fin_get_accting_desc(g_glad.glad0191,g_fmng4_d[l_ac].fmng038))
         END IF
         IF NOT cl_null(g_fmng4_d[l_ac].fmng039) THEN
            LET g_fmng4_d[l_ac].fmng039_desc = s_desc_show1(g_fmng4_d[l_ac].fmng039,s_fin_get_accting_desc(g_glad.glad0201,g_fmng4_d[l_ac].fmng039))
         END IF
         IF NOT cl_null(g_fmng4_d[l_ac].fmng040) THEN
            LET g_fmng4_d[l_ac].fmng040_desc = s_desc_show1(g_fmng4_d[l_ac].fmng040,s_fin_get_accting_desc(g_glad.glad0211,g_fmng4_d[l_ac].fmng040))
         END IF
         IF NOT cl_null(g_fmng4_d[l_ac].fmng041) THEN
            LET g_fmng4_d[l_ac].fmng041_desc = s_desc_show1(g_fmng4_d[l_ac].fmng041,s_fin_get_accting_desc(g_glad.glad0221,g_fmng4_d[l_ac].fmng041))
         END IF
         IF NOT cl_null(g_fmng4_d[l_ac].fmng042) THEN
            LET g_fmng4_d[l_ac].fmng042_desc = s_desc_show1(g_fmng4_d[l_ac].fmng042,s_fin_get_accting_desc(g_glad.glad0231,g_fmng4_d[l_ac].fmng042))
         END IF
         IF NOT cl_null(g_fmng4_d[l_ac].fmng043) THEN
            LET g_fmng4_d[l_ac].fmng043_desc = s_desc_show1(g_fmng4_d[l_ac].fmng043,s_fin_get_accting_desc(g_glad.glad0241,g_fmng4_d[l_ac].fmng043))
         END IF
         IF NOT cl_null(g_fmng4_d[l_ac].fmng044) THEN
            LET g_fmng4_d[l_ac].fmng044_desc = s_desc_show1(g_fmng4_d[l_ac].fmng044,s_fin_get_accting_desc(g_glad.glad0251,g_fmng4_d[l_ac].fmng044))
         END IF
         IF NOT cl_null(g_fmng4_d[l_ac].fmng045) THEN
            LET g_fmng4_d[l_ac].fmng045_desc = s_desc_show1(g_fmng4_d[l_ac].fmng045,s_fin_get_accting_desc(g_glad.glad0261,g_fmng4_d[l_ac].fmng045))
         END IF
         
         
         SELECT fmmt005,fmmt006,fmmt007,fmmt008,fmmt009
           INTO g_fmng_d[l_ac].l_fmmt005,g_fmng_d[l_ac].l_fmmt006,g_fmng_d[l_ac].l_fmmt007,
                g_fmng_d[l_ac].l_fmmt008,g_fmng_d[l_ac].l_fmmt009
           FROM fmms_t
           LEFT JOIN fmmt_t ON fmmsent = fmmtent AND fmmsdocno = fmmtdocno
          WHERE fmmsent = g_enterprise
            AND fmms001 = g_fmmu_m.fmmu002
            AND fmms002 = g_fmmu_m.fmmu003
            AND fmmt001 = g_fmng_d[l_ac].fmng001
            AND fmmt002 = g_fmng_d[l_ac].fmng002
            
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
   #160129-00015#10 add(S)
   
   #應收股利/利息科目DR
   CALL s_fin_get_account_sql('ta1','ta2','fmngent','fmmu001','fmng020') RETURNING l_get_sql.fmng020
   #利息調整科目
   CALL s_fin_get_account_sql('ta3','ta4','fmngent','fmmu001','fmng021') RETURNING l_get_sql.fmng021
   #投資收益科目CR
   CALL s_fin_get_account_sql('ta5','ta6','fmngent','fmmu001','fmng022') RETURNING l_get_sql.fmng022
   #帳款對象
   CALL s_fin_get_trading_partner_abbr_sql('ta7','fmngent','fmng023') RETURNING l_get_sql.fmng023
   #收款對象
   CALL s_fin_get_trading_partner_abbr_sql('ta8','fmngent','fmng024') RETURNING l_get_sql.fmng024
   #部門
   CALL s_fin_get_department_sql('ta9','fmngent','fmng025') RETURNING l_get_sql.fmng025
   #利潤中心
   CALL s_fin_get_department_sql('ta10','fmngent','fmng026') RETURNING l_get_sql.fmng026
   #區域
   CALL s_fin_get_acc_sql('ta11','fmngent','287','fmng027') RETURNING l_get_sql.fmng027
   #客群
   CALL s_fin_get_acc_sql('ta12','fmngent','281','fmng028') RETURNING l_get_sql.fmng028
   #產品類別
   CALL s_fin_get_rtaxl003_sql('ta13','fmngent','fmng029') RETURNING l_get_sql.fmng029
   #人員
   CALL s_fin_get_person_sql('ta14','fmngent','fmng030') RETURNING l_get_sql.fmng030
   #專案代號
   CALL s_fin_get_project_sql('ta15','fmngent','fmng031') RETURNING l_get_sql.fmng031
   #WBS編號
   CALL s_fin_get_wbs_sql('ta16','fmngent','fmng031','fmng032') RETURNING l_get_sql.fmng032
   #渠道
   CALL s_fin_get_oojdl003_sql('ta17','fmngent','fmng034') RETURNING l_get_sql.fmng034
   #品牌
   CALL s_fin_get_acc_sql('ta18','fmngent','2002','fmng035') RETURNING l_get_sql.fmng035
	  
	LET g_sql = "SELECT  DISTINCT fmngseq,fmng001,fmng002,fmng003,fmng004,fmng005,fmng006,fmng007, ",  
               "                 fmng008,fmng009,fmng010,fmng011,fmngseq,fmng012,fmng013,fmng014, ",
			      "                 fmng015,fmngseq,fmng016,fmng017,fmng018,fmng019,fmngseq,fmng020, ",
			      "                 fmng021,fmng022,fmng046,fmng023,fmng024,fmng025,fmng026,fmng027, ",
			      "                 fmng028,fmng029,fmng030,fmng031,fmng032,fmng033,fmng034,fmng035, ",
			      "                 fmng036,fmng037,fmng038,fmng039,fmng040,fmng041,fmng042,fmng043, ",
			      "                 fmng044,fmng045,",
			                        l_get_sql.fmng020,",",l_get_sql.fmng021,",",l_get_sql.fmng022,",",
			                        l_get_sql.fmng023,",",l_get_sql.fmng024,",",l_get_sql.fmng025,",",
			                        l_get_sql.fmng026,",",l_get_sql.fmng027,",",l_get_sql.fmng028,",",
			                        l_get_sql.fmng029,",",l_get_sql.fmng030,",",l_get_sql.fmng031,",",
			                        l_get_sql.fmng032,",",l_get_sql.fmng034,",",l_get_sql.fmng035,
			      "  FROM fmng_t",
               " INNER JOIN fmmu_t ON fmmudocno = fmngdocno ",
               " WHERE fmngent=? AND fmngdocno=?"
    LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
    
    IF NOT cl_null(g_wc2_table1) THEN
       LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
    END IF
    
    #子單身的WC
    
    LET g_sql = g_sql, " ORDER BY fmng_t.fmngseq"
    LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
    PREPARE afmt565_pb1 FROM g_sql
    DECLARE b_fill_cs1 CURSOR FOR afmt565_pb1
    
    LET g_cnt = l_ac
    LET l_ac = 1
    
    OPEN b_fill_cs1 USING g_enterprise,g_fmmu_m.fmmudocno
                                             
    FOREACH b_fill_cs1 INTO g_fmng_d[l_ac].fmngseq, g_fmng_d[l_ac].fmng001, g_fmng_d[l_ac].fmng002, g_fmng_d[l_ac].fmng003, 
                            g_fmng_d[l_ac].fmng004, g_fmng_d[l_ac].fmng005, g_fmng_d[l_ac].fmng006, g_fmng_d[l_ac].fmng007, 
                            g_fmng_d[l_ac].fmng008, g_fmng_d[l_ac].fmng009, g_fmng_d[l_ac].fmng010, g_fmng_d[l_ac].fmng011, 
                            g_fmng2_d[l_ac].fmngseq,g_fmng2_d[l_ac].fmng012,g_fmng2_d[l_ac].fmng013,g_fmng2_d[l_ac].fmng014, 
                            g_fmng2_d[l_ac].fmng015,g_fmng3_d[l_ac].fmngseq,g_fmng3_d[l_ac].fmng016,g_fmng3_d[l_ac].fmng017, 
                            g_fmng3_d[l_ac].fmng018,g_fmng3_d[l_ac].fmng019,g_fmng4_d[l_ac].fmngseq,g_fmng4_d[l_ac].fmng020, 
                            g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng046,g_fmng4_d[l_ac].fmng023, 
                            g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng025,g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng027, 
                            g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng029,g_fmng4_d[l_ac].fmng030,g_fmng4_d[l_ac].fmng031, 
                            g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng033,g_fmng4_d[l_ac].fmng034,g_fmng4_d[l_ac].fmng035, 
                            g_fmng4_d[l_ac].fmng036,g_fmng4_d[l_ac].fmng037,g_fmng4_d[l_ac].fmng038,g_fmng4_d[l_ac].fmng039, 
                            g_fmng4_d[l_ac].fmng040,g_fmng4_d[l_ac].fmng041,g_fmng4_d[l_ac].fmng042,g_fmng4_d[l_ac].fmng043, 
                            g_fmng4_d[l_ac].fmng044,g_fmng4_d[l_ac].fmng045,
						          g_fmng4_d[l_ac].fmng020_desc,g_fmng4_d[l_ac].fmng021_desc,g_fmng4_d[l_ac].fmng022_desc,
						          g_fmng4_d[l_ac].fmng023_desc,g_fmng4_d[l_ac].fmng024_desc,g_fmng4_d[l_ac].fmng025_desc,
						          g_fmng4_d[l_ac].fmng026_desc,g_fmng4_d[l_ac].fmng027_desc,g_fmng4_d[l_ac].fmng028_desc,
						          g_fmng4_d[l_ac].fmng029_desc,g_fmng4_d[l_ac].fmng030_desc,g_fmng4_d[l_ac].fmng031_desc,
						          g_fmng4_d[l_ac].fmng032_desc,g_fmng4_d[l_ac].fmng034_desc,g_fmng4_d[l_ac].fmng035_desc
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
    
       #固定核算項
       #應收股利/利息科目DR
       LET g_fmng4_d[l_ac].fmng020_desc = s_desc_show1(g_fmng4_d[l_ac].fmng020,g_fmng4_d[l_ac].fmng020_desc)
       #對方科目
       LET g_fmng4_d[l_ac].fmng021_desc = s_desc_show1(g_fmng4_d[l_ac].fmng021,g_fmng4_d[l_ac].fmng021_desc)
       #投資收益科目CR
       LET g_fmng4_d[l_ac].fmng022_desc = s_desc_show1(g_fmng4_d[l_ac].fmng022,g_fmng4_d[l_ac].fmng022_desc)
       #交易客商
       LET g_fmng4_d[l_ac].fmng023_desc  = s_desc_show1(g_fmng4_d[l_ac].fmng023,g_fmng4_d[l_ac].fmng023_desc)
       #帳款客戶
       LET g_fmng4_d[l_ac].fmng024_desc  = s_desc_show1(g_fmng4_d[l_ac].fmng024,g_fmng4_d[l_ac].fmng024_desc)
       LET g_fmng4_d[l_ac].fmng025_desc = s_desc_show1(g_fmng4_d[l_ac].fmng025,g_fmng4_d[l_ac].fmng025_desc)
       LET g_fmng4_d[l_ac].fmng026_desc = s_desc_show1(g_fmng4_d[l_ac].fmng026,g_fmng4_d[l_ac].fmng026_desc)
       LET g_fmng4_d[l_ac].fmng027_desc = s_desc_show1(g_fmng4_d[l_ac].fmng027,g_fmng4_d[l_ac].fmng027_desc)
       LET g_fmng4_d[l_ac].fmng028_desc = s_desc_show1(g_fmng4_d[l_ac].fmng028,g_fmng4_d[l_ac].fmng028_desc)
       LET g_fmng4_d[l_ac].fmng029_desc = s_desc_show1(g_fmng4_d[l_ac].fmng029,g_fmng4_d[l_ac].fmng029_desc)
       LET g_fmng4_d[l_ac].fmng030_desc = s_desc_show1(g_fmng4_d[l_ac].fmng030,g_fmng4_d[l_ac].fmng030_desc)
       LET g_fmng4_d[l_ac].fmng031_desc = s_desc_show1(g_fmng4_d[l_ac].fmng031,g_fmng4_d[l_ac].fmng031_desc)
       LET g_fmng4_d[l_ac].fmng032_desc = s_desc_show1(g_fmng4_d[l_ac].fmng032,g_fmng4_d[l_ac].fmng032_desc)
       LET g_fmng4_d[l_ac].fmng033_desc = g_fmng4_d[l_ac].fmng033
       LET g_fmng4_d[l_ac].fmng034_desc = s_desc_show1(g_fmng4_d[l_ac].fmng034,g_fmng4_d[l_ac].fmng034_desc)
       LET g_fmng4_d[l_ac].fmng035_desc = s_desc_show1(g_fmng4_d[l_ac].fmng035,g_fmng4_d[l_ac].fmng035_desc)
    
       #自由核算項
       CALL s_fin_sel_glad(g_fmmu_m.fmmu001,g_fmng4_d[l_ac].fmng020,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
            RETURNING g_errno,g_glad.*
       IF NOT cl_null(g_fmng4_d[l_ac].fmng036) THEN
          LET g_fmng4_d[l_ac].fmng036_desc = s_desc_show1(g_fmng4_d[l_ac].fmng036,s_fin_get_accting_desc(g_glad.glad0171,g_fmng4_d[l_ac].fmng036))
       END IF
       IF NOT cl_null(g_fmng4_d[l_ac].fmng037) THEN
          LET g_fmng4_d[l_ac].fmng037_desc = s_desc_show1(g_fmng4_d[l_ac].fmng037,s_fin_get_accting_desc(g_glad.glad0181,g_fmng4_d[l_ac].fmng037))
       END IF
       IF NOT cl_null(g_fmng4_d[l_ac].fmng038) THEN
          LET g_fmng4_d[l_ac].fmng038_desc = s_desc_show1(g_fmng4_d[l_ac].fmng038,s_fin_get_accting_desc(g_glad.glad0191,g_fmng4_d[l_ac].fmng038))
       END IF
       IF NOT cl_null(g_fmng4_d[l_ac].fmng039) THEN
          LET g_fmng4_d[l_ac].fmng039_desc = s_desc_show1(g_fmng4_d[l_ac].fmng039,s_fin_get_accting_desc(g_glad.glad0201,g_fmng4_d[l_ac].fmng039))
       END IF
       IF NOT cl_null(g_fmng4_d[l_ac].fmng040) THEN
          LET g_fmng4_d[l_ac].fmng040_desc = s_desc_show1(g_fmng4_d[l_ac].fmng040,s_fin_get_accting_desc(g_glad.glad0211,g_fmng4_d[l_ac].fmng040))
       END IF
       IF NOT cl_null(g_fmng4_d[l_ac].fmng041) THEN
          LET g_fmng4_d[l_ac].fmng041_desc = s_desc_show1(g_fmng4_d[l_ac].fmng041,s_fin_get_accting_desc(g_glad.glad0221,g_fmng4_d[l_ac].fmng041))
       END IF
       IF NOT cl_null(g_fmng4_d[l_ac].fmng042) THEN
          LET g_fmng4_d[l_ac].fmng042_desc = s_desc_show1(g_fmng4_d[l_ac].fmng042,s_fin_get_accting_desc(g_glad.glad0231,g_fmng4_d[l_ac].fmng042))
       END IF
       IF NOT cl_null(g_fmng4_d[l_ac].fmng043) THEN
          LET g_fmng4_d[l_ac].fmng043_desc = s_desc_show1(g_fmng4_d[l_ac].fmng043,s_fin_get_accting_desc(g_glad.glad0241,g_fmng4_d[l_ac].fmng043))
       END IF
       IF NOT cl_null(g_fmng4_d[l_ac].fmng044) THEN
          LET g_fmng4_d[l_ac].fmng044_desc = s_desc_show1(g_fmng4_d[l_ac].fmng044,s_fin_get_accting_desc(g_glad.glad0251,g_fmng4_d[l_ac].fmng044))
       END IF
       IF NOT cl_null(g_fmng4_d[l_ac].fmng045) THEN
          LET g_fmng4_d[l_ac].fmng045_desc = s_desc_show1(g_fmng4_d[l_ac].fmng045,s_fin_get_accting_desc(g_glad.glad0261,g_fmng4_d[l_ac].fmng045))
       END IF
       
       
       SELECT fmmt005,fmmt006,fmmt007,fmmt008,fmmt009
         INTO g_fmng_d[l_ac].l_fmmt005,g_fmng_d[l_ac].l_fmmt006,g_fmng_d[l_ac].l_fmmt007,
              g_fmng_d[l_ac].l_fmmt008,g_fmng_d[l_ac].l_fmmt009
         FROM fmms_t
         LEFT JOIN fmmt_t ON fmmsent = fmmtent AND fmmsdocno = fmmtdocno
        WHERE fmmsent = g_enterprise
          AND fmms001 = g_fmmu_m.fmmu002
          AND fmms002 = g_fmmu_m.fmmu003
          AND fmmt001 = g_fmng_d[l_ac].fmng001
          AND fmmt002 = g_fmng_d[l_ac].fmng002
    
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
   #160129-00015#10 add(E)
   #end add-point
   
   CALL g_fmng_d.deleteElement(g_fmng_d.getLength())
   CALL g_fmng2_d.deleteElement(g_fmng2_d.getLength())
   CALL g_fmng3_d.deleteElement(g_fmng3_d.getLength())
   CALL g_fmng4_d.deleteElement(g_fmng4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afmt565_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fmng_d.getLength()
      LET g_fmng_d_mask_o[l_ac].* =  g_fmng_d[l_ac].*
      CALL afmt565_fmng_t_mask()
      LET g_fmng_d_mask_n[l_ac].* =  g_fmng_d[l_ac].*
   END FOR
   
   LET g_fmng2_d_mask_o.* =  g_fmng2_d.*
   FOR l_ac = 1 TO g_fmng2_d.getLength()
      LET g_fmng2_d_mask_o[l_ac].* =  g_fmng2_d[l_ac].*
      CALL afmt565_fmng_t_mask()
      LET g_fmng2_d_mask_n[l_ac].* =  g_fmng2_d[l_ac].*
   END FOR
   LET g_fmng3_d_mask_o.* =  g_fmng3_d.*
   FOR l_ac = 1 TO g_fmng3_d.getLength()
      LET g_fmng3_d_mask_o[l_ac].* =  g_fmng3_d[l_ac].*
      CALL afmt565_fmng_t_mask()
      LET g_fmng3_d_mask_n[l_ac].* =  g_fmng3_d[l_ac].*
   END FOR
   LET g_fmng4_d_mask_o.* =  g_fmng4_d.*
   FOR l_ac = 1 TO g_fmng4_d.getLength()
      LET g_fmng4_d_mask_o[l_ac].* =  g_fmng4_d[l_ac].*
      CALL afmt565_fmng_t_mask()
      LET g_fmng4_d_mask_n[l_ac].* =  g_fmng4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt565.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afmt565_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM fmng_t
       WHERE fmngent = g_enterprise AND
         fmngdocno = ps_keys_bak[1] AND fmngseq = ps_keys_bak[2]
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
         CALL g_fmng_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_fmng2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_fmng3_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'4'" THEN 
         CALL g_fmng4_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afmt565_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO fmng_t
                  (fmngent,
                   fmngdocno,
                   fmngseq
                   ,fmng001,fmng002,fmng003,fmng004,fmng005,fmng006,fmng007,fmng008,fmng009,fmng010,fmng011,fmng012,fmng013,fmng014,fmng015,fmng016,fmng017,fmng018,fmng019,fmng020,fmng021,fmng022,fmng046,fmng023,fmng024,fmng025,fmng026,fmng027,fmng028,fmng029,fmng030,fmng031,fmng032,fmng033,fmng034,fmng035,fmng036,fmng037,fmng038,fmng039,fmng040,fmng041,fmng042,fmng043,fmng044,fmng045) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_fmng_d[g_detail_idx].fmng001,g_fmng_d[g_detail_idx].fmng002,g_fmng_d[g_detail_idx].fmng003, 
                       g_fmng_d[g_detail_idx].fmng004,g_fmng_d[g_detail_idx].fmng005,g_fmng_d[g_detail_idx].fmng006, 
                       g_fmng_d[g_detail_idx].fmng007,g_fmng_d[g_detail_idx].fmng008,g_fmng_d[g_detail_idx].fmng009, 
                       g_fmng_d[g_detail_idx].fmng010,g_fmng_d[g_detail_idx].fmng011,g_fmng2_d[g_detail_idx].fmng012, 
                       g_fmng2_d[g_detail_idx].fmng013,g_fmng2_d[g_detail_idx].fmng014,g_fmng2_d[g_detail_idx].fmng015, 
                       g_fmng3_d[g_detail_idx].fmng016,g_fmng3_d[g_detail_idx].fmng017,g_fmng3_d[g_detail_idx].fmng018, 
                       g_fmng3_d[g_detail_idx].fmng019,g_fmng4_d[g_detail_idx].fmng020,g_fmng4_d[g_detail_idx].fmng021, 
                       g_fmng4_d[g_detail_idx].fmng022,g_fmng4_d[g_detail_idx].fmng046,g_fmng4_d[g_detail_idx].fmng023, 
                       g_fmng4_d[g_detail_idx].fmng024,g_fmng4_d[g_detail_idx].fmng025,g_fmng4_d[g_detail_idx].fmng026, 
                       g_fmng4_d[g_detail_idx].fmng027,g_fmng4_d[g_detail_idx].fmng028,g_fmng4_d[g_detail_idx].fmng029, 
                       g_fmng4_d[g_detail_idx].fmng030,g_fmng4_d[g_detail_idx].fmng031,g_fmng4_d[g_detail_idx].fmng032, 
                       g_fmng4_d[g_detail_idx].fmng033,g_fmng4_d[g_detail_idx].fmng034,g_fmng4_d[g_detail_idx].fmng035, 
                       g_fmng4_d[g_detail_idx].fmng036,g_fmng4_d[g_detail_idx].fmng037,g_fmng4_d[g_detail_idx].fmng038, 
                       g_fmng4_d[g_detail_idx].fmng039,g_fmng4_d[g_detail_idx].fmng040,g_fmng4_d[g_detail_idx].fmng041, 
                       g_fmng4_d[g_detail_idx].fmng042,g_fmng4_d[g_detail_idx].fmng043,g_fmng4_d[g_detail_idx].fmng044, 
                       g_fmng4_d[g_detail_idx].fmng045)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fmng_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_fmng2_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_fmng3_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'4'" THEN 
         CALL g_fmng4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afmt565_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmng_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afmt565_fmng_t_mask_restore('restore_mask_o')
               
      UPDATE fmng_t 
         SET (fmngdocno,
              fmngseq
              ,fmng001,fmng002,fmng003,fmng004,fmng005,fmng006,fmng007,fmng008,fmng009,fmng010,fmng011,fmng012,fmng013,fmng014,fmng015,fmng016,fmng017,fmng018,fmng019,fmng020,fmng021,fmng022,fmng046,fmng023,fmng024,fmng025,fmng026,fmng027,fmng028,fmng029,fmng030,fmng031,fmng032,fmng033,fmng034,fmng035,fmng036,fmng037,fmng038,fmng039,fmng040,fmng041,fmng042,fmng043,fmng044,fmng045) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_fmng_d[g_detail_idx].fmng001,g_fmng_d[g_detail_idx].fmng002,g_fmng_d[g_detail_idx].fmng003, 
                  g_fmng_d[g_detail_idx].fmng004,g_fmng_d[g_detail_idx].fmng005,g_fmng_d[g_detail_idx].fmng006, 
                  g_fmng_d[g_detail_idx].fmng007,g_fmng_d[g_detail_idx].fmng008,g_fmng_d[g_detail_idx].fmng009, 
                  g_fmng_d[g_detail_idx].fmng010,g_fmng_d[g_detail_idx].fmng011,g_fmng2_d[g_detail_idx].fmng012, 
                  g_fmng2_d[g_detail_idx].fmng013,g_fmng2_d[g_detail_idx].fmng014,g_fmng2_d[g_detail_idx].fmng015, 
                  g_fmng3_d[g_detail_idx].fmng016,g_fmng3_d[g_detail_idx].fmng017,g_fmng3_d[g_detail_idx].fmng018, 
                  g_fmng3_d[g_detail_idx].fmng019,g_fmng4_d[g_detail_idx].fmng020,g_fmng4_d[g_detail_idx].fmng021, 
                  g_fmng4_d[g_detail_idx].fmng022,g_fmng4_d[g_detail_idx].fmng046,g_fmng4_d[g_detail_idx].fmng023, 
                  g_fmng4_d[g_detail_idx].fmng024,g_fmng4_d[g_detail_idx].fmng025,g_fmng4_d[g_detail_idx].fmng026, 
                  g_fmng4_d[g_detail_idx].fmng027,g_fmng4_d[g_detail_idx].fmng028,g_fmng4_d[g_detail_idx].fmng029, 
                  g_fmng4_d[g_detail_idx].fmng030,g_fmng4_d[g_detail_idx].fmng031,g_fmng4_d[g_detail_idx].fmng032, 
                  g_fmng4_d[g_detail_idx].fmng033,g_fmng4_d[g_detail_idx].fmng034,g_fmng4_d[g_detail_idx].fmng035, 
                  g_fmng4_d[g_detail_idx].fmng036,g_fmng4_d[g_detail_idx].fmng037,g_fmng4_d[g_detail_idx].fmng038, 
                  g_fmng4_d[g_detail_idx].fmng039,g_fmng4_d[g_detail_idx].fmng040,g_fmng4_d[g_detail_idx].fmng041, 
                  g_fmng4_d[g_detail_idx].fmng042,g_fmng4_d[g_detail_idx].fmng043,g_fmng4_d[g_detail_idx].fmng044, 
                  g_fmng4_d[g_detail_idx].fmng045) 
         WHERE fmngent = g_enterprise AND fmngdocno = ps_keys_bak[1] AND fmngseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmng_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmng_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt565_fmng_t_mask_restore('restore_mask_n')
               
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
 
{<section id="afmt565.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afmt565_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt565.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afmt565_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt565.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afmt565_lock_b(ps_table,ps_page)
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
   #CALL afmt565_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2','3','4',"
   #僅鎖定自身table
   LET ls_group = "fmng_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afmt565_bcl USING g_enterprise,
                                       g_fmmu_m.fmmudocno,g_fmng_d[g_detail_idx].fmngseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt565_bcl:",SQLERRMESSAGE 
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
 
{<section id="afmt565.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afmt565_unlock_b(ps_table,ps_page)
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
      CLOSE afmt565_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afmt565.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt565_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("fmmudocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fmmudocno",TRUE)
      CALL cl_set_comp_entry("fmmudocdt",TRUE)
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
 
{<section id="afmt565.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt565_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmmudocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("fmmudocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("fmmudocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt565.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afmt565_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("fmng008,fmng012,fmng016",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="afmt565.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afmt565_set_no_entry_b(p_cmd)
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
      #若使用的幣別跟主帳套一樣，匯率不能修改
      IF g_fmng_d[l_ac].fmng003 = g_glaa.glaa001 THEN
         CALL cl_set_comp_entry("fmng008",FALSE)
      END IF
      IF g_fmng_d[l_ac].fmng003 = g_glaa.glaa016 THEN
         CALL cl_set_comp_entry("fmng012",FALSE)
      END IF
      IF g_fmng_d[l_ac].fmng003 = g_glaa.glaa020 THEN
         CALL cl_set_comp_entry("fmng016",FALSE)
      END IF
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="afmt565.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt565_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail,open_afmt565_02",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt565_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF cl_null(g_fmmu_m.fmmudocno) OR g_fmmu_m.fmmustus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail,open_afmt565_02", FALSE)
   END IF

   IF cl_null(g_fmmu_m.fmmudocno) THEN
      CALL cl_set_act_visible("open_afmt565_02", FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afmt565_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afmt565_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt565_default_search()
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
      LET ls_wc = ls_wc, " fmmudocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "fmmu_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fmng_t" 
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
 
{<section id="afmt565.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afmt565_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fmmu_m.fmmudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afmt565_cl USING g_enterprise,g_fmmu_m.fmmudocno
   IF STATUS THEN
      CLOSE afmt565_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt565_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afmt565_master_referesh USING g_fmmu_m.fmmudocno INTO g_fmmu_m.fmmusite,g_fmmu_m.fmmu001, 
       g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmu002,g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus, 
       g_fmmu_m.fmmuownid,g_fmmu_m.fmmuowndp,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtdp,g_fmmu_m.fmmucrtdt, 
       g_fmmu_m.fmmumodid,g_fmmu_m.fmmumoddt,g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid, 
       g_fmmu_m.fmmupstdt,g_fmmu_m.fmmuownid_desc,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid_desc,g_fmmu_m.fmmucrtdp_desc, 
       g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmupstid_desc
   
 
   #檢查是否允許此動作
   IF NOT afmt565_action_chk() THEN
      CLOSE afmt565_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmmu_m.fmmusite,g_fmmu_m.fmmusite_desc,g_fmmu_m.fmmu001,g_fmmu_m.fmmu001_desc,g_fmmu_m.l_comp, 
       g_fmmu_m.comp_desc,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocno_desc,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmu002, 
       g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus,g_fmmu_m.fmmuownid,g_fmmu_m.fmmuownid_desc, 
       g_fmmu_m.fmmuowndp,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtid_desc,g_fmmu_m.fmmucrtdp, 
       g_fmmu_m.fmmucrtdp_desc,g_fmmu_m.fmmucrtdt,g_fmmu_m.fmmumodid,g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmumoddt, 
       g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid,g_fmmu_m.fmmupstid_desc, 
       g_fmmu_m.fmmupstdt
 
   CASE g_fmmu_m.fmmustus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_fmmu_m.fmmustus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "N"
               HIDE OPTION "unconfirmed"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)
     
      CASE g_fmmu_m.fmmustus
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
            CALL s_transaction_end('N','0')      #150401-00001#13
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
            IF NOT afmt565_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt565_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afmt565_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt565_cl
            RETURN
         END IF
 
 
 
	  
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
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
 
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "Y" 
      AND lc_state <> "X"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "N"
      ) OR 
      g_fmmu_m.fmmustus = lc_state OR cl_null(lc_state) THEN
      CLOSE afmt565_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      IF g_fmmu_m.fmmustus = 'N' THEN
         CALL cl_err_collect_init()
         CALL s_afmt565_conf_chk(g_fmmu_m.fmmudocno) RETURNING g_sub_success
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
               CALL s_afmt565_conf_upd(g_fmmu_m.fmmudocno) RETURNING g_sub_success
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
      CALL s_afmt565_unconf_chk(g_fmmu_m.fmmudocno) RETURNING g_sub_success
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
            CALL s_afmt565_unconf_upd(g_fmmu_m.fmmudocno) RETURNING g_sub_success
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
      CALL s_afmt565_void_chk(g_fmmu_m.fmmudocno) RETURNING g_sub_success
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
            CALL s_afmt565_void_upd(g_fmmu_m.fmmudocno) RETURNING g_sub_success
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
   
   LET g_fmmu_m.fmmumodid = g_user
   LET g_fmmu_m.fmmumoddt = cl_get_current()
   LET g_fmmu_m.fmmustus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fmmu_t 
      SET (fmmustus,fmmumodid,fmmumoddt) 
        = (g_fmmu_m.fmmustus,g_fmmu_m.fmmumodid,g_fmmu_m.fmmumoddt)     
    WHERE fmmuent = g_enterprise AND fmmudocno = g_fmmu_m.fmmudocno
 
    
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
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE afmt565_master_referesh USING g_fmmu_m.fmmudocno INTO g_fmmu_m.fmmusite,g_fmmu_m.fmmu001, 
          g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocdt,g_fmmu_m.fmmu002,g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus, 
          g_fmmu_m.fmmuownid,g_fmmu_m.fmmuowndp,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtdp,g_fmmu_m.fmmucrtdt, 
          g_fmmu_m.fmmumodid,g_fmmu_m.fmmumoddt,g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid, 
          g_fmmu_m.fmmupstdt,g_fmmu_m.fmmuownid_desc,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid_desc, 
          g_fmmu_m.fmmucrtdp_desc,g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmupstid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fmmu_m.fmmusite,g_fmmu_m.fmmusite_desc,g_fmmu_m.fmmu001,g_fmmu_m.fmmu001_desc, 
          g_fmmu_m.l_comp,g_fmmu_m.comp_desc,g_fmmu_m.fmmudocno,g_fmmu_m.fmmudocno_desc,g_fmmu_m.fmmudocdt, 
          g_fmmu_m.fmmu002,g_fmmu_m.fmmu003,g_fmmu_m.fmmu004,g_fmmu_m.fmmustus,g_fmmu_m.fmmuownid,g_fmmu_m.fmmuownid_desc, 
          g_fmmu_m.fmmuowndp,g_fmmu_m.fmmuowndp_desc,g_fmmu_m.fmmucrtid,g_fmmu_m.fmmucrtid_desc,g_fmmu_m.fmmucrtdp, 
          g_fmmu_m.fmmucrtdp_desc,g_fmmu_m.fmmucrtdt,g_fmmu_m.fmmumodid,g_fmmu_m.fmmumodid_desc,g_fmmu_m.fmmumoddt, 
          g_fmmu_m.fmmucnfid,g_fmmu_m.fmmucnfid_desc,g_fmmu_m.fmmucnfdt,g_fmmu_m.fmmupstid,g_fmmu_m.fmmupstid_desc, 
          g_fmmu_m.fmmupstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afmt565_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt565_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt565.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afmt565_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fmng_d.getLength() THEN
         LET g_detail_idx = g_fmng_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmng_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmng_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_fmng2_d.getLength() THEN
         LET g_detail_idx = g_fmng2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmng2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmng2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_fmng3_d.getLength() THEN
         LET g_detail_idx = g_fmng3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmng3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmng3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_fmng4_d.getLength() THEN
         LET g_detail_idx = g_fmng4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmng4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmng4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmt565_b_fill2(pi_idx)
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
   
   CALL afmt565_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afmt565_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   RETURN FALSE   #160129-00015#10  #用自己寫的b_fill段
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
 
{<section id="afmt565.status_show" >}
PRIVATE FUNCTION afmt565_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt565.mask_functions" >}
&include "erp/afm/afmt565_mask.4gl"
 
{</section>}
 
{<section id="afmt565.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afmt565_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL afmt565_show()
   CALL afmt565_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #151013-00016#11 151106 by sakura add(S)
   IF NOT s_afmt565_unconf_chk(g_fmmu_m.fmmudocno) THEN
      CLOSE afmt565_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #151013-00016#11 151106 by sakura add(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fmmu_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fmng_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_fmng2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_fmng3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_fmng4_d))
 
 
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
   #CALL afmt565_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afmt565_ui_headershow()
   CALL afmt565_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afmt565_draw_out()
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
   CALL afmt565_ui_headershow()  
   CALL afmt565_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afmt565.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt565_set_pk_array()
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
   LET g_pk_array[1].values = g_fmmu_m.fmmudocno
   LET g_pk_array[1].column = 'fmmudocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt565.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afmt565.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt565_msgcentre_notify(lc_state)
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
   CALL afmt565_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmmu_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt565.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmt565_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#13 2016/08/23 By 07900 --add -s-
   SELECT fmmustus INTO g_fmmu_m.fmmustus
     FROM fmmu_t
    WHERE fmmuent = g_enterprise
      AND fmmudocno = g_fmmu_m.fmmudocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_fmmu_m.fmmustus
       
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
        LET g_errparam.extend = g_fmmu_m.fmmudocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afmt565_set_act_visible()
        CALL afmt565_set_act_no_visible()
        CALL afmt565_show()
        RETURN FALSE
     END IF
   END IF
   
   #160818-00017#13 2016/08/23 By 07900 --add -e-
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt565.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得帳套後的預設資料
# Memo...........:
# Usage..........: CALL afmt565_set_ld_info(p_ld)
# Input parameter: p_ld        帳套
# Return code....: comp        法人
# Date & Author..: 2015/05/25 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt565_set_ld_info(p_ld)
DEFINE p_ld        LIKE apca_t.apcald

   CALL s_ld_sel_glaa(p_ld,'glaacomp|glaa001|glaa004|glaa015|glaa016|glaa019|glaa020|glaa024|glaa102|glaa121')
        RETURNING g_sub_success,g_glaa.*
   
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_fmmu_m.fmmusite,g_fmmu_m.fmmudocdt,'1')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_fmmusite
   CALL s_fin_get_wc_str(g_wc_fmmusite) RETURNING g_wc_fmmusite
   CALL s_fin_account_center_ld_str() RETURNING g_wc_fmmu001
   CALL s_fin_get_wc_str(g_wc_fmmu001) RETURNING g_wc_fmmu001
   
   
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
 
