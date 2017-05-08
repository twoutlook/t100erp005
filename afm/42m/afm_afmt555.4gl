#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt555.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2015-12-09 19:29:12), PR版次:0014(2017-01-20 05:46:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: afmt555
#+ Description: 期末公允價值調整帳務單
#+ Creator....: 05016(2015-05-06 15:18:33)
#+ Modifier...: 02159 -SD/PR- 08729
 
{</section>}
 
{<section id="afmt555.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150401-00001#13 2015/07/22 By RayHuang statechange段問題修正
#150916-00015#1  2015/12/07 By Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#151126-00013#6  2015/12/09 By sakura   加單頭傳票編號串查
#151130-00015#2  2015/12/22 BY Xiaozg   根据是否可以更改單據日期 設定開放單據日期修改
#160321-00016#27 2016/03/24 By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00025#49 2016/04/26 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息
#160620-00010#2  2016/06/21 By 01531    拋轉傳票時，傳票憑證日期應該預設單據的財務日期，而非系統日期
#160818-00017#13 2016/08/23 By 07900    删除修改未重新判断状态码
#160913-00017#2  2016/09/21 By 07900    AFM模组调整交易客商开窗
#161006-00005#34 2016/10/28 By 08732    組織類型與職能開窗調整
#160822-00012#4  2016/10/31 By 08732    新舊值調整
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
PRIVATE type type_g_fmmq_m        RECORD
       fmmqsite LIKE fmmq_t.fmmqsite, 
   fmmqsite_desc LIKE type_t.chr80, 
   fmmq001 LIKE fmmq_t.fmmq001, 
   fmmq001_desc LIKE type_t.chr80, 
   l_fmmqcomp LIKE type_t.chr500, 
   fmmqcomp_desc LIKE type_t.chr80, 
   fmmqdocno LIKE fmmq_t.fmmqdocno, 
   fmmqdocdt LIKE fmmq_t.fmmqdocdt, 
   fmmq002 LIKE fmmq_t.fmmq002, 
   fmmq003 LIKE fmmq_t.fmmq003, 
   fmmq004 LIKE fmmq_t.fmmq004, 
   l_curr LIKE type_t.chr500, 
   fmmqstus LIKE fmmq_t.fmmqstus, 
   fmmqownid LIKE fmmq_t.fmmqownid, 
   fmmqownid_desc LIKE type_t.chr80, 
   fmmqowndp LIKE fmmq_t.fmmqowndp, 
   fmmqowndp_desc LIKE type_t.chr80, 
   fmmqcrtid LIKE fmmq_t.fmmqcrtid, 
   fmmqcrtid_desc LIKE type_t.chr80, 
   fmmqcrtdp LIKE fmmq_t.fmmqcrtdp, 
   fmmqcrtdp_desc LIKE type_t.chr80, 
   fmmqcrtdt LIKE fmmq_t.fmmqcrtdt, 
   fmmqmodid LIKE fmmq_t.fmmqmodid, 
   fmmqmodid_desc LIKE type_t.chr80, 
   fmmqmoddt LIKE fmmq_t.fmmqmoddt, 
   fmmqcnfid LIKE fmmq_t.fmmqcnfid, 
   fmmqcnfid_desc LIKE type_t.chr80, 
   fmmqcnfdt LIKE fmmq_t.fmmqcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fmmr_d        RECORD
       fmmrseq LIKE fmmr_t.fmmrseq, 
   fmmr001 LIKE fmmr_t.fmmr001, 
   fmmr001_desc LIKE type_t.chr500, 
   fmmr002 LIKE fmmr_t.fmmr002, 
   l_fmmj004 LIKE type_t.chr500, 
   l_fmmj003 LIKE type_t.chr500, 
   fmmr003 LIKE fmmr_t.fmmr003, 
   l_fmmp006 LIKE type_t.num20_6, 
   l_fmmp007 LIKE type_t.num20_6, 
   fmmr037 LIKE fmmr_t.fmmr037, 
   fmmr004 LIKE fmmr_t.fmmr004, 
   fmmr005 LIKE fmmr_t.fmmr005, 
   fmmr006 LIKE fmmr_t.fmmr006, 
   fmmr007 LIKE fmmr_t.fmmr007, 
   fmmr008 LIKE fmmr_t.fmmr008, 
   fmmr009 LIKE fmmr_t.fmmr009, 
   fmmr010 LIKE fmmr_t.fmmr010
       END RECORD
PRIVATE TYPE type_g_fmmr2_d RECORD
       fmmrseq LIKE fmmr_t.fmmrseq, 
   fmmr011 LIKE fmmr_t.fmmr011, 
   fmmr011_desc LIKE type_t.chr500, 
   fmmr012 LIKE fmmr_t.fmmr012, 
   fmmr012_desc LIKE type_t.chr500, 
   fmmr036 LIKE fmmr_t.fmmr036, 
   fmmr013 LIKE fmmr_t.fmmr013, 
   fmmr013_desc LIKE type_t.chr500, 
   fmmr014 LIKE fmmr_t.fmmr014, 
   fmmr014_desc LIKE type_t.chr500, 
   fmmr015 LIKE fmmr_t.fmmr015, 
   fmmr015_desc LIKE type_t.chr500, 
   fmmr016 LIKE fmmr_t.fmmr016, 
   fmmr016_desc LIKE type_t.chr500, 
   fmmr017 LIKE fmmr_t.fmmr017, 
   fmmr017_desc LIKE type_t.chr500, 
   fmmr018 LIKE fmmr_t.fmmr018, 
   fmmr018_desc LIKE type_t.chr500, 
   fmmr019 LIKE fmmr_t.fmmr019, 
   fmmr019_desc LIKE type_t.chr500, 
   fmmr020 LIKE fmmr_t.fmmr020, 
   fmmr020_desc LIKE type_t.chr500, 
   fmmr021 LIKE fmmr_t.fmmr021, 
   fmmr021_desc LIKE type_t.chr500, 
   fmmr022 LIKE fmmr_t.fmmr022, 
   fmmr022_desc LIKE type_t.chr500, 
   fmmr023 LIKE fmmr_t.fmmr023, 
   fmmr023_desc LIKE type_t.chr500, 
   fmmr024 LIKE fmmr_t.fmmr024, 
   fmmr024_desc LIKE type_t.chr500, 
   fmmr025 LIKE fmmr_t.fmmr025, 
   fmmr025_desc LIKE type_t.chr500, 
   fmmr026 LIKE fmmr_t.fmmr026, 
   fmmr026_desc LIKE type_t.chr500, 
   fmmr027 LIKE fmmr_t.fmmr027, 
   fmmr027_desc LIKE type_t.chr500, 
   fmmr028 LIKE fmmr_t.fmmr028, 
   fmmr028_desc LIKE type_t.chr50, 
   fmmr029 LIKE fmmr_t.fmmr029, 
   fmmr029_desc LIKE type_t.chr500, 
   fmmr030 LIKE fmmr_t.fmmr030, 
   fmmr030_desc LIKE type_t.chr500, 
   fmmr031 LIKE fmmr_t.fmmr031, 
   fmmr031_desc LIKE type_t.chr500, 
   fmmr032 LIKE fmmr_t.fmmr032, 
   fmmr032_desc LIKE type_t.chr500, 
   fmmr033 LIKE fmmr_t.fmmr033, 
   fmmr033_desc LIKE type_t.chr500, 
   fmmr034 LIKE fmmr_t.fmmr034, 
   fmmr034_desc LIKE type_t.chr500, 
   fmmr035 LIKE fmmr_t.fmmr035, 
   fmmr035_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fmmqdocno LIKE fmmq_t.fmmqdocno,
      b_fmmq002 LIKE fmmq_t.fmmq002,
      b_fmmq003 LIKE fmmq_t.fmmq003
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa                RECORD
                             glaacomp  LIKE glaa_t.glaacomp,
                             glaa004   LIKE glaa_t.glaa004,
                             glaa015   LIKE glaa_t.glaa015,
                             glaa019   LIKE glaa_t.glaa019,
                             glaa024   LIKE glaa_t.glaa024,
                             glaa102   LIKE glaa_t.glaa102,
                             glaa121   LIKE glaa_t.glaa121,
                             glaa001   LIKE glaa_t.glaa001,
                             glaa016   LIKE glaa_t.glaa016,
                             glaa020   LIKE glaa_t.glaa020
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
                         
                           
DEFINE g_wc_fmmqsite       STRING
DEFINE g_wc_fmmq001        STRING   #帳套範圍
DEFINE g_wc_cs_comp        STRING   #161006-00005#34   add   #azzi800法人權限
#161104-00046#21 --s add
DEFINE g_user_dept_wc        STRING     
DEFINE g_user_dept_wc_q      STRING    
#161104-00046#21 --e add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_fmmq_m          type_g_fmmq_m
DEFINE g_fmmq_m_t        type_g_fmmq_m
DEFINE g_fmmq_m_o        type_g_fmmq_m
DEFINE g_fmmq_m_mask_o   type_g_fmmq_m #轉換遮罩前資料
DEFINE g_fmmq_m_mask_n   type_g_fmmq_m #轉換遮罩後資料
 
   DEFINE g_fmmqdocno_t LIKE fmmq_t.fmmqdocno
 
 
DEFINE g_fmmr_d          DYNAMIC ARRAY OF type_g_fmmr_d
DEFINE g_fmmr_d_t        type_g_fmmr_d
DEFINE g_fmmr_d_o        type_g_fmmr_d
DEFINE g_fmmr_d_mask_o   DYNAMIC ARRAY OF type_g_fmmr_d #轉換遮罩前資料
DEFINE g_fmmr_d_mask_n   DYNAMIC ARRAY OF type_g_fmmr_d #轉換遮罩後資料
DEFINE g_fmmr2_d          DYNAMIC ARRAY OF type_g_fmmr2_d
DEFINE g_fmmr2_d_t        type_g_fmmr2_d
DEFINE g_fmmr2_d_o        type_g_fmmr2_d
DEFINE g_fmmr2_d_mask_o   DYNAMIC ARRAY OF type_g_fmmr2_d #轉換遮罩前資料
DEFINE g_fmmr2_d_mask_n   DYNAMIC ARRAY OF type_g_fmmr2_d #轉換遮罩後資料
 
 
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
 
{<section id="afmt555.main" >}
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
   CALL s_fin_get_user_dept_control('','fmmq001','fmmqent','fmmqdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   #161104-00046#21 --e add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmmqsite,'',fmmq001,'','','',fmmqdocno,fmmqdocdt,fmmq002,fmmq003,fmmq004, 
       '',fmmqstus,fmmqownid,'',fmmqowndp,'',fmmqcrtid,'',fmmqcrtdp,'',fmmqcrtdt,fmmqmodid,'',fmmqmoddt, 
       fmmqcnfid,'',fmmqcnfdt", 
                      " FROM fmmq_t",
                      " WHERE fmmqent= ? AND fmmqdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt555_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmmqsite,t0.fmmq001,t0.fmmqdocno,t0.fmmqdocdt,t0.fmmq002,t0.fmmq003, 
       t0.fmmq004,t0.fmmqstus,t0.fmmqownid,t0.fmmqowndp,t0.fmmqcrtid,t0.fmmqcrtdp,t0.fmmqcrtdt,t0.fmmqmodid, 
       t0.fmmqmoddt,t0.fmmqcnfid,t0.fmmqcnfdt,t1.ooefl003 ,t2.glaal002 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 , 
       t6.ooefl003 ,t7.ooag011 ,t8.ooag011",
               " FROM fmmq_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fmmqsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.fmmq001 AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.fmmqownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.fmmqowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.fmmqcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.fmmqcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.fmmqmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.fmmqcnfid  ",
 
               " WHERE t0.fmmqent = " ||g_enterprise|| " AND t0.fmmqdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmt555_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmt555 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmt555_init()   
 
      #進入選單 Menu (="N")
      CALL afmt555_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmt555
      
   END IF 
   
   CLOSE afmt555_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmt555.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt555_init()
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
      CALL cl_set_combo_scc_part('fmmqstus','13','Y,N,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #啟用分錄底稿用
   CALL s_fin_continue_no_tmp()
   #經營方式
   CALL cl_set_combo_scc('fmmr023_desc','6013')
   
   #161006-00005#34   add---s
   CALL s_fin_azzi800_sons_query(g_today) 
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   #161006-00005#34   add---e
   #end add-point
   
   #初始化搜尋條件
   CALL afmt555_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afmt555.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afmt555_ui_dialog()
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
   DEFINE l_glap001   LIKE glap_t.glap001    #傳票性質
   DEFINE l_glca002   LIKE glca_t.glca002
   DEFINE l_stus      LIKE glap_t.glapstus
   DEFINE r_docno     LIKE fmmq_t.fmmqdocno
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
         INITIALIZE g_fmmq_m.* TO NULL
         CALL g_fmmr_d.clear()
         CALL g_fmmr2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmt555_init()
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
               
               CALL afmt555_fetch('') # reload data
               LET l_ac = 1
               CALL afmt555_ui_detailshow() #Setting the current row 
         
               CALL afmt555_idx_chk()
               #NEXT FIELD fmmrseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_fmmr_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt555_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL afmt555_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_fmmr2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt555_idx_chk()
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
               CALL afmt555_idx_chk()
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
            CALL afmt555_browser_fill("")
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
               CALL afmt555_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afmt555_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afmt555_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL afmt555_set_act_visible()
            CALL afmt555_set_act_no_visible()
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afmt555_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afmt555_set_act_visible()   
            CALL afmt555_set_act_no_visible()
            IF NOT (g_fmmq_m.fmmqdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fmmqent = " ||g_enterprise|| " AND",
                                  " fmmqdocno = '", g_fmmq_m.fmmqdocno, "' "
 
               #填到對應位置
               CALL afmt555_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "fmmq_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmmr_t" 
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
               CALL afmt555_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "fmmq_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmmr_t" 
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
                  CALL afmt555_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt555_fetch("F")
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
               CALL afmt555_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afmt555_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt555_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afmt555_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt555_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afmt555_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt555_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afmt555_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt555_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afmt555_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt555_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_fmmr_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fmmr2_d)
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
               NEXT FIELD fmmrseq
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
               CALL afmt555_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afmt555_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapp330
            LET g_action_choice="open_aapp330"
            IF cl_auth_chk_act("open_aapp330") THEN
               
               #add-point:ON ACTION open_aapp330 name="menu.open_aapp330"
               IF g_fmmq_m.fmmqdocno IS NULL THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = "" 
                 LET g_errparam.code   = "std-00003" 
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 CONTINUE DIALOG
               END IF
               
               #未確認單據不可拋轉
               IF g_fmmq_m.fmmqstus = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00185'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               #無傳票號碼才可拋轉
               IF cl_null(g_fmmq_m.fmmq004) THEN                                   
                  #產生單別/日期
                  #CALL axrp330_01(g_fmmq_m.fmmq001) RETURNING l_slip,l_date                    #160620-00010#2 mark
                  CALL axrp330_01(g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmqdocno) RETURNING l_slip,l_date  #160620-00010#2 add    #161213-00023#4 add  g_fmmq_m.fmmqdocno
                  #若取消產生時，就不往下走拋轉了
                  IF cl_null(l_slip) THEN
                     CONTINUE DIALOG
                  END IF                  
                  
                  CALL s_transaction_begin()

                  CALL cl_err_collect_init()
                  IF g_glaa.glaa121 = 'Y' THEN 
                     LET l_wc =" glgbdocno = '",g_fmmq_m.fmmqdocno,"' "
                     CALL s_pre_voucher_ins_glap('FM','M30',g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocdt,l_slip,'1',l_wc) 
                          RETURNING g_sub_success,g_fmmq_m.fmmq004,g_fmmq_m.fmmq004
                  ELSE
                     LET l_wc =" fmmqdocno = '",g_fmmq_m.fmmqdocno,"' "
                     CALL s_voucher_gen_fm('4',g_fmmq_m.fmmq001,l_date,l_slip,'0',l_wc,'N','afmt555')
                          RETURNING g_sub_success,g_fmmq_m.fmmq004,g_fmmq_m.fmmq004
                  END IF
                  CALL cl_err_collect_show()

                  IF g_sub_success THEN
                     UPDATE glga_t SET glga007 = g_fmmq_m.fmmq004
                      WHERE glgaent = g_enterprise AND glgald = g_fmmq_m.fmmq001
                        AND glgadocno=g_fmmq_m.fmmqdocno AND glga100 = 'FM' AND glga101 = 'M10'
                     CALL s_transaction_end('Y','0')
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'adz-00217'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  ELSE
                     IF cl_null(g_fmmq_m.fmmq004) THEN 
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
                  SELECT fmmq004 INTO g_fmmq_m.fmmq004
                    FROM fmmq_t
                   WHERE fmmqent = g_enterprise
                     AND fmmqdocno = g_fmmq_m.fmmqdocno
                  DISPLAY BY NAME g_fmmq_m.fmmq004
               ELSE
                  LET l_glap001 = ''
                  SELECT glap001 INTO l_glap001
                    FROM glap_t
                   WHERE glapent = g_enterprise AND glapld = g_fmmq_m.fmmq001
                     AND glapdocno = g_fmmq_m.fmmq004
                  IF NOT l_glap001 MATCHES '[1235]' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00029'
                     LET g_errparam.extend = g_fmmq_m.fmmqdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  ELSE
                     LET la_param.prog = 'aglt310'
                     LET la_param.param[1] = g_fmmq_m.fmmq001
                     LET la_param.param[2] = g_fmmq_m.fmmq004
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun(ls_js)
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt555_02
            LET g_action_choice="open_afmt555_02"
            IF cl_auth_chk_act("open_afmt555_02") THEN
               
               #add-point:ON ACTION open_afmt555_02 name="menu.open_afmt555_02"
               IF NOT cl_null(g_fmmq_m.fmmqdocno) THEN                
                  CALL s_transaction_begin()
                  CALL afmt555_01(g_fmmq_m.fmmqdocno,'2')RETURNING g_sub_success,r_docno
                  IF g_sub_success THEN
                     CALL s_transaction_end('Y',0)
                     LET g_fmmq_m.fmmqdocno = r_docno
                     CALL afmt555_b_fill()
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'axm-00088'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()         
                     IF g_glaa.glaa121 = 'Y' THEN
                        CALL s_transaction_begin()
                        CALL s_pre_voucher_ins('FM','M30',g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,'4')
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
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               #產生分錄底稿
               IF NOT cl_null(g_fmmq_m.fmmqdocno) AND g_fmmq_m.fmmqstus = 'N' THEN
                  CALL s_transaction_begin()
                  CALL s_pre_voucher_ins('FM','M30',g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,'4')
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
                  CALL s_pre_voucher('FM','M30',g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt)
               ELSE
                  CALL axrt300_13('FM',g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocno,'afmt555')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt555_01
            LET g_action_choice="open_afmt555_01"
            IF cl_auth_chk_act("open_afmt555_01") THEN
               
               #add-point:ON ACTION open_afmt555_01 name="menu.open_afmt555_01"
               CALL s_transaction_begin()             
               CALL afmt555_01('','1')RETURNING g_sub_success,r_docno
               IF g_sub_success THEN
                  CALL s_transaction_end('Y',0)
                  IF NOT cl_null(r_docno) THEN
                     LET g_fmmq_m.fmmqdocno = r_docno                  
                     #把產生的那張顯示出來                  
#                     EXECUTE afmt555_master_referesh USING g_fmmq_m.fmmqdocno INTO g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001, 
#                                                                 g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003,g_fmmq_m.fmmq004,g_fmmq_m.fmmqstus, 
#                                                                 g_fmmq_m.fmmqownid,g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtdp,g_fmmq_m.fmmqcrtdt, 
#                                                                 g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmoddt,g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfdt,g_fmmq_m.fmmqsite_desc, 
#                                                                 g_fmmq_m.fmmq001_desc,g_fmmq_m.fmmqownid_desc,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid_desc, 
#                                                                 g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqcnfid_desc
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.extend = "g_fmmq_t"
#                        LET g_errparam.code   = SQLCA.sqlcode
#                        LET g_errparam.popup  = TRUE
#                        CALL cl_err()
#                        INITIALIZE g_fmmq_m.* TO NULL
#                     END IF
#                     #根據資料狀態切換action狀態
#                     CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
#                     CALL afmt555_set_act_visible()
#                     CALL afmt555_set_act_no_visible()
#                     CALL afmt555_show()
#                     CALL afmt555_b_fill()  
                     LET g_wc = " fmmqent = ",g_enterprise," AND fmmqdocno = '",g_fmmq_m.fmmqdocno,"' "
                     CALL afmt555_browser_fill('')
                     LET g_no_ask = TRUE
                     LET g_jump = 1
                     CALL afmt555_fetch('/')




                     #顯示成功訊息
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'axm-00088'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()               
                     IF g_glaa.glaa121 = 'Y' THEN
                        CALL s_transaction_begin()
                        CALL s_pre_voucher_ins('FM','M30',g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,'4')
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
               CALL afmt555_delete()
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
               IF g_fmmq_m.fmmqdocno IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "std-00003"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #無傳票 不可還原
               IF g_fmmq_m.fmmq004 IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "anm-00186"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
              #傳票還原單據日期不可小於等於過帳日期             
               CALL s_afm_close_day_chk(g_fmmq_m.fmmq001,g_fmmq_m.fmmq004) RETURNING g_sub_success,g_errno
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
                     AND glapdocno = g_fmmq_m.fmmq004
                  
                  #IF l_stus = 'Y' THEN
                  IF l_stus NOT MATCHES '[N]' THEN    #05016 modify 未確認才能還原
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
                     CALL s_pre_voucher_delete_glax(g_fmmq_m.fmmq001,g_fmmq_m.fmmq004,'',l_scom0002) RETURNING l_success
                     IF l_success = FALSE THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                     
                     IF l_scom0002 = 'Y' THEN
                        #凭证作废处理
                        UPDATE glap_t SET glapstus = 'X'
                         WHERE glapent = g_enterprise
                           AND glapld = g_fmmq_m.fmmq001
                           AND glapdocno = g_fmmq_m.fmmq004
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
                          AND glapld = g_fmmq_m.fmmq001
                          AND glapdocno = g_fmmq_m.fmmq004
                        #刪除單頭
                        DELETE FROM glap_t
                         WHERE glapent   = g_enterprise
                           AND glapld = g_fmmq_m.fmmq001
                           AND glapdocno = g_fmmq_m.fmmq004
                        #刪除單身
                        DELETE FROM glaq_t
                         WHERE glaqent = g_enterprise
                           AND glaqld = g_fmmq_m.fmmq001
                           AND glaqdocno = g_fmmq_m.fmmq004
                        #170103-00019#22 mark ------
                        ##更新月結這邊的傳票號碼要給空
                        #UPDATE fmmq_t SET fmmq004 = ''
                        # WHERE fmmqent = g_enterprise
                        #   AND fmmqdocno = g_fmmq_m.fmmqdocno
                        #170103-00019#22 mark end---
                        #更新最大號
                        SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_glca002
                          FROM glca_t
                         WHERE glcaent = g_enterprise
                           AND glcald  = g_fmmq_m.fmmq001 AND glca001 = 'FM'
                        IF l_glca002 = 'Y' THEN
                           LET g_prog = 'aglt350'
                        ELSE
                           LET g_prog = 'aglt310'
                        END IF
                        IF NOT s_aooi200_fin_del_docno(g_fmmq_m.fmmq001,g_fmmq_m.fmmq004,l_glapdocdt) THEN
                           CALL s_transaction_end('N','0')
                           CONTINUE DIALOG
                        END IF
                        LET g_prog = 'afmt555'
                        #170103-00019#22 mark ------
                        #LET g_fmmq_m.fmmq004 = ''
                        #DISPLAY BY NAME g_fmmq_m.fmmq004
                        #170103-00019#22 mark end---
                        #分錄底稿
                        UPDATE glga_t SET glga007 = ''
                         WHERE glgaent = g_enterprise AND glgald = g_fmmq_m.fmmq001
                           AND glgadocno=g_fmmq_m.fmmqdocno AND glga100 = 'FM' AND glga101 = 'M30'
                        
                     #170103-00019#22 add ------  
                     END IF
                     #更新月結這邊的傳票號碼要給空
                     UPDATE fmmq_t SET fmmq004 = ''
                      WHERE fmmqent = g_enterprise
                        AND fmmqdocno = g_fmmq_m.fmmqdocno
                     LET g_fmmq_m.fmmq004 = ''
                     DISPLAY BY NAME g_fmmq_m.fmmq004
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
               CALL afmt555_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fmmq004
            LET g_action_choice="prog_fmmq004"
            IF cl_auth_chk_act("prog_fmmq004") THEN
               
               #add-point:ON ACTION prog_fmmq004 name="menu.prog_fmmq004"
               #151126-00013#6(S)
               INITIALIZE la_param.* TO NULL
               IF NOT cl_null(g_fmmq_m.fmmq004) THEN
                  LET l_glap001 = ''
                  SELECT glap001 INTO l_glap001 
                    FROM glap_t 
                   WHERE glapent = g_enterprise
                     AND glapdocno = g_fmmq_m.fmmq004  
                     AND glapld = g_fmmq_m.fmmq001               
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
                  LET la_param.param[1] = g_fmmq_m.fmmq001
                  LET la_param.param[2] = g_fmmq_m.fmmq004
                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #151126-00013#6(E)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt555_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt555_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt555_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmmq_m.fmmqdocdt)
 
 
 
         
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
 
{<section id="afmt555.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afmt555_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT fmmqdocno ",
                      " FROM fmmq_t ",
                      " ",
                      " LEFT JOIN fmmr_t ON fmmrent = fmmqent AND fmmqdocno = fmmrdocno ", "  ",
                      #add-point:browser_fill段sql(fmmr_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE fmmqent = " ||g_enterprise|| " AND fmmrent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fmmq_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fmmqdocno ",
                      " FROM fmmq_t ", 
                      "  ",
                      "  ",
                      " WHERE fmmqent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fmmq_t")
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
      INITIALIZE g_fmmq_m.* TO NULL
      CALL g_fmmr_d.clear()        
      CALL g_fmmr2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fmmqdocno,t0.fmmq002,t0.fmmq003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmmqstus,t0.fmmqdocno,t0.fmmq002,t0.fmmq003 ",
                  " FROM fmmq_t t0",
                  "  ",
                  "  LEFT JOIN fmmr_t ON fmmrent = fmmqent AND fmmqdocno = fmmrdocno ", "  ", 
                  #add-point:browser_fill段sql(fmmr_t1) name="browser_fill.join.fmmr_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.fmmqent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("fmmq_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmmqstus,t0.fmmqdocno,t0.fmmq002,t0.fmmq003 ",
                  " FROM fmmq_t t0",
                  "  ",
                  
                  " WHERE t0.fmmqent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("fmmq_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY fmmqdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmmq_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmmqdocno,g_browser[g_cnt].b_fmmq002, 
          g_browser[g_cnt].b_fmmq003
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
         CALL afmt555_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_fmmqdocno) THEN
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
 
{<section id="afmt555.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afmt555_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fmmq_m.fmmqdocno = g_browser[g_current_idx].b_fmmqdocno   
 
   EXECUTE afmt555_master_referesh USING g_fmmq_m.fmmqdocno INTO g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001, 
       g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003,g_fmmq_m.fmmq004,g_fmmq_m.fmmqstus, 
       g_fmmq_m.fmmqownid,g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtdp,g_fmmq_m.fmmqcrtdt, 
       g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmoddt,g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfdt,g_fmmq_m.fmmqsite_desc, 
       g_fmmq_m.fmmq001_desc,g_fmmq_m.fmmqownid_desc,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid_desc, 
       g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqcnfid_desc
   
   CALL afmt555_fmmq_t_mask()
   CALL afmt555_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afmt555.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afmt555_ui_detailshow()
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
 
{<section id="afmt555.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt555_ui_browser_refresh()
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
      IF g_browser[l_i].b_fmmqdocno = g_fmmq_m.fmmqdocno 
 
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
 
{<section id="afmt555.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt555_construct()
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
   INITIALIZE g_fmmq_m.* TO NULL
   CALL g_fmmr_d.clear()        
   CALL g_fmmr2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON fmmqsite,fmmq001,l_fmmqcomp,fmmqdocno,fmmqdocdt,fmmq002,fmmq003,fmmq004, 
          l_curr,fmmqstus,fmmqownid,fmmqowndp,fmmqcrtid,fmmqcrtdp,fmmqcrtdt,fmmqmodid,fmmqmoddt,fmmqcnfid, 
          fmmqcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmmqcrtdt>>----
         AFTER FIELD fmmqcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmmqmoddt>>----
         AFTER FIELD fmmqmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmmqcnfdt>>----
         AFTER FIELD fmmqcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmmqpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqsite
            #add-point:BEFORE FIELD fmmqsite name="construct.b.fmmqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqsite
            
            #add-point:AFTER FIELD fmmqsite name="construct.a.fmmqsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmqsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqsite
            #add-point:ON ACTION controlp INFIELD fmmqsite name="construct.c.fmmqsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef204 = 'Y' "   #161006-00005#34   mark 
            #CALL q_ooef001()                           #161006-00005#34   mark      
            CALL q_ooef001_46()                         #161006-00005#34   add 
            DISPLAY g_qryparam.return1 TO fmmqsite
            NEXT FIELD fmmqsite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmq001
            #add-point:BEFORE FIELD fmmq001 name="construct.b.fmmq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmq001
            
            #add-point:AFTER FIELD fmmq001 name="construct.a.fmmq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmq001
            #add-point:ON ACTION controlp INFIELD fmmq001 name="construct.c.fmmq001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO fmmq001
            NEXT FIELD fmmq001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmqcomp
            #add-point:BEFORE FIELD l_fmmqcomp name="construct.b.l_fmmqcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmqcomp
            
            #add-point:AFTER FIELD l_fmmqcomp name="construct.a.l_fmmqcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_fmmqcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmqcomp
            #add-point:ON ACTION controlp INFIELD l_fmmqcomp name="construct.c.l_fmmqcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' ",
                                   " AND ooef001 IN ",g_wc_cs_comp   #161006-00005#34   add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO l_fmmqcomp
            NEXT FIELD l_fmmqcomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqdocno
            #add-point:BEFORE FIELD fmmqdocno name="construct.b.fmmqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqdocno
            
            #add-point:AFTER FIELD fmmqdocno name="construct.a.fmmqdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmqdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqdocno
            #add-point:ON ACTION controlp INFIELD fmmqdocno name="construct.c.fmmqdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161104-00046#21 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_user_dept_wc_q 
            END IF
            #161104-00046#21 --e add 
            CALL q_fmmqdocno()
            DISPLAY g_qryparam.return1 TO fmmqdocno
     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqdocdt
            #add-point:BEFORE FIELD fmmqdocdt name="construct.b.fmmqdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqdocdt
            
            #add-point:AFTER FIELD fmmqdocdt name="construct.a.fmmqdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmqdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqdocdt
            #add-point:ON ACTION controlp INFIELD fmmqdocdt name="construct.c.fmmqdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmq002
            #add-point:BEFORE FIELD fmmq002 name="construct.b.fmmq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmq002
            
            #add-point:AFTER FIELD fmmq002 name="construct.a.fmmq002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmq002
            #add-point:ON ACTION controlp INFIELD fmmq002 name="construct.c.fmmq002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmq003
            #add-point:BEFORE FIELD fmmq003 name="construct.b.fmmq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmq003
            
            #add-point:AFTER FIELD fmmq003 name="construct.a.fmmq003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmq003
            #add-point:ON ACTION controlp INFIELD fmmq003 name="construct.c.fmmq003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmq004
            #add-point:BEFORE FIELD fmmq004 name="construct.b.fmmq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmq004
            
            #add-point:AFTER FIELD fmmq004 name="construct.a.fmmq004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmq004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmq004
            #add-point:ON ACTION controlp INFIELD fmmq004 name="construct.c.fmmq004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " fmmq004 IS NOT NULL "
            CALL q_fmmq004()
            DISPLAY g_qryparam.return1 TO fmmq004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_curr
            #add-point:BEFORE FIELD l_curr name="construct.b.l_curr"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_curr
            
            #add-point:AFTER FIELD l_curr name="construct.a.l_curr"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_curr
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_curr
            #add-point:ON ACTION controlp INFIELD l_curr name="construct.c.l_curr"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqstus
            #add-point:BEFORE FIELD fmmqstus name="construct.b.fmmqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqstus
            
            #add-point:AFTER FIELD fmmqstus name="construct.a.fmmqstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqstus
            #add-point:ON ACTION controlp INFIELD fmmqstus name="construct.c.fmmqstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmqownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqownid
            #add-point:ON ACTION controlp INFIELD fmmqownid name="construct.c.fmmqownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE           
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmqownid  #顯示到畫面上
            NEXT FIELD fmmqownid                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqownid
            #add-point:BEFORE FIELD fmmqownid name="construct.b.fmmqownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqownid
            
            #add-point:AFTER FIELD fmmqownid name="construct.a.fmmqownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmqowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqowndp
            #add-point:ON ACTION controlp INFIELD fmmqowndp name="construct.c.fmmqowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmqowndp  #顯示到畫面上
            NEXT FIELD fmmqowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqowndp
            #add-point:BEFORE FIELD fmmqowndp name="construct.b.fmmqowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqowndp
            
            #add-point:AFTER FIELD fmmqowndp name="construct.a.fmmqowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmqcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqcrtid
            #add-point:ON ACTION controlp INFIELD fmmqcrtid name="construct.c.fmmqcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmqcrtid  #顯示到畫面上
            NEXT FIELD fmmqcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqcrtid
            #add-point:BEFORE FIELD fmmqcrtid name="construct.b.fmmqcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqcrtid
            
            #add-point:AFTER FIELD fmmqcrtid name="construct.a.fmmqcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmqcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqcrtdp
            #add-point:ON ACTION controlp INFIELD fmmqcrtdp name="construct.c.fmmqcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmqcrtdp  #顯示到畫面上
            NEXT FIELD fmmqcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqcrtdp
            #add-point:BEFORE FIELD fmmqcrtdp name="construct.b.fmmqcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqcrtdp
            
            #add-point:AFTER FIELD fmmqcrtdp name="construct.a.fmmqcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqcrtdt
            #add-point:BEFORE FIELD fmmqcrtdt name="construct.b.fmmqcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmqmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqmodid
            #add-point:ON ACTION controlp INFIELD fmmqmodid name="construct.c.fmmqmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmqmodid  #顯示到畫面上
            NEXT FIELD fmmqmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqmodid
            #add-point:BEFORE FIELD fmmqmodid name="construct.b.fmmqmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqmodid
            
            #add-point:AFTER FIELD fmmqmodid name="construct.a.fmmqmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqmoddt
            #add-point:BEFORE FIELD fmmqmoddt name="construct.b.fmmqmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmqcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqcnfid
            #add-point:ON ACTION controlp INFIELD fmmqcnfid name="construct.c.fmmqcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmqcnfid  #顯示到畫面上
            NEXT FIELD fmmqcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqcnfid
            #add-point:BEFORE FIELD fmmqcnfid name="construct.b.fmmqcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqcnfid
            
            #add-point:AFTER FIELD fmmqcnfid name="construct.a.fmmqcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqcnfdt
            #add-point:BEFORE FIELD fmmqcnfdt name="construct.b.fmmqcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON fmmrseq,fmmr001,fmmr002,l_fmmj004,l_fmmj003,fmmr003,l_fmmp006,l_fmmp007, 
          fmmr037,fmmr004,fmmr005,fmmr006,fmmr007,fmmr008,fmmr009,fmmr010,fmmr011,fmmr011_desc,fmmr012, 
          fmmr012_desc,fmmr036,fmmr013,fmmr013_desc,fmmr014,fmmr014_desc,fmmr015,fmmr015_desc,fmmr016, 
          fmmr016_desc,fmmr017,fmmr017_desc,fmmr018,fmmr018_desc,fmmr019,fmmr019_desc,fmmr020,fmmr020_desc, 
          fmmr021,fmmr021_desc,fmmr022,fmmr022_desc,fmmr023,fmmr023_desc,fmmr024,fmmr024_desc,fmmr025, 
          fmmr025_desc
           FROM s_detail1[1].fmmrseq,s_detail1[1].fmmr001,s_detail1[1].fmmr002,s_detail1[1].l_fmmj004, 
               s_detail1[1].l_fmmj003,s_detail1[1].fmmr003,s_detail1[1].l_fmmp006,s_detail1[1].l_fmmp007, 
               s_detail1[1].fmmr037,s_detail1[1].fmmr004,s_detail1[1].fmmr005,s_detail1[1].fmmr006,s_detail1[1].fmmr007, 
               s_detail1[1].fmmr008,s_detail1[1].fmmr009,s_detail1[1].fmmr010,s_detail2[1].fmmr011,s_detail2[1].fmmr011_desc, 
               s_detail2[1].fmmr012,s_detail2[1].fmmr012_desc,s_detail2[1].fmmr036,s_detail2[1].fmmr013, 
               s_detail2[1].fmmr013_desc,s_detail2[1].fmmr014,s_detail2[1].fmmr014_desc,s_detail2[1].fmmr015, 
               s_detail2[1].fmmr015_desc,s_detail2[1].fmmr016,s_detail2[1].fmmr016_desc,s_detail2[1].fmmr017, 
               s_detail2[1].fmmr017_desc,s_detail2[1].fmmr018,s_detail2[1].fmmr018_desc,s_detail2[1].fmmr019, 
               s_detail2[1].fmmr019_desc,s_detail2[1].fmmr020,s_detail2[1].fmmr020_desc,s_detail2[1].fmmr021, 
               s_detail2[1].fmmr021_desc,s_detail2[1].fmmr022,s_detail2[1].fmmr022_desc,s_detail2[1].fmmr023, 
               s_detail2[1].fmmr023_desc,s_detail2[1].fmmr024,s_detail2[1].fmmr024_desc,s_detail2[1].fmmr025, 
               s_detail2[1].fmmr025_desc
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmrseq
            #add-point:BEFORE FIELD fmmrseq name="construct.b.page1.fmmrseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmrseq
            
            #add-point:AFTER FIELD fmmrseq name="construct.a.page1.fmmrseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmrseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmrseq
            #add-point:ON ACTION controlp INFIELD fmmrseq name="construct.c.page1.fmmrseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr001
            #add-point:BEFORE FIELD fmmr001 name="construct.b.page1.fmmr001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr001
            
            #add-point:AFTER FIELD fmmr001 name="construct.a.page1.fmmr001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmr001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr001
            #add-point:ON ACTION controlp INFIELD fmmr001 name="construct.c.page1.fmmr001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = "ooef206='Y'"   #161006-00005#34   mark    
            #CALL q_ooef001()                       #161006-00005#34   mark
            CALL q_ooef001_33()                     #161006-00005#34   add     #呼叫開窗 
            DISPLAY g_qryparam.return1 TO fmmr001
            NEXT FIELD fmmr001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr002
            #add-point:BEFORE FIELD fmmr002 name="construct.b.page1.fmmr002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr002
            
            #add-point:AFTER FIELD fmmr002 name="construct.a.page1.fmmr002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmr002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr002
            #add-point:ON ACTION controlp INFIELD fmmr002 name="construct.c.page1.fmmr002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmmp004()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmr002
            NEXT FIELD fmmr002                         #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmj004
            #add-point:BEFORE FIELD l_fmmj004 name="construct.b.page1.l_fmmj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmj004
            
            #add-point:AFTER FIELD l_fmmj004 name="construct.a.page1.l_fmmj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fmmj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmj004
            #add-point:ON ACTION controlp INFIELD l_fmmj004 name="construct.c.page1.l_fmmj004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmj003
            #add-point:BEFORE FIELD l_fmmj003 name="construct.b.page1.l_fmmj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmj003
            
            #add-point:AFTER FIELD l_fmmj003 name="construct.a.page1.l_fmmj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fmmj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmj003
            #add-point:ON ACTION controlp INFIELD l_fmmj003 name="construct.c.page1.l_fmmj003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr003
            #add-point:BEFORE FIELD fmmr003 name="construct.b.page1.fmmr003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr003
            
            #add-point:AFTER FIELD fmmr003 name="construct.a.page1.fmmr003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmr003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr003
            #add-point:ON ACTION controlp INFIELD fmmr003 name="construct.c.page1.fmmr003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO fmmr003  #顯示到畫面上
            NEXT FIELD fmmr003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmp006
            #add-point:BEFORE FIELD l_fmmp006 name="construct.b.page1.l_fmmp006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmp006
            
            #add-point:AFTER FIELD l_fmmp006 name="construct.a.page1.l_fmmp006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fmmp006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmp006
            #add-point:ON ACTION controlp INFIELD l_fmmp006 name="construct.c.page1.l_fmmp006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmp007
            #add-point:BEFORE FIELD l_fmmp007 name="construct.b.page1.l_fmmp007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmp007
            
            #add-point:AFTER FIELD l_fmmp007 name="construct.a.page1.l_fmmp007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_fmmp007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmp007
            #add-point:ON ACTION controlp INFIELD l_fmmp007 name="construct.c.page1.l_fmmp007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr037
            #add-point:BEFORE FIELD fmmr037 name="construct.b.page1.fmmr037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr037
            
            #add-point:AFTER FIELD fmmr037 name="construct.a.page1.fmmr037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmr037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr037
            #add-point:ON ACTION controlp INFIELD fmmr037 name="construct.c.page1.fmmr037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr004
            #add-point:BEFORE FIELD fmmr004 name="construct.b.page1.fmmr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr004
            
            #add-point:AFTER FIELD fmmr004 name="construct.a.page1.fmmr004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmr004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr004
            #add-point:ON ACTION controlp INFIELD fmmr004 name="construct.c.page1.fmmr004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr005
            #add-point:BEFORE FIELD fmmr005 name="construct.b.page1.fmmr005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr005
            
            #add-point:AFTER FIELD fmmr005 name="construct.a.page1.fmmr005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmr005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr005
            #add-point:ON ACTION controlp INFIELD fmmr005 name="construct.c.page1.fmmr005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr006
            #add-point:BEFORE FIELD fmmr006 name="construct.b.page1.fmmr006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr006
            
            #add-point:AFTER FIELD fmmr006 name="construct.a.page1.fmmr006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmr006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr006
            #add-point:ON ACTION controlp INFIELD fmmr006 name="construct.c.page1.fmmr006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr007
            #add-point:BEFORE FIELD fmmr007 name="construct.b.page1.fmmr007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr007
            
            #add-point:AFTER FIELD fmmr007 name="construct.a.page1.fmmr007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmr007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr007
            #add-point:ON ACTION controlp INFIELD fmmr007 name="construct.c.page1.fmmr007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr008
            #add-point:BEFORE FIELD fmmr008 name="construct.b.page1.fmmr008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr008
            
            #add-point:AFTER FIELD fmmr008 name="construct.a.page1.fmmr008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmr008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr008
            #add-point:ON ACTION controlp INFIELD fmmr008 name="construct.c.page1.fmmr008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr009
            #add-point:BEFORE FIELD fmmr009 name="construct.b.page1.fmmr009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr009
            
            #add-point:AFTER FIELD fmmr009 name="construct.a.page1.fmmr009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmr009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr009
            #add-point:ON ACTION controlp INFIELD fmmr009 name="construct.c.page1.fmmr009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr010
            #add-point:BEFORE FIELD fmmr010 name="construct.b.page1.fmmr010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr010
            
            #add-point:AFTER FIELD fmmr010 name="construct.a.page1.fmmr010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmr010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr010
            #add-point:ON ACTION controlp INFIELD fmmr010 name="construct.c.page1.fmmr010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr011
            #add-point:BEFORE FIELD fmmr011 name="construct.b.page2.fmmr011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr011
            
            #add-point:AFTER FIELD fmmr011 name="construct.a.page2.fmmr011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr011
            #add-point:ON ACTION controlp INFIELD fmmr011 name="construct.c.page2.fmmr011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr011_desc
            #add-point:ON ACTION controlp INFIELD fmmr011_desc name="construct.c.page2.fmmr011_desc"
            #公允價值變動科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "  #glac003(科目類型)
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO fmmr011
            DISPLAY g_qryparam.return1 TO fmmr011_desc
            NEXT FIELD fmmr011_desc


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr011_desc
            #add-point:BEFORE FIELD fmmr011_desc name="construct.b.page2.fmmr011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr011_desc
            
            #add-point:AFTER FIELD fmmr011_desc name="construct.a.page2.fmmr011_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr012
            #add-point:BEFORE FIELD fmmr012 name="construct.b.page2.fmmr012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr012
            
            #add-point:AFTER FIELD fmmr012 name="construct.a.page2.fmmr012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr012
            #add-point:ON ACTION controlp INFIELD fmmr012 name="construct.c.page2.fmmr012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr012_desc
            #add-point:BEFORE FIELD fmmr012_desc name="construct.b.page2.fmmr012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr012_desc
            
            #add-point:AFTER FIELD fmmr012_desc name="construct.a.page2.fmmr012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr012_desc
            #add-point:ON ACTION controlp INFIELD fmmr012_desc name="construct.c.page2.fmmr012_desc"
            #公允價值損益科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "  #glac003(科目類型)
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO fmmr012
            DISPLAY g_qryparam.return1 TO fmmr012_desc
            NEXT FIELD fmmr012_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr036
            #add-point:BEFORE FIELD fmmr036 name="construct.b.page2.fmmr036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr036
            
            #add-point:AFTER FIELD fmmr036 name="construct.a.page2.fmmr036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr036
            #add-point:ON ACTION controlp INFIELD fmmr036 name="construct.c.page2.fmmr036"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr013
            #add-point:ON ACTION controlp INFIELD fmmr013 name="construct.c.page2.fmmr013"
            #帳款對象
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()        #160913-00017#2  ADD 
           # CALL q_pmaa001()      #160913-00017#2 mark          #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmr013
            NEXT FIELD fmmr013
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr013
            #add-point:BEFORE FIELD fmmr013 name="construct.b.page2.fmmr013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr013
            
            #add-point:AFTER FIELD fmmr013 name="construct.a.page2.fmmr013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr013_desc
            #add-point:BEFORE FIELD fmmr013_desc name="construct.b.page2.fmmr013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr013_desc
            
            #add-point:AFTER FIELD fmmr013_desc name="construct.a.page2.fmmr013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr013_desc
            #add-point:ON ACTION controlp INFIELD fmmr013_desc name="construct.c.page2.fmmr013_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr014
            #add-point:ON ACTION controlp INFIELD fmmr014 name="construct.c.page2.fmmr014"
             #收款對象
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmac002_1()
            DISPLAY g_qryparam.return1 TO fmmr014
            NEXT FIELD fmmr014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr014
            #add-point:BEFORE FIELD fmmr014 name="construct.b.page2.fmmr014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr014
            
            #add-point:AFTER FIELD fmmr014 name="construct.a.page2.fmmr014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr014_desc
            #add-point:BEFORE FIELD fmmr014_desc name="construct.b.page2.fmmr014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr014_desc
            
            #add-point:AFTER FIELD fmmr014_desc name="construct.a.page2.fmmr014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr014_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr014_desc
            #add-point:ON ACTION controlp INFIELD fmmr014_desc name="construct.c.page2.fmmr014_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr015
            #add-point:BEFORE FIELD fmmr015 name="construct.b.page2.fmmr015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr015
            
            #add-point:AFTER FIELD fmmr015 name="construct.a.page2.fmmr015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr015
            #add-point:ON ACTION controlp INFIELD fmmr015 name="construct.c.page2.fmmr015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr015_desc
            #add-point:ON ACTION controlp INFIELD fmmr015_desc name="construct.c.page2.fmmr015_desc"
           #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO fmmr015
            DISPLAY g_qryparam.return1 TO fmmr015_desc
            NEXT FIELD fmmr015_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr015_desc
            #add-point:BEFORE FIELD fmmr015_desc name="construct.b.page2.fmmr015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr015_desc
            
            #add-point:AFTER FIELD fmmr015_desc name="construct.a.page2.fmmr015_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr016
            #add-point:BEFORE FIELD fmmr016 name="construct.b.page2.fmmr016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr016
            
            #add-point:AFTER FIELD fmmr016 name="construct.a.page2.fmmr016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr016
            #add-point:ON ACTION controlp INFIELD fmmr016 name="construct.c.page2.fmmr016"
        
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr016_desc
            #add-point:ON ACTION controlp INFIELD fmmr016_desc name="construct.c.page2.fmmr016_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO fmmr016
            DISPLAY g_qryparam.return1 TO fmmr016_desc
            NEXT FIELD fmmr016_desc              #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr016_desc
            #add-point:BEFORE FIELD fmmr016_desc name="construct.b.page2.fmmr016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr016_desc
            
            #add-point:AFTER FIELD fmmr016_desc name="construct.a.page2.fmmr016_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr017
            #add-point:BEFORE FIELD fmmr017 name="construct.b.page2.fmmr017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr017
            
            #add-point:AFTER FIELD fmmr017 name="construct.a.page2.fmmr017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr017
            #add-point:ON ACTION controlp INFIELD fmmr017 name="construct.c.page2.fmmr017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr017_desc
            #add-point:ON ACTION controlp INFIELD fmmr017_desc name="construct.c.page2.fmmr017_desc"
             #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO fmmr017
            DISPLAY g_qryparam.return1 TO fmmr017_desc
            NEXT FIELD fmmr017_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr017_desc
            #add-point:BEFORE FIELD fmmr017_desc name="construct.b.page2.fmmr017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr017_desc
            
            #add-point:AFTER FIELD fmmr017_desc name="construct.a.page2.fmmr017_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr018
            #add-point:BEFORE FIELD fmmr018 name="construct.b.page2.fmmr018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr018
            
            #add-point:AFTER FIELD fmmr018 name="construct.a.page2.fmmr018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr018
            #add-point:ON ACTION controlp INFIELD fmmr018 name="construct.c.page2.fmmr018"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr018_desc
            #add-point:ON ACTION controlp INFIELD fmmr018_desc name="construct.c.page2.fmmr018_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO fmmr018
            DISPLAY g_qryparam.return1 TO fmmr018_desc
            NEXT FIELD fmmr018_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr018_desc
            #add-point:BEFORE FIELD fmmr018_desc name="construct.b.page2.fmmr018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr018_desc
            
            #add-point:AFTER FIELD fmmr018_desc name="construct.a.page2.fmmr018_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr019
            #add-point:BEFORE FIELD fmmr019 name="construct.b.page2.fmmr019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr019
            
            #add-point:AFTER FIELD fmmr019 name="construct.a.page2.fmmr019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr019
            #add-point:ON ACTION controlp INFIELD fmmr019 name="construct.c.page2.fmmr019"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr019_desc
            #add-point:ON ACTION controlp INFIELD fmmr019_desc name="construct.c.page2.fmmr019_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO fmmr019
            DISPLAY g_qryparam.return1 TO fmmr019_desc
            NEXT FIELD fmmr019_desc                   #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr019_desc
            #add-point:BEFORE FIELD fmmr019_desc name="construct.b.page2.fmmr019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr019_desc
            
            #add-point:AFTER FIELD fmmr019_desc name="construct.a.page2.fmmr019_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr020
            #add-point:BEFORE FIELD fmmr020 name="construct.b.page2.fmmr020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr020
            
            #add-point:AFTER FIELD fmmr020 name="construct.a.page2.fmmr020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr020
            #add-point:ON ACTION controlp INFIELD fmmr020 name="construct.c.page2.fmmr020"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr020_desc
            #add-point:ON ACTION controlp INFIELD fmmr020_desc name="construct.c.page2.fmmr020_desc"
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO fmmr020
            DISPLAY g_qryparam.return1 TO fmmr020_desc
            NEXT FIELD fmmr020_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr020_desc
            #add-point:BEFORE FIELD fmmr020_desc name="construct.b.page2.fmmr020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr020_desc
            
            #add-point:AFTER FIELD fmmr020_desc name="construct.a.page2.fmmr020_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr021
            #add-point:BEFORE FIELD fmmr021 name="construct.b.page2.fmmr021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr021
            
            #add-point:AFTER FIELD fmmr021 name="construct.a.page2.fmmr021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr021
            #add-point:ON ACTION controlp INFIELD fmmr021 name="construct.c.page2.fmmr021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr021_desc
            #add-point:ON ACTION controlp INFIELD fmmr021_desc name="construct.c.page2.fmmr021_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO fmmr021
            DISPLAY g_qryparam.return1 TO fmmr021_desc
            NEXT FIELD fmmr021_desc

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr021_desc
            #add-point:BEFORE FIELD fmmr021_desc name="construct.b.page2.fmmr021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr021_desc
            
            #add-point:AFTER FIELD fmmr021_desc name="construct.a.page2.fmmr021_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr022
            #add-point:BEFORE FIELD fmmr022 name="construct.b.page2.fmmr022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr022
            
            #add-point:AFTER FIELD fmmr022 name="construct.a.page2.fmmr022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr022
            #add-point:ON ACTION controlp INFIELD fmmr022 name="construct.c.page2.fmmr022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr022_desc
            #add-point:BEFORE FIELD fmmr022_desc name="construct.b.page2.fmmr022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr022_desc
            
            #add-point:AFTER FIELD fmmr022_desc name="construct.a.page2.fmmr022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr022_desc
            #add-point:ON ACTION controlp INFIELD fmmr022_desc name="construct.c.page2.fmmr022_desc"
             #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO fmmr022
            DISPLAY g_qryparam.return1 TO fmmr022_desc
            NEXT FIELD fmmr022_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr023
            #add-point:BEFORE FIELD fmmr023 name="construct.b.page2.fmmr023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr023
            
            #add-point:AFTER FIELD fmmr023 name="construct.a.page2.fmmr023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr023
            #add-point:ON ACTION controlp INFIELD fmmr023 name="construct.c.page2.fmmr023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr023_desc
            #add-point:BEFORE FIELD fmmr023_desc name="construct.b.page2.fmmr023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr023_desc
            
            #add-point:AFTER FIELD fmmr023_desc name="construct.a.page2.fmmr023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr023_desc
            #add-point:ON ACTION controlp INFIELD fmmr023_desc name="construct.c.page2.fmmr023_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr024
            #add-point:BEFORE FIELD fmmr024 name="construct.b.page2.fmmr024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr024
            
            #add-point:AFTER FIELD fmmr024 name="construct.a.page2.fmmr024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr024
            #add-point:ON ACTION controlp INFIELD fmmr024 name="construct.c.page2.fmmr024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr024_desc
            #add-point:ON ACTION controlp INFIELD fmmr024_desc name="construct.c.page2.fmmr024_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO fmmr024
            DISPLAY g_qryparam.return1 TO fmmr024_desc
            NEXT FIELD fmmr024_desc

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr024_desc
            #add-point:BEFORE FIELD fmmr024_desc name="construct.b.page2.fmmr024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr024_desc
            
            #add-point:AFTER FIELD fmmr024_desc name="construct.a.page2.fmmr024_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr025
            #add-point:BEFORE FIELD fmmr025 name="construct.b.page2.fmmr025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr025
            
            #add-point:AFTER FIELD fmmr025 name="construct.a.page2.fmmr025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmmr025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr025
            #add-point:ON ACTION controlp INFIELD fmmr025 name="construct.c.page2.fmmr025"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmmr025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr025_desc
            #add-point:ON ACTION controlp INFIELD fmmr025_desc name="construct.c.page2.fmmr025_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO fmmr025
            DISPLAY g_qryparam.return1 TO fmmr025_desc
            NEXT FIELD fmmr025_desc

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr025_desc
            #add-point:BEFORE FIELD fmmr025_desc name="construct.b.page2.fmmr025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr025_desc
            
            #add-point:AFTER FIELD fmmr025_desc name="construct.a.page2.fmmr025_desc"
            
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
                  WHEN la_wc[li_idx].tableid = "fmmq_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fmmr_t" 
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
 
{<section id="afmt555.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION afmt555_filter()
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
      CONSTRUCT g_wc_filter ON fmmqdocno,fmmq002,fmmq003
                          FROM s_browse[1].b_fmmqdocno,s_browse[1].b_fmmq002,s_browse[1].b_fmmq003
 
         BEFORE CONSTRUCT
               DISPLAY afmt555_filter_parser('fmmqdocno') TO s_browse[1].b_fmmqdocno
            DISPLAY afmt555_filter_parser('fmmq002') TO s_browse[1].b_fmmq002
            DISPLAY afmt555_filter_parser('fmmq003') TO s_browse[1].b_fmmq003
      
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
 
      CALL afmt555_filter_show('fmmqdocno')
   CALL afmt555_filter_show('fmmq002')
   CALL afmt555_filter_show('fmmq003')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt555.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION afmt555_filter_parser(ps_field)
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
 
{<section id="afmt555.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION afmt555_filter_show(ps_field)
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
   LET ls_condition = afmt555_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmt555.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt555_query()
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
   CALL g_fmmr_d.clear()
   CALL g_fmmr2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afmt555_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt555_browser_fill("")
      CALL afmt555_fetch("")
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
      CALL afmt555_filter_show('fmmqdocno')
   CALL afmt555_filter_show('fmmq002')
   CALL afmt555_filter_show('fmmq003')
   CALL afmt555_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afmt555_fetch("F") 
      #顯示單身筆數
      CALL afmt555_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt555.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt555_fetch(p_flag)
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
   
   LET g_fmmq_m.fmmqdocno = g_browser[g_current_idx].b_fmmqdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afmt555_master_referesh USING g_fmmq_m.fmmqdocno INTO g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001, 
       g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003,g_fmmq_m.fmmq004,g_fmmq_m.fmmqstus, 
       g_fmmq_m.fmmqownid,g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtdp,g_fmmq_m.fmmqcrtdt, 
       g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmoddt,g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfdt,g_fmmq_m.fmmqsite_desc, 
       g_fmmq_m.fmmq001_desc,g_fmmq_m.fmmqownid_desc,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid_desc, 
       g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqcnfid_desc
   
   #遮罩相關處理
   LET g_fmmq_m_mask_o.* =  g_fmmq_m.*
   CALL afmt555_fmmq_t_mask()
   LET g_fmmq_m_mask_n.* =  g_fmmq_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt555_set_act_visible()   
   CALL afmt555_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fmmq_m_t.* = g_fmmq_m.*
   LET g_fmmq_m_o.* = g_fmmq_m.*
   
   LET g_data_owner = g_fmmq_m.fmmqownid      
   LET g_data_dept  = g_fmmq_m.fmmqowndp
   
   #重新顯示   
   CALL afmt555_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt555.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt555_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fmmr_d.clear()   
   CALL g_fmmr2_d.clear()  
 
 
   INITIALIZE g_fmmq_m.* TO NULL             #DEFAULT 設定
   
   LET g_fmmqdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmmq_m.fmmqownid = g_user
      LET g_fmmq_m.fmmqowndp = g_dept
      LET g_fmmq_m.fmmqcrtid = g_user
      LET g_fmmq_m.fmmqcrtdp = g_dept 
      LET g_fmmq_m.fmmqcrtdt = cl_get_current()
      LET g_fmmq_m.fmmqmodid = g_user
      LET g_fmmq_m.fmmqmoddt = cl_get_current()
      LET g_fmmq_m.fmmqstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_fmmq_m.fmmq002 = "0"
      LET g_fmmq_m.fmmq003 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      #日期
      LET g_fmmq_m.fmmqdocdt = g_today
      
      #帳務組織/帳套/法人預設
      CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,g_fmmq_m.fmmqsite,
                                                         g_fmmq_m.fmmq001,g_fmmq_m.l_fmmqcomp
      CALL s_desc_get_department_desc(g_fmmq_m.fmmqsite) RETURNING g_fmmq_m.fmmqsite_desc
      #設定帳別相關預設值
      IF NOT cl_null(g_fmmq_m.fmmq001) THEN
         CALL s_desc_get_ld_desc(g_fmmq_m.fmmq001)  RETURNING g_fmmq_m.fmmq001_desc
         CALL afmt555_set_ld_info(g_fmmq_m.fmmq001) RETURNING g_fmmq_m.l_fmmqcomp
         CALL s_desc_get_department_desc(g_fmmq_m.l_fmmqcomp) RETURNING g_fmmq_m.fmmqcomp_desc
      END IF
                                                         
      #取得帳務組織下所屬成員
      CALL s_fin_account_center_sons_query('3',g_fmmq_m.fmmqsite,g_fmmq_m.fmmqdocdt,'1')
      CALL s_fin_account_center_sons_str() RETURNING g_wc_fmmqsite
      CALL s_fin_get_wc_str(g_wc_fmmqsite) RETURNING g_wc_fmmqsite
      CALL s_fin_account_center_ld_str() RETURNING g_wc_fmmq001
      CALL s_fin_get_wc_str(g_wc_fmmq001) RETURNING g_wc_fmmq001
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_fmmq_m_t.* = g_fmmq_m.*
      LET g_fmmq_m_o.* = g_fmmq_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmq_m.fmmqstus 
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
 
 
 
    
      CALL afmt555_input("a")
      
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
         INITIALIZE g_fmmq_m.* TO NULL
         INITIALIZE g_fmmr_d TO NULL
         INITIALIZE g_fmmr2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afmt555_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fmmr_d.clear()
      #CALL g_fmmr2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt555_set_act_visible()   
   CALL afmt555_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmmqdocno_t = g_fmmq_m.fmmqdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmmqent = " ||g_enterprise|| " AND",
                      " fmmqdocno = '", g_fmmq_m.fmmqdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt555_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afmt555_cl
   
   CALL afmt555_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt555_master_referesh USING g_fmmq_m.fmmqdocno INTO g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001, 
       g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003,g_fmmq_m.fmmq004,g_fmmq_m.fmmqstus, 
       g_fmmq_m.fmmqownid,g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtdp,g_fmmq_m.fmmqcrtdt, 
       g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmoddt,g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfdt,g_fmmq_m.fmmqsite_desc, 
       g_fmmq_m.fmmq001_desc,g_fmmq_m.fmmqownid_desc,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid_desc, 
       g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqcnfid_desc
   
   
   #遮罩相關處理
   LET g_fmmq_m_mask_o.* =  g_fmmq_m.*
   CALL afmt555_fmmq_t_mask()
   LET g_fmmq_m_mask_n.* =  g_fmmq_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmmq_m.fmmqsite,g_fmmq_m.fmmqsite_desc,g_fmmq_m.fmmq001,g_fmmq_m.fmmq001_desc,g_fmmq_m.l_fmmqcomp, 
       g_fmmq_m.fmmqcomp_desc,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003, 
       g_fmmq_m.fmmq004,g_fmmq_m.l_curr,g_fmmq_m.fmmqstus,g_fmmq_m.fmmqownid,g_fmmq_m.fmmqownid_desc, 
       g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtid_desc,g_fmmq_m.fmmqcrtdp, 
       g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqcrtdt,g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqmoddt, 
       g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfid_desc,g_fmmq_m.fmmqcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_fmmq_m.fmmqownid      
   LET g_data_dept  = g_fmmq_m.fmmqowndp
   
   #功能已完成,通報訊息中心
   CALL afmt555_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt555_modify()
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
   LET g_fmmq_m_t.* = g_fmmq_m.*
   LET g_fmmq_m_o.* = g_fmmq_m.*
   
   IF g_fmmq_m.fmmqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_fmmqdocno_t = g_fmmq_m.fmmqdocno
 
   CALL s_transaction_begin()
   
   OPEN afmt555_cl USING g_enterprise,g_fmmq_m.fmmqdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt555_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt555_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt555_master_referesh USING g_fmmq_m.fmmqdocno INTO g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001, 
       g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003,g_fmmq_m.fmmq004,g_fmmq_m.fmmqstus, 
       g_fmmq_m.fmmqownid,g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtdp,g_fmmq_m.fmmqcrtdt, 
       g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmoddt,g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfdt,g_fmmq_m.fmmqsite_desc, 
       g_fmmq_m.fmmq001_desc,g_fmmq_m.fmmqownid_desc,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid_desc, 
       g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqcnfid_desc
   
   #檢查是否允許此動作
   IF NOT afmt555_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmmq_m_mask_o.* =  g_fmmq_m.*
   CALL afmt555_fmmq_t_mask()
   LET g_fmmq_m_mask_n.* =  g_fmmq_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL afmt555_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_fmmqdocno_t = g_fmmq_m.fmmqdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_fmmq_m.fmmqmodid = g_user 
LET g_fmmq_m.fmmqmoddt = cl_get_current()
LET g_fmmq_m.fmmqmodid_desc = cl_get_username(g_fmmq_m.fmmqmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afmt555_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE fmmq_t SET (fmmqmodid,fmmqmoddt) = (g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmoddt)
          WHERE fmmqent = g_enterprise AND fmmqdocno = g_fmmqdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_fmmq_m.* = g_fmmq_m_t.*
            CALL afmt555_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_fmmq_m.fmmqdocno != g_fmmq_m_t.fmmqdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE fmmr_t SET fmmrdocno = g_fmmq_m.fmmqdocno
 
          WHERE fmmrent = g_enterprise AND fmmrdocno = g_fmmq_m_t.fmmqdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmmr_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmmr_t:",SQLERRMESSAGE 
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
   CALL afmt555_set_act_visible()   
   CALL afmt555_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmmqent = " ||g_enterprise|| " AND",
                      " fmmqdocno = '", g_fmmq_m.fmmqdocno, "' "
 
   #填到對應位置
   CALL afmt555_browser_fill("")
 
   CLOSE afmt555_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt555_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afmt555.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt555_input(p_cmd)
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
   DISPLAY BY NAME g_fmmq_m.fmmqsite,g_fmmq_m.fmmqsite_desc,g_fmmq_m.fmmq001,g_fmmq_m.fmmq001_desc,g_fmmq_m.l_fmmqcomp, 
       g_fmmq_m.fmmqcomp_desc,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003, 
       g_fmmq_m.fmmq004,g_fmmq_m.l_curr,g_fmmq_m.fmmqstus,g_fmmq_m.fmmqownid,g_fmmq_m.fmmqownid_desc, 
       g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtid_desc,g_fmmq_m.fmmqcrtdp, 
       g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqcrtdt,g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqmoddt, 
       g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfid_desc,g_fmmq_m.fmmqcnfdt
   
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
   LET g_forupd_sql = "SELECT fmmrseq,fmmr001,fmmr002,fmmr003,fmmr037,fmmr004,fmmr005,fmmr006,fmmr007, 
       fmmr008,fmmr009,fmmr010,fmmrseq,fmmr011,fmmr012,fmmr036,fmmr013,fmmr014,fmmr015,fmmr016,fmmr017, 
       fmmr018,fmmr019,fmmr020,fmmr021,fmmr022,fmmr023,fmmr024,fmmr025,fmmr026,fmmr027,fmmr028,fmmr029, 
       fmmr030,fmmr031,fmmr032,fmmr033,fmmr034,fmmr035 FROM fmmr_t WHERE fmmrent=? AND fmmrdocno=? AND  
       fmmrseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt555_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afmt555_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt555_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001,g_fmmq_m.l_fmmqcomp,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt, 
       g_fmmq_m.fmmq002,g_fmmq_m.fmmq003,g_fmmq_m.l_curr,g_fmmq_m.fmmqstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afmt555.input.head" >}
      #單頭段
      INPUT BY NAME g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001,g_fmmq_m.l_fmmqcomp,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt, 
          g_fmmq_m.fmmq002,g_fmmq_m.fmmq003,g_fmmq_m.l_curr,g_fmmq_m.fmmqstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afmt555_cl USING g_enterprise,g_fmmq_m.fmmqdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt555_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt555_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afmt555_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL afmt555_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqsite
            
            #add-point:AFTER FIELD fmmqsite name="input.a.fmmqsite"
            IF NOT cl_null(g_fmmq_m.fmmqsite) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmmq_m.fmmqsite != g_fmmq_m_t.fmmqsite )) THEN   #160822-00012#4   mark
               IF g_fmmq_m.fmmqsite != g_fmmq_m_o.fmmqsite OR cl_null(g_fmmq_m_o.fmmqsite) THEN          #160822-00012#4   add
                  #以目前的資料重展結構,避免[帳套]有值時會比對錯誤,在s_fin_account_center_with_ld_chk做勾稽時會依據這個結構做是否有符合的帳套
                  CALL s_fin_account_center_sons_query('3',g_fmmq_m.fmmqsite,g_fmmq_m.fmmqdocdt,'1')
                  #如果帳務中心不同 且帳套有值 先依據現在的帳務中心跟帳套勾稽一次---(S)---
                  #避免USER 在帳務中心跟帳套卡住走不了 增加對帳套有資料的處理
                  IF g_fmmq_m_t.fmmqsite != g_fmmq_m.fmmqsite AND NOT cl_null(g_fmmq_m.fmmq001) THEN   
                     CALL s_fin_account_center_with_ld_chk(g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001,g_user,'3','N','',g_fmmq_m.fmmqdocdt) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        #勾稽失敗:目前的帳套不在這個帳務中心下 因此預設值給帳務中心的主帳套
                        CALL s_fin_orga_get_comp_ld(g_fmmq_m.fmmqsite) RETURNING g_sub_success,g_errno,g_fmmq_m.l_fmmqcomp,g_fmmq_m.fmmq001
                        #判斷這個主帳套使用者是否有權限
                        CALL s_fin_account_center_with_ld_chk(g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001,g_user,'3','N','',g_fmmq_m.fmmqdocdt) RETURNING g_sub_success,g_errno
                     END IF
                     #判斷完成後 若勾稽失敗則回復舊值
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_fmmq_m.fmmqsite = g_fmmq_m_t.fmmqsite   #160822-00012#4   mark
                        LET g_fmmq_m.fmmqsite = g_fmmq_m_o.fmmqsite    #160822-00012#4   add
                        #LET g_fmmq_m.fmmq001   = g_fmmq_m_t.fmmq001   #160822-00012#4   mark
                        LET g_fmmq_m.fmmq001   = g_fmmq_m_o.fmmq001    #160822-00012#4   add
                        CALL s_desc_get_department_desc(g_fmmq_m.fmmqsite) RETURNING g_fmmq_m.fmmqsite_desc
                        DISPLAY BY NAME g_fmmq_m.fmmqsite_desc
                        NEXT FIELD CURRENT
                     END IF
                     CALL s_desc_get_ld_desc(g_fmmq_m.fmmq001) RETURNING g_fmmq_m.fmmq001_desc
                     CALL afmt555_set_ld_info(g_fmmq_m.fmmq001) RETURNING g_fmmq_m.l_fmmqcomp
                     DISPLAY BY NAME g_fmmq_m.fmmq001_desc
                  END IF
                  #如果帳務中心不同 且帳套有值 先依據現在的帳務中心跟帳套勾稽一次---(E)---
                  CALL s_fin_account_center_with_ld_chk(g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001,g_user,'3','N','',g_fmmq_m.fmmqdocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmq_m.fmmqsite = g_fmmq_m_t.fmmqsite   #160822-00012#4   mark
                     LET g_fmmq_m.fmmqsite = g_fmmq_m_o.fmmqsite    #160822-00012#4   add
                     CALL s_desc_get_department_desc(g_fmmq_m.fmmqsite) RETURNING g_fmmq_m.fmmqsite_desc
                     DISPLAY BY NAME g_fmmq_m.fmmqsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_fin_account_center_sons_query('3',g_fmmq_m.fmmqsite,g_fmmq_m.fmmqdocdt,'1')  #依據正確的資料再重展一次結構
               CALL s_fin_account_center_sons_str() RETURNING g_wc_fmmqsite
               CALL s_fin_get_wc_str(g_wc_fmmqsite) RETURNING g_wc_fmmqsite
               CALL s_fin_account_center_ld_str() RETURNING g_wc_fmmq001
               CALL s_fin_get_wc_str(g_wc_fmmq001) RETURNING g_wc_fmmq001
               LET g_fmmq_m_t.fmmqsite = g_fmmq_m.fmmqsite
            END IF
            CALL s_desc_get_department_desc(g_fmmq_m.fmmqsite) RETURNING g_fmmq_m.fmmqsite_desc
            DISPLAY BY NAME g_fmmq_m.fmmqsite_desc
            LET g_fmmq_m_o.* = g_fmmq_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqsite
            #add-point:BEFORE FIELD fmmqsite name="input.b.fmmqsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmqsite
            #add-point:ON CHANGE fmmqsite name="input.g.fmmqsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmq001
            
            #add-point:AFTER FIELD fmmq001 name="input.a.fmmq001"
            IF NOT cl_null(g_fmmq_m.fmmq001) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmmq_m.fmmq001 != g_fmmq_m_t.fmmq001 )) THEN   #160822-00012#4   mark
               IF g_fmmq_m.fmmq001 != g_fmmq_m_o.fmmq001 OR cl_null(g_fmmq_m_o.fmmq001) THEN           #160822-00012#4
                  CALL s_fin_account_center_with_ld_chk(g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001,g_user,'3','N',g_wc_fmmq001,g_fmmq_m.fmmqdocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmq_m.fmmq001 = g_fmmq_m_t.fmmq001   #160822-00012#4   mark
                     LET g_fmmq_m.fmmq001 = g_fmmq_m_o.fmmq001    #160822-00012#4   add
                     #LET g_fmmq_m.l_fmmqcomp = g_fmmq_m_t.l_fmmqcomp   #160822-00012#4   mark
                     LET g_fmmq_m.l_fmmqcomp = g_fmmq_m_o.l_fmmqcomp    #160822-00012#4   add
                     NEXT FIELD CURRENT
                  END IF
                  CALL afmt555_set_ld_info(g_fmmq_m.fmmq001) RETURNING g_fmmq_m.l_fmmqcomp
               END IF
            END IF
            CALL s_desc_get_ld_desc(g_fmmq_m.fmmq001) RETURNING g_fmmq_m.fmmq001_desc
            DISPLAY BY NAME g_fmmq_m.fmmq001_desc
            LET g_fmmq_m_o.* = g_fmmq_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmq001
            #add-point:BEFORE FIELD fmmq001 name="input.b.fmmq001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmq001
            #add-point:ON CHANGE fmmq001 name="input.g.fmmq001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmqcomp
            #add-point:BEFORE FIELD l_fmmqcomp name="input.b.l_fmmqcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmqcomp
            
            #add-point:AFTER FIELD l_fmmqcomp name="input.a.l_fmmqcomp"
            LET g_fmmq_m_o.* = g_fmmq_m.*    #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmqcomp
            #add-point:ON CHANGE l_fmmqcomp name="input.g.l_fmmqcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqdocno
            #add-point:BEFORE FIELD fmmqdocno name="input.b.fmmqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqdocno
            
            #add-point:AFTER FIELD fmmqdocno name="input.a.fmmqdocno"
            IF NOT cl_null(g_fmmq_m.fmmqdocno) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmq_m.fmmqdocno != g_fmmq_m_t.fmmqdocno OR g_fmmq_m_t.fmmqdocno IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmmq_m.fmmqdocno != g_fmmq_m_o.fmmqdocno OR cl_null(g_fmmq_m_o.fmmqdocno) THEN                                       #160822-00012#4   add
                   IF NOT s_aooi200_fin_chk_docno(g_fmmq_m.fmmq001,'','',g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_prog) THEN
                     #LET g_fmmq_m.fmmqdocno = g_fmmq_m_t.fmmqdocno   #160822-00012#4   mark
                     LET g_fmmq_m.fmmqdocno = g_fmmq_m_o.fmmqdocno    #160822-00012#4   add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_fmmq_m_o.* = g_fmmq_m.*    #160822-00012#4   add



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmqdocno
            #add-point:ON CHANGE fmmqdocno name="input.g.fmmqdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqdocdt
            #add-point:BEFORE FIELD fmmqdocdt name="input.b.fmmqdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqdocdt
            
            #add-point:AFTER FIELD fmmqdocdt name="input.a.fmmqdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmqdocdt
            #add-point:ON CHANGE fmmqdocdt name="input.g.fmmqdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmq002
            #add-point:BEFORE FIELD fmmq002 name="input.b.fmmq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmq002
            
            #add-point:AFTER FIELD fmmq002 name="input.a.fmmq002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmq002
            #add-point:ON CHANGE fmmq002 name="input.g.fmmq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmq003
            #add-point:BEFORE FIELD fmmq003 name="input.b.fmmq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmq003
            
            #add-point:AFTER FIELD fmmq003 name="input.a.fmmq003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmq003
            #add-point:ON CHANGE fmmq003 name="input.g.fmmq003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_curr
            #add-point:BEFORE FIELD l_curr name="input.b.l_curr"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_curr
            
            #add-point:AFTER FIELD l_curr name="input.a.l_curr"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_curr
            #add-point:ON CHANGE l_curr name="input.g.l_curr"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmqstus
            #add-point:BEFORE FIELD fmmqstus name="input.b.fmmqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmqstus
            
            #add-point:AFTER FIELD fmmqstus name="input.a.fmmqstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmqstus
            #add-point:ON CHANGE fmmqstus name="input.g.fmmqstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmmqsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqsite
            #add-point:ON ACTION controlp INFIELD fmmqsite name="input.c.fmmqsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmq001
            #add-point:ON ACTION controlp INFIELD fmmq001 name="input.c.fmmq001"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_fmmqcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmqcomp
            #add-point:ON ACTION controlp INFIELD l_fmmqcomp name="input.c.l_fmmqcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmqdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqdocno
            #add-point:ON ACTION controlp INFIELD fmmqdocno name="input.c.fmmqdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmq_m.fmmqdocno
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()
            LET g_fmmq_m.fmmqdocno = g_qryparam.return1
            DISPLAY BY NAME g_fmmq_m.fmmqdocno
            NEXT FIELD fmmqdocno
            #END add-point
 
 
         #Ctrlp:input.c.fmmqdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqdocdt
            #add-point:ON ACTION controlp INFIELD fmmqdocdt name="input.c.fmmqdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmq002
            #add-point:ON ACTION controlp INFIELD fmmq002 name="input.c.fmmq002"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmq003
            #add-point:ON ACTION controlp INFIELD fmmq003 name="input.c.fmmq003"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_curr
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_curr
            #add-point:ON ACTION controlp INFIELD l_curr name="input.c.l_curr"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmqstus
            #add-point:ON ACTION controlp INFIELD fmmqstus name="input.c.fmmqstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_fmmq_m.fmmqdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_fin_gen_docno(g_fmmq_m.fmmq001,'','',g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_prog)
                       RETURNING g_sub_success,g_fmmq_m.fmmqdocno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00003'
                     LET g_errparam.extend = g_fmmq_m.fmmqdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD fmmqdocno
                  END IF
                  DISPLAY BY NAME g_fmmq_m.fmmqdocno
               #end add-point
               
               INSERT INTO fmmq_t (fmmqent,fmmqsite,fmmq001,fmmqdocno,fmmqdocdt,fmmq002,fmmq003,fmmq004, 
                   fmmqstus,fmmqownid,fmmqowndp,fmmqcrtid,fmmqcrtdp,fmmqcrtdt,fmmqmodid,fmmqmoddt,fmmqcnfid, 
                   fmmqcnfdt)
               VALUES (g_enterprise,g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt, 
                   g_fmmq_m.fmmq002,g_fmmq_m.fmmq003,g_fmmq_m.fmmq004,g_fmmq_m.fmmqstus,g_fmmq_m.fmmqownid, 
                   g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtdp,g_fmmq_m.fmmqcrtdt,g_fmmq_m.fmmqmodid, 
                   g_fmmq_m.fmmqmoddt,g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_fmmq_m:",SQLERRMESSAGE 
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
                  CALL afmt555_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afmt555_b_fill()
                  CALL afmt555_b_fill2('0')
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
               CALL afmt555_fmmq_t_mask_restore('restore_mask_o')
               
               UPDATE fmmq_t SET (fmmqsite,fmmq001,fmmqdocno,fmmqdocdt,fmmq002,fmmq003,fmmq004,fmmqstus, 
                   fmmqownid,fmmqowndp,fmmqcrtid,fmmqcrtdp,fmmqcrtdt,fmmqmodid,fmmqmoddt,fmmqcnfid,fmmqcnfdt) = (g_fmmq_m.fmmqsite, 
                   g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003, 
                   g_fmmq_m.fmmq004,g_fmmq_m.fmmqstus,g_fmmq_m.fmmqownid,g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqcrtid, 
                   g_fmmq_m.fmmqcrtdp,g_fmmq_m.fmmqcrtdt,g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmoddt,g_fmmq_m.fmmqcnfid, 
                   g_fmmq_m.fmmqcnfdt)
                WHERE fmmqent = g_enterprise AND fmmqdocno = g_fmmqdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fmmq_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afmt555_fmmq_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_fmmq_m_t)
               LET g_log2 = util.JSON.stringify(g_fmmq_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_fmmqdocno_t = g_fmmq_m.fmmqdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afmt555.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fmmr_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmmr_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt555_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fmmr_d.getLength()
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
            OPEN afmt555_cl USING g_enterprise,g_fmmq_m.fmmqdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt555_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt555_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmmr_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmmr_d[l_ac].fmmrseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fmmr_d_t.* = g_fmmr_d[l_ac].*  #BACKUP
               LET g_fmmr_d_o.* = g_fmmr_d[l_ac].*  #BACKUP
               CALL afmt555_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afmt555_set_no_entry_b(l_cmd)
               IF NOT afmt555_lock_b("fmmr_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt555_bcl INTO g_fmmr_d[l_ac].fmmrseq,g_fmmr_d[l_ac].fmmr001,g_fmmr_d[l_ac].fmmr002, 
                      g_fmmr_d[l_ac].fmmr003,g_fmmr_d[l_ac].fmmr037,g_fmmr_d[l_ac].fmmr004,g_fmmr_d[l_ac].fmmr005, 
                      g_fmmr_d[l_ac].fmmr006,g_fmmr_d[l_ac].fmmr007,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr009, 
                      g_fmmr_d[l_ac].fmmr010,g_fmmr2_d[l_ac].fmmrseq,g_fmmr2_d[l_ac].fmmr011,g_fmmr2_d[l_ac].fmmr012, 
                      g_fmmr2_d[l_ac].fmmr036,g_fmmr2_d[l_ac].fmmr013,g_fmmr2_d[l_ac].fmmr014,g_fmmr2_d[l_ac].fmmr015, 
                      g_fmmr2_d[l_ac].fmmr016,g_fmmr2_d[l_ac].fmmr017,g_fmmr2_d[l_ac].fmmr018,g_fmmr2_d[l_ac].fmmr019, 
                      g_fmmr2_d[l_ac].fmmr020,g_fmmr2_d[l_ac].fmmr021,g_fmmr2_d[l_ac].fmmr022,g_fmmr2_d[l_ac].fmmr023, 
                      g_fmmr2_d[l_ac].fmmr024,g_fmmr2_d[l_ac].fmmr025,g_fmmr2_d[l_ac].fmmr026,g_fmmr2_d[l_ac].fmmr027, 
                      g_fmmr2_d[l_ac].fmmr028,g_fmmr2_d[l_ac].fmmr029,g_fmmr2_d[l_ac].fmmr030,g_fmmr2_d[l_ac].fmmr031, 
                      g_fmmr2_d[l_ac].fmmr032,g_fmmr2_d[l_ac].fmmr033,g_fmmr2_d[l_ac].fmmr034,g_fmmr2_d[l_ac].fmmr035 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmmr_d_t.fmmrseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmmr_d_mask_o[l_ac].* =  g_fmmr_d[l_ac].*
                  CALL afmt555_fmmr_t_mask()
                  LET g_fmmr_d_mask_n[l_ac].* =  g_fmmr_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt555_show()
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
            INITIALIZE g_fmmr_d[l_ac].* TO NULL 
            INITIALIZE g_fmmr_d_t.* TO NULL 
            INITIALIZE g_fmmr_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_fmmr_d[l_ac].fmmrseq = "0"
      LET g_fmmr_d[l_ac].l_fmmp006 = "0"
      LET g_fmmr_d[l_ac].l_fmmp007 = "0"
      LET g_fmmr_d[l_ac].fmmr037 = "0"
      LET g_fmmr_d[l_ac].fmmr004 = "0"
      LET g_fmmr_d[l_ac].fmmr005 = "0"
      LET g_fmmr_d[l_ac].fmmr006 = "0"
      LET g_fmmr_d[l_ac].fmmr007 = "0"
      LET g_fmmr_d[l_ac].fmmr008 = "0"
      LET g_fmmr_d[l_ac].fmmr009 = "0"
      LET g_fmmr_d[l_ac].fmmr010 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_fmmr_d_t.* = g_fmmr_d[l_ac].*     #新輸入資料
            LET g_fmmr_d_o.* = g_fmmr_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt555_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt555_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmmr_d[li_reproduce_target].* = g_fmmr_d[li_reproduce].*
               LET g_fmmr2_d[li_reproduce_target].* = g_fmmr2_d[li_reproduce].*
 
               LET g_fmmr_d[li_reproduce_target].fmmrseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(fmmrseq) INTO g_fmmr_d[l_ac].fmmrseq
              FROM fmmr_t
             WHERE fmmrent = g_enterprise
               AND fmmrdocno  = g_fmmq_m.fmmqdocno
            IF cl_null(g_fmmr_d[l_ac].fmmrseq)  THEN
               LET g_fmmr_d[l_ac].fmmrseq = '1'
            ELSE
               LET g_fmmr_d[l_ac].fmmrseq = g_fmmr_d[l_ac].fmmrseq +'1'
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
            SELECT COUNT(1) INTO l_count FROM fmmr_t 
             WHERE fmmrent = g_enterprise AND fmmrdocno = g_fmmq_m.fmmqdocno
 
               AND fmmrseq = g_fmmr_d[l_ac].fmmrseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmq_m.fmmqdocno
               LET gs_keys[2] = g_fmmr_d[g_detail_idx].fmmrseq
               CALL afmt555_insert_b('fmmr_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_fmmr_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmmr_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt555_b_fill()
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
               LET gs_keys[01] = g_fmmq_m.fmmqdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_fmmr_d_t.fmmrseq
 
            
               #刪除同層單身
               IF NOT afmt555_delete_b('fmmr_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt555_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt555_key_delete_b(gs_keys,'fmmr_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt555_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               DELETE FROM fmmr_t
                WHERE fmmrent   = g_enterprise
                  AND fmmr002   = g_fmmr_d[l_ac].fmmr002
                  AND fmmrdocno = g_fmmq_m.fmmqdocno

               IF SQLCA.SQLCODE THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt555_bcl
                  CANCEL DELETE
               END IF
               CALL afmt555_b_fill()
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt555_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
            
               #end add-point
               LET l_count = g_fmmr_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmmr_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmrseq
            #add-point:BEFORE FIELD fmmrseq name="input.b.page1.fmmrseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmrseq
            
            #add-point:AFTER FIELD fmmrseq name="input.a.page1.fmmrseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmmq_m.fmmqdocno IS NOT NULL AND g_fmmr_d[g_detail_idx].fmmrseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmmq_m.fmmqdocno != g_fmmqdocno_t OR g_fmmr_d[g_detail_idx].fmmrseq != g_fmmr_d_t.fmmrseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmmr_t WHERE "||"fmmrent = '" ||g_enterprise|| "' AND "||"fmmrdocno = '"||g_fmmq_m.fmmqdocno ||"' AND "|| "fmmrseq = '"||g_fmmr_d[g_detail_idx].fmmrseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmrseq
            #add-point:ON CHANGE fmmrseq name="input.g.page1.fmmrseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr001
            
            #add-point:AFTER FIELD fmmr001 name="input.a.page1.fmmr001"
            #投資組織
            LET g_fmmr_d[l_ac].fmmr001_desc = ' '
            DISPLAY BY NAME g_fmmr_d[l_ac].fmmr001_desc
            IF NOT cl_null(g_fmmr_d[l_ac].fmmr001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmr_d[l_ac].fmmr001 != g_fmmr_d_t.fmmr001 OR g_fmmr_d_t.fmmr001 IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmmr_d[l_ac].fmmr001 != g_fmmr_d_o.fmmr001 OR cl_null(g_fmmr_d_o.fmmr001) THEN                                       #160822-00012#4   add
               CALL s_fin_apcborga_chk(g_fmmq_m.fmmqsite,g_fmmq_m.l_fmmqcomp,g_fmmr_d[l_ac].fmmr001,g_fmmq_m.fmmqdocdt,'6') RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmr_d[l_ac].fmmr001 = g_fmmr_d_t.fmmr001   #160822-00012#4   mark
                     LET g_fmmr_d[l_ac].fmmr001 = g_fmmr_d_o.fmmr001    #160822-00012#4   add
                     CALL s_desc_get_department_desc(g_fmmr_d[l_ac].fmmr001) RETURNING g_fmmr_d[l_ac].fmmr001_desc
                     DISPLAY BY NAME g_fmmr_d[l_ac].fmmr001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_fmmr_d[l_ac].fmmr001_desc = s_desc_get_department_desc(g_fmmr_d[l_ac].fmmr001)
            DISPLAY BY NAME g_fmmr_d[l_ac].fmmr001_desc
            LET g_fmmr_d_o.* = g_fmmr_d[l_ac].*   #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr001
            #add-point:BEFORE FIELD fmmr001 name="input.b.page1.fmmr001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr001
            #add-point:ON CHANGE fmmr001 name="input.g.page1.fmmr001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr002
            #add-point:BEFORE FIELD fmmr002 name="input.b.page1.fmmr002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr002
            
            #add-point:AFTER FIELD fmmr002 name="input.a.page1.fmmr002"
            #投資審核單
            IF NOT cl_null(g_fmmr_d[l_ac].fmmr002) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmr_d[l_ac].fmmr002 != g_fmmr_d_t.fmmr002 OR g_fmmr_d_t.fmmr002 IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmmr_d[l_ac].fmmr002 != g_fmmr_d_o.fmmr002 OR cl_null(g_fmmr_d_o.fmmr002) THEN                                       #160822-00012#4   add
                  CALL afmt555_fmmr002_chk()  RETURNING g_sub_success,g_errno               
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmr_d[l_ac].fmmr002 = g_fmmr_d_t.fmmr002   #160822-00012#4   mark
                     LET g_fmmr_d[l_ac].fmmr002 = g_fmmr_d_o.fmmr002    #160822-00012#4   add
                     NEXT FIELD CURRENT
                  END IF
                  CALL afmt555_fmmr002_info()
               END IF               
            END IF
            LET g_fmmr_d_o.* = g_fmmr_d[l_ac].*   #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr002
            #add-point:ON CHANGE fmmr002 name="input.g.page1.fmmr002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmj004
            #add-point:BEFORE FIELD l_fmmj004 name="input.b.page1.l_fmmj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmj004
            
            #add-point:AFTER FIELD l_fmmj004 name="input.a.page1.l_fmmj004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmj004
            #add-point:ON CHANGE l_fmmj004 name="input.g.page1.l_fmmj004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmp006
            #add-point:BEFORE FIELD l_fmmp006 name="input.b.page1.l_fmmp006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmp006
            
            #add-point:AFTER FIELD l_fmmp006 name="input.a.page1.l_fmmp006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmp006
            #add-point:ON CHANGE l_fmmp006 name="input.g.page1.l_fmmp006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmp007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmr_d[l_ac].l_fmmp007,">=0.000","0","","","azz-00079",1) THEN
               NEXT FIELD l_fmmp007
            END IF 
 
 
 
            #add-point:AFTER FIELD l_fmmp007 name="input.a.page1.l_fmmp007"
            IF NOT cl_null(g_fmmr_d[l_ac].l_fmmp007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmp007
            #add-point:BEFORE FIELD l_fmmp007 name="input.b.page1.l_fmmp007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmp007
            #add-point:ON CHANGE l_fmmp007 name="input.g.page1.l_fmmp007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr037
            #add-point:BEFORE FIELD fmmr037 name="input.b.page1.fmmr037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr037
            
            #add-point:AFTER FIELD fmmr037 name="input.a.page1.fmmr037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr037
            #add-point:ON CHANGE fmmr037 name="input.g.page1.fmmr037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr004
            #add-point:BEFORE FIELD fmmr004 name="input.b.page1.fmmr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr004
            
            #add-point:AFTER FIELD fmmr004 name="input.a.page1.fmmr004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr004
            #add-point:ON CHANGE fmmr004 name="input.g.page1.fmmr004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr005
            #add-point:BEFORE FIELD fmmr005 name="input.b.page1.fmmr005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr005
            
            #add-point:AFTER FIELD fmmr005 name="input.a.page1.fmmr005"
            IF NOT cl_null(g_fmmr_d[l_ac].fmmr005)THEN
              #原幣=本幣  匯率必須為1
               IF g_fmmr_d[l_ac].fmmr003 = g_glaa.glaa001 THEN
                  IF g_fmmr_d[l_ac].fmmr005 <> 1 THEN
                     LET g_fmmr_d[l_ac].fmmr005 = 1
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = 'agl-00327'
                     LET g_errparam.popup = TRUE
                     LET g_errparam.extend = ''
                     CALL cl_err()
                  END IF
               END IF
            
               #取得金額
               CALL s_afm_rate_money(g_fmmq_m.fmmq001,g_fmmr_d[l_ac].fmmr005,g_fmmr_d[l_ac].fmmr007,
                               g_fmmr_d[l_ac].fmmr009,g_fmmr_d[l_ac].fmmr004)   
                   RETURNING g_fmmr_d[l_ac].fmmr006,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr010
               DISPLAY BY NAME g_fmmr_d[l_ac].fmmr006,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr010
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr005
            #add-point:ON CHANGE fmmr005 name="input.g.page1.fmmr005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr006
            #add-point:BEFORE FIELD fmmr006 name="input.b.page1.fmmr006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr006
            
            #add-point:AFTER FIELD fmmr006 name="input.a.page1.fmmr006"
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr006
            #add-point:ON CHANGE fmmr006 name="input.g.page1.fmmr006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr007
            #add-point:BEFORE FIELD fmmr007 name="input.b.page1.fmmr007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr007
            
            #add-point:AFTER FIELD fmmr007 name="input.a.page1.fmmr007"
            IF NOT cl_null(g_fmmr_d[l_ac].fmmr007) THEN
               #原幣=本幣  匯率必須為1
               IF g_fmmr_d[l_ac].fmmr003 = g_glaa.glaa016 THEN
                  IF g_fmmr_d[l_ac].fmmr007 <> 1 THEN
                     LET g_fmmr_d[l_ac].fmmr007 = 1
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = 'agl-00327'
                     LET g_errparam.popup = TRUE
                     LET g_errparam.extend = ''
                     CALL cl_err()
                  END IF
               END IF
            
               #取得金額
               CALL s_afm_rate_money(g_fmmq_m.fmmq001,g_fmmr_d[l_ac].fmmr005,g_fmmr_d[l_ac].fmmr007,
                               g_fmmr_d[l_ac].fmmr009,g_fmmr_d[l_ac].fmmr004)   
                   RETURNING g_fmmr_d[l_ac].fmmr006,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr010
               DISPLAY BY NAME g_fmmr_d[l_ac].fmmr006,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr010
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr007
            #add-point:ON CHANGE fmmr007 name="input.g.page1.fmmr007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr008
            #add-point:BEFORE FIELD fmmr008 name="input.b.page1.fmmr008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr008
            
            #add-point:AFTER FIELD fmmr008 name="input.a.page1.fmmr008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr008
            #add-point:ON CHANGE fmmr008 name="input.g.page1.fmmr008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr009
            #add-point:BEFORE FIELD fmmr009 name="input.b.page1.fmmr009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr009
            
            #add-point:AFTER FIELD fmmr009 name="input.a.page1.fmmr009"
            IF NOT cl_null(g_fmmr_d[l_ac].fmmr009) THEN
                #原幣=本幣  匯率必須為1
               IF g_fmmr_d[l_ac].fmmr003 = g_glaa.glaa020 THEN
                  IF g_fmmr_d[l_ac].fmmr009 <> 1 THEN
                     LET g_fmmr_d[l_ac].fmmr009 = 1
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = 'agl-00327'
                     LET g_errparam.popup = TRUE
                     LET g_errparam.extend = ''
                     CALL cl_err()
                  END IF
               END IF
     
               #取得金額
               CALL s_afm_rate_money(g_fmmq_m.fmmq001,g_fmmr_d[l_ac].fmmr005,g_fmmr_d[l_ac].fmmr007,
                               g_fmmr_d[l_ac].fmmr009,g_fmmr_d[l_ac].fmmr004)   
                   RETURNING g_fmmr_d[l_ac].fmmr006,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr010
               DISPLAY BY NAME g_fmmr_d[l_ac].fmmr006,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr010
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr009
            #add-point:ON CHANGE fmmr009 name="input.g.page1.fmmr009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr010
            #add-point:BEFORE FIELD fmmr010 name="input.b.page1.fmmr010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr010
            
            #add-point:AFTER FIELD fmmr010 name="input.a.page1.fmmr010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr010
            #add-point:ON CHANGE fmmr010 name="input.g.page1.fmmr010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fmmrseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmrseq
            #add-point:ON ACTION controlp INFIELD fmmrseq name="input.c.page1.fmmrseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmr001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr001
            #add-point:ON ACTION controlp INFIELD fmmr001 name="input.c.page1.fmmr001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr_d[l_ac].fmmr001
            LET g_qryparam.where    = " ooef017 ='",g_fmmq_m.l_fmmqcomp,"' AND ooef001 IN ",g_wc_fmmqsite
            #                         " AND ooef206='Y' "   #161006-00005#34   mark    #資金組織
            #CALL q_ooef001()                               #161006-00005#34   mark
            CALL q_ooef001_33()                             #161006-00005#34   add     #呼叫開窗
            LET g_fmmr_d[l_ac].fmmr001 = g_qryparam.return1
            DISPLAY BY NAME g_fmmr_d[l_ac].fmmr001
            NEXT FIELD fmmr001
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmr002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr002
            #add-point:ON ACTION controlp INFIELD fmmr002 name="input.c.page1.fmmr002"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr_d[l_ac].fmmr002             #給予default值
            LET g_qryparam.where    = " fmmpsite ='",g_fmmr_d[l_ac].fmmr001,"' AND fmmpld = '",g_fmmq_m.fmmq001,"' ",
                                      " AND fmmp001 = '",g_fmmq_m.fmmq002,"' AND fmmp002 = '",g_fmmq_m.fmmq003,"'  ",
                                      " AND fmmpstus = 'Y' "
            CALL q_fmmp004()                                #呼叫開窗
            LET g_fmmr_d[l_ac].fmmr002 = g_qryparam.return1
            DISPLAY g_fmmr_d[l_ac].fmmr002 TO fmmr002
            NEXT FIELD fmmr002                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_fmmj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmj004
            #add-point:ON ACTION controlp INFIELD l_fmmj004 name="input.c.page1.l_fmmj004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_fmmp006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmp006
            #add-point:ON ACTION controlp INFIELD l_fmmp006 name="input.c.page1.l_fmmp006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_fmmp007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmp007
            #add-point:ON ACTION controlp INFIELD l_fmmp007 name="input.c.page1.l_fmmp007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmr037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr037
            #add-point:ON ACTION controlp INFIELD fmmr037 name="input.c.page1.fmmr037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmr004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr004
            #add-point:ON ACTION controlp INFIELD fmmr004 name="input.c.page1.fmmr004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmr005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr005
            #add-point:ON ACTION controlp INFIELD fmmr005 name="input.c.page1.fmmr005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmr006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr006
            #add-point:ON ACTION controlp INFIELD fmmr006 name="input.c.page1.fmmr006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmr007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr007
            #add-point:ON ACTION controlp INFIELD fmmr007 name="input.c.page1.fmmr007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmr008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr008
            #add-point:ON ACTION controlp INFIELD fmmr008 name="input.c.page1.fmmr008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmr009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr009
            #add-point:ON ACTION controlp INFIELD fmmr009 name="input.c.page1.fmmr009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmr010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr010
            #add-point:ON ACTION controlp INFIELD fmmr010 name="input.c.page1.fmmr010"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmmr_d[l_ac].* = g_fmmr_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt555_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fmmr_d[l_ac].fmmrseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fmmr_d[l_ac].* = g_fmmr_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afmt555_fmmr_t_mask_restore('restore_mask_o')
      
               UPDATE fmmr_t SET (fmmrdocno,fmmrseq,fmmr001,fmmr002,fmmr003,fmmr037,fmmr004,fmmr005, 
                   fmmr006,fmmr007,fmmr008,fmmr009,fmmr010,fmmr011,fmmr012,fmmr036,fmmr013,fmmr014,fmmr015, 
                   fmmr016,fmmr017,fmmr018,fmmr019,fmmr020,fmmr021,fmmr022,fmmr023,fmmr024,fmmr025,fmmr026, 
                   fmmr027,fmmr028,fmmr029,fmmr030,fmmr031,fmmr032,fmmr033,fmmr034,fmmr035) = (g_fmmq_m.fmmqdocno, 
                   g_fmmr_d[l_ac].fmmrseq,g_fmmr_d[l_ac].fmmr001,g_fmmr_d[l_ac].fmmr002,g_fmmr_d[l_ac].fmmr003, 
                   g_fmmr_d[l_ac].fmmr037,g_fmmr_d[l_ac].fmmr004,g_fmmr_d[l_ac].fmmr005,g_fmmr_d[l_ac].fmmr006, 
                   g_fmmr_d[l_ac].fmmr007,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr009,g_fmmr_d[l_ac].fmmr010, 
                   g_fmmr2_d[l_ac].fmmr011,g_fmmr2_d[l_ac].fmmr012,g_fmmr2_d[l_ac].fmmr036,g_fmmr2_d[l_ac].fmmr013, 
                   g_fmmr2_d[l_ac].fmmr014,g_fmmr2_d[l_ac].fmmr015,g_fmmr2_d[l_ac].fmmr016,g_fmmr2_d[l_ac].fmmr017, 
                   g_fmmr2_d[l_ac].fmmr018,g_fmmr2_d[l_ac].fmmr019,g_fmmr2_d[l_ac].fmmr020,g_fmmr2_d[l_ac].fmmr021, 
                   g_fmmr2_d[l_ac].fmmr022,g_fmmr2_d[l_ac].fmmr023,g_fmmr2_d[l_ac].fmmr024,g_fmmr2_d[l_ac].fmmr025, 
                   g_fmmr2_d[l_ac].fmmr026,g_fmmr2_d[l_ac].fmmr027,g_fmmr2_d[l_ac].fmmr028,g_fmmr2_d[l_ac].fmmr029, 
                   g_fmmr2_d[l_ac].fmmr030,g_fmmr2_d[l_ac].fmmr031,g_fmmr2_d[l_ac].fmmr032,g_fmmr2_d[l_ac].fmmr033, 
                   g_fmmr2_d[l_ac].fmmr034,g_fmmr2_d[l_ac].fmmr035)
                WHERE fmmrent = g_enterprise AND fmmrdocno = g_fmmq_m.fmmqdocno 
 
                  AND fmmrseq = g_fmmr_d_t.fmmrseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmmr_d[l_ac].* = g_fmmr_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmr_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmmr_d[l_ac].* = g_fmmr_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmr_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmq_m.fmmqdocno
               LET gs_keys_bak[1] = g_fmmqdocno_t
               LET gs_keys[2] = g_fmmr_d[g_detail_idx].fmmrseq
               LET gs_keys_bak[2] = g_fmmr_d_t.fmmrseq
               CALL afmt555_update_b('fmmr_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afmt555_fmmr_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fmmr_d[g_detail_idx].fmmrseq = g_fmmr_d_t.fmmrseq 
 
                  ) THEN
                  LET gs_keys[01] = g_fmmq_m.fmmqdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fmmr_d_t.fmmrseq
 
                  CALL afmt555_key_update_b(gs_keys,'fmmr_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmmq_m),util.JSON.stringify(g_fmmr_d_t)
               LET g_log2 = util.JSON.stringify(g_fmmq_m),util.JSON.stringify(g_fmmr_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afmt555_unlock_b("fmmr_t","'1'")
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
               LET g_fmmr_d[li_reproduce_target].* = g_fmmr_d[li_reproduce].*
               LET g_fmmr2_d[li_reproduce_target].* = g_fmmr2_d[li_reproduce].*
 
               LET g_fmmr_d[li_reproduce_target].fmmrseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmmr_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmmr_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_fmmr2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
 
            #end add-point
            
            CALL afmt555_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmmr2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmmr2_d[l_ac].* TO NULL 
            INITIALIZE g_fmmr2_d_t.* TO NULL 
            INITIALIZE g_fmmr2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_fmmr2_d_t.* = g_fmmr2_d[l_ac].*     #新輸入資料
            LET g_fmmr2_d_o.* = g_fmmr2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt555_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt555_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmmr_d[li_reproduce_target].* = g_fmmr_d[li_reproduce].*
               LET g_fmmr2_d[li_reproduce_target].* = g_fmmr2_d[li_reproduce].*
 
               LET g_fmmr2_d[li_reproduce_target].fmmrseq = NULL
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
            OPEN afmt555_cl USING g_enterprise,g_fmmq_m.fmmqdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt555_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt555_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmmr2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmmr2_d[l_ac].fmmrseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmmr2_d_t.* = g_fmmr2_d[l_ac].*  #BACKUP
               LET g_fmmr2_d_o.* = g_fmmr2_d[l_ac].*  #BACKUP
               CALL afmt555_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL afmt555_set_no_entry_b(l_cmd)
               IF NOT afmt555_lock_b("fmmr_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt555_bcl INTO g_fmmr_d[l_ac].fmmrseq,g_fmmr_d[l_ac].fmmr001,g_fmmr_d[l_ac].fmmr002, 
                      g_fmmr_d[l_ac].fmmr003,g_fmmr_d[l_ac].fmmr037,g_fmmr_d[l_ac].fmmr004,g_fmmr_d[l_ac].fmmr005, 
                      g_fmmr_d[l_ac].fmmr006,g_fmmr_d[l_ac].fmmr007,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr009, 
                      g_fmmr_d[l_ac].fmmr010,g_fmmr2_d[l_ac].fmmrseq,g_fmmr2_d[l_ac].fmmr011,g_fmmr2_d[l_ac].fmmr012, 
                      g_fmmr2_d[l_ac].fmmr036,g_fmmr2_d[l_ac].fmmr013,g_fmmr2_d[l_ac].fmmr014,g_fmmr2_d[l_ac].fmmr015, 
                      g_fmmr2_d[l_ac].fmmr016,g_fmmr2_d[l_ac].fmmr017,g_fmmr2_d[l_ac].fmmr018,g_fmmr2_d[l_ac].fmmr019, 
                      g_fmmr2_d[l_ac].fmmr020,g_fmmr2_d[l_ac].fmmr021,g_fmmr2_d[l_ac].fmmr022,g_fmmr2_d[l_ac].fmmr023, 
                      g_fmmr2_d[l_ac].fmmr024,g_fmmr2_d[l_ac].fmmr025,g_fmmr2_d[l_ac].fmmr026,g_fmmr2_d[l_ac].fmmr027, 
                      g_fmmr2_d[l_ac].fmmr028,g_fmmr2_d[l_ac].fmmr029,g_fmmr2_d[l_ac].fmmr030,g_fmmr2_d[l_ac].fmmr031, 
                      g_fmmr2_d[l_ac].fmmr032,g_fmmr2_d[l_ac].fmmr033,g_fmmr2_d[l_ac].fmmr034,g_fmmr2_d[l_ac].fmmr035 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmmr2_d_mask_o[l_ac].* =  g_fmmr2_d[l_ac].*
                  CALL afmt555_fmmr_t_mask()
                  LET g_fmmr2_d_mask_n[l_ac].* =  g_fmmr2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt555_show()
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
               LET gs_keys[01] = g_fmmq_m.fmmqdocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmmr2_d_t.fmmrseq
            
               #刪除同層單身
               IF NOT afmt555_delete_b('fmmr_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt555_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt555_key_delete_b(gs_keys,'fmmr_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt555_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt555_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_fmmr_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmmr2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM fmmr_t 
             WHERE fmmrent = g_enterprise AND fmmrdocno = g_fmmq_m.fmmqdocno
               AND fmmrseq = g_fmmr2_d[l_ac].fmmrseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmq_m.fmmqdocno
               LET gs_keys[2] = g_fmmr2_d[g_detail_idx].fmmrseq
               CALL afmt555_insert_b('fmmr_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmmr_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fmmr_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt555_b_fill()
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
               LET g_fmmr2_d[l_ac].* = g_fmmr2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt555_bcl
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
               LET g_fmmr2_d[l_ac].* = g_fmmr2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL afmt555_fmmr_t_mask_restore('restore_mask_o')
                              
               UPDATE fmmr_t SET (fmmrdocno,fmmrseq,fmmr001,fmmr002,fmmr003,fmmr037,fmmr004,fmmr005, 
                   fmmr006,fmmr007,fmmr008,fmmr009,fmmr010,fmmr011,fmmr012,fmmr036,fmmr013,fmmr014,fmmr015, 
                   fmmr016,fmmr017,fmmr018,fmmr019,fmmr020,fmmr021,fmmr022,fmmr023,fmmr024,fmmr025,fmmr026, 
                   fmmr027,fmmr028,fmmr029,fmmr030,fmmr031,fmmr032,fmmr033,fmmr034,fmmr035) = (g_fmmq_m.fmmqdocno, 
                   g_fmmr_d[l_ac].fmmrseq,g_fmmr_d[l_ac].fmmr001,g_fmmr_d[l_ac].fmmr002,g_fmmr_d[l_ac].fmmr003, 
                   g_fmmr_d[l_ac].fmmr037,g_fmmr_d[l_ac].fmmr004,g_fmmr_d[l_ac].fmmr005,g_fmmr_d[l_ac].fmmr006, 
                   g_fmmr_d[l_ac].fmmr007,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr009,g_fmmr_d[l_ac].fmmr010, 
                   g_fmmr2_d[l_ac].fmmr011,g_fmmr2_d[l_ac].fmmr012,g_fmmr2_d[l_ac].fmmr036,g_fmmr2_d[l_ac].fmmr013, 
                   g_fmmr2_d[l_ac].fmmr014,g_fmmr2_d[l_ac].fmmr015,g_fmmr2_d[l_ac].fmmr016,g_fmmr2_d[l_ac].fmmr017, 
                   g_fmmr2_d[l_ac].fmmr018,g_fmmr2_d[l_ac].fmmr019,g_fmmr2_d[l_ac].fmmr020,g_fmmr2_d[l_ac].fmmr021, 
                   g_fmmr2_d[l_ac].fmmr022,g_fmmr2_d[l_ac].fmmr023,g_fmmr2_d[l_ac].fmmr024,g_fmmr2_d[l_ac].fmmr025, 
                   g_fmmr2_d[l_ac].fmmr026,g_fmmr2_d[l_ac].fmmr027,g_fmmr2_d[l_ac].fmmr028,g_fmmr2_d[l_ac].fmmr029, 
                   g_fmmr2_d[l_ac].fmmr030,g_fmmr2_d[l_ac].fmmr031,g_fmmr2_d[l_ac].fmmr032,g_fmmr2_d[l_ac].fmmr033, 
                   g_fmmr2_d[l_ac].fmmr034,g_fmmr2_d[l_ac].fmmr035) #自訂欄位頁簽
                WHERE fmmrent = g_enterprise AND fmmrdocno = g_fmmq_m.fmmqdocno
                  AND fmmrseq = g_fmmr2_d_t.fmmrseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmmr2_d[l_ac].* = g_fmmr2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmr_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmmr2_d[l_ac].* = g_fmmr2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmr_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmmq_m.fmmqdocno
               LET gs_keys_bak[1] = g_fmmqdocno_t
               LET gs_keys[2] = g_fmmr2_d[g_detail_idx].fmmrseq
               LET gs_keys_bak[2] = g_fmmr2_d_t.fmmrseq
               CALL afmt555_update_b('fmmr_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt555_fmmr_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmmr2_d[g_detail_idx].fmmrseq = g_fmmr2_d_t.fmmrseq 
                  ) THEN
                  LET gs_keys[01] = g_fmmq_m.fmmqdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmmr2_d_t.fmmrseq
                  CALL afmt555_key_update_b(gs_keys,'fmmr_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmmq_m),util.JSON.stringify(g_fmmr2_d_t)
               LET g_log2 = util.JSON.stringify(g_fmmq_m),util.JSON.stringify(g_fmmr2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr011
            #add-point:BEFORE FIELD fmmr011 name="input.b.page2.fmmr011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr011
            
            #add-point:AFTER FIELD fmmr011 name="input.a.page2.fmmr011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr011
            #add-point:ON CHANGE fmmr011 name="input.g.page2.fmmr011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr011_desc
            #add-point:BEFORE FIELD fmmr011_desc name="input.b.page2.fmmr011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr011_desc
            
            #add-point:AFTER FIELD fmmr011_desc name="input.a.page2.fmmr011_desc"
            #公允價值變動科目
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr011_desc) THEN
                #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511203
             LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_fmmq_m.fmmq001,g_fmmr2_d[l_ac].fmmr011_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_fmmq_m.fmmq001
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr011_desc
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_fmmr2_d[l_ac].fmmr011_desc
                LET g_qryparam.arg3 = g_fmmq_m.fmmq001
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               
                LET g_fmmr2_d[l_ac].fmmr011 = g_qryparam.return1
                LET g_fmmr2_d[l_ac].fmmr011_desc = g_qryparam.return1
                DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr011,g_fmmr2_d[l_ac].fmmr011_desc
                
              END IF
              IF  s_aglt310_getlike_lc_subject(g_fmmq_m.fmmq001,g_fmmr2_d[l_ac].fmmr011_desc,l_sql) THEN
                  LET g_fmmr2_d[l_ac].fmmr011      = g_fmmr2_d_t.fmmr011
                        LET g_fmmr2_d[l_ac].fmmr011_desc = g_fmmr2_d_t.fmmr011_desc
                        DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr011,g_fmmr2_d[l_ac].fmmr011_desc
                        NEXT FIELD CURRENT
              END IF
       #  150916-00015#1 END
               IF ( g_fmmr2_d[l_ac].fmmr011_desc != g_fmmr2_d_t.fmmr011_desc OR g_fmmr2_d_t.fmmr011_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr011 = g_fmmr2_d[l_ac].fmmr011_desc
                  IF (g_fmmr2_d[l_ac].fmmr011 != g_fmmr2_d_t.fmmr011 OR g_fmmr2_d_t.fmmr011 IS NULL) THEN
                     CALL s_aap_glac002_chk(g_fmmr2_d[l_ac].fmmr011,g_fmmq_m.fmmq001) RETURNING g_sub_success,g_errno
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
                        LET g_fmmr2_d[l_ac].fmmr011      = g_fmmr2_d_t.fmmr011
                        LET g_fmmr2_d[l_ac].fmmr011_desc = g_fmmr2_d_t.fmmr011_desc
                        DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr011,g_fmmr2_d[l_ac].fmmr011_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr011 = ''
            END IF
            LET g_fmmr2_d_t.fmmr011_desc = g_fmmr2_d[l_ac].fmmr011_desc
            LET g_fmmr2_d[l_ac].fmmr011_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr011,s_desc_get_account_desc(g_fmmq_m.fmmq001,g_fmmr2_d[l_ac].fmmr011))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr011,g_fmmr2_d[l_ac].fmmr011_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr011_desc
            #add-point:ON CHANGE fmmr011_desc name="input.g.page2.fmmr011_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr012
            #add-point:BEFORE FIELD fmmr012 name="input.b.page2.fmmr012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr012
            
            #add-point:AFTER FIELD fmmr012 name="input.a.page2.fmmr012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr012
            #add-point:ON CHANGE fmmr012 name="input.g.page2.fmmr012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr012_desc
            #add-point:BEFORE FIELD fmmr012_desc name="input.b.page2.fmmr012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr012_desc
            
            #add-point:AFTER FIELD fmmr012_desc name="input.a.page2.fmmr012_desc"
            #公允價值變動科目
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr012_desc) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511203
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_fmmq_m.fmmq001,g_fmmr2_d[l_ac].fmmr012_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_fmmq_m.fmmq001
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr012_desc
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_fmmr2_d[l_ac].fmmr012_desc
                LET g_qryparam.arg3 = g_fmmq_m.fmmq001
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
               
          LET g_fmmr2_d[l_ac].fmmr012 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr012_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr012,g_fmmr2_d[l_ac].fmmr012_desc
              END IF
               IF  NOT s_aglt310_lc_subject(g_fmmq_m.fmmq001,g_fmmr2_d[l_ac].fmmr012_desc,'N') THEN
                     LET g_fmmr2_d[l_ac].fmmr012      = g_fmmr2_d_t.fmmr012
                        LET g_fmmr2_d[l_ac].fmmr012_desc = g_fmmr2_d_t.fmmr012_desc
                        DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr012,g_fmmr2_d[l_ac].fmmr012_desc
                        NEXT FIELD CURRENT
               END IF
        #  150916-00015#1 END
               IF ( g_fmmr2_d[l_ac].fmmr012_desc != g_fmmr2_d_t.fmmr012_desc OR g_fmmr2_d_t.fmmr012_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr012 = g_fmmr2_d[l_ac].fmmr012_desc
                  IF (g_fmmr2_d[l_ac].fmmr012 != g_fmmr2_d_t.fmmr012 OR g_fmmr2_d_t.fmmr012 IS NULL) THEN
                     CALL s_aap_glac002_chk(g_fmmr2_d[l_ac].fmmr012,g_fmmq_m.fmmq001) RETURNING g_sub_success,g_errno
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
                        LET g_fmmr2_d[l_ac].fmmr012      = g_fmmr2_d_t.fmmr012
                        LET g_fmmr2_d[l_ac].fmmr012_desc = g_fmmr2_d_t.fmmr012_desc
                        DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr012,g_fmmr2_d[l_ac].fmmr012_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr012 = ''
            END IF
            LET g_fmmr2_d_t.fmmr012_desc = g_fmmr2_d[l_ac].fmmr012_desc
            LET g_fmmr2_d[l_ac].fmmr012_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr012,s_desc_get_account_desc(g_fmmq_m.fmmq001,g_fmmr2_d[l_ac].fmmr012))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr012,g_fmmr2_d[l_ac].fmmr012_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr012_desc
            #add-point:ON CHANGE fmmr012_desc name="input.g.page2.fmmr012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr036
            #add-point:BEFORE FIELD fmmr036 name="input.b.page2.fmmr036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr036
            
            #add-point:AFTER FIELD fmmr036 name="input.a.page2.fmmr036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr036
            #add-point:ON CHANGE fmmr036 name="input.g.page2.fmmr036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr013
            #add-point:BEFORE FIELD fmmr013 name="input.b.page2.fmmr013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr013
            
            #add-point:AFTER FIELD fmmr013 name="input.a.page2.fmmr013"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr013
            #add-point:ON CHANGE fmmr013 name="input.g.page2.fmmr013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr013_desc
            #add-point:BEFORE FIELD fmmr013_desc name="input.b.page2.fmmr013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr013_desc
            
            #add-point:AFTER FIELD fmmr013_desc name="input.a.page2.fmmr013_desc"
            #帳款對象
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr013_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr013_desc != g_fmmr2_d_t.fmmr013_desc OR g_fmmr2_d_t.fmmr013_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr013 = g_fmmr2_d[l_ac].fmmr013_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr013 != g_fmmr2_d_t.fmmr013 OR g_fmmr2_d_t.fmmr013 IS NULL) THEN
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_fmmr2_d[l_ac].fmmr013
                        LET g_chkparam.arg2 = ' '
                        LET g_errshow = TRUE   #160318-00025#49
                        LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"    #160318-00025#49 
                        IF NOT cl_chk_exist("v_pmaa001_2") THEN   #160913-00017#2 mod v_pmaa001_7 -> v_pmaa001_2 
                           LET g_fmmr2_d[l_ac].fmmr013 = g_fmmr2_d_t.fmmr013
                           LET g_fmmr2_d[l_ac].fmmr013_desc = g_fmmr2_d_t.fmmr013_desc
                           #CALL s_desc_get_trading_partner_abbr_desc(g_fmmr2_d[l_ac].fmmr013) RETURNING g_fmmr2_d[l_ac].fmmr013_desc
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr013 ,g_fmmr2_d[l_ac].fmmr013_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr013 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr013_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr013,s_desc_get_trading_partner_abbr_desc(g_fmmr2_d[l_ac].fmmr013))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr013 ,g_fmmr2_d[l_ac].fmmr013_desc
            LET g_fmmr2_d_t.fmmr013_desc = g_fmmr2_d[l_ac].fmmr013_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr013_desc
            #add-point:ON CHANGE fmmr013_desc name="input.g.page2.fmmr013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr014
            #add-point:BEFORE FIELD fmmr014 name="input.b.page2.fmmr014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr014
            
            #add-point:AFTER FIELD fmmr014 name="input.a.page2.fmmr014"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr014
            #add-point:ON CHANGE fmmr014 name="input.g.page2.fmmr014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr014_desc
            #add-point:BEFORE FIELD fmmr014_desc name="input.b.page2.fmmr014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr014_desc
            
            #add-point:AFTER FIELD fmmr014_desc name="input.a.page2.fmmr014_desc"
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr014_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr014_desc != g_fmmr2_d_t.fmmr014_desc OR g_fmmr2_d_t.fmmr014_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr014 = g_fmmr2_d[l_ac].fmmr014_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr014 != g_fmmr2_d_t.fmmr014 OR g_fmmr2_d_t.fmmr014 IS NULL) THEN
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_fmmr2_d[l_ac].fmmr014
                        LET g_chkparam.arg2 = ' '
                        LET g_errshow = TRUE   #160318-00025#49
                        LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"    #160318-00025#49 
                        IF NOT cl_chk_exist("v_pmaa001_7") THEN
                           LET g_fmmr2_d[l_ac].fmmr014 = g_fmmr2_d_t.fmmr014
                           LET g_fmmr2_d[l_ac].fmmr014_desc = g_fmmr2_d_t.fmmr014_desc
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr014 ,g_fmmr2_d[l_ac].fmmr014_desc
                           NEXT FIELD CURRENT
                        END IF

                        #資料邏輯正確性檢查
                        IF g_fmmr2_d[l_ac].fmmr013 != g_fmmr2_d[l_ac].fmmr014 THEN
                           INITIALIZE g_chkparam.* TO NULL
                           LET g_chkparam.arg1 = g_fmmr2_d[l_ac].fmmr013
                           LET g_chkparam.arg2 = g_fmmr2_d[l_ac].fmmr014
                           LET g_errshow = TRUE   #160318-00025#49
                           LET g_chkparam.err_str[1] = "axr-00049:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"    #160318-00025#49
                           IF NOT cl_chk_exist("v_pmac002_4") THEN
                              LET g_fmmr2_d[l_ac].fmmr014 = g_fmmr2_d_t.fmmr014
                              LET g_fmmr2_d[l_ac].fmmr014_desc = g_fmmr2_d_t.fmmr014_desc
                              DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr014 ,g_fmmr2_d[l_ac].fmmr014_desc
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
            LET g_fmmr2_d[l_ac].fmmr014 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr014_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr014,s_desc_get_trading_partner_abbr_desc(g_fmmr2_d[l_ac].fmmr014))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr014 ,g_fmmr2_d[l_ac].fmmr014_desc
            LET g_fmmr2_d_t.fmmr014_desc = g_fmmr2_d[l_ac].fmmr014_desc
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr014_desc
            #add-point:ON CHANGE fmmr014_desc name="input.g.page2.fmmr014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr015
            #add-point:BEFORE FIELD fmmr015 name="input.b.page2.fmmr015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr015
            
            #add-point:AFTER FIELD fmmr015 name="input.a.page2.fmmr015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr015
            #add-point:ON CHANGE fmmr015 name="input.g.page2.fmmr015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr015_desc
            #add-point:BEFORE FIELD fmmr015_desc name="input.b.page2.fmmr015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr015_desc
            
            #add-point:AFTER FIELD fmmr015_desc name="input.a.page2.fmmr015_desc"
            #部門
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr015_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr015_desc != g_fmmr2_d_t.fmmr015_desc OR g_fmmr2_d_t.fmmr015_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr015 = g_fmmr2_d[l_ac].fmmr015_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr015 != g_fmmr2_d_t.fmmr015 OR g_fmmr2_d_t.fmmr015 IS NULL) THEN
                        CALL s_department_chk(g_fmmr2_d[l_ac].fmmr015_desc,g_fmmq_m.fmmqdocdt) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_fmmr2_d[l_ac].fmmr015 = g_fmmr2_d_t.fmmr015
                           LET g_fmmr2_d[l_ac].fmmr015_desc = g_fmmr2_d_t.fmmr015_desc
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr015 ,g_fmmr2_d[l_ac].fmmr015_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  #取責任中心                  
                  CALL s_department_get_respon_center(g_fmmr2_d[l_ac].fmmr015,g_fmmq_m.fmmqdocdt)
                       RETURNING g_sub_success,g_errno,g_fmmr2_d[l_ac].fmmr016,g_fmmr2_d[l_ac].fmmr016_desc
                  LET g_fmmr2_d[l_ac].fmmr016_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr016,g_fmmr2_d[l_ac].fmmr016_desc)
                  LET g_fmmr2_d_t.fmmr016_desc = g_fmmr2_d[l_ac].fmmr016_desc
                  DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr016,g_fmmr2_d[l_ac].fmmr016_desc
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr015 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr015_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr015,s_desc_get_department_desc(g_fmmr2_d[l_ac].fmmr015))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr015 ,g_fmmr2_d[l_ac].fmmr015_desc
            LET g_fmmr2_d_t.fmmr015_desc = g_fmmr2_d[l_ac].fmmr015_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr015_desc
            #add-point:ON CHANGE fmmr015_desc name="input.g.page2.fmmr015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr016
            #add-point:BEFORE FIELD fmmr016 name="input.b.page2.fmmr016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr016
            
            #add-point:AFTER FIELD fmmr016 name="input.a.page2.fmmr016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr016
            #add-point:ON CHANGE fmmr016 name="input.g.page2.fmmr016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr016_desc
            #add-point:BEFORE FIELD fmmr016_desc name="input.b.page2.fmmr016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr016_desc
            
            #add-point:AFTER FIELD fmmr016_desc name="input.a.page2.fmmr016_desc"
            #責任中心
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr016_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr016_desc != g_fmmr2_d_t.fmmr016_desc OR g_fmmr2_d_t.fmmr016_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr016 = g_fmmr2_d[l_ac].fmmr016_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr016 != g_fmmr2_d_t.fmmr016 OR g_fmmr2_d_t.fmmr016 IS NULL) THEN
                        CALL s_voucher_glaq019_chk(g_fmmr2_d[l_ac].fmmr016_desc,g_fmmq_m.fmmqdocdt)
                        IF NOT cl_null(g_errno) THEN
                           LET g_fmmr2_d[l_ac].fmmr016 = g_fmmr2_d_t.fmmr016
                           LET g_fmmr2_d[l_ac].fmmr016_desc = g_fmmr2_d_t.fmmr016_desc
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr016,g_fmmr2_d[l_ac].fmmr016_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr016 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr016_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr016,s_desc_get_department_desc(g_fmmr2_d[l_ac].fmmr016))         
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr016 ,g_fmmr2_d[l_ac].fmmr016_desc
            LET g_fmmr2_d_t.fmmr016_desc = g_fmmr2_d[l_ac].fmmr016_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr016_desc
            #add-point:ON CHANGE fmmr016_desc name="input.g.page2.fmmr016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr017
            #add-point:BEFORE FIELD fmmr017 name="input.b.page2.fmmr017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr017
            
            #add-point:AFTER FIELD fmmr017 name="input.a.page2.fmmr017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr017
            #add-point:ON CHANGE fmmr017 name="input.g.page2.fmmr017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr017_desc
            #add-point:BEFORE FIELD fmmr017_desc name="input.b.page2.fmmr017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr017_desc
            
            #add-point:AFTER FIELD fmmr017_desc name="input.a.page2.fmmr017_desc"
            #區域
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr017_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr017_desc != g_fmmr2_d_t.fmmr017_desc OR g_fmmr2_d_t.fmmr017_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr017 = g_fmmr2_d[l_ac].fmmr017_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr017 != g_fmmr2_d_t.fmmr017 OR g_fmmr2_d_t.fmmr017 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('287',g_fmmr2_d[l_ac].fmmr017) THEN
                           LET g_fmmr2_d[l_ac].fmmr017 = g_fmmr2_d_t.fmmr017
                           LET g_fmmr2_d[l_ac].fmmr017_desc = g_fmmr2_d_t.fmmr017_desc
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr017 ,g_fmmr2_d[l_ac].fmmr017_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            LET g_fmmr2_d[l_ac].fmmr017_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr017,s_desc_get_acc_desc('287',g_fmmr2_d[l_ac].fmmr017))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr017 ,g_fmmr2_d[l_ac].fmmr017_desc
            LET g_fmmr2_d_t.fmmr017_desc = g_fmmr2_d[l_ac].fmmr017_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr017_desc
            #add-point:ON CHANGE fmmr017_desc name="input.g.page2.fmmr017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr018
            #add-point:BEFORE FIELD fmmr018 name="input.b.page2.fmmr018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr018
            
            #add-point:AFTER FIELD fmmr018 name="input.a.page2.fmmr018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr018
            #add-point:ON CHANGE fmmr018 name="input.g.page2.fmmr018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr018_desc
            #add-point:BEFORE FIELD fmmr018_desc name="input.b.page2.fmmr018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr018_desc
            
            #add-point:AFTER FIELD fmmr018_desc name="input.a.page2.fmmr018_desc"
            #客群
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr018_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr018_desc != g_fmmr2_d_t.fmmr018_desc OR g_fmmr2_d_t.fmmr018_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr018 = g_fmmr2_d[l_ac].fmmr018_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr018 != g_fmmr2_d_t.fmmr018 OR g_fmmr2_d_t.fmmr018 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('281',g_fmmr2_d[l_ac].fmmr018) THEN
                           LET g_fmmr2_d[l_ac].fmmr018 = g_fmmr2_d_t.fmmr018
                           LET g_fmmr2_d[l_ac].fmmr018_desc = g_fmmr2_d_t.fmmr018_desc
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr018 ,g_fmmr2_d[l_ac].fmmr018_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr018 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr018_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr018,s_desc_get_acc_desc('281',g_fmmr2_d[l_ac].fmmr018))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr018 ,g_fmmr2_d[l_ac].fmmr018_desc
            LET g_fmmr2_d_t.fmmr018_desc = g_fmmr2_d[l_ac].fmmr018_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr018_desc
            #add-point:ON CHANGE fmmr018_desc name="input.g.page2.fmmr018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr019
            #add-point:BEFORE FIELD fmmr019 name="input.b.page2.fmmr019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr019
            
            #add-point:AFTER FIELD fmmr019 name="input.a.page2.fmmr019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr019
            #add-point:ON CHANGE fmmr019 name="input.g.page2.fmmr019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr019_desc
            #add-point:BEFORE FIELD fmmr019_desc name="input.b.page2.fmmr019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr019_desc
            
            #add-point:AFTER FIELD fmmr019_desc name="input.a.page2.fmmr019_desc"
            #產品類別
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr019_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr019_desc != g_fmmr2_d_t.fmmr019_desc OR g_fmmr2_d_t.fmmr019_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr019 = g_fmmr2_d[l_ac].fmmr019_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr019 != g_fmmr2_d_t.fmmr019 OR g_fmmr2_d_t.fmmr019 IS NULL) THEN
                        CALL s_voucher_glaq024_chk(g_fmmr2_d[l_ac].fmmr019) 
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
                           LET g_fmmr2_d[l_ac].fmmr019 = g_fmmr2_d_t.fmmr019
                           LET g_fmmr2_d[l_ac].fmmr019_desc = g_fmmr2_d_t.fmmr019_desc
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr019 ,g_fmmr2_d[l_ac].fmmr019_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr019 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr019_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr019,s_desc_get_rtaxl003_desc(g_fmmr2_d[l_ac].fmmr019))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr019 ,g_fmmr2_d[l_ac].fmmr019_desc
            LET g_fmmr2_d_t.fmmr019_desc = g_fmmr2_d[l_ac].fmmr019_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr019_desc
            #add-point:ON CHANGE fmmr019_desc name="input.g.page2.fmmr019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr020
            #add-point:BEFORE FIELD fmmr020 name="input.b.page2.fmmr020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr020
            
            #add-point:AFTER FIELD fmmr020 name="input.a.page2.fmmr020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr020
            #add-point:ON CHANGE fmmr020 name="input.g.page2.fmmr020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr020_desc
            #add-point:BEFORE FIELD fmmr020_desc name="input.b.page2.fmmr020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr020_desc
            
            #add-point:AFTER FIELD fmmr020_desc name="input.a.page2.fmmr020_desc"
           #人員
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr020_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr020_desc != g_fmmr2_d_t.fmmr020_desc OR g_fmmr2_d_t.fmmr020_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr020 = g_fmmr2_d[l_ac].fmmr020_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr020 != g_fmmr2_d_t.fmmr020 OR g_fmmr2_d_t.fmmr020 IS NULL) THEN
                        CALL s_employee_chk(g_fmmr2_d[l_ac].fmmr020_desc) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_fmmr2_d[l_ac].fmmr020 = g_fmmr2_d_t.fmmr020
                           LET g_fmmr2_d[l_ac].fmmr020_desc = g_fmmr2_d_t.fmmr020_desc
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr020,g_fmmr2_d[l_ac].fmmr020_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr020 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr020_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr020,s_desc_get_person_desc(g_fmmr2_d[l_ac].fmmr020))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr020,g_fmmr2_d[l_ac].fmmr020_desc
            LET g_fmmr2_d_t.fmmr020_desc = g_fmmr2_d[l_ac].fmmr020_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr020_desc
            #add-point:ON CHANGE fmmr020_desc name="input.g.page2.fmmr020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr021
            #add-point:BEFORE FIELD fmmr021 name="input.b.page2.fmmr021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr021
            
            #add-point:AFTER FIELD fmmr021 name="input.a.page2.fmmr021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr021
            #add-point:ON CHANGE fmmr021 name="input.g.page2.fmmr021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr021_desc
            #add-point:BEFORE FIELD fmmr021_desc name="input.b.page2.fmmr021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr021_desc
            
            #add-point:AFTER FIELD fmmr021_desc name="input.a.page2.fmmr021_desc"
            #專案代號
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr021_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr021_desc != g_fmmr2_d_t.fmmr021_desc OR g_fmmr2_d_t.fmmr021_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr021 = g_fmmr2_d[l_ac].fmmr021_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr021 != g_fmmr2_d_t.fmmr021 OR g_fmmr2_d_t.fmmr021 IS NULL) THEN
                        CALL s_aap_project_chk( g_fmmr2_d[l_ac].fmmr021) RETURNING g_sub_success,g_errno
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
                           LET g_fmmr2_d[l_ac].fmmr021      = g_fmmr2_d_t.fmmr021
                           LET g_fmmr2_d[l_ac].fmmr021_desc = g_fmmr2_d_t.fmmr021_desc
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr021,g_fmmr2_d[l_ac].fmmr021_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr021 = ''                 
            END IF
            LET g_fmmr2_d[l_ac].fmmr021_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr021,s_desc_get_project_desc(g_fmmr2_d[l_ac].fmmr021))
            LET g_fmmr2_d_t.fmmr021 = g_fmmr2_d[l_ac].fmmr021_desc
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr021,g_fmmr2_d[l_ac].fmmr021_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr021_desc
            #add-point:ON CHANGE fmmr021_desc name="input.g.page2.fmmr021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr022
            #add-point:BEFORE FIELD fmmr022 name="input.b.page2.fmmr022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr022
            
            #add-point:AFTER FIELD fmmr022 name="input.a.page2.fmmr022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr022
            #add-point:ON CHANGE fmmr022 name="input.g.page2.fmmr022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr022_desc
            #add-point:BEFORE FIELD fmmr022_desc name="input.b.page2.fmmr022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr022_desc
            
            #add-point:AFTER FIELD fmmr022_desc name="input.a.page2.fmmr022_desc"
            #WBS
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr022_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr022_desc != g_fmmr2_d_t.fmmr022_desc OR g_fmmr2_d_t.fmmr022_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr022 = g_fmmr2_d[l_ac].fmmr022_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr022 != g_fmmr2_d_t.fmmr022 OR g_fmmr2_d_t.fmmr022 IS NULL) THEN
                        CALL s_voucher_glaq028_chk(g_fmmr2_d[l_ac].fmmr021,g_fmmr2_d[l_ac].fmmr022)
                        IF NOT cl_null(g_errno) THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_fmmr2_d[l_ac].fmmr022      = g_fmmr2_d_t.fmmr022
                           LET g_fmmr2_d[l_ac].fmmr022_desc = g_fmmr2_d_t.fmmr022_desc
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr022,g_fmmr2_d[l_ac].fmmr022_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr022 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr022_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr022,s_desc_get_pjbbl004_desc(g_fmmr2_d[l_ac].fmmr021,g_fmmr2_d[l_ac].fmmr022))
            LET g_fmmr2_d_t.fmmr022 = g_fmmr2_d[l_ac].fmmr022_desc
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr022,g_fmmr2_d[l_ac].fmmr022_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr022_desc
            #add-point:ON CHANGE fmmr022_desc name="input.g.page2.fmmr022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr023
            #add-point:BEFORE FIELD fmmr023 name="input.b.page2.fmmr023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr023
            
            #add-point:AFTER FIELD fmmr023 name="input.a.page2.fmmr023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr023
            #add-point:ON CHANGE fmmr023 name="input.g.page2.fmmr023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr023_desc
            #add-point:BEFORE FIELD fmmr023_desc name="input.b.page2.fmmr023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr023_desc
            
            #add-point:AFTER FIELD fmmr023_desc name="input.a.page2.fmmr023_desc"
            #經營方式
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr023_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr023_desc != g_fmmr2_d_t.fmmr023_desc OR g_fmmr2_d_t.fmmr023_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr023 = g_fmmr2_d[l_ac].fmmr023_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr023 != g_fmmr2_d_t.fmmr023 OR g_fmmr2_d_t.fmmr023 IS NULL) THEN
                        CALL s_voucher_glaq051_chk(g_fmmr2_d[l_ac].fmmr023) 
                        IF NOT g_sub_success THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_fmmr2_d[l_ac].fmmr023      = g_fmmr2_d_t.fmmr023
                           LET g_fmmr2_d[l_ac].fmmr023_desc = g_fmmr2_d_t.fmmr023_desc
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr023,g_fmmr2_d[l_ac].fmmr023_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr023 = ''
            END IF
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr023 ,g_fmmr2_d[l_ac].fmmr023_desc
            LET g_fmmr2_d_t.fmmr023_desc = g_fmmr2_d[l_ac].fmmr023_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr023_desc
            #add-point:ON CHANGE fmmr023_desc name="input.g.page2.fmmr023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr024
            #add-point:BEFORE FIELD fmmr024 name="input.b.page2.fmmr024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr024
            
            #add-point:AFTER FIELD fmmr024 name="input.a.page2.fmmr024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr024
            #add-point:ON CHANGE fmmr024 name="input.g.page2.fmmr024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr024_desc
            #add-point:BEFORE FIELD fmmr024_desc name="input.b.page2.fmmr024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr024_desc
            
            #add-point:AFTER FIELD fmmr024_desc name="input.a.page2.fmmr024_desc"
            #渠道
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr024_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr024_desc != g_fmmr2_d_t.fmmr024_desc OR g_fmmr2_d_t.fmmr024_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr024 = g_fmmr2_d[l_ac].fmmr024_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     CALL s_voucher_glaq052_chk(g_fmmr2_d[l_ac].fmmr024)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_fmmr2_d[l_ac].fmmr024 = g_fmmr2_d_t.fmmr024
                        LET g_fmmr2_d[l_ac].fmmr024_desc = g_fmmr2_d_t.fmmr024_desc
                        DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr024,g_fmmr2_d[l_ac].fmmr024_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr024 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr024_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr024,s_desc_get_oojdl003_desc(g_fmmr2_d[l_ac].fmmr024))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr024,g_fmmr2_d[l_ac].fmmr024_desc
            LET g_fmmr2_d_t.fmmr024_desc = g_fmmr2_d[l_ac].fmmr024_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr024_desc
            #add-point:ON CHANGE fmmr024_desc name="input.g.page2.fmmr024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr025
            #add-point:BEFORE FIELD fmmr025 name="input.b.page2.fmmr025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr025
            
            #add-point:AFTER FIELD fmmr025 name="input.a.page2.fmmr025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr025
            #add-point:ON CHANGE fmmr025 name="input.g.page2.fmmr025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr025_desc
            #add-point:BEFORE FIELD fmmr025_desc name="input.b.page2.fmmr025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr025_desc
            
            #add-point:AFTER FIELD fmmr025_desc name="input.a.page2.fmmr025_desc"
            #品牌
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr025_desc) THEN
               IF ( g_fmmr2_d[l_ac].fmmr025_desc != g_fmmr2_d_t.fmmr025_desc OR g_fmmr2_d_t.fmmr025_desc IS NULL ) THEN
                  LET g_fmmr2_d[l_ac].fmmr025 = g_fmmr2_d[l_ac].fmmr025_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF NOT s_azzi650_chk_exist('2002',g_fmmr2_d[l_ac].fmmr025) THEN
                        LET g_fmmr2_d[l_ac].fmmr025      = g_fmmr2_d_t.fmmr025
                        LET g_fmmr2_d[l_ac].fmmr025_desc = g_fmmr2_d_t.fmmr025_desc
                        DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr025 ,g_fmmr2_d[l_ac].fmmr025_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr025 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr025_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr025,s_desc_get_acc_desc('2002',g_fmmr2_d[l_ac].fmmr025))      
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr025 ,g_fmmr2_d[l_ac].fmmr025_desc
            LET g_fmmr2_d_t.fmmr025_desc = g_fmmr2_d[l_ac].fmmr025_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr025_desc
            #add-point:ON CHANGE fmmr025_desc name="input.g.page2.fmmr025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr026
            #add-point:BEFORE FIELD fmmr026 name="input.b.page2.fmmr026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr026
            
            #add-point:AFTER FIELD fmmr026 name="input.a.page2.fmmr026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr026
            #add-point:ON CHANGE fmmr026 name="input.g.page2.fmmr026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr026_desc
            #add-point:BEFORE FIELD fmmr026_desc name="input.b.page2.fmmr026_desc"
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_fmmr2_d[l_ac].fmmr026_desc = g_fmmr2_d[l_ac].fmmr026
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr026_desc
            
            #add-point:AFTER FIELD fmmr026_desc name="input.a.page2.fmmr026_desc"
             #自由核算項一
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr026_desc) THEN
               IF (g_fmmr2_d[l_ac].fmmr026_desc != g_fmmr2_d_t.fmmr026_desc OR g_fmmr2_d_t.fmmr026_desc IS NULL) THEN
                  LET g_fmmr2_d[l_ac].fmmr026 = g_fmmr2_d[l_ac].fmmr026_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr026 != g_fmmr2_d_t.fmmr026 OR g_fmmr2_d_t.fmmr026 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_fmmr2_d[l_ac].fmmr026,g_glad.glad0172) RETURNING g_errno
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
                           LET g_fmmr2_d[l_ac].fmmr026 = g_fmmr2_d_t.fmmr026
                           LET g_fmmr2_d[l_ac].fmmr026_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr026,s_fin_get_accting_desc(g_glad.glad0171,g_fmmr2_d[l_ac].fmmr026))
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr026_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr026 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr026_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr026,s_fin_get_accting_desc(g_glad.glad0171,g_fmmr2_d[l_ac].fmmr026))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr026_desc
            LET g_fmmr2_d_t.fmmr026_desc = g_fmmr2_d[l_ac].fmmr026_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr026_desc
            #add-point:ON CHANGE fmmr026_desc name="input.g.page2.fmmr026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr027
            #add-point:BEFORE FIELD fmmr027 name="input.b.page2.fmmr027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr027
            
            #add-point:AFTER FIELD fmmr027 name="input.a.page2.fmmr027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr027
            #add-point:ON CHANGE fmmr027 name="input.g.page2.fmmr027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr027_desc
            #add-point:BEFORE FIELD fmmr027_desc name="input.b.page2.fmmr027_desc"
            #自由核算項二
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_fmmr2_d[l_ac].fmmr027_desc = g_fmmr2_d[l_ac].fmmr027
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr027_desc
            
            #add-point:AFTER FIELD fmmr027_desc name="input.a.page2.fmmr027_desc"
            #自由核算項二
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr027_desc) THEN
               IF (g_fmmr2_d[l_ac].fmmr027_desc != g_fmmr2_d_t.fmmr027_desc OR g_fmmr2_d_t.fmmr027_desc IS NULL) THEN
                  LET g_fmmr2_d[l_ac].fmmr027 = g_fmmr2_d[l_ac].fmmr027_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr027 != g_fmmr2_d_t.fmmr027 OR g_fmmr2_d_t.fmmr027 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_fmmr2_d[l_ac].fmmr027,g_glad.glad0182) RETURNING g_errno
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
                           LET g_fmmr2_d[l_ac].fmmr027 = g_fmmr2_d_t.fmmr027
                           LET g_fmmr2_d[l_ac].fmmr027_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr027,s_fin_get_accting_desc(g_glad.glad0181,g_fmmr2_d[l_ac].fmmr027))
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr027_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr027 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr027_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr027,s_fin_get_accting_desc(g_glad.glad0181,g_fmmr2_d[l_ac].fmmr027))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr027_desc 
            LET g_fmmr2_d_t.fmmr027_desc = g_fmmr2_d[l_ac].fmmr027_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr027_desc
            #add-point:ON CHANGE fmmr027_desc name="input.g.page2.fmmr027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr028
            #add-point:BEFORE FIELD fmmr028 name="input.b.page2.fmmr028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr028
            
            #add-point:AFTER FIELD fmmr028 name="input.a.page2.fmmr028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr028
            #add-point:ON CHANGE fmmr028 name="input.g.page2.fmmr028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr028_desc
            #add-point:BEFORE FIELD fmmr028_desc name="input.b.page2.fmmr028_desc"
            #自由核算項三
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_fmmr2_d[l_ac].fmmr028_desc = g_fmmr2_d[l_ac].fmmr028
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr028_desc
            
            #add-point:AFTER FIELD fmmr028_desc name="input.a.page2.fmmr028_desc"
            #自由核算項三
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr028_desc) THEN
               IF (g_fmmr2_d[l_ac].fmmr028_desc != g_fmmr2_d_t.fmmr028_desc OR g_fmmr2_d_t.fmmr028_desc IS NULL) THEN
                  LET g_fmmr2_d[l_ac].fmmr028 = g_fmmr2_d[l_ac].fmmr028_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr028 != g_fmmr2_d_t.fmmr028 OR g_fmmr2_d_t.fmmr028 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_fmmr2_d[l_ac].fmmr028,g_glad.glad0192) RETURNING g_errno
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
                           LET g_fmmr2_d[l_ac].fmmr028 = g_fmmr2_d_t.fmmr028
                           LET g_fmmr2_d[l_ac].fmmr028_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr028,s_fin_get_accting_desc(g_glad.glad0191,g_fmmr2_d[l_ac].fmmr028))
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr028_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr028 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr028_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr028,s_fin_get_accting_desc(g_glad.glad0191,g_fmmr2_d[l_ac].fmmr028))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr028_desc 
            LET g_fmmr2_d_t.fmmr028_desc = g_fmmr2_d[l_ac].fmmr028_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr028_desc
            #add-point:ON CHANGE fmmr028_desc name="input.g.page2.fmmr028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr029
            #add-point:BEFORE FIELD fmmr029 name="input.b.page2.fmmr029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr029
            
            #add-point:AFTER FIELD fmmr029 name="input.a.page2.fmmr029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr029
            #add-point:ON CHANGE fmmr029 name="input.g.page2.fmmr029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr029_desc
            #add-point:BEFORE FIELD fmmr029_desc name="input.b.page2.fmmr029_desc"
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_fmmr2_d[l_ac].fmmr029_desc = g_fmmr2_d[l_ac].fmmr029
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr029_desc
            
            #add-point:AFTER FIELD fmmr029_desc name="input.a.page2.fmmr029_desc"
            #自由核算項四
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr029_desc) THEN
               IF (g_fmmr2_d[l_ac].fmmr029_desc != g_fmmr2_d_t.fmmr029_desc OR g_fmmr2_d_t.fmmr029_desc IS NULL) THEN
                  LET g_fmmr2_d[l_ac].fmmr029 = g_fmmr2_d[l_ac].fmmr029_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr029 != g_fmmr2_d_t.fmmr029 OR g_fmmr2_d_t.fmmr029 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_fmmr2_d[l_ac].fmmr029,g_glad.glad0202) RETURNING g_errno
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
                           LET g_fmmr2_d[l_ac].fmmr029 = g_fmmr2_d_t.fmmr029
                           LET g_fmmr2_d[l_ac].fmmr029_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr029,s_fin_get_accting_desc(g_glad.glad0201,g_fmmr2_d[l_ac].fmmr029))
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr029_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr029 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr029_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr029,s_fin_get_accting_desc(g_glad.glad0201,g_fmmr2_d[l_ac].fmmr029))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr029_desc 
            LET g_fmmr2_d_t.fmmr029_desc = g_fmmr2_d[l_ac].fmmr029_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr029_desc
            #add-point:ON CHANGE fmmr029_desc name="input.g.page2.fmmr029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr030
            #add-point:BEFORE FIELD fmmr030 name="input.b.page2.fmmr030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr030
            
            #add-point:AFTER FIELD fmmr030 name="input.a.page2.fmmr030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr030
            #add-point:ON CHANGE fmmr030 name="input.g.page2.fmmr030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr030_desc
            #add-point:BEFORE FIELD fmmr030_desc name="input.b.page2.fmmr030_desc"
            #自由核算項五
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_fmmr2_d[l_ac].fmmr030_desc = g_fmmr2_d[l_ac].fmmr030
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr030_desc
            
            #add-point:AFTER FIELD fmmr030_desc name="input.a.page2.fmmr030_desc"
            #自由核算項五
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr030_desc) THEN
               IF (g_fmmr2_d[l_ac].fmmr030_desc != g_fmmr2_d_t.fmmr030_desc OR g_fmmr2_d_t.fmmr030_desc IS NULL) THEN
                  LET g_fmmr2_d[l_ac].fmmr030 = g_fmmr2_d[l_ac].fmmr030_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr030 != g_fmmr2_d_t.fmmr030 OR g_fmmr2_d_t.fmmr030 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_fmmr2_d[l_ac].fmmr030,g_glad.glad0212) RETURNING g_errno
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
                           LET g_fmmr2_d[l_ac].fmmr030 = g_fmmr2_d_t.fmmr030
                           LET g_fmmr2_d[l_ac].fmmr030_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr030,s_fin_get_accting_desc(g_glad.glad0211,g_fmmr2_d[l_ac].fmmr030))
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr030_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr030 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr030_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr030,s_fin_get_accting_desc(g_glad.glad0211,g_fmmr2_d[l_ac].fmmr030))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr030_desc
            LET g_fmmr2_d_t.fmmr030_desc = g_fmmr2_d[l_ac].fmmr030_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr030_desc
            #add-point:ON CHANGE fmmr030_desc name="input.g.page2.fmmr030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr031
            #add-point:BEFORE FIELD fmmr031 name="input.b.page2.fmmr031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr031
            
            #add-point:AFTER FIELD fmmr031 name="input.a.page2.fmmr031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr031
            #add-point:ON CHANGE fmmr031 name="input.g.page2.fmmr031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr031_desc
            #add-point:BEFORE FIELD fmmr031_desc name="input.b.page2.fmmr031_desc"
            #自由核算項六
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_fmmr2_d[l_ac].fmmr031_desc = g_fmmr2_d[l_ac].fmmr031
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr031_desc
            
            #add-point:AFTER FIELD fmmr031_desc name="input.a.page2.fmmr031_desc"
            #自由核算項六
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr031_desc) THEN
               IF (g_fmmr2_d[l_ac].fmmr031_desc != g_fmmr2_d_t.fmmr031_desc OR g_fmmr2_d_t.fmmr031_desc IS NULL) THEN
                  LET g_fmmr2_d[l_ac].fmmr031 = g_fmmr2_d[l_ac].fmmr031_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr031 != g_fmmr2_d_t.fmmr031 OR g_fmmr2_d_t.fmmr031 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_fmmr2_d[l_ac].fmmr031,g_glad.glad0222) RETURNING g_errno
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
                           LET g_fmmr2_d[l_ac].fmmr031 = g_fmmr2_d_t.fmmr031
                           LET g_fmmr2_d[l_ac].fmmr031_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr031,s_fin_get_accting_desc(g_glad.glad0221,g_fmmr2_d[l_ac].fmmr031))
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr031_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr031 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr031_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr031,s_fin_get_accting_desc(g_glad.glad0221,g_fmmr2_d[l_ac].fmmr031))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr031_desc 
            LET g_fmmr2_d_t.fmmr031_desc = g_fmmr2_d[l_ac].fmmr031_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr031_desc
            #add-point:ON CHANGE fmmr031_desc name="input.g.page2.fmmr031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr032
            #add-point:BEFORE FIELD fmmr032 name="input.b.page2.fmmr032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr032
            
            #add-point:AFTER FIELD fmmr032 name="input.a.page2.fmmr032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr032
            #add-point:ON CHANGE fmmr032 name="input.g.page2.fmmr032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr032_desc
            #add-point:BEFORE FIELD fmmr032_desc name="input.b.page2.fmmr032_desc"
            #自由核算項七
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_fmmr2_d[l_ac].fmmr032_desc = g_fmmr2_d[l_ac].fmmr032
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr032_desc
            
            #add-point:AFTER FIELD fmmr032_desc name="input.a.page2.fmmr032_desc"
            #自由核算項七
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr032_desc) THEN
               IF (g_fmmr2_d[l_ac].fmmr032_desc != g_fmmr2_d_t.fmmr032_desc OR g_fmmr2_d_t.fmmr032_desc IS NULL) THEN
                  LET g_fmmr2_d[l_ac].fmmr032 = g_fmmr2_d[l_ac].fmmr032_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr032 != g_fmmr2_d_t.fmmr032 OR g_fmmr2_d_t.fmmr032 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0231,g_fmmr2_d[l_ac].fmmr032,g_glad.glad0232) RETURNING g_errno
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
                           LET g_fmmr2_d[l_ac].fmmr032 = g_fmmr2_d_t.fmmr032
                           LET g_fmmr2_d[l_ac].fmmr032_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr032,s_fin_get_accting_desc(g_glad.glad0231,g_fmmr2_d[l_ac].fmmr032))
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr032_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr032 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr032_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr032,s_fin_get_accting_desc(g_glad.glad0231,g_fmmr2_d[l_ac].fmmr032))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr032_desc 
            LET g_fmmr2_d_t.fmmr032_desc = g_fmmr2_d[l_ac].fmmr032_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr032_desc
            #add-point:ON CHANGE fmmr032_desc name="input.g.page2.fmmr032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr033
            #add-point:BEFORE FIELD fmmr033 name="input.b.page2.fmmr033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr033
            
            #add-point:AFTER FIELD fmmr033 name="input.a.page2.fmmr033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr033
            #add-point:ON CHANGE fmmr033 name="input.g.page2.fmmr033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr033_desc
            #add-point:BEFORE FIELD fmmr033_desc name="input.b.page2.fmmr033_desc"
            #自由核算項八
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_fmmr2_d[l_ac].fmmr033_desc = g_fmmr2_d[l_ac].fmmr033
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr033_desc
            
            #add-point:AFTER FIELD fmmr033_desc name="input.a.page2.fmmr033_desc"
             #自由核算項八
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr033_desc) THEN
               IF (g_fmmr2_d[l_ac].fmmr033_desc != g_fmmr2_d_t.fmmr033_desc OR g_fmmr2_d_t.fmmr033_desc IS NULL) THEN
                  LET g_fmmr2_d[l_ac].fmmr033 = g_fmmr2_d[l_ac].fmmr033_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr033 != g_fmmr2_d_t.fmmr033 OR g_fmmr2_d_t.fmmr033 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_fmmr2_d[l_ac].fmmr033,g_glad.glad0242) RETURNING g_errno
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
                           LET g_fmmr2_d[l_ac].fmmr033 = g_fmmr2_d_t.fmmr033
                           LET g_fmmr2_d[l_ac].fmmr033_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr033,s_fin_get_accting_desc(g_glad.glad0241,g_fmmr2_d[l_ac].fmmr033))
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr033_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr033 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr033_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr033,s_fin_get_accting_desc(g_glad.glad0241,g_fmmr2_d[l_ac].fmmr033))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr033_desc
            LET g_fmmr2_d_t.fmmr033_desc = g_fmmr2_d[l_ac].fmmr033_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr033_desc
            #add-point:ON CHANGE fmmr033_desc name="input.g.page2.fmmr033_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr034
            #add-point:BEFORE FIELD fmmr034 name="input.b.page2.fmmr034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr034
            
            #add-point:AFTER FIELD fmmr034 name="input.a.page2.fmmr034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr034
            #add-point:ON CHANGE fmmr034 name="input.g.page2.fmmr034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr034_desc
            #add-point:BEFORE FIELD fmmr034_desc name="input.b.page2.fmmr034_desc"
            #自由核算項九
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_fmmr2_d[l_ac].fmmr034_desc = g_fmmr2_d[l_ac].fmmr034
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr034_desc
            
            #add-point:AFTER FIELD fmmr034_desc name="input.a.page2.fmmr034_desc"
            #自由核算項九
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr034_desc) THEN
               IF (g_fmmr2_d[l_ac].fmmr034_desc != g_fmmr2_d_t.fmmr034_desc OR g_fmmr2_d_t.fmmr034_desc IS NULL) THEN
                  LET g_fmmr2_d[l_ac].fmmr034 = g_fmmr2_d[l_ac].fmmr034_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr034 != g_fmmr2_d_t.fmmr034 OR g_fmmr2_d_t.fmmr034 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_fmmr2_d[l_ac].fmmr034,g_glad.glad0252) RETURNING g_errno
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
                           LET g_fmmr2_d[l_ac].fmmr034 = g_fmmr2_d_t.fmmr034
                           LET g_fmmr2_d[l_ac].fmmr034_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr034,s_fin_get_accting_desc(g_glad.glad0251,g_fmmr2_d[l_ac].fmmr034))
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr034_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr034 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr034_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr034,s_fin_get_accting_desc(g_glad.glad0251,g_fmmr2_d[l_ac].fmmr034))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr034_desc
            LET g_fmmr2_d_t.fmmr034_desc = g_fmmr2_d[l_ac].fmmr034_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr034_desc
            #add-point:ON CHANGE fmmr034_desc name="input.g.page2.fmmr034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr035
            #add-point:BEFORE FIELD fmmr035 name="input.b.page2.fmmr035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr035
            
            #add-point:AFTER FIELD fmmr035 name="input.a.page2.fmmr035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr035
            #add-point:ON CHANGE fmmr035 name="input.g.page2.fmmr035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmr035_desc
            #add-point:BEFORE FIELD fmmr035_desc name="input.b.page2.fmmr035_desc"
            #自由核算項十
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_fmmr2_d[l_ac].fmmr035_desc = g_fmmr2_d[l_ac].fmmr035
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmr035_desc
            
            #add-point:AFTER FIELD fmmr035_desc name="input.a.page2.fmmr035_desc"
            #自由核算項十
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr035_desc) THEN
               IF (g_fmmr2_d[l_ac].fmmr035_desc != g_fmmr2_d_t.fmmr035_desc OR g_fmmr2_d_t.fmmr035_desc IS NULL) THEN
                  LET g_fmmr2_d[l_ac].fmmr035 = g_fmmr2_d[l_ac].fmmr035_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_fmmr2_d[l_ac].fmmr035 != g_fmmr2_d_t.fmmr035 OR g_fmmr2_d_t.fmmr035 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_fmmr2_d[l_ac].fmmr035,g_glad.glad0262) RETURNING g_errno
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
                           LET g_fmmr2_d[l_ac].fmmr035 = g_fmmr2_d_t.fmmr035
                           LET g_fmmr2_d[l_ac].fmmr035_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr035,s_fin_get_accting_desc(g_glad.glad0261,g_fmmr2_d[l_ac].fmmr035))
                           DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr035_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_fmmr2_d[l_ac].fmmr035 = ''
            END IF
            LET g_fmmr2_d[l_ac].fmmr035_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr035,s_fin_get_accting_desc(g_glad.glad0261,g_fmmr2_d[l_ac].fmmr035))
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr035_desc
            LET g_fmmr2_d_t.fmmr035_desc = g_fmmr2_d[l_ac].fmmr035_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmr035_desc
            #add-point:ON CHANGE fmmr035_desc name="input.g.page2.fmmr035_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.fmmr011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr011
            #add-point:ON ACTION controlp INFIELD fmmr011 name="input.c.page2.fmmr011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr011_desc
            #add-point:ON ACTION controlp INFIELD fmmr011_desc name="input.c.page2.fmmr011_desc"
            #公允價值變動科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr011
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                  " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fmmq_m.fmmq001,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_fmmr2_d[l_ac].fmmr011 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr011_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr011,g_fmmr2_d[l_ac].fmmr011_desc
            NEXT FIELD fmmr011_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr012
            #add-point:ON ACTION controlp INFIELD fmmr012 name="input.c.page2.fmmr012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr012_desc
            #add-point:ON ACTION controlp INFIELD fmmr012_desc name="input.c.page2.fmmr012_desc"
            #對方科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr012
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",
                                  " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fmmq_m.fmmq001,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_fmmr2_d[l_ac].fmmr012 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr012_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr012,g_fmmr2_d[l_ac].fmmr012_desc
            NEXT FIELD fmmr012_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr036
            #add-point:ON ACTION controlp INFIELD fmmr036 name="input.c.page2.fmmr036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr013
            #add-point:ON ACTION controlp INFIELD fmmr013 name="input.c.page2.fmmr013"
            #帳款對象編號
            

            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr013_desc
            #add-point:ON ACTION controlp INFIELD fmmr013_desc name="input.c.page2.fmmr013_desc"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr013
            #LET g_qryparam.where = "pmaa002 IN ('2','3')"  #160913-00017#2 mark 
            CALL q_pmaa001_25()        #160913-00017#2  ADD 
           # CALL q_pmaa001()      #160913-00017#2 mark          #呼叫開窗
            LET g_fmmr2_d[l_ac].fmmr013 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr013_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr013,g_fmmr2_d[l_ac].fmmr013_desc
            NEXT FIELD fmmr013_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr014
            #add-point:ON ACTION controlp INFIELD fmmr014 name="input.c.page2.fmmr014"
            #應用 a07 樣板自動產生(Version:2)   
          


            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr014_desc
            #add-point:ON ACTION controlp INFIELD fmmr014_desc name="input.c.page2.fmmr014_desc"
            #收款對象
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr014
            LET g_qryparam.arg1 = g_fmmr2_d[l_ac].fmmr013
            LET g_qryparam.arg2 = "1"
            CALL q_pmac002_1()
            LET g_fmmr2_d[l_ac].fmmr014 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr014_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr014,g_fmmr2_d[l_ac].fmmr014_desc
            NEXT FIELD fmmr014_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr015
            #add-point:ON ACTION controlp INFIELD fmmr015 name="input.c.page2.fmmr015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr015_desc
            #add-point:ON ACTION controlp INFIELD fmmr015_desc name="input.c.page2.fmmr015_desc"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr015
            LET g_qryparam.arg1 = g_fmmq_m.fmmqdocdt    #應以單據日期
            CALL q_ooeg001_4()
            LET g_fmmr2_d[l_ac].fmmr015 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr015_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr015,g_fmmr2_d[l_ac].fmmr015_desc
            NEXT FIELD fmmr015_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr016
            #add-point:ON ACTION controlp INFIELD fmmr016 name="input.c.page2.fmmr016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr016_desc
            #add-point:ON ACTION controlp INFIELD fmmr016_desc name="input.c.page2.fmmr016_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 =  g_fmmr2_d[l_ac].fmmr016
            LET g_qryparam.arg1 = g_fmmq_m.fmmqdocdt
            CALL q_ooeg001_5()
            LET g_fmmr2_d[l_ac].fmmr016 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr016_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr016,g_fmmr2_d[l_ac].fmmr016_desc
            NEXT FIELD fmmr016_desc

            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr017
            #add-point:ON ACTION controlp INFIELD fmmr017 name="input.c.page2.fmmr017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr017_desc
            #add-point:ON ACTION controlp INFIELD fmmr017_desc name="input.c.page2.fmmr017_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr017
            CALL q_oocq002_287()
            LET g_fmmr2_d[l_ac].fmmr017 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr017_desc = g_qryparam.return1
            DISPLAY BY NAME  g_fmmr2_d[l_ac].fmmr017,g_fmmr2_d[l_ac].fmmr017_desc
            NEXT FIELD fmmr017_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr018
            #add-point:ON ACTION controlp INFIELD fmmr018 name="input.c.page2.fmmr018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr018_desc
            #add-point:ON ACTION controlp INFIELD fmmr018_desc name="input.c.page2.fmmr018_desc"
            #應用 a07 樣板自動產生(Version:2)   
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr018
            CALL q_oocq002_281()
            LET g_fmmr2_d[l_ac].fmmr018 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr018_desc = g_qryparam.return1
            DISPLAY BY NAME  g_fmmr2_d[l_ac].fmmr018,g_fmmr2_d[l_ac].fmmr018_desc
            NEXT FIELD fmmr018_desc

            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr019
            #add-point:ON ACTION controlp INFIELD fmmr019 name="input.c.page2.fmmr019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr019_desc
            #add-point:ON ACTION controlp INFIELD fmmr019_desc name="input.c.page2.fmmr019_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr019
            CALL q_rtax001()
            LET g_fmmr2_d[l_ac].fmmr019 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr019_desc = g_qryparam.return1
            DISPLAY BY NAME  g_fmmr2_d[l_ac].fmmr019,g_fmmr2_d[l_ac].fmmr019_desc
            NEXT FIELD fmmr019_desc


            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr020
            #add-point:ON ACTION controlp INFIELD fmmr020 name="input.c.page2.fmmr020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr020_desc
            #add-point:ON ACTION controlp INFIELD fmmr020_desc name="input.c.page2.fmmr020_desc"
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr020
            CALL q_ooag001_8()
            LET g_fmmr2_d[l_ac].fmmr020 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr020_desc = g_qryparam.return1 
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr020,g_fmmr2_d[l_ac].fmmr020_desc
            NEXT FIELD fmmr020_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr021
            #add-point:ON ACTION controlp INFIELD fmmr021 name="input.c.page2.fmmr021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr021_desc
            #add-point:ON ACTION controlp INFIELD fmmr021_desc name="input.c.page2.fmmr021_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr021
            CALL q_pjba001()
            LET g_fmmr2_d[l_ac].fmmr021 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr021_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr021,g_fmmr2_d[l_ac].fmmr021_desc
            NEXT FIELD fmmr021_desc

            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr022
            #add-point:ON ACTION controlp INFIELD fmmr022 name="input.c.page2.fmmr022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr022_desc
            #add-point:ON ACTION controlp INFIELD fmmr022_desc name="input.c.page2.fmmr022_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr022
            #150302 add---
            IF NOT cl_null(g_fmmr2_d[l_ac].fmmr021) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_fmmr2_d[l_ac].fmmr021,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            #150302 add end ---
            CALL q_pjbb002()
            LET g_fmmr2_d[l_ac].fmmr022 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr022_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr022,g_fmmr2_d[l_ac].fmmr022_desc
            NEXT FIELD fmmr022_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr023
            #add-point:ON ACTION controlp INFIELD fmmr023 name="input.c.page2.fmmr023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr023_desc
            #add-point:ON ACTION controlp INFIELD fmmr023_desc name="input.c.page2.fmmr023_desc"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr024
            #add-point:ON ACTION controlp INFIELD fmmr024 name="input.c.page2.fmmr024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr024_desc
            #add-point:ON ACTION controlp INFIELD fmmr024_desc name="input.c.page2.fmmr024_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr024
            CALL q_oojd001_2()
            LET g_fmmr2_d[l_ac].fmmr024 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr024_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr024,g_fmmr2_d[l_ac].fmmr024_desc
            NEXT FIELD fmmr024_desc
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr025
            #add-point:ON ACTION controlp INFIELD fmmr025 name="input.c.page2.fmmr025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr025_desc
            #add-point:ON ACTION controlp INFIELD fmmr025_desc name="input.c.page2.fmmr025_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr025
            CALL q_oocq002_2002()
            LET g_fmmr2_d[l_ac].fmmr025 = g_qryparam.return1
            LET g_fmmr2_d[l_ac].fmmr025_desc = g_qryparam.return1
            DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr025,g_fmmr2_d[l_ac].fmmr025_desc
            NEXT FIELD fmmr025_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr026
            #add-point:ON ACTION controlp INFIELD fmmr026 name="input.c.page2.fmmr026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr026_desc
            #add-point:ON ACTION controlp INFIELD fmmr026_desc name="input.c.page2.fmmr026_desc"
           #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr026
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmmr2_d[l_ac].fmmr026 = g_qryparam.return1
               LET g_fmmr2_d[l_ac].fmmr026_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr026,g_fmmr2_d[l_ac].fmmr026_desc
               NEXT FIELD fmmr026_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr027
            #add-point:ON ACTION controlp INFIELD fmmr027 name="input.c.page2.fmmr027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr027_desc
            #add-point:ON ACTION controlp INFIELD fmmr027_desc name="input.c.page2.fmmr027_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr027
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmmr2_d[l_ac].fmmr027 = g_qryparam.return1
               LET g_fmmr2_d[l_ac].fmmr027_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr027,g_fmmr2_d[l_ac].fmmr027_desc
               NEXT FIELD fmmr026_desc
            END IF  
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr028
            #add-point:ON ACTION controlp INFIELD fmmr028 name="input.c.page2.fmmr028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr028_desc
            #add-point:ON ACTION controlp INFIELD fmmr028_desc name="input.c.page2.fmmr028_desc"
            #自由核算項三           
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr028
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmmr2_d[l_ac].fmmr028 = g_qryparam.return1
               LET g_fmmr2_d[l_ac].fmmr028_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr028,g_fmmr2_d[l_ac].fmmr028_desc
               NEXT FIELD fmmr028_desc
            END IF  
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr029
            #add-point:ON ACTION controlp INFIELD fmmr029 name="input.c.page2.fmmr029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr029_desc
            #add-point:ON ACTION controlp INFIELD fmmr029_desc name="input.c.page2.fmmr029_desc"
 　　　　 　 #自由核算項四           
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr029
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmmr2_d[l_ac].fmmr029 = g_qryparam.return1
               LET g_fmmr2_d[l_ac].fmmr029_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr029,g_fmmr2_d[l_ac].fmmr029_desc
               NEXT FIELD fmmr029_desc
            END IF  
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr030
            #add-point:ON ACTION controlp INFIELD fmmr030 name="input.c.page2.fmmr030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr030_desc
            #add-point:ON ACTION controlp INFIELD fmmr030_desc name="input.c.page2.fmmr030_desc"
            #自由核算項五          
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr030
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmmr2_d[l_ac].fmmr030 = g_qryparam.return1
               LET g_fmmr2_d[l_ac].fmmr030_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr030,g_fmmr2_d[l_ac].fmmr030_desc
               NEXT FIELD fmmr030_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr031
            #add-point:ON ACTION controlp INFIELD fmmr031 name="input.c.page2.fmmr031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr031_desc
            #add-point:ON ACTION controlp INFIELD fmmr031_desc name="input.c.page2.fmmr031_desc"
            #自由核算項六          
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr031
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmmr2_d[l_ac].fmmr031 = g_qryparam.return1
               LET g_fmmr2_d[l_ac].fmmr031_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr031,g_fmmr2_d[l_ac].fmmr031_desc
               NEXT FIELD fmmr031_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr032
            #add-point:ON ACTION controlp INFIELD fmmr032 name="input.c.page2.fmmr032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr032_desc
            #add-point:ON ACTION controlp INFIELD fmmr032_desc name="input.c.page2.fmmr032_desc"
            #自由核算項七          
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr032
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmmr2_d[l_ac].fmmr032 = g_qryparam.return1
               LET g_fmmr2_d[l_ac].fmmr032_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr032,g_fmmr2_d[l_ac].fmmr032_desc
               NEXT FIELD fmmr032_desc
            END IF 
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr033
            #add-point:ON ACTION controlp INFIELD fmmr033 name="input.c.page2.fmmr033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr033_desc
            #add-point:ON ACTION controlp INFIELD fmmr033_desc name="input.c.page2.fmmr033_desc"
            #自由核算項八          
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr033
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmmr2_d[l_ac].fmmr033 = g_qryparam.return1
               LET g_fmmr2_d[l_ac].fmmr033_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr033,g_fmmr2_d[l_ac].fmmr033_desc
               NEXT FIELD fmmr033_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr034
            #add-point:ON ACTION controlp INFIELD fmmr034 name="input.c.page2.fmmr034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr034_desc
            #add-point:ON ACTION controlp INFIELD fmmr034_desc name="input.c.page2.fmmr034_desc"
            #自由核算項九          
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr034
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmmr2_d[l_ac].fmmr034 = g_qryparam.return1
               LET g_fmmr2_d[l_ac].fmmr034_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr034,g_fmmr2_d[l_ac].fmmr034_desc
               NEXT FIELD fmmr034_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr035
            #add-point:ON ACTION controlp INFIELD fmmr035 name="input.c.page2.fmmr035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmmr035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmr035_desc
            #add-point:ON ACTION controlp INFIELD fmmr035_desc name="input.c.page2.fmmr035_desc"
            #自由核算項十         
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_fmmr2_d[l_ac].fmmr035
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_fmmr2_d[l_ac].fmmr035 = g_qryparam.return1
               LET g_fmmr2_d[l_ac].fmmr035_desc = g_qryparam.return1
               DISPLAY BY NAME g_fmmr2_d[l_ac].fmmr035,g_fmmr2_d[l_ac].fmmr035_desc
               NEXT FIELD fmmr035_desc
            END IF
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmmr2_d[l_ac].* = g_fmmr2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt555_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt555_unlock_b("fmmr_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
           IF g_glaa.glaa121 = 'Y' THEN
               CALL s_transaction_begin()
               CALL s_pre_voucher_ins('FM','M30',g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,'4')
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
               LET g_fmmr_d[li_reproduce_target].* = g_fmmr_d[li_reproduce].*
               LET g_fmmr2_d[li_reproduce_target].* = g_fmmr2_d[li_reproduce].*
 
               LET g_fmmr2_d[li_reproduce_target].fmmrseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmmr2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmmr2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="afmt555.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD fmmqsite
            #end add-point  
            NEXT FIELD fmmqdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fmmrseq
               WHEN "s_detail2"
                  NEXT FIELD fmmrseq_2
 
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
 
{<section id="afmt555.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afmt555_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afmt555_b_fill() #單身填充
      CALL afmt555_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt555_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL afmt555_set_ld_info(g_fmmq_m.fmmq001) RETURNING g_fmmq_m.l_fmmqcomp
   LET g_fmmq_m.fmmqsite_desc = s_desc_get_department_desc(g_fmmq_m.fmmqsite)    #帳務中心
   LET g_fmmq_m.fmmq001_desc  = s_desc_get_ld_desc(g_fmmq_m.fmmq001)             #帳套     
   LET g_fmmq_m.fmmqcomp_desc = s_desc_get_department_desc(g_fmmq_m.l_fmmqcomp)  #法人
   CALL cl_set_act_visible("afmt555_02", TRUE)
   IF cl_null(g_fmmq_m.fmmqdocno) THEN
      CALL cl_set_act_visible("afmt555_02", FALSE)
   ENd IF
   #end add-point
   
   #遮罩相關處理
   LET g_fmmq_m_mask_o.* =  g_fmmq_m.*
   CALL afmt555_fmmq_t_mask()
   LET g_fmmq_m_mask_n.* =  g_fmmq_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmmq_m.fmmqsite,g_fmmq_m.fmmqsite_desc,g_fmmq_m.fmmq001,g_fmmq_m.fmmq001_desc,g_fmmq_m.l_fmmqcomp, 
       g_fmmq_m.fmmqcomp_desc,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003, 
       g_fmmq_m.fmmq004,g_fmmq_m.l_curr,g_fmmq_m.fmmqstus,g_fmmq_m.fmmqownid,g_fmmq_m.fmmqownid_desc, 
       g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtid_desc,g_fmmq_m.fmmqcrtdp, 
       g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqcrtdt,g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqmoddt, 
       g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfid_desc,g_fmmq_m.fmmqcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmq_m.fmmqstus 
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
   FOR l_ac = 1 TO g_fmmr_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_fmmr2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afmt555_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afmt555_detail_show()
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
 
{<section id="afmt555.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt555_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fmmq_t.fmmqdocno 
   DEFINE l_oldno     LIKE fmmq_t.fmmqdocno 
 
   DEFINE l_master    RECORD LIKE fmmq_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fmmr_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_fmmq_m.fmmqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_fmmqdocno_t = g_fmmq_m.fmmqdocno
 
    
   LET g_fmmq_m.fmmqdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmmq_m.fmmqownid = g_user
      LET g_fmmq_m.fmmqowndp = g_dept
      LET g_fmmq_m.fmmqcrtid = g_user
      LET g_fmmq_m.fmmqcrtdp = g_dept 
      LET g_fmmq_m.fmmqcrtdt = cl_get_current()
      LET g_fmmq_m.fmmqmodid = g_user
      LET g_fmmq_m.fmmqmoddt = cl_get_current()
      LET g_fmmq_m.fmmqstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmq_m.fmmqstus 
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
   
   
   CALL afmt555_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fmmq_m.* TO NULL
      INITIALIZE g_fmmr_d TO NULL
      INITIALIZE g_fmmr2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afmt555_show()
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
   CALL afmt555_set_act_visible()   
   CALL afmt555_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmmqdocno_t = g_fmmq_m.fmmqdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmmqent = " ||g_enterprise|| " AND",
                      " fmmqdocno = '", g_fmmq_m.fmmqdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt555_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afmt555_idx_chk()
   
   LET g_data_owner = g_fmmq_m.fmmqownid      
   LET g_data_dept  = g_fmmq_m.fmmqowndp
   
   #功能已完成,通報訊息中心
   CALL afmt555_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt555.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afmt555_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fmmr_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afmt555_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmmr_t
    WHERE fmmrent = g_enterprise AND fmmrdocno = g_fmmqdocno_t
 
    INTO TEMP afmt555_detail
 
   #將key修正為調整後   
   UPDATE afmt555_detail 
      #更新key欄位
      SET fmmrdocno = g_fmmq_m.fmmqdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fmmr_t SELECT * FROM afmt555_detail
   
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
   DROP TABLE afmt555_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fmmqdocno_t = g_fmmq_m.fmmqdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afmt555_delete()
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
   
   IF g_fmmq_m.fmmqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afmt555_cl USING g_enterprise,g_fmmq_m.fmmqdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt555_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt555_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt555_master_referesh USING g_fmmq_m.fmmqdocno INTO g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001, 
       g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003,g_fmmq_m.fmmq004,g_fmmq_m.fmmqstus, 
       g_fmmq_m.fmmqownid,g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtdp,g_fmmq_m.fmmqcrtdt, 
       g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmoddt,g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfdt,g_fmmq_m.fmmqsite_desc, 
       g_fmmq_m.fmmq001_desc,g_fmmq_m.fmmqownid_desc,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid_desc, 
       g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT afmt555_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmmq_m_mask_o.* =  g_fmmq_m.*
   CALL afmt555_fmmq_t_mask()
   LET g_fmmq_m_mask_n.* =  g_fmmq_m.*
   
   CALL afmt555_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt555_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_fmmqdocno_t = g_fmmq_m.fmmqdocno
 
 
      DELETE FROM fmmq_t
       WHERE fmmqent = g_enterprise AND fmmqdocno = g_fmmq_m.fmmqdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_fmmq_m.fmmqdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
       #刪除底稿
      IF g_glaa.glaa121 = 'Y' THEN
         CALL s_pre_voucher_del('FM','M30',g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_fmmq_m.fmmqdocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = FALSE
            CALL cl_err()
         END IF
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM fmmr_t
       WHERE fmmrent = g_enterprise AND fmmrdocno = g_fmmq_m.fmmqdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmmr_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      DELETE FROM glga_t
       WHERE glgaent = g_enterprise
         AND glgald  = g_fmmq_m.fmmq001 AND glgadocno = g_fmmq_m.fmmqdocno
         AND glga100 = 'FM' AND glga101 ='M30'
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "glga_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF

     DELETE FROM glgb_t
       WHERE glgbent = g_enterprise
         AND glgbld  = g_fmmq_m.fmmq001 AND glgbdocno = g_fmmq_m.fmmqdocno
         AND glgb100 = 'FM' AND glgb101 ='M30'
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "glgb_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fmmq_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afmt555_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fmmr_d.clear() 
      CALL g_fmmr2_d.clear()       
 
     
      CALL afmt555_ui_browser_refresh()  
      #CALL afmt555_ui_headershow()  
      #CALL afmt555_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afmt555_browser_fill("")
         CALL afmt555_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afmt555_cl
 
   #功能已完成,通報訊息中心
   CALL afmt555_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afmt555.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmt555_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fmmr_d.clear()
   CALL g_fmmr2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF afmt555_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmmrseq,fmmr001,fmmr002,fmmr003,fmmr037,fmmr004,fmmr005,fmmr006, 
             fmmr007,fmmr008,fmmr009,fmmr010,fmmrseq,fmmr011,fmmr012,fmmr036,fmmr013,fmmr014,fmmr015, 
             fmmr016,fmmr017,fmmr018,fmmr019,fmmr020,fmmr021,fmmr022,fmmr023,fmmr024,fmmr025,fmmr026, 
             fmmr027,fmmr028,fmmr029,fmmr030,fmmr031,fmmr032,fmmr033,fmmr034,fmmr035  FROM fmmr_t",  
               
                     " INNER JOIN fmmq_t ON fmmqent = " ||g_enterprise|| " AND fmmqdocno = fmmrdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE fmmrent=? AND fmmrdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmmr_t.fmmrseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt555_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afmt555_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fmmq_m.fmmqdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fmmq_m.fmmqdocno INTO g_fmmr_d[l_ac].fmmrseq,g_fmmr_d[l_ac].fmmr001, 
          g_fmmr_d[l_ac].fmmr002,g_fmmr_d[l_ac].fmmr003,g_fmmr_d[l_ac].fmmr037,g_fmmr_d[l_ac].fmmr004, 
          g_fmmr_d[l_ac].fmmr005,g_fmmr_d[l_ac].fmmr006,g_fmmr_d[l_ac].fmmr007,g_fmmr_d[l_ac].fmmr008, 
          g_fmmr_d[l_ac].fmmr009,g_fmmr_d[l_ac].fmmr010,g_fmmr2_d[l_ac].fmmrseq,g_fmmr2_d[l_ac].fmmr011, 
          g_fmmr2_d[l_ac].fmmr012,g_fmmr2_d[l_ac].fmmr036,g_fmmr2_d[l_ac].fmmr013,g_fmmr2_d[l_ac].fmmr014, 
          g_fmmr2_d[l_ac].fmmr015,g_fmmr2_d[l_ac].fmmr016,g_fmmr2_d[l_ac].fmmr017,g_fmmr2_d[l_ac].fmmr018, 
          g_fmmr2_d[l_ac].fmmr019,g_fmmr2_d[l_ac].fmmr020,g_fmmr2_d[l_ac].fmmr021,g_fmmr2_d[l_ac].fmmr022, 
          g_fmmr2_d[l_ac].fmmr023,g_fmmr2_d[l_ac].fmmr024,g_fmmr2_d[l_ac].fmmr025,g_fmmr2_d[l_ac].fmmr026, 
          g_fmmr2_d[l_ac].fmmr027,g_fmmr2_d[l_ac].fmmr028,g_fmmr2_d[l_ac].fmmr029,g_fmmr2_d[l_ac].fmmr030, 
          g_fmmr2_d[l_ac].fmmr031,g_fmmr2_d[l_ac].fmmr032,g_fmmr2_d[l_ac].fmmr033,g_fmmr2_d[l_ac].fmmr034, 
          g_fmmr2_d[l_ac].fmmr035   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL afmt555_fmmr002_ref()
         LET g_fmmr_d[l_ac].fmmr001_desc = s_desc_get_department_desc(g_fmmr_d[l_ac].fmmr001)
         #固定核算項         
         #公允價值變動科目
         LET g_fmmr2_d[l_ac].fmmr011_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr011,s_desc_get_account_desc(g_fmmq_m.fmmq001,g_fmmr2_d[l_ac].fmmr011))
         #公允價值損益科目
         LET g_fmmr2_d[l_ac].fmmr012_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr012,s_desc_get_account_desc(g_fmmq_m.fmmq001,g_fmmr2_d[l_ac].fmmr012))
         
         LET g_fmmr2_d[l_ac].fmmr013_desc  = s_desc_show1(g_fmmr2_d[l_ac].fmmr013,s_desc_get_trading_partner_abbr_desc(g_fmmr2_d[l_ac].fmmr013))
         LET g_fmmr2_d[l_ac].fmmr014_desc  = s_desc_show1(g_fmmr2_d[l_ac].fmmr014,s_desc_get_trading_partner_abbr_desc(g_fmmr2_d[l_ac].fmmr014))
         LET g_fmmr2_d[l_ac].fmmr015_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr015,s_desc_get_department_desc(g_fmmr2_d[l_ac].fmmr015))
         LET g_fmmr2_d[l_ac].fmmr016_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr016,s_desc_get_department_desc(g_fmmr2_d[l_ac].fmmr016))
         LET g_fmmr2_d[l_ac].fmmr017_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr017,s_desc_get_acc_desc('287',g_fmmr2_d[l_ac].fmmr017))
         LET g_fmmr2_d[l_ac].fmmr018_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr018,s_desc_get_acc_desc('281',g_fmmr2_d[l_ac].fmmr018))
         LET g_fmmr2_d[l_ac].fmmr019_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr019,s_desc_get_rtaxl003_desc(g_fmmr2_d[l_ac].fmmr019))
         LET g_fmmr2_d[l_ac].fmmr020_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr020,s_desc_get_person_desc(g_fmmr2_d[l_ac].fmmr020))
         LET g_fmmr2_d[l_ac].fmmr021_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr021,s_desc_get_project_desc(g_fmmr2_d[l_ac].fmmr021))
         LET g_fmmr2_d[l_ac].fmmr022_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr022,s_desc_get_pjbbl004_desc(g_fmmr2_d[l_ac].fmmr021,g_fmmr2_d[l_ac].fmmr022))
         LET g_fmmr2_d[l_ac].fmmr023_desc = g_fmmr2_d[l_ac].fmmr023
         LET g_fmmr2_d[l_ac].fmmr024_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr024,s_desc_get_oojdl003_desc(g_fmmr2_d[l_ac].fmmr024))
         LET g_fmmr2_d[l_ac].fmmr025_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr025,s_desc_get_acc_desc('2002',g_fmmr2_d[l_ac].fmmr025))

         #自由核算項
         CALL s_fin_sel_glad(g_fmmq_m.fmmq001,g_fmmr2_d[l_ac].fmmr011,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
              RETURNING g_errno,g_glad.*
         IF NOT cl_null(g_fmmr2_d[l_ac].fmmr026) THEN
            LET g_fmmr2_d[l_ac].fmmr026_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr026,s_fin_get_accting_desc(g_glad.glad0171,g_fmmr2_d[l_ac].fmmr026))
         END IF
         IF NOT cl_null(g_fmmr2_d[l_ac].fmmr027) THEN
            LET g_fmmr2_d[l_ac].fmmr027_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr027,s_fin_get_accting_desc(g_glad.glad0181,g_fmmr2_d[l_ac].fmmr027))
         END IF
         IF NOT cl_null(g_fmmr2_d[l_ac].fmmr028) THEN
            LET g_fmmr2_d[l_ac].fmmr028_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr028,s_fin_get_accting_desc(g_glad.glad0191,g_fmmr2_d[l_ac].fmmr028))
         END IF
         IF NOT cl_null(g_fmmr2_d[l_ac].fmmr029) THEN
            LET g_fmmr2_d[l_ac].fmmr029_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr029,s_fin_get_accting_desc(g_glad.glad0201,g_fmmr2_d[l_ac].fmmr029))
         END IF
         IF NOT cl_null(g_fmmr2_d[l_ac].fmmr030) THEN
            LET g_fmmr2_d[l_ac].fmmr030_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr030,s_fin_get_accting_desc(g_glad.glad0211,g_fmmr2_d[l_ac].fmmr030))
         END IF
         IF NOT cl_null(g_fmmr2_d[l_ac].fmmr031) THEN
            LET g_fmmr2_d[l_ac].fmmr031_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr031,s_fin_get_accting_desc(g_glad.glad0221,g_fmmr2_d[l_ac].fmmr031))
         END IF
         IF NOT cl_null(g_fmmr2_d[l_ac].fmmr032) THEN
            LET g_fmmr2_d[l_ac].fmmr032_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr032,s_fin_get_accting_desc(g_glad.glad0231,g_fmmr2_d[l_ac].fmmr032))
         END IF
         IF NOT cl_null(g_fmmr2_d[l_ac].fmmr033) THEN
            LET g_fmmr2_d[l_ac].fmmr033_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr033,s_fin_get_accting_desc(g_glad.glad0241,g_fmmr2_d[l_ac].fmmr033))
         END IF
         IF NOT cl_null(g_fmmr2_d[l_ac].fmmr034) THEN
            LET g_fmmr2_d[l_ac].fmmr034_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr034,s_fin_get_accting_desc(g_glad.glad0251,g_fmmr2_d[l_ac].fmmr034))
         END IF
         IF NOT cl_null(g_fmmr2_d[l_ac].fmmr035) THEN
            LET g_fmmr2_d[l_ac].fmmr035_desc = s_desc_show1(g_fmmr2_d[l_ac].fmmr035,s_fin_get_accting_desc(g_glad.glad0261,g_fmmr2_d[l_ac].fmmr035))
         END IF
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
   
   #end add-point
   
   CALL g_fmmr_d.deleteElement(g_fmmr_d.getLength())
   CALL g_fmmr2_d.deleteElement(g_fmmr2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afmt555_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fmmr_d.getLength()
      LET g_fmmr_d_mask_o[l_ac].* =  g_fmmr_d[l_ac].*
      CALL afmt555_fmmr_t_mask()
      LET g_fmmr_d_mask_n[l_ac].* =  g_fmmr_d[l_ac].*
   END FOR
   
   LET g_fmmr2_d_mask_o.* =  g_fmmr2_d.*
   FOR l_ac = 1 TO g_fmmr2_d.getLength()
      LET g_fmmr2_d_mask_o[l_ac].* =  g_fmmr2_d[l_ac].*
      CALL afmt555_fmmr_t_mask()
      LET g_fmmr2_d_mask_n[l_ac].* =  g_fmmr2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt555.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afmt555_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM fmmr_t
       WHERE fmmrent = g_enterprise AND
         fmmrdocno = ps_keys_bak[1] AND fmmrseq = ps_keys_bak[2]
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
         CALL g_fmmr_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_fmmr2_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afmt555_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO fmmr_t
                  (fmmrent,
                   fmmrdocno,
                   fmmrseq
                   ,fmmr001,fmmr002,fmmr003,fmmr037,fmmr004,fmmr005,fmmr006,fmmr007,fmmr008,fmmr009,fmmr010,fmmr011,fmmr012,fmmr036,fmmr013,fmmr014,fmmr015,fmmr016,fmmr017,fmmr018,fmmr019,fmmr020,fmmr021,fmmr022,fmmr023,fmmr024,fmmr025,fmmr026,fmmr027,fmmr028,fmmr029,fmmr030,fmmr031,fmmr032,fmmr033,fmmr034,fmmr035) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_fmmr_d[g_detail_idx].fmmr001,g_fmmr_d[g_detail_idx].fmmr002,g_fmmr_d[g_detail_idx].fmmr003, 
                       g_fmmr_d[g_detail_idx].fmmr037,g_fmmr_d[g_detail_idx].fmmr004,g_fmmr_d[g_detail_idx].fmmr005, 
                       g_fmmr_d[g_detail_idx].fmmr006,g_fmmr_d[g_detail_idx].fmmr007,g_fmmr_d[g_detail_idx].fmmr008, 
                       g_fmmr_d[g_detail_idx].fmmr009,g_fmmr_d[g_detail_idx].fmmr010,g_fmmr2_d[g_detail_idx].fmmr011, 
                       g_fmmr2_d[g_detail_idx].fmmr012,g_fmmr2_d[g_detail_idx].fmmr036,g_fmmr2_d[g_detail_idx].fmmr013, 
                       g_fmmr2_d[g_detail_idx].fmmr014,g_fmmr2_d[g_detail_idx].fmmr015,g_fmmr2_d[g_detail_idx].fmmr016, 
                       g_fmmr2_d[g_detail_idx].fmmr017,g_fmmr2_d[g_detail_idx].fmmr018,g_fmmr2_d[g_detail_idx].fmmr019, 
                       g_fmmr2_d[g_detail_idx].fmmr020,g_fmmr2_d[g_detail_idx].fmmr021,g_fmmr2_d[g_detail_idx].fmmr022, 
                       g_fmmr2_d[g_detail_idx].fmmr023,g_fmmr2_d[g_detail_idx].fmmr024,g_fmmr2_d[g_detail_idx].fmmr025, 
                       g_fmmr2_d[g_detail_idx].fmmr026,g_fmmr2_d[g_detail_idx].fmmr027,g_fmmr2_d[g_detail_idx].fmmr028, 
                       g_fmmr2_d[g_detail_idx].fmmr029,g_fmmr2_d[g_detail_idx].fmmr030,g_fmmr2_d[g_detail_idx].fmmr031, 
                       g_fmmr2_d[g_detail_idx].fmmr032,g_fmmr2_d[g_detail_idx].fmmr033,g_fmmr2_d[g_detail_idx].fmmr034, 
                       g_fmmr2_d[g_detail_idx].fmmr035)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmmr_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fmmr_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_fmmr2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afmt555_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmmr_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afmt555_fmmr_t_mask_restore('restore_mask_o')
               
      UPDATE fmmr_t 
         SET (fmmrdocno,
              fmmrseq
              ,fmmr001,fmmr002,fmmr003,fmmr037,fmmr004,fmmr005,fmmr006,fmmr007,fmmr008,fmmr009,fmmr010,fmmr011,fmmr012,fmmr036,fmmr013,fmmr014,fmmr015,fmmr016,fmmr017,fmmr018,fmmr019,fmmr020,fmmr021,fmmr022,fmmr023,fmmr024,fmmr025,fmmr026,fmmr027,fmmr028,fmmr029,fmmr030,fmmr031,fmmr032,fmmr033,fmmr034,fmmr035) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_fmmr_d[g_detail_idx].fmmr001,g_fmmr_d[g_detail_idx].fmmr002,g_fmmr_d[g_detail_idx].fmmr003, 
                  g_fmmr_d[g_detail_idx].fmmr037,g_fmmr_d[g_detail_idx].fmmr004,g_fmmr_d[g_detail_idx].fmmr005, 
                  g_fmmr_d[g_detail_idx].fmmr006,g_fmmr_d[g_detail_idx].fmmr007,g_fmmr_d[g_detail_idx].fmmr008, 
                  g_fmmr_d[g_detail_idx].fmmr009,g_fmmr_d[g_detail_idx].fmmr010,g_fmmr2_d[g_detail_idx].fmmr011, 
                  g_fmmr2_d[g_detail_idx].fmmr012,g_fmmr2_d[g_detail_idx].fmmr036,g_fmmr2_d[g_detail_idx].fmmr013, 
                  g_fmmr2_d[g_detail_idx].fmmr014,g_fmmr2_d[g_detail_idx].fmmr015,g_fmmr2_d[g_detail_idx].fmmr016, 
                  g_fmmr2_d[g_detail_idx].fmmr017,g_fmmr2_d[g_detail_idx].fmmr018,g_fmmr2_d[g_detail_idx].fmmr019, 
                  g_fmmr2_d[g_detail_idx].fmmr020,g_fmmr2_d[g_detail_idx].fmmr021,g_fmmr2_d[g_detail_idx].fmmr022, 
                  g_fmmr2_d[g_detail_idx].fmmr023,g_fmmr2_d[g_detail_idx].fmmr024,g_fmmr2_d[g_detail_idx].fmmr025, 
                  g_fmmr2_d[g_detail_idx].fmmr026,g_fmmr2_d[g_detail_idx].fmmr027,g_fmmr2_d[g_detail_idx].fmmr028, 
                  g_fmmr2_d[g_detail_idx].fmmr029,g_fmmr2_d[g_detail_idx].fmmr030,g_fmmr2_d[g_detail_idx].fmmr031, 
                  g_fmmr2_d[g_detail_idx].fmmr032,g_fmmr2_d[g_detail_idx].fmmr033,g_fmmr2_d[g_detail_idx].fmmr034, 
                  g_fmmr2_d[g_detail_idx].fmmr035) 
         WHERE fmmrent = g_enterprise AND fmmrdocno = ps_keys_bak[1] AND fmmrseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmmr_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmmr_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt555_fmmr_t_mask_restore('restore_mask_n')
               
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
 
