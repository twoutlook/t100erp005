#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt940.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0027(2016-08-23 15:23:04), PR版次:0027(2017-01-23 17:24:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000144
#+ Filename...: aapt940
#+ Description: 帳齡及壞帳提列維護
#+ Creator....: 03080(2014-10-29 10:33:56)
#+ Modifier...: 08729 -SD/PR- 04152
 
{</section>}
 
{<section id="aapt940.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#141218-00011#6              By Belle    單身維護時：其他信息的核算，不必檢核是否有輸入及合理性。
#141202-00061#17             By Belle    產生分錄底稿
#150116                      By albireo  核算項檢核風格統一
#150126-00027#1              By Belle    增加傳票補號
#150202-00002#1              By Reanna   月結部份不用判斷單別是否拋傳票，都要拋
#150205-00012#1              BY Hans     進欄位之後只顯示編號不顯示中文名稱
#150302                      By albireo  核算項修改(責任中心,專案,WBS)
#140818-00002#2              By albireo  科目取聯集與核算項控制的問題修正
#150323                      By Reanna   拋傳票時日期default單據日期
#150506-00033#6              By RayHuang 新增單據串查功能
#150527-00020#1              By Reanna   傳票還原增加簡和總帳關帳日
#150401-00001#13             By RayHuang statechange段問題修正
#150916-00015#1   2015/12/07 By Xiaozg   1.快捷带出类似科目编号 2. 当有账套时，科目检查改为检查是否存在于glad_t中
#160125-00005#6   2016/02/15 By 02097    查詢時，只顯示有權限的帳套
#160225-00001#1   2016/03/04 By 02097    參數D-FIN-0033=N 時不管什麼欄位都不可異動
#160321-00016#22  2016/03/24 By Jessy    修正azzi920重複定義之錯誤訊息
#160818-00017#2   2016/08/24 By 07900    删除修改未重新判断状态码
#161011-00019#1   2016/10/12 By dorishsu 傳票未確認才可還原
#161006-00005#6   2016/10/14 By 08732    組織類型與職能開窗調整
#161014-00053#4   2016/10/24 By 08171    帳套權限調整
#161115-00044#1   2016/11/22 By 08729    開窗增加過濾據點
#161104-00046#8   2017/01/03 By 06821    單別預設值;資料依照單別user dept權限過濾單號
#170103-00019#7   2017/01/09 By Reanna   产生凭证时，应一并检核立冲否，并写入立冲明细表；为科目冲销时，明细操作的立冲处理需开放点选。
#161213-00023#2   2017/01/12 By 06694    新增aapp330_01元件單別參數，默認拋轉單別
#161229-00047#66  2017/01/20 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#170120-00017#1   2017/01/23 By Reanna   修改#170103-00019#7還原時的bug
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
PRIVATE type type_g_xrej_m        RECORD
       xrejsite LIKE xrej_t.xrejsite, 
   xrejsite_desc LIKE type_t.chr80, 
   xrejld LIKE xrej_t.xrejld, 
   xrejld_desc LIKE type_t.chr80, 
   xrej004 LIKE xrej_t.xrej004, 
   xrej004_desc LIKE type_t.chr80, 
   xrejdocno LIKE xrej_t.xrejdocno, 
   xrejdocdt LIKE xrej_t.xrejdocdt, 
   xrej001 LIKE xrej_t.xrej001, 
   xrej002 LIKE xrej_t.xrej002, 
   xrej005 LIKE xrej_t.xrej005, 
   xrejstus LIKE xrej_t.xrejstus, 
   xrejownid LIKE xrej_t.xrejownid, 
   xrejownid_desc LIKE type_t.chr80, 
   xrejowndp LIKE xrej_t.xrejowndp, 
   xrejowndp_desc LIKE type_t.chr80, 
   xrejcrtid LIKE xrej_t.xrejcrtid, 
   xrejcrtid_desc LIKE type_t.chr80, 
   xrejcrtdp LIKE xrej_t.xrejcrtdp, 
   xrejcrtdp_desc LIKE type_t.chr80, 
   xrejcrtdt LIKE xrej_t.xrejcrtdt, 
   xrejmodid LIKE xrej_t.xrejmodid, 
   xrejmodid_desc LIKE type_t.chr80, 
   xrejmoddt LIKE xrej_t.xrejmoddt, 
   xrejcnfid LIKE xrej_t.xrejcnfid, 
   xrejcnfid_desc LIKE type_t.chr80, 
   xrejcnfdt LIKE xrej_t.xrejcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xrek_d        RECORD
       xrekseq LIKE xrek_t.xrekseq, 
   xrek005 LIKE xrek_t.xrek005, 
   xrek006 LIKE xrek_t.xrek006, 
   xrek007 LIKE xrek_t.xrek007, 
   xrek100 LIKE xrek_t.xrek100, 
   xrek103 LIKE xrek_t.xrek103, 
   xrek113 LIKE xrek_t.xrek113, 
   xrek037 LIKE xrek_t.xrek037, 
   xrek039 LIKE xrek_t.xrek039, 
   xrek105 LIKE xrek_t.xrek105, 
   xrek115 LIKE xrek_t.xrek115, 
   xrek104 LIKE xrek_t.xrek104, 
   xrek114 LIKE xrek_t.xrek114, 
   xrek038 LIKE xrek_t.xrek038, 
   xrek040 LIKE xrek_t.xrek040, 
   xrek106 LIKE xrek_t.xrek106, 
   xrek116 LIKE xrek_t.xrek116, 
   xrek107 LIKE xrek_t.xrek107, 
   xrek117 LIKE xrek_t.xrek117
       END RECORD
PRIVATE TYPE type_g_xrek2_d RECORD
       xrekseq LIKE xrek_t.xrekseq, 
   xrek033 LIKE xrek_t.xrek033, 
   xrek019 LIKE xrek_t.xrek019, 
   l_xrek019_desc LIKE type_t.chr500, 
   xrek041 LIKE xrek_t.xrek041, 
   l_xrek041_desc LIKE type_t.chr500, 
   xrekorga LIKE xrek_t.xrekorga, 
   l_xrekorga_desc LIKE type_t.chr500, 
   xrek009 LIKE xrek_t.xrek009, 
   l_xrek009_desc LIKE type_t.chr500, 
   xrek016 LIKE xrek_t.xrek016, 
   l_xrek016_desc LIKE type_t.chr500, 
   xrek011 LIKE xrek_t.xrek011, 
   l_xrek011_desc LIKE type_t.chr500, 
   xrek012 LIKE xrek_t.xrek012, 
   l_xrek012_desc LIKE type_t.chr500, 
   xrek013 LIKE xrek_t.xrek013, 
   l_xrek013_desc LIKE type_t.chr500, 
   xrek014 LIKE xrek_t.xrek014, 
   l_xrek014_desc LIKE type_t.chr500, 
   xrek015 LIKE xrek_t.xrek015, 
   l_xrek015_desc LIKE type_t.chr500, 
   xrek017 LIKE xrek_t.xrek017, 
   l_xrek017_desc LIKE type_t.chr500, 
   xrek018 LIKE xrek_t.xrek018, 
   l_xrek018_desc LIKE type_t.chr500, 
   xrek020 LIKE xrek_t.xrek020, 
   xrek021 LIKE xrek_t.xrek021, 
   l_xrek021_desc LIKE type_t.chr500, 
   xrek022 LIKE xrek_t.xrek022, 
   l_xrek022_desc LIKE type_t.chr500, 
   xrek023 LIKE xrek_t.xrek023, 
   l_xrek023_desc LIKE type_t.chr500, 
   xrek024 LIKE xrek_t.xrek024, 
   l_xrek024_desc LIKE type_t.chr500, 
   xrek025 LIKE xrek_t.xrek025, 
   l_xrek025_desc LIKE type_t.chr500, 
   xrek026 LIKE xrek_t.xrek026, 
   l_xrek026_desc LIKE type_t.chr500, 
   xrek027 LIKE xrek_t.xrek027, 
   l_xrek027_desc LIKE type_t.chr500, 
   xrek028 LIKE xrek_t.xrek028, 
   l_xrek028_desc LIKE type_t.chr500, 
   xrek029 LIKE xrek_t.xrek029, 
   l_xrek029_desc LIKE type_t.chr500, 
   xrek030 LIKE xrek_t.xrek030, 
   l_xrek030_desc LIKE type_t.chr500, 
   xrek031 LIKE xrek_t.xrek031, 
   l_xrek031_desc LIKE type_t.chr500, 
   xrek032 LIKE xrek_t.xrek032, 
   l_xrek032_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xrejdocno LIKE xrej_t.xrejdocno,
      b_xrej001 LIKE xrej_t.xrej001,
      b_xrej002 LIKE xrej_t.xrej002,
      b_xrej004 LIKE xrej_t.xrej004
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#140818-00002#2 albireo 150316-----s
#修正LIKE範圍
#DEFINE g_glad        RECORD LIKE glad_t.*
DEFINE g_glad        RECORD
            glad017    LIKE  glad_t.glad017, 
            glad018    LIKE  glad_t.glad018,
            glad019    LIKE  glad_t.glad019,
            glad020    LIKE  glad_t.glad020,
            glad021    LIKE  glad_t.glad021,
            glad022    LIKE  glad_t.glad022,
            glad023    LIKE  glad_t.glad023,
            glad024    LIKE  glad_t.glad024,
            glad025    LIKE  glad_t.glad025,
            glad026    LIKE  glad_t.glad026,
            glad0171   LIKE  glad_t.glad0171,
            glad0172   LIKE  glad_t.glad0172,
            glad0181   LIKE  glad_t.glad0181,
            glad0182   LIKE  glad_t.glad0182,
            glad0191   LIKE  glad_t.glad0191,
            glad0192   LIKE  glad_t.glad0192,
            glad0201   LIKE  glad_t.glad0201,
            glad0202   LIKE  glad_t.glad0202,
            glad0211   LIKE  glad_t.glad0211,
            glad0212   LIKE  glad_t.glad0212,
            glad0221   LIKE  glad_t.glad0221,
            glad0222   LIKE  glad_t.glad0222,
            glad0231   LIKE  glad_t.glad0231,
            glad0232   LIKE  glad_t.glad0232,
            glad0241   LIKE  glad_t.glad0241,
            glad0242   LIKE  glad_t.glad0242,
            glad0251   LIKE  glad_t.glad0251,
            glad0252   LIKE  glad_t.glad0252,
            glad0261   LIKE  glad_t.glad0261,                  
            glad0262   LIKE  glad_t.glad0262
                     END RECORD
#140818-00002#2 albireo 150316-----e
DEFINE g_glaa004     LIKE glaa_t.glaa004
DEFINE g_glaa121     LIKE glaa_t.glaa121     #是否啟用分錄底稿
 TYPE type_g_xrek3_d RECORD
             xrekseq   LIKE xrek_t.xrekseq,
             xrek005   LIKE xrek_t.xrek005,
             xrek006   LIKE xrek_t.xrek006,
             xrek007   LIKE xrek_t.xrek007,
             xrek100   LIKE xrek_t.xrek100,
             xrek103   LIKE xrek_t.xrek103,
             xrek113   LIKE xrek_t.xrek113,
             xrek037   LIKE xrek_t.xrek037,
             xrek039   LIKE xrek_t.xrek039,
             xrek105   LIKE xrek_t.xrek105,
             xrek115   LIKE xrek_t.xrek115
             END RECORD
             
 TYPE type_g_xrek4_d RECORD
             xrekseq   LIKE xrek_t.xrekseq,
             xrek005   LIKE xrek_t.xrek005,
             xrek006   LIKE xrek_t.xrek006,
             xrek007   LIKE xrek_t.xrek007,
             xrek100   LIKE xrek_t.xrek100,
             xrek104   LIKE xrek_t.xrek104,
             xrek114   LIKE xrek_t.xrek114,
             xrek038   LIKE xrek_t.xrek038,
             xrek040   LIKE xrek_t.xrek040,
             xrek106   LIKE xrek_t.xrek106,
             xrek116   LIKE xrek_t.xrek116
             END RECORD
DEFINE g_xrek3_d          DYNAMIC ARRAY OF type_g_xrek3_d    
DEFINE g_xrek4_d          DYNAMIC ARRAY OF type_g_xrek4_d
DEFINE g_glaa102          LIKE glaa_t.glaa102
DEFINE g_dfin0030         LIKE type_t.chr1           #141202-00061#17
DEFINE g_ap_slip          LIKE apca_t.apcadocno      #141202-00061#17
DEFINE g_glaacomp         LIKE glaa_t.glaacomp       #141202-00061#17
DEFINE g_wc_cs_ld            STRING                #160125-00005#6
DEFINE g_site_str            STRING                #161014-00053#4
DEFINE g_sql_ctrl            STRING                #161115-00044#1-add
#161104-00046#8 --s add
DEFINE g_user_dept_wc        STRING     
DEFINE g_user_dept_wc_q      STRING     
#161104-00046#8 --e add
#161229-00047#66 add ------
DEFINE g_wc_cs_comp      STRING
DEFINE g_comp_str        STRING
#161229-00047#66 add end---
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xrej_m          type_g_xrej_m
DEFINE g_xrej_m_t        type_g_xrej_m
DEFINE g_xrej_m_o        type_g_xrej_m
DEFINE g_xrej_m_mask_o   type_g_xrej_m #轉換遮罩前資料
DEFINE g_xrej_m_mask_n   type_g_xrej_m #轉換遮罩後資料
 
   DEFINE g_xrejdocno_t LIKE xrej_t.xrejdocno
 
 
DEFINE g_xrek_d          DYNAMIC ARRAY OF type_g_xrek_d
DEFINE g_xrek_d_t        type_g_xrek_d
DEFINE g_xrek_d_o        type_g_xrek_d
DEFINE g_xrek_d_mask_o   DYNAMIC ARRAY OF type_g_xrek_d #轉換遮罩前資料
DEFINE g_xrek_d_mask_n   DYNAMIC ARRAY OF type_g_xrek_d #轉換遮罩後資料
DEFINE g_xrek2_d          DYNAMIC ARRAY OF type_g_xrek2_d
DEFINE g_xrek2_d_t        type_g_xrek2_d
DEFINE g_xrek2_d_o        type_g_xrek2_d
DEFINE g_xrek2_d_mask_o   DYNAMIC ARRAY OF type_g_xrek2_d #轉換遮罩前資料
DEFINE g_xrek2_d_mask_n   DYNAMIC ARRAY OF type_g_xrek2_d #轉換遮罩後資料
 
 
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
 
{<section id="aapt940.main" >}
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
   CALL s_fin_create_account_center_tmp()                      #160125-00005#6
   CALL s_fin_azzi800_sons_query(g_today)                      #160125-00005#6
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld     #160125-00005#6
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld      #160125-00005#6
   #161115-00044#1-add(s)
   SELECT ooef017 INTO g_glaacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_glaacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#66 mark
   #161115-00044#1-add(s)
   #161229-00047#66 add ------
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#66 add end---
   #161104-00046#8 --s add
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','xrejld','xrejent','xrejdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc 
   #161104-00046#8 --e add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xrejsite,'',xrejld,'',xrej004,'',xrejdocno,xrejdocdt,xrej001,xrej002, 
       xrej005,xrejstus,xrejownid,'',xrejowndp,'',xrejcrtid,'',xrejcrtdp,'',xrejcrtdt,xrejmodid,'',xrejmoddt, 
       xrejcnfid,'',xrejcnfdt", 
                      " FROM xrej_t",
                      " WHERE xrejent= ? AND xrejdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt940_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xrejsite,t0.xrejld,t0.xrej004,t0.xrejdocno,t0.xrejdocdt,t0.xrej001, 
       t0.xrej002,t0.xrej005,t0.xrejstus,t0.xrejownid,t0.xrejowndp,t0.xrejcrtid,t0.xrejcrtdp,t0.xrejcrtdt, 
       t0.xrejmodid,t0.xrejmoddt,t0.xrejcnfid,t0.xrejcnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooag011",
               " FROM xrej_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xrejownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xrejowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.xrejcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.xrejcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.xrejmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.xrejcnfid  ",
 
               " WHERE t0.xrejent = " ||g_enterprise|| " AND t0.xrejdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapt940_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapt940 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapt940_init()   
 
      #進入選單 Menu (="N")
      CALL aapt940_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapt940
      
   END IF 
   
   CLOSE aapt940_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapt940.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapt940_init()
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
      CALL cl_set_combo_scc_part('xrejstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL aapt940_01_create_tmp()
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_set_comp_scc('xrej002','111')  #13期
   CALL s_fin_set_comp_scc('xrej001','43')   #年度
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #啟用分錄底稿用
   CALL s_fin_continue_no_tmp()               #150126-00027#1
   CALL cl_set_combo_scc('xrek020','6013') 
   #end add-point
   
   #初始化搜尋條件
   CALL aapt940_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aapt940.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aapt940_ui_dialog()
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
   DEFINE l_comp        LIKE ooef_t.ooef001
   DEFINE l_para_data   LIKE type_t.dat
   DEFINE l_slip        LIKE glap_t.glapdocno
   DEFINE l_date        LIKE glap_t.glapdocdt
   DEFINE l_count       LIKE type_t.num5
   DEFINE l_start_no    LIKE glap_t.glapdocno
   DEFINE l_stus        LIKE glap_t.glapstus
   DEFINE l_success_doc LIKE xrej_t.xrejdocno
   DEFINE l_glaa013     LIKE glaa_t.glaa013    #150527-00020#1
   DEFINE l_glapdocdt   LIKE glap_t.glapdocdt  #150527-00020#1
   #170103-00019#7 add ------
   DEFINE l_scom0002    LIKE type_t.chr10
   DEFINE l_success     LIKE type_t.num5
   #170103-00019#7 add end---
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
            CALL aapt940_insert()
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
         INITIALIZE g_xrej_m.* TO NULL
         CALL g_xrek_d.clear()
         CALL g_xrek2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapt940_init()
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
               
               CALL aapt940_fetch('') # reload data
               LET l_ac = 1
               CALL aapt940_ui_detailshow() #Setting the current row 
         
               CALL aapt940_idx_chk()
               #NEXT FIELD xrekseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_xrek_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt940_idx_chk()
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
               CALL aapt940_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_xrek005
                  LET g_action_choice="prog_xrek005"
                  IF cl_auth_chk_act("prog_xrek005") THEN
                     
                     #add-point:ON ACTION prog_xrek005 name="menu.detail_show.page1_sub.prog_xrek005"
                     CALL aapt940_qrystr(g_xrej_m.xrejld,g_xrek_d[g_detail_idx].xrek005)   #150506-00033#6
                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xrek2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt940_idx_chk()
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
               CALL aapt940_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xrek3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         END DISPLAY
         
         DISPLAY ARRAY g_xrek4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aapt940_browser_fill("")
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
               CALL aapt940_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aapt940_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aapt940_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL cl_set_act_visible("insert,reproduce,modify", FALSE)
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aapt940_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aapt940_set_act_visible()   
            CALL aapt940_set_act_no_visible()
            IF NOT (g_xrej_m.xrejdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xrejent = " ||g_enterprise|| " AND",
                                  " xrejdocno = '", g_xrej_m.xrejdocno, "' "
 
               #填到對應位置
               CALL aapt940_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "xrej_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrek_t" 
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
               CALL aapt940_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "xrej_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrek_t" 
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
                  CALL aapt940_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapt940_fetch("F")
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
               CALL aapt940_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aapt940_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt940_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aapt940_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt940_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aapt940_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt940_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aapt940_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt940_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aapt940_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt940_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xrek_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xrek2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[3] = base.typeInfo.create(g_xrek3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_xrek4_d)
                  LET g_export_id[4]   = "s_detail4"
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
               NEXT FIELD xrekseq
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
               CALL aapt940_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aapt940_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               #141202-00061#17--產生分錄底稿
               IF NOT cl_null(g_xrej_m.xrejdocno) AND g_xrej_m.xrejstus = 'N' THEN
                  CALL s_pre_voucher_ins('AP','P60',g_xrej_m.xrejld,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,'1')
                       RETURNING g_sub_success
               END IF
               #141202-00061#17--產生分錄底稿
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt300_14
            LET g_action_choice="open_aapt300_14"
            IF cl_auth_chk_act("open_aapt300_14") THEN
               
               #add-point:ON ACTION open_aapt300_14 name="menu.open_aapt300_14"
               IF g_xrej_m.xrejdocno IS NULL THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "std-00003" 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               #傳票預覽
               #141202-00061#17
               CALL s_ld_sel_glaa(g_xrej_m.xrejld,'glaa121') RETURNING g_sub_success,g_glaa121
               IF g_glaa121 = 'Y' THEN               
                  CALL s_pre_voucher('AP','P60',g_xrej_m.xrejld,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt)
               ELSE
               #141202-00061#17
                  CALL aapt300_14(g_xrej_m.xrejld,g_xrej_m.xrejdocno,'1')
               END IF        #141202-00061#17
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION voucher_redo
            LET g_action_choice="voucher_redo"
            IF cl_auth_chk_act("voucher_redo") THEN
               
               #add-point:ON ACTION voucher_redo name="menu.voucher_redo"
               CALL s_transaction_begin() #150527-00020#1
               IF g_xrej_m.xrejdocno IS NULL THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "std-00003" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0') #150527-00020#1
                  CONTINUE DIALOG
               END IF
               #無傳票 不可還原
               IF g_xrej_m.xrej005 IS NULL THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "anm-00186" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0') #150527-00020#1
                  CONTINUE DIALOG               
               END IF
               
               #150527-00020#1 add ------
               #傳票還原單據日期不可大於過帳日期
               SELECT glapdocdt INTO l_glapdocdt
                 FROM glap_t
                WHERE glapent = g_enterprise
                  AND glapld = g_xrej_m.xrejld
                  AND glapdocno = g_xrej_m.xrej005
               
               SELECT glaa013 INTO l_glaa013
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald = g_xrej_m.xrejld
               
               IF l_glapdocdt <= l_glaa013 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00077'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               #150527-00020#1 add end---
               
               IF NOT cl_ask_confirm('aap-00239') THEN
                  CALL s_transaction_end('N','0') #150527-00020#1
                  EXIT DIALOG
               ELSE      
                  #傳票已經確認不可還原               
                  SELECT glapstus INTO l_stus
                    FROM glap_t
                   WHERE glapent = g_enterprise
                     AND glapdocno = g_xrej_m.xrej005
                  
                  #IF l_stus = 'Y' THEN              #161011-00019#1 mark
                  IF l_stus NOT MATCHES '[N]' THEN   #161011-00019#1 add
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00076'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0') #150527-00020#1
                  ELSE           
                     #170103-00019#7 add ------
                     #更新相关的细项立冲账资料
                     LET l_success = TRUE
                     CALL cl_get_para(g_enterprise,g_glaacomp,'S-COM-0002') RETURNING l_scom0002
                     CALL s_pre_voucher_delete_glax(g_xrej_m.xrejld,g_xrej_m.xrej005,'',l_scom0002) RETURNING l_success
                     IF l_success = FALSE THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                     
                     IF l_scom0002 = 'Y' THEN
                        #凭证作废处理
                        UPDATE glap_t SET glapstus = 'X'
                         WHERE glapent = g_enterprise
                           AND glapld = g_xrej_m.xrejld
                           AND glapdocno = g_xrej_m.xrej005
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
                     #170103-00019#7 add end---
                        DELETE FROM glap_t
                         WHERE glapent   = g_enterprise
                           AND glapld    = g_xrej_m.xrejld
                           AND glapdocno = g_xrej_m.xrej005
                        #141202-00061#17
                        DELETE FROM glaq_t
                         WHERE glaqent   = g_enterprise
                           AND glaqld    = g_xrej_m.xrejld
                           AND glaqdocno = g_xrej_m.xrej005
                        #141202-00061#17
                        #170120-00017#1 mark ------
                        #UPDATE xrej_t
                        #   SET xrej005 = ''
                        # WHERE xrejent = g_enterprise
                        #   AND xrejdocno = g_xrej_m.xrejdocno
                        #   AND xrej003 = 'AP'
                        #170120-00017#1 mark end---
                        #150527-00020#1 add ------
                        #更新最大號
                        LET g_prog = 'aglt310'
                        IF NOT s_aooi200_fin_del_docno(g_xrej_m.xrejld,g_xrej_m.xrej005,l_glapdocdt) THEN
                           CALL s_transaction_end('N','0')
                           CONTINUE DIALOG
                        END IF
                        LET g_prog = 'aapt940'
                        #150527-00020#1 add end---
                        #170120-00017#1 mark ------
                        #LET g_xrej_m.xrej005 = ''
                        #DISPLAY BY NAME g_xrej_m.xrej005
                        #170120-00017#1 mark end---
                        #141202-00061#17
                        UPDATE glga_t SET glga007 = ''
                         WHERE glgaent = g_enterprise AND glgald = g_xrej_m.xrejld 
                           AND glgadocno=g_xrej_m.xrejdocno AND glga100 = 'AP' AND glga101 = 'P60'
                        #141202-00061#17
                        #CALL s_transaction_end('Y','0') #150527-00020#1 #170120-00017#1 mark
                     END IF  #170103-00019#7 add
                     #170120-00017#1 add ------
                     #更新月結這邊的傳票號碼要給空
                     UPDATE xrej_t
                        SET xrej005 = ''
                      WHERE xrejent = g_enterprise
                        AND xrejdocno = g_xrej_m.xrejdocno
                        AND xrej003 = 'AP'
                     LET g_xrej_m.xrej005 = ''
                     DISPLAY BY NAME g_xrej_m.xrej005
                     
                     CALL s_transaction_end('Y','0')
                     #170120-00017#1 add end---
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aapt940_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt940_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION voucher_past
            LET g_action_choice="voucher_past"
            IF cl_auth_chk_act("voucher_past") THEN
               
               #add-point:ON ACTION voucher_past name="menu.voucher_past"
               IF g_xrej_m.xrejdocno IS NULL THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = "" 
                 LET g_errparam.code   = "std-00003" 
                 LET g_errparam.popup  = FALSE 
                 CALL cl_err()
                 CONTINUE DIALOG
               END IF               
               
               #取所屬法人關帳日
               LET l_comp = NULL
               SELECT glaacomp INTO l_comp FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald  = g_xrej_m.xrejld
               CALL cl_get_para(g_enterprise,l_comp,'S-FIN-3007') RETURNING l_para_data
              
               #未確認單據不可拋轉
               IF  g_xrej_m.xrejstus = 'N' THEN         
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00185'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF 

               #已拋轉傳票的單據不可以再拋轉 #Reanna 15/02/11 add
               IF NOT cl_null(g_xrej_m.xrej005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00198'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               #無傳票並且狀態瑪為Y才可拋轉                            
               IF cl_null(g_xrej_m.xrej005) THEN
                  SELECT glaa102 INTO g_glaa102 FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_xrej_m.xrejld
                  #產生單別/日期/
                  #CALL axrp330_01(g_xrej_m.xrejld) RETURNING l_slip,l_date #150323 mark
                  CALL aapp330_01(g_xrej_m.xrejld,g_xrej_m.xrejdocdt,'P60',g_xrej_m.xrejdocno) RETURNING l_slip,l_date #150323   #161213-00023#2 add g_xrej_m.xrejdocno
                  
                  #若取消產生時，就不往下走拋轉了 #Reanna 15/02/11 add
                  IF cl_null(l_slip) THEN
                     CONTINUE DIALOG
                  END IF

                  #必須大於帳套關帳日期才可拋轉
                  IF l_date < l_para_data THEN 
                     LET g_errparam.code = 'aap-00077'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
                  CALL s_aapp330_cre_tmp() RETURNING g_sub_success
                  CALL s_transaction_begin()
                  DELETE  FROM s_voucher_tmp
                  INSERT INTO s_voucher_tmp (docno,type)
                       VALUES ( g_xrej_m.xrejdocno, '0' )

                  LET l_count = NULL
                  SELECT COUNT(*) INTO l_count FROM s_voucher_tmp
                  IF cl_null(l_count)THEN LET l_count = 0 END IF
                  IF l_count > 0 THEN
                     
                     #準備資料
                     CALL s_aapp330_gen_ac('1','P60',g_xrej_m.xrejld,'','','1','!#@',g_xrej_m.xrejstus) RETURNING g_sub_success,l_start_no,l_start_no                     
                
                     IF g_sub_success THEN               
                        CALL s_transaction_end('Y','Y')
                     ELSE
                        CALL s_transaction_end('N','Y')
                     END IF
                     
                     #傳票拋轉
                     CALL s_transaction_begin()
                     CALL cl_err_collect_init()
                     CALL s_aapp330_generate_voucher('P60',l_slip,l_date,g_xrej_m.xrejld,'1','Y',g_glaa102,'AP')
                          RETURNING g_sub_success,g_xrej_m.xrej005,g_xrej_m.xrej005
          
                     CALL cl_err_collect_show()   
                     IF g_sub_success THEN
                        UPDATE xrej_t 
                           SET xrej005 = g_xrej_m.xrej005
                         WHERE xrejent = g_enterprise
                           AND xrejdocno = g_xrej_m.xrejdocno 
                           AND xrej003 = 'AP'        
                        #141202-00061#17
                        UPDATE glga_t SET glga007 = g_xrej_m.xrej005
                         WHERE glgaent = g_enterprise AND glgald = g_xrej_m.xrejld 
                           AND glgadocno=g_xrej_m.xrejdocno AND glga100 = 'AP' AND glga101 = 'P60'
                        #141202-00061#17
                        CALL s_transaction_end('Y','Y')
                     ELSE
                        CALL s_transaction_end('N','Y')
                     END IF
                     DISPLAY BY NAME g_xrej_m.xrej005
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt940_01
            LET g_action_choice="open_aapt940_01"
            IF cl_auth_chk_act("open_aapt940_01") THEN
               
               #add-point:ON ACTION open_aapt940_01 name="menu.open_aapt940_01"
               CALL s_transaction_begin()
               LET l_success_doc = NULL
               CALL aapt940_01()RETURNING g_sub_success,l_success_doc
               IF g_sub_success THEN
                  CALL s_transaction_end('Y',0)
                  IF NOT cl_null(l_success_doc)THEN
                     #把產生的那張顯示出來
                     LET g_xrej_m.xrejdocno = l_success_doc
                     EXECUTE aapt940_master_referesh USING g_xrej_m.xrejdocno INTO g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004, 
                         g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus, 
                         g_xrej_m.xrejownid,g_xrej_m.xrejowndp,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdt, 
                         g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid,g_xrej_m.xrejcnfdt,g_xrej_m.xrejownid_desc, 
                         g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp_desc,g_xrej_m.xrejmodid_desc, 
                         g_xrej_m.xrejcnfid_desc
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "xrej_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()                     
                        INITIALIZE g_xrej_m.* TO NULL
                     END IF
                     #根據資料狀態切換action狀態
                     CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
                     CALL aapt940_set_act_visible()   
                     CALL aapt940_set_act_no_visible()
                     
                     #保存單頭舊值
                     LET g_xrej_m_t.* = g_xrej_m.*
                     LET g_xrej_m_o.* = g_xrej_m.*
                     
                     LET g_data_owner = g_xrej_m.xrejownid      
                     LET g_data_dept  = g_xrej_m.xrejowndp
                     
                     #重新顯示   
                     CALL aapt940_show()
                  END IF                  
               ELSE
                  CALL s_transaction_end('N',0)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/aap/aapt940_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/aap/aapt940_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapt940_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xrej004
            LET g_action_choice="prog_xrej004"
            IF cl_auth_chk_act("prog_xrej004") THEN
               
               #add-point:ON ACTION prog_xrej004 name="menu.prog_xrej004"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_xrej_m.xrej004)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xrej005
            LET g_action_choice="prog_xrej005"
            IF cl_auth_chk_act("prog_xrej005") THEN
               
               #add-point:ON ACTION prog_xrej005 name="menu.prog_xrej005"
               #150506-00033#6-----s
               IF cl_null(g_xrej_m.xrejld) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'sub-00280'
                  LET g_errparam.extend = s_fin_get_colname(g_prog,'xrejld')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_xrej_m.xrej005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'sub-00280'
                  LET g_errparam.extend = s_fin_get_colname(g_prog,'xrej005')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               
               INITIALIZE la_param.* TO NULL
               CALL s_aapt300_get_aglt3xx_prog(g_xrej_m.xrejld,g_xrej_m.xrej005)RETURNING la_param.prog
               LET la_param.param[1] = g_xrej_m.xrejld
               LET la_param.param[2] = g_xrej_m.xrej005
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               #150506-00033#6-----e  
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapt940_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt940_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt940_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_xrej_m.xrejdocdt)
 
 
 
         
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
 
{<section id="aapt940.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aapt940_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ld_str          STRING #161014-00053#4 add
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   #161014-00053#4 --s add
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str  
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xrejld")
   LET l_wc = l_wc," AND ",l_ld_str
   #161014-00053#4 --e add
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
      LET l_sub_sql = " SELECT DISTINCT xrejdocno ",
                      " FROM xrej_t ",
                      " ",
                      " LEFT JOIN xrek_t ON xrekent = xrejent AND xrejdocno = xrekdocno ", "  ",
                      #add-point:browser_fill段sql(xrek_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE xrejent = " ||g_enterprise|| " AND xrekent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xrej_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xrejdocno ",
                      " FROM xrej_t ", 
                      "  ",
                      "  ",
                      " WHERE xrejent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xrej_t")
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
      INITIALIZE g_xrej_m.* TO NULL
      CALL g_xrek_d.clear()        
      CALL g_xrek2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      CALL g_xrek3_d.clear()
      CALL g_xrek4_d.clear()
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xrejdocno,t0.xrej001,t0.xrej002,t0.xrej004 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xrejstus,t0.xrejdocno,t0.xrej001,t0.xrej002,t0.xrej004 ",
                  " FROM xrej_t t0",
                  "  ",
                  "  LEFT JOIN xrek_t ON xrekent = xrejent AND xrejdocno = xrekdocno ", "  ", 
                  #add-point:browser_fill段sql(xrek_t1) name="browser_fill.join.xrek_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.xrejent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xrej_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xrejstus,t0.xrejdocno,t0.xrej001,t0.xrej002,t0.xrej004 ",
                  " FROM xrej_t t0",
                  "  ",
                  
                  " WHERE t0.xrejent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xrej_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #151231-00010#1(E) 
   IF NOT cl_null(g_wc_cs_ld) THEN     #160125-00005#6--(S)
      LET g_sql = g_sql , " AND xrejld IN ",g_wc_cs_ld
   END IF                              #160125-00005#6--(E)
   #end add-point
   #end add-point
   LET g_sql = g_sql, " ORDER BY xrejdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xrej_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xrejdocno,g_browser[g_cnt].b_xrej001, 
          g_browser[g_cnt].b_xrej002,g_browser[g_cnt].b_xrej004
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
         CALL aapt940_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_xrejdocno) THEN
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
   CALL cl_set_act_visible("mainhidden", FALSE)   #150226
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="aapt940.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aapt940_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xrej_m.xrejdocno = g_browser[g_current_idx].b_xrejdocno   
 
   EXECUTE aapt940_master_referesh USING g_xrej_m.xrejdocno INTO g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004, 
       g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus, 
       g_xrej_m.xrejownid,g_xrej_m.xrejowndp,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdt, 
       g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid,g_xrej_m.xrejcnfdt,g_xrej_m.xrejownid_desc, 
       g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp_desc,g_xrej_m.xrejmodid_desc, 
       g_xrej_m.xrejcnfid_desc
   
   CALL aapt940_xrej_t_mask()
   CALL aapt940_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aapt940.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aapt940_ui_detailshow()
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
 
{<section id="aapt940.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapt940_ui_browser_refresh()
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
      IF g_browser[l_i].b_xrejdocno = g_xrej_m.xrejdocno 
 
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
   CALL cl_set_act_visible("mainhidden", FALSE)   #150226
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt940_construct()
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
   DEFINE l_ld_str    STRING               #161014-00053#4 add
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xrej_m.* TO NULL
   CALL g_xrek_d.clear()        
   CALL g_xrek2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL g_xrek3_d.clear()
   CALL g_xrek4_d.clear()
   LET g_site_str = NULL   #161014-00053#4
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xrejsite,xrejsite_desc,xrejld,xrejld_desc,xrej004,xrej004_desc,xrejdocno, 
          xrejdocdt,xrej001,xrej002,xrej005,xrejstus,xrejownid,xrejowndp,xrejcrtid,xrejcrtdp,xrejcrtdt, 
          xrejmodid,xrejmoddt,xrejcnfid,xrejcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xrejcrtdt>>----
         AFTER FIELD xrejcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xrejmoddt>>----
         AFTER FIELD xrejmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrejcnfdt>>----
         AFTER FIELD xrejcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrejpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejsite
            #add-point:BEFORE FIELD xrejsite name="construct.b.xrejsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejsite
            
            #add-point:AFTER FIELD xrejsite name="construct.a.xrejsite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str #161014-00053#4
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrejsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejsite
            #add-point:ON ACTION controlp INFIELD xrejsite name="construct.c.xrejsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #161006-00005#6   mark
            CALL q_ooef001_46()                         #161006-00005#6   add
            DISPLAY g_qryparam.return1 TO xrejsite
            NEXT FIELD xrejsite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejsite_desc
            #add-point:BEFORE FIELD xrejsite_desc name="construct.b.xrejsite_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejsite_desc
            
            #add-point:AFTER FIELD xrejsite_desc name="construct.a.xrejsite_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrejsite_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejsite_desc
            #add-point:ON ACTION controlp INFIELD xrejsite_desc name="construct.c.xrejsite_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejld
            #add-point:BEFORE FIELD xrejld name="construct.b.xrejld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejld
            
            #add-point:AFTER FIELD xrejld name="construct.a.xrejld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrejld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejld
            #add-point:ON ACTION controlp INFIELD xrejld name="construct.c.xrejld"
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str #161014-00053#4 add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
           #LET g_qryparam.where = " glaald IN ",g_wc_cs_ld    #160125-00005#6              #161014-00053#4 mark
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')" #161014-00053#4 add
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO xrejld
            NEXT FIELD xrejld
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejld_desc
            #add-point:BEFORE FIELD xrejld_desc name="construct.b.xrejld_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejld_desc
            
            #add-point:AFTER FIELD xrejld_desc name="construct.a.xrejld_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrejld_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejld_desc
            #add-point:ON ACTION controlp INFIELD xrejld_desc name="construct.c.xrejld_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej004
            #add-point:BEFORE FIELD xrej004 name="construct.b.xrej004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej004
            
            #add-point:AFTER FIELD xrej004 name="construct.a.xrej004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrej004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej004
            #add-point:ON ACTION controlp INFIELD xrej004 name="construct.c.xrej004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO xrej004      #顯示到畫面上
            NEXT FIELD xrej004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej004_desc
            #add-point:BEFORE FIELD xrej004_desc name="construct.b.xrej004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej004_desc
            
            #add-point:AFTER FIELD xrej004_desc name="construct.a.xrej004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrej004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej004_desc
            #add-point:ON ACTION controlp INFIELD xrej004_desc name="construct.c.xrej004_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejdocno
            #add-point:BEFORE FIELD xrejdocno name="construct.b.xrejdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejdocno
            
            #add-point:AFTER FIELD xrejdocno name="construct.a.xrejdocno"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrejdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejdocno
            #add-point:ON ACTION controlp INFIELD xrejdocno name="construct.c.xrejdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "xrej003 = 'AP' "
            #161014-00053#4 --s add
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xrejld")
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
            #161014-00053#4 --e add
            #161104-00046#8 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#8 --e add             
            CALL q_xrejdocno()
            DISPLAY g_qryparam.return1 TO xrejdocno      #顯示到畫面上
            NEXT FIELD xrejdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejdocdt
            #add-point:BEFORE FIELD xrejdocdt name="construct.b.xrejdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejdocdt
            
            #add-point:AFTER FIELD xrejdocdt name="construct.a.xrejdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrejdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejdocdt
            #add-point:ON ACTION controlp INFIELD xrejdocdt name="construct.c.xrejdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej001
            #add-point:BEFORE FIELD xrej001 name="construct.b.xrej001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej001
            
            #add-point:AFTER FIELD xrej001 name="construct.a.xrej001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrej001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej001
            #add-point:ON ACTION controlp INFIELD xrej001 name="construct.c.xrej001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej002
            #add-point:BEFORE FIELD xrej002 name="construct.b.xrej002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej002
            
            #add-point:AFTER FIELD xrej002 name="construct.a.xrej002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrej002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej002
            #add-point:ON ACTION controlp INFIELD xrej002 name="construct.c.xrej002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej005
            #add-point:BEFORE FIELD xrej005 name="construct.b.xrej005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej005
            
            #add-point:AFTER FIELD xrej005 name="construct.a.xrej005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrej005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej005
            #add-point:ON ACTION controlp INFIELD xrej005 name="construct.c.xrej005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejstus
            #add-point:BEFORE FIELD xrejstus name="construct.b.xrejstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejstus
            
            #add-point:AFTER FIELD xrejstus name="construct.a.xrejstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrejstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejstus
            #add-point:ON ACTION controlp INFIELD xrejstus name="construct.c.xrejstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrejownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejownid
            #add-point:ON ACTION controlp INFIELD xrejownid name="construct.c.xrejownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrejownid  #顯示到畫面上
            NEXT FIELD xrejownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejownid
            #add-point:BEFORE FIELD xrejownid name="construct.b.xrejownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejownid
            
            #add-point:AFTER FIELD xrejownid name="construct.a.xrejownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrejowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejowndp
            #add-point:ON ACTION controlp INFIELD xrejowndp name="construct.c.xrejowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrejowndp  #顯示到畫面上
            NEXT FIELD xrejowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejowndp
            #add-point:BEFORE FIELD xrejowndp name="construct.b.xrejowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejowndp
            
            #add-point:AFTER FIELD xrejowndp name="construct.a.xrejowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrejcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejcrtid
            #add-point:ON ACTION controlp INFIELD xrejcrtid name="construct.c.xrejcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrejcrtid  #顯示到畫面上
            NEXT FIELD xrejcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejcrtid
            #add-point:BEFORE FIELD xrejcrtid name="construct.b.xrejcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejcrtid
            
            #add-point:AFTER FIELD xrejcrtid name="construct.a.xrejcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrejcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejcrtdp
            #add-point:ON ACTION controlp INFIELD xrejcrtdp name="construct.c.xrejcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrejcrtdp  #顯示到畫面上
            NEXT FIELD xrejcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejcrtdp
            #add-point:BEFORE FIELD xrejcrtdp name="construct.b.xrejcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejcrtdp
            
            #add-point:AFTER FIELD xrejcrtdp name="construct.a.xrejcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejcrtdt
            #add-point:BEFORE FIELD xrejcrtdt name="construct.b.xrejcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrejmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejmodid
            #add-point:ON ACTION controlp INFIELD xrejmodid name="construct.c.xrejmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrejmodid  #顯示到畫面上
            NEXT FIELD xrejmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejmodid
            #add-point:BEFORE FIELD xrejmodid name="construct.b.xrejmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejmodid
            
            #add-point:AFTER FIELD xrejmodid name="construct.a.xrejmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejmoddt
            #add-point:BEFORE FIELD xrejmoddt name="construct.b.xrejmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrejcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejcnfid
            #add-point:ON ACTION controlp INFIELD xrejcnfid name="construct.c.xrejcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrejcnfid  #顯示到畫面上
            NEXT FIELD xrejcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejcnfid
            #add-point:BEFORE FIELD xrejcnfid name="construct.b.xrejcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejcnfid
            
            #add-point:AFTER FIELD xrejcnfid name="construct.a.xrejcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejcnfdt
            #add-point:BEFORE FIELD xrejcnfdt name="construct.b.xrejcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xrekseq,xrek005,xrek006,xrek007,xrek100,xrek103,xrek113,xrek037,xrek039, 
          xrek105,xrek115,xrek104,xrek114,xrek038,xrek040,xrek106,xrek116,xrek107,xrek117,xrek033,xrek019, 
          l_xrek019_desc,xrek041,l_xrek041_desc,xrekorga,l_xrekorga_desc,xrek009,l_xrek009_desc,xrek016, 
          l_xrek016_desc,xrek011,l_xrek011_desc,xrek012,l_xrek012_desc,xrek013,l_xrek013_desc,xrek014, 
          l_xrek014_desc,xrek015,l_xrek015_desc,xrek017,l_xrek017_desc,xrek018,l_xrek018_desc,xrek020, 
          xrek021,l_xrek021_desc,xrek022,l_xrek022_desc,xrek023,l_xrek023_desc,xrek024,l_xrek024_desc, 
          xrek025,l_xrek025_desc,xrek026,l_xrek026_desc,xrek027,l_xrek027_desc,xrek028,l_xrek028_desc, 
          xrek029,l_xrek029_desc,xrek030,l_xrek030_desc,xrek031,l_xrek031_desc,xrek032,l_xrek032_desc 
 
           FROM s_detail1[1].xrekseq,s_detail1[1].xrek005,s_detail1[1].xrek006,s_detail1[1].xrek007, 
               s_detail1[1].xrek100,s_detail1[1].xrek103,s_detail1[1].xrek113,s_detail1[1].xrek037,s_detail1[1].xrek039, 
               s_detail1[1].xrek105,s_detail1[1].xrek115,s_detail1[1].xrek104,s_detail1[1].xrek114,s_detail1[1].xrek038, 
               s_detail1[1].xrek040,s_detail1[1].xrek106,s_detail1[1].xrek116,s_detail1[1].xrek107,s_detail1[1].xrek117, 
               s_detail2[1].xrek033,s_detail2[1].xrek019,s_detail2[1].l_xrek019_desc,s_detail2[1].xrek041, 
               s_detail2[1].l_xrek041_desc,s_detail2[1].xrekorga,s_detail2[1].l_xrekorga_desc,s_detail2[1].xrek009, 
               s_detail2[1].l_xrek009_desc,s_detail2[1].xrek016,s_detail2[1].l_xrek016_desc,s_detail2[1].xrek011, 
               s_detail2[1].l_xrek011_desc,s_detail2[1].xrek012,s_detail2[1].l_xrek012_desc,s_detail2[1].xrek013, 
               s_detail2[1].l_xrek013_desc,s_detail2[1].xrek014,s_detail2[1].l_xrek014_desc,s_detail2[1].xrek015, 
               s_detail2[1].l_xrek015_desc,s_detail2[1].xrek017,s_detail2[1].l_xrek017_desc,s_detail2[1].xrek018, 
               s_detail2[1].l_xrek018_desc,s_detail2[1].xrek020,s_detail2[1].xrek021,s_detail2[1].l_xrek021_desc, 
               s_detail2[1].xrek022,s_detail2[1].l_xrek022_desc,s_detail2[1].xrek023,s_detail2[1].l_xrek023_desc, 
               s_detail2[1].xrek024,s_detail2[1].l_xrek024_desc,s_detail2[1].xrek025,s_detail2[1].l_xrek025_desc, 
               s_detail2[1].xrek026,s_detail2[1].l_xrek026_desc,s_detail2[1].xrek027,s_detail2[1].l_xrek027_desc, 
               s_detail2[1].xrek028,s_detail2[1].l_xrek028_desc,s_detail2[1].xrek029,s_detail2[1].l_xrek029_desc, 
               s_detail2[1].xrek030,s_detail2[1].l_xrek030_desc,s_detail2[1].xrek031,s_detail2[1].l_xrek031_desc, 
               s_detail2[1].xrek032,s_detail2[1].l_xrek032_desc
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrekseq
            #add-point:BEFORE FIELD xrekseq name="construct.b.page1.xrekseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrekseq
            
            #add-point:AFTER FIELD xrekseq name="construct.a.page1.xrekseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrekseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrekseq
            #add-point:ON ACTION controlp INFIELD xrekseq name="construct.c.page1.xrekseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek005
            #add-point:BEFORE FIELD xrek005 name="construct.b.page1.xrek005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek005
            
            #add-point:AFTER FIELD xrek005 name="construct.a.page1.xrek005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek005
            #add-point:ON ACTION controlp INFIELD xrek005 name="construct.c.page1.xrek005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek006
            #add-point:BEFORE FIELD xrek006 name="construct.b.page1.xrek006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek006
            
            #add-point:AFTER FIELD xrek006 name="construct.a.page1.xrek006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek006
            #add-point:ON ACTION controlp INFIELD xrek006 name="construct.c.page1.xrek006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek007
            #add-point:BEFORE FIELD xrek007 name="construct.b.page1.xrek007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek007
            
            #add-point:AFTER FIELD xrek007 name="construct.a.page1.xrek007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek007
            #add-point:ON ACTION controlp INFIELD xrek007 name="construct.c.page1.xrek007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek100
            #add-point:BEFORE FIELD xrek100 name="construct.b.page1.xrek100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek100
            
            #add-point:AFTER FIELD xrek100 name="construct.a.page1.xrek100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek100
            #add-point:ON ACTION controlp INFIELD xrek100 name="construct.c.page1.xrek100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek103
            #add-point:BEFORE FIELD xrek103 name="construct.b.page1.xrek103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek103
            
            #add-point:AFTER FIELD xrek103 name="construct.a.page1.xrek103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek103
            #add-point:ON ACTION controlp INFIELD xrek103 name="construct.c.page1.xrek103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek113
            #add-point:BEFORE FIELD xrek113 name="construct.b.page1.xrek113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek113
            
            #add-point:AFTER FIELD xrek113 name="construct.a.page1.xrek113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek113
            #add-point:ON ACTION controlp INFIELD xrek113 name="construct.c.page1.xrek113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek037
            #add-point:BEFORE FIELD xrek037 name="construct.b.page1.xrek037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek037
            
            #add-point:AFTER FIELD xrek037 name="construct.a.page1.xrek037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek037
            #add-point:ON ACTION controlp INFIELD xrek037 name="construct.c.page1.xrek037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek039
            #add-point:BEFORE FIELD xrek039 name="construct.b.page1.xrek039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek039
            
            #add-point:AFTER FIELD xrek039 name="construct.a.page1.xrek039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek039
            #add-point:ON ACTION controlp INFIELD xrek039 name="construct.c.page1.xrek039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek105
            #add-point:BEFORE FIELD xrek105 name="construct.b.page1.xrek105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek105
            
            #add-point:AFTER FIELD xrek105 name="construct.a.page1.xrek105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek105
            #add-point:ON ACTION controlp INFIELD xrek105 name="construct.c.page1.xrek105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek115
            #add-point:BEFORE FIELD xrek115 name="construct.b.page1.xrek115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek115
            
            #add-point:AFTER FIELD xrek115 name="construct.a.page1.xrek115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek115
            #add-point:ON ACTION controlp INFIELD xrek115 name="construct.c.page1.xrek115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek104
            #add-point:BEFORE FIELD xrek104 name="construct.b.page1.xrek104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek104
            
            #add-point:AFTER FIELD xrek104 name="construct.a.page1.xrek104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek104
            #add-point:ON ACTION controlp INFIELD xrek104 name="construct.c.page1.xrek104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek114
            #add-point:BEFORE FIELD xrek114 name="construct.b.page1.xrek114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek114
            
            #add-point:AFTER FIELD xrek114 name="construct.a.page1.xrek114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek114
            #add-point:ON ACTION controlp INFIELD xrek114 name="construct.c.page1.xrek114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek038
            #add-point:BEFORE FIELD xrek038 name="construct.b.page1.xrek038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek038
            
            #add-point:AFTER FIELD xrek038 name="construct.a.page1.xrek038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek038
            #add-point:ON ACTION controlp INFIELD xrek038 name="construct.c.page1.xrek038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek040
            #add-point:BEFORE FIELD xrek040 name="construct.b.page1.xrek040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek040
            
            #add-point:AFTER FIELD xrek040 name="construct.a.page1.xrek040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek040
            #add-point:ON ACTION controlp INFIELD xrek040 name="construct.c.page1.xrek040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek106
            #add-point:BEFORE FIELD xrek106 name="construct.b.page1.xrek106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek106
            
            #add-point:AFTER FIELD xrek106 name="construct.a.page1.xrek106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek106
            #add-point:ON ACTION controlp INFIELD xrek106 name="construct.c.page1.xrek106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek116
            #add-point:BEFORE FIELD xrek116 name="construct.b.page1.xrek116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek116
            
            #add-point:AFTER FIELD xrek116 name="construct.a.page1.xrek116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek116
            #add-point:ON ACTION controlp INFIELD xrek116 name="construct.c.page1.xrek116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek107
            #add-point:BEFORE FIELD xrek107 name="construct.b.page1.xrek107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek107
            
            #add-point:AFTER FIELD xrek107 name="construct.a.page1.xrek107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek107
            #add-point:ON ACTION controlp INFIELD xrek107 name="construct.c.page1.xrek107"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek117
            #add-point:BEFORE FIELD xrek117 name="construct.b.page1.xrek117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek117
            
            #add-point:AFTER FIELD xrek117 name="construct.a.page1.xrek117"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrek117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek117
            #add-point:ON ACTION controlp INFIELD xrek117 name="construct.c.page1.xrek117"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek033
            #add-point:BEFORE FIELD xrek033 name="construct.b.page2.xrek033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek033
            
            #add-point:AFTER FIELD xrek033 name="construct.a.page2.xrek033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek033
            #add-point:ON ACTION controlp INFIELD xrek033 name="construct.c.page2.xrek033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek019
            #add-point:BEFORE FIELD xrek019 name="construct.b.page2.xrek019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek019
            
            #add-point:AFTER FIELD xrek019 name="construct.a.page2.xrek019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek019
            #add-point:ON ACTION controlp INFIELD xrek019 name="construct.c.page2.xrek019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek019_desc
            #add-point:BEFORE FIELD l_xrek019_desc name="construct.b.page2.l_xrek019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek019_desc
            
            #add-point:AFTER FIELD l_xrek019_desc name="construct.a.page2.l_xrek019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek019_desc
            #add-point:ON ACTION controlp INFIELD l_xrek019_desc name="construct.c.page2.l_xrek019_desc"
            #161115-00044#1-add(s)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            SELECT ooef017 INTO g_glaacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_xrej_m.xrejld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_glaacomp
               AND glaa014 = 'Y' 
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_xrej_m.xrejld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO l_xrek019_desc
            NEXT FIELD l_xrek019_desc
            #161115-00044#1-add(e)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek041
            #add-point:BEFORE FIELD xrek041 name="construct.b.page2.xrek041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek041
            
            #add-point:AFTER FIELD xrek041 name="construct.a.page2.xrek041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek041
            #add-point:ON ACTION controlp INFIELD xrek041 name="construct.c.page2.xrek041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek041_desc
            #add-point:BEFORE FIELD l_xrek041_desc name="construct.b.page2.l_xrek041_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek041_desc
            
            #add-point:AFTER FIELD l_xrek041_desc name="construct.a.page2.l_xrek041_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek041_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek041_desc
            #add-point:ON ACTION controlp INFIELD l_xrek041_desc name="construct.c.page2.l_xrek041_desc"
            #161115-00044#1-add(s)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            SELECT ooef017 INTO g_glaacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_xrej_m.xrejld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_glaacomp
               AND glaa014 = 'Y' 
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_xrej_m.xrejld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO l_xrek041_desc
            NEXT FIELD l_xrek041_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrekorga
            #add-point:BEFORE FIELD xrekorga name="construct.b.page2.xrekorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrekorga
            
            #add-point:AFTER FIELD xrekorga name="construct.a.page2.xrekorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrekorga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrekorga
            #add-point:ON ACTION controlp INFIELD xrekorga name="construct.c.page2.xrekorga"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrekorga_desc
            #add-point:BEFORE FIELD l_xrekorga_desc name="construct.b.page2.l_xrekorga_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrekorga_desc
            
            #add-point:AFTER FIELD l_xrekorga_desc name="construct.a.page2.l_xrekorga_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrekorga_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrekorga_desc
            #add-point:ON ACTION controlp INFIELD l_xrekorga_desc name="construct.c.page2.l_xrekorga_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek009
            #add-point:BEFORE FIELD xrek009 name="construct.b.page2.xrek009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek009
            
            #add-point:AFTER FIELD xrek009 name="construct.a.page2.xrek009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek009
            #add-point:ON ACTION controlp INFIELD xrek009 name="construct.c.page2.xrek009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek009_desc
            #add-point:BEFORE FIELD l_xrek009_desc name="construct.b.page2.l_xrek009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek009_desc
            
            #add-point:AFTER FIELD l_xrek009_desc name="construct.a.page2.l_xrek009_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek009_desc
            #add-point:ON ACTION controlp INFIELD l_xrek009_desc name="construct.c.page2.l_xrek009_desc"
            #161115-00044#1-add(s)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO l_xrek009_desc
            NEXT FIELD l_xrek009_desc
            #161115-00044#1-add(e)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek016
            #add-point:BEFORE FIELD xrek016 name="construct.b.page2.xrek016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek016
            
            #add-point:AFTER FIELD xrek016 name="construct.a.page2.xrek016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek016
            #add-point:ON ACTION controlp INFIELD xrek016 name="construct.c.page2.xrek016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek016_desc
            #add-point:BEFORE FIELD l_xrek016_desc name="construct.b.page2.l_xrek016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek016_desc
            
            #add-point:AFTER FIELD l_xrek016_desc name="construct.a.page2.l_xrek016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek016_desc
            #add-point:ON ACTION controlp INFIELD l_xrek016_desc name="construct.c.page2.l_xrek016_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek011
            #add-point:BEFORE FIELD xrek011 name="construct.b.page2.xrek011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek011
            
            #add-point:AFTER FIELD xrek011 name="construct.a.page2.xrek011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek011
            #add-point:ON ACTION controlp INFIELD xrek011 name="construct.c.page2.xrek011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek011_desc
            #add-point:BEFORE FIELD l_xrek011_desc name="construct.b.page2.l_xrek011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek011_desc
            
            #add-point:AFTER FIELD l_xrek011_desc name="construct.a.page2.l_xrek011_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek011_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek011_desc
            #add-point:ON ACTION controlp INFIELD l_xrek011_desc name="construct.c.page2.l_xrek011_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek012
            #add-point:BEFORE FIELD xrek012 name="construct.b.page2.xrek012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek012
            
            #add-point:AFTER FIELD xrek012 name="construct.a.page2.xrek012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek012
            #add-point:ON ACTION controlp INFIELD xrek012 name="construct.c.page2.xrek012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek012_desc
            #add-point:BEFORE FIELD l_xrek012_desc name="construct.b.page2.l_xrek012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek012_desc
            
            #add-point:AFTER FIELD l_xrek012_desc name="construct.a.page2.l_xrek012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek012_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek012_desc
            #add-point:ON ACTION controlp INFIELD l_xrek012_desc name="construct.c.page2.l_xrek012_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek013
            #add-point:BEFORE FIELD xrek013 name="construct.b.page2.xrek013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek013
            
            #add-point:AFTER FIELD xrek013 name="construct.a.page2.xrek013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek013
            #add-point:ON ACTION controlp INFIELD xrek013 name="construct.c.page2.xrek013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek013_desc
            #add-point:BEFORE FIELD l_xrek013_desc name="construct.b.page2.l_xrek013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek013_desc
            
            #add-point:AFTER FIELD l_xrek013_desc name="construct.a.page2.l_xrek013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek013_desc
            #add-point:ON ACTION controlp INFIELD l_xrek013_desc name="construct.c.page2.l_xrek013_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek014
            #add-point:BEFORE FIELD xrek014 name="construct.b.page2.xrek014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek014
            
            #add-point:AFTER FIELD xrek014 name="construct.a.page2.xrek014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek014
            #add-point:ON ACTION controlp INFIELD xrek014 name="construct.c.page2.xrek014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek014_desc
            #add-point:BEFORE FIELD l_xrek014_desc name="construct.b.page2.l_xrek014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek014_desc
            
            #add-point:AFTER FIELD l_xrek014_desc name="construct.a.page2.l_xrek014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek014_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek014_desc
            #add-point:ON ACTION controlp INFIELD l_xrek014_desc name="construct.c.page2.l_xrek014_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek015
            #add-point:BEFORE FIELD xrek015 name="construct.b.page2.xrek015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek015
            
            #add-point:AFTER FIELD xrek015 name="construct.a.page2.xrek015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek015
            #add-point:ON ACTION controlp INFIELD xrek015 name="construct.c.page2.xrek015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek015_desc
            #add-point:BEFORE FIELD l_xrek015_desc name="construct.b.page2.l_xrek015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek015_desc
            
            #add-point:AFTER FIELD l_xrek015_desc name="construct.a.page2.l_xrek015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek015_desc
            #add-point:ON ACTION controlp INFIELD l_xrek015_desc name="construct.c.page2.l_xrek015_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek017
            #add-point:BEFORE FIELD xrek017 name="construct.b.page2.xrek017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek017
            
            #add-point:AFTER FIELD xrek017 name="construct.a.page2.xrek017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek017
            #add-point:ON ACTION controlp INFIELD xrek017 name="construct.c.page2.xrek017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek017_desc
            #add-point:BEFORE FIELD l_xrek017_desc name="construct.b.page2.l_xrek017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek017_desc
            
            #add-point:AFTER FIELD l_xrek017_desc name="construct.a.page2.l_xrek017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek017_desc
            #add-point:ON ACTION controlp INFIELD l_xrek017_desc name="construct.c.page2.l_xrek017_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek018
            #add-point:BEFORE FIELD xrek018 name="construct.b.page2.xrek018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek018
            
            #add-point:AFTER FIELD xrek018 name="construct.a.page2.xrek018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek018
            #add-point:ON ACTION controlp INFIELD xrek018 name="construct.c.page2.xrek018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek018_desc
            #add-point:BEFORE FIELD l_xrek018_desc name="construct.b.page2.l_xrek018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek018_desc
            
            #add-point:AFTER FIELD l_xrek018_desc name="construct.a.page2.l_xrek018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek018_desc
            #add-point:ON ACTION controlp INFIELD l_xrek018_desc name="construct.c.page2.l_xrek018_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek020
            #add-point:BEFORE FIELD xrek020 name="construct.b.page2.xrek020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek020
            
            #add-point:AFTER FIELD xrek020 name="construct.a.page2.xrek020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek020
            #add-point:ON ACTION controlp INFIELD xrek020 name="construct.c.page2.xrek020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek021
            #add-point:BEFORE FIELD xrek021 name="construct.b.page2.xrek021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek021
            
            #add-point:AFTER FIELD xrek021 name="construct.a.page2.xrek021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek021
            #add-point:ON ACTION controlp INFIELD xrek021 name="construct.c.page2.xrek021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek021_desc
            #add-point:BEFORE FIELD l_xrek021_desc name="construct.b.page2.l_xrek021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek021_desc
            
            #add-point:AFTER FIELD l_xrek021_desc name="construct.a.page2.l_xrek021_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek021_desc
            #add-point:ON ACTION controlp INFIELD l_xrek021_desc name="construct.c.page2.l_xrek021_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek022
            #add-point:BEFORE FIELD xrek022 name="construct.b.page2.xrek022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek022
            
            #add-point:AFTER FIELD xrek022 name="construct.a.page2.xrek022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek022
            #add-point:ON ACTION controlp INFIELD xrek022 name="construct.c.page2.xrek022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek022_desc
            #add-point:BEFORE FIELD l_xrek022_desc name="construct.b.page2.l_xrek022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek022_desc
            
            #add-point:AFTER FIELD l_xrek022_desc name="construct.a.page2.l_xrek022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek022_desc
            #add-point:ON ACTION controlp INFIELD l_xrek022_desc name="construct.c.page2.l_xrek022_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek023
            #add-point:BEFORE FIELD xrek023 name="construct.b.page2.xrek023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek023
            
            #add-point:AFTER FIELD xrek023 name="construct.a.page2.xrek023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek023
            #add-point:ON ACTION controlp INFIELD xrek023 name="construct.c.page2.xrek023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek023_desc
            #add-point:BEFORE FIELD l_xrek023_desc name="construct.b.page2.l_xrek023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek023_desc
            
            #add-point:AFTER FIELD l_xrek023_desc name="construct.a.page2.l_xrek023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek023_desc
            #add-point:ON ACTION controlp INFIELD l_xrek023_desc name="construct.c.page2.l_xrek023_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek024
            #add-point:BEFORE FIELD xrek024 name="construct.b.page2.xrek024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek024
            
            #add-point:AFTER FIELD xrek024 name="construct.a.page2.xrek024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek024
            #add-point:ON ACTION controlp INFIELD xrek024 name="construct.c.page2.xrek024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek024_desc
            #add-point:BEFORE FIELD l_xrek024_desc name="construct.b.page2.l_xrek024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek024_desc
            
            #add-point:AFTER FIELD l_xrek024_desc name="construct.a.page2.l_xrek024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek024_desc
            #add-point:ON ACTION controlp INFIELD l_xrek024_desc name="construct.c.page2.l_xrek024_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek025
            #add-point:BEFORE FIELD xrek025 name="construct.b.page2.xrek025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek025
            
            #add-point:AFTER FIELD xrek025 name="construct.a.page2.xrek025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek025
            #add-point:ON ACTION controlp INFIELD xrek025 name="construct.c.page2.xrek025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek025_desc
            #add-point:BEFORE FIELD l_xrek025_desc name="construct.b.page2.l_xrek025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek025_desc
            
            #add-point:AFTER FIELD l_xrek025_desc name="construct.a.page2.l_xrek025_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek025_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek025_desc
            #add-point:ON ACTION controlp INFIELD l_xrek025_desc name="construct.c.page2.l_xrek025_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek026
            #add-point:BEFORE FIELD xrek026 name="construct.b.page2.xrek026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek026
            
            #add-point:AFTER FIELD xrek026 name="construct.a.page2.xrek026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek026
            #add-point:ON ACTION controlp INFIELD xrek026 name="construct.c.page2.xrek026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek026_desc
            #add-point:BEFORE FIELD l_xrek026_desc name="construct.b.page2.l_xrek026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek026_desc
            
            #add-point:AFTER FIELD l_xrek026_desc name="construct.a.page2.l_xrek026_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek026_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek026_desc
            #add-point:ON ACTION controlp INFIELD l_xrek026_desc name="construct.c.page2.l_xrek026_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek027
            #add-point:BEFORE FIELD xrek027 name="construct.b.page2.xrek027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek027
            
            #add-point:AFTER FIELD xrek027 name="construct.a.page2.xrek027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek027
            #add-point:ON ACTION controlp INFIELD xrek027 name="construct.c.page2.xrek027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek027_desc
            #add-point:BEFORE FIELD l_xrek027_desc name="construct.b.page2.l_xrek027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek027_desc
            
            #add-point:AFTER FIELD l_xrek027_desc name="construct.a.page2.l_xrek027_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek027_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek027_desc
            #add-point:ON ACTION controlp INFIELD l_xrek027_desc name="construct.c.page2.l_xrek027_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek028
            #add-point:BEFORE FIELD xrek028 name="construct.b.page2.xrek028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek028
            
            #add-point:AFTER FIELD xrek028 name="construct.a.page2.xrek028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek028
            #add-point:ON ACTION controlp INFIELD xrek028 name="construct.c.page2.xrek028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek028_desc
            #add-point:BEFORE FIELD l_xrek028_desc name="construct.b.page2.l_xrek028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek028_desc
            
            #add-point:AFTER FIELD l_xrek028_desc name="construct.a.page2.l_xrek028_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek028_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek028_desc
            #add-point:ON ACTION controlp INFIELD l_xrek028_desc name="construct.c.page2.l_xrek028_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek029
            #add-point:BEFORE FIELD xrek029 name="construct.b.page2.xrek029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek029
            
            #add-point:AFTER FIELD xrek029 name="construct.a.page2.xrek029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek029
            #add-point:ON ACTION controlp INFIELD xrek029 name="construct.c.page2.xrek029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek029_desc
            #add-point:BEFORE FIELD l_xrek029_desc name="construct.b.page2.l_xrek029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek029_desc
            
            #add-point:AFTER FIELD l_xrek029_desc name="construct.a.page2.l_xrek029_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek029_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek029_desc
            #add-point:ON ACTION controlp INFIELD l_xrek029_desc name="construct.c.page2.l_xrek029_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek030
            #add-point:BEFORE FIELD xrek030 name="construct.b.page2.xrek030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek030
            
            #add-point:AFTER FIELD xrek030 name="construct.a.page2.xrek030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek030
            #add-point:ON ACTION controlp INFIELD xrek030 name="construct.c.page2.xrek030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek030_desc
            #add-point:BEFORE FIELD l_xrek030_desc name="construct.b.page2.l_xrek030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek030_desc
            
            #add-point:AFTER FIELD l_xrek030_desc name="construct.a.page2.l_xrek030_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek030_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek030_desc
            #add-point:ON ACTION controlp INFIELD l_xrek030_desc name="construct.c.page2.l_xrek030_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek031
            #add-point:BEFORE FIELD xrek031 name="construct.b.page2.xrek031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek031
            
            #add-point:AFTER FIELD xrek031 name="construct.a.page2.xrek031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek031
            #add-point:ON ACTION controlp INFIELD xrek031 name="construct.c.page2.xrek031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek031_desc
            #add-point:BEFORE FIELD l_xrek031_desc name="construct.b.page2.l_xrek031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek031_desc
            
            #add-point:AFTER FIELD l_xrek031_desc name="construct.a.page2.l_xrek031_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek031_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek031_desc
            #add-point:ON ACTION controlp INFIELD l_xrek031_desc name="construct.c.page2.l_xrek031_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek032
            #add-point:BEFORE FIELD xrek032 name="construct.b.page2.xrek032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek032
            
            #add-point:AFTER FIELD xrek032 name="construct.a.page2.xrek032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrek032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek032
            #add-point:ON ACTION controlp INFIELD xrek032 name="construct.c.page2.xrek032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek032_desc
            #add-point:BEFORE FIELD l_xrek032_desc name="construct.b.page2.l_xrek032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek032_desc
            
            #add-point:AFTER FIELD l_xrek032_desc name="construct.a.page2.l_xrek032_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_xrek032_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek032_desc
            #add-point:ON ACTION controlp INFIELD l_xrek032_desc name="construct.c.page2.l_xrek032_desc"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#66 add
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
                  WHEN la_wc[li_idx].tableid = "xrej_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xrek_t" 
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
   IF NOT INT_FLAG THEN
      LET g_wc = g_wc CLIPPED," AND xrej003 = 'AP' "
   END IF
   #161104-00046#8 --s add
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#8 --s add      
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt940.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aapt940_filter()
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
      CONSTRUCT g_wc_filter ON xrejdocno,xrej001,xrej002,xrej004
                          FROM s_browse[1].b_xrejdocno,s_browse[1].b_xrej001,s_browse[1].b_xrej002,s_browse[1].b_xrej004 
 
 
         BEFORE CONSTRUCT
               DISPLAY aapt940_filter_parser('xrejdocno') TO s_browse[1].b_xrejdocno
            DISPLAY aapt940_filter_parser('xrej001') TO s_browse[1].b_xrej001
            DISPLAY aapt940_filter_parser('xrej002') TO s_browse[1].b_xrej002
            DISPLAY aapt940_filter_parser('xrej004') TO s_browse[1].b_xrej004
      
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
 
      CALL aapt940_filter_show('xrejdocno')
   CALL aapt940_filter_show('xrej001')
   CALL aapt940_filter_show('xrej002')
   CALL aapt940_filter_show('xrej004')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt940.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aapt940_filter_parser(ps_field)
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
 
{<section id="aapt940.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aapt940_filter_show(ps_field)
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
   LET ls_condition = aapt940_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapt940.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapt940_query()
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
   CALL g_xrek_d.clear()
   CALL g_xrek2_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL g_xrek3_d.clear()
   CALL g_xrek4_d.clear()
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aapt940_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapt940_browser_fill("")
      CALL aapt940_fetch("")
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
      CALL aapt940_filter_show('xrejdocno')
   CALL aapt940_filter_show('xrej001')
   CALL aapt940_filter_show('xrej002')
   CALL aapt940_filter_show('xrej004')
   CALL aapt940_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aapt940_fetch("F") 
      #顯示單身筆數
      CALL aapt940_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt940.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapt940_fetch(p_flag)
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
   
   LET g_xrej_m.xrejdocno = g_browser[g_current_idx].b_xrejdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aapt940_master_referesh USING g_xrej_m.xrejdocno INTO g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004, 
       g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus, 
       g_xrej_m.xrejownid,g_xrej_m.xrejowndp,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdt, 
       g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid,g_xrej_m.xrejcnfdt,g_xrej_m.xrejownid_desc, 
       g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp_desc,g_xrej_m.xrejmodid_desc, 
       g_xrej_m.xrejcnfid_desc
   
   #遮罩相關處理
   LET g_xrej_m_mask_o.* =  g_xrej_m.*
   CALL aapt940_xrej_t_mask()
   LET g_xrej_m_mask_n.* =  g_xrej_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt940_set_act_visible()   
   CALL aapt940_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xrej_m_t.* = g_xrej_m.*
   LET g_xrej_m_o.* = g_xrej_m.*
   
   LET g_data_owner = g_xrej_m.xrejownid      
   LET g_data_dept  = g_xrej_m.xrejowndp
   
   #重新顯示   
   CALL aapt940_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt940.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt940_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xrek_d.clear()   
   CALL g_xrek2_d.clear()  
 
 
   INITIALIZE g_xrej_m.* TO NULL             #DEFAULT 設定
   
   LET g_xrejdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   CALL g_xrek3_d.clear()
   CALL g_xrek4_d.clear()
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrej_m.xrejownid = g_user
      LET g_xrej_m.xrejowndp = g_dept
      LET g_xrej_m.xrejcrtid = g_user
      LET g_xrej_m.xrejcrtdp = g_dept 
      LET g_xrej_m.xrejcrtdt = cl_get_current()
      LET g_xrej_m.xrejmodid = g_user
      LET g_xrej_m.xrejmoddt = cl_get_current()
      LET g_xrej_m.xrejstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xrej_m_t.* = g_xrej_m.*
      LET g_xrej_m_o.* = g_xrej_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrej_m.xrejstus 
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
 
 
 
    
      CALL aapt940_input("a")
      
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
         INITIALIZE g_xrej_m.* TO NULL
         INITIALIZE g_xrek_d TO NULL
         INITIALIZE g_xrek2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aapt940_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xrek_d.clear()
      #CALL g_xrek2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt940_set_act_visible()   
   CALL aapt940_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xrejdocno_t = g_xrej_m.xrejdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrejent = " ||g_enterprise|| " AND",
                      " xrejdocno = '", g_xrej_m.xrejdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt940_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aapt940_cl
   
   CALL aapt940_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapt940_master_referesh USING g_xrej_m.xrejdocno INTO g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004, 
       g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus, 
       g_xrej_m.xrejownid,g_xrej_m.xrejowndp,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdt, 
       g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid,g_xrej_m.xrejcnfdt,g_xrej_m.xrejownid_desc, 
       g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp_desc,g_xrej_m.xrejmodid_desc, 
       g_xrej_m.xrejcnfid_desc
   
   
   #遮罩相關處理
   LET g_xrej_m_mask_o.* =  g_xrej_m.*
   CALL aapt940_xrej_t_mask()
   LET g_xrej_m_mask_n.* =  g_xrej_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrej_m.xrejsite,g_xrej_m.xrejsite_desc,g_xrej_m.xrejld,g_xrej_m.xrejld_desc,g_xrej_m.xrej004, 
       g_xrej_m.xrej004_desc,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002, 
       g_xrej_m.xrej005,g_xrej_m.xrejstus,g_xrej_m.xrejownid,g_xrej_m.xrejownid_desc,g_xrej_m.xrejowndp, 
       g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdp_desc, 
       g_xrej_m.xrejcrtdt,g_xrej_m.xrejmodid,g_xrej_m.xrejmodid_desc,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid, 
       g_xrej_m.xrejcnfid_desc,g_xrej_m.xrejcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_xrej_m.xrejownid      
   LET g_data_dept  = g_xrej_m.xrejowndp
   
   #功能已完成,通報訊息中心
   CALL aapt940_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt940_modify()
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
   LET g_xrej_m_t.* = g_xrej_m.*
   LET g_xrej_m_o.* = g_xrej_m.*
   
   IF g_xrej_m.xrejdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xrejdocno_t = g_xrej_m.xrejdocno
 
   CALL s_transaction_begin()
   
   OPEN aapt940_cl USING g_enterprise,g_xrej_m.xrejdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt940_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt940_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt940_master_referesh USING g_xrej_m.xrejdocno INTO g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004, 
       g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus, 
       g_xrej_m.xrejownid,g_xrej_m.xrejowndp,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdt, 
       g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid,g_xrej_m.xrejcnfdt,g_xrej_m.xrejownid_desc, 
       g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp_desc,g_xrej_m.xrejmodid_desc, 
       g_xrej_m.xrejcnfid_desc
   
   #檢查是否允許此動作
   IF NOT aapt940_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xrej_m_mask_o.* =  g_xrej_m.*
   CALL aapt940_xrej_t_mask()
   LET g_xrej_m_mask_n.* =  g_xrej_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aapt940_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_xrejdocno_t = g_xrej_m.xrejdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xrej_m.xrejmodid = g_user 
LET g_xrej_m.xrejmoddt = cl_get_current()
LET g_xrej_m.xrejmodid_desc = cl_get_username(g_xrej_m.xrejmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aapt940_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xrej_t SET (xrejmodid,xrejmoddt) = (g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt)
          WHERE xrejent = g_enterprise AND xrejdocno = g_xrejdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xrej_m.* = g_xrej_m_t.*
            CALL aapt940_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xrej_m.xrejdocno != g_xrej_m_t.xrejdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xrek_t SET xrekdocno = g_xrej_m.xrejdocno
 
          WHERE xrekent = g_enterprise AND xrekdocno = g_xrej_m_t.xrejdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
            AND xrej003 = 'AP'
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xrek_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrek_t:",SQLERRMESSAGE 
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
   CALL aapt940_set_act_visible()   
   CALL aapt940_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xrejent = " ||g_enterprise|| " AND",
                      " xrejdocno = '", g_xrej_m.xrejdocno, "' "
 
   #填到對應位置
   CALL aapt940_browser_fill("")
 
   CLOSE aapt940_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt940_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aapt940.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapt940_input(p_cmd)
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
   DEFINE  l_glaa121             LIKE glaa_t.glaa121    #141218-00011#6
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
   DISPLAY BY NAME g_xrej_m.xrejsite,g_xrej_m.xrejsite_desc,g_xrej_m.xrejld,g_xrej_m.xrejld_desc,g_xrej_m.xrej004, 
       g_xrej_m.xrej004_desc,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002, 
       g_xrej_m.xrej005,g_xrej_m.xrejstus,g_xrej_m.xrejownid,g_xrej_m.xrejownid_desc,g_xrej_m.xrejowndp, 
       g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdp_desc, 
       g_xrej_m.xrejcrtdt,g_xrej_m.xrejmodid,g_xrej_m.xrejmodid_desc,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid, 
       g_xrej_m.xrejcnfid_desc,g_xrej_m.xrejcnfdt
   
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
   LET g_forupd_sql = "SELECT xrekseq,xrek005,xrek006,xrek007,xrek100,xrek103,xrek113,xrek037,xrek039, 
       xrek105,xrek115,xrek104,xrek114,xrek038,xrek040,xrek106,xrek116,xrek107,xrek117,xrekseq,xrek033, 
       xrek019,xrek041,xrekorga,xrek009,xrek016,xrek011,xrek012,xrek013,xrek014,xrek015,xrek017,xrek018, 
       xrek020,xrek021,xrek022,xrek023,xrek024,xrek025,xrek026,xrek027,xrek028,xrek029,xrek030,xrek031, 
       xrek032 FROM xrek_t WHERE xrekent=? AND xrekdocno=? AND xrekseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt940_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aapt940_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aapt940_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt, 
       g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aapt940.input.head" >}
      #單頭段
      INPUT BY NAME g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt, 
          g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aapt940_cl USING g_enterprise,g_xrej_m.xrejdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt940_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt940_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aapt940_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            NEXT FIELD xrek033
            #end add-point
            CALL aapt940_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejsite
            
            #add-point:AFTER FIELD xrejsite name="input.a.xrejsite"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejsite
            #add-point:BEFORE FIELD xrejsite name="input.b.xrejsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrejsite
            #add-point:ON CHANGE xrejsite name="input.g.xrejsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejld
            
            #add-point:AFTER FIELD xrejld name="input.a.xrejld"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejld
            #add-point:BEFORE FIELD xrejld name="input.b.xrejld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrejld
            #add-point:ON CHANGE xrejld name="input.g.xrejld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej004
            
            #add-point:AFTER FIELD xrej004 name="input.a.xrej004"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej004
            #add-point:BEFORE FIELD xrej004 name="input.b.xrej004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrej004
            #add-point:ON CHANGE xrej004 name="input.g.xrej004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejdocno
            #add-point:BEFORE FIELD xrejdocno name="input.b.xrejdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejdocno
            
            #add-point:AFTER FIELD xrejdocno name="input.a.xrejdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xrej_m.xrejdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xrej_m.xrejdocno != g_xrejdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrej_t WHERE "||"xrejent = '" ||g_enterprise|| "' AND "||"xrejdocno = '"||g_xrej_m.xrejdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrejdocno
            #add-point:ON CHANGE xrejdocno name="input.g.xrejdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejdocdt
            #add-point:BEFORE FIELD xrejdocdt name="input.b.xrejdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejdocdt
            
            #add-point:AFTER FIELD xrejdocdt name="input.a.xrejdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrejdocdt
            #add-point:ON CHANGE xrejdocdt name="input.g.xrejdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej001
            #add-point:BEFORE FIELD xrej001 name="input.b.xrej001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej001
            
            #add-point:AFTER FIELD xrej001 name="input.a.xrej001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrej001
            #add-point:ON CHANGE xrej001 name="input.g.xrej001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej002
            #add-point:BEFORE FIELD xrej002 name="input.b.xrej002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej002
            
            #add-point:AFTER FIELD xrej002 name="input.a.xrej002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrej002
            #add-point:ON CHANGE xrej002 name="input.g.xrej002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej005
            #add-point:BEFORE FIELD xrej005 name="input.b.xrej005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej005
            
            #add-point:AFTER FIELD xrej005 name="input.a.xrej005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrej005
            #add-point:ON CHANGE xrej005 name="input.g.xrej005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejstus
            #add-point:BEFORE FIELD xrejstus name="input.b.xrejstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejstus
            
            #add-point:AFTER FIELD xrejstus name="input.a.xrejstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrejstus
            #add-point:ON CHANGE xrejstus name="input.g.xrejstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xrejsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejsite
            #add-point:ON ACTION controlp INFIELD xrejsite name="input.c.xrejsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrejld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejld
            #add-point:ON ACTION controlp INFIELD xrejld name="input.c.xrejld"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrej004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej004
            #add-point:ON ACTION controlp INFIELD xrej004 name="input.c.xrej004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrejdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejdocno
            #add-point:ON ACTION controlp INFIELD xrejdocno name="input.c.xrejdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrejdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejdocdt
            #add-point:ON ACTION controlp INFIELD xrejdocdt name="input.c.xrejdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrej001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej001
            #add-point:ON ACTION controlp INFIELD xrej001 name="input.c.xrej001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrej002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej002
            #add-point:ON ACTION controlp INFIELD xrej002 name="input.c.xrej002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrej005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej005
            #add-point:ON ACTION controlp INFIELD xrej005 name="input.c.xrej005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrejstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejstus
            #add-point:ON ACTION controlp INFIELD xrejstus name="input.c.xrejstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xrej_m.xrejdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO xrej_t (xrejent,xrejsite,xrejld,xrej004,xrejdocno,xrejdocdt,xrej001,xrej002, 
                   xrej005,xrejstus,xrejownid,xrejowndp,xrejcrtid,xrejcrtdp,xrejcrtdt,xrejmodid,xrejmoddt, 
                   xrejcnfid,xrejcnfdt)
               VALUES (g_enterprise,g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004,g_xrej_m.xrejdocno, 
                   g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus, 
                   g_xrej_m.xrejownid,g_xrej_m.xrejowndp,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdt, 
                   g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid,g_xrej_m.xrejcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xrej_m:",SQLERRMESSAGE 
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
                  CALL aapt940_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aapt940_b_fill()
                  CALL aapt940_b_fill2('0')
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
               CALL aapt940_xrej_t_mask_restore('restore_mask_o')
               
               UPDATE xrej_t SET (xrejsite,xrejld,xrej004,xrejdocno,xrejdocdt,xrej001,xrej002,xrej005, 
                   xrejstus,xrejownid,xrejowndp,xrejcrtid,xrejcrtdp,xrejcrtdt,xrejmodid,xrejmoddt,xrejcnfid, 
                   xrejcnfdt) = (g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004,g_xrej_m.xrejdocno, 
                   g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus, 
                   g_xrej_m.xrejownid,g_xrej_m.xrejowndp,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdt, 
                   g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid,g_xrej_m.xrejcnfdt)
                WHERE xrejent = g_enterprise AND xrejdocno = g_xrejdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrej_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aapt940_xrej_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xrej_m_t)
               LET g_log2 = util.JSON.stringify(g_xrej_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xrejdocno_t = g_xrej_m.xrejdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aapt940.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xrek_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            NEXT FIELD xrek033
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xrek_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt940_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xrek_d.getLength()
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
            OPEN aapt940_cl USING g_enterprise,g_xrej_m.xrejdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt940_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt940_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xrek_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xrek_d[l_ac].xrekseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xrek_d_t.* = g_xrek_d[l_ac].*  #BACKUP
               LET g_xrek_d_o.* = g_xrek_d[l_ac].*  #BACKUP
               CALL aapt940_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aapt940_set_no_entry_b(l_cmd)
               IF NOT aapt940_lock_b("xrek_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt940_bcl INTO g_xrek_d[l_ac].xrekseq,g_xrek_d[l_ac].xrek005,g_xrek_d[l_ac].xrek006, 
                      g_xrek_d[l_ac].xrek007,g_xrek_d[l_ac].xrek100,g_xrek_d[l_ac].xrek103,g_xrek_d[l_ac].xrek113, 
                      g_xrek_d[l_ac].xrek037,g_xrek_d[l_ac].xrek039,g_xrek_d[l_ac].xrek105,g_xrek_d[l_ac].xrek115, 
                      g_xrek_d[l_ac].xrek104,g_xrek_d[l_ac].xrek114,g_xrek_d[l_ac].xrek038,g_xrek_d[l_ac].xrek040, 
                      g_xrek_d[l_ac].xrek106,g_xrek_d[l_ac].xrek116,g_xrek_d[l_ac].xrek107,g_xrek_d[l_ac].xrek117, 
                      g_xrek2_d[l_ac].xrekseq,g_xrek2_d[l_ac].xrek033,g_xrek2_d[l_ac].xrek019,g_xrek2_d[l_ac].xrek041, 
                      g_xrek2_d[l_ac].xrekorga,g_xrek2_d[l_ac].xrek009,g_xrek2_d[l_ac].xrek016,g_xrek2_d[l_ac].xrek011, 
                      g_xrek2_d[l_ac].xrek012,g_xrek2_d[l_ac].xrek013,g_xrek2_d[l_ac].xrek014,g_xrek2_d[l_ac].xrek015, 
                      g_xrek2_d[l_ac].xrek017,g_xrek2_d[l_ac].xrek018,g_xrek2_d[l_ac].xrek020,g_xrek2_d[l_ac].xrek021, 
                      g_xrek2_d[l_ac].xrek022,g_xrek2_d[l_ac].xrek023,g_xrek2_d[l_ac].xrek024,g_xrek2_d[l_ac].xrek025, 
                      g_xrek2_d[l_ac].xrek026,g_xrek2_d[l_ac].xrek027,g_xrek2_d[l_ac].xrek028,g_xrek2_d[l_ac].xrek029, 
                      g_xrek2_d[l_ac].xrek030,g_xrek2_d[l_ac].xrek031,g_xrek2_d[l_ac].xrek032
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xrek_d_t.xrekseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrek_d_mask_o[l_ac].* =  g_xrek_d[l_ac].*
                  CALL aapt940_xrek_t_mask()
                  LET g_xrek_d_mask_n[l_ac].* =  g_xrek_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt940_show()
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
            INITIALIZE g_xrek_d[l_ac].* TO NULL 
            INITIALIZE g_xrek_d_t.* TO NULL 
            INITIALIZE g_xrek_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_xrek_d[l_ac].xrek103 = "0"
      LET g_xrek_d[l_ac].xrek113 = "0"
      LET g_xrek_d[l_ac].xrek105 = "0"
      LET g_xrek_d[l_ac].xrek115 = "0"
      LET g_xrek_d[l_ac].xrek104 = "0"
      LET g_xrek_d[l_ac].xrek114 = "0"
      LET g_xrek_d[l_ac].xrek106 = "0"
      LET g_xrek_d[l_ac].xrek116 = "0"
      LET g_xrek_d[l_ac].xrek107 = "0"
      LET g_xrek_d[l_ac].xrek117 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xrek_d_t.* = g_xrek_d[l_ac].*     #新輸入資料
            LET g_xrek_d_o.* = g_xrek_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt940_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt940_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrek_d[li_reproduce_target].* = g_xrek_d[li_reproduce].*
               LET g_xrek2_d[li_reproduce_target].* = g_xrek2_d[li_reproduce].*
 
               LET g_xrek_d[li_reproduce_target].xrekseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xrek_t 
             WHERE xrekent = g_enterprise AND xrekdocno = g_xrej_m.xrejdocno
 
               AND xrekseq = g_xrek_d[l_ac].xrekseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrej_m.xrejdocno
               LET gs_keys[2] = g_xrek_d[g_detail_idx].xrekseq
               CALL aapt940_insert_b('xrek_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xrek_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrek_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt940_b_fill()
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
               LET gs_keys[01] = g_xrej_m.xrejdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_xrek_d_t.xrekseq
 
            
               #刪除同層單身
               IF NOT aapt940_delete_b('xrek_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt940_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt940_key_delete_b(gs_keys,'xrek_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt940_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt940_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xrek_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xrek_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrekseq
            #add-point:BEFORE FIELD xrekseq name="input.b.page1.xrekseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrekseq
            
            #add-point:AFTER FIELD xrekseq name="input.a.page1.xrekseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xrej_m.xrejdocno IS NOT NULL AND g_xrek_d[g_detail_idx].xrekseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xrej_m.xrejdocno != g_xrejdocno_t OR g_xrek_d[g_detail_idx].xrekseq != g_xrek_d_t.xrekseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrek_t WHERE "||"xrekent = '" ||g_enterprise|| "' AND "||"xrekdocno = '"||g_xrej_m.xrejdocno ||"' AND "|| "xrekseq = '"||g_xrek_d[g_detail_idx].xrekseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrekseq
            #add-point:ON CHANGE xrekseq name="input.g.page1.xrekseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek005
            #add-point:BEFORE FIELD xrek005 name="input.b.page1.xrek005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek005
            
            #add-point:AFTER FIELD xrek005 name="input.a.page1.xrek005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek005
            #add-point:ON CHANGE xrek005 name="input.g.page1.xrek005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek006
            #add-point:BEFORE FIELD xrek006 name="input.b.page1.xrek006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek006
            
            #add-point:AFTER FIELD xrek006 name="input.a.page1.xrek006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek006
            #add-point:ON CHANGE xrek006 name="input.g.page1.xrek006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek007
            #add-point:BEFORE FIELD xrek007 name="input.b.page1.xrek007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek007
            
            #add-point:AFTER FIELD xrek007 name="input.a.page1.xrek007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek007
            #add-point:ON CHANGE xrek007 name="input.g.page1.xrek007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek100
            #add-point:BEFORE FIELD xrek100 name="input.b.page1.xrek100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek100
            
            #add-point:AFTER FIELD xrek100 name="input.a.page1.xrek100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek100
            #add-point:ON CHANGE xrek100 name="input.g.page1.xrek100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek103
            #add-point:BEFORE FIELD xrek103 name="input.b.page1.xrek103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek103
            
            #add-point:AFTER FIELD xrek103 name="input.a.page1.xrek103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek103
            #add-point:ON CHANGE xrek103 name="input.g.page1.xrek103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek113
            #add-point:BEFORE FIELD xrek113 name="input.b.page1.xrek113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek113
            
            #add-point:AFTER FIELD xrek113 name="input.a.page1.xrek113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek113
            #add-point:ON CHANGE xrek113 name="input.g.page1.xrek113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek037
            #add-point:BEFORE FIELD xrek037 name="input.b.page1.xrek037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek037
            
            #add-point:AFTER FIELD xrek037 name="input.a.page1.xrek037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek037
            #add-point:ON CHANGE xrek037 name="input.g.page1.xrek037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek039
            #add-point:BEFORE FIELD xrek039 name="input.b.page1.xrek039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek039
            
            #add-point:AFTER FIELD xrek039 name="input.a.page1.xrek039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek039
            #add-point:ON CHANGE xrek039 name="input.g.page1.xrek039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek105
            #add-point:BEFORE FIELD xrek105 name="input.b.page1.xrek105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek105
            
            #add-point:AFTER FIELD xrek105 name="input.a.page1.xrek105"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek105
            #add-point:ON CHANGE xrek105 name="input.g.page1.xrek105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek115
            #add-point:BEFORE FIELD xrek115 name="input.b.page1.xrek115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek115
            
            #add-point:AFTER FIELD xrek115 name="input.a.page1.xrek115"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek115
            #add-point:ON CHANGE xrek115 name="input.g.page1.xrek115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek104
            #add-point:BEFORE FIELD xrek104 name="input.b.page1.xrek104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek104
            
            #add-point:AFTER FIELD xrek104 name="input.a.page1.xrek104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek104
            #add-point:ON CHANGE xrek104 name="input.g.page1.xrek104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek114
            #add-point:BEFORE FIELD xrek114 name="input.b.page1.xrek114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek114
            
            #add-point:AFTER FIELD xrek114 name="input.a.page1.xrek114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek114
            #add-point:ON CHANGE xrek114 name="input.g.page1.xrek114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek038
            #add-point:BEFORE FIELD xrek038 name="input.b.page1.xrek038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek038
            
            #add-point:AFTER FIELD xrek038 name="input.a.page1.xrek038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek038
            #add-point:ON CHANGE xrek038 name="input.g.page1.xrek038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek040
            #add-point:BEFORE FIELD xrek040 name="input.b.page1.xrek040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek040
            
            #add-point:AFTER FIELD xrek040 name="input.a.page1.xrek040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek040
            #add-point:ON CHANGE xrek040 name="input.g.page1.xrek040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek106
            #add-point:BEFORE FIELD xrek106 name="input.b.page1.xrek106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek106
            
            #add-point:AFTER FIELD xrek106 name="input.a.page1.xrek106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek106
            #add-point:ON CHANGE xrek106 name="input.g.page1.xrek106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek116
            #add-point:BEFORE FIELD xrek116 name="input.b.page1.xrek116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek116
            
            #add-point:AFTER FIELD xrek116 name="input.a.page1.xrek116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek116
            #add-point:ON CHANGE xrek116 name="input.g.page1.xrek116"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek107
            #add-point:BEFORE FIELD xrek107 name="input.b.page1.xrek107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek107
            
            #add-point:AFTER FIELD xrek107 name="input.a.page1.xrek107"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek107
            #add-point:ON CHANGE xrek107 name="input.g.page1.xrek107"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek117
            #add-point:BEFORE FIELD xrek117 name="input.b.page1.xrek117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek117
            
            #add-point:AFTER FIELD xrek117 name="input.a.page1.xrek117"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek117
            #add-point:ON CHANGE xrek117 name="input.g.page1.xrek117"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xrekseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrekseq
            #add-point:ON ACTION controlp INFIELD xrekseq name="input.c.page1.xrekseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek005
            #add-point:ON ACTION controlp INFIELD xrek005 name="input.c.page1.xrek005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek006
            #add-point:ON ACTION controlp INFIELD xrek006 name="input.c.page1.xrek006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek007
            #add-point:ON ACTION controlp INFIELD xrek007 name="input.c.page1.xrek007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek100
            #add-point:ON ACTION controlp INFIELD xrek100 name="input.c.page1.xrek100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek103
            #add-point:ON ACTION controlp INFIELD xrek103 name="input.c.page1.xrek103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek113
            #add-point:ON ACTION controlp INFIELD xrek113 name="input.c.page1.xrek113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek037
            #add-point:ON ACTION controlp INFIELD xrek037 name="input.c.page1.xrek037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek039
            #add-point:ON ACTION controlp INFIELD xrek039 name="input.c.page1.xrek039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek105
            #add-point:ON ACTION controlp INFIELD xrek105 name="input.c.page1.xrek105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek115
            #add-point:ON ACTION controlp INFIELD xrek115 name="input.c.page1.xrek115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek104
            #add-point:ON ACTION controlp INFIELD xrek104 name="input.c.page1.xrek104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek114
            #add-point:ON ACTION controlp INFIELD xrek114 name="input.c.page1.xrek114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek038
            #add-point:ON ACTION controlp INFIELD xrek038 name="input.c.page1.xrek038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek040
            #add-point:ON ACTION controlp INFIELD xrek040 name="input.c.page1.xrek040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek106
            #add-point:ON ACTION controlp INFIELD xrek106 name="input.c.page1.xrek106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek116
            #add-point:ON ACTION controlp INFIELD xrek116 name="input.c.page1.xrek116"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek107
            #add-point:ON ACTION controlp INFIELD xrek107 name="input.c.page1.xrek107"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrek117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek117
            #add-point:ON ACTION controlp INFIELD xrek117 name="input.c.page1.xrek117"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xrek_d[l_ac].* = g_xrek_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt940_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xrek_d[l_ac].xrekseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xrek_d[l_ac].* = g_xrek_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aapt940_xrek_t_mask_restore('restore_mask_o')
      
               UPDATE xrek_t SET (xrekdocno,xrekseq,xrek005,xrek006,xrek007,xrek100,xrek103,xrek113, 
                   xrek037,xrek039,xrek105,xrek115,xrek104,xrek114,xrek038,xrek040,xrek106,xrek116,xrek107, 
                   xrek117,xrek033,xrek019,xrek041,xrekorga,xrek009,xrek016,xrek011,xrek012,xrek013, 
                   xrek014,xrek015,xrek017,xrek018,xrek020,xrek021,xrek022,xrek023,xrek024,xrek025,xrek026, 
                   xrek027,xrek028,xrek029,xrek030,xrek031,xrek032) = (g_xrej_m.xrejdocno,g_xrek_d[l_ac].xrekseq, 
                   g_xrek_d[l_ac].xrek005,g_xrek_d[l_ac].xrek006,g_xrek_d[l_ac].xrek007,g_xrek_d[l_ac].xrek100, 
                   g_xrek_d[l_ac].xrek103,g_xrek_d[l_ac].xrek113,g_xrek_d[l_ac].xrek037,g_xrek_d[l_ac].xrek039, 
                   g_xrek_d[l_ac].xrek105,g_xrek_d[l_ac].xrek115,g_xrek_d[l_ac].xrek104,g_xrek_d[l_ac].xrek114, 
                   g_xrek_d[l_ac].xrek038,g_xrek_d[l_ac].xrek040,g_xrek_d[l_ac].xrek106,g_xrek_d[l_ac].xrek116, 
                   g_xrek_d[l_ac].xrek107,g_xrek_d[l_ac].xrek117,g_xrek2_d[l_ac].xrek033,g_xrek2_d[l_ac].xrek019, 
                   g_xrek2_d[l_ac].xrek041,g_xrek2_d[l_ac].xrekorga,g_xrek2_d[l_ac].xrek009,g_xrek2_d[l_ac].xrek016, 
                   g_xrek2_d[l_ac].xrek011,g_xrek2_d[l_ac].xrek012,g_xrek2_d[l_ac].xrek013,g_xrek2_d[l_ac].xrek014, 
                   g_xrek2_d[l_ac].xrek015,g_xrek2_d[l_ac].xrek017,g_xrek2_d[l_ac].xrek018,g_xrek2_d[l_ac].xrek020, 
                   g_xrek2_d[l_ac].xrek021,g_xrek2_d[l_ac].xrek022,g_xrek2_d[l_ac].xrek023,g_xrek2_d[l_ac].xrek024, 
                   g_xrek2_d[l_ac].xrek025,g_xrek2_d[l_ac].xrek026,g_xrek2_d[l_ac].xrek027,g_xrek2_d[l_ac].xrek028, 
                   g_xrek2_d[l_ac].xrek029,g_xrek2_d[l_ac].xrek030,g_xrek2_d[l_ac].xrek031,g_xrek2_d[l_ac].xrek032) 
 
                WHERE xrekent = g_enterprise AND xrekdocno = g_xrej_m.xrejdocno 
 
                  AND xrekseq = g_xrek_d_t.xrekseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xrek_d[l_ac].* = g_xrek_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrek_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xrek_d[l_ac].* = g_xrek_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrek_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrej_m.xrejdocno
               LET gs_keys_bak[1] = g_xrejdocno_t
               LET gs_keys[2] = g_xrek_d[g_detail_idx].xrekseq
               LET gs_keys_bak[2] = g_xrek_d_t.xrekseq
               CALL aapt940_update_b('xrek_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aapt940_xrek_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xrek_d[g_detail_idx].xrekseq = g_xrek_d_t.xrekseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xrej_m.xrejdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xrek_d_t.xrekseq
 
                  CALL aapt940_key_update_b(gs_keys,'xrek_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xrej_m),util.JSON.stringify(g_xrek_d_t)
               LET g_log2 = util.JSON.stringify(g_xrej_m),util.JSON.stringify(g_xrek_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aapt940_unlock_b("xrek_t","'1'")
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
               LET g_xrek_d[li_reproduce_target].* = g_xrek_d[li_reproduce].*
               LET g_xrek2_d[li_reproduce_target].* = g_xrek2_d[li_reproduce].*
 
               LET g_xrek_d[li_reproduce_target].xrekseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrek_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrek_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_xrek2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            
            CALL aapt940_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xrek2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            CALL s_ld_sel_glaa(g_xrej_m.xrejld,'glaa121') RETURNING g_sub_success,l_glaa121  #141218-00011#6
            NEXT FIELD xrek033
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrek2_d[l_ac].* TO NULL 
            INITIALIZE g_xrek2_d_t.* TO NULL 
            INITIALIZE g_xrek2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_xrek2_d_t.* = g_xrek2_d[l_ac].*     #新輸入資料
            LET g_xrek2_d_o.* = g_xrek2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt940_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt940_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrek_d[li_reproduce_target].* = g_xrek_d[li_reproduce].*
               LET g_xrek2_d[li_reproduce_target].* = g_xrek2_d[li_reproduce].*
 
               LET g_xrek2_d[li_reproduce_target].xrekseq = NULL
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
            OPEN aapt940_cl USING g_enterprise,g_xrej_m.xrejdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt940_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt940_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xrek2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xrek2_d[l_ac].xrekseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xrek2_d_t.* = g_xrek2_d[l_ac].*  #BACKUP
               LET g_xrek2_d_o.* = g_xrek2_d[l_ac].*  #BACKUP
               CALL aapt940_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL aapt940_set_no_entry_b(l_cmd)
               IF NOT aapt940_lock_b("xrek_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt940_bcl INTO g_xrek_d[l_ac].xrekseq,g_xrek_d[l_ac].xrek005,g_xrek_d[l_ac].xrek006, 
                      g_xrek_d[l_ac].xrek007,g_xrek_d[l_ac].xrek100,g_xrek_d[l_ac].xrek103,g_xrek_d[l_ac].xrek113, 
                      g_xrek_d[l_ac].xrek037,g_xrek_d[l_ac].xrek039,g_xrek_d[l_ac].xrek105,g_xrek_d[l_ac].xrek115, 
                      g_xrek_d[l_ac].xrek104,g_xrek_d[l_ac].xrek114,g_xrek_d[l_ac].xrek038,g_xrek_d[l_ac].xrek040, 
                      g_xrek_d[l_ac].xrek106,g_xrek_d[l_ac].xrek116,g_xrek_d[l_ac].xrek107,g_xrek_d[l_ac].xrek117, 
                      g_xrek2_d[l_ac].xrekseq,g_xrek2_d[l_ac].xrek033,g_xrek2_d[l_ac].xrek019,g_xrek2_d[l_ac].xrek041, 
                      g_xrek2_d[l_ac].xrekorga,g_xrek2_d[l_ac].xrek009,g_xrek2_d[l_ac].xrek016,g_xrek2_d[l_ac].xrek011, 
                      g_xrek2_d[l_ac].xrek012,g_xrek2_d[l_ac].xrek013,g_xrek2_d[l_ac].xrek014,g_xrek2_d[l_ac].xrek015, 
                      g_xrek2_d[l_ac].xrek017,g_xrek2_d[l_ac].xrek018,g_xrek2_d[l_ac].xrek020,g_xrek2_d[l_ac].xrek021, 
                      g_xrek2_d[l_ac].xrek022,g_xrek2_d[l_ac].xrek023,g_xrek2_d[l_ac].xrek024,g_xrek2_d[l_ac].xrek025, 
                      g_xrek2_d[l_ac].xrek026,g_xrek2_d[l_ac].xrek027,g_xrek2_d[l_ac].xrek028,g_xrek2_d[l_ac].xrek029, 
                      g_xrek2_d[l_ac].xrek030,g_xrek2_d[l_ac].xrek031,g_xrek2_d[l_ac].xrek032
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrek2_d_mask_o[l_ac].* =  g_xrek2_d[l_ac].*
                  CALL aapt940_xrek_t_mask()
                  LET g_xrek2_d_mask_n[l_ac].* =  g_xrek2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt940_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            INITIALIZE g_glad.* TO NULL
            LET g_glad.glad017 = 'N' #自由核算項一控制方式
            LET g_glad.glad018 = 'N'
            LET g_glad.glad019 = 'N'
            LET g_glad.glad020 = 'N'
            LET g_glad.glad021 = 'N'
            LET g_glad.glad022 = 'N'
            LET g_glad.glad023 = 'N'
            LET g_glad.glad024 = 'N'
            LET g_glad.glad025 = 'N'
            LET g_glad.glad026 = 'N' #自由核算項十控制方式
            IF NOT cl_null(g_xrek2_d[l_ac].xrek019) THEN
               #140818-00002#2 albireo 150316 modify-----s
                #CALL aapt940_glad_chk(g_xrek2_d[l_ac].xrek019) RETURNING g_glad.*  
                CALL aapt940_glad_chk(g_xrek2_d[l_ac].xrek019)  
               #140818-00002#2 albireo 150316 modify-----e
            END IF  
            
            IF NOT cl_null(g_xrek2_d[l_ac].xrek041) THEN
               #140818-00002#2 albireo 150316 modify-----s
               #CALL aapt940_glad_chk(g_xrek2_d[l_ac].xrek041) RETURNING g_glad.*  
               CALL aapt940_glad_chk(g_xrek2_d[l_ac].xrek041)               
               #140818-00002#2 albireo 150316 modify-----e
            END IF 
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
               LET gs_keys[01] = g_xrej_m.xrejdocno
               LET gs_keys[gs_keys.getLength()+1] = g_xrek2_d_t.xrekseq
            
               #刪除同層單身
               IF NOT aapt940_delete_b('xrek_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt940_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt940_key_delete_b(gs_keys,'xrek_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt940_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt940_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_xrek_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xrek2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM xrek_t 
             WHERE xrekent = g_enterprise AND xrekdocno = g_xrej_m.xrejdocno
               AND xrekseq = g_xrek2_d[l_ac].xrekseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrej_m.xrejdocno
               LET gs_keys[2] = g_xrek2_d[g_detail_idx].xrekseq
               CALL aapt940_insert_b('xrek_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xrek_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xrek_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt940_b_fill()
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
               LET g_xrek2_d[l_ac].* = g_xrek2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt940_bcl
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
               LET g_xrek2_d[l_ac].* = g_xrek2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aapt940_xrek_t_mask_restore('restore_mask_o')
                              
               UPDATE xrek_t SET (xrekdocno,xrekseq,xrek005,xrek006,xrek007,xrek100,xrek103,xrek113, 
                   xrek037,xrek039,xrek105,xrek115,xrek104,xrek114,xrek038,xrek040,xrek106,xrek116,xrek107, 
                   xrek117,xrek033,xrek019,xrek041,xrekorga,xrek009,xrek016,xrek011,xrek012,xrek013, 
                   xrek014,xrek015,xrek017,xrek018,xrek020,xrek021,xrek022,xrek023,xrek024,xrek025,xrek026, 
                   xrek027,xrek028,xrek029,xrek030,xrek031,xrek032) = (g_xrej_m.xrejdocno,g_xrek_d[l_ac].xrekseq, 
                   g_xrek_d[l_ac].xrek005,g_xrek_d[l_ac].xrek006,g_xrek_d[l_ac].xrek007,g_xrek_d[l_ac].xrek100, 
                   g_xrek_d[l_ac].xrek103,g_xrek_d[l_ac].xrek113,g_xrek_d[l_ac].xrek037,g_xrek_d[l_ac].xrek039, 
                   g_xrek_d[l_ac].xrek105,g_xrek_d[l_ac].xrek115,g_xrek_d[l_ac].xrek104,g_xrek_d[l_ac].xrek114, 
                   g_xrek_d[l_ac].xrek038,g_xrek_d[l_ac].xrek040,g_xrek_d[l_ac].xrek106,g_xrek_d[l_ac].xrek116, 
                   g_xrek_d[l_ac].xrek107,g_xrek_d[l_ac].xrek117,g_xrek2_d[l_ac].xrek033,g_xrek2_d[l_ac].xrek019, 
                   g_xrek2_d[l_ac].xrek041,g_xrek2_d[l_ac].xrekorga,g_xrek2_d[l_ac].xrek009,g_xrek2_d[l_ac].xrek016, 
                   g_xrek2_d[l_ac].xrek011,g_xrek2_d[l_ac].xrek012,g_xrek2_d[l_ac].xrek013,g_xrek2_d[l_ac].xrek014, 
                   g_xrek2_d[l_ac].xrek015,g_xrek2_d[l_ac].xrek017,g_xrek2_d[l_ac].xrek018,g_xrek2_d[l_ac].xrek020, 
                   g_xrek2_d[l_ac].xrek021,g_xrek2_d[l_ac].xrek022,g_xrek2_d[l_ac].xrek023,g_xrek2_d[l_ac].xrek024, 
                   g_xrek2_d[l_ac].xrek025,g_xrek2_d[l_ac].xrek026,g_xrek2_d[l_ac].xrek027,g_xrek2_d[l_ac].xrek028, 
                   g_xrek2_d[l_ac].xrek029,g_xrek2_d[l_ac].xrek030,g_xrek2_d[l_ac].xrek031,g_xrek2_d[l_ac].xrek032)  
                   #自訂欄位頁簽
                WHERE xrekent = g_enterprise AND xrekdocno = g_xrej_m.xrejdocno
                  AND xrekseq = g_xrek2_d_t.xrekseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xrek2_d[l_ac].* = g_xrek2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrek_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xrek2_d[l_ac].* = g_xrek2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrek_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrej_m.xrejdocno
               LET gs_keys_bak[1] = g_xrejdocno_t
               LET gs_keys[2] = g_xrek2_d[g_detail_idx].xrekseq
               LET gs_keys_bak[2] = g_xrek2_d_t.xrekseq
               CALL aapt940_update_b('xrek_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt940_xrek_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xrek2_d[g_detail_idx].xrekseq = g_xrek2_d_t.xrekseq 
                  ) THEN
                  LET gs_keys[01] = g_xrej_m.xrejdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xrek2_d_t.xrekseq
                  CALL aapt940_key_update_b(gs_keys,'xrek_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xrej_m),util.JSON.stringify(g_xrek2_d_t)
               LET g_log2 = util.JSON.stringify(g_xrej_m),util.JSON.stringify(g_xrek2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek033
            #add-point:BEFORE FIELD xrek033 name="input.b.page2.xrek033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek033
            
            #add-point:AFTER FIELD xrek033 name="input.a.page2.xrek033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek033
            #add-point:ON CHANGE xrek033 name="input.g.page2.xrek033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek019
            #add-point:BEFORE FIELD xrek019 name="input.b.page2.xrek019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek019
            
            #add-point:AFTER FIELD xrek019 name="input.a.page2.xrek019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek019
            #add-point:ON CHANGE xrek019 name="input.g.page2.xrek019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek019_desc
            #add-point:BEFORE FIELD l_xrek019_desc name="input.b.page2.l_xrek019_desc"
            LET g_xrek2_d[l_ac].l_xrek019_desc = g_xrek2_d[l_ac].xrek019   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek019_desc
            
            #add-point:AFTER FIELD l_xrek019_desc name="input.a.page2.l_xrek019_desc"
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek019_desc) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_xrej_m.xrejld,g_xrek2_d[l_ac].l_xrek019_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_xrej_m.xrejld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_xrek2_d[l_ac].l_xrek019_desc
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_xrek2_d[l_ac].l_xrek019_desc
                LET g_qryparam.arg3 = g_xrej_m.xrejld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_xrek2_d[l_ac].xrek019      = g_qryparam.return1
                LET g_xrek2_d[l_ac].l_xrek019_desc = g_xrek2_d[l_ac].xrek019
                DISPLAY BY NAME g_xrek2_d[l_ac].xrek019,g_xrek2_d[l_ac].l_xrek019_desc
               
                
              END IF
              IF NOT s_aglt310_lc_subject(g_xrej_m.xrejld,g_xrek2_d[l_ac].l_xrek019_desc,'N') THEN
                   LET g_xrek2_d[l_ac].xrek019      = g_xrek2_d_t.xrek019
                   LET g_xrek2_d[l_ac].l_xrek019_desc = g_xrek2_d_t.l_xrek019_desc
                   DISPLAY BY NAME g_xrek2_d[l_ac].xrek019,g_xrek2_d[l_ac].l_xrek019_desc
                   NEXT FIELD CURRENT
              END IF
 #  150916-00015#1 END
               IF g_xrek2_d[l_ac].l_xrek019_desc != g_xrek2_d_t.l_xrek019_desc OR g_xrek2_d_t.l_xrek019_desc IS NULL THEN
                  LET g_xrek2_d[l_ac].xrek019 = g_xrek2_d[l_ac].l_xrek019_desc
                  IF g_xrek2_d[l_ac].xrek019 != g_xrek2_d_t.xrek019 OR g_xrek2_d_t.xrek019 IS NULL THEN  #albireo 150116
                     CALL s_aap_glac002_chk(g_xrek2_d[l_ac].xrek019,g_xrej_m.xrejld) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#22 --s add
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                        #160321-00016#22 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xrek2_d[l_ac].xrek019      = g_xrek2_d_t.xrek019
                        LET g_xrek2_d[l_ac].l_xrek019_desc = g_xrek2_d_t.l_xrek019_desc
                        DISPLAY BY NAME g_xrek2_d[l_ac].xrek019,g_xrek2_d[l_ac].l_xrek019_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE 
               LET g_xrek2_d[l_ac].xrek019 = ''  #albireo 150116
            END IF
            LET g_xrek2_d[l_ac].l_xrek019_desc = s_desc_show1(g_xrek2_d[l_ac].xrek019,s_desc_get_account_desc(g_xrej_m.xrejld,g_xrek2_d[l_ac].xrek019))
            LET g_xrek2_d_t.l_xrek019_desc = g_xrek2_d[l_ac].l_xrek019_desc
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek019 ,g_xrek2_d[l_ac].l_xrek019_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek019_desc
            #add-point:ON CHANGE l_xrek019_desc name="input.g.page2.l_xrek019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek041
            #add-point:BEFORE FIELD xrek041 name="input.b.page2.xrek041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek041
            
            #add-point:AFTER FIELD xrek041 name="input.a.page2.xrek041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek041
            #add-point:ON CHANGE xrek041 name="input.g.page2.xrek041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek041_desc
            #add-point:BEFORE FIELD l_xrek041_desc name="input.b.page2.l_xrek041_desc"
            LET g_xrek2_d[l_ac].l_xrek041_desc = g_xrek2_d[l_ac].xrek041   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek041_desc
            
            #add-point:AFTER FIELD l_xrek041_desc name="input.a.page2.l_xrek041_desc"
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek041_desc) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_xrej_m.xrejld,g_xrek2_d[l_ac].l_xrek041_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_xrej_m.xrejld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_xrek2_d[l_ac].l_xrek041_desc
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_xrek2_d[l_ac].l_xrek041_desc
                LET g_qryparam.arg3 = g_xrej_m.xrejld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_xrek2_d[l_ac].xrek041      = g_qryparam.return1
                LET g_xrek2_d[l_ac].l_xrek041_desc = g_xrek2_d[l_ac].xrek041
                DISPLAY BY NAME g_xrek2_d[l_ac].xrek041,g_xrek2_d[l_ac].l_xrek041_desc
           
              END IF
              IF NOT s_aglt310_lc_subject(g_xrej_m.xrejld,g_xrek2_d[l_ac].l_xrek041_desc,'N') THEN
                   LET g_xrek2_d[l_ac].xrek041     = g_xrek2_d_t.xrek041
                   LET g_xrek2_d[l_ac].l_xrek041_desc = g_xrek2_d_t.l_xrek041_desc
                   DISPLAY BY NAME g_xrek2_d[l_ac].xrek041,g_xrek2_d[l_ac].l_xrek041_desc
                   NEXT FIELD CURRENT
              END IF
 #  150916-00015#1 END
               IF g_xrek2_d[l_ac].l_xrek041_desc != g_xrek2_d_t.l_xrek041_desc OR g_xrek2_d_t.l_xrek041_desc IS NULL THEN
                  LET g_xrek2_d[l_ac].xrek041 = g_xrek2_d[l_ac].l_xrek041_desc
                  IF g_xrek2_d[l_ac].xrek041 != g_xrek2_d_t.xrek041 OR g_xrek2_d_t.xrek041 IS NULL THEN  #albireo 150116
                     CALL s_aap_glac002_chk(g_xrek2_d[l_ac].xrek041,g_xrej_m.xrejld) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#22 --s add
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                        #160321-00016#22 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xrek2_d[l_ac].xrek041      = g_xrek2_d_t.xrek041
                        LET g_xrek2_d[l_ac].l_xrek041_desc = g_xrek2_d_t.l_xrek041_desc
                        DISPLAY BY NAME g_xrek2_d[l_ac].xrek041,g_xrek2_d[l_ac].l_xrek041_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE 
               LET g_xrek2_d[l_ac].xrek041 = ''  #albireo 150116
            END IF
            LET g_xrek2_d[l_ac].l_xrek041_desc = s_desc_show1(g_xrek2_d[l_ac].xrek041,s_desc_get_account_desc(g_xrej_m.xrejld,g_xrek2_d[l_ac].xrek041))
            LET g_xrek2_d_t.l_xrek041_desc = g_xrek2_d[l_ac].l_xrek041_desc
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek041 ,g_xrek2_d[l_ac].l_xrek041_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek041_desc
            #add-point:ON CHANGE l_xrek041_desc name="input.g.page2.l_xrek041_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrekorga
            #add-point:BEFORE FIELD xrekorga name="input.b.page2.xrekorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrekorga
            
            #add-point:AFTER FIELD xrekorga name="input.a.page2.xrekorga"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrekorga
            #add-point:ON CHANGE xrekorga name="input.g.page2.xrekorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrekorga_desc
            #add-point:BEFORE FIELD l_xrekorga_desc name="input.b.page2.l_xrekorga_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrekorga_desc
            
            #add-point:AFTER FIELD l_xrekorga_desc name="input.a.page2.l_xrekorga_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrekorga_desc
            #add-point:ON CHANGE l_xrekorga_desc name="input.g.page2.l_xrekorga_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek009
            #add-point:BEFORE FIELD xrek009 name="input.b.page2.xrek009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek009
            
            #add-point:AFTER FIELD xrek009 name="input.a.page2.xrek009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek009
            #add-point:ON CHANGE xrek009 name="input.g.page2.xrek009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek009_desc
            #add-point:BEFORE FIELD l_xrek009_desc name="input.b.page2.l_xrek009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek009_desc
            
            #add-point:AFTER FIELD l_xrek009_desc name="input.a.page2.l_xrek009_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek009_desc
            #add-point:ON CHANGE l_xrek009_desc name="input.g.page2.l_xrek009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek016
            #add-point:BEFORE FIELD xrek016 name="input.b.page2.xrek016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek016
            
            #add-point:AFTER FIELD xrek016 name="input.a.page2.xrek016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek016
            #add-point:ON CHANGE xrek016 name="input.g.page2.xrek016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek016_desc
            #add-point:BEFORE FIELD l_xrek016_desc name="input.b.page2.l_xrek016_desc"
            LET g_xrek2_d[l_ac].l_xrek016_desc = g_xrek2_d[l_ac].xrek016   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek016_desc
            
            #add-point:AFTER FIELD l_xrek016_desc name="input.a.page2.l_xrek016_desc"
            #業務人員
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek016_desc) THEN
               IF ( g_xrek2_d[l_ac].l_xrek016_desc != g_xrek2_d_t.l_xrek016_desc OR g_xrek2_d_t.l_xrek016_desc IS NULL ) THEN
                  LET g_xrek2_d[l_ac].xrek016 = g_xrek2_d[l_ac].l_xrek016_desc
                  IF ( g_xrek2_d[l_ac].xrek016 != g_xrek2_d_t.xrek016 OR g_xrek2_d_t.xrek016 IS NULL ) THEN   #albireo 150116
                     IF l_glaa121 = 'N' THEN     #141218-00011#6
                        CALL s_employee_chk(g_xrek2_d[l_ac].xrek016) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_xrek2_d[l_ac].xrek016        = g_xrek2_d_t.xrek016
                           LET g_xrek2_d[l_ac].l_xrek016_desc = g_xrek2_d_t.l_xrek016_desc
                           DISPLAY BY NAME g_xrek2_d[l_ac].xrek016,g_xrek2_d[l_ac].l_xrek016_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek016 = ''   #albireo 150116
            END IF
            LET g_xrek2_d[l_ac].l_xrek016_desc = s_desc_show1(g_xrek2_d[l_ac].xrek016,s_desc_get_person_desc(g_xrek2_d[l_ac].xrek016))
            LET g_xrek2_d[l_ac].l_xrek016_desc = g_xrek2_d[l_ac].l_xrek016_desc
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek016,g_xrek2_d[l_ac].l_xrek016_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek016_desc
            #add-point:ON CHANGE l_xrek016_desc name="input.g.page2.l_xrek016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek011
            #add-point:BEFORE FIELD xrek011 name="input.b.page2.xrek011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek011
            
            #add-point:AFTER FIELD xrek011 name="input.a.page2.xrek011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek011
            #add-point:ON CHANGE xrek011 name="input.g.page2.xrek011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek011_desc
            #add-point:BEFORE FIELD l_xrek011_desc name="input.b.page2.l_xrek011_desc"
            LET g_xrek2_d[l_ac].l_xrek011_desc = g_xrek2_d[l_ac].xrek011   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek011_desc
            
            #add-point:AFTER FIELD l_xrek011_desc name="input.a.page2.l_xrek011_desc"
            #部門
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek011_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek011_desc != g_xrek2_d_t.l_xrek011_desc OR g_xrek2_d_t.l_xrek011_desc IS NULL) THEN
                  LET g_xrek2_d[l_ac].xrek011 = g_xrek2_d[l_ac].l_xrek011_desc
                  IF (g_xrek2_d[l_ac].xrek011 != g_xrek2_d_t.xrek011 OR g_xrek2_d_t.xrek011 IS NULL) THEN   #albireo 150116
                     IF l_glaa121 = 'N' THEN     #141218-00011#6
                        CALL s_department_chk(g_xrek2_d[l_ac].xrek011,g_xrej_m.xrejdocdt) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_xrek2_d[l_ac].xrek011      = g_xrek2_d_t.xrek011
                           LET g_xrek2_d[l_ac].l_xrek011_desc = g_xrek2_d_t.l_xrek011_desc
                           DISPLAY BY NAME g_xrek2_d[l_ac].xrek011,g_xrek2_d[l_ac].l_xrek011_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek011 = ''  #albireo 150116
            END IF
            LET g_xrek2_d[l_ac].l_xrek011_desc = s_desc_show1(g_xrek2_d[l_ac].xrek011,
                                                              s_desc_get_department_desc(g_xrek2_d[l_ac].xrek011))
            LET g_xrek2_d_t.l_xrek011_desc = g_xrek2_d[l_ac].l_xrek011_desc
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek011,g_xrek2_d[l_ac].l_xrek011_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek011_desc
            #add-point:ON CHANGE l_xrek011_desc name="input.g.page2.l_xrek011_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek012
            #add-point:BEFORE FIELD xrek012 name="input.b.page2.xrek012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek012
            
            #add-point:AFTER FIELD xrek012 name="input.a.page2.xrek012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek012
            #add-point:ON CHANGE xrek012 name="input.g.page2.xrek012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek012_desc
            #add-point:BEFORE FIELD l_xrek012_desc name="input.b.page2.l_xrek012_desc"
            LET g_xrek2_d[l_ac].l_xrek012_desc = g_xrek2_d[l_ac].xrek012   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek012_desc
            
            #add-point:AFTER FIELD l_xrek012_desc name="input.a.page2.l_xrek012_desc"
            #責任中心
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek012_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek012_desc != g_xrek2_d_t.l_xrek012_desc OR g_xrek2_d_t.l_xrek012_desc IS NULL) THEN
                  LET g_xrek2_d[l_ac].xrek012 = g_xrek2_d[l_ac].l_xrek012_desc
                  IF (g_xrek2_d[l_ac].xrek012 != g_xrek2_d_t.xrek012 OR g_xrek2_d_t.xrek012 IS NULL) THEN   #albireo 150116
                     IF l_glaa121 = 'N' THEN     #141218-00011#6
                        #CALL s_department_chk(g_xrek2_d[l_ac].xrek012,g_xrej_m.xrejdocdt) RETURNING g_sub_success #albireo 150302 MARK
                        CALL s_voucher_glaq019_chk(g_xrek2_d[l_ac].xrek012,g_xrej_m.xrejdocdt)   #albireo 150302 add
                        IF NOT g_sub_success THEN
                           LET g_xrek2_d[l_ac].xrek012      = g_xrek2_d_t.xrek012
                           LET g_xrek2_d[l_ac].l_xrek012_desc = g_xrek2_d_t.l_xrek012_desc
                           DISPLAY BY NAME g_xrek2_d[l_ac].xrek012,g_xrek2_d[l_ac].l_xrek012_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek012 = ''   #albireo 150116
            END IF
            LET g_xrek2_d[l_ac].l_xrek012_desc = s_desc_show1(g_xrek2_d[l_ac].xrek012,
                                                              s_desc_get_department_desc(g_xrek2_d[l_ac].xrek012))
            LET g_xrek2_d_t.l_xrek012_desc = g_xrek2_d[l_ac].l_xrek012_desc
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek012,g_xrek2_d[l_ac].l_xrek012_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek012_desc
            #add-point:ON CHANGE l_xrek012_desc name="input.g.page2.l_xrek012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek013
            #add-point:BEFORE FIELD xrek013 name="input.b.page2.xrek013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek013
            
            #add-point:AFTER FIELD xrek013 name="input.a.page2.xrek013"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek013
            #add-point:ON CHANGE xrek013 name="input.g.page2.xrek013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek013_desc
            #add-point:BEFORE FIELD l_xrek013_desc name="input.b.page2.l_xrek013_desc"
            LET g_xrek2_d[l_ac].l_xrek013_desc = g_xrek2_d[l_ac].xrek013   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek013_desc
            
            #add-point:AFTER FIELD l_xrek013_desc name="input.a.page2.l_xrek013_desc"
            #區域
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek013_desc) THEN
               IF ( g_xrek2_d[l_ac].l_xrek013_desc != g_xrek2_d_t.l_xrek013_desc OR g_xrek2_d_t.l_xrek013_desc IS NULL ) THEN
                  LET g_xrek2_d[l_ac].xrek013 = g_xrek2_d[l_ac].l_xrek013_desc
                  IF ( g_xrek2_d[l_ac].xrek013 != g_xrek2_d_t.xrek013 OR g_xrek2_d_t.xrek013 IS NULL ) THEN   #albireo 150116
                     IF l_glaa121 = 'N' THEN     #141218-00011#6
                        IF NOT s_azzi650_chk_exist('287',g_xrek2_d[l_ac].xrek013) THEN
                           LET g_xrek2_d[l_ac].xrek013      = g_xrek2_d_t.xrek013
                           LET g_xrek2_d[l_ac].l_xrek013_desc = g_xrek2_d_t.l_xrek013_desc
                           DISPLAY BY NAME g_xrek2_d[l_ac].xrek013 ,g_xrek2_d[l_ac].l_xrek013_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek013 = ''   #albireo 150116
            END IF
            LET g_xrek2_d[l_ac].l_xrek013_desc = s_desc_show1(g_xrek2_d[l_ac].xrek013,
                                                 s_desc_get_acc_desc('287',g_xrek2_d[l_ac].xrek013))
            LET g_xrek2_d_t.l_xrek013_desc = g_xrek2_d[l_ac].l_xrek013_desc
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek013 ,g_xrek2_d[l_ac].l_xrek013_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek013_desc
            #add-point:ON CHANGE l_xrek013_desc name="input.g.page2.l_xrek013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek014
            #add-point:BEFORE FIELD xrek014 name="input.b.page2.xrek014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek014
            
            #add-point:AFTER FIELD xrek014 name="input.a.page2.xrek014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek014
            #add-point:ON CHANGE xrek014 name="input.g.page2.xrek014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek014_desc
            #add-point:BEFORE FIELD l_xrek014_desc name="input.b.page2.l_xrek014_desc"
            LET g_xrek2_d[l_ac].l_xrek014_desc = g_xrek2_d[l_ac].xrek014   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek014_desc
            
            #add-point:AFTER FIELD l_xrek014_desc name="input.a.page2.l_xrek014_desc"
            #客群
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek014_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek014_desc != g_xrek2_d_t.l_xrek014_desc OR g_xrek2_d_t.l_xrek014_desc IS NULL ) THEN
                  LET g_xrek2_d[l_ac].l_xrek014_desc = g_xrek2_d[l_ac].l_xrek014_desc
                  IF (g_xrek2_d[l_ac].xrek014 != g_xrek2_d_t.xrek014 OR g_xrek2_d_t.xrek014 IS NULL ) THEN   #albireo 150116
                     IF l_glaa121 = 'N' THEN     #141218-00011#6
                        IF NOT s_azzi650_chk_exist('281',g_xrek2_d[l_ac].xrek014) THEN
                           LET g_xrek2_d[l_ac].xrek014        = g_xrek2_d_t.xrek014
                           LET g_xrek2_d[l_ac].l_xrek014_desc = g_xrek2_d_t.l_xrek014_desc
                           DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek014_desc ,g_xrek2_d[l_ac].l_xrek014_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek014= ''   #albireo 150116
            END IF
            LET g_xrek2_d[l_ac].l_xrek014_desc = s_desc_show1(g_xrek2_d[l_ac].xrek014,
                                                 s_desc_get_acc_desc('281',g_xrek2_d[l_ac].xrek014))
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek014 ,g_xrek2_d[l_ac].l_xrek014_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek014_desc
            #add-point:ON CHANGE l_xrek014_desc name="input.g.page2.l_xrek014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek015
            #add-point:BEFORE FIELD xrek015 name="input.b.page2.xrek015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek015
            
            #add-point:AFTER FIELD xrek015 name="input.a.page2.xrek015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek015
            #add-point:ON CHANGE xrek015 name="input.g.page2.xrek015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek015_desc
            #add-point:BEFORE FIELD l_xrek015_desc name="input.b.page2.l_xrek015_desc"
            LET g_xrek2_d[l_ac].l_xrek015_desc = g_xrek2_d[l_ac].xrek015   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek015_desc
            
            #add-point:AFTER FIELD l_xrek015_desc name="input.a.page2.l_xrek015_desc"
            #產品類別
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek015_desc) THEN
               IF ( g_xrek2_d[l_ac].l_xrek015_desc != g_xrek2_d_t.l_xrek015_desc OR g_xrek2_d_t.l_xrek015_desc IS NULL ) THEN
                  LET g_xrek2_d[l_ac].xrek015 = g_xrek2_d[l_ac].l_xrek015_desc
                  IF ( g_xrek2_d[l_ac].xrek015 != g_xrek2_d_t.xrek015 OR g_xrek2_d_t.xrek015 IS NULL ) THEN   #albireo 150116
                     IF l_glaa121 = 'N' THEN     #141218-00011#6
                        CALL s_voucher_glaq024_chk(g_xrek2_d[l_ac].xrek015)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#22 --s add
                           LET g_errparam.replace[1] = 'arti202'
                           LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                           LET g_errparam.exeprog = 'arti202'
                           #160321-00016#22 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_xrek2_d[l_ac].xrek015        = g_xrek2_d_t.xrek015
                           LET g_xrek2_d[l_ac].l_xrek015_desc = g_xrek2_d_t.l_xrek015_desc
                           DISPLAY BY NAME g_xrek2_d[l_ac].xrek015 ,g_xrek2_d[l_ac].l_xrek015_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE 
               LET g_xrek2_d[l_ac].xrek015 = ''   #albireo 150116
            END IF
            LET g_xrek2_d[l_ac].l_xrek015_desc = s_desc_show1(g_xrek2_d[l_ac].xrek015,
                                                              s_desc_get_rtaxl003_desc(g_xrek2_d[l_ac].xrek015))
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek015 ,g_xrek2_d[l_ac].l_xrek015_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek015_desc
            #add-point:ON CHANGE l_xrek015_desc name="input.g.page2.l_xrek015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek017
            #add-point:BEFORE FIELD xrek017 name="input.b.page2.xrek017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek017
            
            #add-point:AFTER FIELD xrek017 name="input.a.page2.xrek017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek017
            #add-point:ON CHANGE xrek017 name="input.g.page2.xrek017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek017_desc
            #add-point:BEFORE FIELD l_xrek017_desc name="input.b.page2.l_xrek017_desc"
            LET g_xrek2_d[l_ac].l_xrek017_desc = g_xrek2_d[l_ac].xrek017   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek017_desc
            
            #add-point:AFTER FIELD l_xrek017_desc name="input.a.page2.l_xrek017_desc"
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek017_desc) THEN
               IF ( g_xrek2_d[l_ac].l_xrek017_desc != g_xrek2_d_t.l_xrek017_desc OR g_xrek2_d_t.l_xrek017_desc IS NULL ) THEN
                  LET g_xrek2_d[l_ac].xrek017 = g_xrek2_d[l_ac].l_xrek017_desc
                  
                  IF ( g_xrek2_d[l_ac].xrek017 != g_xrek2_d_t.xrek017 OR g_xrek2_d_t.xrek017 IS NULL ) THEN  #albireo 150116
                     IF l_glaa121 = 'N' THEN     #141218-00011#6
                        CALL s_aap_project_chk( g_xrek2_d[l_ac].xrek017) RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           #160321-00016#22 --s add
                           LET g_errparam.replace[1] = 'apjm200'
                           LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                           LET g_errparam.exeprog = 'apjm200'
                           #160321-00016#22 --e add
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_xrek2_d[l_ac].xrek017        = g_xrek2_d_t.xrek017
                           LET g_xrek2_d[l_ac].l_xrek017_desc = g_xrek2_d_t.l_xrek017_desc
                           DISPLAY BY NAME g_xrek2_d[l_ac].xrek017,g_xrek2_d[l_ac].l_xrek017_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE 
               LET g_xrek2_d[l_ac].xrek017 = ''    #albireo 150116
            END IF
            LET g_xrek2_d[l_ac].l_xrek017_desc = s_desc_show1(g_xrek2_d[l_ac].xrek017,s_desc_get_project_desc(g_xrek2_d[l_ac].xrek017))
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek017,g_xrek2_d[l_ac].l_xrek017_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek017_desc
            #add-point:ON CHANGE l_xrek017_desc name="input.g.page2.l_xrek017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek018
            #add-point:BEFORE FIELD xrek018 name="input.b.page2.xrek018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek018
            
            #add-point:AFTER FIELD xrek018 name="input.a.page2.xrek018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek018
            #add-point:ON CHANGE xrek018 name="input.g.page2.xrek018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek018_desc
            #add-point:BEFORE FIELD l_xrek018_desc name="input.b.page2.l_xrek018_desc"
            LET g_xrek2_d[l_ac].l_xrek018_desc = g_xrek2_d[l_ac].xrek018   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek018_desc
            
            #add-point:AFTER FIELD l_xrek018_desc name="input.a.page2.l_xrek018_desc"
            #WBS
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek018_desc) THEN
               IF ( g_xrek2_d[l_ac].l_xrek018_desc != g_xrek2_d_t.l_xrek018_desc OR g_xrek2_d_t.l_xrek018_desc IS NULL ) THEN
                  LET g_xrek2_d[l_ac].xrek018 = g_xrek2_d[l_ac].l_xrek018_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                    #CALL s_aap_project_chk( g_xrek2_d[l_ac].xrek018) RETURNING g_sub_success,g_errno
                    
                     #albireo 150302-----s
                     LET g_errno = NULL
                     CALL s_voucher_glaq028_chk(g_xrek2_d[l_ac].xrek017,g_xrek2_d[l_ac].xrek018)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xrek2_d[l_ac].xrek018        = g_xrek2_d_t.xrek018
                        LET g_xrek2_d[l_ac].l_xrek018_desc = g_xrek2_d_t.l_xrek018_desc
                        DISPLAY BY NAME g_xrek2_d[l_ac].xrek018,g_xrek2_d[l_ac].l_xrek018_desc
                        NEXT FIELD CURRENT
                     END IF
                     #albireo 150302-----e
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek018 = ''   #albireo 150116
            END IF
            LET g_xrek2_d[l_ac].l_xrek018_desc = s_desc_show1(g_xrek2_d[l_ac].xrek018,s_desc_get_pjbbl004_desc(g_xrek2_d[l_ac].xrek017,g_xrek2_d[l_ac].xrek018))
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek018,g_xrek2_d[l_ac].l_xrek018_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek018_desc
            #add-point:ON CHANGE l_xrek018_desc name="input.g.page2.l_xrek018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek020
            #add-point:BEFORE FIELD xrek020 name="input.b.page2.xrek020"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek020
            
            #add-point:AFTER FIELD xrek020 name="input.a.page2.xrek020"
            #經營方式
            IF NOT cl_null(g_xrek2_d[l_ac].xrek020) THEN
               IF ( g_xrek2_d[l_ac].xrek020 != g_xrek2_d_t.xrek020 OR g_xrek2_d_t.xrek020 IS NULL ) THEN
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     CALL s_voucher_glaq051_chk(g_xrek2_d[l_ac].xrek020)
                     IF NOT cl_null(g_errno) THEN
                        LET g_xrek2_d[l_ac].xrek021    = g_xrek2_d_t.xrek021
                        DISPLAY BY NAME g_xrek2_d[l_ac].xrek020
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek020
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek020
            #add-point:ON CHANGE xrek020 name="input.g.page2.xrek020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek021
            
            #add-point:AFTER FIELD xrek021 name="input.a.page2.xrek021"
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek021
            #add-point:BEFORE FIELD xrek021 name="input.b.page2.xrek021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek021
            #add-point:ON CHANGE xrek021 name="input.g.page2.xrek021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek021_desc
            #add-point:BEFORE FIELD l_xrek021_desc name="input.b.page2.l_xrek021_desc"
            LET g_xrek2_d[l_ac].l_xrek021_desc = g_xrek2_d[l_ac].xrek021   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek021_desc
            
            #add-point:AFTER FIELD l_xrek021_desc name="input.a.page2.l_xrek021_desc"
            #渠道
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek021_desc) THEN
               IF ( g_xrek2_d[l_ac].l_xrek021_desc != g_xrek2_d_t.l_xrek021_desc OR g_xrek2_d_t.l_xrek021_desc IS NULL ) THEN
                  LET g_xrek2_d[l_ac].xrek021 = g_xrek2_d[l_ac].l_xrek021_desc
                  IF ( g_xrek2_d[l_ac].xrek021 != g_xrek2_d_t.xrek021 OR g_xrek2_d_t.xrek021 IS NULL ) THEN    #albireo 150116
                     IF l_glaa121 = 'N' THEN     #141218-00011#6
                        CALL s_voucher_glaq052_chk(g_xrek2_d[l_ac].l_xrek021_desc)
                        IF NOT cl_null(g_errno) THEN
                           LET g_xrek2_d[l_ac].xrek021      = g_xrek2_d_t.xrek021
                           LET g_xrek2_d[l_ac].l_xrek021_desc = g_xrek2_d_t.l_xrek021_desc
                           DISPLAY BY NAME g_xrek2_d[l_ac].xrek021,g_xrek2_d[l_ac].l_xrek021_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek021 = ''
            END IF
            LET g_xrek2_d[l_ac].l_xrek021_desc = s_desc_show1(g_xrek2_d[l_ac].xrek021,s_desc_get_oojdl003_desc(g_xrek2_d[l_ac].xrek021))
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek021,g_xrek2_d[l_ac].l_xrek021_desc
            LET g_xrek2_d_t.l_xrek021_desc = g_xrek2_d[l_ac].l_xrek021_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek021_desc
            #add-point:ON CHANGE l_xrek021_desc name="input.g.page2.l_xrek021_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek022
            
            #add-point:AFTER FIELD xrek022 name="input.a.page2.xrek022"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek022
            #add-point:BEFORE FIELD xrek022 name="input.b.page2.xrek022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek022
            #add-point:ON CHANGE xrek022 name="input.g.page2.xrek022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek022_desc
            #add-point:BEFORE FIELD l_xrek022_desc name="input.b.page2.l_xrek022_desc"
            LET g_xrek2_d[l_ac].l_xrek022_desc = g_xrek2_d[l_ac].xrek022   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek022_desc
            
            #add-point:AFTER FIELD l_xrek022_desc name="input.a.page2.l_xrek022_desc"
            #品牌
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek022_desc) THEN
               IF ( g_xrek2_d[l_ac].l_xrek022_desc != g_xrek2_d_t.l_xrek022_desc OR g_xrek2_d_t.l_xrek022_desc IS NULL ) THEN
                  LET g_xrek2_d[l_ac].xrek022 = g_xrek2_d[l_ac].l_xrek022_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF ( g_xrek2_d[l_ac].xrek022 != g_xrek2_d_t.xrek022 OR g_xrek2_d_t.xrek022 IS NULL ) THEN   #albireo 150116
                        IF NOT s_azzi650_chk_exist('2002',g_xrek2_d[l_ac].xrek022) THEN
                           LET g_xrek2_d[l_ac].xrek022        = g_xrek2_d_t.xrek022
                           LET g_xrek2_d[l_ac].l_xrek022_desc = g_xrek2_d_t.l_xrek022_desc
                           DISPLAY BY NAME g_xrek2_d[l_ac].xrek022,g_xrek2_d[l_ac].l_xrek022_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek022 = ''
            END IF
            LET g_xrek2_d[l_ac].l_xrek022_desc = s_desc_show1(g_xrek2_d[l_ac].xrek022,s_desc_get_acc_desc(2002,g_xrek2_d[l_ac].xrek022))
            DISPLAY BY NAME  g_xrek2_d[l_ac].xrek022, g_xrek2_d[l_ac].l_xrek022_desc
            LET g_xrek2_d_t.l_xrek022_desc = g_xrek2_d[l_ac].l_xrek022_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek022_desc
            #add-point:ON CHANGE l_xrek022_desc name="input.g.page2.l_xrek022_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek023
            
            #add-point:AFTER FIELD xrek023 name="input.a.page2.xrek023"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek023
            #add-point:BEFORE FIELD xrek023 name="input.b.page2.xrek023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek023
            #add-point:ON CHANGE xrek023 name="input.g.page2.xrek023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek023_desc
            #add-point:BEFORE FIELD l_xrek023_desc name="input.b.page2.l_xrek023_desc"
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_xrek2_d[l_ac].l_xrek023_desc = g_xrek2_d[l_ac].xrek023   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek023_desc
            
            #add-point:AFTER FIELD l_xrek023_desc name="input.a.page2.l_xrek023_desc"
            #自由核算項一
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek023_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek023_desc != g_xrek2_d_t.l_xrek023_desc OR g_xrek2_d_t.l_xrek023_desc IS NULL) THEN
                  LET g_xrek2_d[l_ac].xrek023 = g_xrek2_d[l_ac].l_xrek023_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xrek2_d[l_ac].xrek023 != g_xrek2_d_t.xrek023 OR g_xrek2_d_t.xrek023 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_xrek2_d[l_ac].xrek023,g_glad.glad0172) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#22 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#22 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_xrek2_d[l_ac].xrek023 =        g_xrek2_d_t.xrek023
                           LET g_xrek2_d[l_ac].l_xrek023_desc = s_desc_show1(g_xrek2_d[l_ac].xrek023,s_fin_get_accting_desc(g_glad.glad0171,g_xrek2_d[l_ac].xrek023))
                           DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek023_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek023 = ''
            END IF
            LET g_xrek2_d[l_ac].l_xrek023_desc = s_desc_show1(g_xrek2_d[l_ac].xrek023,s_fin_get_accting_desc(g_glad.glad0171,g_xrek2_d[l_ac].xrek023))
            DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek023_desc
            LET g_xrek2_d_t.l_xrek023_desc = g_xrek2_d[l_ac].l_xrek023_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek023_desc
            #add-point:ON CHANGE l_xrek023_desc name="input.g.page2.l_xrek023_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek024
            
            #add-point:AFTER FIELD xrek024 name="input.a.page2.xrek024"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek024
            #add-point:BEFORE FIELD xrek024 name="input.b.page2.xrek024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek024
            #add-point:ON CHANGE xrek024 name="input.g.page2.xrek024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek024_desc
            #add-point:BEFORE FIELD l_xrek024_desc name="input.b.page2.l_xrek024_desc"
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_xrek2_d[l_ac].l_xrek024_desc = g_xrek2_d[l_ac].xrek024   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek024_desc
            
            #add-point:AFTER FIELD l_xrek024_desc name="input.a.page2.l_xrek024_desc"
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek024_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek024_desc != g_xrek2_d_t.l_xrek024_desc OR g_xrek2_d_t.l_xrek024_desc IS NULL) THEN
                  LET g_xrek2_d[l_ac].xrek024 = g_xrek2_d[l_ac].l_xrek024_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xrek2_d[l_ac].xrek024 != g_xrek2_d_t.xrek024 OR g_xrek2_d_t.xrek024 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_xrek2_d[l_ac].xrek024,g_glad.glad0182) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#22 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#22 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_xrek2_d[l_ac].xrek024 = g_xrek2_d_t.xrek024
                           LET g_xrek2_d[l_ac].l_xrek024_desc = s_desc_show1(g_xrek2_d[l_ac].xrek024,s_fin_get_accting_desc(g_glad.glad0181,g_xrek2_d[l_ac].xrek024))
                           DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek024_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek024 = ''
            END IF
            LET g_xrek2_d[l_ac].l_xrek024_desc = s_desc_show1(g_xrek2_d[l_ac].xrek024,s_fin_get_accting_desc(g_glad.glad0181,g_xrek2_d[l_ac].xrek024))
            DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek024_desc
            LET g_xrek2_d_t.l_xrek024_desc = g_xrek2_d[l_ac].l_xrek024_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek024_desc
            #add-point:ON CHANGE l_xrek024_desc name="input.g.page2.l_xrek024_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek025
            
            #add-point:AFTER FIELD xrek025 name="input.a.page2.xrek025"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek025
            #add-point:BEFORE FIELD xrek025 name="input.b.page2.xrek025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek025
            #add-point:ON CHANGE xrek025 name="input.g.page2.xrek025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek025_desc
            #add-point:BEFORE FIELD l_xrek025_desc name="input.b.page2.l_xrek025_desc"
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_xrek2_d[l_ac].l_xrek025_desc = g_xrek2_d[l_ac].xrek025   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek025_desc
            
            #add-point:AFTER FIELD l_xrek025_desc name="input.a.page2.l_xrek025_desc"
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek025_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek025_desc != g_xrek2_d_t.l_xrek025_desc OR g_xrek2_d_t.l_xrek025_desc IS NULL) THEN
                  LET g_xrek2_d[l_ac].xrek025 = g_xrek2_d[l_ac].l_xrek025_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xrek2_d[l_ac].xrek025 != g_xrek2_d_t.xrek025 OR g_xrek2_d_t.xrek025 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_xrek2_d[l_ac].xrek025,g_glad.glad0192) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#22 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#22 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_xrek2_d[l_ac].xrek025 = g_xrek2_d_t.xrek025
                           LET g_xrek2_d[l_ac].l_xrek025_desc = s_desc_show1(g_xrek2_d[l_ac].xrek025,s_fin_get_accting_desc(g_glad.glad0191,g_xrek2_d[l_ac].xrek025))
                           DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek025_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek025 = ''
            END IF
            LET g_xrek2_d[l_ac].l_xrek025_desc = s_desc_show1(g_xrek2_d[l_ac].xrek025,s_fin_get_accting_desc(g_glad.glad0191,g_xrek2_d[l_ac].xrek025))
            DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek025_desc
            LET g_xrek2_d_t.l_xrek025_desc = g_xrek2_d[l_ac].l_xrek025_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek025_desc
            #add-point:ON CHANGE l_xrek025_desc name="input.g.page2.l_xrek025_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek026
            
            #add-point:AFTER FIELD xrek026 name="input.a.page2.xrek026"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek026
            #add-point:BEFORE FIELD xrek026 name="input.b.page2.xrek026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek026
            #add-point:ON CHANGE xrek026 name="input.g.page2.xrek026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek026_desc
            #add-point:BEFORE FIELD l_xrek026_desc name="input.b.page2.l_xrek026_desc"
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_xrek2_d[l_ac].l_xrek026_desc = g_xrek2_d[l_ac].xrek026   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek026_desc
            
            #add-point:AFTER FIELD l_xrek026_desc name="input.a.page2.l_xrek026_desc"
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek026_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek026_desc != g_xrek2_d_t.l_xrek026_desc OR g_xrek2_d_t.l_xrek026_desc IS NULL) THEN
                  LET g_xrek2_d[l_ac].xrek026 = g_xrek2_d[l_ac].l_xrek026_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xrek2_d[l_ac].xrek026 != g_xrek2_d_t.xrek026 OR g_xrek2_d_t.xrek026 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_xrek2_d[l_ac].xrek026,g_glad.glad0202) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#22 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#22 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_xrek2_d[l_ac].xrek026 = g_xrek2_d_t.xrek026
                           LET g_xrek2_d[l_ac].l_xrek026_desc = s_desc_show1(g_xrek2_d[l_ac].xrek026,s_fin_get_accting_desc(g_glad.glad0201,g_xrek2_d[l_ac].xrek026))
                           DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek026_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek026 = '' 
            END IF
            LET g_xrek2_d[l_ac].l_xrek026_desc = s_desc_show1(g_xrek2_d[l_ac].xrek026,s_fin_get_accting_desc(g_glad.glad0201,g_xrek2_d[l_ac].xrek026))
            DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek026_desc
            LET g_xrek2_d_t.l_xrek026_desc = g_xrek2_d[l_ac].l_xrek026_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek026_desc
            #add-point:ON CHANGE l_xrek026_desc name="input.g.page2.l_xrek026_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek027
            
            #add-point:AFTER FIELD xrek027 name="input.a.page2.xrek027"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek027
            #add-point:BEFORE FIELD xrek027 name="input.b.page2.xrek027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek027
            #add-point:ON CHANGE xrek027 name="input.g.page2.xrek027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek027_desc
            #add-point:BEFORE FIELD l_xrek027_desc name="input.b.page2.l_xrek027_desc"
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_xrek2_d[l_ac].l_xrek027_desc = g_xrek2_d[l_ac].xrek027   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek027_desc
            
            #add-point:AFTER FIELD l_xrek027_desc name="input.a.page2.l_xrek027_desc"
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek027_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek027_desc != g_xrek2_d_t.l_xrek027_desc OR g_xrek2_d_t.l_xrek027_desc IS NULL) THEN
                  LET g_xrek2_d[l_ac].xrek027 = g_xrek2_d[l_ac].l_xrek027_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xrek2_d[l_ac].xrek027 != g_xrek2_d_t.xrek027 OR g_xrek2_d_t.xrek027 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_xrek2_d[l_ac].xrek027,g_glad.glad0212) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#22 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#22 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_xrek2_d[l_ac].xrek027 = g_xrek2_d_t.xrek027
                           LET g_xrek2_d[l_ac].l_xrek027_desc = s_desc_show1(g_xrek2_d[l_ac].xrek027,s_fin_get_accting_desc(g_glad.glad0211,g_xrek2_d[l_ac].xrek027))
                           DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek027_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek027 = ''
            END IF
            LET g_xrek2_d[l_ac].l_xrek027_desc = s_desc_show1(g_xrek2_d[l_ac].xrek027,s_fin_get_accting_desc(g_glad.glad0211,g_xrek2_d[l_ac].xrek027))
            DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek027_desc
            LET g_xrek2_d_t.l_xrek027_desc = g_xrek2_d[l_ac].l_xrek027_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek027_desc
            #add-point:ON CHANGE l_xrek027_desc name="input.g.page2.l_xrek027_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek028
            
            #add-point:AFTER FIELD xrek028 name="input.a.page2.xrek028"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek028
            #add-point:BEFORE FIELD xrek028 name="input.b.page2.xrek028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek028
            #add-point:ON CHANGE xrek028 name="input.g.page2.xrek028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek028_desc
            #add-point:BEFORE FIELD l_xrek028_desc name="input.b.page2.l_xrek028_desc"
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_xrek2_d[l_ac].l_xrek028_desc = g_xrek2_d[l_ac].xrek028   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek028_desc
            
            #add-point:AFTER FIELD l_xrek028_desc name="input.a.page2.l_xrek028_desc"
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek028_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek028_desc != g_xrek2_d_t.l_xrek028_desc OR g_xrek2_d_t.l_xrek028_desc IS NULL) THEN
                  LET g_xrek2_d[l_ac].xrek028 = g_xrek2_d[l_ac].l_xrek028_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xrek2_d[l_ac].xrek028 != g_xrek2_d_t.xrek028 OR g_xrek2_d_t.xrek028 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_xrek2_d[l_ac].xrek028,g_glad.glad0222) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#22 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#22 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_xrek2_d[l_ac].xrek028 = g_xrek2_d_t.xrek028
                           LET g_xrek2_d[l_ac].l_xrek028_desc = s_desc_show1(g_xrek2_d[l_ac].xrek028,s_fin_get_accting_desc(g_glad.glad0221,g_xrek2_d[l_ac].xrek028))
                           DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek028_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek028 = ''
            END IF
            LET g_xrek2_d[l_ac].l_xrek028_desc = s_desc_show1(g_xrek2_d[l_ac].xrek028,s_fin_get_accting_desc(g_glad.glad0221,g_xrek2_d[l_ac].xrek028))
            DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek028_desc
            LET g_xrek2_d_t.l_xrek028_desc = g_xrek2_d[l_ac].l_xrek028_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek028_desc
            #add-point:ON CHANGE l_xrek028_desc name="input.g.page2.l_xrek028_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek029
            
            #add-point:AFTER FIELD xrek029 name="input.a.page2.xrek029"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek029
            #add-point:BEFORE FIELD xrek029 name="input.b.page2.xrek029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek029
            #add-point:ON CHANGE xrek029 name="input.g.page2.xrek029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek029_desc
            #add-point:BEFORE FIELD l_xrek029_desc name="input.b.page2.l_xrek029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek029_desc
            
            #add-point:AFTER FIELD l_xrek029_desc name="input.a.page2.l_xrek029_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek029_desc
            #add-point:ON CHANGE l_xrek029_desc name="input.g.page2.l_xrek029_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek030
            
            #add-point:AFTER FIELD xrek030 name="input.a.page2.xrek030"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek030
            #add-point:BEFORE FIELD xrek030 name="input.b.page2.xrek030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek030
            #add-point:ON CHANGE xrek030 name="input.g.page2.xrek030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek030_desc
            #add-point:BEFORE FIELD l_xrek030_desc name="input.b.page2.l_xrek030_desc"
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_xrek2_d[l_ac].l_xrek030_desc = g_xrek2_d[l_ac].xrek030   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek030_desc
            
            #add-point:AFTER FIELD l_xrek030_desc name="input.a.page2.l_xrek030_desc"
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek030_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek030_desc != g_xrek2_d_t.l_xrek030_desc OR g_xrek2_d_t.l_xrek030_desc IS NULL) THEN
                  LET g_xrek2_d[l_ac].xrek030 = g_xrek2_d[l_ac].l_xrek030_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xrek2_d[l_ac].xrek030 != g_xrek2_d_t.xrek030 OR g_xrek2_d_t.xrek030 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_xrek2_d[l_ac].xrek030,g_glad.glad0242) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#22 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#22 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_xrek2_d[l_ac].xrek030 = g_xrek2_d_t.xrek030
                           LET g_xrek2_d[l_ac].l_xrek030_desc = s_desc_show1(g_xrek2_d[l_ac].xrek030,s_fin_get_accting_desc(g_glad.glad0241,g_xrek2_d[l_ac].xrek030))
                           DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek030_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek030 = ''
            END IF
            LET g_xrek2_d[l_ac].l_xrek030_desc = s_desc_show1(g_xrek2_d[l_ac].xrek030,s_fin_get_accting_desc(g_glad.glad0241,g_xrek2_d[l_ac].xrek030))
            DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek030_desc
            LET g_xrek2_d_t.l_xrek030_desc = g_xrek2_d[l_ac].l_xrek030_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek030_desc
            #add-point:ON CHANGE l_xrek030_desc name="input.g.page2.l_xrek030_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek031
            
            #add-point:AFTER FIELD xrek031 name="input.a.page2.xrek031"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek031
            #add-point:BEFORE FIELD xrek031 name="input.b.page2.xrek031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek031
            #add-point:ON CHANGE xrek031 name="input.g.page2.xrek031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek031_desc
            #add-point:BEFORE FIELD l_xrek031_desc name="input.b.page2.l_xrek031_desc"
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_xrek2_d[l_ac].l_xrek031_desc = g_xrek2_d[l_ac].xrek031   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek031_desc
            
            #add-point:AFTER FIELD l_xrek031_desc name="input.a.page2.l_xrek031_desc"
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek031_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek031_desc != g_xrek2_d_t.l_xrek031_desc OR g_xrek2_d_t.l_xrek031_desc IS NULL) THEN
                  LET g_xrek2_d[l_ac].xrek031 = g_xrek2_d[l_ac].l_xrek031_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xrek2_d[l_ac].xrek031 != g_xrek2_d_t.xrek031 OR g_xrek2_d_t.xrek031 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_xrek2_d[l_ac].xrek031,g_glad.glad0252) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#22 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#22 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_xrek2_d[l_ac].xrek031 = g_xrek2_d_t.xrek031
                           LET g_xrek2_d[l_ac].l_xrek031_desc = s_desc_show1(g_xrek2_d[l_ac].xrek031,s_fin_get_accting_desc(g_glad.glad0251,g_xrek2_d[l_ac].xrek031))
                           DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek031_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek031 = ''
            END IF
            LET g_xrek2_d[l_ac].l_xrek031_desc = s_desc_show1(g_xrek2_d[l_ac].xrek031,s_fin_get_accting_desc(g_glad.glad0251,g_xrek2_d[l_ac].xrek031))
            DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek031_desc
            LET g_xrek2_d_t.l_xrek031_desc = g_xrek2_d[l_ac].l_xrek031_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek031_desc
            #add-point:ON CHANGE l_xrek031_desc name="input.g.page2.l_xrek031_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrek032
            
            #add-point:AFTER FIELD xrek032 name="input.a.page2.xrek032"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrek032
            #add-point:BEFORE FIELD xrek032 name="input.b.page2.xrek032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrek032
            #add-point:ON CHANGE xrek032 name="input.g.page2.xrek032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrek032_desc
            #add-point:BEFORE FIELD l_xrek032_desc name="input.b.page2.l_xrek032_desc"
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_xrek2_d[l_ac].l_xrek032_desc = g_xrek2_d[l_ac].xrek032   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrek032_desc
            
            #add-point:AFTER FIELD l_xrek032_desc name="input.a.page2.l_xrek032_desc"
            IF NOT cl_null(g_xrek2_d[l_ac].l_xrek032_desc) THEN
               IF (g_xrek2_d[l_ac].l_xrek032_desc != g_xrek2_d_t.l_xrek032_desc OR g_xrek2_d_t.l_xrek032_desc IS NULL) THEN
                  LET g_xrek2_d[l_ac].xrek032 = g_xrek2_d[l_ac].l_xrek032_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xrek2_d[l_ac].xrek032 != g_xrek2_d_t.xrek032 OR g_xrek2_d_t.xrek032 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_xrek2_d[l_ac].xrek032,g_glad.glad0262) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#22 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#22 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_xrek2_d[l_ac].xrek032 = g_xrek2_d_t.xrek032
                           LET g_xrek2_d[l_ac].l_xrek032_desc = s_desc_show1(g_xrek2_d[l_ac].xrek032,s_fin_get_accting_desc(g_glad.glad0261,g_xrek2_d[l_ac].xrek032))
                           DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek032_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xrek2_d[l_ac].xrek032 = ''
            END IF
            LET g_xrek2_d[l_ac].l_xrek032_desc = s_desc_show1(g_xrek2_d[l_ac].xrek032,s_fin_get_accting_desc(g_glad.glad0261,g_xrek2_d[l_ac].xrek032))
            LET g_xrek2_d_t.l_xrek032_desc = g_xrek2_d[l_ac].l_xrek032_desc 
            DISPLAY BY NAME g_xrek2_d[l_ac].l_xrek032_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrek032_desc
            #add-point:ON CHANGE l_xrek032_desc name="input.g.page2.l_xrek032_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.xrek033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek033
            #add-point:ON ACTION controlp INFIELD xrek033 name="input.c.page2.xrek033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek019
            #add-point:ON ACTION controlp INFIELD xrek019 name="input.c.page2.xrek019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek019_desc
            #add-point:ON ACTION controlp INFIELD l_xrek019_desc name="input.c.page2.l_xrek019_desc"
            LET g_glaa004 = NULL
            SELECT glaa004 INTO g_glaa004 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_xrej_m.xrejld
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek019
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' " , #glac001(會計科目參照表)/glac003(科目類型)
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",  #161115-00044#1-add
                                   "AND gladld='",g_xrej_m.xrejld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"            
            CALL aglt310_04()
            LET g_xrek2_d[l_ac].xrek019      = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek019_desc = g_xrek2_d[l_ac].xrek019
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek019,g_xrek2_d[l_ac].l_xrek019_desc
            NEXT FIELD l_xrek019_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek041
            #add-point:ON ACTION controlp INFIELD xrek041 name="input.c.page2.xrek041"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek041_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek041_desc
            #add-point:ON ACTION controlp INFIELD l_xrek041_desc name="input.c.page2.l_xrek041_desc"
            LET g_glaa004 = NULL
            SELECT glaa004 INTO g_glaa004 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_xrej_m.xrejld
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek041
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' ",  #glac001(會計科目參照表)/glac003(科目類型)
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",  #161115-00044#1-add
                                   "AND gladld='",g_xrej_m.xrejld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_xrek2_d[l_ac].xrek041      = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek041_desc = g_xrek2_d[l_ac].xrek041
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek041,g_xrek2_d[l_ac].l_xrek041_desc
            NEXT FIELD l_xrek041_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrekorga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrekorga
            #add-point:ON ACTION controlp INFIELD xrekorga name="input.c.page2.xrekorga"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrekorga_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrekorga_desc
            #add-point:ON ACTION controlp INFIELD l_xrekorga_desc name="input.c.page2.l_xrekorga_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek009
            #add-point:ON ACTION controlp INFIELD xrek009 name="input.c.page2.xrek009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek009_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek009_desc
            #add-point:ON ACTION controlp INFIELD l_xrek009_desc name="input.c.page2.l_xrek009_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek016
            #add-point:ON ACTION controlp INFIELD xrek016 name="input.c.page2.xrek016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek016_desc
            #add-point:ON ACTION controlp INFIELD l_xrek016_desc name="input.c.page2.l_xrek016_desc"
            #業務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek016
            CALL q_ooag001_8()        #141218-00011#6
            LET g_xrek2_d[l_ac].xrek016 = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek016_desc = g_qryparam.return1
            DISPLAY BY NAME  g_xrek2_d[l_ac].xrek016,g_xrek2_d[l_ac].l_xrek016_desc
            NEXT FIELD l_xrek016_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek011
            #add-point:ON ACTION controlp INFIELD xrek011 name="input.c.page2.xrek011"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek011_desc
            #add-point:ON ACTION controlp INFIELD l_xrek011_desc name="input.c.page2.l_xrek011_desc"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek011
            LET g_qryparam.arg1 = g_xrej_m.xrejdocdt
            CALL q_ooeg001_4()
            LET g_xrek2_d[l_ac].xrek011      = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek011_desc = g_xrek2_d[l_ac].xrek011
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek011,g_xrek2_d[l_ac].l_xrek011_desc
            NEXT FIELD l_xrek011_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek012
            #add-point:ON ACTION controlp INFIELD xrek012 name="input.c.page2.xrek012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek012_desc
            #add-point:ON ACTION controlp INFIELD l_xrek012_desc name="input.c.page2.l_xrek012_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek012
           #CALL q_ooeg001_2()      ##141218-00011#6 MARK