{<section id="afmt555.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afmt555_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt555.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afmt555_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt555.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afmt555_lock_b(ps_table,ps_page)
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
   #CALL afmt555_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "fmmr_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afmt555_bcl USING g_enterprise,
                                       g_fmmq_m.fmmqdocno,g_fmmr_d[g_detail_idx].fmmrseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt555_bcl:",SQLERRMESSAGE 
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
 
{<section id="afmt555.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afmt555_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt555_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afmt555.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt555_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("fmmqdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fmmqdocno",TRUE)
      CALL cl_set_comp_entry("fmmqdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("fmmqsite,fmmq001",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt555.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt555_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success  LIKE type_t.num5     #151130-00015#2 
   DEFINE l_slip     LIKE type_t.chr10  #151130-00015#2
   DEFINE l_dfin0033  LIKE type_t.chr80 #151130-00015#2
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmmqdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("fmmqsite,fmmq001",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("fmmqdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("fmmqdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #151130-00015#2 -begin -add by XZG 20151222
      IF NOT cl_null(g_fmmq_m.fmmqdocno) THEN  
            #获取单别
            CALL s_aooi200_fin_get_slip(g_fmmq_m.fmmqdocno) RETURNING l_success,l_slip
            #是否可改日期
            CALL s_fin_get_doc_para(g_fmmq_m.fmmq001,g_fmmq_m.l_fmmqcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
            IF l_dfin0033 = "N"  THEN 
               CALL cl_set_comp_entry("fmmqdocdt",FALSE)
            ELSE 
               CALL cl_set_comp_entry("fmmqdocdt",TRUE)
            END IF          
         END IF 
      #151130-00015#2  -end 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt555.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afmt555_set_entry_b(p_cmd)
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
 
{<section id="afmt555.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afmt555_set_no_entry_b(p_cmd)
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
 
{<section id="afmt555.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt555_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail,open_afmt555_02", TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt555_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_fmmq_m.fmmqstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail,open_afmt555_02", FALSE)
   END IF

   IF cl_null(g_fmmq_m.fmmqdocno) THEN
      CALL cl_set_act_visible("open_afmt555_02", FALSE)
   END IF
          
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afmt555_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afmt555_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt555_default_search()
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
      LET ls_wc = ls_wc, " fmmqdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "fmmq_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fmmr_t" 
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
 
{<section id="afmt555.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afmt555_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fmmq_m.fmmqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afmt555_cl USING g_enterprise,g_fmmq_m.fmmqdocno
   IF STATUS THEN
      CLOSE afmt555_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt555_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afmt555_master_referesh USING g_fmmq_m.fmmqdocno INTO g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001, 
       g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003,g_fmmq_m.fmmq004,g_fmmq_m.fmmqstus, 
       g_fmmq_m.fmmqownid,g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtdp,g_fmmq_m.fmmqcrtdt, 
       g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmoddt,g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfdt,g_fmmq_m.fmmqsite_desc, 
       g_fmmq_m.fmmq001_desc,g_fmmq_m.fmmqownid_desc,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid_desc, 
       g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT afmt555_action_chk() THEN
      CLOSE afmt555_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmmq_m.fmmqsite,g_fmmq_m.fmmqsite_desc,g_fmmq_m.fmmq001,g_fmmq_m.fmmq001_desc,g_fmmq_m.l_fmmqcomp, 
       g_fmmq_m.fmmqcomp_desc,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003, 
       g_fmmq_m.fmmq004,g_fmmq_m.l_curr,g_fmmq_m.fmmqstus,g_fmmq_m.fmmqownid,g_fmmq_m.fmmqownid_desc, 
       g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtid_desc,g_fmmq_m.fmmqcrtdp, 
       g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqcrtdt,g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqmoddt, 
       g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfid_desc,g_fmmq_m.fmmqcnfdt
 
   CASE g_fmmq_m.fmmqstus
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
         CASE g_fmmq_m.fmmqstus
            
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
     
      CASE g_fmmq_m.fmmqstus
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
            CALL s_transaction_end('N','0')        #150401-00001#13
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
            IF NOT afmt555_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt555_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afmt555_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt555_cl
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
      g_fmmq_m.fmmqstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afmt555_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      IF g_fmmq_m.fmmqstus = 'N' THEN
         CALL cl_err_collect_init()
         CALL s_afmt555_conf_chk(g_fmmq_m.fmmqdocno) RETURNING g_sub_success
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
               CALL s_afmt555_conf_upd(g_fmmq_m.fmmqdocno) RETURNING g_sub_success
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
      CALL s_afmt555_unconf_chk(g_fmmq_m.fmmqdocno) RETURNING g_sub_success
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
            CALL s_afmt555_unconf_upd(g_fmmq_m.fmmqdocno) RETURNING g_sub_success
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
      CALL s_afmt555_void_chk(g_fmmq_m.fmmqdocno) RETURNING g_sub_success
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
            CALL s_afmt555_void_upd(g_fmmq_m.fmmqdocno) RETURNING g_sub_success
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
   
   LET g_fmmq_m.fmmqmodid = g_user
   LET g_fmmq_m.fmmqmoddt = cl_get_current()
   LET g_fmmq_m.fmmqstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fmmq_t 
      SET (fmmqstus,fmmqmodid,fmmqmoddt) 
        = (g_fmmq_m.fmmqstus,g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmoddt)     
    WHERE fmmqent = g_enterprise AND fmmqdocno = g_fmmq_m.fmmqdocno
 
    
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
      EXECUTE afmt555_master_referesh USING g_fmmq_m.fmmqdocno INTO g_fmmq_m.fmmqsite,g_fmmq_m.fmmq001, 
          g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002,g_fmmq_m.fmmq003,g_fmmq_m.fmmq004,g_fmmq_m.fmmqstus, 
          g_fmmq_m.fmmqownid,g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtdp,g_fmmq_m.fmmqcrtdt, 
          g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmoddt,g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfdt,g_fmmq_m.fmmqsite_desc, 
          g_fmmq_m.fmmq001_desc,g_fmmq_m.fmmqownid_desc,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid_desc, 
          g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fmmq_m.fmmqsite,g_fmmq_m.fmmqsite_desc,g_fmmq_m.fmmq001,g_fmmq_m.fmmq001_desc, 
          g_fmmq_m.l_fmmqcomp,g_fmmq_m.fmmqcomp_desc,g_fmmq_m.fmmqdocno,g_fmmq_m.fmmqdocdt,g_fmmq_m.fmmq002, 
          g_fmmq_m.fmmq003,g_fmmq_m.fmmq004,g_fmmq_m.l_curr,g_fmmq_m.fmmqstus,g_fmmq_m.fmmqownid,g_fmmq_m.fmmqownid_desc, 
          g_fmmq_m.fmmqowndp,g_fmmq_m.fmmqowndp_desc,g_fmmq_m.fmmqcrtid,g_fmmq_m.fmmqcrtid_desc,g_fmmq_m.fmmqcrtdp, 
          g_fmmq_m.fmmqcrtdp_desc,g_fmmq_m.fmmqcrtdt,g_fmmq_m.fmmqmodid,g_fmmq_m.fmmqmodid_desc,g_fmmq_m.fmmqmoddt, 
          g_fmmq_m.fmmqcnfid,g_fmmq_m.fmmqcnfid_desc,g_fmmq_m.fmmqcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afmt555_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt555_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt555.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afmt555_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fmmr_d.getLength() THEN
         LET g_detail_idx = g_fmmr_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmmr_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmmr_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_fmmr2_d.getLength() THEN
         LET g_detail_idx = g_fmmr2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmmr2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmmr2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmt555_b_fill2(pi_idx)
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
   
   CALL afmt555_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afmt555_fill_chk(ps_idx)
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
 
{<section id="afmt555.status_show" >}
PRIVATE FUNCTION afmt555_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt555.mask_functions" >}
&include "erp/afm/afmt555_mask.4gl"
 
{</section>}
 
{<section id="afmt555.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afmt555_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL afmt555_show()
   CALL afmt555_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #151013-00016#11 151106 by sakura add(S)
   IF NOT s_afmt555_unconf_chk(g_fmmq_m.fmmqdocno) THEN
      CLOSE afmt555_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #151013-00016#11 151106 by sakura add(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fmmq_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fmmr_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_fmmr2_d))
 
 
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
   #CALL afmt555_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afmt555_ui_headershow()
   CALL afmt555_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afmt555_draw_out()
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
   CALL afmt555_ui_headershow()  
   CALL afmt555_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afmt555.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt555_set_pk_array()
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
   LET g_pk_array[1].values = g_fmmq_m.fmmqdocno
   LET g_pk_array[1].column = 'fmmqdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt555.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afmt555.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt555_msgcentre_notify(lc_state)
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
   CALL afmt555_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmmq_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt555.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmt555_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#13 2016/08/23 By 07900 -add-s-
   SELECT fmmqstus INTO g_fmmq_m.fmmqstus
     FROM fmmq_t
    WHERE fmmqent = g_enterprise
      AND fmmqdocno = g_fmmq_m.fmmqdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
    LET g_errno = NULL    
    CASE g_fmmq_m.fmmqstus       
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
        LET g_errparam.extend = g_fmmq_m.fmmqdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afmt555_set_act_visible()
        CALL afmt555_set_act_no_visible()
        CALL afmt555_show()
        RETURN FALSE
     END IF
   END IF
   
   #160818-00017#13 2016/08/23 By 07900 -add-e-
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt555.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得帳套預設資料
# Memo...........:
# Usage..........: CALL afmt555_set_ld_info(p_ld)
# Input parameter: p_ld        帳套
# Return code....: comp        法人
# Date & Author..: 2015/05/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt555_set_ld_info(p_ld)
DEFINE p_ld        LIKE apca_t.apcald
DEFINE l_comp      LIKE apca_t.apcacomp
DEFINE l_ld        LIKE apca_t.apcald
   
   WHENEVER ERROR CONTINUE
   
   CALL s_ld_sel_glaa(p_ld,'glaacomp|glaa004|glaa015|glaa019|glaa024|glaa102|glaa121|glaa001|glaa016|glaa020')
        RETURNING g_sub_success,g_glaa.*
   CALL s_ld_sel_glaa(p_ld,'glaa001')
        RETURNING g_sub_success,g_fmmq_m.l_curr
   DISPLAY BY NAME g_fmmq_m.l_curr
   #取得所屬法人+帳別
   CALL s_fin_orga_get_comp_ld(g_fmmq_m.fmmqsite) 
      RETURNING g_sub_success,g_errno,l_comp,l_ld
   
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_fmmq_m.fmmqsite,g_fmmq_m.fmmqdocdt,'1')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_fmmqsite
   CALL s_fin_get_wc_str(g_wc_fmmqsite) RETURNING g_wc_fmmqsite
   CALL s_fin_account_center_ld_str()  RETURNING g_wc_fmmq001
   CALL s_fin_get_wc_str(g_wc_fmmq001) RETURNING g_wc_fmmq001
   
   
   IF g_glaa.glaa015 = 'N' AND  g_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('fmmr007,fmmr008,fmmr009,fmmr010',FALSE)   #本位幣隱藏
   ELSE
      #本幣二
      IF g_glaa.glaa015 = 'Y' THEN
         CALL cl_set_comp_visible('fmmr007,fmmr008',TRUE)
      ELSE
         CALL cl_set_comp_visible('fmmr007,fmmr008',FALSE)
      END IF

      #本幣三
      IF g_glaa.glaa019 = 'Y' THEN
         CALL cl_set_comp_visible('fmmr009,fmmr010',TRUE)
      ELSE
         CALL cl_set_comp_visible('fmmr009,fmmr010',FALSE)
      END IF
   END IF

   #是否啟用分錄底稿
   IF g_glaa.glaa121 = 'Y' THEN
      CALL cl_set_act_visible("open_pre", TRUE)
   ELSE
      CALL cl_set_act_visible("open_pre", FALSE)
   END IF
   
   RETURN l_comp
END FUNCTION

################################################################################
# Descriptions...: 投資購買單號檢查
# Memo...........:
# Usage..........: CALL afmt555_fmmr002_chk()
# Date & Author..: 2015/05/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt555_fmmr002_chk()
DEFINE l_fmmpsuts      LIKE fmmp_t.fmmpstus
DEFINE l_count         LIKE type_t.num5
DEFINE r_success       LIKE type_t.chr1
DEFINE r_errno         LIKE gzze_t.gzze001

   LET r_success = TRUE
   LET r_errno = NULL
   #是否存在aft550
   SELECT COUNT(*) INTO l_count
     FROM fmmp_t
    WHERE fmmpent = g_enterprise
      AND fmmpld  = g_fmmq_m.fmmq001
      AND fmmp001 = g_fmmq_m.fmmq002
      AND fmmp002 = g_fmmq_m.fmmq003
      AND fmmp003 = g_fmmr_d[l_ac].fmmr001
      AND fmmp004 = g_fmmr_d[l_ac].fmmr002
      AND fmmpstus = 'Y'
   
   IF cl_null(l_count) THEN
      LET l_count = 0 
   END IF
   
  
      IF l_count = 0 THEN
         LET r_errno = 'afm-00107' 
         LET r_success = FALSE
      END IF
   
   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 投資購買單號帶出相關資訊
# Memo...........:
# Usage..........: CALL afmt555_fmmr002_info()
# Date & Author..: 2015/05/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt555_fmmr002_info()
  
  #投資標的 投資類型  購入幣別
   SELECT fmmj004,fmmj003,fmmj006 
     INTO g_fmmr_d[l_ac].l_fmmj004,g_fmmr_d[l_ac].l_fmmj003,g_fmmr_d[l_ac].fmmr003
     FROM fmmj_t
    WHERE fmmjent = g_enterprise
      AND fmmjdocno = g_fmmr_d[l_ac].fmmr002

   #留倉金額 期末公允價值 價值變動差額
   SELECT fmmp006,fmmp007,fmmp009
     INTO g_fmmr_d[l_ac].l_fmmp006,g_fmmr_d[l_ac].l_fmmp007,g_fmmr_d[l_ac].fmmr004
     FROM fmmp_t
    WHERE fmmpent = g_enterprise
      AND fmmpld = g_fmmq_m.fmmq001
      AND fmmp001 = g_fmmq_m.fmmq002
      AND fmmp002 = g_fmmq_m.fmmq003
      AND fmmp003 = g_fmmr_d[l_ac].fmmr001
      AND fmmp004 = g_fmmr_d[l_ac].fmmr002  
      
   IF cl_null(g_fmmr_d[l_ac].l_fmmp006) THEN LET g_fmmr_d[l_ac].l_fmmp006 = 0 ENd IF 
   IF cl_null(g_fmmr_d[l_ac].l_fmmp007) THEN LET g_fmmr_d[l_ac].l_fmmp007 = 0 ENd IF 
   IF cl_null(g_fmmr_d[l_ac].fmmr004) THEN LET g_fmmr_d[l_ac].fmmr004 = 0 ENd IF
    
   #公允價值變動科目
   SELECT fmmb004 INTO g_fmmr2_d[l_ac].fmmr011 
     FROM fmmb_t 
    WHERE fmmbent = g_enterprise
      AND fmmb002 = g_fmmq_m.fmmq001
      AND fmmb001 = g_fmmr_d[l_ac].l_fmmj003
   
   #損益科目   
   IF g_fmmr_d[l_ac].fmmr004 >= 0 THEN 
     CALL s_fin_get_account(g_fmmq_m.fmmq001,'25','8318','8318_11')  #重評價匯兌收益
         RETURNING g_sub_success,g_fmmr2_d[l_ac].fmmr012,g_errno
   ELSE
      CALL s_fin_get_account(g_fmmq_m.fmmq001,'25','8318','8318_11') #重評價匯兌損失
         RETURNING g_sub_success,g_fmmr2_d[l_ac].fmmr012,g_errno
   END IF
   
   #金額先取位
   CALL s_curr_round_ld('1',g_fmmq_m.fmmq001,g_fmmr_d[l_ac].fmmr003,g_fmmr_d[l_ac].fmmr004,3) 
      RETURNING g_sub_success,g_errno,g_fmmr_d[l_ac].fmmr004
   #取得帳套對應幣別匯率 
   CALL s_fin_get_curr_rate(g_fmmq_m.l_fmmqcomp,g_fmmq_m.fmmq001,g_fmmq_m.fmmqdocdt,g_fmmr_d[l_ac].fmmr003,'')
        RETURNING g_fmmr_d[l_ac].fmmr005,g_fmmr_d[l_ac].fmmr007,g_fmmr_d[l_ac].fmmr009   
        
   #取得金額
   CALL s_afm_rate_money(g_fmmq_m.fmmq001,g_fmmr_d[l_ac].fmmr005,g_fmmr_d[l_ac].fmmr007,
                            g_fmmr_d[l_ac].fmmr009,g_fmmr_d[l_ac].fmmr004)   
        RETURNING g_fmmr_d[l_ac].fmmr006,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr010
        
   
   DISPLAY BY NAME g_fmmr_d[l_ac].l_fmmj004,g_fmmr_d[l_ac].l_fmmj003,g_fmmr_d[l_ac].fmmr003,
                   g_fmmr_d[l_ac].l_fmmp006,g_fmmr_d[l_ac].l_fmmp007,g_fmmr_d[l_ac].fmmr004,
                   g_fmmr2_d[l_ac].fmmr011,g_fmmr2_d[l_ac].fmmr012,
                   g_fmmr_d[l_ac].fmmr006,g_fmmr_d[l_ac].fmmr008,g_fmmr_d[l_ac].fmmr010                   
              


END FUNCTION

################################################################################
# Descriptions...: 投資購買單相關資訊
# Memo...........:
# Usage..........: CALL afmt555_fmmr002_ref()
# Date & Author..: 2015/05/18 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt555_fmmr002_ref()
 #投資標的 投資類型  
   SELECT fmmj004,fmmj003 
     INTO g_fmmr_d[l_ac].l_fmmj004,g_fmmr_d[l_ac].l_fmmj003
     FROM fmmj_t
    WHERE fmmjent = g_enterprise
      AND fmmjdocno = g_fmmr_d[l_ac].fmmr002

   #留倉金額 期末公允價值 
   SELECT fmmp006,fmmp007
     INTO g_fmmr_d[l_ac].l_fmmp006,g_fmmr_d[l_ac].l_fmmp007
     FROM fmmp_t
    WHERE fmmpent = g_enterprise
      AND fmmpld = g_fmmq_m.fmmq001
      AND fmmp001 = g_fmmq_m.fmmq002
      AND fmmp002 = g_fmmq_m.fmmq003
      AND fmmp003 = g_fmmr_d[l_ac].fmmr001
      AND fmmp004 = g_fmmr_d[l_ac].fmmr002  
   IF cl_null(g_fmmr_d[l_ac].l_fmmp006) THEN LET g_fmmr_d[l_ac].l_fmmp006 = 0 ENd IF 
   IF cl_null(g_fmmr_d[l_ac].l_fmmp007) THEN LET g_fmmr_d[l_ac].l_fmmp007 = 0 ENd IF 
   
   
   
END FUNCTION

 
{</section>}
 