#            LET g_qryparam.where = " ooeg003 IN ('1','2','3')"    #141218-00011#6   #albireo 150302 MARK
            LET g_qryparam.arg1 = g_xrej_m.xrejdocdt               #albireo 150302 ADD
            CALL q_ooeg001_5()                                     #141218-00011#6
            LET g_xrek2_d[l_ac].xrek012      = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek012_desc = g_xrek2_d[l_ac].xrek012 
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek012,g_xrek2_d[l_ac].l_xrek012_desc
            NEXT FIELD l_xrek012_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek013
            #add-point:ON ACTION controlp INFIELD xrek013 name="input.c.page2.xrek013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek013_desc
            #add-point:ON ACTION controlp INFIELD l_xrek013_desc name="input.c.page2.l_xrek013_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek013
            CALL q_oocq002_287()
            LET g_xrek2_d[l_ac].xrek013      = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek013_desc = g_qryparam.return1
            DISPLAY BY NAME  g_xrek2_d[l_ac].xrek013,g_xrek2_d[l_ac].l_xrek013_desc
            NEXT FIELD l_xrek013_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek014
            #add-point:ON ACTION controlp INFIELD xrek014 name="input.c.page2.xrek014"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek014_desc
            #add-point:ON ACTION controlp INFIELD l_xrek014_desc name="input.c.page2.l_xrek014_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek014
            CALL q_oocq002_281()
            LET g_xrek2_d[l_ac].xrek014      = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek014_desc = g_qryparam.return1
            DISPLAY BY NAME  g_xrek2_d[l_ac].xrek014,g_xrek2_d[l_ac].l_xrek014_desc
            NEXT FIELD l_xrek014_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek015
            #add-point:ON ACTION controlp INFIELD xrek015 name="input.c.page2.xrek015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek015_desc
            #add-point:ON ACTION controlp INFIELD l_xrek015_desc name="input.c.page2.l_xrek015_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek015
            CALL q_rtax001()
            LET g_xrek2_d[l_ac].xrek015 = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek015_desc = g_qryparam.return1
            DISPLAY BY NAME  g_xrek2_d[l_ac].xrek015,g_xrek2_d[l_ac].l_xrek015_desc
            NEXT FIELD l_xrek015_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek017
            #add-point:ON ACTION controlp INFIELD xrek017 name="input.c.page2.xrek017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek017_desc
            #add-point:ON ACTION controlp INFIELD l_xrek017_desc name="input.c.page2.l_xrek017_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek017
            CALL q_pjba001()
            LET g_xrek2_d[l_ac].xrek017      = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek017_desc = g_xrek2_d[l_ac].xrek017
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek017,g_xrek2_d[l_ac].l_xrek017_desc
            NEXT FIELD l_xrek017_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek018
            #add-point:ON ACTION controlp INFIELD xrek018 name="input.c.page2.xrek018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek018_desc
            #add-point:ON ACTION controlp INFIELD l_xrek018_desc name="input.c.page2.l_xrek018_desc"
            #albireo 150302-----s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek018
            IF NOT cl_null(g_xrek2_d[l_ac].xrek017) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_xrek2_d[l_ac].xrek017,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF  
            CALL q_pjbb002()
            LET g_xrek2_d[l_ac].xrek018      = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek018_desc = g_xrek2_d[l_ac].xrek018
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek018,g_xrek2_d[l_ac].l_xrek018_desc
            NEXT FIELD l_xrek018_desc
            #albireo 150302-----e
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek020
            #add-point:ON ACTION controlp INFIELD xrek020 name="input.c.page2.xrek020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek021
            #add-point:ON ACTION controlp INFIELD xrek021 name="input.c.page2.xrek021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek021_desc
            #add-point:ON ACTION controlp INFIELD l_xrek021_desc name="input.c.page2.l_xrek021_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek021
            CALL q_oojd001_2()
            LET g_xrek2_d[l_ac].xrek021      = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek021_desc = g_xrek2_d[l_ac].xrek021
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek021,g_xrek2_d[l_ac].l_xrek021_desc
            NEXT FIELD l_xrek021_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek022
            #add-point:ON ACTION controlp INFIELD xrek022 name="input.c.page2.xrek022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek022_desc
            #add-point:ON ACTION controlp INFIELD l_xrek022_desc name="input.c.page2.l_xrek022_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek022
            CALL q_oocq002_2002()
            LET g_xrek2_d[l_ac].xrek022        = g_qryparam.return1
            LET g_xrek2_d[l_ac].l_xrek022_desc   = g_xrek2_d[l_ac].xrek022
            DISPLAY BY NAME g_xrek2_d[l_ac].xrek022,g_xrek2_d[l_ac].l_xrek022_desc
            NEXT FIELD l_xrek022_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek023
            #add-point:ON ACTION controlp INFIELD xrek023 name="input.c.page2.xrek023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek023_desc
            #add-point:ON ACTION controlp INFIELD l_xrek023_desc name="input.c.page2.l_xrek023_desc"
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek023

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xrek2_d[l_ac].xrek023      = g_qryparam.return1
               LET g_xrek2_d[l_ac].l_xrek023_desc = g_qryparam.return1
               DISPLAY BY NAME g_xrek2_d[l_ac].xrek023,g_xrek2_d[l_ac].l_xrek023_desc
               NEXT FIELD l_xrek023_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek024
            #add-point:ON ACTION controlp INFIELD xrek024 name="input.c.page2.xrek024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek024_desc
            #add-point:ON ACTION controlp INFIELD l_xrek024_desc name="input.c.page2.l_xrek024_desc"
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek024 

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xrek2_d[l_ac].xrek024       = g_qryparam.return1
               LET g_xrek2_d[l_ac].l_xrek024_desc  = g_qryparam.return1
               DISPLAY BY NAME g_xrek2_d[l_ac].xrek024,g_xrek2_d[l_ac].l_xrek024_desc
               NEXT FIELD l_xrek024_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek025
            #add-point:ON ACTION controlp INFIELD xrek025 name="input.c.page2.xrek025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek025_desc
            #add-point:ON ACTION controlp INFIELD l_xrek025_desc name="input.c.page2.l_xrek025_desc"
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek025

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xrek2_d[l_ac].xrek025      = g_qryparam.return1
               LET g_xrek2_d[l_ac].l_xrek025_desc = g_qryparam.return1
               DISPLAY BY NAME g_xrek2_d[l_ac].xrek025,g_xrek2_d[l_ac].l_xrek025_desc
               NEXT FIELD l_xrek025_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek026
            #add-point:ON ACTION controlp INFIELD xrek026 name="input.c.page2.xrek026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek026_desc
            #add-point:ON ACTION controlp INFIELD l_xrek026_desc name="input.c.page2.l_xrek026_desc"
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 =  g_xrek2_d[l_ac].xrek026  

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xrek2_d[l_ac].xrek026      = g_qryparam.return1
               LET g_xrek2_d[l_ac].l_xrek026_desc = g_qryparam.return1
               DISPLAY BY NAME g_xrek2_d[l_ac].xrek026,g_xrek2_d[l_ac].l_xrek026_desc
               NEXT FIELD l_xrek026_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek027
            #add-point:ON ACTION controlp INFIELD xrek027 name="input.c.page2.xrek027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek027_desc
            #add-point:ON ACTION controlp INFIELD l_xrek027_desc name="input.c.page2.l_xrek027_desc"
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek027 

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xrek2_d[l_ac].xrek027      = g_qryparam.return1
               LET g_xrek2_d[l_ac].l_xrek027_desc = g_qryparam.return1
               DISPLAY BY NAME g_xrek2_d[l_ac].xrek027,g_xrek2_d[l_ac].l_xrek027_desc
               NEXT FIELD l_xrek027_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek028
            #add-point:ON ACTION controlp INFIELD xrek028 name="input.c.page2.xrek028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek028_desc
            #add-point:ON ACTION controlp INFIELD l_xrek028_desc name="input.c.page2.l_xrek028_desc"
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek028

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xrek2_d[l_ac].xrek028      = g_qryparam.return1
               LET g_xrek2_d[l_ac].l_xrek028_desc = g_qryparam.return1
               DISPLAY BY NAME g_xrek2_d[l_ac].xrek028,g_xrek2_d[l_ac].l_xrek028_desc
               NEXT FIELD l_xrek028_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek029
            #add-point:ON ACTION controlp INFIELD xrek029 name="input.c.page2.xrek029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek029_desc
            #add-point:ON ACTION controlp INFIELD l_xrek029_desc name="input.c.page2.l_xrek029_desc"
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek029

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xrek2_d[l_ac].xrek029      = g_qryparam.return1
               LET g_xrek2_d[l_ac].l_xrek029_desc = g_qryparam.return1
               DISPLAY BY NAME g_xrek2_d[l_ac].xrek029,g_xrek2_d[l_ac].l_xrek029_desc
               NEXT FIELD l_xrek029_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek030
            #add-point:ON ACTION controlp INFIELD xrek030 name="input.c.page2.xrek030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek030_desc
            #add-point:ON ACTION controlp INFIELD l_xrek030_desc name="input.c.page2.l_xrek030_desc"
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek030

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xrek2_d[l_ac].xrek030      = g_qryparam.return1
               LET g_xrek2_d[l_ac].l_xrek030_desc = g_qryparam.return1
               DISPLAY BY NAME g_xrek2_d[l_ac].xrek030,g_xrek2_d[l_ac].l_xrek030_desc
               NEXT FIELD l_xrek030_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek031
            #add-point:ON ACTION controlp INFIELD xrek031 name="input.c.page2.xrek031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek031_desc
            #add-point:ON ACTION controlp INFIELD l_xrek031_desc name="input.c.page2.l_xrek031_desc"
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek031

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xrek2_d[l_ac].xrek031      = g_qryparam.return1
               LET g_xrek2_d[l_ac].l_xrek031_desc = g_qryparam.return1
               DISPLAY BY NAME g_xrek2_d[l_ac].xrek031,g_xrek2_d[l_ac].l_xrek031_desc
               NEXT FIELD l_xrek031_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrek032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrek032
            #add-point:ON ACTION controlp INFIELD xrek032 name="input.c.page2.xrek032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_xrek032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrek032_desc
            #add-point:ON ACTION controlp INFIELD l_xrek032_desc name="input.c.page2.l_xrek032_desc"
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrek2_d[l_ac].xrek032

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xrek2_d[l_ac].xrek032     = g_qryparam.return1
               LET g_xrek2_d[l_ac].l_xrek032_desc = g_qryparam.return1
               DISPLAY BY NAME g_xrek2_d[l_ac].xrek032,g_xrek2_d[l_ac].l_xrek032_desc
               NEXT FIELD l_xrek032_desc
            END IF
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xrek2_d[l_ac].* = g_xrek2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt940_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt940_unlock_b("xrek_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            #141202-00061#17
            CALL s_ld_sel_glaa(g_xrej_m.xrejld,'glaa121|glaacomp') RETURNING g_sub_success,g_glaa121,g_glaacomp
            CALL s_aooi200_fin_get_slip(g_xrej_m.xrejdocno) RETURNING g_sub_success,g_ap_slip               
            #150202-00002#1 mark
            #CALL s_fin_get_doc_para(g_xrej_m.xrejld,g_glaacomp,g_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
            #IF g_glaa121 = 'Y' AND g_dfin0030 = 'Y' THEN
            IF g_glaa121 = 'Y' THEN #150202-00002#1 add
               CALL s_transaction_begin()
               CALL s_pre_voucher_ins('AP','P60',g_xrej_m.xrejld,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,'1')
                    RETURNING g_sub_success
               IF g_sub_success THEN 
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
               END IF
            END IF
            #141202-00061#17
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xrek_d[li_reproduce_target].* = g_xrek_d[li_reproduce].*
               LET g_xrek2_d[li_reproduce_target].* = g_xrek2_d[li_reproduce].*
 
               LET g_xrek2_d[li_reproduce_target].xrekseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrek2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrek2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aapt940.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         NEXT FIELD xrek033
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xrejdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xrekseq
               WHEN "s_detail2"
                  NEXT FIELD xrekseq_2
 
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
 
{<section id="aapt940.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aapt940_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aapt940_b_fill() #單身填充
      CALL aapt940_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aapt940_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_xrej_m_mask_o.* =  g_xrej_m.*
   CALL aapt940_xrej_t_mask()
   LET g_xrej_m_mask_n.* =  g_xrej_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xrej_m.xrejsite,g_xrej_m.xrejsite_desc,g_xrej_m.xrejld,g_xrej_m.xrejld_desc,g_xrej_m.xrej004, 
       g_xrej_m.xrej004_desc,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002, 
       g_xrej_m.xrej005,g_xrej_m.xrejstus,g_xrej_m.xrejownid,g_xrej_m.xrejownid_desc,g_xrej_m.xrejowndp, 
       g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdp_desc, 
       g_xrej_m.xrejcrtdt,g_xrej_m.xrejmodid,g_xrej_m.xrejmodid_desc,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid, 
       g_xrej_m.xrejcnfid_desc,g_xrej_m.xrejcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrej_m.xrejstus 
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
   FOR l_ac = 1 TO g_xrek_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xrek2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   #141202-00061#17
   CALL s_ld_sel_glaa(g_xrej_m.xrejld,'glaa121') RETURNING g_sub_success,g_glaa121
   #是否啟用分錄底稿
   IF g_glaa121 = 'Y' THEN
      CALL cl_set_toolbaritem_visible("open_pre", TRUE)
   ELSE
      CALL cl_set_toolbaritem_visible("open_pre", FALSE)
   END IF
   #141202-00061#17
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aapt940_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aapt940_detail_show()
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
 
{<section id="aapt940.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapt940_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xrej_t.xrejdocno 
   DEFINE l_oldno     LIKE xrej_t.xrejdocno 
 
   DEFINE l_master    RECORD LIKE xrej_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xrek_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_xrej_m.xrejdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xrejdocno_t = g_xrej_m.xrejdocno
 
    
   LET g_xrej_m.xrejdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrej_m.xrejownid = g_user
      LET g_xrej_m.xrejowndp = g_dept
      LET g_xrej_m.xrejcrtid = g_user
      LET g_xrej_m.xrejcrtdp = g_dept 
      LET g_xrej_m.xrejcrtdt = cl_get_current()
      LET g_xrej_m.xrejmodid = g_user
      LET g_xrej_m.xrejmoddt = cl_get_current()
      LET g_xrej_m.xrejstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrej_m.xrejstus 
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
   
   
   CALL aapt940_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xrej_m.* TO NULL
      INITIALIZE g_xrek_d TO NULL
      INITIALIZE g_xrek2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aapt940_show()
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
   CALL aapt940_set_act_visible()   
   CALL aapt940_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xrejdocno_t = g_xrej_m.xrejdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrejent = " ||g_enterprise|| " AND",
                      " xrejdocno = '", g_xrej_m.xrejdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt940_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aapt940_idx_chk()
   
   LET g_data_owner = g_xrej_m.xrejownid      
   LET g_data_dept  = g_xrej_m.xrejowndp
   
   #功能已完成,通報訊息中心
   CALL aapt940_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt940.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aapt940_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xrek_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aapt940_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrek_t
    WHERE xrekent = g_enterprise AND xrekdocno = g_xrejdocno_t
 
    INTO TEMP aapt940_detail
 
   #將key修正為調整後   
   UPDATE aapt940_detail 
      #更新key欄位
      SET xrekdocno = g_xrej_m.xrejdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xrek_t SELECT * FROM aapt940_detail
   
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
   DROP TABLE aapt940_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xrejdocno_t = g_xrej_m.xrejdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt940_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_cnt           LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xrej_m.xrejdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aapt940_cl USING g_enterprise,g_xrej_m.xrejdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt940_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt940_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt940_master_referesh USING g_xrej_m.xrejdocno INTO g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004, 
       g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus, 
       g_xrej_m.xrejownid,g_xrej_m.xrejowndp,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdt, 
       g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid,g_xrej_m.xrejcnfdt,g_xrej_m.xrejownid_desc, 
       g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp_desc,g_xrej_m.xrejmodid_desc, 
       g_xrej_m.xrejcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aapt940_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xrej_m_mask_o.* =  g_xrej_m.*
   CALL aapt940_xrej_t_mask()
   LET g_xrej_m_mask_n.* =  g_xrej_m.*
   
   CALL aapt940_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt940_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xrejdocno_t = g_xrej_m.xrejdocno
 
 
      DELETE FROM xrej_t
       WHERE xrejent = g_enterprise AND xrejdocno = g_xrej_m.xrejdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
        AND xrej003 = 'AP'
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xrej_m.xrejdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
       IF NOT s_aooi200_fin_del_docno(g_xrej_m.xrejld,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #141202-00061#17
      CALL s_ld_sel_glaa(g_xrej_m.xrejld,'glaacomp|glaa121') RETURNING  g_sub_success,g_glaacomp,g_glaa121
      CALL s_aooi200_fin_get_slip(g_xrej_m.xrejdocno) RETURNING g_sub_success,g_ap_slip
      #150202-00002#1 mark
      #CALL s_fin_get_doc_para(g_xrej_m.xrejld,g_glaacomp,g_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
      #IF g_glaa121 = 'Y' AND g_dfin0030 = 'Y' THEN
      IF g_glaa121 = 'Y' THEN  #150202-00002#1 add
         #分錄單頭
         SELECT count(*) INTO l_cnt
           FROM glga_t
          WHERE glgaent = g_enterprise
            AND glgald  = g_xrej_m.xrejld AND glgadocno = g_xrej_m.xrejdocno
            AND glga100 = 'AP' AND glga101 = 'P60'
          
          IF l_cnt > 0 THEN
            DELETE FROM glga_t
             WHERE glgaent = g_enterprise
               AND glgald  = g_xrej_m.xrejld AND glgadocno = g_xrej_m.xrejdocno
               AND glga100 = 'AP' AND glga101 = 'P60'
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xrej_m.xrejdocno 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
            END IF 
          END IF
          
          #分錄單身
          SELECT count(*) INTO l_cnt
           FROM glgb_t
          WHERE glgbent = g_enterprise
            AND glgbld  = g_xrej_m.xrejld AND glgbdocno = g_xrej_m.xrejdocno
            AND glgb100 = 'AP' AND glgb101 LIKE 'P60'
          
          IF l_cnt > 0 THEN
            DELETE FROM glgb_t
             WHERE glgbent = g_enterprise
               AND glgbld  = g_xrej_m.xrejld AND glgbdocno = g_xrej_m.xrejdocno
               AND glgb100 = 'AP' AND glgb101 LIKE 'P60'
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xrej_m.xrejdocno 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
               END IF 
          END IF
      END IF
      #141202-00061#17
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xrek_t
       WHERE xrekent = g_enterprise AND xrekdocno = g_xrej_m.xrejdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrek_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      CALL g_xrek3_d.clear()
      CALL g_xrek4_d.clear()
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xrej_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aapt940_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xrek_d.clear() 
      CALL g_xrek2_d.clear()       
 
     
      CALL aapt940_ui_browser_refresh()  
      #CALL aapt940_ui_headershow()  
      #CALL aapt940_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aapt940_browser_fill("")
         CALL aapt940_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aapt940_cl
 
   #功能已完成,通報訊息中心
   CALL aapt940_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aapt940.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt940_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xrek_d.clear()
   CALL g_xrek2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_xrek3_d.clear()
   CALL g_xrek4_d.clear()
   #end add-point
   
   #判斷是否填充
   IF aapt940_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrekseq,xrek005,xrek006,xrek007,xrek100,xrek103,xrek113,xrek037, 
             xrek039,xrek105,xrek115,xrek104,xrek114,xrek038,xrek040,xrek106,xrek116,xrek107,xrek117, 
             xrekseq,xrek033,xrek019,xrek041,xrekorga,xrek009,xrek016,xrek011,xrek012,xrek013,xrek014, 
             xrek015,xrek017,xrek018,xrek020,xrek021,xrek022,xrek023,xrek024,xrek025,xrek026,xrek027, 
             xrek028,xrek029,xrek030,xrek031,xrek032  FROM xrek_t",   
                     " INNER JOIN xrej_t ON xrejent = " ||g_enterprise|| " AND xrejdocno = xrekdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE xrekent=? AND xrekdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xrek_t.xrekseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt940_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aapt940_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xrej_m.xrejdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xrej_m.xrejdocno INTO g_xrek_d[l_ac].xrekseq,g_xrek_d[l_ac].xrek005, 
          g_xrek_d[l_ac].xrek006,g_xrek_d[l_ac].xrek007,g_xrek_d[l_ac].xrek100,g_xrek_d[l_ac].xrek103, 
          g_xrek_d[l_ac].xrek113,g_xrek_d[l_ac].xrek037,g_xrek_d[l_ac].xrek039,g_xrek_d[l_ac].xrek105, 
          g_xrek_d[l_ac].xrek115,g_xrek_d[l_ac].xrek104,g_xrek_d[l_ac].xrek114,g_xrek_d[l_ac].xrek038, 
          g_xrek_d[l_ac].xrek040,g_xrek_d[l_ac].xrek106,g_xrek_d[l_ac].xrek116,g_xrek_d[l_ac].xrek107, 
          g_xrek_d[l_ac].xrek117,g_xrek2_d[l_ac].xrekseq,g_xrek2_d[l_ac].xrek033,g_xrek2_d[l_ac].xrek019, 
          g_xrek2_d[l_ac].xrek041,g_xrek2_d[l_ac].xrekorga,g_xrek2_d[l_ac].xrek009,g_xrek2_d[l_ac].xrek016, 
          g_xrek2_d[l_ac].xrek011,g_xrek2_d[l_ac].xrek012,g_xrek2_d[l_ac].xrek013,g_xrek2_d[l_ac].xrek014, 
          g_xrek2_d[l_ac].xrek015,g_xrek2_d[l_ac].xrek017,g_xrek2_d[l_ac].xrek018,g_xrek2_d[l_ac].xrek020, 
          g_xrek2_d[l_ac].xrek021,g_xrek2_d[l_ac].xrek022,g_xrek2_d[l_ac].xrek023,g_xrek2_d[l_ac].xrek024, 
          g_xrek2_d[l_ac].xrek025,g_xrek2_d[l_ac].xrek026,g_xrek2_d[l_ac].xrek027,g_xrek2_d[l_ac].xrek028, 
          g_xrek2_d[l_ac].xrek029,g_xrek2_d[l_ac].xrek030,g_xrek2_d[l_ac].xrek031,g_xrek2_d[l_ac].xrek032  
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
         CALL s_desc_get_department_desc(g_xrej_m.xrejsite)RETURNING g_xrej_m.xrejsite_desc
         CALL s_desc_get_ld_desc(g_xrej_m.xrejld) RETURNING g_xrej_m.xrejld_desc
         CALL s_desc_get_person_desc(g_xrej_m.xrej004) RETURNING g_xrej_m.xrej004_desc         
         #固定核算項
         LET g_xrek2_d[l_ac].l_xrek041_desc = s_desc_show1(g_xrek2_d[l_ac].xrek041,s_desc_get_account_desc(g_xrej_m.xrejld,g_xrek2_d[l_ac].xrek041))
         LET g_xrek2_d[l_ac].l_xrek019_desc = s_desc_show1(g_xrek2_d[l_ac].xrek019,s_desc_get_account_desc(g_xrej_m.xrejld,g_xrek2_d[l_ac].xrek019))
         LET g_xrek2_d[l_ac].l_xrek011_desc = s_desc_show1(g_xrek2_d[l_ac].xrek011,s_desc_get_department_desc(g_xrek2_d[l_ac].xrek011))
         LET g_xrek2_d[l_ac].l_xrek012_desc = s_desc_show1(g_xrek2_d[l_ac].xrek012,s_desc_get_department_desc(g_xrek2_d[l_ac].xrek012))
         LET g_xrek2_d[l_ac].l_xrek013_desc = s_desc_show1(g_xrek2_d[l_ac].xrek013,s_desc_get_acc_desc('287',g_xrek2_d[l_ac].xrek013))
         LET g_xrek2_d[l_ac].l_xrek014_desc = s_desc_show1(g_xrek2_d[l_ac].xrek014,s_desc_get_acc_desc('281',g_xrek2_d[l_ac].xrek014))
         LET g_xrek2_d[l_ac].l_xrek015_desc = s_desc_show1(g_xrek2_d[l_ac].xrek015,s_desc_get_rtaxl003_desc(g_xrek2_d[l_ac].xrek015))
         LET g_xrek2_d[l_ac].l_xrek016_desc = s_desc_show1(g_xrek2_d[l_ac].xrek016,s_desc_get_person_desc(g_xrek2_d[l_ac].xrek016))
         LET g_xrek2_d[l_ac].l_xrek017_desc = s_desc_show1(g_xrek2_d[l_ac].xrek017,s_desc_get_project_desc(g_xrek2_d[l_ac].xrek017))
         LET g_xrek2_d[l_ac].l_xrek021_desc = s_desc_show1(g_xrek2_d[l_ac].xrek021,s_desc_get_oojdl003_desc(g_xrek2_d[l_ac].xrek021))
         LET g_xrek2_d[l_ac].l_xrek022_desc = s_desc_show1(g_xrek2_d[l_ac].xrek022,s_desc_get_acc_desc(2002,g_xrek2_d[l_ac].xrek022))
         LET g_xrek2_d[l_ac].l_xrek018_desc = s_desc_show1(g_xrek2_d[l_ac].xrek018,s_desc_get_pjbbl004_desc(g_xrek2_d[l_ac].xrek017,g_xrek2_d[l_ac].xrek018))
         
         #取得自由核算項類型
         INITIALIZE g_glad.* TO NULL #140818-00002#2 albireo 150316 ADD
         # CALL s_fin_sel_glad(g_xrem_m.xremld,g_xrek2_d[l_ac].xrek019,'ALL') RETURNING g_glad.*
         LET g_glad.glad017 = 'N' #自由核算項一控制方式
         LET g_glad.glad018 = 'N'
         LET g_glad.glad019 = 'N'
         LET g_glad.glad020 = 'N'
         LET g_glad.glad021 = 'N'
         LET g_glad.glad022 = 'N'
         LET g_glad.glad023 = 'N'
         LET g_glad.glad024 = 'N'
         LET g_glad.glad025 = 'N'
         LET g_glad.glad026 = 'N' #自由核算項十控制方式
         IF NOT cl_null(g_xrek2_d[l_ac].xrek019) THEN
            #140818-00002#2 albireo 150316 modify-----s
            #CALL aapt940_glad_chk(g_xrek2_d[l_ac].xrek019) RETURNING g_glad.*
            CALL aapt940_glad_chk(g_xrek2_d[l_ac].xrek019)
            #140818-00002#2 albireo 150316 modify-----e
         END IF  
         
         IF NOT cl_null(g_xrek2_d[l_ac].xrek041) THEN
            #140818-00002#2 albireo 150316 modify-----s
            #CALL aapt940_glad_chk(g_xrek2_d[l_ac].xrek041) RETURNING g_glad.*
            CALL aapt940_glad_chk(g_xrek2_d[l_ac].xrek041)
            #140818-00002#2 albireo 150316 modify-----e
         END IF
         
         IF NOT cl_null(g_xrek2_d[l_ac].xrek023) THEN
            LET g_xrek2_d[l_ac].l_xrek023_desc = s_desc_show1(g_xrek2_d[l_ac].xrek023,s_fin_get_accting_desc(g_glad.glad0171,g_xrek2_d[l_ac].xrek023))
         END IF
         IF NOT cl_null(g_xrek2_d[l_ac].xrek024) THEN
            LET g_xrek2_d[l_ac].l_xrek024_desc = s_desc_show1(g_xrek2_d[l_ac].xrek024,s_fin_get_accting_desc(g_glad.glad0181,g_xrek2_d[l_ac].xrek024))
         END IF
         IF NOT cl_null(g_xrek2_d[l_ac].xrek025) THEN
            LET g_xrek2_d[l_ac].l_xrek025_desc = s_desc_show1(g_xrek2_d[l_ac].xrek025,s_fin_get_accting_desc(g_glad.glad0191,g_xrek2_d[l_ac].xrek025))
         END IF
         IF NOT cl_null(g_xrek2_d[l_ac].xrek026) THEN
            LET g_xrek2_d[l_ac].l_xrek026_desc = s_desc_show1(g_xrek2_d[l_ac].xrek026,s_fin_get_accting_desc(g_glad.glad0201,g_xrek2_d[l_ac].xrek026))
         END IF
         IF NOT cl_null(g_xrek2_d[l_ac].xrek027) THEN
            LET g_xrek2_d[l_ac].l_xrek027_desc = s_desc_show1(g_xrek2_d[l_ac].xrek027,s_fin_get_accting_desc(g_glad.glad0211,g_xrek2_d[l_ac].xrek027))
         END IF
         IF NOT cl_null(g_xrek2_d[l_ac].xrek028) THEN
            LET g_xrek2_d[l_ac].l_xrek028_desc = s_desc_show1(g_xrek2_d[l_ac].xrek028,s_fin_get_accting_desc(g_glad.glad0221,g_xrek2_d[l_ac].xrek028))
         END IF
         IF NOT cl_null(g_xrek2_d[l_ac].xrek029) THEN
            LET g_xrek2_d[l_ac].l_xrek029_desc = s_desc_show1(g_xrek2_d[l_ac].xrek029,s_fin_get_accting_desc(g_glad.glad0231,g_xrek2_d[l_ac].xrek029))
         END IF
         IF NOT cl_null(g_xrek2_d[l_ac].xrek030) THEN
            LET g_xrek2_d[l_ac].l_xrek030_desc = s_desc_show1(g_xrek2_d[l_ac].xrek030,s_fin_get_accting_desc(g_glad.glad0241,g_xrek2_d[l_ac].xrek030))
         END IF
         IF NOT cl_null(g_xrek2_d[l_ac].xrek031) THEN
            LET g_xrek2_d[l_ac].l_xrek031_desc = s_desc_show1(g_xrek2_d[l_ac].xrek031,s_fin_get_accting_desc(g_glad.glad0251,g_xrek2_d[l_ac].xrek031))
         END IF
         IF NOT cl_null(g_xrek2_d[l_ac].xrek032) THEN
            LET g_xrek2_d[l_ac].l_xrek032_desc = s_desc_show1(g_xrek2_d[l_ac].xrek032,s_fin_get_accting_desc(g_glad.glad0261,g_xrek2_d[l_ac].xrek032))
         END IF
         #要弄成desc讓總長度夠   說明才會出來
         LET g_xrek2_d[l_ac].l_xrekorga_desc = s_desc_show1(g_xrek2_d[l_ac].xrekorga,s_desc_get_department_desc(g_xrek2_d[l_ac].xrekorga))
         LET g_xrek2_d[l_ac].l_xrek009_desc  = s_desc_show1(g_xrek2_d[l_ac].xrek009,s_desc_get_trading_partner_abbr_desc(g_xrek2_d[l_ac].xrek009))
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
   LET g_sql = "SELECT xrekseq,xrek005,xrek006,xrek007,",
               "       xrek100,xrek103,xrek113,xrek037,",
               "       xrek039,xrek105,xrek115 ",
               "  FROM xrek_t ",
               " WHERE xrekent = ",g_enterprise," ",
               "   AND xrekdocno=? "
   PREPARE aapt940_bfill2p FROM g_sql
   DECLARE aapt940_bfill2c CURSOR FOR aapt940_bfill2p
   LET l_ac = 1
   FOREACH aapt940_bfill2c USING g_xrej_m.xrejdocno 
      INTO g_xrek3_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   
   LET g_sql = "SELECT xrekseq,xrek005,xrek006,xrek007,",
               "       xrek100,xrek104,xrek114,xrek038,",
               "       xrek040,xrek106,xrek116 ",
               "  FROM xrek_t ",
               " WHERE xrekent = ",g_enterprise," ",
               "   AND xrekdocno=? "
   PREPARE aapt940_bfill3p FROM g_sql
   DECLARE aapt940_bfill3c CURSOR FOR aapt940_bfill3p
   
   LET l_ac = 1
   FOREACH aapt940_bfill3c USING g_xrej_m.xrejdocno 
      INTO g_xrek4_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH         
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_xrek3_d.deleteElement(g_xrek3_d.getLength())
   CALL g_xrek4_d.deleteElement(g_xrek4_d.getLength())
   #end add-point
   
   CALL g_xrek_d.deleteElement(g_xrek_d.getLength())
   CALL g_xrek2_d.deleteElement(g_xrek2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aapt940_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xrek_d.getLength()
      LET g_xrek_d_mask_o[l_ac].* =  g_xrek_d[l_ac].*
      CALL aapt940_xrek_t_mask()
      LET g_xrek_d_mask_n[l_ac].* =  g_xrek_d[l_ac].*
   END FOR
   
   LET g_xrek2_d_mask_o.* =  g_xrek2_d.*
   FOR l_ac = 1 TO g_xrek2_d.getLength()
      LET g_xrek2_d_mask_o[l_ac].* =  g_xrek2_d[l_ac].*
      CALL aapt940_xrek_t_mask()
      LET g_xrek2_d_mask_n[l_ac].* =  g_xrek2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aapt940.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt940_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM xrek_t
       WHERE xrekent = g_enterprise AND
         xrekdocno = ps_keys_bak[1] AND xrekseq = ps_keys_bak[2]
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
         CALL g_xrek_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xrek2_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt940_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO xrek_t
                  (xrekent,
                   xrekdocno,
                   xrekseq
                   ,xrek005,xrek006,xrek007,xrek100,xrek103,xrek113,xrek037,xrek039,xrek105,xrek115,xrek104,xrek114,xrek038,xrek040,xrek106,xrek116,xrek107,xrek117,xrek033,xrek019,xrek041,xrekorga,xrek009,xrek016,xrek011,xrek012,xrek013,xrek014,xrek015,xrek017,xrek018,xrek020,xrek021,xrek022,xrek023,xrek024,xrek025,xrek026,xrek027,xrek028,xrek029,xrek030,xrek031,xrek032) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xrek_d[g_detail_idx].xrek005,g_xrek_d[g_detail_idx].xrek006,g_xrek_d[g_detail_idx].xrek007, 
                       g_xrek_d[g_detail_idx].xrek100,g_xrek_d[g_detail_idx].xrek103,g_xrek_d[g_detail_idx].xrek113, 
                       g_xrek_d[g_detail_idx].xrek037,g_xrek_d[g_detail_idx].xrek039,g_xrek_d[g_detail_idx].xrek105, 
                       g_xrek_d[g_detail_idx].xrek115,g_xrek_d[g_detail_idx].xrek104,g_xrek_d[g_detail_idx].xrek114, 
                       g_xrek_d[g_detail_idx].xrek038,g_xrek_d[g_detail_idx].xrek040,g_xrek_d[g_detail_idx].xrek106, 
                       g_xrek_d[g_detail_idx].xrek116,g_xrek_d[g_detail_idx].xrek107,g_xrek_d[g_detail_idx].xrek117, 
                       g_xrek2_d[g_detail_idx].xrek033,g_xrek2_d[g_detail_idx].xrek019,g_xrek2_d[g_detail_idx].xrek041, 
                       g_xrek2_d[g_detail_idx].xrekorga,g_xrek2_d[g_detail_idx].xrek009,g_xrek2_d[g_detail_idx].xrek016, 
                       g_xrek2_d[g_detail_idx].xrek011,g_xrek2_d[g_detail_idx].xrek012,g_xrek2_d[g_detail_idx].xrek013, 
                       g_xrek2_d[g_detail_idx].xrek014,g_xrek2_d[g_detail_idx].xrek015,g_xrek2_d[g_detail_idx].xrek017, 
                       g_xrek2_d[g_detail_idx].xrek018,g_xrek2_d[g_detail_idx].xrek020,g_xrek2_d[g_detail_idx].xrek021, 
                       g_xrek2_d[g_detail_idx].xrek022,g_xrek2_d[g_detail_idx].xrek023,g_xrek2_d[g_detail_idx].xrek024, 
                       g_xrek2_d[g_detail_idx].xrek025,g_xrek2_d[g_detail_idx].xrek026,g_xrek2_d[g_detail_idx].xrek027, 
                       g_xrek2_d[g_detail_idx].xrek028,g_xrek2_d[g_detail_idx].xrek029,g_xrek2_d[g_detail_idx].xrek030, 
                       g_xrek2_d[g_detail_idx].xrek031,g_xrek2_d[g_detail_idx].xrek032)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrek_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xrek_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xrek2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt940_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xrek_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aapt940_xrek_t_mask_restore('restore_mask_o')
               
      UPDATE xrek_t 
         SET (xrekdocno,
              xrekseq
              ,xrek005,xrek006,xrek007,xrek100,xrek103,xrek113,xrek037,xrek039,xrek105,xrek115,xrek104,xrek114,xrek038,xrek040,xrek106,xrek116,xrek107,xrek117,xrek033,xrek019,xrek041,xrekorga,xrek009,xrek016,xrek011,xrek012,xrek013,xrek014,xrek015,xrek017,xrek018,xrek020,xrek021,xrek022,xrek023,xrek024,xrek025,xrek026,xrek027,xrek028,xrek029,xrek030,xrek031,xrek032) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xrek_d[g_detail_idx].xrek005,g_xrek_d[g_detail_idx].xrek006,g_xrek_d[g_detail_idx].xrek007, 
                  g_xrek_d[g_detail_idx].xrek100,g_xrek_d[g_detail_idx].xrek103,g_xrek_d[g_detail_idx].xrek113, 
                  g_xrek_d[g_detail_idx].xrek037,g_xrek_d[g_detail_idx].xrek039,g_xrek_d[g_detail_idx].xrek105, 
                  g_xrek_d[g_detail_idx].xrek115,g_xrek_d[g_detail_idx].xrek104,g_xrek_d[g_detail_idx].xrek114, 
                  g_xrek_d[g_detail_idx].xrek038,g_xrek_d[g_detail_idx].xrek040,g_xrek_d[g_detail_idx].xrek106, 
                  g_xrek_d[g_detail_idx].xrek116,g_xrek_d[g_detail_idx].xrek107,g_xrek_d[g_detail_idx].xrek117, 
                  g_xrek2_d[g_detail_idx].xrek033,g_xrek2_d[g_detail_idx].xrek019,g_xrek2_d[g_detail_idx].xrek041, 
                  g_xrek2_d[g_detail_idx].xrekorga,g_xrek2_d[g_detail_idx].xrek009,g_xrek2_d[g_detail_idx].xrek016, 
                  g_xrek2_d[g_detail_idx].xrek011,g_xrek2_d[g_detail_idx].xrek012,g_xrek2_d[g_detail_idx].xrek013, 
                  g_xrek2_d[g_detail_idx].xrek014,g_xrek2_d[g_detail_idx].xrek015,g_xrek2_d[g_detail_idx].xrek017, 
                  g_xrek2_d[g_detail_idx].xrek018,g_xrek2_d[g_detail_idx].xrek020,g_xrek2_d[g_detail_idx].xrek021, 
                  g_xrek2_d[g_detail_idx].xrek022,g_xrek2_d[g_detail_idx].xrek023,g_xrek2_d[g_detail_idx].xrek024, 
                  g_xrek2_d[g_detail_idx].xrek025,g_xrek2_d[g_detail_idx].xrek026,g_xrek2_d[g_detail_idx].xrek027, 
                  g_xrek2_d[g_detail_idx].xrek028,g_xrek2_d[g_detail_idx].xrek029,g_xrek2_d[g_detail_idx].xrek030, 
                  g_xrek2_d[g_detail_idx].xrek031,g_xrek2_d[g_detail_idx].xrek032) 
         WHERE xrekent = g_enterprise AND xrekdocno = ps_keys_bak[1] AND xrekseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrek_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrek_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt940_xrek_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aapt940.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aapt940_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt940.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aapt940_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt940.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt940_lock_b(ps_table,ps_page)
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
   #CALL aapt940_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "xrek_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aapt940_bcl USING g_enterprise,
                                       g_xrej_m.xrejdocno,g_xrek_d[g_detail_idx].xrekseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt940_bcl:",SQLERRMESSAGE 
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
 
{<section id="aapt940.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt940_unlock_b(ps_table,ps_page)
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
      CLOSE aapt940_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aapt940.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapt940_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xrejdocno,xrejld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xrejdocno",TRUE)
      CALL cl_set_comp_entry("xrejdocdt",TRUE)
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
 
{<section id="aapt940.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapt940_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xrejdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xrejdocno,xrejld",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("xrejdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt940.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt940_set_entry_b(p_cmd)
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
 
{<section id="aapt940.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt940_set_no_entry_b(p_cmd)
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
 
{<section id="aapt940.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapt940_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapt940_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_ld          LIKE glaa_t.glaald      #160225-00001#1
   DEFINE l_comp        LIKE glaa_t.glaacomp    #160225-00001#1
   DEFINE l_dfin0033    LIKE type_t.chr1        #160225-00001#1
   DEFINE l_slip        LIKE apca_t.apcadocno   #160225-00001#1
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
#   CALL cl_set_act_visible("insert,reproduce,modify", FALSE)
   IF g_xrej_m.xrejstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #160225-00001#1--(S)
   IF NOT cl_null(g_xrej_m.xrejdocno) THEN
      SELECT xrejld,xrejcomp INTO l_ld,l_comp
        FROM xrej_t
       WHERE xrejent = g_enterprise AND xrejdocno = g_xrej_m.xrejdocno
      CALL s_aooi200_fin_get_slip(g_xrej_m.xrejdocno) RETURNING g_sub_success,l_slip
      CALL s_fin_get_doc_para(l_ld,l_comp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      CALL s_fin_date_close_chk('@',l_comp,'AAP',g_xrej_m.xrejdocdt) RETURNING g_sub_success
      IF l_dfin0033 = "N" AND NOT g_sub_success THEN 
         CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
      END IF
   END IF
   #160225-00001#1--(E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aapt940_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aapt940_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
#   IF g_xrej_m.xrejstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
#      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
#   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt940_default_search()
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
      LET ls_wc = ls_wc, " xrejdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "xrej_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xrek_t" 
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
  ##避免查詢方案顯示--Belle 15/02/11
  #IF g_wc.getIndexOf(" 1=2", 1) THEN
  #   LET g_default = TRUE
  #END IF
  #LET g_wc = " xrej003 = 'AP' "
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt940.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aapt940_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xrej_m.xrejdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aapt940_cl USING g_enterprise,g_xrej_m.xrejdocno
   IF STATUS THEN
      CLOSE aapt940_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt940_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aapt940_master_referesh USING g_xrej_m.xrejdocno INTO g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004, 
       g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus, 
       g_xrej_m.xrejownid,g_xrej_m.xrejowndp,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdt, 
       g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid,g_xrej_m.xrejcnfdt,g_xrej_m.xrejownid_desc, 
       g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp_desc,g_xrej_m.xrejmodid_desc, 
       g_xrej_m.xrejcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aapt940_action_chk() THEN
      CLOSE aapt940_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrej_m.xrejsite,g_xrej_m.xrejsite_desc,g_xrej_m.xrejld,g_xrej_m.xrejld_desc,g_xrej_m.xrej004, 
       g_xrej_m.xrej004_desc,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002, 
       g_xrej_m.xrej005,g_xrej_m.xrejstus,g_xrej_m.xrejownid,g_xrej_m.xrejownid_desc,g_xrej_m.xrejowndp, 
       g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp,g_xrej_m.xrejcrtdp_desc, 
       g_xrej_m.xrejcrtdt,g_xrej_m.xrejmodid,g_xrej_m.xrejmodid_desc,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid, 
       g_xrej_m.xrejcnfid_desc,g_xrej_m.xrejcnfdt
 
   CASE g_xrej_m.xrejstus
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
         CASE g_xrej_m.xrejstus
            
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
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)
      CASE g_xrej_m.xrejstus
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
            CALL s_transaction_end('N','0')         #150401-00001#13
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
            IF NOT aapt940_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt940_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aapt940_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt940_cl
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
      g_xrej_m.xrejstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aapt940_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   IF lc_state = 'Y' THEN
      CALL cl_err_collect_init()
      #確認
      CALL s_aapt940_prepare_declare()
      #chk
      CALL s_aapt940_conf_chk(g_xrej_m.xrejdocno)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')        #150401-00001#13
         CALL cl_err_collect_show()
         RETURN                                 #150401-00001#13
      END IF
      #詢問
      IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
         CALL s_transaction_end('N','0')        #150401-00001#13
         CALL cl_err_collect_show()
         RETURN                                 #150401-00001#13
      ELSE
         CALL s_transaction_begin()
         CALL s_aapt940_conf_upd(g_xrej_m.xrejdocno) RETURNING g_sub_success
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
   
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      #取消確認
      #CALL s_aapt940_prepare_declare()
      #chk
      CALL s_aapt940_unconf_chk(g_xrej_m.xrejdocno)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')        #150401-00001#13
         CALL cl_err_collect_show()
         RETURN                                 #150401-00001#13
      END IF
      #詢問
      IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
         CALL s_transaction_end('N','0')        #150401-00001#13
         CALL cl_err_collect_show() 
         RETURN                                 #150401-00001#13
      ELSE
         CALL s_transaction_begin()
         CALL s_aapt940_unconf_upd(g_xrej_m.xrejdocno) RETURNING g_sub_success
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
   
   IF lc_state = 'X' THEN
      CALL cl_err_collect_init()
      #作廢
      #CALL s_aapt940_prepare_declare()
      #chk
      CALL s_aapt940_void_chk(g_xrej_m.xrejdocno)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')        #150401-00001#13
         CALL cl_err_collect_show()
         RETURN                                 #150401-00001#13
      END IF
      #詢問
      IF NOT cl_ask_confirm('aim-00109') THEN   #是否執作廢?
         CALL s_transaction_end('N','0')        #150401-00001#13
         CALL cl_err_collect_show()
         RETURN                                 #150401-00001#13
      ELSE
         CALL s_transaction_begin()
         CALL s_aapt940_void_upd(g_xrej_m.xrejdocno) RETURNING g_sub_success
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
   #end add-point
   
   LET g_xrej_m.xrejmodid = g_user
   LET g_xrej_m.xrejmoddt = cl_get_current()
   LET g_xrej_m.xrejstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xrej_t 
      SET (xrejstus,xrejmodid,xrejmoddt) 
        = (g_xrej_m.xrejstus,g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt)     
    WHERE xrejent = g_enterprise AND xrejdocno = g_xrej_m.xrejdocno
 
    
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
      EXECUTE aapt940_master_referesh USING g_xrej_m.xrejdocno INTO g_xrej_m.xrejsite,g_xrej_m.xrejld, 
          g_xrej_m.xrej004,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001,g_xrej_m.xrej002,g_xrej_m.xrej005, 
          g_xrej_m.xrejstus,g_xrej_m.xrejownid,g_xrej_m.xrejowndp,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtdp, 
          g_xrej_m.xrejcrtdt,g_xrej_m.xrejmodid,g_xrej_m.xrejmoddt,g_xrej_m.xrejcnfid,g_xrej_m.xrejcnfdt, 
          g_xrej_m.xrejownid_desc,g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp_desc, 
          g_xrej_m.xrejmodid_desc,g_xrej_m.xrejcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xrej_m.xrejsite,g_xrej_m.xrejsite_desc,g_xrej_m.xrejld,g_xrej_m.xrejld_desc, 
          g_xrej_m.xrej004,g_xrej_m.xrej004_desc,g_xrej_m.xrejdocno,g_xrej_m.xrejdocdt,g_xrej_m.xrej001, 
          g_xrej_m.xrej002,g_xrej_m.xrej005,g_xrej_m.xrejstus,g_xrej_m.xrejownid,g_xrej_m.xrejownid_desc, 
          g_xrej_m.xrejowndp,g_xrej_m.xrejowndp_desc,g_xrej_m.xrejcrtid,g_xrej_m.xrejcrtid_desc,g_xrej_m.xrejcrtdp, 
          g_xrej_m.xrejcrtdp_desc,g_xrej_m.xrejcrtdt,g_xrej_m.xrejmodid,g_xrej_m.xrejmodid_desc,g_xrej_m.xrejmoddt, 
          g_xrej_m.xrejcnfid,g_xrej_m.xrejcnfid_desc,g_xrej_m.xrejcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aapt940_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt940_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt940.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aapt940_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xrek_d.getLength() THEN
         LET g_detail_idx = g_xrek_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xrek_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrek_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xrek2_d.getLength() THEN
         LET g_detail_idx = g_xrek2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xrek2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrek2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapt940_b_fill2(pi_idx)
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
   
   CALL aapt940_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aapt940_fill_chk(ps_idx)
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
 
{<section id="aapt940.status_show" >}
PRIVATE FUNCTION aapt940_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapt940.mask_functions" >}
&include "erp/aap/aapt940_mask.4gl"
 
{</section>}
 
{<section id="aapt940.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aapt940_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aapt940_show()
   CALL aapt940_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_xrej_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_xrek_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_xrek2_d))
 
 
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
   #CALL aapt940_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aapt940_ui_headershow()
   CALL aapt940_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aapt940_draw_out()
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
   CALL aapt940_ui_headershow()  
   CALL aapt940_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aapt940.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt940_set_pk_array()
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
   LET g_pk_array[1].values = g_xrej_m.xrejdocno
   LET g_pk_array[1].column = 'xrejdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt940.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aapt940.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapt940_msgcentre_notify(lc_state)
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
   CALL aapt940_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xrej_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt940.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aapt940_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#2   2016/08/24  By 07900 --add--s--
   SELECT xrejstus INTO g_xrej_m.xrejstus
     FROM xrej_t
    WHERE xrejent = g_enterprise
      AND xrejdocno = g_xrej_m.xrejdocno
     
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_xrej_m.xrejstus
       
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
        LET g_errparam.extend =  g_xrej_m.xrejdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aapt940_set_act_visible()
        CALL aapt940_set_act_no_visible()
        CALL aapt940_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#2   2016/08/24  By 07900 --add--e--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt940.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 核算項預設
# Memo...........: 取傳入的聯集
# Date & Author..: 141104 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt940_glad_chk(p_glad001)
   #140818-00002#2 albireo 150316 modify-----s
   #DEFINE l_glad  RECORD LIKE glad_t.*
   DEFINE l_glad  RECORD
                  glad017    LIKE  glad_t.glad017, 
                  glad018    LIKE  glad_t.glad018,
                  glad019    LIKE  glad_t.glad019,
                  glad020    LIKE  glad_t.glad020,
                  glad021    LIKE  glad_t.glad021,
                  glad022    LIKE  glad_t.glad022,
                  glad023    LIKE  glad_t.glad023,
                  glad024    LIKE  glad_t.glad024,
                  glad025    LIKE  glad_t.glad025,
                  glad026    LIKE  glad_t.glad026,
                  glad0171   LIKE  glad_t.glad0171,
                  glad0172   LIKE  glad_t.glad0172,
                  glad0181   LIKE  glad_t.glad0181,
                  glad0182   LIKE  glad_t.glad0182,
                  glad0191   LIKE  glad_t.glad0191,
                  glad0192   LIKE  glad_t.glad0192,
                  glad0201   LIKE  glad_t.glad0201,
                  glad0202   LIKE  glad_t.glad0202,
                  glad0211   LIKE  glad_t.glad0211,
                  glad0212   LIKE  glad_t.glad0212,
                  glad0221   LIKE  glad_t.glad0221,
                  glad0222   LIKE  glad_t.glad0222,
                  glad0231   LIKE  glad_t.glad0231,
                  glad0232   LIKE  glad_t.glad0232,
                  glad0241   LIKE  glad_t.glad0241,
                  glad0242   LIKE  glad_t.glad0242,
                  glad0251   LIKE  glad_t.glad0251,
                  glad0252   LIKE  glad_t.glad0252,
                  glad0261   LIKE  glad_t.glad0261,                  
                  glad0262   LIKE  glad_t.glad0262
                  END RECORD
   #140818-00002#2 albireo 150316 modify-----e
   DEFINE p_glad001    LIKE glad_t.glad001
    
   INITIALIZE l_glad.* TO NULL 
   #140818-00002#2 albireo 150316 modify-----s
   #SELECT * INTO l_glad.* 
   SELECT glad017,glad018,glad019,glad020,glad021,
          glad022,glad023,glad024,glad025,glad026,
          glad0171,glad0172,glad0181,glad0182,
          glad0191,glad0192,glad0201,glad0202,
          glad0211,glad0212,glad0221,glad0222,
          glad0231,glad0232,glad0241,glad0242,
          glad0251,glad0252,glad0261,glad0262
     INTO l_glad.glad017,l_glad.glad018,l_glad.glad019,l_glad.glad020,l_glad.glad021,
          l_glad.glad022,l_glad.glad023,l_glad.glad024,l_glad.glad025,l_glad.glad026,
          l_glad.glad0171,l_glad.glad0172,l_glad.glad0181,l_glad.glad0182,
          l_glad.glad0191,l_glad.glad0192,l_glad.glad0201,l_glad.glad0202,
          l_glad.glad0211,l_glad.glad0212,l_glad.glad0221,l_glad.glad0222,
          l_glad.glad0231,l_glad.glad0232,l_glad.glad0241,l_glad.glad0242,
          l_glad.glad0251,l_glad.glad0252,l_glad.glad0261,l_glad.glad0262
     FROM glad_t
    WHERE gladent = g_enterprise
      AND gladld  = g_xrej_m.xrejld
      AND glad001 = p_glad001
   #140818-00002#2 albireo 150316 modify-----e

   IF l_glad.glad017 = 'Y' THEN LET g_glad.glad017 = 'Y' END IF
   IF l_glad.glad018 = 'Y' THEN LET g_glad.glad018 = 'Y' END IF
   IF l_glad.glad019 = 'Y' THEN LET g_glad.glad019 = 'Y' END IF
   IF l_glad.glad020 = 'Y' THEN LET g_glad.glad020 = 'Y' END IF 
   IF l_glad.glad021 = 'Y' THEN LET g_glad.glad021 = 'Y' END IF 
   IF l_glad.glad022 = 'Y' THEN LET g_glad.glad022 = 'Y' END IF 
   IF l_glad.glad023 = 'Y' THEN LET g_glad.glad023 = 'Y' END IF 
   IF l_glad.glad024 = 'Y' THEN LET g_glad.glad024 = 'Y' END IF 
   IF l_glad.glad025 = 'Y' THEN LET g_glad.glad025 = 'Y' END IF 
   IF l_glad.glad026 = 'Y' THEN LET g_glad.glad026 = 'Y' END IF 
   
   #140818-00002#2 albireo 150316 modify-----s
   #同個自由核算項顧問在輔導的時候會設定成同一個檢查方式跟檢查點
   #因此有取到就取用哪個設定
   IF cl_null(g_glad.glad0171)THEN LET g_glad.glad0171 = l_glad.glad0171 END IF
   IF cl_null(g_glad.glad0172)THEN LET g_glad.glad0172 = l_glad.glad0172 END IF
   IF cl_null(g_glad.glad0181)THEN LET g_glad.glad0181 = l_glad.glad0181 END IF 
   IF cl_null(g_glad.glad0182)THEN LET g_glad.glad0182 = l_glad.glad0182 END IF
   IF cl_null(g_glad.glad0191)THEN LET g_glad.glad0191 = l_glad.glad0191 END IF
   IF cl_null(g_glad.glad0192)THEN LET g_glad.glad0192 = l_glad.glad0192 END IF
   IF cl_null(g_glad.glad0201)THEN LET g_glad.glad0201 = l_glad.glad0201 END IF
   IF cl_null(g_glad.glad0202)THEN LET g_glad.glad0202 = l_glad.glad0202 END IF
   IF cl_null(g_glad.glad0211)THEN LET g_glad.glad0211 = l_glad.glad0211 END IF
   IF cl_null(g_glad.glad0212)THEN LET g_glad.glad0212 = l_glad.glad0212 END IF
   IF cl_null(g_glad.glad0221)THEN LET g_glad.glad0221 = l_glad.glad0221 END IF
   IF cl_null(g_glad.glad0222)THEN LET g_glad.glad0222 = l_glad.glad0222 END IF
   IF cl_null(g_glad.glad0231)THEN LET g_glad.glad0231 = l_glad.glad0231 END IF
   IF cl_null(g_glad.glad0232)THEN LET g_glad.glad0232 = l_glad.glad0232 END IF
   IF cl_null(g_glad.glad0241)THEN LET g_glad.glad0241 = l_glad.glad0241 END IF
   IF cl_null(g_glad.glad0242)THEN LET g_glad.glad0242 = l_glad.glad0242 END IF
   IF cl_null(g_glad.glad0251)THEN LET g_glad.glad0251 = l_glad.glad0251 END IF
   IF cl_null(g_glad.glad0252)THEN LET g_glad.glad0252 = l_glad.glad0252 END IF
   IF cl_null(g_glad.glad0261)THEN LET g_glad.glad0261 = l_glad.glad0261 END IF
   IF cl_null(g_glad.glad0262)THEN LET g_glad.glad0262 = l_glad.glad0262 END IF
   #140818-00002#2 albireo 150316 modify-----e

   #RETURN l_glad.*   140818-00002#2 albireo 150316 mark
END FUNCTION
################################################################################
# Descriptions...: 單據串查
# Memo...........:
# Date & Author..: 15/05/26 By rayhuang
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt940_qrystr(p_xrejld,p_xrek005)
   DEFINE p_xrejld      LIKE xrej_t.xrejld
   DEFINE p_xrek005     LIKE xrek_t.xrek005     #DOCNO
   DEFINE la_param      RECORD
          prog          STRING,
          actionid      STRING,
          background    LIKE type_t.chr1,
          param         DYNAMIC ARRAY OF STRING
                        END RECORD
   DEFINE ls_js         STRING
   DEFINE l_sql         STRING
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_j           LIKE type_t.num5

   IF cl_null(p_xrejld) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'sub-00280'
      LET g_errparam.extend = s_fin_get_colname(g_prog,'xrejld')
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   IF cl_null(p_xrek005) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'sub-00280'
      LET g_errparam.extend = s_fin_get_colname(g_prog,'xrek005')
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   INITIALIZE la_param.* TO NULL
   CALL s_aapt300_get_aapt3xx_prog(p_xrejld,p_xrek005)RETURNING la_param.prog,l_i,l_j
   LET la_param.param[l_i] = p_xrejld
   LET la_param.param[l_j] = p_xrek005
   LET ls_js = util.JSON.stringify(la_param)
   CALL cl_cmdrun_wait(ls_js)
END FUNCTION

 
{</section>}
 
